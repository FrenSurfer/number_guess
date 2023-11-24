--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: userinfo; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.userinfo (
    username character varying(22),
    games_played integer,
    best_game integer,
    user_id integer NOT NULL
);


ALTER TABLE public.userinfo OWNER TO freecodecamp;

--
-- Name: userinfo_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.userinfo_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userinfo_user_id_seq OWNER TO freecodecamp;

--
-- Name: userinfo_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.userinfo_user_id_seq OWNED BY public.userinfo.user_id;


--
-- Name: userinfo user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.userinfo ALTER COLUMN user_id SET DEFAULT nextval('public.userinfo_user_id_seq'::regclass);


--
-- Data for Name: userinfo; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.userinfo VALUES ('me', 2, 4, 30);
INSERT INTO public.userinfo VALUES ('otherme', 1, 3, 31);
INSERT INTO public.userinfo VALUES ('user_1700838989050', 2, 222, 33);
INSERT INTO public.userinfo VALUES ('user_1700838989051', 5, 354, 32);
INSERT INTO public.userinfo VALUES ('user_1700839198463', 2, 20, 35);
INSERT INTO public.userinfo VALUES ('user_1700839198464', 5, 147, 34);


--
-- Name: userinfo_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.userinfo_user_id_seq', 35, true);


--
-- Name: userinfo userinfo_user_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.userinfo
    ADD CONSTRAINT userinfo_user_id_key UNIQUE (user_id);


--
-- Name: userinfo userinfo_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.userinfo
    ADD CONSTRAINT userinfo_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

