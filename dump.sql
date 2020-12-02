--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

-- Started on 2020-12-03 00:56:02

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
-- TOC entry 202 (class 1259 OID 16429)
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    city_id integer NOT NULL,
    city_name character varying(100) NOT NULL,
    country_code character(3) NOT NULL
);


ALTER TABLE public.city OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16427)
-- Name: city_city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.city_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.city_city_id_seq OWNER TO postgres;

--
-- TOC entry 3073 (class 0 OID 0)
-- Dependencies: 201
-- Name: city_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.city_city_id_seq OWNED BY public.city.city_id;


--
-- TOC entry 206 (class 1259 OID 16522)
-- Name: conference; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.conference OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16542)
-- Name: conferenceroles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conferenceroles (
    authenticationid integer NOT NULL,
    confid character varying(20),
    confid_role integer NOT NULL
);


ALTER TABLE public.conferenceroles OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16532)
-- Name: conferencetags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conferencetags (
    confid character varying(20) NOT NULL,
    tag character varying(200) NOT NULL
);


ALTER TABLE public.conferencetags OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16562)
-- Name: conferenceupdates; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.conferenceupdates OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16407)
-- Name: country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country (
    country_code character(3) NOT NULL,
    country_name character varying(50) NOT NULL
);


ALTER TABLE public.country OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16682)
-- Name: submissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.submissions (
    authenticationid integer NOT NULL,
    confid character varying(20) NOT NULL,
    submissionid integer NOT NULL,
    prevsubmissionid integer
);


ALTER TABLE public.submissions OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16680)
-- Name: submissions_submissionid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.submissions_submissionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.submissions_submissionid_seq OWNER TO postgres;

--
-- TOC entry 3074 (class 0 OID 0)
-- Dependencies: 210
-- Name: submissions_submissionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.submissions_submissionid_seq OWNED BY public.submissions.submissionid;


--
-- TOC entry 204 (class 1259 OID 16474)
-- Name: usersinfo; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.usersinfo OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16472)
-- Name: usersinfo_authenticationid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usersinfo_authenticationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usersinfo_authenticationid_seq OWNER TO postgres;

--
-- TOC entry 3075 (class 0 OID 0)
-- Dependencies: 203
-- Name: usersinfo_authenticationid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usersinfo_authenticationid_seq OWNED BY public.usersinfo.authenticationid;


--
-- TOC entry 205 (class 1259 OID 16499)
-- Name: userslog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userslog (
    title character varying(50) NOT NULL,
    name character varying(50) NOT NULL,
    lname character varying(50) NOT NULL,
    affiliation character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    phone character varying(50) NOT NULL,
    fax character varying(50) NOT NULL,
    url character varying(50) NOT NULL,
    address character varying(100) NOT NULL,
    city character varying(100) NOT NULL,
    country character varying(3) NOT NULL,
    date timestamp without time zone NOT NULL,
    status integer NOT NULL,
    authenticationid integer NOT NULL,
    primary_email character varying(100) NOT NULL,
    secondary_email character varying(100) NOT NULL
);


ALTER TABLE public.userslog OWNER TO postgres;

--
-- TOC entry 2888 (class 2604 OID 16432)
-- Name: city city_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city ALTER COLUMN city_id SET DEFAULT nextval('public.city_city_id_seq'::regclass);


--
-- TOC entry 2890 (class 2604 OID 16685)
-- Name: submissions submissionid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions ALTER COLUMN submissionid SET DEFAULT nextval('public.submissions_submissionid_seq'::regclass);


--
-- TOC entry 2889 (class 2604 OID 16477)
-- Name: usersinfo authenticationid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usersinfo ALTER COLUMN authenticationid SET DEFAULT nextval('public.usersinfo_authenticationid_seq'::regclass);


--
-- TOC entry 3058 (class 0 OID 16429)
-- Dependencies: 202
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.city (city_id, city_name, country_code) FROM stdin;
1	ANKARA	TUR
2	ISTANBUL	TUR
3	IZMIR	TUR
4	NEW YORK	USA
\.


--
-- TOC entry 3062 (class 0 OID 16522)
-- Dependencies: 206
-- Data for Name: conference; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conference (confid, name, shortname, year, start_date, end_date, submission_deadline, creator_user, website, creation_datetime, status) FROM stdin;
_dnm_2020	deneme	dnm	2020	2020-12-09	2020-12-05	2020-12-03	4	https://deneme.com	2020-12-02	0
_dnm_2020_2	deneme	dnm	2020	2020-12-11	2020-12-20	2020-12-03	4	https://deneme2.com	2020-12-02	0
cikm2020	Conference of Information Knowledge and Management	cikm	2020	2020-06-06	2020-09-09	2020-05-05	5	--	2020-12-01	1
sigir2021	Special Interest Group of Information Retrieval	sigir	2021	2021-06-06	2021-09-09	2021-05-05	4	--	2020-12-01	2
_abb_2120	abc	abb	2120	2020-12-18	2020-12-05	2020-12-12	4	https://aaa.com	2020-12-02	0
\.


