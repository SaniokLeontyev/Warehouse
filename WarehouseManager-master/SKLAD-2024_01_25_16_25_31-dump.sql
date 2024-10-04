--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 13.3

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
-- Name: warehouse; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE warehouse WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';


ALTER DATABASE warehouse OWNER TO postgres;

\connect warehouse

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
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    id bigint NOT NULL,
    document character varying(255),
    password character varying(255),
    role_id bigint,
    username character varying(255),
    user_id bigint
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_id_seq OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- Name: constructor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.constructor (
    id bigint NOT NULL,
    height integer NOT NULL,
    name character varying(255),
    width integer NOT NULL
);


ALTER TABLE public.constructor OWNER TO postgres;

--
-- Name: constructor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.constructor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.constructor_id_seq OWNER TO postgres;

--
-- Name: constructor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.constructor_id_seq OWNED BY public.constructor.id;


--
-- Name: doorways; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doorways (
    id bigint NOT NULL,
    coordinate_x character varying(255),
    coordinate_y character varying(255),
    draggable boolean NOT NULL,
    fill_pattern_image character varying(255),
    height integer NOT NULL,
    name character varying(255),
    opacity double precision NOT NULL,
    rotation integer NOT NULL,
    width integer NOT NULL,
    constructor_id bigint
);


ALTER TABLE public.doorways OWNER TO postgres;

--
-- Name: doorways_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.doorways_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.doorways_id_seq OWNER TO postgres;

--
-- Name: doorways_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doorways_id_seq OWNED BY public.doorways.id;


--
-- Name: item_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_attributes (
    id bigint NOT NULL,
    cell_number integer,
    condition_type character varying(255),
    nomenclature character varying(255),
    quantity integer NOT NULL,
    shelf_level integer,
    units character varying(255),
    uuid character varying(255),
    shelf_id bigint
);


ALTER TABLE public.item_attributes OWNER TO postgres;

--
-- Name: item_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_attributes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_attributes_id_seq OWNER TO postgres;

--
-- Name: item_attributes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_attributes_id_seq OWNED BY public.item_attributes.id;


--
-- Name: shelves; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shelves (
    id bigint NOT NULL,
    cell_height double precision,
    cell_width double precision,
    cells_per_depth integer,
    cells_per_width integer,
    coordinate_x character varying(255),
    coordinate_y character varying(255),
    draggable boolean NOT NULL,
    fill character varying(255),
    height double precision NOT NULL,
    name character varying(255),
    opacity integer NOT NULL,
    rack_height integer,
    rack_id character varying(255),
    rotation integer NOT NULL,
    shelf_level integer,
    width double precision NOT NULL,
    constructor_id bigint
);


ALTER TABLE public.shelves OWNER TO postgres;

--
-- Name: shelves_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shelves_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shelves_id_seq OWNER TO postgres;

--
-- Name: shelves_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shelves_id_seq OWNED BY public.shelves.id;


--
-- Name: task_nomenclature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_nomenclature (
    id bigint NOT NULL,
    item_attribute_id bigint,
    task_id bigint
);


ALTER TABLE public.task_nomenclature OWNER TO postgres;

--
-- Name: task_nomenclature_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_nomenclature_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_nomenclature_id_seq OWNER TO postgres;

--
-- Name: task_nomenclature_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_nomenclature_id_seq OWNED BY public.task_nomenclature.id;


--
-- Name: task_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_status (
    id bigint NOT NULL,
    name character varying(255)
);


ALTER TABLE public.task_status OWNER TO postgres;

--
-- Name: task_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_status_id_seq OWNER TO postgres;

--
-- Name: task_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_status_id_seq OWNED BY public.task_status.id;


--
-- Name: task_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_types (
    id bigint NOT NULL,
    name character varying(255)
);


ALTER TABLE public.task_types OWNER TO postgres;

--
-- Name: task_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_types_id_seq OWNER TO postgres;

--
-- Name: task_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_types_id_seq OWNED BY public.task_types.id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    id bigint NOT NULL,
    comments text,
    create_date timestamp without time zone,
    edit_date timestamp without time zone,
    constructor_id bigint,
    task_status_id bigint,
    task_type bigint,
    user_id bigint
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasks_id_seq OWNER TO postgres;

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: user_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role (
    id bigint NOT NULL,
    role character varying(255)
);


