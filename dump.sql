--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

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
-- Name: city; Type: TABLE; Schema: public; Owner: ibahadiraltun
--

CREATE TABLE public.city (
    city_id integer NOT NULL,
    city_name character varying(100) NOT NULL,
    country_code character(3) NOT NULL
);


ALTER TABLE public.city OWNER TO ibahadiraltun;

--
-- Name: city_city_id_seq; Type: SEQUENCE; Schema: public; Owner: ibahadiraltun
--

CREATE SEQUENCE public.city_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.city_city_id_seq OWNER TO ibahadiraltun;

--
-- Name: city_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ibahadiraltun
--

ALTER SEQUENCE public.city_city_id_seq OWNED BY public.city.city_id;


--
-- Name: conference; Type: TABLE; Schema: public; Owner: ibahadiraltun
--

CREATE TABLE public.conference (
    confid character varying(20) NOT NULL,
    name character varying(100) NOT NULL,
    shortname character varying(19) NOT NULL,
    year integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    submission_deadline date NOT NULL,
    creator_user integer NOT NULL,
    website character varying(100),
    creation_datetime date NOT NULL,
    status integer
);


ALTER TABLE public.conference OWNER TO ibahadiraltun;

--
-- Name: conferenceroles; Type: TABLE; Schema: public; Owner: ibahadiraltun
--

CREATE TABLE public.conferenceroles (
    authenticationid integer NOT NULL,
    confid character varying(20),
    confid_role integer NOT NULL
);


ALTER TABLE public.conferenceroles OWNER TO ibahadiraltun;

--
-- Name: conferencetags; Type: TABLE; Schema: public; Owner: ibahadiraltun
--

CREATE TABLE public.conferencetags (
    confid character varying(20) NOT NULL,
    tag character varying(200) NOT NULL
);


ALTER TABLE public.conferencetags OWNER TO ibahadiraltun;

--
-- Name: conferenceupdates; Type: TABLE; Schema: public; Owner: ibahadiraltun
--

CREATE TABLE public.conferenceupdates (
    confid character varying(20) NOT NULL,
    name character varying(100) NOT NULL,
    shortname character varying(19) NOT NULL,
    year integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    submission_deadline date NOT NULL,
    website character varying(100)
);


ALTER TABLE public.conferenceupdates OWNER TO ibahadiraltun;

--
-- Name: country; Type: TABLE; Schema: public; Owner: ibahadiraltun
--

CREATE TABLE public.country (
    country_code character(3) NOT NULL,
    country_name character varying(50) NOT NULL
);


ALTER TABLE public.country OWNER TO ibahadiraltun;

--
-- Name: submissions; Type: TABLE; Schema: public; Owner: ibahadiraltun
--

CREATE TABLE public.submissions (
    authenticationid integer NOT NULL,
    confid character varying(20) NOT NULL,
    submissionid integer NOT NULL,
    prevsubmissionid integer
);


ALTER TABLE public.submissions OWNER TO ibahadiraltun;

--
-- Name: submissions_submissionid_seq; Type: SEQUENCE; Schema: public; Owner: ibahadiraltun
--

CREATE SEQUENCE public.submissions_submissionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.submissions_submissionid_seq OWNER TO ibahadiraltun;

--
-- Name: submissions_submissionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ibahadiraltun
--

ALTER SEQUENCE public.submissions_submissionid_seq OWNED BY public.submissions.submissionid;


--
-- Name: usersinfo; Type: TABLE; Schema: public; Owner: ibahadiraltun
--

CREATE TABLE public.usersinfo (
    authenticationid integer NOT NULL,
    title character varying(50) NOT NULL,
    name character varying(50) NOT NULL,
    lname character varying(50) NOT NULL,
    affiliation character varying(50) NOT NULL,
    primary_email character varying(100) NOT NULL,
    secondary_email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    phone character varying(50) NOT NULL,
    fax character varying(50) NOT NULL,
    url character varying(50) NOT NULL,
    address character varying(100) NOT NULL,
    city character varying(100) NOT NULL,
    country character varying(3) NOT NULL,
    date timestamp without time zone NOT NULL,
    status integer NOT NULL
);


