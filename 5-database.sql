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
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: film_provenienza; Type: TYPE; Schema: public; Owner: -
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


--
-- Name: film_stato; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.film_stato AS ENUM (
    'DA_VEDERE',
    'VISTO'
);


--
-- Name: gioco_provenienza; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.gioco_provenienza AS ENUM (
    'GRATUITO',
    'ACQUISTATO',
    'IN_ABBONAMENTO',
    'PRESO_IN_PRESTITO',
    'NON_PIU_POSSEDUTO',
    'ALTRO'
);


--
-- Name: gioco_stato; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.gioco_stato AS ENUM (
    'DA_INIZIARE',
    'INIZIATO',
    'FINITO',
    'COMPLETATO',
    'NON_APPLICABILE'
);


--
-- Name: libro_provenienza; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.libro_provenienza AS ENUM (
    'ACQUISTATO_FISICO',
    'ACQUISTATO_DIGITALE',
    'PRESTITO',
    'NON_PIU_POSSEDUTO',
    'ALTRO'
);


--
-- Name: libro_stato; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.libro_stato AS ENUM (
    'DA_INIZIARE',
    'INIZIATO',
    'FINITO',
    'ABBANDONATO',
    'NON_APPLICABILE'
);


--
-- Name: is_numeric(character varying); Type: FUNCTION; Schema: public; Owner: -
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


