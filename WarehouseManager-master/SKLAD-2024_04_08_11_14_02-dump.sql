--
-- PostgreSQL database dump
--

-- Dumped from database version 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)
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
    shelf_id bigint NOT NULL
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
    task_status_id bigint NOT NULL,
    task_type bigint NOT NULL,
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

INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (1, 'test', '$2a$12$waubTe7sgJtZ7mqsLOYpxucVUC93nV2F6.hkUh2q.q612.kEwxE9y', 1, 'test', 1);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (2, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/Test_Sklad', '$2a$10$YJ3QI5eXdKnZ.RWHm2P5TepH5i3kAS0sIVpyD6kcUkbI2EckEj1nO', 3, 'Test_Sklad', 2);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (3, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/man', '$2a$10$vEGA6LmGtokq/JTButucbe7eEKWGgDb1oa9byQpNJKhzTP0pa5ESK', 2, 'man', 3);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (4, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/qwerty', '$2a$10$jXNlyjNtBNRa6EZh52N8wOHQpGHTzLDseq6Th.j9n6mycBauvG1oy', 2, 'qwerty', 4);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (5, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/AvtoOtdel', '$2a$10$ZTyIGfKNrGBxeIFTkonEYelsLFb9pfowrAHdol0xHFM27HItRsBZu', 2, 'AvtoOtdel', 5);


--
-- Data for Name: constructor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.constructor (id, height, name, width) VALUES (1, 641, '01', 1360);
INSERT INTO public.constructor (id, height, name, width) VALUES (2, 641, '01', 1360);
INSERT INTO public.constructor (id, height, name, width) VALUES (3, 641, '01', 1360);
INSERT INTO public.constructor (id, height, name, width) VALUES (4, 945, 'Outside', 1920);
INSERT INTO public.constructor (id, height, name, width) VALUES (5, 754, '02', 1440);
INSERT INTO public.constructor (id, height, name, width) VALUES (6, 754, '02', 1440);
INSERT INTO public.constructor (id, height, name, width) VALUES (7, 754, '02', 1440);
INSERT INTO public.constructor (id, height, name, width) VALUES (8, 730, 'TestCheckName', 1536);


--
-- Data for Name: doorways; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.doorways (id, coordinate_x, coordinate_y, draggable, fill_pattern_image, height, name, opacity, rotation, width, constructor_id) VALUES (1, '407', '235.00000000000006', true, 'red', 19, 'door', 1, 0, 199, 4);
INSERT INTO public.doorways (id, coordinate_x, coordinate_y, draggable, fill_pattern_image, height, name, opacity, rotation, width, constructor_id) VALUES (2, '340.5999984741209', '141.59999847412104', true, 'red', 27, 'door', 1, 0, 199, 8);
INSERT INTO public.doorways (id, coordinate_x, coordinate_y, draggable, fill_pattern_image, height, name, opacity, rotation, width, constructor_id) VALUES (3, '359.5999984741207', '630.6000061035155', true, 'orange', 25, 'door', 1, 0, 162, 8);
INSERT INTO public.doorways (id, coordinate_x, coordinate_y, draggable, fill_pattern_image, height, name, opacity, rotation, width, constructor_id) VALUES (4, '627.2727272727276', '936.3636363636365', true, 'orange', 44, 'door', 1, 0, 94, 1);


