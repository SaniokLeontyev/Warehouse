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
    task_status_id bigint NOT NULL,
    task_type bigint NOT NULL,
    user_id bigint,
    creator_id integer NOT NULL
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

INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (2, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/Test_Sklad', '$2a$10$YJ3QI5eXdKnZ.RWHm2P5TepH5i3kAS0sIVpyD6kcUkbI2EckEj1nO', 3, 'Test_Sklad', 2);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (3, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/man', '$2a$10$vEGA6LmGtokq/JTButucbe7eEKWGgDb1oa9byQpNJKhzTP0pa5ESK', 2, 'man', 3);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (5, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/AvtoOtdel', '$2a$10$ZTyIGfKNrGBxeIFTkonEYelsLFb9pfowrAHdol0xHFM27HItRsBZu', 2, 'AvtoOtdel', 5);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (1, 'test', '$2a$10$l7AqsFMyNCriyDUYrQGWdOzBYWMm.WXj5J3wo9ESk1LQc.Saa6fbG', 1, 'test', 1);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (6, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/test', '$2a$10$8i8W1Q7/FDYAGjPcJE6kSeXghoAeQC/3120CO/iFPjYhJugDwEMSC', 1, 'test2', 6);


--
-- Data for Name: constructor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.constructor (id, height, name, width) VALUES (12, 912, 'Main', 1920);


--
-- Data for Name: doorways; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.doorways (id, coordinate_x, coordinate_y, draggable, fill_pattern_image, height, name, opacity, rotation, width, constructor_id) VALUES (5, '421', '188', true, 'red', 20, 'door', 1, 0, 199, 12);


--
-- Data for Name: item_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.item_attributes (id, cell_number, condition_type, nomenclature, quantity, shelf_level, units, uuid, shelf_id) VALUES (37, 0, '5db7f312-2c2f-11e5-802d-0025900c6161', 'Бизнес Ланч', 100, 1, '5db7f312-2c2f-11e5-802d-0025900c6161', '5db7f312-2c2f-11e5-802d-0025900c6161', 135);
INSERT INTO public.item_attributes (id, cell_number, condition_type, nomenclature, quantity, shelf_level, units, uuid, shelf_id) VALUES (39, 2, 'e918335b-2c5a-11e5-802d-0025900c6161', 'Акция Maxi Чай зеленый Лимон 1,20 ПЭТ 6 штуп (17+2 ОПТ)', 100, 1, 'e918335b-2c5a-11e5-802d-0025900c6161', 'e918335b-2c5a-11e5-802d-0025900c6161', 140);
INSERT INTO public.item_attributes (id, cell_number, condition_type, nomenclature, quantity, shelf_level, units, uuid, shelf_id) VALUES (38, 2, 'e918335b-2c5a-11e5-802d-0025900c6161', 'Акция Maxi Чай зеленый Лимон 1,20 ПЭТ 6 штуп (17+2 ОПТ)', 100, 0, 'e918335b-2c5a-11e5-802d-0025900c6161', 'e918335b-2c5a-11e5-802d-0025900c6161', NULL);