ALTER TABLE public.user_role OWNER TO postgres;

--
-- Name: user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_role_id_seq OWNER TO postgres;

--
-- Name: user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_role_id_seq OWNED BY public.user_role.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    job_title character varying(255),
    name character varying(255),
    patronymic character varying(255),
    surname character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: walls; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.walls (
    id bigint NOT NULL,
    coordinate_x character varying(255),
    coordinate_y character varying(255),
    draggable boolean NOT NULL,
    fill character varying(255),
    height double precision NOT NULL,
    name character varying(255),
    opacity double precision NOT NULL,
    rotation integer NOT NULL,
    width double precision NOT NULL,
    constructor_id bigint
);


ALTER TABLE public.walls OWNER TO postgres;

--
-- Name: walls_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.walls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.walls_id_seq OWNER TO postgres;

--
-- Name: walls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.walls_id_seq OWNED BY public.walls.id;


--
-- Name: windows; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.windows (
    id bigint NOT NULL,
    coordinate_x character varying(255),
    coordinate_y character varying(255),
    draggable boolean NOT NULL,
    fill_pattern_image character varying(255),
    height integer NOT NULL,
    name character varying(255),
    opacity double precision NOT NULL,
    rotation integer NOT NULL,
    width integer NOT NULL,
    constructor_id bigint
);


ALTER TABLE public.windows OWNER TO postgres;

--
-- Name: windows_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.windows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.windows_id_seq OWNER TO postgres;

--
-- Name: windows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.windows_id_seq OWNED BY public.windows.id;


--
-- Name: zone_shelves; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zone_shelves (
    id bigint NOT NULL,
    shelf_id bigint,
    zone_id bigint
);


ALTER TABLE public.zone_shelves OWNER TO postgres;

--
-- Name: zone_shelves_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.zone_shelves_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zone_shelves_id_seq OWNER TO postgres;

--
-- Name: zone_shelves_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.zone_shelves_id_seq OWNED BY public.zone_shelves.id;


--
-- Name: zones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zones (
    id bigint NOT NULL,
    coordinate_x character varying(255),
    coordinate_y character varying(255),
    description text,
    draggable boolean NOT NULL,
    fill character varying(255),
    height double precision NOT NULL,
    name character varying(255),
    opacity double precision NOT NULL,
    rotation integer NOT NULL,
    title character varying(255),
    width double precision NOT NULL,
    constructor_id bigint
);


ALTER TABLE public.zones OWNER TO postgres;

--
-- Name: zones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.zones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zones_id_seq OWNER TO postgres;

--
-- Name: zones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.zones_id_seq OWNED BY public.zones.id;


--
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- Name: constructor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.constructor ALTER COLUMN id SET DEFAULT nextval('public.constructor_id_seq'::regclass);


--
-- Name: doorways id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doorways ALTER COLUMN id SET DEFAULT nextval('public.doorways_id_seq'::regclass);


--
-- Name: item_attributes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_attributes ALTER COLUMN id SET DEFAULT nextval('public.item_attributes_id_seq'::regclass);


--
-- Name: shelves id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shelves ALTER COLUMN id SET DEFAULT nextval('public.shelves_id_seq'::regclass);


--
-- Name: task_nomenclature id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_nomenclature ALTER COLUMN id SET DEFAULT nextval('public.task_nomenclature_id_seq'::regclass);


--
-- Name: task_status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_status ALTER COLUMN id SET DEFAULT nextval('public.task_status_id_seq'::regclass);


