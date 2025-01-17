PGDMP     .                     x            HW2    13.1    13.1 9    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                        0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16396    HW2    DATABASE     b   CREATE DATABASE "HW2" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Turkish_Turkey.1254';
    DROP DATABASE "HW2";
                postgres    false            �            1259    16429    city    TABLE     �   CREATE TABLE public.city (
    city_id integer NOT NULL,
    city_name character varying(100) NOT NULL,
    country_code character(3) NOT NULL
);
    DROP TABLE public.city;
       public         heap    postgres    false            �            1259    16427    city_city_id_seq    SEQUENCE     �   CREATE SEQUENCE public.city_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.city_city_id_seq;
       public          postgres    false    202                       0    0    city_city_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.city_city_id_seq OWNED BY public.city.city_id;
          public          postgres    false    201            �            1259    16522 
   conference    TABLE     �  CREATE TABLE public.conference (
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
    DROP TABLE public.conference;
       public         heap    postgres    false            �            1259    16542    conferenceroles    TABLE     �   CREATE TABLE public.conferenceroles (
    authenticationid integer NOT NULL,
    confid character varying(20),
    confid_role integer NOT NULL
);
 #   DROP TABLE public.conferenceroles;
       public         heap    postgres    false            �            1259    16532    conferencetags    TABLE     {   CREATE TABLE public.conferencetags (
    confid character varying(20) NOT NULL,
    tag character varying(200) NOT NULL
);
 "   DROP TABLE public.conferencetags;
       public         heap    postgres    false            �            1259    16562    conferenceupdates    TABLE     M  CREATE TABLE public.conferenceupdates (
    confid character varying(20) NOT NULL,
    name character varying(100) NOT NULL,
    shortname character varying(19) NOT NULL,
    year integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    submission_deadline date NOT NULL,
    website character varying(100)
);
 %   DROP TABLE public.conferenceupdates;
       public         heap    postgres    false            �            1259    16407    country    TABLE     y   CREATE TABLE public.country (
    country_code character(3) NOT NULL,
    country_name character varying(50) NOT NULL
);
    DROP TABLE public.country;
       public         heap    postgres    false            �            1259    16682    submissions    TABLE     �   CREATE TABLE public.submissions (
    authenticationid integer NOT NULL,
    confid character varying(20) NOT NULL,
    submissionid integer NOT NULL,
    prevsubmissionid integer
);
    DROP TABLE public.submissions;
       public         heap    postgres    false            �            1259    16680    submissions_submissionid_seq    SEQUENCE     �   CREATE SEQUENCE public.submissions_submissionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.submissions_submissionid_seq;
       public          postgres    false    211                       0    0    submissions_submissionid_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.submissions_submissionid_seq OWNED BY public.submissions.submissionid;
          public          postgres    false    210            �            1259    16474 	   usersinfo    TABLE     �  CREATE TABLE public.usersinfo (
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
    DROP TABLE public.usersinfo;
       public         heap    postgres    false            �            1259    16472    usersinfo_authenticationid_seq    SEQUENCE     �   CREATE SEQUENCE public.usersinfo_authenticationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.usersinfo_authenticationid_seq;
       public          postgres    false    204                       0    0    usersinfo_authenticationid_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.usersinfo_authenticationid_seq OWNED BY public.usersinfo.authenticationid;
          public          postgres    false    203            �            1259    16499    userslog    TABLE     �  CREATE TABLE public.userslog (
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
    DROP TABLE public.userslog;
       public         heap    postgres    false            H           2604    16432    city city_id    DEFAULT     l   ALTER TABLE ONLY public.city ALTER COLUMN city_id SET DEFAULT nextval('public.city_city_id_seq'::regclass);
 ;   ALTER TABLE public.city ALTER COLUMN city_id DROP DEFAULT;
       public          postgres    false    201    202    202            J           2604    16685    submissions submissionid    DEFAULT     �   ALTER TABLE ONLY public.submissions ALTER COLUMN submissionid SET DEFAULT nextval('public.submissions_submissionid_seq'::regclass);
 G   ALTER TABLE public.submissions ALTER COLUMN submissionid DROP DEFAULT;
       public          postgres    false    211    210    211            I           2604    16477    usersinfo authenticationid    DEFAULT     �   ALTER TABLE ONLY public.usersinfo ALTER COLUMN authenticationid SET DEFAULT nextval('public.usersinfo_authenticationid_seq'::regclass);
 I   ALTER TABLE public.usersinfo ALTER COLUMN authenticationid DROP DEFAULT;
       public          postgres    false    203    204    204            �          0    16429    city 
   TABLE DATA           @   COPY public.city (city_id, city_name, country_code) FROM stdin;
    public          postgres    false    202   �L       �          0    16522 
   conference 
   TABLE DATA           �   COPY public.conference (confid, name, shortname, year, start_date, end_date, submission_deadline, creator_user, website, creation_datetime, status) FROM stdin;
    public          postgres    false    206   M       �          0    16542    conferenceroles 
   TABLE DATA           P   COPY public.conferenceroles (authenticationid, confid, confid_role) FROM stdin;
    public          postgres    false    208   N       �          0    16532    conferencetags 
   TABLE DATA           5   COPY public.conferencetags (confid, tag) FROM stdin;
    public          postgres    false    207   LN       �          0    16562    conferenceupdates 
   TABLE DATA           ~   COPY public.conferenceupdates (confid, name, shortname, year, start_date, end_date, submission_deadline, website) FROM stdin;
    public          postgres    false    209   iN       �          0    16407    country 
   TABLE DATA           =   COPY public.country (country_code, country_name) FROM stdin;
    public          postgres    false    200   �N       �          0    16682    submissions 
   TABLE DATA           _   COPY public.submissions (authenticationid, confid, submissionid, prevsubmissionid) FROM stdin;
    public          postgres    false    211   %O       �          0    16474 	   usersinfo 
   TABLE DATA           �   COPY public.usersinfo (authenticationid, title, name, lname, affiliation, primary_email, secondary_email, password, phone, fax, url, address, city, country, date, status) FROM stdin;
    public          postgres    false    204   ZO       �          0    16499    userslog 
   TABLE DATA           �   COPY public.userslog (title, name, lname, affiliation, password, phone, fax, url, address, city, country, date, status, authenticationid, primary_email, secondary_email) FROM stdin;
    public          postgres    false    205   MP                  0    0    city_city_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.city_city_id_seq', 4, true);
          public          postgres    false    201                       0    0    submissions_submissionid_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.submissions_submissionid_seq', 10, true);
          public          postgres    false    210                       0    0    usersinfo_authenticationid_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.usersinfo_authenticationid_seq', 7, true);
          public          postgres    false    203            P           2606    16471    city city_city_name_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_city_name_key UNIQUE (city_name);
 A   ALTER TABLE ONLY public.city DROP CONSTRAINT city_city_name_key;
       public            postgres    false    202            R           2606    16434    city city_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id, city_name);
 8   ALTER TABLE ONLY public.city DROP CONSTRAINT city_pkey;
       public            postgres    false    202    202            Z           2606    16526    conference conference_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.conference
    ADD CONSTRAINT conference_pkey PRIMARY KEY (confid);
 D   ALTER TABLE ONLY public.conference DROP CONSTRAINT conference_pkey;
       public            postgres    false    206            ^           2606    16546 $   conferenceroles conferenceroles_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.conferenceroles
    ADD CONSTRAINT conferenceroles_pkey PRIMARY KEY (authenticationid);
 N   ALTER TABLE ONLY public.conferenceroles DROP CONSTRAINT conferenceroles_pkey;
       public            postgres    false    208            \           2606    16536 "   conferencetags conferencetags_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.conferencetags
    ADD CONSTRAINT conferencetags_pkey PRIMARY KEY (confid, tag);
 L   ALTER TABLE ONLY public.conferencetags DROP CONSTRAINT conferencetags_pkey;
       public            postgres    false    207    207            `           2606    16566 (   conferenceupdates conferenceupdates_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.conferenceupdates
    ADD CONSTRAINT conferenceupdates_pkey PRIMARY KEY (confid);
 R   ALTER TABLE ONLY public.conferenceupdates DROP CONSTRAINT conferenceupdates_pkey;
       public            postgres    false    209            L           2606    16413     country country_country_name_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_country_name_key UNIQUE (country_name);
 J   ALTER TABLE ONLY public.country DROP CONSTRAINT country_country_name_key;
       public            postgres    false    200            N           2606    16411    country country_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_code);
 >   ALTER TABLE ONLY public.country DROP CONSTRAINT country_pkey;
       public            postgres    false    200            b           2606    16687    submissions submissions_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (submissionid);
 F   ALTER TABLE ONLY public.submissions DROP CONSTRAINT submissions_pkey;
       public            postgres    false    211            T           2606    16482    usersinfo usersinfo_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.usersinfo
    ADD CONSTRAINT usersinfo_pkey PRIMARY KEY (authenticationid);
 B   ALTER TABLE ONLY public.usersinfo DROP CONSTRAINT usersinfo_pkey;
       public            postgres    false    204            V           2606    16484 %   usersinfo usersinfo_primary_email_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.usersinfo
    ADD CONSTRAINT usersinfo_primary_email_key UNIQUE (primary_email);
 O   ALTER TABLE ONLY public.usersinfo DROP CONSTRAINT usersinfo_primary_email_key;
       public            postgres    false    204            X           2606    16486 '   usersinfo usersinfo_secondary_email_key 
   CONSTRAINT     m   ALTER TABLE ONLY public.usersinfo
    ADD CONSTRAINT usersinfo_secondary_email_key UNIQUE (secondary_email);
 Q   ALTER TABLE ONLY public.usersinfo DROP CONSTRAINT usersinfo_secondary_email_key;
       public            postgres    false    204            c           2606    16435    city city_country_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_country_code_fkey FOREIGN KEY (country_code) REFERENCES public.country(country_code);
 E   ALTER TABLE ONLY public.city DROP CONSTRAINT city_country_code_fkey;
       public          postgres    false    202    2894    200            h           2606    16527 '   conference conference_creator_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.conference
    ADD CONSTRAINT conference_creator_user_fkey FOREIGN KEY (creator_user) REFERENCES public.usersinfo(authenticationid);
 Q   ALTER TABLE ONLY public.conference DROP CONSTRAINT conference_creator_user_fkey;
       public          postgres    false    2900    206    204            k           2606    16557 5   conferenceroles conferenceroles_authenticationid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.conferenceroles
    ADD CONSTRAINT conferenceroles_authenticationid_fkey FOREIGN KEY (authenticationid) REFERENCES public.usersinfo(authenticationid);
 _   ALTER TABLE ONLY public.conferenceroles DROP CONSTRAINT conferenceroles_authenticationid_fkey;
       public          postgres    false    204    208    2900            j           2606    16552 +   conferenceroles conferenceroles_confid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.conferenceroles
    ADD CONSTRAINT conferenceroles_confid_fkey FOREIGN KEY (confid) REFERENCES public.conference(confid);
 U   ALTER TABLE ONLY public.conferenceroles DROP CONSTRAINT conferenceroles_confid_fkey;
       public          postgres    false    206    2906    208            i           2606    16537 )   conferencetags conferencetags_confid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.conferencetags
    ADD CONSTRAINT conferencetags_confid_fkey FOREIGN KEY (confid) REFERENCES public.conference(confid);
 S   ALTER TABLE ONLY public.conferencetags DROP CONSTRAINT conferencetags_confid_fkey;
       public          postgres    false    2906    206    207            l           2606    16688 -   submissions submissions_authenticationid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_authenticationid_fkey FOREIGN KEY (authenticationid) REFERENCES public.usersinfo(authenticationid);
 W   ALTER TABLE ONLY public.submissions DROP CONSTRAINT submissions_authenticationid_fkey;
       public          postgres    false    211    2900    204            m           2606    16693 #   submissions submissions_confid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_confid_fkey FOREIGN KEY (confid) REFERENCES public.conference(confid);
 M   ALTER TABLE ONLY public.submissions DROP CONSTRAINT submissions_confid_fkey;
       public          postgres    false    211    206    2906            d           2606    16487    usersinfo usersinfo_city_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.usersinfo
    ADD CONSTRAINT usersinfo_city_fkey FOREIGN KEY (city) REFERENCES public.city(city_name);
 G   ALTER TABLE ONLY public.usersinfo DROP CONSTRAINT usersinfo_city_fkey;
       public          postgres    false    204    202    2896            e           2606    16492     usersinfo usersinfo_country_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usersinfo
    ADD CONSTRAINT usersinfo_country_fkey FOREIGN KEY (country) REFERENCES public.country(country_code);
 J   ALTER TABLE ONLY public.usersinfo DROP CONSTRAINT usersinfo_country_fkey;
       public          postgres    false    200    204    2894            f           2606    16512    userslog userslog_city_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.userslog
    ADD CONSTRAINT userslog_city_fkey FOREIGN KEY (city) REFERENCES public.city(city_name);
 E   ALTER TABLE ONLY public.userslog DROP CONSTRAINT userslog_city_fkey;
       public          postgres    false    2896    205    202            g           2606    16517    userslog userslog_country_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.userslog
    ADD CONSTRAINT userslog_country_fkey FOREIGN KEY (country) REFERENCES public.country(country_code);
 H   ALTER TABLE ONLY public.userslog DROP CONSTRAINT userslog_country_fkey;
       public          postgres    false    205    2894    200            �   =   x�3�t��vr�	�2��q�s
�s�9=�|=��lN?�p�H� o��`G�=... ��      �   �   x�uQ�N� >O�tpk\�6�E�&d�N+��������l5����A7v�J(Yb���B�B3,3����0N���uW�!�+L��k����\�n��V�6�C{p�%O�&�Z~����,��#���Oh��Z6��]%�q]�q�Y�s�%E6� �d:�㍄��j�}�1��ɻ��:�3o�{HLH��Ⱦ2�ʋ���W1�U������� �,���*�V�D��_w��o
���      �       x�3�,�L�,2202�4�2C�r��qqq ��r      �      x������ � �      �   k   x�+�L�,2202�.HM�L�Q��+I-J-.Qp/�/-P�O����&�d��)��e��%�p�tr���]3 �2-��4"Ό���b+}�b�mz���\1z\\\ bf%]      �   1   x�	�	�v��
v�t�u�tv�
w���urt
w����� �	�      �   %   x�3�,�L�,2202�4��5�2C0�4����� �Y       �   �   x��P�N�0=;_�H�8���D*.4��ݸ��²�R���-k����'=���Uh.s�2�:��	nw����	���`B:G�c�R��2h�B����}�t������W�_�
눻�����*�$�1�s�Ud26Pl�k�����
M_G��b�i��j-,�v
\�zp~�Fd~ 7����zmâ�J�d��9���(��h�E��;(���R��[֔�{VB�ƕm3      �   �   x��P�
�0;�_�hic�7Ovxt�y�RD�h��?n ��%$!���aH�	�������T
Ȋ�D\q��ۘ̔џ��t]@�@K��Ӭ+��k�xq���K~�L��YZ��"�C6+^׮���QJ� Җ^     