--
-- Data for Name: item_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.item_attributes (id, cell_number, condition_type, nomenclature, quantity, shelf_level, units, uuid, shelf_id) VALUES (13, 45, '5db7f312-2c2f-11e5-802d-0025900c6161', '5db7f312-2c2f-11e5-802d-0025900c6161', 0, 5, '5db7f312-2c2f-11e5-802d-0025900c6161', '5db7f312-2c2f-11e5-802d-0025900c6161', 37);
INSERT INTO public.item_attributes (id, cell_number, condition_type, nomenclature, quantity, shelf_level, units, uuid, shelf_id) VALUES (14, 25, '5db7f312-2c2f-11e5-802d-0025900c6161', '5db7f312-2c2f-11e5-802d-0025900c6161', 100, 3, '5db7f312-2c2f-11e5-802d-0025900c6161', '5db7f312-2c2f-11e5-802d-0025900c6161', 46);
INSERT INTO public.item_attributes (id, cell_number, condition_type, nomenclature, quantity, shelf_level, units, uuid, shelf_id) VALUES (15, 15, '5db7f312-2c2f-11e5-802d-0025900c6161', '5db7f312-2c2f-11e5-802d-0025900c6161', 77, 2, '5db7f312-2c2f-11e5-802d-0025900c6161', '5db7f312-2c2f-11e5-802d-0025900c6161', 45);
INSERT INTO public.item_attributes (id, cell_number, condition_type, nomenclature, quantity, shelf_level, units, uuid, shelf_id) VALUES (16, 24, '56769a3a-6161-11e7-a23f-0025900c6161', '56769a3a-6161-11e7-a23f-0025900c6161', 55, 3, '56769a3a-6161-11e7-a23f-0025900c6161', '56769a3a-6161-11e7-a23f-0025900c6161', 38);
INSERT INTO public.item_attributes (id, cell_number, condition_type, nomenclature, quantity, shelf_level, units, uuid, shelf_id) VALUES (17, 23, '56769a3a-6161-11e7-a23f-0025900c6161', '56769a3a-6161-11e7-a23f-0025900c6161', 22, 3, '56769a3a-6161-11e7-a23f-0025900c6161', '56769a3a-6161-11e7-a23f-0025900c6161', 39);
INSERT INTO public.item_attributes (id, cell_number, condition_type, nomenclature, quantity, shelf_level, units, uuid, shelf_id) VALUES (18, 2, '92fd389b-edec-11e6-8069-0025900c6161', '92fd389b-edec-11e6-8069-0025900c6161', 10, 1, '92fd389b-edec-11e6-8069-0025900c6161', '92fd389b-edec-11e6-8069-0025900c6161', 43);
INSERT INTO public.item_attributes (id, cell_number, condition_type, nomenclature, quantity, shelf_level, units, uuid, shelf_id) VALUES (19, 29, '5db7f312-2c2f-11e5-802d-0025900c6161', '5db7f312-2c2f-11e5-802d-0025900c6161', 55, 4, '5db7f312-2c2f-11e5-802d-0025900c6161', '5db7f312-2c2f-11e5-802d-0025900c6161', 38);
INSERT INTO public.item_attributes (id, cell_number, condition_type, nomenclature, quantity, shelf_level, units, uuid, shelf_id) VALUES (20, 6, '5db7f312-2c2f-11e5-802d-0025900c6161', '5db7f312-2c2f-11e5-802d-0025900c6161', 10, 1, '5db7f312-2c2f-11e5-802d-0025900c6161', '5db7f312-2c2f-11e5-802d-0025900c6161', 63);
INSERT INTO public.item_attributes (id, cell_number, condition_type, nomenclature, quantity, shelf_level, units, uuid, shelf_id) VALUES (21, 0, '492adb2f-a9bd-11e3-94f3-0025900c6161', 'Зеркало', 5, 2, '492adb2f-a9bd-11e3-94f3-0025900c6161', '492adb2f-a9bd-11e3-94f3-0025900c6161', 37);
INSERT INTO public.item_attributes (id, cell_number, condition_type, nomenclature, quantity, shelf_level, units, uuid, shelf_id) VALUES (22, 0, '4ffe5a6f-a048-11e4-806e-0025900c6161', '4ffe5a6f-a048-11e4-806e-0025900c6161', 2, 1, '4ffe5a6f-a048-11e4-806e-0025900c6161', '4ffe5a6f-a048-11e4-806e-0025900c6161', 73);