ALTER TABLE public.usersinfo OWNER TO ibahadiraltun;

--
-- Name: usersinfo_authenticationid_seq; Type: SEQUENCE; Schema: public; Owner: ibahadiraltun
--

CREATE SEQUENCE public.usersinfo_authenticationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usersinfo_authenticationid_seq OWNER TO ibahadiraltun;

--
-- Name: usersinfo_authenticationid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ibahadiraltun
--

ALTER SEQUENCE public.usersinfo_authenticationid_seq OWNED BY public.usersinfo.authenticationid;


--
-- Name: userslog; Type: TABLE; Schema: public; Owner: ibahadiraltun
--

CREATE TABLE public.userslog (
    authenticationid integer NOT NULL,
    title character varying(50) NOT NULL,
    name character varying(50) NOT NULL,
    lname character varying(50) NOT NULL,
    affiliation character varying(50) NOT NULL,
    primary_email character varying(100) NOT NULL,
    secondary_email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    phone character varying(50) NOT NULL,
    fax character varying(50) NOT NULL,
    url character varying(50) NOT NULL,
    address character varying(100) NOT NULL,
    city character varying(100) NOT NULL,
    country character varying(3) NOT NULL,
    date timestamp without time zone NOT NULL,
    status integer NOT NULL
);


ALTER TABLE public.userslog OWNER TO ibahadiraltun;

--
-- Name: userslog_authenticationid_seq; Type: SEQUENCE; Schema: public; Owner: ibahadiraltun
--

CREATE SEQUENCE public.userslog_authenticationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userslog_authenticationid_seq OWNER TO ibahadiraltun;

--
-- Name: userslog_authenticationid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ibahadiraltun
--

ALTER SEQUENCE public.userslog_authenticationid_seq OWNED BY public.userslog.authenticationid;


--
-- Name: city city_id; Type: DEFAULT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.city ALTER COLUMN city_id SET DEFAULT nextval('public.city_city_id_seq'::regclass);


--
-- Name: submissions submissionid; Type: DEFAULT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.submissions ALTER COLUMN submissionid SET DEFAULT nextval('public.submissions_submissionid_seq'::regclass);


--
-- Name: usersinfo authenticationid; Type: DEFAULT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.usersinfo ALTER COLUMN authenticationid SET DEFAULT nextval('public.usersinfo_authenticationid_seq'::regclass);


--
-- Name: userslog authenticationid; Type: DEFAULT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.userslog ALTER COLUMN authenticationid SET DEFAULT nextval('public.userslog_authenticationid_seq'::regclass);


--
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: ibahadiraltun
--

COPY public.city (city_id, city_name, country_code) FROM stdin;
1	ANKARA	TUR
2	ISTANBUL	TUR
3	IZMIR	TUR
4	NEW YORK	USA
\.


--
-- Data for Name: conference; Type: TABLE DATA; Schema: public; Owner: ibahadiraltun
--

COPY public.conference (confid, name, shortname, year, start_date, end_date, submission_deadline, creator_user, website, creation_datetime, status) FROM stdin;
cikm2020	Conference of Information Knowledge and Management	cikm	2020	2020-06-06	2020-09-09	2020-05-05	5	--	2020-12-01	1
sigir2021	Special Interest Group of Information Retrieval	sigir	2021	2021-06-06	2021-09-09	2021-05-05	4	--	2020-12-01	-1
\.


--
-- Data for Name: conferenceroles; Type: TABLE DATA; Schema: public; Owner: ibahadiraltun
--

COPY public.conferenceroles (authenticationid, confid, confid_role) FROM stdin;
4	sigir2021	0
\.