--
-- TOC entry 3064 (class 0 OID 16542)
-- Dependencies: 208
-- Data for Name: conferenceroles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conferenceroles (authenticationid, confid, confid_role) FROM stdin;
4	sigir2021	0
6	sigir2021	1
\.


--
-- TOC entry 3063 (class 0 OID 16532)
-- Dependencies: 207
-- Data for Name: conferencetags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conferencetags (confid, tag) FROM stdin;
\.


--
-- TOC entry 3065 (class 0 OID 16562)
-- Dependencies: 209
-- Data for Name: conferenceupdates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conferenceupdates (confid, name, shortname, year, start_date, end_date, submission_deadline, website) FROM stdin;
sigir2021	Special Interest Group of Information Retrieval	sigir	2021	2021-06-06	2021-09-09	2021-05-05	https://sigir2021.com
\.


--
-- TOC entry 3056 (class 0 OID 16407)
-- Dependencies: 200
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.country (country_code, country_name) FROM stdin;
TUR	TURKEY
USA	AMERICA
ZWE	ZIMBABWE
\.


--
-- TOC entry 3067 (class 0 OID 16682)
-- Dependencies: 211
-- Data for Name: submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.submissions (authenticationid, confid, submissionid, prevsubmissionid) FROM stdin;
6	sigir2021	3	-1
6	sigir2021	7	3
\.


--
-- TOC entry 3060 (class 0 OID 16474)
-- Dependencies: 204
-- Data for Name: usersinfo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usersinfo (authenticationid, title, name, lname, affiliation, primary_email, secondary_email, password, phone, fax, url, address, city, country, date, status) FROM stdin;
5	admin	admin	--	--	admin	--	admin	--	--	--	--	ANKARA	TUR	2020-11-30 21:04:07.784148	1
7	dr	bahadir	altun	--	bahadir	bahadir2	bahadir	--	--	--	--	ISTANBUL	TUR	2020-12-01 21:08:36.239833	0
6	prof	john	smith	--	john	john2	john	--	--	--	--	ISTANBUL	TUR	2020-12-01 21:08:36.239833	1
4	Dr.	Ahmet	Akan	--	ahmetakan@gmail.com	ahmetakan2@gmail.com	12345	888 888 8888	22 222 222 2222	ahmetakan.com.tr	TOBB	ANKARA	TUR	2020-11-29 20:20:00.848129	1
\.


--
-- TOC entry 3061 (class 0 OID 16499)
-- Dependencies: 205
-- Data for Name: userslog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.userslog (title, name, lname, affiliation, password, phone, fax, url, address, city, country, date, status, authenticationid, primary_email, secondary_email) FROM stdin;
Prof	Ahmet	Akan	--	12345	888 888 8888	22 222 222 2222	ahmetakan.com.tr	TOBB	ANKARA	TUR	2020-11-29 20:20:00.848129	1	4	ahmetakan@gmail.com	ahmetakan2@gmail.com
Dr.	Ahmet	Akan	--	12345	888 888 8888	22 222 222 2222	ahmetakan.com.tr	TOBB	ANKARA	TUR	2020-11-29 20:20:00.848129	1	4	ahmetakan@gmail.com	ahmetakan2@gmail.com
Prof	Ahmet	Akan	--	12345	888 888 8888	22 222 222 2222	ahmetakan.com.tr	TOBB	ANKARA	TUR	2020-11-29 20:20:00.848129	1	4	ahmetakan@gmail.com	ahmetakan2@gmail.com
\.


--
-- TOC entry 3076 (class 0 OID 0)
-- Dependencies: 201
-- Name: city_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.city_city_id_seq', 4, true);


--
-- TOC entry 3077 (class 0 OID 0)
-- Dependencies: 210
-- Name: submissions_submissionid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.submissions_submissionid_seq', 10, true);


--
-- TOC entry 3078 (class 0 OID 0)
-- Dependencies: 203
-- Name: usersinfo_authenticationid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usersinfo_authenticationid_seq', 7, true);


--
-- TOC entry 2896 (class 2606 OID 16471)
-- Name: city city_city_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_city_name_key UNIQUE (city_name);


--
-- TOC entry 2898 (class 2606 OID 16434)
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id, city_name);


