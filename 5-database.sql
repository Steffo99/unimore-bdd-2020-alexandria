--
-- PostgreSQL database dump
--

-- Dumped from database version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 11.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: film_provenienza; Type: TYPE; Schema: public; Owner: cookie
--

CREATE TYPE public.film_provenienza AS ENUM (
    'ACQUISTATO_FISICO',
    'VISTO_AL_CINEMA',
    'VISTO_IN_TV',
    'VISTO_IN_STREAMING',
    'PRESTITO',
    'NON_PIU_POSSEDUTO',
    'ALTRO'
);


ALTER TYPE public.film_provenienza OWNER TO cookie;

--
-- Name: film_stato; Type: TYPE; Schema: public; Owner: cookie
--

CREATE TYPE public.film_stato AS ENUM (
    'DA_VEDERE',
    'VISTO'
);


ALTER TYPE public.film_stato OWNER TO cookie;

--
-- Name: gioco_provenienza; Type: TYPE; Schema: public; Owner: cookie
--

CREATE TYPE public.gioco_provenienza AS ENUM (
    'GRATUITO',
    'ACQUISTATO',
    'IN_ABBONAMENTO',
    'PRESO_IN_PRESTITO',
    'NON_PIU_POSSEDUTO',
    'ALTRO'
);


ALTER TYPE public.gioco_provenienza OWNER TO cookie;

--
-- Name: gioco_stato; Type: TYPE; Schema: public; Owner: cookie
--

CREATE TYPE public.gioco_stato AS ENUM (
    'DA_INIZIARE',
    'INIZIATO',
    'FINITO',
    'COMPLETATO',
    'NON_APPLICABILE'
);


ALTER TYPE public.gioco_stato OWNER TO cookie;

--
-- Name: libro_provenienza; Type: TYPE; Schema: public; Owner: cookie
--

CREATE TYPE public.libro_provenienza AS ENUM (
    'ACQUISTATO_FISICO',
    'ACQUISTATO_DIGITALE',
    'PRESTITO',
    'NON_PIU_POSSEDUTO',
    'ALTRO'
);


ALTER TYPE public.libro_provenienza OWNER TO cookie;

--
-- Name: libro_stato; Type: TYPE; Schema: public; Owner: cookie
--

CREATE TYPE public.libro_stato AS ENUM (
    'DA_INIZIARE',
    'INIZIATO',
    'FINITO',
    'ABBANDONATO',
    'NON_APPLICABILE'
);


ALTER TYPE public.libro_stato OWNER TO cookie;

--
-- Name: adegua_isbn(); Type: FUNCTION; Schema: public; Owner: cookie
--

CREATE FUNCTION public.adegua_isbn() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE
	isbn VARCHAR;
BEGIN
	if NEW.isbn LIKE '%x' then
		new.isbn:= CONCAT(substring(new.isbn, 1, 12),'X');
	end if;
	return new;
END$$;


ALTER FUNCTION public.adegua_isbn() OWNER TO cookie;

--
-- Name: is_numeric(character varying); Type: FUNCTION; Schema: public; Owner: cookie
--

CREATE FUNCTION public.is_numeric(text character varying) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$DECLARE x NUMERIC;
BEGIN
    x = $1::NUMERIC;
    RETURN TRUE;
EXCEPTION WHEN others THEN
    RETURN FALSE;
END;$_$;


ALTER FUNCTION public.is_numeric(text character varying) OWNER TO cookie;

--
-- Name: update_n_audiolibri(); Type: FUNCTION; Schema: public; Owner: cookie
--

CREATE FUNCTION public.update_n_audiolibri() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	 UPDATE utente
		SET new.audiolibro_elementi_posseduti = old.audiolibro_elementi_posseduti + 1
		WHERE utente.id = new.audiolibro_elemento.appartiene_a;
END;$$;


ALTER FUNCTION public.update_n_audiolibri() OWNER TO cookie;

--
-- Name: update_n_film(); Type: FUNCTION; Schema: public; Owner: cookie
--

CREATE FUNCTION public.update_n_film() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	 UPDATE utente
		SET new.film_elementi_posseduti = old.film_elementi_posseduti + 1
		WHERE utente.id = new.film_elemento.appartiene_a;
END;$$;


ALTER FUNCTION public.update_n_film() OWNER TO cookie;

--
-- Name: update_n_giochi(); Type: FUNCTION; Schema: public; Owner: cookie
--

CREATE FUNCTION public.update_n_giochi() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	 UPDATE utente
		SET new.gioco_elementi_posseduti = old.gioco_elementi_posseduti + 1
		WHERE utente.id = new.gioco_elemento.appartiene_a;
END;$$;


ALTER FUNCTION public.update_n_giochi() OWNER TO cookie;

--
-- Name: update_n_libri(); Type: FUNCTION; Schema: public; Owner: cookie
--

CREATE FUNCTION public.update_n_libri() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	 UPDATE utente
		SET new.libro_elementi_posseduti = old.libro_elementi_posseduti + 1
		WHERE utente.id = new.libro_elemento.appartiene_a;
END;$$;


ALTER FUNCTION public.update_n_libri() OWNER TO cookie;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: audiolibro_edizione; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.audiolibro_edizione (
    isbn integer NOT NULL,
    titolo character varying NOT NULL,
    durata interval,
    immagine bytea,
    relativa_a integer NOT NULL
);


ALTER TABLE public.audiolibro_edizione OWNER TO cookie;

--
-- Name: elemento_id_seq; Type: SEQUENCE; Schema: public; Owner: cookie
--

CREATE SEQUENCE public.elemento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.elemento_id_seq OWNER TO cookie;

