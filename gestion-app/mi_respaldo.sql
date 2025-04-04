--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0 (Debian 17.0-1.pgdg120+1)
-- Dumped by pg_dump version 17.0 (Debian 17.0-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: course_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_requests (
    request_id integer NOT NULL,
    request_status character varying(50),
    school_id integer NOT NULL,
    course_id integer NOT NULL,
    "group" integer,
    assignment_id integer,
    CONSTRAINT course_requests_request_status_check CHECK (((request_status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'rejected'::character varying])::text[])))
);


ALTER TABLE public.course_requests OWNER TO postgres;

--
-- Name: course_requests_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_requests_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.course_requests_course_id_seq OWNER TO postgres;

--
-- Name: course_requests_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_requests_course_id_seq OWNED BY public.course_requests.course_id;


--
-- Name: course_requests_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_requests_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.course_requests_request_id_seq OWNER TO postgres;

--
-- Name: course_requests_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_requests_request_id_seq OWNED BY public.course_requests.request_id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses (
    course_id integer NOT NULL,
    course_name character varying(255) NOT NULL,
    credits integer NOT NULL,
    semester_id integer NOT NULL,
    code character varying,
    CONSTRAINT courses_credits_check CHECK ((credits > 0))
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- Name: courses_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.courses_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.courses_course_id_seq OWNER TO postgres;

--
-- Name: courses_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.courses_course_id_seq OWNED BY public.courses.course_id;


--
-- Name: school_courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.school_courses (
    school_id integer NOT NULL,
    course_id integer NOT NULL
);


ALTER TABLE public.school_courses OWNER TO postgres;

--
-- Name: schools; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schools (
    school_id integer NOT NULL,
    school_name character varying(255) NOT NULL
);


ALTER TABLE public.schools OWNER TO postgres;

--
-- Name: schools_school_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schools_school_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.schools_school_id_seq OWNER TO postgres;

--
-- Name: schools_school_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schools_school_id_seq OWNED BY public.schools.school_id;


--
-- Name: semesters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.semesters (
    semester_id integer NOT NULL,
    year_id integer NOT NULL,
    semester_num integer,
    semester_name character varying
);


ALTER TABLE public.semesters OWNER TO postgres;

--
-- Name: semesters_semester_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.semesters_semester_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.semesters_semester_id_seq OWNER TO postgres;

--
-- Name: semesters_semester_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.semesters_semester_id_seq OWNED BY public.semesters.semester_id;


--
-- Name: teacher_course_assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teacher_course_assignments (
    assignment_id integer NOT NULL,
    teacher_id integer NOT NULL,
    assigned_date date NOT NULL,
    semester_id integer NOT NULL,
    course_request_id integer
);


ALTER TABLE public.teacher_course_assignments OWNER TO postgres;

--
-- Name: teacher_course_assignments_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teacher_course_assignments_assignment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teacher_course_assignments_assignment_id_seq OWNER TO postgres;

--
-- Name: teacher_course_assignments_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teacher_course_assignments_assignment_id_seq OWNED BY public.teacher_course_assignments.assignment_id;


--
-- Name: teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teachers (
    teacher_id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone_number character varying(20),
    max_credits integer NOT NULL,
    rut_login character varying,
    password character varying,
    contract character varying,
    status boolean,
    CONSTRAINT teachers_max_credits_check CHECK ((max_credits > 0))
);


ALTER TABLE public.teachers OWNER TO postgres;

--
-- Name: teachers_teacher_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teachers_teacher_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teachers_teacher_id_seq OWNER TO postgres;

--
-- Name: teachers_teacher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teachers_teacher_id_seq OWNED BY public.teachers.teacher_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    rut character varying NOT NULL,
    password character varying NOT NULL,
    role "char" NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: years; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.years (
    year_id integer NOT NULL,
    year_name character varying(4) NOT NULL
);


ALTER TABLE public.years OWNER TO postgres;

--
-- Name: years_year_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.years_year_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.years_year_id_seq OWNER TO postgres;

--
-- Name: years_year_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.years_year_id_seq OWNED BY public.years.year_id;


--
-- Name: course_requests request_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_requests ALTER COLUMN request_id SET DEFAULT nextval('public.course_requests_request_id_seq'::regclass);


--
-- Name: course_requests course_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_requests ALTER COLUMN course_id SET DEFAULT nextval('public.course_requests_course_id_seq'::regclass);


--
-- Name: courses course_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses ALTER COLUMN course_id SET DEFAULT nextval('public.courses_course_id_seq'::regclass);


--
-- Name: schools school_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schools ALTER COLUMN school_id SET DEFAULT nextval('public.schools_school_id_seq'::regclass);


--
-- Name: semesters semester_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.semesters ALTER COLUMN semester_id SET DEFAULT nextval('public.semesters_semester_id_seq'::regclass);


--
-- Name: teacher_course_assignments assignment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments ALTER COLUMN assignment_id SET DEFAULT nextval('public.teacher_course_assignments_assignment_id_seq'::regclass);


--
-- Name: teachers teacher_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers ALTER COLUMN teacher_id SET DEFAULT nextval('public.teachers_teacher_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Name: years year_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.years ALTER COLUMN year_id SET DEFAULT nextval('public.years_year_id_seq'::regclass);


--
-- Data for Name: course_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_requests (request_id, request_status, school_id, course_id, "group", assignment_id) FROM stdin;
2994	pending	3	137	0	\N
2995	pending	4	138	0	\N
2996	pending	3	140	0	\N
2997	pending	3	141	0	\N
2998	pending	5	142	0	\N
2999	pending	2	143	0	\N
3000	pending	4	143	0	\N
3004	pending	3	149	0	\N
3005	pending	3	150	0	\N
3006	pending	3	151	0	\N
3007	pending	4	152	0	\N
3008	pending	4	153	0	\N
3009	pending	3	154	0	\N
3010	pending	4	155	0	\N
3011	pending	3	156	0	\N
3012	pending	7	157	0	\N
3013	pending	7	158	0	\N
3014	pending	4	159	0	\N
3015	pending	3	160	0	\N
3016	pending	4	161	0	\N
3017	pending	4	154	0	\N
3018	pending	3	163	0	\N
3019	pending	4	164	0	\N
3020	pending	3	165	0	\N
3021	pending	4	166	0	\N
3022	pending	3	167	0	\N
3023	pending	3	168	0	\N
3024	pending	4	169	0	\N
3025	pending	3	170	0	\N
3026	pending	4	171	0	\N
3027	pending	4	172	0	\N
3028	pending	4	173	0	\N
3029	pending	4	174	0	\N
3030	pending	3	175	0	\N
3031	pending	4	176	0	\N
3032	pending	4	177	0	\N
3033	pending	4	178	0	\N
3034	pending	4	179	0	\N
3035	pending	4	180	0	\N
3036	pending	3	180	0	\N
3037	pending	4	182	0	\N
3038	pending	3	183	0	\N
3039	pending	3	184	0	\N
3040	pending	3	185	0	\N
3041	pending	3	186	0	\N
3042	pending	4	187	0	\N
3043	pending	4	188	0	\N
3044	pending	4	189	0	\N
3045	pending	4	190	0	\N
3046	pending	4	191	0	\N
2993	approved	2	136	0	153
3002	approved	2	145	0	154
3003	approved	4	145	0	154
3001	approved	6	145	0	154
\.


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.courses (course_id, course_name, credits, semester_id, code) FROM stdin;
136	TALLER DE INGENIER├ìA II	6	32	IOCC038-17
137	TALLER DE MATERIALES DE CONSTRUCCI├ôN	6	32	IOCC075-18
138	TALLER DE GEOMETR├ìA DESCRIPTIVA	6	32	IOCC079-18
139	TALLER DE GEOMETR├ìA DESCRIPTIVA	6	32	IOCC079-18
140	MEC├üNICA RACIONAL	6	32	IOCC085-18
141	TALLER DE URBANIZACI├ôN	6	32	IOCC088-18
142	TALLER DE DIBUJO EN INGENIER├ìA	6	32	IOCC104-18
143	MEC├üNICA RACIONAL EST├üTICA	6	32	IOCC109-18
144	MEC├üNICA RACIONAL EST├üTICA	6	32	IOCC109-18
145	TALLER DE INTRODUCCI├ôN A LOS PROCESOS CONSTRUCTIVOS	6	32	IOCC119-18
146	TALLER DE INTRODUCCI├ôN A LOS PROCESOS CONSTRUCTIVOS	6	32	IOCC119-18
147	TALLER DE INTRODUCCI├ôN A LOS PROCESOS CONSTRUCTIVOS	6	32	IOCC119-18
148	TALLER DE INTRODUCCI├ôN A LOS PROCESOS CONSTRUCTIVOS	6	32	IOCC119-18
149	AN├üLISIS DE ESTRUCTURAS	6	32	IOCC129-18
150	MEC├üNICA DE SUELOS Y LABORATORIO	6	32	IOCC146-18
151	EDIFICACI├ôN EN OBRA GRUESA	6	32	IOCC153-18
152	GESTI├ôN DE OPERACIONES EN LA CONSTRUCCI├ôN	6	32	IOCC156-13
153	HIDR├üULICA	6	32	IOCC157-18
154	TOPOGRAF├ìA GENERAL	6	32	IOCC165-18
155	AN├üLISIS DE ESTRUCTURAS ISOST├üTICAS	6	32	IOCC166-18
156	TALLER DE REDES DE AGUA POTABLE Y ALCANTARILLADO	6	32	IOCC168-18
157	SISTEMAS ESTRUCTURALES	6	32	IOCC178-17
158	DISE├æO ESTRUCTURAL AVANZADO	6	32	IOCC195-17
159	M├ëTODOS MATEM├üTICOS PARA INGENIER├ìA	6	32	IOCC204-18
160	ESTRATEGIA COMPETITIVA	6	32	IOCC207-21
161	SISTEMAS Y PROCESOS CONSTRUCTIVOS	6	32	IOCC209-18
162	TOPOGRAF├ìA GENERAL	6	32	IOCC219-18
163	ESTRUCTURAS MET├üLICAS Y DE MADERA	6	32	IOCC241-18
164	DIN├üMICA DE ESTRUCTURAS	6	32	IOCC244-18
165	HORMIG├ôN ARMADO	6	32	IOCC245-18
166	DISE├æO DE ELEMENTOS DE HORMIG├ôN ARMADO	6	32	IOCC248-18
167	CONSTRUCCI├ôN DE OBRAS VIALES	6	32	IOCC251-18
168	DETERIORO Y REPARACI├ôN DE MATERIALES DE CONSTRUCCI├ôN	6	32	IOCC252-21
169	ESTRATEGIA COMPETITIVA EN CONTEXTO DE OBRAS CIVILES	6	32	IOCC253-22
170	SUSTENTABILIDAD DE MATERIALES DE CONSTRUCCI├ôN	6	32	IOCC254-21
171	MEC├üNICA DE SUELOS APLICADA	6	32	IOCC255-18
172	EVALUACI├ôN DE PROYECTOS	6	32	IOCC256-18
173	DETERIORO Y REPARACI├ôN DE MATERIALES DE CONSTRUCCI├ôN EN OBRAS CIVILES	6	32	IOCC257-22
174	TALLER DE INSTALACIONES SANITARIAS	6	32	IOCC258-18
175	PROGRAMACI├ôN DE OBRAS	6	32	IOCC259-18
176	INGENIER├ìA SISMO RESISTENTE	6	32	IOCC269-18
177	DISE├æO ESTRUCTURAL DE PAVIMENTO	6	32	IOCC279-18
178	DISE├æO AVANZADO DE ESTRUCTURAS DE ACERO	6	32	IOCC280-18
179	INGENIER├ìA AMBIENTAL	6	32	IOCC285-18
180	DISE├æO Y CONTROL DE MEZCLAS BITUMINOSAS	6	32	IOCC287-22
181	DISE├æO Y CONTROL DE MEZCLAS BITUMINOSAS	6	32	IOCC287-22
182	TALLER DE DISE├æO ESTRUCTURAL	6	32	IOCC288-18
183	GIRA DE ESTUDIOS	6	32	IOCC290-18
184	SEMINARIO DE CONSTRUCCI├ôN	6	32	IOCC295-08
185	PR├üCTICA PROFESIONAL	6	32	IOCC295-18
186	TRABAJO DE T├ìTULO	6	32	IOCC297-18
187	PROYECTO DE T├ìTULO	6	32	IOCC298-22
188	TESIS	6	32	IOCC298-90
189	ESTRUCTURAS DE PUENTES	6	32	IOCC301-11
190	SISMOLOG├ìA APLICADA	6	32	IOCC302-11
191	MODELACI├ôN DEL COMPORTAMIENTO DE MATERIALES EN EL CONTEXTO DE OBRAS CIVILES	6	32	IOCC315-22
\.


--
-- Data for Name: school_courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.school_courses (school_id, course_id) FROM stdin;
\.


--
-- Data for Name: schools; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schools (school_id, school_name) FROM stdin;
2	BACHILLERATO EN CIENCIAS DE LA INGENIER├ìA PLAN COM├ÜN 
3	INGENIER├ìA EN CONSTRUCCI├ôN 
4	INGENIER├ìA CIVIL EN OBRAS CIVILES 
5	PROGRAMA ESPECIAL DE PREGRADO DE INTERCAMBIO 
6	BACHILLERATO EN CIENCIAS DE LA INGENIER├ìA (COY)
7	ARQUITECTURA
\.


--
-- Data for Name: semesters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.semesters (semester_id, year_id, semester_num, semester_name) FROM stdin;
31	1	1	Semestral
32	1	2	Semestral
33	2	3	Semestral
34	2	4	Semestral
35	3	5	Anual
36	3	6	Anual
37	3	7	Anual
38	3	8	Anual
39	3	9	Anual
40	3	10	Anual
41	3	11	Anual
\.


--
-- Data for Name: teacher_course_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teacher_course_assignments (assignment_id, teacher_id, assigned_date, semester_id, course_request_id) FROM stdin;
152	1	2024-11-11	32	2993
153	2	2024-11-11	32	2993
154	29	2024-11-11	32	3002
\.


--
-- Data for Name: teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teachers (teacher_id, first_name, last_name, email, phone_number, max_credits, rut_login, password, contract, status) FROM stdin;
1	Juan	P├®rez	juan.perez@uach.cl	123456789	20	12345678-9	password1	Contrato A	\N
2	Mar├¡a	Gonz├ílez	maria.gonzalez@uach.cl	987654321	25	98765432-1	password2	Contrato B	\N
3	Luis	Rodr├¡guez	luis.rodriguez@uach.cl	456123789	15	45678912-3	password3	Contrato C	\N
4	Ana	Mart├¡nez	ana.martinez@uach.cl	321654987	30	32165498-7	password4	Contrato D	\N
10	Patricia	L├│pez	patricia.lopez@uach.cl	123789456	18	12378945-6	password6	Contrato A	t
11	Fernando	D├¡az	fernando.diaz@uach.cl	789456123	22	78945612-3	password7	Contrato B	t
12	Sof├¡a	Ram├¡rez	sofia.ramirez@uach.cl	147258369	20	14725836-9	password8	Contrato C	t
13	Ricardo	Torres	ricardo.torres@uach.cl	258369147	12	25836914-7	password9	Contrato D	t
14	Andrea	S├ínchez	andrea.sanchez@uach.cl	369147258	24	36914725-8	password10	Contrato E	t
15	Jorge	Castro	jorge.castro@uach.cl	741852963	15	74185296-3	password11	Contrato A	t
16	Claudia	Morales	claudia.morales@uach.cl	852963741	28	85296374-1	password12	Contrato B	t
17	Ra├║l	G├│mez	raul.gomez@uach.cl	963741852	19	96374185-2	password13	Contrato C	t
18	Elena	Reyes	elena.reyes@uach.cl	951753456	17	95175345-6	password14	Contrato D	t
19	Manuel	Jim├®nez	manuel.jimenez@uach.cl	753951456	21	75395145-6	password15	Contrato E	t
20	Gabriela	Ortiz	gabriela.ortiz@uach.cl	456951753	20	45695175-3	password16	Contrato A	t
21	Francisco	Molina	francisco.molina@uach.cl	852147963	14	85214796-3	password17	Contrato B	t
22	M├│nica	Silva	monica.silva@uach.cl	741963852	25	74196385-2	password18	Contrato C	t
23	H├®ctor	Vargas	hector.vargas@uach.cl	369852147	18	36985214-7	password19	Contrato D	t
24	Isabel	Pe├▒a	isabel.pena@uach.cl	123456789	23	12345678-5	password20	Contrato E	t
25	Tom├ís	Campos	tomas.campos@uach.cl	789123456	27	78912345-6	password21	Contrato A	t
26	Carla	Pizarro	carla.pizarro@uach.cl	147852369	16	14785236-9	password22	Contrato B	t
27	Javier	Navarro	javier.navarro@uach.cl	258741369	29	25874136-9	password23	Contrato C	t
28	Natalia	Espinoza	natalia.espinoza@uach.cl	369258147	13	36925814-5	password24	Contrato D	t
29	C├®sar	Rojas	cesar.rojas@uach.cl	456123789	20	45612378-9	password25	Contrato E	t
5	Carlos	Hern├índez	carlos.hernandez@uach.cl	654321987	10	65432112-5	password5	Contrato E	t
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, rut, password, role) FROM stdin;
\.


--
-- Data for Name: years; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.years (year_id, year_name) FROM stdin;
1	2023
2	2024
3	2025
4	2026
5	2027
\.


--
-- Name: course_requests_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_requests_course_id_seq', 5, true);


--
-- Name: course_requests_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_requests_request_id_seq', 3046, true);


--
-- Name: courses_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_course_id_seq', 191, true);


--
-- Name: schools_school_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schools_school_id_seq', 7, true);


--
-- Name: semesters_semester_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.semesters_semester_id_seq', 41, true);


--
-- Name: teacher_course_assignments_assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teacher_course_assignments_assignment_id_seq', 154, true);


--
-- Name: teachers_teacher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teachers_teacher_id_seq', 29, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);


--
-- Name: years_year_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.years_year_id_seq', 1, false);


--
-- Name: course_requests course_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_requests
    ADD CONSTRAINT course_requests_pkey PRIMARY KEY (request_id);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (course_id);


--
-- Name: school_courses school_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school_courses
    ADD CONSTRAINT school_courses_pkey PRIMARY KEY (school_id, course_id);


--
-- Name: schools schools_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schools
    ADD CONSTRAINT schools_pkey PRIMARY KEY (school_id);


--
-- Name: semesters semesters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.semesters
    ADD CONSTRAINT semesters_pkey PRIMARY KEY (semester_id);


--
-- Name: teacher_course_assignments teacher_course_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT teacher_course_assignments_pkey PRIMARY KEY (assignment_id);


--
-- Name: teachers teachers_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_email_key UNIQUE (email);


--
-- Name: teachers teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (teacher_id);


--
-- Name: course_requests unique_course_school_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_requests
    ADD CONSTRAINT unique_course_school_group UNIQUE (course_id, school_id, "group");


--
-- Name: users user_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_id PRIMARY KEY (user_id) INCLUDE (user_id);


--
-- Name: years years_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.years
    ADD CONSTRAINT years_pkey PRIMARY KEY (year_id);


--
-- Name: fki_assignment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_assignment_id ON public.course_requests USING btree (assignment_id);


--
-- Name: fki_course_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_course_id ON public.course_requests USING btree (course_id);


--
-- Name: fki_semester_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_semester_id ON public.courses USING btree (semester_id);


--
-- Name: course_requests assignment_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_requests
    ADD CONSTRAINT assignment_id FOREIGN KEY (assignment_id) REFERENCES public.teacher_course_assignments(assignment_id) NOT VALID;


--
-- Name: course_requests course_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_requests
    ADD CONSTRAINT course_id FOREIGN KEY (course_id) REFERENCES public.courses(course_id) NOT VALID;


--
-- Name: course_requests course_requests_school_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_requests
    ADD CONSTRAINT course_requests_school_id_fkey FOREIGN KEY (school_id) REFERENCES public.schools(school_id) ON DELETE CASCADE;


--
-- Name: teacher_course_assignments fk_course_request; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT fk_course_request FOREIGN KEY (course_request_id) REFERENCES public.course_requests(request_id) ON DELETE CASCADE;


--
-- Name: courses semester_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT semester_id FOREIGN KEY (semester_id) REFERENCES public.semesters(semester_id) NOT VALID;


--
-- Name: semesters semesters_year_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.semesters
    ADD CONSTRAINT semesters_year_id_fkey FOREIGN KEY (year_id) REFERENCES public.years(year_id) ON DELETE CASCADE;


--
-- Name: teacher_course_assignments teacher_course_assignments_semester_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT teacher_course_assignments_semester_id_fkey FOREIGN KEY (semester_id) REFERENCES public.semesters(semester_id) ON DELETE CASCADE;


--
-- Name: teacher_course_assignments teacher_course_assignments_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT teacher_course_assignments_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teachers(teacher_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