--
-- Name: task_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_types ALTER COLUMN id SET DEFAULT nextval('public.task_types_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: user_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role ALTER COLUMN id SET DEFAULT nextval('public.user_role_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: walls id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.walls ALTER COLUMN id SET DEFAULT nextval('public.walls_id_seq'::regclass);


--
-- Name: windows id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.windows ALTER COLUMN id SET DEFAULT nextval('public.windows_id_seq'::regclass);


--
-- Name: zone_shelves id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zone_shelves ALTER COLUMN id SET DEFAULT nextval('public.zone_shelves_id_seq'::regclass);


--
-- Name: zones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zones ALTER COLUMN id SET DEFAULT nextval('public.zones_id_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (id, document, password, role_id, username, user_id) FROM stdin;
1	test	$2a$12$waubTe7sgJtZ7mqsLOYpxucVUC93nV2F6.hkUh2q.q612.kEwxE9y	1	test	1
\.


--
-- Data for Name: constructor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.constructor (id, height, name, width) FROM stdin;
1	641	01	1360
2	641	01	1360
3	641	01	1360
\.


--
-- Data for Name: doorways; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doorways (id, coordinate_x, coordinate_y, draggable, fill_pattern_image, height, name, opacity, rotation, width, constructor_id) FROM stdin;
\.


--
-- Data for Name: item_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_attributes (id, cell_number, condition_type, nomenclature, quantity, shelf_level, units, uuid, shelf_id) FROM stdin;
\.


--
-- Data for Name: shelves; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) FROM stdin;
3	0	0	0	0	0	0	t	gray	12	shelv	1	0	1	0	1	12	2
4	0	0	0	0	216.81741465692974	143.77393639606004	t	gray	26.35589428147588	shelv	1	0	1	0	1	26.35589428147584	1
5	0	0	0	0	0	0	t	gray	12	shelv	1	0	1	0	1	12	2
6	0	0	0	0	244.64350161345112	148.1217624830163	t	gray	12	shelv	1	0	2	0	1	12	1
7	0	0	0	0	216.81741465692974	143.77393639606004	t	gray	26.35589428147588	shelv	1	0	1	0	1	26.35589428147584	2
9	0	0	0	0	244.64350161345112	148.1217624830163	t	gray	12	shelv	1	0	2	0	1	12	2
11	0	0	0	0	216.81741465692974	143.77393639606004	t	gray	26.35589428147588	shelv	1	0	1	0	1	26.35589428147584	1
12	0	0	0	0	0	0	t	gray	12	shelv	1	0	1	0	1	12	3
13	0	0	0	0	0	0	t	gray	12	shelv	1	0	1	0	1	12	2
14	0	0	0	0	244.64350161345112	148.1217624830163	t	gray	12	shelv	1	0	2	0	1	12	1
15	0	0	0	0	0	0	t	gray	12	shelv	1	0	1	0	1	12	3
17	0	0	0	0	0	0	t	gray	12	shelv	1	0	1	0	1	12	2
18	0	0	0	0	216.81741465692974	143.77393639606004	t	gray	26.35589428147588	shelv	1	0	1	0	1	26.35589428147584	3
20	0	0	0	0	244.64350161345112	148.1217624830163	t	gray	12	shelv	1	0	2	0	1	12	3
21	0	0	0	0	216.81741465692974	143.77393639606004	t	gray	26.35589428147588	shelv	1	0	1	0	1	26.35589428147584	2
22	0	0	0	0	216.81741465692974	143.77393639606004	t	gray	26.35589428147588	shelv	1	0	1	0	1	26.35589428147584	1
23	0	0	0	0	0	0	t	gray	12	shelv	1	0	1	0	1	12	3
24	0	0	0	0	244.64350161345112	148.1217624830163	t	gray	12	shelv	1	0	2	0	1	12	2
25	0	0	0	0	244.64350161345112	148.1217624830163	t	gray	12	shelv	1	0	2	0	1	12	1
26	0	0	0	0	0	0	t	gray	12	shelv	1	0	1	0	1	12	3
27	0	0	0	0	0	0	t	gray	12	shelv	1	0	1	0	1	12	2
28	0	0	0	0	216.81741465692974	143.77393639606004	t	gray	26.35589428147588	shelv	1	0	1	0	1	26.35589428147584	3
29	0	0	0	0	244.64350161345112	148.1217624830163	t	gray	12	shelv	1	0	2	0	1	12	3
30	0	0	0	0	0	0	t	gray	12	shelv	1	0	1	0	1	12	2
31	0	0	0	0	0	0	t	gray	12	shelv	1	0	1	0	1	12	3
32	0	0	0	0	0	0	t	gray	12	shelv	1	0	1	0	1	12	3
33	0	0	0	0	216.81741465692974	143.77393639606004	t	gray	26.35589428147588	shelv	1	0	1	0	1	26.35589428147584	2
34	0	0	0	0	216.81741465692974	143.77393639606004	t	gray	26.35589428147588	shelv	1	0	1	0	1	26.35589428147584	3
35	0	0	0	0	244.64350161345112	148.1217624830163	t	gray	12	shelv	1	0	2	0	1	12	2
36	0	0	0	0	244.64350161345112	148.1217624830163	t	gray	12	shelv	1	0	2	0	1	12	3
\.


--
-- Data for Name: task_nomenclature; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_nomenclature (id, item_attribute_id, task_id) FROM stdin;
\.


--
-- Data for Name: task_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_status (id, name) FROM stdin;
\.


--
-- Data for Name: task_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_types (id, name) FROM stdin;
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) FROM stdin;
\.