--
-- Name: audiolibro_elemento; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.audiolibro_elemento (
    id bigint DEFAULT nextval('public.elemento_id_seq'::regclass) NOT NULL,
    istanza_di integer NOT NULL,
    stato public.libro_stato,
    provenienza public.libro_provenienza,
    appartiene_a character varying NOT NULL
);


ALTER TABLE public.audiolibro_elemento OWNER TO cookie;

--
-- Name: audiolibro_narrata_da; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.audiolibro_narrata_da (
    id_edizione integer NOT NULL,
    id_narratore integer NOT NULL
);


ALTER TABLE public.audiolibro_narrata_da OWNER TO cookie;

--
-- Name: audiolibro_narratore_id_seq; Type: SEQUENCE; Schema: public; Owner: cookie
--

CREATE SEQUENCE public.audiolibro_narratore_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.audiolibro_narratore_id_seq OWNER TO cookie;

--
-- Name: audiolibro_narratore; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.audiolibro_narratore (
    id integer DEFAULT nextval('public.audiolibro_narratore_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL
);


ALTER TABLE public.audiolibro_narratore OWNER TO cookie;

--
-- Name: audiolibro_recensione; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.audiolibro_recensione (
    id bigint NOT NULL,
    commento text NOT NULL,
    valutazione smallint NOT NULL,
    data timestamp without time zone NOT NULL,
    CONSTRAINT audiolibro_recensione_valutazione_check CHECK (((valutazione >= 0) AND (valutazione <= 100)))
);


ALTER TABLE public.audiolibro_recensione OWNER TO cookie;

--
-- Name: film; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.film (
    eidr character(34) NOT NULL,
    titolo character varying NOT NULL,
    sinossi text,
    locandina bytea,
    durata integer,
    CONSTRAINT film_durata_check CHECK ((durata >= 0))
);


ALTER TABLE public.film OWNER TO cookie;

--
-- Name: COLUMN film.eidr; Type: COMMENT; Schema: public; Owner: cookie
--

COMMENT ON COLUMN public.film.eidr IS 'Gli EIDR sono tutti di 34 caratteri.

http://eidr.org/documents/EIDR_ID_Format_v1.1.pdf';


--
-- Name: film_appartenenza_a_genere; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.film_appartenenza_a_genere (
    id_genere integer NOT NULL,
    eidr character(34) NOT NULL
);


ALTER TABLE public.film_appartenenza_a_genere OWNER TO cookie;

--
-- Name: film_cast_id_seq; Type: SEQUENCE; Schema: public; Owner: cookie
--

CREATE SEQUENCE public.film_cast_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.film_cast_id_seq OWNER TO cookie;

--
-- Name: film_cast; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.film_cast (
    id integer DEFAULT nextval('public.film_cast_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL
);


ALTER TABLE public.film_cast OWNER TO cookie;

--
-- Name: film_correlazioni; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.film_correlazioni (
    eidr_1 character(34) NOT NULL,
    eidr_2 character(34) NOT NULL
);


ALTER TABLE public.film_correlazioni OWNER TO cookie;

--
-- Name: film_elemento; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.film_elemento (
    id bigint DEFAULT nextval('public.elemento_id_seq'::regclass) NOT NULL,
    stato public.film_stato,
    provenienza public.film_provenienza,
    istanza_di character(34) NOT NULL,
    appartiene_a character varying NOT NULL
);


ALTER TABLE public.film_elemento OWNER TO cookie;

--
-- Name: film_genere_id_seq; Type: SEQUENCE; Schema: public; Owner: cookie
--

CREATE SEQUENCE public.film_genere_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.film_genere_id_seq OWNER TO cookie;

--
-- Name: film_genere; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.film_genere (
    id integer DEFAULT nextval('public.film_genere_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL
);


ALTER TABLE public.film_genere OWNER TO cookie;

--
-- Name: film_localizzazione; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.film_localizzazione (
    lingua character(4) NOT NULL,
    eidr character(34) NOT NULL,
    titolo_localizzato character varying NOT NULL
);


ALTER TABLE public.film_localizzazione OWNER TO cookie;

--
-- Name: film_prodotto_da; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.film_prodotto_da (
    id_studio integer NOT NULL,
    eidr character(34) NOT NULL
);


ALTER TABLE public.film_prodotto_da OWNER TO cookie;

--
-- Name: film_recensione; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.film_recensione (
    id bigint NOT NULL,
    commento text NOT NULL,
    data timestamp without time zone NOT NULL,
    valutazione smallint NOT NULL,
    CONSTRAINT film_recensione_valutazione_check CHECK (((valutazione >= 0) AND (valutazione <= 100)))
);


ALTER TABLE public.film_recensione OWNER TO cookie;

--
-- Name: film_ruolo_id_seq; Type: SEQUENCE; Schema: public; Owner: cookie
--

CREATE SEQUENCE public.film_ruolo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.film_ruolo_id_seq OWNER TO cookie;

--
-- Name: film_ruolo; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.film_ruolo (
    id integer DEFAULT nextval('public.film_ruolo_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL
);


ALTER TABLE public.film_ruolo OWNER TO cookie;

--
-- Name: film_studio_id_seq; Type: SEQUENCE; Schema: public; Owner: cookie
--

CREATE SEQUENCE public.film_studio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.film_studio_id_seq OWNER TO cookie;

--
-- Name: film_studio; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.film_studio (
    id integer DEFAULT nextval('public.film_studio_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL
);


ALTER TABLE public.film_studio OWNER TO cookie;

--
-- Name: film_vi_ha_preso_parte; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.film_vi_ha_preso_parte (
    eidr character(34) NOT NULL,
    id_cast integer NOT NULL,
    id_ruolo integer NOT NULL
);


ALTER TABLE public.film_vi_ha_preso_parte OWNER TO cookie;

--
-- Name: gioco; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.gioco (
    id integer NOT NULL,
    nome character varying NOT NULL,
    descrizione text
);


ALTER TABLE public.gioco OWNER TO cookie;

--
-- Name: gioco_appartenenza_a_genere; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.gioco_appartenenza_a_genere (
    id_gioco integer NOT NULL,
    id_genere integer NOT NULL
);


ALTER TABLE public.gioco_appartenenza_a_genere OWNER TO cookie;

--
-- Name: gioco_correlazioni; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.gioco_correlazioni (
    id_1 integer NOT NULL,
    id_2 integer NOT NULL
);


ALTER TABLE public.gioco_correlazioni OWNER TO cookie;

--
-- Name: gioco_edizione; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.gioco_edizione (
    id integer NOT NULL,
    titolo_alternativo character varying,
    piattaforma character varying NOT NULL,
    box_art bytea,
    relativa_a integer NOT NULL
);


ALTER TABLE public.gioco_edizione OWNER TO cookie;

--
-- Name: gioco_elemento; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.gioco_elemento (
    id bigint DEFAULT nextval('public.elemento_id_seq'::regclass) NOT NULL,
    stato public.gioco_stato,
    provenienza public.gioco_provenienza,
    istanza_di integer NOT NULL,
    appartiene_a character varying NOT NULL
);


ALTER TABLE public.gioco_elemento OWNER TO cookie;

--
-- Name: gioco_genere_id_seq; Type: SEQUENCE; Schema: public; Owner: cookie
--

CREATE SEQUENCE public.gioco_genere_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gioco_genere_id_seq OWNER TO cookie;

--
-- Name: gioco_genere; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.gioco_genere (
    id integer DEFAULT nextval('public.gioco_genere_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL
);


ALTER TABLE public.gioco_genere OWNER TO cookie;

--
-- Name: gioco_portato_da; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.gioco_portato_da (
    id_edizione integer NOT NULL,
    id_studio integer NOT NULL
);


ALTER TABLE public.gioco_portato_da OWNER TO cookie;

--
-- Name: gioco_prodotto_da; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.gioco_prodotto_da (
    id_gioco integer NOT NULL,
    id_studio integer NOT NULL
);


ALTER TABLE public.gioco_prodotto_da OWNER TO cookie;

--
-- Name: gioco_recensione; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.gioco_recensione (
    id bigint NOT NULL,
    commento text NOT NULL,
    data timestamp without time zone NOT NULL,
    valutazione smallint NOT NULL,
    CONSTRAINT gioco_recensione_valutazione_check CHECK (((valutazione >= 0) AND (valutazione <= 100)))
);


ALTER TABLE public.gioco_recensione OWNER TO cookie;

--
-- Name: gioco_studio_id_seq; Type: SEQUENCE; Schema: public; Owner: cookie
--

CREATE SEQUENCE public.gioco_studio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gioco_studio_id_seq OWNER TO cookie;

--
-- Name: gioco_studio; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.gioco_studio (
    id integer DEFAULT nextval('public.gioco_studio_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL
);


ALTER TABLE public.gioco_studio OWNER TO cookie;

--
-- Name: gioco_sviluppato_da; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.gioco_sviluppato_da (
    id_gioco integer NOT NULL,
    id_studio integer NOT NULL
);


ALTER TABLE public.gioco_sviluppato_da OWNER TO cookie;

--
-- Name: libro_id_seq; Type: SEQUENCE; Schema: public; Owner: cookie
--

CREATE SEQUENCE public.libro_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.libro_id_seq OWNER TO cookie;

--
-- Name: libro; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.libro (
    id integer DEFAULT nextval('public.libro_id_seq'::regclass) NOT NULL,
    titolo_primario character varying NOT NULL,
    sinossi text
);


ALTER TABLE public.libro OWNER TO cookie;

--
-- Name: libro_appartenenza_a_genere; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.libro_appartenenza_a_genere (
    id_genere integer NOT NULL,
    id_libro integer NOT NULL
);


ALTER TABLE public.libro_appartenenza_a_genere OWNER TO cookie;

--
-- Name: libro_autore_id_seq; Type: SEQUENCE; Schema: public; Owner: cookie
--

CREATE SEQUENCE public.libro_autore_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.libro_autore_id_seq OWNER TO cookie;

--
-- Name: libro_autore; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.libro_autore (
    id integer DEFAULT nextval('public.libro_autore_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL
);


ALTER TABLE public.libro_autore OWNER TO cookie;

--
-- Name: libro_correlazioni; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.libro_correlazioni (
    id_1 integer NOT NULL,
    id_2 integer NOT NULL
);


ALTER TABLE public.libro_correlazioni OWNER TO cookie;

--
-- Name: libro_editore; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.libro_editore (
    parte_isbn character(5) NOT NULL,
    nome character varying NOT NULL
);


ALTER TABLE public.libro_editore OWNER TO cookie;

--
-- Name: COLUMN libro_editore.parte_isbn; Type: COMMENT; Schema: public; Owner: cookie
--

COMMENT ON COLUMN public.libro_editore.parte_isbn IS 'Gli editori hanno un prefisso ISBN univoco di 5 cifre.

https://www.isbn.it/CODICEISBN.aspx';


--
-- Name: libro_edizione; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.libro_edizione (
    isbn character(13) NOT NULL,
    titolo_edizione character varying NOT NULL,
    pagine integer,
    copertina bytea,
    relativa_a integer,
    CONSTRAINT libro_edizione_pagine_check CHECK ((pagine >= 0))
);


ALTER TABLE public.libro_edizione OWNER TO cookie;

--
-- Name: COLUMN libro_edizione.isbn; Type: COMMENT; Schema: public; Owner: cookie
--

COMMENT ON COLUMN public.libro_edizione.isbn IS 'L''ISBN ha sempre 13 cifre.

https://www.isbn.it/CODICEISBN.aspx';


--
-- Name: libro_elemento; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.libro_elemento (
    id bigint DEFAULT nextval('public.elemento_id_seq'::regclass) NOT NULL,
    istanza_di character(13) NOT NULL,
    stato public.libro_stato,
    provenienza public.libro_provenienza,
    appartiene_a character varying NOT NULL
);


ALTER TABLE public.libro_elemento OWNER TO cookie;

--
-- Name: libro_genere_id_seq; Type: SEQUENCE; Schema: public; Owner: cookie
--

CREATE SEQUENCE public.libro_genere_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.libro_genere_id_seq OWNER TO cookie;

--
-- Name: libro_genere; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.libro_genere (
    id integer DEFAULT nextval('public.libro_genere_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL
);


ALTER TABLE public.libro_genere OWNER TO cookie;

--
-- Name: libro_recensione; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.libro_recensione (
    id bigint NOT NULL,
    commento text NOT NULL,
    data timestamp without time zone NOT NULL,
    valutazione integer NOT NULL,
    CONSTRAINT libro_recensione_valutazione_check CHECK (((valutazione >= 0) AND (valutazione <= 100)))
);


ALTER TABLE public.libro_recensione OWNER TO cookie;

--
-- Name: libro_scritto_da; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.libro_scritto_da (
    id_libro integer NOT NULL,
    id_autore integer NOT NULL
);


ALTER TABLE public.libro_scritto_da OWNER TO cookie;

--
-- Name: utente; Type: TABLE; Schema: public; Owner: cookie
--

CREATE TABLE public.utente (
    username character varying NOT NULL,
    password bytea NOT NULL,
    email character varying,
    is_admin boolean DEFAULT false NOT NULL,
    is_banned boolean DEFAULT false NOT NULL,
    libro_elementi_posseduti integer DEFAULT 0 NOT NULL,
    audiolibro_elementi_posseduti integer DEFAULT 0 NOT NULL,
    film_elementi_posseduti integer DEFAULT 0 NOT NULL,
    gioco_elementi_posseduti integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.utente OWNER TO cookie;

--
-- Data for Name: audiolibro_edizione; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.audiolibro_edizione (isbn, titolo, durata, immagine, relativa_a) FROM stdin;
\.


--
-- Data for Name: audiolibro_elemento; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.audiolibro_elemento (id, istanza_di, stato, provenienza, appartiene_a) FROM stdin;
\.


--
-- Data for Name: audiolibro_narrata_da; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.audiolibro_narrata_da (id_edizione, id_narratore) FROM stdin;
\.


--
-- Data for Name: audiolibro_narratore; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.audiolibro_narratore (id, nome) FROM stdin;
\.


--
-- Data for Name: audiolibro_recensione; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.audiolibro_recensione (id, commento, valutazione, data) FROM stdin;
\.


--
-- Data for Name: film; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.film (eidr, titolo, sinossi, locandina, durata) FROM stdin;
\.


--
-- Data for Name: film_appartenenza_a_genere; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.film_appartenenza_a_genere (id_genere, eidr) FROM stdin;
\.


--
-- Data for Name: film_cast; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.film_cast (id, nome) FROM stdin;
\.


--
-- Data for Name: film_correlazioni; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.film_correlazioni (eidr_1, eidr_2) FROM stdin;
\.


--
-- Data for Name: film_elemento; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.film_elemento (id, stato, provenienza, istanza_di, appartiene_a) FROM stdin;
\.


--
-- Data for Name: film_genere; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.film_genere (id, nome) FROM stdin;
\.


--
-- Data for Name: film_localizzazione; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.film_localizzazione (lingua, eidr, titolo_localizzato) FROM stdin;
\.


--
-- Data for Name: film_prodotto_da; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.film_prodotto_da (id_studio, eidr) FROM stdin;
\.


--
-- Data for Name: film_recensione; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.film_recensione (id, commento, data, valutazione) FROM stdin;
\.


--
-- Data for Name: film_ruolo; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.film_ruolo (id, nome) FROM stdin;
\.


--
-- Data for Name: film_studio; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.film_studio (id, nome) FROM stdin;
\.


--
-- Data for Name: film_vi_ha_preso_parte; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.film_vi_ha_preso_parte (eidr, id_cast, id_ruolo) FROM stdin;
\.


--
-- Data for Name: gioco; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.gioco (id, nome, descrizione) FROM stdin;
\.


--
-- Data for Name: gioco_appartenenza_a_genere; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.gioco_appartenenza_a_genere (id_gioco, id_genere) FROM stdin;
\.


--
-- Data for Name: gioco_correlazioni; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.gioco_correlazioni (id_1, id_2) FROM stdin;
\.


--
-- Data for Name: gioco_edizione; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.gioco_edizione (id, titolo_alternativo, piattaforma, box_art, relativa_a) FROM stdin;
\.


--
-- Data for Name: gioco_elemento; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.gioco_elemento (id, stato, provenienza, istanza_di, appartiene_a) FROM stdin;
\.


--
-- Data for Name: gioco_genere; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.gioco_genere (id, nome) FROM stdin;
\.


--
-- Data for Name: gioco_portato_da; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.gioco_portato_da (id_edizione, id_studio) FROM stdin;
\.


--
-- Data for Name: gioco_prodotto_da; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.gioco_prodotto_da (id_gioco, id_studio) FROM stdin;
\.


--
-- Data for Name: gioco_recensione; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.gioco_recensione (id, commento, data, valutazione) FROM stdin;
\.


--
-- Data for Name: gioco_studio; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.gioco_studio (id, nome) FROM stdin;
\.


--
-- Data for Name: gioco_sviluppato_da; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.gioco_sviluppato_da (id_gioco, id_studio) FROM stdin;
\.


--
-- Data for Name: libro; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.libro (id, titolo_primario, sinossi) FROM stdin;
\.


--
-- Data for Name: libro_appartenenza_a_genere; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.libro_appartenenza_a_genere (id_genere, id_libro) FROM stdin;
\.


--
-- Data for Name: libro_autore; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.libro_autore (id, nome) FROM stdin;
\.


--
-- Data for Name: libro_correlazioni; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.libro_correlazioni (id_1, id_2) FROM stdin;
\.


--
-- Data for Name: libro_editore; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.libro_editore (parte_isbn, nome) FROM stdin;
\.


--
-- Data for Name: libro_edizione; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.libro_edizione (isbn, titolo_edizione, pagine, copertina, relativa_a) FROM stdin;
\.


--
-- Data for Name: libro_elemento; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.libro_elemento (id, istanza_di, stato, provenienza, appartiene_a) FROM stdin;
\.


--
-- Data for Name: libro_genere; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.libro_genere (id, nome) FROM stdin;
\.


--
-- Data for Name: libro_recensione; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.libro_recensione (id, commento, data, valutazione) FROM stdin;
\.


--
-- Data for Name: libro_scritto_da; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.libro_scritto_da (id_libro, id_autore) FROM stdin;
\.


--
-- Data for Name: utente; Type: TABLE DATA; Schema: public; Owner: cookie
--

COPY public.utente (username, password, email, is_admin, is_banned, libro_elementi_posseduti, audiolibro_elementi_posseduti, film_elementi_posseduti, gioco_elementi_posseduti) FROM stdin;
\.


--
-- Name: audiolibro_narratore_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cookie
--

SELECT pg_catalog.setval('public.audiolibro_narratore_id_seq', 1, false);


--
-- Name: elemento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cookie
--

SELECT pg_catalog.setval('public.elemento_id_seq', 1, false);


--
-- Name: film_cast_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cookie
--

SELECT pg_catalog.setval('public.film_cast_id_seq', 1, false);


--
-- Name: film_genere_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cookie
--

SELECT pg_catalog.setval('public.film_genere_id_seq', 1, false);


--
-- Name: film_ruolo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cookie
--

SELECT pg_catalog.setval('public.film_ruolo_id_seq', 1, false);


--
-- Name: film_studio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cookie
--

SELECT pg_catalog.setval('public.film_studio_id_seq', 1, false);


--
-- Name: gioco_genere_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cookie
--

SELECT pg_catalog.setval('public.gioco_genere_id_seq', 1, false);


--
-- Name: gioco_studio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cookie
--

SELECT pg_catalog.setval('public.gioco_studio_id_seq', 1, false);


--
-- Name: libro_autore_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cookie
--

SELECT pg_catalog.setval('public.libro_autore_id_seq', 1, false);


--
-- Name: libro_genere_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cookie
--

SELECT pg_catalog.setval('public.libro_genere_id_seq', 1, false);


--
-- Name: libro_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cookie
--

SELECT pg_catalog.setval('public.libro_id_seq', 1, false);


--
-- Name: libro_edizione Edizione(libro)_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_edizione
    ADD CONSTRAINT "Edizione(libro)_pkey" PRIMARY KEY (isbn);


--
-- Name: audiolibro_edizione audiolibro_edizione_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.audiolibro_edizione
    ADD CONSTRAINT audiolibro_edizione_pkey PRIMARY KEY (isbn);


--
-- Name: audiolibro_elemento audiolibro_elemento_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.audiolibro_elemento
    ADD CONSTRAINT audiolibro_elemento_pkey PRIMARY KEY (id);


--
-- Name: audiolibro_narrata_da audiolibro_narrata_da_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.audiolibro_narrata_da
    ADD CONSTRAINT audiolibro_narrata_da_pkey PRIMARY KEY (id_edizione, id_narratore);


--
-- Name: audiolibro_narratore audiolibro_narratore_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.audiolibro_narratore
    ADD CONSTRAINT audiolibro_narratore_pkey PRIMARY KEY (id);


--
-- Name: audiolibro_recensione audiolibro_recensione_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.audiolibro_recensione
    ADD CONSTRAINT audiolibro_recensione_pkey PRIMARY KEY (id);


--
-- Name: libro_correlazioni correlazioni_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_correlazioni
    ADD CONSTRAINT correlazioni_pkey PRIMARY KEY (id_1, id_2);


--
-- Name: film_appartenenza_a_genere film_appartenenza_a_genere_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_appartenenza_a_genere
    ADD CONSTRAINT film_appartenenza_a_genere_pkey PRIMARY KEY (id_genere, eidr);


--
-- Name: film_cast film_cast_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_cast
    ADD CONSTRAINT film_cast_pkey PRIMARY KEY (id);


--
-- Name: film_correlazioni film_correlazioni_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_correlazioni
    ADD CONSTRAINT film_correlazioni_pkey PRIMARY KEY (eidr_1, eidr_2);


--
-- Name: film_elemento film_elemento_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_elemento
    ADD CONSTRAINT film_elemento_pkey PRIMARY KEY (id);


--
-- Name: film_genere film_genere_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_genere
    ADD CONSTRAINT film_genere_pkey PRIMARY KEY (id);


--
-- Name: film_localizzazione film_localizzazione_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_localizzazione
    ADD CONSTRAINT film_localizzazione_pkey PRIMARY KEY (eidr, lingua);


--
-- Name: film film_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film
    ADD CONSTRAINT film_pkey PRIMARY KEY (eidr);


--
-- Name: film_prodotto_da film_prodotto_da_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_prodotto_da
    ADD CONSTRAINT film_prodotto_da_pkey PRIMARY KEY (id_studio, eidr);


--
-- Name: film_recensione film_recensione_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_recensione
    ADD CONSTRAINT film_recensione_pkey PRIMARY KEY (id);


--
-- Name: film_studio film_studio_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_studio
    ADD CONSTRAINT film_studio_pkey PRIMARY KEY (id);


--
-- Name: film_vi_ha_preso_parte film_vi_ha_preso_parte_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_vi_ha_preso_parte
    ADD CONSTRAINT film_vi_ha_preso_parte_pkey PRIMARY KEY (eidr, id_cast, id_ruolo);


--
-- Name: gioco_appartenenza_a_genere gioco_appartenenza_a_genere_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_appartenenza_a_genere
    ADD CONSTRAINT gioco_appartenenza_a_genere_pkey PRIMARY KEY (id_gioco, id_genere);


--
-- Name: gioco_correlazioni gioco_correlazioni_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_correlazioni
    ADD CONSTRAINT gioco_correlazioni_pkey PRIMARY KEY (id_1, id_2);


--
-- Name: gioco_edizione gioco_edizione_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_edizione
    ADD CONSTRAINT gioco_edizione_pkey PRIMARY KEY (id);


--
-- Name: gioco_elemento gioco_elemento_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_elemento
    ADD CONSTRAINT gioco_elemento_pkey PRIMARY KEY (id);


--
-- Name: gioco_genere gioco_genere_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_genere
    ADD CONSTRAINT gioco_genere_pkey PRIMARY KEY (id);


--
-- Name: gioco gioco_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco
    ADD CONSTRAINT gioco_pkey PRIMARY KEY (id);


--
-- Name: gioco_portato_da gioco_portato_da_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_portato_da
    ADD CONSTRAINT gioco_portato_da_pkey PRIMARY KEY (id_edizione, id_studio);


--
-- Name: gioco_prodotto_da gioco_prodotto_da_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_prodotto_da
    ADD CONSTRAINT gioco_prodotto_da_pkey PRIMARY KEY (id_gioco, id_studio);


--
-- Name: gioco_recensione gioco_recensione_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_recensione
    ADD CONSTRAINT gioco_recensione_pkey PRIMARY KEY (id);


--
-- Name: gioco_studio gioco_studio_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_studio
    ADD CONSTRAINT gioco_studio_pkey PRIMARY KEY (id);


--
-- Name: gioco_sviluppato_da gioco_sviluppato_da_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_sviluppato_da
    ADD CONSTRAINT gioco_sviluppato_da_pkey PRIMARY KEY (id_gioco, id_studio);


--
-- Name: libro_appartenenza_a_genere libro_appartenenza_a_genere_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_appartenenza_a_genere
    ADD CONSTRAINT libro_appartenenza_a_genere_pkey PRIMARY KEY (id_genere, id_libro);


--
-- Name: libro_autore libro_autore_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_autore
    ADD CONSTRAINT libro_autore_pkey PRIMARY KEY (id);


--
-- Name: libro_editore libro_editore_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_editore
    ADD CONSTRAINT libro_editore_pkey PRIMARY KEY (parte_isbn);


--
-- Name: libro_edizione libro_edizione_isbn_check; Type: CHECK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE public.libro_edizione
    ADD CONSTRAINT libro_edizione_isbn_check CHECK ((public.is_numeric(("substring"((isbn)::text, 1, 12))::character varying) AND (public.is_numeric(("right"((isbn)::text, 1))::character varying) OR ("right"((isbn)::text, 1) ~~ '%X'::text)))) NOT VALID;


--
-- Name: libro_elemento libro_elemento_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_elemento
    ADD CONSTRAINT libro_elemento_pkey PRIMARY KEY (id);


--
-- Name: libro_genere libro_genere_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_genere
    ADD CONSTRAINT libro_genere_pkey PRIMARY KEY (id);


--
-- Name: libro libro_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro
    ADD CONSTRAINT libro_pkey PRIMARY KEY (id);


--
-- Name: libro_recensione libro_recensione_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_recensione
    ADD CONSTRAINT libro_recensione_pkey PRIMARY KEY (id);


--
-- Name: libro_scritto_da libro_scritto_da_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_scritto_da
    ADD CONSTRAINT libro_scritto_da_pkey PRIMARY KEY (id_libro, id_autore);


--
-- Name: film_ruolo ruolo_pkey; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_ruolo
    ADD CONSTRAINT ruolo_pkey PRIMARY KEY (id);


--
-- Name: utente username; Type: CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.utente
    ADD CONSTRAINT username PRIMARY KEY (username);


--
-- Name: film_correlazioni EIDR_1; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_correlazioni
    ADD CONSTRAINT "EIDR_1" FOREIGN KEY (eidr_1) REFERENCES public.film(eidr);


--
-- Name: film_correlazioni EIDR_2; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_correlazioni
    ADD CONSTRAINT "EIDR_2" FOREIGN KEY (eidr_2) REFERENCES public.film(eidr);


--
-- Name: libro_elemento appartiene_a; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_elemento
    ADD CONSTRAINT appartiene_a FOREIGN KEY (appartiene_a) REFERENCES public.utente(username);


--
-- Name: audiolibro_elemento appartiene_a; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.audiolibro_elemento
    ADD CONSTRAINT appartiene_a FOREIGN KEY (appartiene_a) REFERENCES public.utente(username);


--
-- Name: film_elemento appartiene_a; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_elemento
    ADD CONSTRAINT appartiene_a FOREIGN KEY (appartiene_a) REFERENCES public.utente(username);


--
-- Name: gioco_elemento appartiene_a; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_elemento
    ADD CONSTRAINT appartiene_a FOREIGN KEY (appartiene_a) REFERENCES public.utente(username);


--
-- Name: film_appartenenza_a_genere eidr; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_appartenenza_a_genere
    ADD CONSTRAINT eidr FOREIGN KEY (eidr) REFERENCES public.film(eidr);


--
-- Name: film_localizzazione eidr; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_localizzazione
    ADD CONSTRAINT eidr FOREIGN KEY (eidr) REFERENCES public.film(eidr);


--
-- Name: film_prodotto_da eidr; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_prodotto_da
    ADD CONSTRAINT eidr FOREIGN KEY (eidr) REFERENCES public.film(eidr);


--
-- Name: film_vi_ha_preso_parte eidr; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_vi_ha_preso_parte
    ADD CONSTRAINT eidr FOREIGN KEY (eidr) REFERENCES public.film(eidr);


--
-- Name: film_recensione id; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_recensione
    ADD CONSTRAINT id FOREIGN KEY (id) REFERENCES public.film_elemento(id);


--
-- Name: gioco_recensione id; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_recensione
    ADD CONSTRAINT id FOREIGN KEY (id) REFERENCES public.gioco_elemento(id);


--
-- Name: audiolibro_recensione id; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.audiolibro_recensione
    ADD CONSTRAINT id FOREIGN KEY (id) REFERENCES public.audiolibro_elemento(id);


--
-- Name: libro_recensione id; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_recensione
    ADD CONSTRAINT id FOREIGN KEY (id) REFERENCES public.libro_elemento(id);


--
-- Name: gioco_correlazioni id_1; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_correlazioni
    ADD CONSTRAINT id_1 FOREIGN KEY (id_1) REFERENCES public.gioco(id);


--
-- Name: libro_correlazioni id_1; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_correlazioni
    ADD CONSTRAINT id_1 FOREIGN KEY (id_1) REFERENCES public.libro(id);


--
-- Name: gioco_correlazioni id_2; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_correlazioni
    ADD CONSTRAINT id_2 FOREIGN KEY (id_2) REFERENCES public.gioco(id);


--
-- Name: libro_correlazioni id_2; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_correlazioni
    ADD CONSTRAINT id_2 FOREIGN KEY (id_2) REFERENCES public.libro(id);


--
-- Name: libro_scritto_da id_autore; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_scritto_da
    ADD CONSTRAINT id_autore FOREIGN KEY (id_autore) REFERENCES public.libro_autore(id);


--
-- Name: film_vi_ha_preso_parte id_cast; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_vi_ha_preso_parte
    ADD CONSTRAINT id_cast FOREIGN KEY (id_cast) REFERENCES public.film_cast(id);


--
-- Name: audiolibro_narrata_da id_edizione; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.audiolibro_narrata_da
    ADD CONSTRAINT id_edizione FOREIGN KEY (id_edizione) REFERENCES public.audiolibro_edizione(isbn);


--
-- Name: gioco_portato_da id_edizione; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_portato_da
    ADD CONSTRAINT id_edizione FOREIGN KEY (id_edizione) REFERENCES public.gioco_edizione(id);


--
-- Name: film_appartenenza_a_genere id_genere; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_appartenenza_a_genere
    ADD CONSTRAINT id_genere FOREIGN KEY (id_genere) REFERENCES public.film_genere(id);


--
-- Name: gioco_appartenenza_a_genere id_genere; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_appartenenza_a_genere
    ADD CONSTRAINT id_genere FOREIGN KEY (id_genere) REFERENCES public.gioco_genere(id);


--
-- Name: libro_appartenenza_a_genere id_genere; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_appartenenza_a_genere
    ADD CONSTRAINT id_genere FOREIGN KEY (id_genere) REFERENCES public.libro_genere(id);


--
-- Name: gioco_appartenenza_a_genere id_gioco; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_appartenenza_a_genere
    ADD CONSTRAINT id_gioco FOREIGN KEY (id_gioco) REFERENCES public.gioco(id);


--
-- Name: gioco_prodotto_da id_gioco; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_prodotto_da
    ADD CONSTRAINT id_gioco FOREIGN KEY (id_gioco) REFERENCES public.gioco(id);


--
-- Name: gioco_sviluppato_da id_gioco; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_sviluppato_da
    ADD CONSTRAINT id_gioco FOREIGN KEY (id_gioco) REFERENCES public.gioco(id);


--
-- Name: libro_appartenenza_a_genere id_libro; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_appartenenza_a_genere
    ADD CONSTRAINT id_libro FOREIGN KEY (id_libro) REFERENCES public.libro(id);


--
-- Name: libro_scritto_da id_libro; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_scritto_da
    ADD CONSTRAINT id_libro FOREIGN KEY (id_libro) REFERENCES public.libro(id);


--
-- Name: audiolibro_narrata_da id_narratore; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.audiolibro_narrata_da
    ADD CONSTRAINT id_narratore FOREIGN KEY (id_narratore) REFERENCES public.audiolibro_narratore(id);


--
-- Name: film_vi_ha_preso_parte id_ruolo; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_vi_ha_preso_parte
    ADD CONSTRAINT id_ruolo FOREIGN KEY (id_ruolo) REFERENCES public.film_ruolo(id);


--
-- Name: gioco_sviluppato_da id_studio; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_sviluppato_da
    ADD CONSTRAINT id_studio FOREIGN KEY (id_studio) REFERENCES public.gioco_studio(id);


--
-- Name: gioco_portato_da id_studio; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_portato_da
    ADD CONSTRAINT id_studio FOREIGN KEY (id_studio) REFERENCES public.gioco_studio(id);


--
-- Name: gioco_prodotto_da id_studio; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_prodotto_da
    ADD CONSTRAINT id_studio FOREIGN KEY (id_studio) REFERENCES public.gioco_studio(id);


--
-- Name: film_prodotto_da id_studio; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_prodotto_da
    ADD CONSTRAINT id_studio FOREIGN KEY (id_studio) REFERENCES public.film_studio(id);


--
-- Name: audiolibro_elemento istanza_di; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.audiolibro_elemento
    ADD CONSTRAINT istanza_di FOREIGN KEY (istanza_di) REFERENCES public.audiolibro_edizione(isbn);


--
-- Name: libro_elemento istanza_di; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_elemento
    ADD CONSTRAINT istanza_di FOREIGN KEY (istanza_di) REFERENCES public.libro_edizione(isbn);


--
-- Name: film_elemento istanza_di; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.film_elemento
    ADD CONSTRAINT istanza_di FOREIGN KEY (istanza_di) REFERENCES public.film(eidr);


--
-- Name: gioco_elemento istanza_di; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_elemento
    ADD CONSTRAINT istanza_di FOREIGN KEY (istanza_di) REFERENCES public.gioco_edizione(id);


--
-- Name: libro_edizione relativa_a; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.libro_edizione
    ADD CONSTRAINT relativa_a FOREIGN KEY (relativa_a) REFERENCES public.libro(id);


--
-- Name: audiolibro_edizione relativa_a; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.audiolibro_edizione
    ADD CONSTRAINT relativa_a FOREIGN KEY (relativa_a) REFERENCES public.libro(id);


--
-- Name: gioco_edizione relativa_a; Type: FK CONSTRAINT; Schema: public; Owner: cookie
--

ALTER TABLE ONLY public.gioco_edizione
    ADD CONSTRAINT relativa_a FOREIGN KEY (relativa_a) REFERENCES public.gioco(id);


--
-- Name: TABLE audiolibro_edizione; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.audiolibro_edizione TO steffo;


--
-- Name: TABLE audiolibro_elemento; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.audiolibro_elemento TO steffo;


--
-- Name: TABLE audiolibro_narrata_da; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.audiolibro_narrata_da TO steffo;


--
-- Name: TABLE audiolibro_narratore; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.audiolibro_narratore TO steffo;


--
-- Name: TABLE audiolibro_recensione; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.audiolibro_recensione TO steffo;


--
-- Name: TABLE film; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.film TO steffo;


--
-- Name: TABLE film_appartenenza_a_genere; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.film_appartenenza_a_genere TO steffo;


--
-- Name: TABLE film_cast; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.film_cast TO steffo;


--
-- Name: TABLE film_correlazioni; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.film_correlazioni TO steffo;


--
-- Name: TABLE film_elemento; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.film_elemento TO steffo;


--
-- Name: TABLE film_genere; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.film_genere TO steffo;


--
-- Name: TABLE film_localizzazione; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.film_localizzazione TO steffo;


--
-- Name: TABLE film_ruolo; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.film_ruolo TO steffo;


--
-- Name: TABLE film_studio; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.film_studio TO steffo;


--
-- Name: TABLE film_vi_ha_preso_parte; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.film_vi_ha_preso_parte TO steffo;


--
-- Name: TABLE gioco; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.gioco TO steffo;


--
-- Name: TABLE gioco_appartenenza_a_genere; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.gioco_appartenenza_a_genere TO steffo;


--
-- Name: TABLE gioco_correlazioni; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.gioco_correlazioni TO steffo;


--
-- Name: TABLE gioco_edizione; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.gioco_edizione TO steffo;


--
-- Name: TABLE gioco_elemento; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.gioco_elemento TO steffo;


--
-- Name: TABLE gioco_genere; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.gioco_genere TO steffo;


--
-- Name: TABLE gioco_portato_da; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.gioco_portato_da TO steffo;


--
-- Name: TABLE gioco_prodotto_da; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.gioco_prodotto_da TO steffo;


--
-- Name: TABLE gioco_studio; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.gioco_studio TO steffo;


--
-- Name: TABLE gioco_sviluppato_da; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.gioco_sviluppato_da TO steffo;


--
-- Name: TABLE libro; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.libro TO steffo;


--
-- Name: TABLE libro_appartenenza_a_genere; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.libro_appartenenza_a_genere TO steffo;


--
-- Name: TABLE libro_autore; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.libro_autore TO steffo;


--
-- Name: TABLE libro_correlazioni; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.libro_correlazioni TO steffo;


--
-- Name: TABLE libro_editore; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.libro_editore TO steffo;


--
-- Name: TABLE libro_edizione; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.libro_edizione TO steffo;


--
-- Name: TABLE libro_elemento; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.libro_elemento TO steffo;


--
-- Name: TABLE libro_genere; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.libro_genere TO steffo;


--
-- Name: TABLE libro_recensione; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.libro_recensione TO steffo;


--
-- Name: TABLE libro_scritto_da; Type: ACL; Schema: public; Owner: cookie
--

GRANT ALL ON TABLE public.libro_scritto_da TO steffo;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public REVOKE ALL ON SEQUENCES  FROM postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO steffo;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO cookie;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public REVOKE ALL ON TABLES  FROM postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO steffo;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO cookie;


--
-- PostgreSQL database dump complete
--