--
-- Data for Name: shelves; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (145, 0, 0, 2, 2, '269', '266', true, 'gray', 45, 'shelv', 1, 300, '1.1.5', 0, 5, 45, 12);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (146, 0, 0, 2, 2, '315', '266', true, 'gray', 45, 'shelv', 1, 300, '1.2.5', 0, 5, 45, 12);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (147, 0, 0, 2, 2, '360', '266', true, 'gray', 45, 'shelv', 1, 300, '1.3.5', 0, 5, 45, 12);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (148, 0, 0, 2, 2, '404', '266', true, 'gray', 45, 'shelv', 1, 300, '1.4.5', 0, 5, 45, 12);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (149, 0, 0, 2, 2, '449', '266', true, 'gray', 45, 'shelv', 1, 300, '1.5.5', 0, 5, 45, 12);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (135, 0, 0, 2, 2, '269', '264', true, 'gray', 45, 'shelv', 1, 300, '1.1.5', 0, 5, 45, 12);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (140, 0, 0, 2, 4, '270', '354', true, 'gray', 45, 'shelv', 1, 300, '2.1.3', 0, 3, 45, 12);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (141, 0, 0, 2, 4, '270', '399', true, 'gray', 45, 'shelv', 1, 300, '2.2.3', 0, 3, 45, 12);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (142, 0, 0, 2, 4, '270', '444', true, 'gray', 45, 'shelv', 1, 300, '2.3.3', 0, 3, 45, 12);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (143, 0, 0, 2, 4, '270', '489', true, 'gray', 45, 'shelv', 1, 300, '2.4.3', 0, 3, 45, 12);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (144, 0, 0, 2, 4, '270', '534', true, 'gray', 45, 'shelv', 1, 300, '2.5.3', 0, 3, 45, 12);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (150, 0, 0, 2, 2, '540', '268', true, 'gray', 45, 'shelv', 1, 300, '1.5.5', 0, 5, 45, 12);


--
-- Data for Name: task_nomenclature; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.task_nomenclature (id, item_attribute_id, task_id) VALUES (91, 37, 78);
INSERT INTO public.task_nomenclature (id, item_attribute_id, task_id) VALUES (92, 38, 79);


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

INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id, creator_id) VALUES (78, '', '2024-04-14 18:32:55.322973', NULL, 12, 9, 1, 2, 6);
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id, creator_id) VALUES (79, '', '2024-04-14 18:33:35.941264', '2024-04-15 01:59:03.499008', 12, 11, 2, 3, 6);


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

INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (2, 'Кладовщик', 'Аркадий', '', 'Паровозов');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (3, 'Заведующий складом', 'Man', 'Manovich', 'Manov');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (5, 'Заведующий складом', 'Avtom', '', 'Otdel');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (6, 'Кладовщик', 'Testing UPDATE', 'test', 'TESTING');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (1, 'Кладовщик', 'Testing UPDATE22', 'test', 'TESTING');


--
-- Data for Name: walls; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (72, '179.0000000000001', '177.99999999999974', true, 'black', 44.999999999999964, 'wall', 1, 0, 631.9999999999998, 12);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (73, '179.99999999999986', '204.00000000000023', true, 'black', 506.99999999999955, 'wall', 1, 0, 44.999999999999964, 12);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (74, '186.99999999999972', '665.0000000000001', true, 'black', 44.999999999999964, 'wall', 1, 0, 623.0000000000003, 12);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (75, '764.9999999999999', '198', true, 'black', 495.9999999999998, 'wall', 1, 0, 44.99999999999999, 12);


--
-- Data for Name: windows; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.windows (id, coordinate_x, coordinate_y, draggable, fill_pattern_image, height, name, opacity, rotation, width, constructor_id) VALUES (7, '446.99999999999994', '674.9999999999999', true, 'orange', 24, 'window', 1, 0, 144, 12);


--
-- Data for Name: zone_shelves; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: zones; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (34, '238.6113937019238', '245.6113937019234', 'zone test description', true, '#8607ca', 376.57650985494286, 'zone', 0.5, 0, 'zone', 280.5765098549427, 12);


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 7, true);


--
-- Name: constructor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.constructor_id_seq', 12, true);


--
-- Name: doorways_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doorways_id_seq', 5, true);


--
-- Name: item_attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_attributes_id_seq', 39, true);


--
-- Name: shelves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shelves_id_seq', 150, true);


--
-- Name: task_nomenclature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_nomenclature_id_seq', 92, true);


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

SELECT pg_catalog.setval('public.tasks_id_seq', 79, true);


--
-- Name: user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_role_id_seq', 6, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 7, true);


--
-- Name: walls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.walls_id_seq', 75, true);


--
-- Name: windows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.windows_id_seq', 7, true);


--
-- Name: zone_shelves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.zone_shelves_id_seq', 1, false);


--
-- Name: zones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.zones_id_seq', 34, true);


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
-- Name: tasks tasks_creator_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_creator_fk FOREIGN KEY (creator_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