--
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role (id, role) FROM stdin;
1	ADMINISTRATOR
2	STOREKEEPER
3	WAREHOUSE_MANAGER
4	FORKLIFT_DRIVER
5	LOADER
6	WAREHOUSE_AUDITOR
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, job_title, name, patronymic, surname) FROM stdin;
1	Администратор	Куантай	\N	Тылеп
\.


--
-- Data for Name: walls; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) FROM stdin;
1	134.7826086956522	130.43478260869566	t	black	12.000000000000014	wall	1	0	379.82608695652186	1
2	134.7826086956522	130.43478260869566	t	black	12.000000000000014	wall	1	0	379.82608695652186	2
3	127.8260869565219	127.82608695652173	t	black	260.69565217391306	wall	1	0	12.00000000000001	1
4	127.8260869565219	127.82608695652173	t	black	260.69565217391306	wall	1	0	12.00000000000001	2
5	127.82608695652183	377.3913043478261	t	black	12.000000000000007	wall	1	0	383.3043478260869	1
6	502.60869565217394	133.0434782608696	t	black	12	wall	1	0	12	1
7	127.82608695652183	377.3913043478261	t	black	12.000000000000007	wall	1	0	383.3043478260869	2
8	502.60869565217394	133.0434782608696	t	black	12	wall	1	0	12	2
9	134.7826086956522	130.43478260869566	t	black	12.000000000000014	wall	1	0	379.82608695652186	2
10	127.8260869565219	127.82608695652173	t	black	260.69565217391306	wall	1	0	12.00000000000001	2
11	127.82608695652183	377.3913043478261	t	black	12.000000000000007	wall	1	0	383.3043478260869	2
12	502.60869565217394	133.0434782608696	t	black	12	wall	1	0	12	2
13	134.7826086956522	130.43478260869566	t	black	12.000000000000014	wall	1	0	379.82608695652186	3
14	127.8260869565219	127.82608695652173	t	black	260.69565217391306	wall	1	0	12.00000000000001	3
15	127.82608695652183	377.3913043478261	t	black	12.000000000000007	wall	1	0	383.3043478260869	3
16	502.60869565217394	133.0434782608696	t	black	12	wall	1	0	12	3
17	134.7826086956522	130.43478260869566	t	black	12.000000000000014	wall	1	0	379.82608695652186	3
18	127.8260869565219	127.82608695652173	t	black	260.69565217391306	wall	1	0	12.00000000000001	3
19	127.82608695652183	377.3913043478261	t	black	12.000000000000007	wall	1	0	383.3043478260869	3
20	502.60869565217394	133.0434782608696	t	black	12	wall	1	0	12	3
21	134.7826086956522	130.43478260869566	t	black	12.000000000000014	wall	1	0	379.82608695652186	3
22	127.8260869565219	127.82608695652173	t	black	260.69565217391306	wall	1	0	12.00000000000001	3
23	127.82608695652183	377.3913043478261	t	black	12.000000000000007	wall	1	0	383.3043478260869	3
24	502.60869565217394	133.0434782608696	t	black	12	wall	1	0	12	3
25	494.99999999999994	134.00000000000003	t	black	200	wall	1	0	16.00000000000008	1
\.


--
-- Data for Name: windows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.windows (id, coordinate_x, coordinate_y, draggable, fill_pattern_image, height, name, opacity, rotation, width, constructor_id) FROM stdin;
\.


--
-- Data for Name: zone_shelves; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.zone_shelves (id, shelf_id, zone_id) FROM stdin;
\.