--
-- Data for Name: conferencetags; Type: TABLE DATA; Schema: public; Owner: ibahadiraltun
--

COPY public.conferencetags (confid, tag) FROM stdin;
\.


--
-- Data for Name: conferenceupdates; Type: TABLE DATA; Schema: public; Owner: ibahadiraltun
--

COPY public.conferenceupdates (confid, name, shortname, year, start_date, end_date, submission_deadline, website) FROM stdin;
\.


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: ibahadiraltun
--

COPY public.country (country_code, country_name) FROM stdin;
TUR	TURKEY
USA	AMERICA
ZWE	ZIMBABWE
\.


--
-- Data for Name: submissions; Type: TABLE DATA; Schema: public; Owner: ibahadiraltun
--

COPY public.submissions (authenticationid, confid, submissionid, prevsubmissionid) FROM stdin;
5	cikm2020	5	-1
5	cikm2020	6	5
5	cikm2020	7	6
5	cikm2020	8	7
5	cikm2020	9	8
5	cikm2020	10	9
5	cikm2020	11	10
5	cikm2020	12	11
5	cikm2020	13	12
5	cikm2020	14	13
5	cikm2020	15	14
5	cikm2020	16	15
5	cikm2020	17	16
5	cikm2020	18	17
5	cikm2020	19	18
5	cikm2020	20	19
5	cikm2020	21	20
5	cikm2020	22	21
5	cikm2020	23	22
5	cikm2020	24	23
\.


--
-- Data for Name: usersinfo; Type: TABLE DATA; Schema: public; Owner: ibahadiraltun
--

COPY public.usersinfo (authenticationid, title, name, lname, affiliation, primary_email, secondary_email, password, phone, fax, url, address, city, country, date, status) FROM stdin;
1	admin	admin	--	--	admin	--	admin	--	--	--	--	ANKARA	TUR	2020-12-01 01:53:34.053378	1
5	dr	john	smith	--	john	john2	john	--	--	--	--	ISTANBUL	TUR	2020-12-01 03:29:12.692866	1
4	Prof	Ahmet	Akan	--	ahmetakan@gmail.com	ahmetakan2@gmail.com	12345	888 888 8888	22 222 222 2222	ahmetakan.com.tr	TOBB	NEW YORK	USA	2020-11-29 20:20:00.848129	1
6	prof	bahadir	altun	--	bahadir	bahadir2	bahadir	--	--	--	--	ISTANBUL	TUR	2020-12-01 03:29:12.692866	1
\.


--
-- Data for Name: userslog; Type: TABLE DATA; Schema: public; Owner: ibahadiraltun
--

COPY public.userslog (authenticationid, title, name, lname, affiliation, primary_email, secondary_email, password, phone, fax, url, address, city, country, date, status) FROM stdin;
\.


--
-- Name: city_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ibahadiraltun
--

SELECT pg_catalog.setval('public.city_city_id_seq', 4, true);


--
-- Name: submissions_submissionid_seq; Type: SEQUENCE SET; Schema: public; Owner: ibahadiraltun
--

SELECT pg_catalog.setval('public.submissions_submissionid_seq', 24, true);


--
-- Name: usersinfo_authenticationid_seq; Type: SEQUENCE SET; Schema: public; Owner: ibahadiraltun
--

SELECT pg_catalog.setval('public.usersinfo_authenticationid_seq', 4, true);


--
-- Name: userslog_authenticationid_seq; Type: SEQUENCE SET; Schema: public; Owner: ibahadiraltun
--

SELECT pg_catalog.setval('public.userslog_authenticationid_seq', 1, false);


--
-- Name: city city_city_name_key; Type: CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_city_name_key UNIQUE (city_name);


--
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id, city_name);


--
-- Name: conference conference_pkey; Type: CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.conference
    ADD CONSTRAINT conference_pkey PRIMARY KEY (confid);