--
-- TOC entry 2906 (class 2606 OID 16526)
-- Name: conference conference_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conference
    ADD CONSTRAINT conference_pkey PRIMARY KEY (confid);


--
-- TOC entry 2910 (class 2606 OID 16546)
-- Name: conferenceroles conferenceroles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conferenceroles
    ADD CONSTRAINT conferenceroles_pkey PRIMARY KEY (authenticationid);


--
-- TOC entry 2908 (class 2606 OID 16536)
-- Name: conferencetags conferencetags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conferencetags
    ADD CONSTRAINT conferencetags_pkey PRIMARY KEY (confid, tag);


--
-- TOC entry 2912 (class 2606 OID 16566)
-- Name: conferenceupdates conferenceupdates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conferenceupdates
    ADD CONSTRAINT conferenceupdates_pkey PRIMARY KEY (confid);


--
-- TOC entry 2892 (class 2606 OID 16413)
-- Name: country country_country_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_country_name_key UNIQUE (country_name);


--
-- TOC entry 2894 (class 2606 OID 16411)
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_code);


--
-- TOC entry 2914 (class 2606 OID 16687)
-- Name: submissions submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (submissionid);


--
-- TOC entry 2900 (class 2606 OID 16482)
-- Name: usersinfo usersinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usersinfo
    ADD CONSTRAINT usersinfo_pkey PRIMARY KEY (authenticationid);


--
-- TOC entry 2902 (class 2606 OID 16484)
-- Name: usersinfo usersinfo_primary_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usersinfo
    ADD CONSTRAINT usersinfo_primary_email_key UNIQUE (primary_email);


--
-- TOC entry 2904 (class 2606 OID 16486)
-- Name: usersinfo usersinfo_secondary_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usersinfo
    ADD CONSTRAINT usersinfo_secondary_email_key UNIQUE (secondary_email);


--
-- TOC entry 2915 (class 2606 OID 16435)
-- Name: city city_country_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_country_code_fkey FOREIGN KEY (country_code) REFERENCES public.country(country_code);


--
-- TOC entry 2920 (class 2606 OID 16527)
-- Name: conference conference_creator_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conference
    ADD CONSTRAINT conference_creator_user_fkey FOREIGN KEY (creator_user) REFERENCES public.usersinfo(authenticationid);


--
-- TOC entry 2923 (class 2606 OID 16557)
-- Name: conferenceroles conferenceroles_authenticationid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conferenceroles
    ADD CONSTRAINT conferenceroles_authenticationid_fkey FOREIGN KEY (authenticationid) REFERENCES public.usersinfo(authenticationid);


--
-- TOC entry 2922 (class 2606 OID 16552)
-- Name: conferenceroles conferenceroles_confid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conferenceroles
    ADD CONSTRAINT conferenceroles_confid_fkey FOREIGN KEY (confid) REFERENCES public.conference(confid);


--
-- TOC entry 2921 (class 2606 OID 16537)
-- Name: conferencetags conferencetags_confid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conferencetags
    ADD CONSTRAINT conferencetags_confid_fkey FOREIGN KEY (confid) REFERENCES public.conference(confid);


--
-- TOC entry 2924 (class 2606 OID 16688)
-- Name: submissions submissions_authenticationid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_authenticationid_fkey FOREIGN KEY (authenticationid) REFERENCES public.usersinfo(authenticationid);


--
-- TOC entry 2925 (class 2606 OID 16693)
-- Name: submissions submissions_confid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_confid_fkey FOREIGN KEY (confid) REFERENCES public.conference(confid);


--
-- TOC entry 2916 (class 2606 OID 16487)
-- Name: usersinfo usersinfo_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usersinfo
    ADD CONSTRAINT usersinfo_city_fkey FOREIGN KEY (city) REFERENCES public.city(city_name);


--
-- TOC entry 2917 (class 2606 OID 16492)
-- Name: usersinfo usersinfo_country_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usersinfo
    ADD CONSTRAINT usersinfo_country_fkey FOREIGN KEY (country) REFERENCES public.country(country_code);


--
-- TOC entry 2918 (class 2606 OID 16512)
-- Name: userslog userslog_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userslog
    ADD CONSTRAINT userslog_city_fkey FOREIGN KEY (city) REFERENCES public.city(city_name);


--
-- TOC entry 2919 (class 2606 OID 16517)
-- Name: userslog userslog_country_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userslog
    ADD CONSTRAINT userslog_country_fkey FOREIGN KEY (country) REFERENCES public.country(country_code);


-- Completed on 2020-12-03 00:56:03

--
-- PostgreSQL database dump complete
--