--
-- Data for Name: zones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) FROM stdin;
1	139.99999999999983	141.7391304347824	test123123	t	#80f532	234.52702059862168	zone	0.5	0	ГП	75.39658581601313	1
2	216.52173913043484	142.6086956521739	test123123	t	#43128c	44.99999999999999	zone	0.5	0	Химия	289.3478260869564	1
3	139.99999999999983	141.7391304347824	test123123	t	#80f532	234.52702059862168	zone	0.5	0	ГП	75.39658581601313	2
4	139.99999999999983	141.7391304347824	test123123	t	#80f532	234.52702059862168	zone	0.5	0	ГП	75.39658581601313	1
5	216.52173913043484	142.6086956521739	test123123	t	#43128c	44.99999999999999	zone	0.5	0	Химия	289.3478260869564	2
6	139.99999999999983	141.7391304347824	test123123	t	#80f532	234.52702059862168	zone	0.5	0	ГП	75.39658581601313	2
7	216.52173913043484	142.6086956521739	test123123	t	#43128c	44.99999999999999	zone	0.5	0	Химия	289.3478260869564	1
8	216.52173913043484	142.6086956521739	test123123	t	#43128c	44.99999999999999	zone	0.5	0	Химия	289.3478260869564	2
9	139.99999999999983	141.7391304347824	test123123	t	#80f532	234.52702059862168	zone	0.5	0	ГП	75.39658581601313	2
10	139.99999999999983	141.7391304347824	test123123	t	#80f532	234.52702059862168	zone	0.5	0	ГП	75.39658581601313	1
11	216.52173913043484	142.6086956521739	test123123	t	#43128c	44.99999999999999	zone	0.5	0	Химия	289.3478260869564	2
12	216.52173913043484	142.6086956521739	test123123	t	#43128c	44.99999999999999	zone	0.5	0	Химия	289.3478260869564	1
13	139.99999999999983	141.7391304347824	test123123	t	#80f532	234.52702059862168	zone	0.5	0	ГП	75.39658581601313	3
14	216.52173913043484	142.6086956521739	test123123	t	#43128c	44.99999999999999	zone	0.5	0	Химия	289.3478260869564	3
15	139.99999999999983	141.7391304347824	test123123	t	#80f532	234.52702059862168	zone	0.5	0	ГП	75.39658581601313	3
16	216.52173913043484	142.6086956521739	test123123	t	#43128c	44.99999999999999	zone	0.5	0	Химия	289.3478260869564	3
17	139.99999999999983	141.7391304347824	test123123	t	#80f532	234.52702059862168	zone	0.5	0	ГП	75.39658581601313	3
18	216.52173913043484	142.6086956521739	test123123	t	#43128c	44.99999999999999	zone	0.5	0	Химия	289.3478260869564	3
\.


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 1, true);


--
-- Name: constructor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.constructor_id_seq', 3, true);


--
-- Name: doorways_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doorways_id_seq', 1, false);


--
-- Name: item_attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_attributes_id_seq', 1, false);


--
-- Name: shelves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shelves_id_seq', 36, true);


--
-- Name: task_nomenclature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_nomenclature_id_seq', 1, false);


--
-- Name: task_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_status_id_seq', 1, false);


--
-- Name: task_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_types_id_seq', 1, false);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tasks_id_seq', 1, false);


--
-- Name: user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_role_id_seq', 6, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: walls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.walls_id_seq', 25, true);


--
-- Name: windows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.windows_id_seq', 1, false);


--
-- Name: zone_shelves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.zone_shelves_id_seq', 1, false);


--
-- Name: zones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.zones_id_seq', 18, true);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: constructor constructor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.constructor
    ADD CONSTRAINT constructor_pkey PRIMARY KEY (id);


--
-- Name: doorways doorways_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doorways
    ADD CONSTRAINT doorways_pkey PRIMARY KEY (id);


--
-- Name: item_attributes item_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_attributes
    ADD CONSTRAINT item_attributes_pkey PRIMARY KEY (id);


--
-- Name: shelves shelves_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shelves
    ADD CONSTRAINT shelves_pkey PRIMARY KEY (id);


--
-- Name: task_nomenclature task_nomenclature_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_nomenclature
    ADD CONSTRAINT task_nomenclature_pkey PRIMARY KEY (id);


--
-- Name: task_status task_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_status
    ADD CONSTRAINT task_status_pkey PRIMARY KEY (id);