--
-- Name: update_n_audiolibri(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_n_audiolibri() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	IF (TG_OP = 'DELETE') THEN
    	UPDATE utente
			SET audiolibro_elementi_posseduti = audiolibro_elementi_posseduti - 1
			WHERE utente.username = old.appartiene_a;
        RETURN OLD;
    ELSIF (TG_OP = 'INSERT') THEN
        UPDATE utente
			SET audiolibro_elementi_posseduti = audiolibro_elementi_posseduti + 1
			WHERE utente.username = new.appartiene_a;
        RETURN new;
    END IF;
END;
$$;


--
-- Name: update_n_film(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_n_film() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	IF (TG_OP = 'DELETE') THEN
    	UPDATE utente
			SET film_elementi_posseduti = film_elementi_posseduti - 1
			WHERE utente.username = old.appartiene_a;
    	RETURN old;
    ELSIF (TG_OP = 'INSERT') THEN
        UPDATE utente
			SET film_elementi_posseduti = film_elementi_posseduti + 1
			WHERE utente.username = new.appartiene_a;
        RETURN new;
    END IF;
END;
$$;


--
-- Name: update_n_giochi(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_n_giochi() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	IF (TG_OP = 'DELETE') THEN
    	UPDATE utente
			SET gioco_elementi_posseduti = gioco_elementi_posseduti - 1
			WHERE utente.username = old.appartiene_a;
        RETURN old;
    ELSIF (TG_OP = 'INSERT') THEN
        UPDATE utente
			SET gioco_elementi_posseduti = gioco_elementi_posseduti + 1
			WHERE utente.username = new.appartiene_a;
        RETURN new;
    END IF;
END;
$$;


--
-- Name: update_n_libri(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_n_libri() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	IF (TG_OP = 'DELETE') THEN
    	UPDATE utente
			SET libro_elementi_posseduti = libro_elementi_posseduti - 1
			WHERE utente.username = old.appartiene_a;
        RETURN old;
    ELSIF (TG_OP = 'INSERT') THEN
        UPDATE utente
			SET libro_elementi_posseduti = libro_elementi_posseduti + 1
			WHERE utente.username = new.appartiene_a;
        RETURN new;
    END IF;
END;
$$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: audiolibro_edizione; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audiolibro_edizione (
    isbn character(13) NOT NULL,
    titolo character varying NOT NULL,
    durata interval,
    immagine bytea,
    relativa_a integer NOT NULL
);


--
-- Name: elemento_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.elemento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: audiolibro_elemento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audiolibro_elemento (
    id bigint DEFAULT nextval('public.elemento_id_seq'::regclass) NOT NULL,
    istanza_di character(13) NOT NULL,
    stato public.libro_stato,
    provenienza public.libro_provenienza,
    appartiene_a character varying NOT NULL
);


--
-- Name: audiolibro_narrata_da; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audiolibro_narrata_da (
    isbn_edizione character(13) NOT NULL,
    id_narratore integer NOT NULL
);


--
-- Name: audiolibro_narratore_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.audiolibro_narratore_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: audiolibro_narratore; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audiolibro_narratore (
    id integer DEFAULT nextval('public.audiolibro_narratore_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL
);


--
-- Name: audiolibro_recensione; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audiolibro_recensione (
    id bigint NOT NULL,
    commento text NOT NULL,
    valutazione smallint NOT NULL,
    data timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT audiolibro_recensione_valutazione_check CHECK (((valutazione >= 0) AND (valutazione <= 100)))
);


--
-- Name: film; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.film (
    eidr character(34) NOT NULL,
    titolo character varying NOT NULL,
    sinossi text,
    locandina bytea,
    durata integer,
    CONSTRAINT film_durata_check CHECK ((durata >= 0))
);


--
-- Name: COLUMN film.eidr; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.film.eidr IS 'Gli EIDR sono tutti di 34 caratteri.

http://eidr.org/documents/EIDR_ID_Format_v1.1.pdf';


--
-- Name: film_appartenenza_a_genere; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.film_appartenenza_a_genere (
    id_genere integer NOT NULL,
    eidr character(34) NOT NULL
);


--
-- Name: film_cast_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.film_cast_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: film_cast; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.film_cast (
    id integer DEFAULT nextval('public.film_cast_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL
);


--
-- Name: film_correlazioni; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.film_correlazioni (
    eidr_1 character(34) NOT NULL,
    eidr_2 character(34) NOT NULL
);


--
-- Name: film_elemento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.film_elemento (
    id bigint DEFAULT nextval('public.elemento_id_seq'::regclass) NOT NULL,
    stato public.film_stato,
    provenienza public.film_provenienza,
    istanza_di character(34) NOT NULL,
    appartiene_a character varying NOT NULL
);


--
-- Name: film_genere_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.film_genere_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: film_genere; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.film_genere (
    id integer DEFAULT nextval('public.film_genere_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL
);


--
-- Name: film_localizzazione; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.film_localizzazione (
    lingua character(4) NOT NULL,
    eidr character(34) NOT NULL,
    titolo_localizzato character varying NOT NULL
);


--
-- Name: film_prodotto_da; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.film_prodotto_da (
    id_studio integer NOT NULL,
    eidr character(34) NOT NULL
);


--
-- Name: film_recensione; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.film_recensione (
    id bigint NOT NULL,
    commento text NOT NULL,
    data timestamp without time zone DEFAULT now() NOT NULL,
    valutazione smallint NOT NULL,
    CONSTRAINT film_recensione_valutazione_check CHECK (((valutazione >= 0) AND (valutazione <= 100)))
);


--
-- Name: film_ruolo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.film_ruolo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: film_ruolo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.film_ruolo (
    id integer DEFAULT nextval('public.film_ruolo_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL
);


--
-- Name: film_studio_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.film_studio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: film_studio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.film_studio (
    id integer DEFAULT nextval('public.film_studio_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL
);


--
-- Name: film_vi_ha_preso_parte; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.film_vi_ha_preso_parte (
    eidr character(34) NOT NULL,
    id_cast integer NOT NULL,
    id_ruolo integer NOT NULL
);


--
-- Name: gioco_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gioco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gioco; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gioco (
    id integer DEFAULT nextval('public.gioco_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL,
    descrizione text
);


--
-- Name: gioco_appartenenza_a_genere; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gioco_appartenenza_a_genere (
    id_gioco integer NOT NULL,
    id_genere integer NOT NULL
);


--
-- Name: gioco_correlazioni; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gioco_correlazioni (
    id_1 integer NOT NULL,
    id_2 integer NOT NULL
);


--
-- Name: gioco_edizione_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gioco_edizione_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gioco_edizione; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gioco_edizione (
    id integer DEFAULT nextval('public.gioco_edizione_id_seq'::regclass) NOT NULL,
    titolo_alternativo character varying,
    piattaforma character varying NOT NULL,
    box_art bytea,
    relativa_a integer NOT NULL
);


--
-- Name: gioco_elemento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gioco_elemento (
    id bigint DEFAULT nextval('public.elemento_id_seq'::regclass) NOT NULL,
    stato public.gioco_stato,
    provenienza public.gioco_provenienza,
    istanza_di integer NOT NULL,
    appartiene_a character varying NOT NULL
);


--
-- Name: gioco_genere_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gioco_genere_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gioco_genere; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gioco_genere (
    id integer DEFAULT nextval('public.gioco_genere_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL
);


--
-- Name: gioco_portato_da; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gioco_portato_da (
    id_edizione integer NOT NULL,
    id_studio integer NOT NULL
);


--
-- Name: gioco_prodotto_da; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gioco_prodotto_da (
    id_gioco integer NOT NULL,
    id_studio integer NOT NULL
);


--
-- Name: gioco_recensione; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gioco_recensione (
    id bigint NOT NULL,
    commento text NOT NULL,
    data timestamp without time zone DEFAULT now() NOT NULL,
    valutazione smallint NOT NULL,
    CONSTRAINT gioco_recensione_valutazione_check CHECK (((valutazione >= 0) AND (valutazione <= 100)))
);


--
-- Name: gioco_studio_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gioco_studio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gioco_studio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gioco_studio (
    id integer DEFAULT nextval('public.gioco_studio_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL
);


--
-- Name: gioco_sviluppato_da; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gioco_sviluppato_da (
    id_gioco integer NOT NULL,
    id_studio integer NOT NULL
);


--
-- Name: libro_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.libro_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: libro; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.libro (
    id integer DEFAULT nextval('public.libro_id_seq'::regclass) NOT NULL,
    titolo_primario character varying NOT NULL,
    sinossi text
);


--
-- Name: libro_appartenenza_a_genere; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.libro_appartenenza_a_genere (
    id_genere integer NOT NULL,
    id_libro integer NOT NULL
);


--
-- Name: libro_autore_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.libro_autore_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: libro_autore; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.libro_autore (
    id integer DEFAULT nextval('public.libro_autore_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL
);


--
-- Name: libro_correlazioni; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.libro_correlazioni (
    id_1 integer NOT NULL,
    id_2 integer NOT NULL
);


--
-- Name: libro_editore; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.libro_editore (
    parte_isbn character varying(7) NOT NULL,
    nome character varying NOT NULL
);


--
-- Name: COLUMN libro_editore.parte_isbn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.libro_editore.parte_isbn IS 'Gli editori hanno un prefisso ISBN univoco di 5 cifre.

https://www.isbn.it/CODICEISBN.aspx';


--
-- Name: libro_edizione; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.libro_edizione (
    isbn character(13) NOT NULL,
    titolo_edizione character varying NOT NULL,
    pagine integer,
    copertina bytea,
    relativa_a integer NOT NULL,
    CONSTRAINT libro_edizione_isbn_check CHECK ((public.is_numeric(("substring"((isbn)::text, 1, 12))::character varying) AND (public.is_numeric(("right"((isbn)::text, 1))::character varying) OR ("right"((isbn)::text, 1) ~~ '%X'::text)))),
    CONSTRAINT libro_edizione_pagine_check CHECK ((pagine >= 0))
);


--
-- Name: COLUMN libro_edizione.isbn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.libro_edizione.isbn IS 'L''ISBN ha sempre 13 cifre.

https://www.isbn.it/CODICEISBN.aspx';


--
-- Name: libro_elemento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.libro_elemento (
    id bigint DEFAULT nextval('public.elemento_id_seq'::regclass) NOT NULL,
    istanza_di character(13) NOT NULL,
    stato public.libro_stato,
    provenienza public.libro_provenienza,
    appartiene_a character varying NOT NULL
);


--
-- Name: libro_genere_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.libro_genere_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: libro_genere; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.libro_genere (
    id integer DEFAULT nextval('public.libro_genere_id_seq'::regclass) NOT NULL,
    nome character varying NOT NULL
);


--
-- Name: libro_recensione; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.libro_recensione (
    id bigint NOT NULL,
    commento text NOT NULL,
    data timestamp without time zone DEFAULT now() NOT NULL,
    valutazione integer NOT NULL,
    CONSTRAINT libro_recensione_valutazione_check CHECK (((valutazione >= 0) AND (valutazione <= 100)))
);


--
-- Name: libro_scritto_da; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.libro_scritto_da (
    id_libro integer NOT NULL,
    id_autore integer NOT NULL
);


--
-- Name: utente; Type: TABLE; Schema: public; Owner: -
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


--
-- Data for Name: audiolibro_edizione; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.audiolibro_edizione (isbn, titolo, durata, immagine, relativa_a) FROM stdin;
9781433261565	Moby Dick	\N	\N	1
9788862560320	Harry Potter e la Pietra Filosofale	\N	\N	3
9788898425376	Il Libro della Giungla	05:25:00	\N	10
\.


--
-- Data for Name: audiolibro_elemento; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.audiolibro_elemento (id, istanza_di, stato, provenienza, appartiene_a) FROM stdin;
1	9788898425376	FINITO	PRESTITO	Cookie
2	9788862560320	FINITO	ACQUISTATO_DIGITALE	Adolfo
\.


--
-- Data for Name: audiolibro_narrata_da; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.audiolibro_narrata_da (isbn_edizione, id_narratore) FROM stdin;
9788862560320	1
9788898425376	2
\.


--
-- Data for Name: audiolibro_narratore; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.audiolibro_narratore (id, nome) FROM stdin;
1	Giorgio Scaramuzzino
2	Pino Insegno
\.


--
-- Data for Name: audiolibro_recensione; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.audiolibro_recensione (id, commento, valutazione, data) FROM stdin;
1	Molto carino, e Pino Insegno ha una bellissima voce.	75	2020-06-03 12:05:12.618531
2	Libro bellissimo, ma letto maluccio	60	2020-04-21 20:12:34.624137
\.


--
-- Data for Name: film; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.film (eidr, titolo, sinossi, locandina, durata) FROM stdin;
10.5240/29E6-2D4B-B704-2B69-441F-8	Titanic	\N	\N	195
10.5240/E030-107B-C08A-BF93-AC79-B	The Lord of the Rings: The Fellowship of the Ring	\N	\N	\N
10.5240/598E-D2AE-1B7D-67EB-3F75-6	The Lord of the Rings: The Two Towers	\N	\N	\N
10.5240/B07E-E305-8057-CD37-0887-E	The Lord of the Rings: The Return of the King	\N	\N	\N
10.5240/0EF3-54F9-2642-0B49-6829-R	Inception	\N	\N	148
10.5240/3CB5-4D3B-BC77-8A4E-78D4-9	La vita è bella	\N	\N	\N
10.5240/E73C-4D4C-4F90-781B-B62F-K	Shining	\N	\N	146
10.5240/09A3-1F6E-3538-DF46-5C6F-I	Back to the Future	\N	\N	\N
10.5240/5DA5-C386-2911-7E2B-1782-L	Back to the Future Part II	\N	\N	\N
\.


--
-- Data for Name: film_appartenenza_a_genere; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.film_appartenenza_a_genere (id_genere, eidr) FROM stdin;
5	10.5240/E73C-4D4C-4F90-781B-B62F-K
6	10.5240/09A3-1F6E-3538-DF46-5C6F-I
2	10.5240/5DA5-C386-2911-7E2B-1782-L
3	10.5240/29E6-2D4B-B704-2B69-441F-8
1	10.5240/E030-107B-C08A-BF93-AC79-B
1	10.5240/598E-D2AE-1B7D-67EB-3F75-6
1	10.5240/B07E-E305-8057-CD37-0887-E
\.


--
-- Data for Name: film_cast; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.film_cast (id, nome) FROM stdin;
1	Stanley Kubrick
2	Leonardo DiCaprio
3	Peter Jackson
4	Orlando Bloom
5	Roberto Benigni
\.


--
-- Data for Name: film_correlazioni; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.film_correlazioni (eidr_1, eidr_2) FROM stdin;
10.5240/E030-107B-C08A-BF93-AC79-B	10.5240/598E-D2AE-1B7D-67EB-3F75-6
10.5240/E030-107B-C08A-BF93-AC79-B	10.5240/B07E-E305-8057-CD37-0887-E
10.5240/598E-D2AE-1B7D-67EB-3F75-6	10.5240/B07E-E305-8057-CD37-0887-E
10.5240/09A3-1F6E-3538-DF46-5C6F-I	10.5240/5DA5-C386-2911-7E2B-1782-L
\.


--
-- Data for Name: film_elemento; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.film_elemento (id, stato, provenienza, istanza_di, appartiene_a) FROM stdin;
1	VISTO	VISTO_AL_CINEMA	10.5240/29E6-2D4B-B704-2B69-441F-8	Adolfo
2	VISTO	ACQUISTATO_FISICO	10.5240/E030-107B-C08A-BF93-AC79-B	Paolino
3	VISTO	VISTO_IN_TV	10.5240/09A3-1F6E-3538-DF46-5C6F-I	Paolino
4	DA_VEDERE	VISTO_IN_TV	10.5240/5DA5-C386-2911-7E2B-1782-L	Paolino
5	VISTO	VISTO_AL_CINEMA	10.5240/0EF3-54F9-2642-0B49-6829-R	Cookie
6	VISTO	ACQUISTATO_FISICO	10.5240/3CB5-4D3B-BC77-8A4E-78D4-9	Adolfo
7	VISTO	VISTO_IN_TV	10.5240/09A3-1F6E-3538-DF46-5C6F-I	Cookie
8	VISTO	VISTO_IN_TV	10.5240/5DA5-C386-2911-7E2B-1782-L	Cookie
9	VISTO	ACQUISTATO_FISICO	10.5240/E030-107B-C08A-BF93-AC79-B	Cookie
10	VISTO	PRESTITO	10.5240/29E6-2D4B-B704-2B69-441F-8	Paolino
\.


--
-- Data for Name: film_genere; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.film_genere (id, nome) FROM stdin;
1	Fantasy
2	Fantascienza
3	Romantico
4	Thriller
5	Horror
6	Comico
\.


--
-- Data for Name: film_localizzazione; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.film_localizzazione (lingua, eidr, titolo_localizzato) FROM stdin;
it  	10.5240/E030-107B-C08A-BF93-AC79-B	Il Signore degli Anelli: la Compagnia dell'Anello
it  	10.5240/598E-D2AE-1B7D-67EB-3F75-6	Il Signore degli Anelli: le Due Torri
it  	10.5240/B07E-E305-8057-CD37-0887-E	Il Signore degli Anelli: il Ritorno del Re
it  	10.5240/09A3-1F6E-3538-DF46-5C6F-I	Ritorno al Futuro
it  	10.5240/5DA5-C386-2911-7E2B-1782-L	Ritorno al Futuro parte II
\.


--
-- Data for Name: film_prodotto_da; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.film_prodotto_da (id_studio, eidr) FROM stdin;
1	10.5240/29E6-2D4B-B704-2B69-441F-8
2	10.5240/E030-107B-C08A-BF93-AC79-B
2	10.5240/598E-D2AE-1B7D-67EB-3F75-6
2	10.5240/B07E-E305-8057-CD37-0887-E
3	10.5240/E73C-4D4C-4F90-781B-B62F-K
3	10.5240/0EF3-54F9-2642-0B49-6829-R
4	10.5240/0EF3-54F9-2642-0B49-6829-R
5	10.5240/09A3-1F6E-3538-DF46-5C6F-I
6	10.5240/09A3-1F6E-3538-DF46-5C6F-I
5	10.5240/5DA5-C386-2911-7E2B-1782-L
6	10.5240/5DA5-C386-2911-7E2B-1782-L
\.


--
-- Data for Name: film_recensione; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.film_recensione (id, commento, data, valutazione) FROM stdin;
6	Film eccellente, davvero ben fatto e profondo	2020-03-01 08:05:24.916243	100
3	Spassosissimo, non vedo l'ora che alla TV diano il secondo!	2020-05-04 23:56:18.27341	88
2	Gran bel film, e ben recitato!	2020-03-21 14:10:28.624197	80
5	Lo adoro. Punto.	2020-04-22 10:20:47.152308	95
10	Una lungaggine mostruosa. Mi sono annoiato dall'inizio alla fine. Non sono fatto per i film romantici...	2020-02-02 20:57:22.725368	25
\.


--
-- Data for Name: film_ruolo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.film_ruolo (id, nome) FROM stdin;
1	attore protagonista
2	attore non protagonista
3	regista
\.


--
-- Data for Name: film_studio; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.film_studio (id, nome) FROM stdin;
1	20th Century Fox
2	New Line Cinema
3	Warner Bros
4	Legendary Pictures
5	Universal Pictures
6	Amblin Entertainment
\.


--
-- Data for Name: film_vi_ha_preso_parte; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.film_vi_ha_preso_parte (eidr, id_cast, id_ruolo) FROM stdin;
10.5240/E030-107B-C08A-BF93-AC79-B	3	3
10.5240/E030-107B-C08A-BF93-AC79-B	4	2
10.5240/598E-D2AE-1B7D-67EB-3F75-6	3	3
10.5240/598E-D2AE-1B7D-67EB-3F75-6	4	2
10.5240/B07E-E305-8057-CD37-0887-E	3	3
10.5240/B07E-E305-8057-CD37-0887-E	4	2
10.5240/29E6-2D4B-B704-2B69-441F-8	2	1
10.5240/0EF3-54F9-2642-0B49-6829-R	2	1
10.5240/3CB5-4D3B-BC77-8A4E-78D4-9	5	1
10.5240/3CB5-4D3B-BC77-8A4E-78D4-9	5	3
10.5240/E73C-4D4C-4F90-781B-B62F-K	1	3
\.


--
-- Data for Name: gioco; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gioco (id, nome, descrizione) FROM stdin;
1	Fire Emblem: Three Houses	\N
2	AI: The Somnium Files	\N
3	Factorio	\N
4	Terraria	\N
5	Tetris 99	\N
6	Fire Emblem Echoes: Shadows of Valentia	\N
7	Il Professor Layton e il Paese dei Misteri	Il famoso gentiluomo Hershel Layton e il suo fido assistente Luke, dopo aver ricevuto una lettera, si precipitano nello sperduto villaggio di Saint-Mystère...
8	Il Professor Layton e lo Scrigno di Pandora	\N
\.


--
-- Data for Name: gioco_appartenenza_a_genere; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gioco_appartenenza_a_genere (id_gioco, id_genere) FROM stdin;
1	1
1	9
1	8
1	6
2	6
2	2
3	7
3	5
3	9
2	9
4	4
4	5
3	3
4	9
5	5
5	10
6	1
6	9
6	8
6	6
\.


--
-- Data for Name: gioco_correlazioni; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gioco_correlazioni (id_1, id_2) FROM stdin;
1	6
7	8
\.


--
-- Data for Name: gioco_edizione; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gioco_edizione (id, titolo_alternativo, piattaforma, box_art, relativa_a) FROM stdin;
1	\N	Nintendo Switch	\N	1
2	\N	PC	\N	2
3	\N	PC	\N	3
4	\N	PC\r\n	\N	4
5	\N	Nintendo Switch	\N	5
6	\N	Nintendo Switch	\N	4
7	\N	Nintendo 3DS	\N	6
8	\N	Nintendo DS	\N	7
9	\N	Nintendo DS	\N	8
\.


--
-- Data for Name: gioco_elemento; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gioco_elemento (id, stato, provenienza, istanza_di, appartiene_a) FROM stdin;
1	FINITO	PRESO_IN_PRESTITO	1	Steffo
2	COMPLETATO	ALTRO	2	Steffo
3	FINITO	ACQUISTATO	3	Steffo
4	FINITO	ACQUISTATO	4	Steffo
5	NON_APPLICABILE	GRATUITO	5	Steffo
6	FINITO	ACQUISTATO	1	Paolino
7	DA_INIZIARE	GRATUITO	5	Paolino
8	NON_APPLICABILE	ACQUISTATO	6	Paolino
9	DA_INIZIARE	GRATUITO	3	Cookie
10	FINITO	ACQUISTATO	7	Cookie
11	COMPLETATO	ACQUISTATO	8	Cookie
\.


--
-- Data for Name: gioco_genere; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gioco_genere (id, nome) FROM stdin;
1	Strategia
2	Giallo
3	Industria
4	Avventura
5	Multigiocatore
6	Giapponese
7	Ingegneria
8	Fantasy
9	Giocatore singolo
10	Tetris
\.


--
-- Data for Name: gioco_portato_da; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gioco_portato_da (id_edizione, id_studio) FROM stdin;
4	7
\.


--
-- Data for Name: gioco_prodotto_da; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gioco_prodotto_da (id_gioco, id_studio) FROM stdin;
1	5
2	2
3	3
4	4
5	5
\.


--
-- Data for Name: gioco_recensione; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gioco_recensione (id, commento, data, valutazione) FROM stdin;
1	Bello, ma non al livello del settimo capitolo della serie.	2020-06-04 18:00:33.270987	82
3	Attenzione: causa dipendenza	2020-06-04 18:00:33.270987	80
5	Inaspettatamente divertente.	2020-06-04 18:00:33.270987	78
6	Bellissimo	2020-05-25 10:30:37.725301	90
7	Stupendo! Adoro i giochi di misteri!	2020-01-08 09:00:32.926157	87
8	Completato tutto, bello quanto il primo (nonostante l'ultimo "mangia la pallina" mi abbia distrutta).	2020-02-17 20:22:54.261348	86
\.


--
-- Data for Name: gioco_studio; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gioco_studio (id, nome) FROM stdin;
1	Intelligent Systems
2	Spike Chunsoft
3	Wube Software
4	Re-Logic
5	Nintendo
6	Arika
7	505 Games
\.


--
-- Data for Name: gioco_sviluppato_da; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gioco_sviluppato_da (id_gioco, id_studio) FROM stdin;
1	1
1	5
2	2
3	3
4	4
5	5
5	6
\.


--
-- Data for Name: libro; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.libro (id, titolo_primario, sinossi) FROM stdin;
1	Moby Dick	\N
2	A Study in Scarlet	\N
3	Harry Potter e la pietra pilosofale	Primo libro della famosa saga di Harry Potter, di J. K. Rowling.
4	Il segno dei quattro	\N
5	La via del male	\N
6	Ventimila leghe sotto i mari	\N
7	Il signore degli anelli: la compagnia dell'anello	\N
8	Il signore degli anelli: le due torri	\N
9	Il signore degli anelli: il ritorno del re	\N
10	Il libro della giungla	\N
\.


--
-- Data for Name: libro_appartenenza_a_genere; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.libro_appartenenza_a_genere (id_genere, id_libro) FROM stdin;
1	7
1	8
1	9
1	3
2	4
2	2
2	5
3	1
\.


--
-- Data for Name: libro_autore; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.libro_autore (id, nome) FROM stdin;
1	Herman Melville
2	Arthur Conan Doyle
3	Joanne Rowling
4	John Ronald Reuel Tolkien 
5	Andrea Camilleri
6	Agatha Christie
\.


--
-- Data for Name: libro_correlazioni; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.libro_correlazioni (id_1, id_2) FROM stdin;
7	8
7	9
8	9
\.


--
-- Data for Name: libro_editore; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.libro_editore (parte_isbn, nome) FROM stdin;
389	Sellerio editore
6184	Mondadori
7926	Einaudi ragazzi
912	Panini comics
6746	De Agostini
486	Libri Oro Rizzoli
09	Giunti editore
384	Edizioni Piemme
566	Edizioni Piemme
6212	Magazzini Salani
6821	Magazzini Salani
7366	Magazzini Salani
9367	Magazzini Salani
\.


--
-- Data for Name: libro_edizione; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.libro_edizione (isbn, titolo_edizione, pagine, copertina, relativa_a) FROM stdin;
9788845910951	Moby Dick o la balena	588	\N	1
9788884516107	Harry Potter e la pietra pilosofale	\N	\N	3
9788804668466	Il segno dei quattro	\N	\N	4
9788869184796	La via del male	\N	\N	5
9788861883956	Ventimila leghe sotto i mari	\N	\N	6
9788845290404	Il signore degli Anelli: la compagnia dell'anello	\N	\N	7
9788845290428	Il signore degli anelli: le due torri	\N	\N	8
9788848603720	Il signore degli anelli: il ritorno del re	\N	\N	9
\.


--
-- Data for Name: libro_elemento; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.libro_elemento (id, istanza_di, stato, provenienza, appartiene_a) FROM stdin;
10	9788848603720	FINITO	ACQUISTATO_FISICO	Steffo
11	9788845290428	FINITO	ACQUISTATO_FISICO	Steffo
12	9788845290404	FINITO	ACQUISTATO_FISICO	Steffo
13	9788869184796	DA_INIZIARE	PRESTITO	Cookie
14	9788884516107	FINITO	ACQUISTATO_FISICO	Cookie
15	9788804668466	INIZIATO	ACQUISTATO_DIGITALE	Cookie
16	9788845290404	FINITO	PRESTITO	Paolino
17	9788845290428	ABBANDONATO	PRESTITO	Paolino
18	9788845910951	FINITO	ACQUISTATO_FISICO	Adolfo
19	9788861883956	FINITO	ACQUISTATO_FISICO	Adolfo
\.


--
-- Data for Name: libro_genere; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.libro_genere (id, nome) FROM stdin;
1	Fantasy
2	Giallo
3	Romanzo
\.


--
-- Data for Name: libro_recensione; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.libro_recensione (id, commento, data, valutazione) FROM stdin;
10	Inizio fantastico per una fantastica saga fantasy.	2020-06-04 18:05:22.212523	90
17	Noiosissimo, non sono riuscito a finirlo!!	2020-03-10 21:01:13.142351	20
16	Un amico mi ha consigliato di leggere la saga cartacea, il primo non è male ma un po' monotono...	2020-02-23 20:37:24.513521	70
18	Chiamatemi Ismaele. Un grande classico che tutti dovrebbero leggere.	2020-01-06 17:30:47.423513	95
\.


--
-- Data for Name: libro_scritto_da; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.libro_scritto_da (id_libro, id_autore) FROM stdin;
1	1
2	2
7	4
8	4
9	4
5	3
3	3
\.


--
-- Data for Name: utente; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.utente (username, password, email, is_admin, is_banned, libro_elementi_posseduti, audiolibro_elementi_posseduti, film_elementi_posseduti, gioco_elementi_posseduti) FROM stdin;
Steffo	\\x2432622431322464657148396e46436e41615658786c4f50453538504f394777356d48466e4c507741302f4e344c61414b744631397a48372e2e6e71	me@steffo.eu	t	f	3	0	0	5
Adolfo	\\x243262243132246c4b3539323747476354306838766f5a72314f79506534723756755850644f6868696935756748783473725974576330642e63616d	\N	f	t	2	1	2	0
Cookie	\\x24326224313224576f755a4a6d4563573241616169662f66396f6a484f516d554253675270316c6d7950576551744650504d3962636c57616b716743	chiara.calzolari.cc@gmail.com	t	f	3	1	4	3
Paolino	\\x24326224313224783963563341766c4e693770663935696c355468442e4f2e477a344a68526675726f354a47724264436f41755a6d516d4131687236	example@example.org	f	f	2	0	4	3
\.


--
-- Name: audiolibro_narratore_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.audiolibro_narratore_id_seq', 1, false);


--
-- Name: elemento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.elemento_id_seq', 12, true);


--
-- Name: film_cast_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.film_cast_id_seq', 1, false);


--
-- Name: film_genere_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.film_genere_id_seq', 1, false);


--
-- Name: film_ruolo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.film_ruolo_id_seq', 1, false);


--
-- Name: film_studio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.film_studio_id_seq', 1, false);


--
-- Name: gioco_edizione_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.gioco_edizione_id_seq', 7, true);


--
-- Name: gioco_genere_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.gioco_genere_id_seq', 10, true);


--
-- Name: gioco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.gioco_id_seq', 6, true);


--
-- Name: gioco_studio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.gioco_studio_id_seq', 7, true);


--
-- Name: libro_autore_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.libro_autore_id_seq', 1, false);


--
-- Name: libro_genere_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.libro_genere_id_seq', 1, false);


--
-- Name: libro_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.libro_id_seq', 1, false);


--
-- Name: audiolibro_edizione audiolibro_edizione_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audiolibro_edizione
    ADD CONSTRAINT audiolibro_edizione_pkey PRIMARY KEY (isbn);


--
-- Name: audiolibro_elemento audiolibro_elemento_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audiolibro_elemento
    ADD CONSTRAINT audiolibro_elemento_pkey PRIMARY KEY (id);


--
-- Name: audiolibro_narrata_da audiolibro_narrata_da_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audiolibro_narrata_da
    ADD CONSTRAINT audiolibro_narrata_da_pkey PRIMARY KEY (isbn_edizione, id_narratore);


--
-- Name: audiolibro_narratore audiolibro_narratore_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audiolibro_narratore
    ADD CONSTRAINT audiolibro_narratore_pkey PRIMARY KEY (id);


--
-- Name: audiolibro_recensione audiolibro_recensione_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audiolibro_recensione
    ADD CONSTRAINT audiolibro_recensione_pkey PRIMARY KEY (id);


--
-- Name: film_appartenenza_a_genere film_appartenenza_a_genere_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_appartenenza_a_genere
    ADD CONSTRAINT film_appartenenza_a_genere_pkey PRIMARY KEY (id_genere, eidr);


--
-- Name: film_cast film_cast_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_cast
    ADD CONSTRAINT film_cast_pkey PRIMARY KEY (id);


--
-- Name: film_correlazioni film_correlazioni_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_correlazioni
    ADD CONSTRAINT film_correlazioni_pkey PRIMARY KEY (eidr_1, eidr_2);


--
-- Name: film_elemento film_elemento_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_elemento
    ADD CONSTRAINT film_elemento_pkey PRIMARY KEY (id);


--
-- Name: film_genere film_genere_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_genere
    ADD CONSTRAINT film_genere_pkey PRIMARY KEY (id);


--
-- Name: film_localizzazione film_localizzazione_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_localizzazione
    ADD CONSTRAINT film_localizzazione_pkey PRIMARY KEY (eidr, lingua);


--
-- Name: film film_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film
    ADD CONSTRAINT film_pkey PRIMARY KEY (eidr);


--
-- Name: film_prodotto_da film_prodotto_da_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_prodotto_da
    ADD CONSTRAINT film_prodotto_da_pkey PRIMARY KEY (id_studio, eidr);


--
-- Name: film_recensione film_recensione_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_recensione
    ADD CONSTRAINT film_recensione_pkey PRIMARY KEY (id);


--
-- Name: film_studio film_studio_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_studio
    ADD CONSTRAINT film_studio_pkey PRIMARY KEY (id);


--
-- Name: film_vi_ha_preso_parte film_vi_ha_preso_parte_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_vi_ha_preso_parte
    ADD CONSTRAINT film_vi_ha_preso_parte_pkey PRIMARY KEY (eidr, id_cast, id_ruolo);


--
-- Name: gioco_appartenenza_a_genere gioco_appartenenza_a_genere_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_appartenenza_a_genere
    ADD CONSTRAINT gioco_appartenenza_a_genere_pkey PRIMARY KEY (id_gioco, id_genere);


--
-- Name: gioco_correlazioni gioco_correlazioni_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_correlazioni
    ADD CONSTRAINT gioco_correlazioni_pkey PRIMARY KEY (id_1, id_2);


--
-- Name: gioco_edizione gioco_edizione_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_edizione
    ADD CONSTRAINT gioco_edizione_pkey PRIMARY KEY (id);


--
-- Name: gioco_elemento gioco_elemento_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_elemento
    ADD CONSTRAINT gioco_elemento_pkey PRIMARY KEY (id);


--
-- Name: gioco_genere gioco_genere_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_genere
    ADD CONSTRAINT gioco_genere_pkey PRIMARY KEY (id);


--
-- Name: gioco gioco_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco
    ADD CONSTRAINT gioco_pkey PRIMARY KEY (id);


--
-- Name: gioco_portato_da gioco_portato_da_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_portato_da
    ADD CONSTRAINT gioco_portato_da_pkey PRIMARY KEY (id_edizione, id_studio);


--
-- Name: gioco_prodotto_da gioco_prodotto_da_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_prodotto_da
    ADD CONSTRAINT gioco_prodotto_da_pkey PRIMARY KEY (id_gioco, id_studio);


--
-- Name: gioco_recensione gioco_recensione_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_recensione
    ADD CONSTRAINT gioco_recensione_pkey PRIMARY KEY (id);


--
-- Name: gioco_studio gioco_studio_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_studio
    ADD CONSTRAINT gioco_studio_pkey PRIMARY KEY (id);


--
-- Name: gioco_sviluppato_da gioco_sviluppato_da_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_sviluppato_da
    ADD CONSTRAINT gioco_sviluppato_da_pkey PRIMARY KEY (id_gioco, id_studio);


--
-- Name: libro_appartenenza_a_genere libro_appartenenza_a_genere_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_appartenenza_a_genere
    ADD CONSTRAINT libro_appartenenza_a_genere_pkey PRIMARY KEY (id_genere, id_libro);


--
-- Name: libro_autore libro_autore_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_autore
    ADD CONSTRAINT libro_autore_pkey PRIMARY KEY (id);


--
-- Name: libro_correlazioni libro_correlazioni_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_correlazioni
    ADD CONSTRAINT libro_correlazioni_pkey PRIMARY KEY (id_1, id_2);


--
-- Name: libro_editore libro_editore_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_editore
    ADD CONSTRAINT libro_editore_pkey PRIMARY KEY (parte_isbn);


--
-- Name: libro_edizione libro_edizione_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_edizione
    ADD CONSTRAINT libro_edizione_pkey PRIMARY KEY (isbn);


--
-- Name: libro_elemento libro_elemento_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_elemento
    ADD CONSTRAINT libro_elemento_pkey PRIMARY KEY (id);


--
-- Name: libro_genere libro_genere_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_genere
    ADD CONSTRAINT libro_genere_pkey PRIMARY KEY (id);


--
-- Name: libro libro_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro
    ADD CONSTRAINT libro_pkey PRIMARY KEY (id);


--
-- Name: libro_recensione libro_recensione_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_recensione
    ADD CONSTRAINT libro_recensione_pkey PRIMARY KEY (id);


--
-- Name: libro_scritto_da libro_scritto_da_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_scritto_da
    ADD CONSTRAINT libro_scritto_da_pkey PRIMARY KEY (id_libro, id_autore);


--
-- Name: film_ruolo ruolo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_ruolo
    ADD CONSTRAINT ruolo_pkey PRIMARY KEY (id);


--
-- Name: utente username; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utente
    ADD CONSTRAINT username PRIMARY KEY (username);


--
-- Name: audiolibro_elemento numero_audiolibri_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER numero_audiolibri_trigger BEFORE INSERT OR DELETE ON public.audiolibro_elemento FOR EACH ROW EXECUTE PROCEDURE public.update_n_audiolibri();


--
-- Name: film_elemento numero_film_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER numero_film_trigger BEFORE INSERT OR DELETE ON public.film_elemento FOR EACH ROW EXECUTE PROCEDURE public.update_n_film();


--
-- Name: gioco_elemento numero_giochi_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER numero_giochi_trigger BEFORE INSERT OR DELETE ON public.gioco_elemento FOR EACH ROW EXECUTE PROCEDURE public.update_n_giochi();


--
-- Name: libro_elemento numero_libri_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER numero_libri_trigger BEFORE INSERT OR DELETE ON public.libro_elemento FOR EACH ROW EXECUTE PROCEDURE public.update_n_libri();


--
-- Name: libro_elemento appartiene_a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_elemento
    ADD CONSTRAINT appartiene_a FOREIGN KEY (appartiene_a) REFERENCES public.utente(username);


--
-- Name: audiolibro_elemento appartiene_a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audiolibro_elemento
    ADD CONSTRAINT appartiene_a FOREIGN KEY (appartiene_a) REFERENCES public.utente(username);


--
-- Name: film_elemento appartiene_a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_elemento
    ADD CONSTRAINT appartiene_a FOREIGN KEY (appartiene_a) REFERENCES public.utente(username);


--
-- Name: gioco_elemento appartiene_a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_elemento
    ADD CONSTRAINT appartiene_a FOREIGN KEY (appartiene_a) REFERENCES public.utente(username);


--
-- Name: film_appartenenza_a_genere eidr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_appartenenza_a_genere
    ADD CONSTRAINT eidr FOREIGN KEY (eidr) REFERENCES public.film(eidr);


--
-- Name: film_localizzazione eidr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_localizzazione
    ADD CONSTRAINT eidr FOREIGN KEY (eidr) REFERENCES public.film(eidr);


--
-- Name: film_prodotto_da eidr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_prodotto_da
    ADD CONSTRAINT eidr FOREIGN KEY (eidr) REFERENCES public.film(eidr);


--
-- Name: film_vi_ha_preso_parte eidr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_vi_ha_preso_parte
    ADD CONSTRAINT eidr FOREIGN KEY (eidr) REFERENCES public.film(eidr);


--
-- Name: film_correlazioni eidr_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_correlazioni
    ADD CONSTRAINT eidr_1 FOREIGN KEY (eidr_1) REFERENCES public.film(eidr);


--
-- Name: film_correlazioni eidr_2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_correlazioni
    ADD CONSTRAINT eidr_2 FOREIGN KEY (eidr_2) REFERENCES public.film(eidr);


--
-- Name: film_recensione id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_recensione
    ADD CONSTRAINT id FOREIGN KEY (id) REFERENCES public.film_elemento(id);


--
-- Name: gioco_recensione id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_recensione
    ADD CONSTRAINT id FOREIGN KEY (id) REFERENCES public.gioco_elemento(id);


--
-- Name: audiolibro_recensione id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audiolibro_recensione
    ADD CONSTRAINT id FOREIGN KEY (id) REFERENCES public.audiolibro_elemento(id);


--
-- Name: libro_recensione id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_recensione
    ADD CONSTRAINT id FOREIGN KEY (id) REFERENCES public.libro_elemento(id);


--
-- Name: gioco_correlazioni id_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_correlazioni
    ADD CONSTRAINT id_1 FOREIGN KEY (id_1) REFERENCES public.gioco(id);


--
-- Name: libro_correlazioni id_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_correlazioni
    ADD CONSTRAINT id_1 FOREIGN KEY (id_1) REFERENCES public.libro(id);


--
-- Name: gioco_correlazioni id_2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_correlazioni
    ADD CONSTRAINT id_2 FOREIGN KEY (id_2) REFERENCES public.gioco(id);


--
-- Name: libro_correlazioni id_2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_correlazioni
    ADD CONSTRAINT id_2 FOREIGN KEY (id_2) REFERENCES public.libro(id);


--
-- Name: libro_scritto_da id_autore; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_scritto_da
    ADD CONSTRAINT id_autore FOREIGN KEY (id_autore) REFERENCES public.libro_autore(id);


--
-- Name: film_vi_ha_preso_parte id_cast; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_vi_ha_preso_parte
    ADD CONSTRAINT id_cast FOREIGN KEY (id_cast) REFERENCES public.film_cast(id);


--
-- Name: gioco_portato_da id_edizione; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_portato_da
    ADD CONSTRAINT id_edizione FOREIGN KEY (id_edizione) REFERENCES public.gioco_edizione(id);


--
-- Name: film_appartenenza_a_genere id_genere; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_appartenenza_a_genere
    ADD CONSTRAINT id_genere FOREIGN KEY (id_genere) REFERENCES public.film_genere(id);


--
-- Name: gioco_appartenenza_a_genere id_genere; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_appartenenza_a_genere
    ADD CONSTRAINT id_genere FOREIGN KEY (id_genere) REFERENCES public.gioco_genere(id);


--
-- Name: libro_appartenenza_a_genere id_genere; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_appartenenza_a_genere
    ADD CONSTRAINT id_genere FOREIGN KEY (id_genere) REFERENCES public.libro_genere(id);


--
-- Name: gioco_appartenenza_a_genere id_gioco; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_appartenenza_a_genere
    ADD CONSTRAINT id_gioco FOREIGN KEY (id_gioco) REFERENCES public.gioco(id);


--
-- Name: gioco_prodotto_da id_gioco; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_prodotto_da
    ADD CONSTRAINT id_gioco FOREIGN KEY (id_gioco) REFERENCES public.gioco(id);


--
-- Name: gioco_sviluppato_da id_gioco; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_sviluppato_da
    ADD CONSTRAINT id_gioco FOREIGN KEY (id_gioco) REFERENCES public.gioco(id);


--
-- Name: libro_appartenenza_a_genere id_libro; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_appartenenza_a_genere
    ADD CONSTRAINT id_libro FOREIGN KEY (id_libro) REFERENCES public.libro(id);


--
-- Name: libro_scritto_da id_libro; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_scritto_da
    ADD CONSTRAINT id_libro FOREIGN KEY (id_libro) REFERENCES public.libro(id);


--
-- Name: audiolibro_narrata_da id_narratore; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audiolibro_narrata_da
    ADD CONSTRAINT id_narratore FOREIGN KEY (id_narratore) REFERENCES public.audiolibro_narratore(id);


--
-- Name: film_vi_ha_preso_parte id_ruolo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_vi_ha_preso_parte
    ADD CONSTRAINT id_ruolo FOREIGN KEY (id_ruolo) REFERENCES public.film_ruolo(id);


--
-- Name: gioco_sviluppato_da id_studio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_sviluppato_da
    ADD CONSTRAINT id_studio FOREIGN KEY (id_studio) REFERENCES public.gioco_studio(id);


--
-- Name: gioco_portato_da id_studio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_portato_da
    ADD CONSTRAINT id_studio FOREIGN KEY (id_studio) REFERENCES public.gioco_studio(id);


--
-- Name: gioco_prodotto_da id_studio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_prodotto_da
    ADD CONSTRAINT id_studio FOREIGN KEY (id_studio) REFERENCES public.gioco_studio(id);


--
-- Name: film_prodotto_da id_studio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_prodotto_da
    ADD CONSTRAINT id_studio FOREIGN KEY (id_studio) REFERENCES public.film_studio(id);


--
-- Name: audiolibro_narrata_da isbn_edizione; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audiolibro_narrata_da
    ADD CONSTRAINT isbn_edizione FOREIGN KEY (isbn_edizione) REFERENCES public.audiolibro_edizione(isbn);


--
-- Name: libro_elemento istanza_di; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_elemento
    ADD CONSTRAINT istanza_di FOREIGN KEY (istanza_di) REFERENCES public.libro_edizione(isbn);


--
-- Name: film_elemento istanza_di; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_elemento
    ADD CONSTRAINT istanza_di FOREIGN KEY (istanza_di) REFERENCES public.film(eidr);


--
-- Name: gioco_elemento istanza_di; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_elemento
    ADD CONSTRAINT istanza_di FOREIGN KEY (istanza_di) REFERENCES public.gioco_edizione(id);


--
-- Name: audiolibro_elemento istanza_di; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audiolibro_elemento
    ADD CONSTRAINT istanza_di FOREIGN KEY (istanza_di) REFERENCES public.audiolibro_edizione(isbn);


--
-- Name: libro_edizione relativa_a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libro_edizione
    ADD CONSTRAINT relativa_a FOREIGN KEY (relativa_a) REFERENCES public.libro(id);


--
-- Name: audiolibro_edizione relativa_a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audiolibro_edizione
    ADD CONSTRAINT relativa_a FOREIGN KEY (relativa_a) REFERENCES public.libro(id);


--
-- Name: gioco_edizione relativa_a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gioco_edizione
    ADD CONSTRAINT relativa_a FOREIGN KEY (relativa_a) REFERENCES public.gioco(id);


--
-- PostgreSQL database dump complete
--