--
-- Data for Name: shelves; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (7, 0, 0, 0, 0, '216.81741465692974', '143.77393639606004', true, 'gray', 26.35589428147588, 'shelv', 1, 0, '1', 0, 1, 26.35589428147584, 2);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (9, 0, 0, 0, 0, '244.64350161345112', '148.1217624830163', true, 'gray', 12, 'shelv', 1, 0, '2', 0, 1, 12, 2);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (12, 0, 0, 0, 0, '0', '0', true, 'gray', 12, 'shelv', 1, 0, '1', 0, 1, 12, 3);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (15, 0, 0, 0, 0, '0', '0', true, 'gray', 12, 'shelv', 1, 0, '1', 0, 1, 12, 3);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (18, 0, 0, 0, 0, '216.81741465692974', '143.77393639606004', true, 'gray', 26.35589428147588, 'shelv', 1, 0, '1', 0, 1, 26.35589428147584, 3);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (20, 0, 0, 0, 0, '244.64350161345112', '148.1217624830163', true, 'gray', 12, 'shelv', 1, 0, '2', 0, 1, 12, 3);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (21, 0, 0, 0, 0, '216.81741465692974', '143.77393639606004', true, 'gray', 26.35589428147588, 'shelv', 1, 0, '1', 0, 1, 26.35589428147584, 2);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (23, 0, 0, 0, 0, '0', '0', true, 'gray', 12, 'shelv', 1, 0, '1', 0, 1, 12, 3);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (24, 0, 0, 0, 0, '244.64350161345112', '148.1217624830163', true, 'gray', 12, 'shelv', 1, 0, '2', 0, 1, 12, 2);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (26, 0, 0, 0, 0, '0', '0', true, 'gray', 12, 'shelv', 1, 0, '1', 0, 1, 12, 3);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (28, 0, 0, 0, 0, '216.81741465692974', '143.77393639606004', true, 'gray', 26.35589428147588, 'shelv', 1, 0, '1', 0, 1, 26.35589428147584, 3);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (29, 0, 0, 0, 0, '244.64350161345112', '148.1217624830163', true, 'gray', 12, 'shelv', 1, 0, '2', 0, 1, 12, 3);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (30, 0, 0, 0, 0, '0', '0', true, 'gray', 12, 'shelv', 1, 0, '1', 0, 1, 12, 2);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (31, 0, 0, 0, 0, '0', '0', true, 'gray', 12, 'shelv', 1, 0, '1', 0, 1, 12, 3);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (32, 0, 0, 0, 0, '0', '0', true, 'gray', 12, 'shelv', 1, 0, '1', 0, 1, 12, 3);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (33, 0, 0, 0, 0, '216.81741465692974', '143.77393639606004', true, 'gray', 26.35589428147588, 'shelv', 1, 0, '1', 0, 1, 26.35589428147584, 2);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (34, 0, 0, 0, 0, '216.81741465692974', '143.77393639606004', true, 'gray', 26.35589428147588, 'shelv', 1, 0, '1', 0, 1, 26.35589428147584, 3);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (35, 0, 0, 0, 0, '244.64350161345112', '148.1217624830163', true, 'gray', 12, 'shelv', 1, 0, '2', 0, 1, 12, 2);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (37, 0, 0, 3, 3, '270', '311', true, 'gray', 45, 'shelv', 1, 300, '2.1.5', 0, 5, 45, 4);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (38, 0, 0, 3, 3, '315', '311', true, 'gray', 45, 'shelv', 1, 300, '2.2.5', 0, 5, 45, 4);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (39, 0, 0, 3, 3, '360', '311', true, 'gray', 45, 'shelv', 1, 300, '2.3.5', 0, 5, 45, 4);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (40, 0, 0, 3, 3, '405', '311', true, 'gray', 45, 'shelv', 1, 300, '2.4.5', 0, 5, 45, 4);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (41, 0, 0, 3, 3, '450', '311', true, 'gray', 45, 'shelv', 1, 300, '2.5.5', 0, 5, 45, 4);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (42, 0, 0, 3, 3, '495', '311', true, 'gray', 45, 'shelv', 1, 300, '2.6.5', 0, 5, 45, 4);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (43, 0, 0, 3, 3, '540', '311', true, 'gray', 45, 'shelv', 1, 300, '2.7.5', 0, 5, 45, 4);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (44, 0, 0, 3, 3, '585', '311', true, 'gray', 45, 'shelv', 1, 300, '2.8.5', 0, 5, 45, 4);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (45, 0, 0, 3, 3, '630', '311', true, 'gray', 45, 'shelv', 1, 300, '2.9.5', 0, 5, 45, 4);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (46, 0, 0, 3, 3, '675', '311', true, 'gray', 45, 'shelv', 1, 300, '2.10.5', 0, 5, 45, 4);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (47, 0, 0, 0, 0, '03', '0-1', true, 'gray', 12, 'shelv', 1, 0, '1', 0, 1, 12, 3);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (48, 0, 0, 0, 0, '72.5', '47.5', true, 'gray', 12, 'shelv', 1, 0, '1.1', 0, 1, 12, 5);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (49, 0, 0, 0, 0, '72.50000000000013', '47.50000000000001', true, 'gray', 12.000000000000004, 'shelv', 1, 0, '1.1', 0, 1, 11.374999999999872, 6);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (50, 0, 0, 0, 0, '84.375', '47.50000000000005', true, 'gray', 12.944498736746569, 'shelv', 1, 0, '1.2', 0, 1, 12.944498736746572, 6);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (63, 0, 0, 3, 3, '269.5999984741211', '220.5999984741211', true, 'gray', 45, 'shelv', 1, 300, '4.1.5', 0, 5, 45, 8);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (64, 0, 0, 3, 3, '269.5999984741211', '265.5999984741211', true, 'gray', 45, 'shelv', 1, 300, '4.2.5', 0, 5, 45, 8);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (65, 0, 0, 3, 3, '269.5999984741211', '310.5999984741211', true, 'gray', 45, 'shelv', 1, 300, '4.3.5', 0, 5, 45, 8);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (66, 0, 0, 3, 3, '269.5999984741211', '355.5999984741211', true, 'gray', 45, 'shelv', 1, 300, '4.4.5', 0, 5, 45, 8);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (67, 0, 0, 3, 3, '269.5999984741211', '400.5999984741211', true, 'gray', 45, 'shelv', 1, 300, '4.5.5', 0, 5, 45, 8);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (68, 0, 0, 3, 3, '359.5999984741211', '220.5999984741211', true, 'gray', 45, 'shelv', 1, 300, '3.1.5', 0, 5, 45, 8);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (69, 0, 0, 3, 3, '404.5999984741211', '220.5999984741211', true, 'gray', 45, 'shelv', 1, 300, '3.2.5', 0, 5, 45, 8);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (70, 0, 0, 3, 3, '449.5999984741211', '220.5999984741211', true, 'gray', 45, 'shelv', 1, 300, '3.3.5', 0, 5, 45, 8);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (71, 0, 0, 3, 3, '494.5999984741211', '220.5999984741211', true, 'gray', 45, 'shelv', 1, 300, '3.4.5', 0, 5, 45, 8);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (72, 0, 0, 3, 3, '539.5999984741211', '220.5999984741211', true, 'gray', 45, 'shelv', 1, 300, '3.5.5', 0, 5, 45, 8);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (73, 0, 0, 0, 0, '136.51300713490147', '88.68997915770669', true, 'gray', 45, 'shelv', 1, 0, 'A1.1', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (74, 0, 0, 0, 0, '180.6434975353161', '88.68997915770669', true, 'gray', 45, 'shelv', 1, 0, 'A1.2', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (90, 0, 0, 0, 0, '134.53684102018784', '134.53684102018784', true, 'gray', 45, 'shelv', 1, 0, 'A2.1', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (91, 0, 0, 0, 0, '179.53684102018784', '132.7187756009961', true, 'gray', 45, 'shelv', 1, 0, 'A2.2', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (92, 0, 0, 0, 0, '224.5368410201878', '132.71877560099608', true, 'gray', 45, 'shelv', 1, 0, 'A2.3', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (93, 0, 0, 0, 0, '269.5368410201878', '132.7187756009961', true, 'gray', 45, 'shelv', 1, 0, 'A2.4', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (94, 0, 0, 0, 0, '316.35490643937953', '132.7187756009961', true, 'gray', 45, 'shelv', 1, 0, 'A2.5', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (95, 0, 0, 0, 0, '359.5368410201878', '132.7187756009961', true, 'gray', 45, 'shelv', 1, 0, 'A2.6', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (96, 0, 0, 0, 0, '404.53684102018786', '132.7187756009961', true, 'gray', 45, 'shelv', 1, 0, 'A2.7', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (97, 0, 0, 0, 0, '449.53684102018786', '134.53684102018784', true, 'gray', 45, 'shelv', 1, 0, 'A2.8', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (98, 0, 0, 0, 0, '494.53684102018786', '134.53684102018784', true, 'gray', 45, 'shelv', 1, 0, 'A2.9', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (99, 0, 0, 0, 0, '539.5368410201878', '132.7187756009961', true, 'gray', 45, 'shelv', 1, 0, 'A2.10', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (100, 0, 0, 0, 0, '584.5368410201879', '134.53684102018784', true, 'gray', 45, 'shelv', 1, 0, 'A2.11', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (101, 0, 0, 0, 0, '631.3549064393795', '134.53684102018784', true, 'gray', 45, 'shelv', 1, 0, 'A2.12', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (103, 0, 0, 0, 0, '721.3549064393795', '134.53684102018784', true, 'gray', 45, 'shelv', 1, 0, 'A2.14', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (104, 0, 0, 0, 0, '764.5368410201878', '134.53684102018784', true, 'gray', 45, 'shelv', 1, 0, 'A2.15', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (105, 0, 0, 0, 0, '809.5368410201879', '132.7187756009961', true, 'gray', 45, 'shelv', 1, 0, 'A2.16', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (106, 0, 0, 0, 0, '852.7187756009961', '132.7187756009961', true, 'gray', 45, 'shelv', 1, 0, 'A2.17', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (113, 0, 0, 0, 0, NULL, NULL, true, 'gray', 0, 'shelv', 1, 0, '1', 0, 1, 0, 2);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (114, 0, 0, 0, 0, '216.8174146569297445781011121416181921222427293033343739.99999999999997NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', '143.7739363960600445781011131516192022232426272930313334NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', true, 'gray', 26.35589428147588, 'shelv', 1, 0, '1', 0, 1, 26.35589428147584, 3);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (115, 0, 0, 0, 0, '670.6435016134509', '205.12176248301617', true, 'gray', 205.99999999999972, 'shelv', 1, 0, '2', 0, 1, 113.00000000000051, 3);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (116, 0, 0, 0, 0, '136.5130071349014700NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', '88.6899791577066968.999999999999986NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', true, 'gray', 45, 'shelv', 1, 0, 'A1.1', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (117, 0, 0, 0, 0, NULL, NULL, true, 'gray', 0, 'shelv', 1, 0, 'A1.2', 0, 1, 0, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (118, 0, 0, 0, 0, '134.53684102018784-2NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', '134.53684102018784-5NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', true, 'gray', 45, 'shelv', 1, 0, 'A2.1', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (119, 0, 0, 0, 0, '179.53684102018784-2NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', '132.7187756009961-3NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', true, 'gray', 45, 'shelv', 1, 0, 'A2.2', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (120, 0, 0, 0, 0, '224.53684102018783NaNNaNNaNNaNNaNNaNNaN', '132.71877560099608-2NaNNaNNaNNaNNaNNaNNaN', true, 'gray', 45, 'shelv', 1, 0, 'A2.3', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (121, 0, 0, 0, 0, '404.53684102018786-1NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', '132.71877560099616NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', true, 'gray', 45, 'shelv', 1, 0, 'A2.7', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (122, 0, 0, 0, 0, NULL, NULL, true, 'gray', 0, 'shelv', 1, 0, 'A2.15', 0, 1, 0, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (123, 0, 0, 0, 0, '269.5368410201878-3NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', '132.71877560099610NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', true, 'gray', 45, 'shelv', 1, 0, 'A2.4', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (124, 0, 0, 0, 0, '316.35490643937953-3NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', '132.71877560099610NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', true, 'gray', 45, 'shelv', 1, 0, 'A2.5', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (125, 0, 0, 0, 0, '359.5368410201878-4NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', '132.7187756009961-4NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', true, 'gray', 45, 'shelv', 1, 0, 'A2.6', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (126, 0, 0, 0, 0, '404.53684102018786-4NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', '132.7187756009961-5NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', true, 'gray', 45, 'shelv', 1, 0, 'A2.7', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (127, 0, 0, 0, 0, '449.53684102018786-3NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', '134.53684102018784-1NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', true, 'gray', 45, 'shelv', 1, 0, 'A2.8', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (128, 0, 0, 0, 0, '494.53684102018786-4NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', '134.53684102018784-2NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', true, 'gray', 45, 'shelv', 1, 0, 'A2.9', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (129, 0, 0, 0, 0, '539.5368410201878-3NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', '132.71877560099610NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', true, 'gray', 45, 'shelv', 1, 0, 'A2.10', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (130, 0, 0, 0, 0, '584.5368410201879-3NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', '134.53684102018784-1NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', true, 'gray', 45, 'shelv', 1, 0, 'A2.11', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (131, 0, 0, 0, 0, '631.3549064393795-3NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', '134.536841020187840NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', true, 'gray', 45, 'shelv', 1, 0, 'A2.12', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (132, 0, 0, 0, 0, '721.3549064393795-3NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', '134.536841020187840NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', true, 'gray', 45, 'shelv', 1, 0, 'A2.14', 0, 1, 45, 1);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (133, 0, 0, 0, 0, '224.53684102018783NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', '132.71877560099608-2NaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaNNaN', true, 'gray', 45, 'shelv', 1, 0, 'A2.3', 0, 1, 45, 1);


--
-- Data for Name: task_nomenclature; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.task_nomenclature (id, item_attribute_id, task_id) VALUES (74, 18, 46);
INSERT INTO public.task_nomenclature (id, item_attribute_id, task_id) VALUES (82, 13, 66);
INSERT INTO public.task_nomenclature (id, item_attribute_id, task_id) VALUES (83, 14, 66);
INSERT INTO public.task_nomenclature (id, item_attribute_id, task_id) VALUES (84, 15, 66);
INSERT INTO public.task_nomenclature (id, item_attribute_id, task_id) VALUES (85, 19, 66);
INSERT INTO public.task_nomenclature (id, item_attribute_id, task_id) VALUES (86, 20, 66);
INSERT INTO public.task_nomenclature (id, item_attribute_id, task_id) VALUES (87, 22, 69);


--
-- Data for Name: task_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.task_status (id, name) VALUES (9, 'active');
INSERT INTO public.task_status (id, name) VALUES (10, 'in_process');
INSERT INTO public.task_status (id, name) VALUES (11, 'waiting_confirm');
INSERT INTO public.task_status (id, name) VALUES (12, 'confirmed');
INSERT INTO public.task_status (id, name) VALUES (13, 'closed');


--
-- Data for Name: task_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.task_types (id, name) VALUES (1, 'acceptance');
INSERT INTO public.task_types (id, name) VALUES (2, 'shipment');
INSERT INTO public.task_types (id, name) VALUES (3, 'movement');
INSERT INTO public.task_types (id, name) VALUES (4, 'receipt_from_warehouse');
INSERT INTO public.task_types (id, name) VALUES (5, 'write_off');
INSERT INTO public.task_types (id, name) VALUES (6, 'exchange');
INSERT INTO public.task_types (id, name) VALUES (7, 'return');
INSERT INTO public.task_types (id, name) VALUES (8, 'inventory');


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (46, '', '2024-03-12 16:05:01.530721', '2024-03-12 16:19:06.996967', 4, 13, 1, 4);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (50, '', '2024-04-05 10:11:04.448326', NULL, 1, 9, 1, 2);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (52, '', '2024-04-05 10:24:15.704869', NULL, 1, 9, 1, 2);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (53, '', '2024-04-05 10:24:33.60958', NULL, 2, 9, 1, 1);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (54, '', '2024-04-05 10:25:01.551555', NULL, 2, 9, 2, 2);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (56, '', '2024-04-05 10:46:33.287755', NULL, 4, 9, 7, 1);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (57, '', '2024-04-05 10:47:01.874268', NULL, 2, 9, 4, 2);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (58, '', '2024-04-05 10:47:19.383248', NULL, 2, 9, 5, 1);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (41, '', '2024-03-12 07:42:11.491507', '2024-04-05 12:32:31.491532', 2, 13, 4, 2);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (64, '', '2024-04-05 12:36:31.822515', '2024-04-05 12:38:29.158179', 4, 13, 1, 5);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (61, '', '2024-04-05 12:25:06.633359', '2024-04-05 12:38:32.962227', 1, 13, 1, 2);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (47, '', '2024-03-13 12:37:07.420294', '2024-04-05 12:38:39.56041', 4, 13, 1, 1);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (48, '', '2024-03-19 15:13:12.385529', '2024-04-05 12:38:42.360139', 4, 13, 1, 1);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (49, '', '2024-04-02 06:03:14.58154', '2024-04-05 12:38:45.607371', 1, 13, 3, 1);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (65, '', '2024-04-05 12:39:43.682379', '2024-04-05 12:40:04.545632', 1, 11, 4, 1);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (55, '', '2024-04-05 10:45:42.202044', '2024-04-05 12:40:08.819181', 4, 11, 2, 1);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (44, '', '2024-03-12 12:07:34.641273', '2024-04-05 12:41:00.554217', 4, 11, 1, 3);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (66, '', '2024-04-07 06:13:20.935809', NULL, 8, 9, 1, 3);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (67, '', '2024-04-07 23:47:59.695439', NULL, 4, 9, 1, 1);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (62, '', '2024-04-05 12:31:20.170766', '2024-04-07 23:48:20.757691', 1, 13, 1, 1);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (45, '', '2024-03-12 12:10:56.186607', '2024-04-07 23:48:25.895622', 4, 13, 1, 2);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (68, '', '2024-04-07 23:49:38.8473', '2024-04-08 00:14:06.052856', 4, 11, 1, 1);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (60, '', '2024-04-05 12:16:17.207998', '2024-04-08 00:14:10.759767', 4, 10, 1, 1);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (59, '', '2024-04-05 12:14:47.463658', '2024-04-08 00:14:21.599083', 4, 10, 1, 2);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id) VALUES (69, '', '2024-04-08 05:15:01.021171', NULL, 1, 9, 1, 4);


--
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_role (id, role) VALUES (1, 'ADMINISTRATOR');
INSERT INTO public.user_role (id, role) VALUES (2, 'STOREKEEPER');
INSERT INTO public.user_role (id, role) VALUES (3, 'WAREHOUSE_MANAGER');
INSERT INTO public.user_role (id, role) VALUES (4, 'FORKLIFT_DRIVER');
INSERT INTO public.user_role (id, role) VALUES (5, 'LOADER');
INSERT INTO public.user_role (id, role) VALUES (6, 'WAREHOUSE_AUDITOR');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (1, 'Администратор', 'Куантай', NULL, 'Тылеп');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (2, 'Кладовщик', 'Аркадий', '', 'Паровозов');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (3, 'Заведующий складом', 'Man', 'Manovich', 'Manov');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (4, 'Заведующий складом', 'qwerty', 'qwerty', 'qwerty');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (5, 'Заведующий складом', 'Avtom', '', 'Otdel');


--
-- Data for Name: walls; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (2, '134.7826086956522', '130.43478260869566', true, 'black', 12.000000000000014, 'wall', 1, 0, 379.82608695652186, 2);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (4, '127.8260869565219', '127.82608695652173', true, 'black', 260.69565217391306, 'wall', 1, 0, 12.00000000000001, 2);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (7, '127.82608695652183', '377.3913043478261', true, 'black', 12.000000000000007, 'wall', 1, 0, 383.3043478260869, 2);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (8, '502.60869565217394', '133.0434782608696', true, 'black', 12, 'wall', 1, 0, 12, 2);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (9, '134.7826086956522', '130.43478260869566', true, 'black', 12.000000000000014, 'wall', 1, 0, 379.82608695652186, 2);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (10, '127.8260869565219', '127.82608695652173', true, 'black', 260.69565217391306, 'wall', 1, 0, 12.00000000000001, 2);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (11, '127.82608695652183', '377.3913043478261', true, 'black', 12.000000000000007, 'wall', 1, 0, 383.3043478260869, 2);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (12, '502.60869565217394', '133.0434782608696', true, 'black', 12, 'wall', 1, 0, 12, 2);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (13, '134.7826086956522', '130.43478260869566', true, 'black', 12.000000000000014, 'wall', 1, 0, 379.82608695652186, 3);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (14, '127.8260869565219', '127.82608695652173', true, 'black', 260.69565217391306, 'wall', 1, 0, 12.00000000000001, 3);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (15, '127.82608695652183', '377.3913043478261', true, 'black', 12.000000000000007, 'wall', 1, 0, 383.3043478260869, 3);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (16, '502.60869565217394', '133.0434782608696', true, 'black', 12, 'wall', 1, 0, 12, 3);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (17, '134.7826086956522', '130.43478260869566', true, 'black', 12.000000000000014, 'wall', 1, 0, 379.82608695652186, 3);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (18, '127.8260869565219', '127.82608695652173', true, 'black', 260.69565217391306, 'wall', 1, 0, 12.00000000000001, 3);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (19, '127.82608695652183', '377.3913043478261', true, 'black', 12.000000000000007, 'wall', 1, 0, 383.3043478260869, 3);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (20, '502.60869565217394', '133.0434782608696', true, 'black', 12, 'wall', 1, 0, 12, 3);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (21, '134.7826086956522', '130.43478260869566', true, 'black', 12.000000000000014, 'wall', 1, 0, 379.82608695652186, 3);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (22, '127.8260869565219', '127.82608695652173', true, 'black', 260.69565217391306, 'wall', 1, 0, 12.00000000000001, 3);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (23, '127.82608695652183', '377.3913043478261', true, 'black', 12.000000000000007, 'wall', 1, 0, 383.3043478260869, 3);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (24, '502.60869565217394', '133.0434782608696', true, 'black', 12, 'wall', 1, 0, 12, 3);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (26, '178.99999999999972', '219.99999999999974', true, 'black', 533.0000000000002, 'wall', 1, 0, 44.99999999999998, 4);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (27, '196.00000000000006', '222.99999999999997', true, 'black', 44.99999999999997, 'wall', 1, 0, 613, 4);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (28, '765.0000000000001', '243.00000000000006', true, 'black', 514.0000000000001, 'wall', 1, 0, 44.99999999999999, 4);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (29, '201.00000000000028', '707.9999999999994', true, 'black', 45.00000000000001, 'wall', 1, 0, 594.0000000000005, 4);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (30, '178.99999999999937', '226.99999999999974', true, 'black', 525.9999999999978, 'wall', 1, 0, 44.999999999999936, 4);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (31, '179', '223.00000000000003', true, 'black', 45, 'wall', 1, 0, 630.9999999999994, 4);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (32, '764.9999999999993', '243.00000000000017', true, 'black', 510, 'wall', 1, 0, 44.99999999999998, 4);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (33, '60.3463442496799', '35.12499999999983', true, 'black', 300.47134424967976, 'wall', 1, 0, 6.2500000000000835, 5);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (34, '59.764327875159324', '41.48567212483985', true, 'black', 300.471344249681, 'wall', 1, -89, 6.250000000000085, 5);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (37, '354.375', '37.49999999999999', true, 'black', 302.97134424967976, 'wall', 1, 0, 6.250000000000082, 5);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (39, '298.67143056810534', '336.1731721248385', true, 'black', 238.59460269294618, 'wall', 1, 89, 6.316134506741527, 5);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (40, '60.3463442496799', '35.12499999999983', true, 'black', 300.47134424967976, 'wall', 1, 0, 6.2500000000000835, 6);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (41, '59.764327875159324', '41.48567212483985', true, 'black', 300.471344249681, 'wall', 1, -89, 6.250000000000085, 6);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (42, '0', '0', true, 'black', 300.471344249681, 'wall', 1, -89, 6.250000000000085, 6);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (43, '0', '0', true, 'black', 300.471344249681, 'wall', 1, -89, 6.250000000000085, 6);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (44, '354.375', '37.49999999999999', true, 'black', 302.97134424967976, 'wall', 1, 0, 6.250000000000082, 6);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (45, '0', '0', true, 'black', 300.471344249681, 'wall', 1, -89, 6.250000000000085, 6);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (46, '298.67143056810534', '336.1731721248385', true, 'black', 238.59460269294618, 'wall', 1, 89, 6.316134506741527, 6);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (54, '179.99999999999991', '132.99999999999986', true, 'black', 44.99999999999996, 'wall', 1, 0, 495.00000000000006, 8);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (55, '180.59999847412087', '155.59999847412135', true, 'black', 377.99999999999955, 'wall', 1, 0, 44.999999999999964, 8);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (56, '187.59999847412115', '486.5999984741215', true, 'black', 44.999999999999936, 'wall', 1, 0, 487.99999999999966, 8);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (57, '629.5999984741209', '158.5999984741212', true, 'black', 352.99999999999943, 'wall', 1, 0, 44.99999999999999, 8);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (58, '179.59999847412098', '619.6000061035148', true, 'black', 44.99999999999995, 'wall', 1, 0, 496.0000000000002, 8);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (59, '179.59999847412115', '975.6000061035144', true, 'black', 45.07428001608082, 'wall', 1, 0, 494.8154295098646, 8);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (60, '179.5999984741211', '635.6000061035157', true, 'black', 367.9999999999996, 'wall', 1, 0, 44.999999999999964, 8);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (61, '629.5999984741201', '625.6000061035163', true, 'black', 379.00000000000006, 'wall', 1, 0, 44.999999999999964, 8);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (62, '117.57142857142875', '88.14285714285711', true, 'black', 885.5714285714287, 'wall', 1, 0, 16.000000000000096, 1);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (63, '117.14285714285695', '69.99999999999993', true, 'black', 17.857142857142737, 'wall', 1, 0, 798.6335403726698, 1);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (64, '899.5031055900628', '88.81987577639751', true, 'black', 887.3987154150198, 'wall', 1, 0, 16.304347826086776, 1);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (65, '134.54545454545433', '954.5454545454556', true, 'black', 21.36363636363685, 'wall', 1, 0, 492.2727272727271, 1);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (66, '721.8181818181823', '960.8522727272717', true, 'black', 17.4431818181814, 'wall', 1, 0, 179.54545454545502, 1);


--
-- Data for Name: windows; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.windows (id, coordinate_x, coordinate_y, draggable, fill_pattern_image, height, name, opacity, rotation, width, constructor_id) VALUES (1, '423.99999999999994', '722.0000000000001', true, 'orange', 22, 'window', 1, 0, 144, 4);
INSERT INTO public.windows (id, coordinate_x, coordinate_y, draggable, fill_pattern_image, height, name, opacity, rotation, width, constructor_id) VALUES (3, '355.59999847412126', '495.5999984741211', true, 'orange', 29, 'window', 1, 0, 144, 8);
INSERT INTO public.windows (id, coordinate_x, coordinate_y, draggable, fill_pattern_image, height, name, opacity, rotation, width, constructor_id) VALUES (4, '361.59999847412075', '987.6000061035155', true, '#fff', 21, 'window', 1, 0, 145, 8);
INSERT INTO public.windows (id, coordinate_x, coordinate_y, draggable, fill_pattern_image, height, name, opacity, rotation, width, constructor_id) VALUES (5, '171.38339920948607', '73.59683794466405', true, '#fff', 9, 'window', 1, 0, 144, 1);
INSERT INTO public.windows (id, coordinate_x, coordinate_y, draggable, fill_pattern_image, height, name, opacity, rotation, width, constructor_id) VALUES (6, '665.4545454545454', '72.72727272727268', true, '#fff', 12, 'window', 1, 0, 144, 1);


--
-- Data for Name: zone_shelves; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: zones; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (3, '139.99999999999983', '141.7391304347824', 'test123123', true, '#80f532', 234.52702059862168, 'zone', 0.5, 0, 'ГП', 75.39658581601313, 2);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (5, '216.52173913043484', '142.6086956521739', 'test123123', true, '#43128c', 44.99999999999999, 'zone', 0.5, 0, 'Химия', 289.3478260869564, 2);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (6, '139.99999999999983', '141.7391304347824', 'test123123', true, '#80f532', 234.52702059862168, 'zone', 0.5, 0, 'ГП', 75.39658581601313, 2);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (8, '216.52173913043484', '142.6086956521739', 'test123123', true, '#43128c', 44.99999999999999, 'zone', 0.5, 0, 'Химия', 289.3478260869564, 2);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (9, '139.99999999999983', '141.7391304347824', 'test123123', true, '#80f532', 234.52702059862168, 'zone', 0.5, 0, 'ГП', 75.39658581601313, 2);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (11, '216.52173913043484', '142.6086956521739', 'test123123', true, '#43128c', 44.99999999999999, 'zone', 0.5, 0, 'Химия', 289.3478260869564, 2);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (13, '139.99999999999983', '141.7391304347824', 'test123123', true, '#80f532', 234.52702059862168, 'zone', 0.5, 0, 'ГП', 75.39658581601313, 3);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (14, '216.52173913043484', '142.6086956521739', 'test123123', true, '#43128c', 44.99999999999999, 'zone', 0.5, 0, 'Химия', 289.3478260869564, 3);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (15, '139.99999999999983', '141.7391304347824', 'test123123', true, '#80f532', 234.52702059862168, 'zone', 0.5, 0, 'ГП', 75.39658581601313, 3);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (16, '216.52173913043484', '142.6086956521739', 'test123123', true, '#43128c', 44.99999999999999, 'zone', 0.5, 0, 'Химия', 289.3478260869564, 3);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (17, '139.99999999999983', '141.7391304347824', 'test123123', true, '#80f532', 234.52702059862168, 'zone', 0.5, 0, 'ГП', 75.39658581601313, 3);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (20, '236.00000000000009', '278.99999999999966', 'test123123', true, '#ff0000', 337.68689346275886, 'zone', 0.5, 0, 'Food', 514.0505298263955, 4);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (21, '66.24999999999996', '40.62499999999999', 'test123123', true, '#ae2929', 90.62500000000001, 'zone', 0.5, 0, 'Продукты', 288.12500000000006, 5);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (22, '65.62499999999991', '249.37499999999986', 'test123123', true, '#29ae38', 86.87499999999977, 'zone', 0.5, 0, 'Химия', 233.75000000000006, 5);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (23, '66.24999999999996', '40.62499999999999', 'test123123', true, '#ae2929', 90.62500000000001, 'zone', 0.5, 0, 'Продукты', 288.12500000000006, 6);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (24, '65.62499999999991', '249.37499999999986', 'test123123', true, '#29ae38', 86.87499999999977, 'zone', 0.5, 0, 'Химия', 233.75000000000006, 6);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (27, '247.061114385144', '200.06111438514486', 'CheckTestZone', true, '#0008ff', 270.57031153153173, 'zone', 0.5, 0, 'CheckTestZone', 364.5703115315322, 8);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (28, '270.5999984741206', '707.600006103514', 'CheckTestName', true, '#fa0000', 225.0000000000018, 'zone', 0.5, 0, 'CheckTestName', 313.99999999999994, 8);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (33, '133.9999999999988', '90.00000000000018', 'test123123', true, '#00ff00', 134.4772350137451, 'zone', 0.5, 0, 'sadsad', 609.4772350137422, 1);


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 5, true);


--
-- Name: constructor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.constructor_id_seq', 8, true);


--
-- Name: doorways_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doorways_id_seq', 4, true);


--
-- Name: item_attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_attributes_id_seq', 22, true);


--
-- Name: shelves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shelves_id_seq', 133, true);


--
-- Name: task_nomenclature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_nomenclature_id_seq', 87, true);


--
-- Name: task_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_status_id_seq', 13, true);


--
-- Name: task_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_types_id_seq', 8, true);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tasks_id_seq', 69, true);


--
-- Name: user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_role_id_seq', 6, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: walls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.walls_id_seq', 66, true);


--
-- Name: windows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.windows_id_seq', 6, true);


--
-- Name: zone_shelves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.zone_shelves_id_seq', 1, false);


--
-- Name: zones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.zones_id_seq', 33, true);


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