--
-- Name: task_types task_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_types
    ADD CONSTRAINT task_types_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: user_role user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: walls walls_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.walls
    ADD CONSTRAINT walls_pkey PRIMARY KEY (id);


--
-- Name: windows windows_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.windows
    ADD CONSTRAINT windows_pkey PRIMARY KEY (id);


--
-- Name: zone_shelves zone_shelves_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zone_shelves
    ADD CONSTRAINT zone_shelves_pkey PRIMARY KEY (id);


--
-- Name: zones zones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zones
    ADD CONSTRAINT zones_pkey PRIMARY KEY (id);


--
-- Name: tasks fk28wihl2wapg7bfo9jklxg8y0u; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk28wihl2wapg7bfo9jklxg8y0u FOREIGN KEY (constructor_id) REFERENCES public.constructor(id);


--
-- Name: tasks fk6s1ob9k4ihi75xbxe2w0ylsdh; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk6s1ob9k4ihi75xbxe2w0ylsdh FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: task_nomenclature fk9w80wv9v9n0t40s0dhf2dvqxa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_nomenclature
    ADD CONSTRAINT fk9w80wv9v9n0t40s0dhf2dvqxa FOREIGN KEY (task_id) REFERENCES public.tasks(id);


--
-- Name: shelves fk9xhe0ttmhluaolj98t3seppqo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shelves
    ADD CONSTRAINT fk9xhe0ttmhluaolj98t3seppqo FOREIGN KEY (constructor_id) REFERENCES public.constructor(id);


--
-- Name: zones fkbgssaadnvvq8lg0a838rvvg69; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zones
    ADD CONSTRAINT fkbgssaadnvvq8lg0a838rvvg69 FOREIGN KEY (constructor_id) REFERENCES public.constructor(id);


--
-- Name: tasks fke3ebe6kjret8akcdil10eh2wc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fke3ebe6kjret8akcdil10eh2wc FOREIGN KEY (task_status_id) REFERENCES public.task_status(id);


--
-- Name: zone_shelves fkf81tmb9naltibf6g383fa13t; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zone_shelves
    ADD CONSTRAINT fkf81tmb9naltibf6g383fa13t FOREIGN KEY (zone_id) REFERENCES public.zones(id);


--
-- Name: task_nomenclature fkk449wjaeniab9d6piy6ew2v4q; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_nomenclature
    ADD CONSTRAINT fkk449wjaeniab9d6piy6ew2v4q FOREIGN KEY (item_attribute_id) REFERENCES public.item_attributes(id);


--
-- Name: item_attributes fkkiscd7kytaa4r9jmlqv23se3h; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_attributes
    ADD CONSTRAINT fkkiscd7kytaa4r9jmlqv23se3h FOREIGN KEY (shelf_id) REFERENCES public.shelves(id);


--
-- Name: zone_shelves fkm4ykioqoh6h61qd56iym526v1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zone_shelves
    ADD CONSTRAINT fkm4ykioqoh6h61qd56iym526v1 FOREIGN KEY (shelf_id) REFERENCES public.shelves(id);


--
-- Name: windows fkn99x8wwmryolst72tp3ovh32j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.windows
    ADD CONSTRAINT fkn99x8wwmryolst72tp3ovh32j FOREIGN KEY (constructor_id) REFERENCES public.constructor(id);


--
-- Name: accounts fknjuop33mo69pd79ctplkck40n; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT fknjuop33mo69pd79ctplkck40n FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: doorways fknomiql980nrv75vxm3wmxeseo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doorways
    ADD CONSTRAINT fknomiql980nrv75vxm3wmxeseo FOREIGN KEY (constructor_id) REFERENCES public.constructor(id);


--
-- Name: tasks fkon71enw59brg8uvnm0dqbiq6i; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fkon71enw59brg8uvnm0dqbiq6i FOREIGN KEY (task_type) REFERENCES public.task_types(id);


--
-- Name: walls fktmmd6kgimlrfg87p8u53l6jjx; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.walls
    ADD CONSTRAINT fktmmd6kgimlrfg87p8u53l6jjx FOREIGN KEY (constructor_id) REFERENCES public.constructor(id);


--
-- PostgreSQL database dump complete
--