--
-- Name: conferenceroles conferenceroles_pkey; Type: CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.conferenceroles
    ADD CONSTRAINT conferenceroles_pkey PRIMARY KEY (authenticationid);


--
-- Name: conferencetags conferencetags_pkey; Type: CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.conferencetags
    ADD CONSTRAINT conferencetags_pkey PRIMARY KEY (confid, tag);


--
-- Name: conferenceupdates conferenceupdates_pkey; Type: CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.conferenceupdates
    ADD CONSTRAINT conferenceupdates_pkey PRIMARY KEY (confid);


--
-- Name: country country_country_name_key; Type: CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_country_name_key UNIQUE (country_name);


--
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_code);


--
-- Name: submissions submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (submissionid);


--
-- Name: usersinfo usersinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.usersinfo
    ADD CONSTRAINT usersinfo_pkey PRIMARY KEY (authenticationid);


--
-- Name: usersinfo usersinfo_primary_email_key; Type: CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.usersinfo
    ADD CONSTRAINT usersinfo_primary_email_key UNIQUE (primary_email);


--
-- Name: usersinfo usersinfo_secondary_email_key; Type: CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.usersinfo
    ADD CONSTRAINT usersinfo_secondary_email_key UNIQUE (secondary_email);


--
-- Name: userslog userslog_pkey; Type: CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.userslog
    ADD CONSTRAINT userslog_pkey PRIMARY KEY (authenticationid);


--
-- Name: userslog userslog_primary_email_key; Type: CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.userslog
    ADD CONSTRAINT userslog_primary_email_key UNIQUE (primary_email);


--
-- Name: userslog userslog_secondary_email_key; Type: CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.userslog
    ADD CONSTRAINT userslog_secondary_email_key UNIQUE (secondary_email);


--
-- Name: city city_country_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_country_code_fkey FOREIGN KEY (country_code) REFERENCES public.country(country_code);


--
-- Name: conference conference_creator_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.conference
    ADD CONSTRAINT conference_creator_user_fkey FOREIGN KEY (creator_user) REFERENCES public.usersinfo(authenticationid);


--
-- Name: conferenceroles conferenceroles_authenticationid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.conferenceroles
    ADD CONSTRAINT conferenceroles_authenticationid_fkey FOREIGN KEY (authenticationid) REFERENCES public.usersinfo(authenticationid);


--
-- Name: conferenceroles conferenceroles_confid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.conferenceroles
    ADD CONSTRAINT conferenceroles_confid_fkey FOREIGN KEY (confid) REFERENCES public.conference(confid);


--
-- Name: conferencetags conferencetags_confid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.conferencetags
    ADD CONSTRAINT conferencetags_confid_fkey FOREIGN KEY (confid) REFERENCES public.conference(confid);


--
-- Name: submissions submissions_authenticationid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_authenticationid_fkey FOREIGN KEY (authenticationid) REFERENCES public.usersinfo(authenticationid);


--
-- Name: submissions submissions_confid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_confid_fkey FOREIGN KEY (confid) REFERENCES public.conference(confid);


--
-- Name: usersinfo usersinfo_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.usersinfo
    ADD CONSTRAINT usersinfo_city_fkey FOREIGN KEY (city) REFERENCES public.city(city_name);


--
-- Name: usersinfo usersinfo_country_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.usersinfo
    ADD CONSTRAINT usersinfo_country_fkey FOREIGN KEY (country) REFERENCES public.country(country_code);


--
-- Name: userslog userslog_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.userslog
    ADD CONSTRAINT userslog_city_fkey FOREIGN KEY (city) REFERENCES public.city(city_name);


--
-- Name: userslog userslog_country_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ibahadiraltun
--

ALTER TABLE ONLY public.userslog
    ADD CONSTRAINT userslog_country_fkey FOREIGN KEY (country) REFERENCES public.country(country_code);


--
-- PostgreSQL database dump complete
--

