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
-- Name: item_attr_shelves; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_attr_shelves (
    id integer NOT NULL,
    shelf_level integer,
    cell_number integer,
    quantity_on_shelf integer,
    shelf_id integer,
    item_attr_id integer
);


ALTER TABLE public.item_attr_shelves OWNER TO postgres;

--
-- Name: item_attr_shelves_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_attr_shelves_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_attr_shelves_id_seq OWNER TO postgres;

--
-- Name: item_attr_shelves_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_attr_shelves_id_seq OWNED BY public.item_attr_shelves.id;


--
-- Name: item_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_attributes (
    id bigint NOT NULL,
    condition_type character varying(255),
    nomenclature character varying(255),
    units character varying(255),
    uuid character varying(255),
    quantity integer,
    start_date timestamp without time zone,
    end_date timestamp without time zone
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
-- Name: nomenclature_hist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nomenclature_hist (
    id integer NOT NULL,
    condition_type character varying(255),
    nomenclature character varying(255),
    units character varying(255),
    uuid character varying(255),
    start_date timestamp without time zone,
    end_date timestamp without time zone
);


ALTER TABLE public.nomenclature_hist OWNER TO postgres;

--
-- Name: nomenclature_hist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nomenclature_hist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nomenclature_hist_id_seq OWNER TO postgres;

--
-- Name: nomenclature_hist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nomenclature_hist_id_seq OWNED BY public.nomenclature_hist.id;


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
-- Name: task_file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_file (
    id integer NOT NULL,
    task_id integer,
    file character varying(255)
);


ALTER TABLE public.task_file OWNER TO postgres;

--
-- Name: task_file_hist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_file_hist (
    id integer NOT NULL,
    task_id integer,
    file character varying(255)
);


ALTER TABLE public.task_file_hist OWNER TO postgres;

--
-- Name: task_file_hist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_file_hist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_file_hist_id_seq OWNER TO postgres;

--
-- Name: task_file_hist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_file_hist_id_seq OWNED BY public.task_file_hist.id;


--
-- Name: task_file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_file_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_file_id_seq OWNER TO postgres;

--
-- Name: task_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_file_id_seq OWNED BY public.task_file.id;


--
-- Name: task_hist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_hist (
    id integer NOT NULL,
    comments text,
    create_date timestamp without time zone,
    edit_date timestamp without time zone,
    task_type character varying(255),
    task_status character varying(255),
    user_name character varying(255),
    user_surname character varying(255),
    user_patronymic character varying(255),
    manager_name character varying(255),
    manager_surname character varying(255),
    manager_patronymic character varying(255),
    uuid character varying(255),
    constructor_name character varying(255)
);


ALTER TABLE public.task_hist OWNER TO postgres;

--
-- Name: task_hist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_hist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_hist_id_seq OWNER TO postgres;

--
-- Name: task_hist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_hist_id_seq OWNED BY public.task_hist.id;


--
-- Name: task_nomenclature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_nomenclature (
    id bigint NOT NULL,
    item_attribute_shelf_id bigint,
    task_id bigint,
    quantity integer
);


ALTER TABLE public.task_nomenclature OWNER TO postgres;

--
-- Name: task_nomenclature_hist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_nomenclature_hist (
    id integer NOT NULL,
    nomenclature_id integer,
    task_id integer,
    quantity integer
);


ALTER TABLE public.task_nomenclature_hist OWNER TO postgres;

--
-- Name: task_nomenclature_hist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_nomenclature_hist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_nomenclature_hist_id_seq OWNER TO postgres;

--
-- Name: task_nomenclature_hist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_nomenclature_hist_id_seq OWNED BY public.task_nomenclature_hist.id;


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
    creator_id integer NOT NULL,
    uuid character varying NOT NULL
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
-- Name: item_attr_shelves id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_attr_shelves ALTER COLUMN id SET DEFAULT nextval('public.item_attr_shelves_id_seq'::regclass);


--
-- Name: item_attributes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_attributes ALTER COLUMN id SET DEFAULT nextval('public.item_attributes_id_seq'::regclass);


--
-- Name: nomenclature_hist id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenclature_hist ALTER COLUMN id SET DEFAULT nextval('public.nomenclature_hist_id_seq'::regclass);


--
-- Name: shelves id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shelves ALTER COLUMN id SET DEFAULT nextval('public.shelves_id_seq'::regclass);


--
-- Name: task_file id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_file ALTER COLUMN id SET DEFAULT nextval('public.task_file_id_seq'::regclass);


--
-- Name: task_file_hist id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_file_hist ALTER COLUMN id SET DEFAULT nextval('public.task_file_hist_id_seq'::regclass);


--
-- Name: task_hist id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_hist ALTER COLUMN id SET DEFAULT nextval('public.task_hist_id_seq'::regclass);


--
-- Name: task_nomenclature id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_nomenclature ALTER COLUMN id SET DEFAULT nextval('public.task_nomenclature_id_seq'::regclass);


--
-- Name: task_nomenclature_hist id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_nomenclature_hist ALTER COLUMN id SET DEFAULT nextval('public.task_nomenclature_hist_id_seq'::regclass);


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

INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (26, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/User3', '$2a$10$A3D5kQmABxsJyMhPN3yP8enhmOzqYiQ20EksUP3y0UZgOt1yoNIP.', 3, 'User3', 24);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (27, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/User4', '$2a$10$FMQToaz/7Jp3T6Ok7iTJK.JyS7ssLgk2BAms8fKZmC64/AcNlE5pa', 3, 'User4', 25);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (28, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/User5', '$2a$10$QcnNoEJr/617Vo9nA2bYbOMuDfgEtugsYfXfB4nhxLzZWM4w7XTHK', 5, 'User5', 26);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (29, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/User6', '$2a$10$312I71ltsmACLt68GqI9xutBaFYXJcGaKlKYIxkHxISE1Ja7RADK2', 5, 'User6', 27);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (30, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/User7', '$2a$10$Sl/eHq9KqNUvBjIS39pAz.0oMqO2R.U1h9P9qnxMrZIHYW7yRF.VC', 6, 'User7', 28);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (31, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/User8', '$2a$10$nCvQKY2LLo2UcjF2s9G0PumK2XAjExdGDx8XXo.DtyD6cBzy4v6ge', 6, 'User8', 29);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (1, 'test', '$2a$10$GZBx3aNaixxaQh5H3I2xLeobzXfesrte5KKpXplcCBfY75hrSpa9C', 1, 'test', 1);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (23, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/zavsklad1', '$2a$10$mW16FXpIRKnQJTP3ZbZwzOUg2vssBsdfCpXwDqxHuCfL9RHmy/61y', 2, 'zavsklad1', 21);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (24, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/user1', '$2a$10$.N/5MBHVznTArS7h1N4XLOV1gmH9LA2Fpiu5hVmrBreQ27uD.Bu2y', 3, 'user1', 22);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (25, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/User2', '$2a$10$8W2pnBY81ONU2AUSrg2TrenRZW8cTCRQo5ptvJxvi1tHjVp3zpNPG', 3, 'User2', 23);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (48, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/jason', '$2a$10$aWeEREuQZ2ARO7Q9od15t.1o73ltbLefEHXSwzGpdWXQ3uNriCtzu', 7, 'jason', 45);
INSERT INTO public.accounts (id, document, password, role_id, username, user_id) VALUES (49, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/marlen', '$2a$10$MedqEp0pylTtGGhOL7hfSOR8JxyQNq1iwmsjBzXRS646qFdGuTrsq', 6, 'marlen', 46);


--
-- Data for Name: constructor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.constructor (id, height, name, width) VALUES (50, 945, 'Test', 1920);


--
-- Data for Name: doorways; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.doorways (id, coordinate_x, coordinate_y, draggable, fill_pattern_image, height, name, opacity, rotation, width, constructor_id) VALUES (41, '177.12499999999994', '134.5', true, 'red', 6, 'door', 1, 0, 199, 50);


--
-- Data for Name: item_attr_shelves; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.item_attr_shelves (id, shelf_level, cell_number, quantity_on_shelf, shelf_id, item_attr_id) VALUES (72, 2, 6, 155, 698, 303);
INSERT INTO public.item_attr_shelves (id, shelf_level, cell_number, quantity_on_shelf, shelf_id, item_attr_id) VALUES (78, 1, 2, 0, 699, 310);


--
-- Data for Name: item_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.item_attributes (id, condition_type, nomenclature, units, uuid, quantity, start_date, end_date) VALUES (303, '5db7f312-2c2f-11e5-802d-0025900c6161', 'Бизнес Ланч', '5db7f312-2c2f-11e5-802d-0025900c6161', '5db7f312-2c2f-11e5-802d-0025900c6161', 170, '2024-05-30 00:00:00', '2024-07-07 00:00:00');
INSERT INTO public.item_attributes (id, condition_type, nomenclature, units, uuid, quantity, start_date, end_date) VALUES (310, 'e918335b-2c5a-11e5-802d-0025900c6161', 'Акция Maxi Чай зеленый Лимон 1,20 ПЭТ 6 штуп (17+2 ОПТ)', 'e918335b-2c5a-11e5-802d-0025900c6161', 'e918335b-2c5a-11e5-802d-0025900c6161', 200, '2024-07-02 00:00:00', '2024-07-30 00:00:00');


--
-- Data for Name: nomenclature_hist; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.nomenclature_hist (id, condition_type, nomenclature, units, uuid, start_date, end_date) VALUES (2, 'e918335b-2c5a-11e5-802d-0025900c6161', 'Акция Maxi Чай зеленый Лимон 1,20 ПЭТ 6 штуп (17+2 ОПТ)', 'e918335b-2c5a-11e5-802d-0025900c6161', 'e918335b-2c5a-11e5-802d-0025900c6161', '2024-05-27 00:00:00', '2024-07-01 00:00:00');
INSERT INTO public.nomenclature_hist (id, condition_type, nomenclature, units, uuid, start_date, end_date) VALUES (3, '5db7f312-2c2f-11e5-802d-0025900c6161', 'Бизнес Ланч', '5db7f312-2c2f-11e5-802d-0025900c6161', '5db7f312-2c2f-11e5-802d-0025900c6161', '2024-05-30 00:00:00', '2024-07-07 00:00:00');
INSERT INTO public.nomenclature_hist (id, condition_type, nomenclature, units, uuid, start_date, end_date) VALUES (4, '5db7f312-2c2f-11e5-802d-0025900c6161', 'Бизнес Ланч', '5db7f312-2c2f-11e5-802d-0025900c6161', '5db7f312-2c2f-11e5-802d-0025900c6161', '2024-05-30 00:00:00', '2024-07-07 00:00:00');
INSERT INTO public.nomenclature_hist (id, condition_type, nomenclature, units, uuid, start_date, end_date) VALUES (5, '5db7f312-2c2f-11e5-802d-0025900c6161', 'Бизнес Ланч', '5db7f312-2c2f-11e5-802d-0025900c6161', '5db7f312-2c2f-11e5-802d-0025900c6161', '2024-05-30 00:00:00', '2024-07-07 00:00:00');
INSERT INTO public.nomenclature_hist (id, condition_type, nomenclature, units, uuid, start_date, end_date) VALUES (6, '5db7f312-2c2f-11e5-802d-0025900c6161', 'Бизнес Ланч', '5db7f312-2c2f-11e5-802d-0025900c6161', '5db7f312-2c2f-11e5-802d-0025900c6161', '2024-05-30 00:00:00', '2024-07-07 00:00:00');
INSERT INTO public.nomenclature_hist (id, condition_type, nomenclature, units, uuid, start_date, end_date) VALUES (7, '5db7f312-2c2f-11e5-802d-0025900c6161', 'Бизнес Ланч', '5db7f312-2c2f-11e5-802d-0025900c6161', '5db7f312-2c2f-11e5-802d-0025900c6161', '2024-05-30 00:00:00', '2024-07-07 00:00:00');


--
-- Data for Name: shelves; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (701, 0, 0, 2, 4, '268.75', '179.125', true, 'gray', 45, 'shelv', 1, 500, '1.4.4', 0, 4, 45, 50);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (702, 0, 0, 2, 4, '315.625', '179.125', true, 'gray', 45, 'shelv', 1, 500, '1.5.4', 0, 4, 45, 50);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (698, 0, 0, 2, 4, '135', '176', true, 'gray', 45, 'shelv', 1, 500, '1.1.4', 0, 4, 45, 50);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (699, 0, 0, 2, 4, '181.25', '177.25', true, 'gray', 45, 'shelv', 1, 500, '1.2.4', 0, 4, 45, 50);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (700, 0, 0, 2, 4, '226.25', '178.5', true, 'gray', 45, 'shelv', 1, 500, '1.3.4', 0, 4, 45, 50);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (709, 0, 0, 2, 2, '133.75', '268', true, 'gray', 45, 'shelv', 1, 200, '2.1.3', 0, 3, 45, 50);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (710, 0, 0, 2, 2, '180.625', '266.75', true, 'gray', 45, 'shelv', 1, 200, '2.2.3', 0, 3, 45, 50);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (711, 0, 0, 2, 2, '225', '264.25', true, 'gray', 45, 'shelv', 1, 200, '2.3.3', 0, 3, 45, 50);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (712, 0, 0, 0, 0, '453', '176', true, 'gray', 45, 'shelv', 1, 0, '3.1', 0, 1, 45, 50);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (713, 0, 0, 0, 0, '497', '177', true, 'gray', 45, 'shelv', 1, 0, '3.2', 0, 1, 45, 50);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (714, 0, 0, 0, 0, '542', '176', true, 'gray', 45, 'shelv', 1, 0, '3.3', 0, 1, 45, 50);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (715, 0, 0, 0, 0, '449', '265', true, 'gray', 45, 'shelv', 1, 0, '3.4', 0, 1, 45, 50);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (716, 0, 0, 0, 0, '496', '264', true, 'gray', 45, 'shelv', 1, 0, '3.5', 0, 1, 45, 50);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (717, 0, 0, 0, 0, '542', '267', true, 'gray', 45, 'shelv', 1, 0, '3.6', 0, 1, 45, 50);
INSERT INTO public.shelves (id, cell_height, cell_width, cells_per_depth, cells_per_width, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rack_height, rack_id, rotation, shelf_level, width, constructor_id) VALUES (718, 0, 0, 0, 0, '450', '356', true, 'gray', 45, 'shelv', 1, 0, '6', 0, 1, 45, 50);


--
-- Data for Name: task_file; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.task_file (id, task_id, file) VALUES (74, 351, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/task_33a256cc-6c0a-44db-aae7-f43579a8a4cd');
INSERT INTO public.task_file (id, task_id, file) VALUES (75, 352, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/task_ac9e1cd2-c920-444b-8fc5-470927763981');
INSERT INTO public.task_file (id, task_id, file) VALUES (76, 353, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/task_331fa441-7b46-4223-ae8a-cc4b94c1d5b3');
INSERT INTO public.task_file (id, task_id, file) VALUES (77, 354, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/task_c94a5025-3f87-408b-b7b4-5646fb8a59d4');
INSERT INTO public.task_file (id, task_id, file) VALUES (78, 355, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/task_2e683ecc-4a5d-4855-94c6-fa95ddb1ce89');


--
-- Data for Name: task_file_hist; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.task_file_hist (id, task_id, file) VALUES (8, 8, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/task_de4b0dee-c602-491b-a161-92fc4f054905');
INSERT INTO public.task_file_hist (id, task_id, file) VALUES (9, 9, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/task_18638d56-758b-4c7b-b2a0-a82f42c3302f');
INSERT INTO public.task_file_hist (id, task_id, file) VALUES (10, 10, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/task_aa21a924-c909-4737-ad8d-5137a87f4b92');
INSERT INTO public.task_file_hist (id, task_id, file) VALUES (11, 11, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/task_b5e3aaaf-085f-47b8-908c-50a0df63651d');
INSERT INTO public.task_file_hist (id, task_id, file) VALUES (12, 12, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/task_cbd35479-9371-4a9f-b069-bea5f7a490e5');
INSERT INTO public.task_file_hist (id, task_id, file) VALUES (13, 13, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/task_ec55ff69-0a89-44d7-a228-528cc49ba990');
INSERT INTO public.task_file_hist (id, task_id, file) VALUES (14, 14, 'https://sklad01.s3.ap-northeast-2.amazonaws.com/task_61845936-e8c4-47aa-adde-dcf092478e6e');


--
-- Data for Name: task_hist; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.task_hist (id, comments, create_date, edit_date, task_type, task_status, user_name, user_surname, user_patronymic, manager_name, manager_surname, manager_patronymic, uuid, constructor_name) VALUES (8, NULL, '2024-06-25 01:21:25.7757', '2024-07-01 19:36:31.262605', 'write_off', 'closed', 'Testing UPDATE22', 'TESTING', 'test', 'Алла', 'Карцева ', 'Владимировна', 'de4b0dee-c602-491b-a161-92fc4f054905', 'Test');
INSERT INTO public.task_hist (id, comments, create_date, edit_date, task_type, task_status, user_name, user_surname, user_patronymic, manager_name, manager_surname, manager_patronymic, uuid, constructor_name) VALUES (9, 'TRATATA', '2024-07-01 19:43:58.376556', '2024-07-01 19:44:50.468345', 'write_off', 'closed', 'Testing UPDATE22', 'TESTING', 'test', 'Алла', 'Карцева ', 'Владимировна', '18638d56-758b-4c7b-b2a0-a82f42c3302f', 'Test');
INSERT INTO public.task_hist (id, comments, create_date, edit_date, task_type, task_status, user_name, user_surname, user_patronymic, manager_name, manager_surname, manager_patronymic, uuid, constructor_name) VALUES (10, 'TRATATA22', '2024-07-01 19:51:50.546794', '2024-07-01 19:52:06.073431', 'write_off', 'closed', 'Testing UPDATE22', 'TESTING', 'test', 'Алла', 'Карцева ', 'Владимировна', 'aa21a924-c909-4737-ad8d-5137a87f4b92', 'Test');
INSERT INTO public.task_hist (id, comments, create_date, edit_date, task_type, task_status, user_name, user_surname, user_patronymic, manager_name, manager_surname, manager_patronymic, uuid, constructor_name) VALUES (11, 'TRATATA33', '2024-07-01 19:53:37.459923', '2024-07-01 19:53:44.031455', 'write_off', 'closed', 'Testing UPDATE22', 'TESTING', 'test', 'Алла', 'Карцева ', 'Владимировна', 'b5e3aaaf-085f-47b8-908c-50a0df63651d', 'Test');
INSERT INTO public.task_hist (id, comments, create_date, edit_date, task_type, task_status, user_name, user_surname, user_patronymic, manager_name, manager_surname, manager_patronymic, uuid, constructor_name) VALUES (12, 'TRATATA4', '2024-07-01 19:55:37.801161', '2024-07-01 19:56:38.767574', 'write_off', 'closed', 'Testing UPDATE22', 'TESTING', 'test', 'Алла', 'Карцева ', 'Владимировна', 'cbd35479-9371-4a9f-b069-bea5f7a490e5', 'Test');
INSERT INTO public.task_hist (id, comments, create_date, edit_date, task_type, task_status, user_name, user_surname, user_patronymic, manager_name, manager_surname, manager_patronymic, uuid, constructor_name) VALUES (13, 'TRATATA55', '2024-07-01 19:58:41.841069', '2024-07-01 19:58:55.730504', 'write_off', 'closed', 'Testing UPDATE22', 'TESTING', 'test', 'Алла', 'Карцева ', 'Владимировна', 'ec55ff69-0a89-44d7-a228-528cc49ba990', 'Test');
INSERT INTO public.task_hist (id, comments, create_date, edit_date, task_type, task_status, user_name, user_surname, user_patronymic, manager_name, manager_surname, manager_patronymic, uuid, constructor_name) VALUES (14, 'TRATATA666', '2024-07-01 22:19:40.348109', '2024-07-07 22:11:35.289009', 'write_off', 'closed', 'Testovich', 'Test', 'Tect', 'Алла', 'Карцева ', 'Владимировна', '61845936-e8c4-47aa-adde-dcf092478e6e', 'Test');


--
-- Data for Name: task_nomenclature; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.task_nomenclature (id, item_attribute_shelf_id, task_id, quantity) VALUES (363, 72, 351, 155);
INSERT INTO public.task_nomenclature (id, item_attribute_shelf_id, task_id, quantity) VALUES (364, 78, 352, 200);
INSERT INTO public.task_nomenclature (id, item_attribute_shelf_id, task_id, quantity) VALUES (365, 78, 353, 200);
INSERT INTO public.task_nomenclature (id, item_attribute_shelf_id, task_id, quantity) VALUES (366, 72, 354, 155);
INSERT INTO public.task_nomenclature (id, item_attribute_shelf_id, task_id, quantity) VALUES (367, 78, 354, 0);
INSERT INTO public.task_nomenclature (id, item_attribute_shelf_id, task_id, quantity) VALUES (368, 78, 355, 0);
INSERT INTO public.task_nomenclature (id, item_attribute_shelf_id, task_id, quantity) VALUES (369, 72, 355, 155);


--
-- Data for Name: task_nomenclature_hist; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.task_nomenclature_hist (id, nomenclature_id, task_id, quantity) VALUES (3, 2, 8, 150);
INSERT INTO public.task_nomenclature_hist (id, nomenclature_id, task_id, quantity) VALUES (4, 3, 9, 150);
INSERT INTO public.task_nomenclature_hist (id, nomenclature_id, task_id, quantity) VALUES (5, 4, 10, 150);
INSERT INTO public.task_nomenclature_hist (id, nomenclature_id, task_id, quantity) VALUES (6, 5, 11, 10);
INSERT INTO public.task_nomenclature_hist (id, nomenclature_id, task_id, quantity) VALUES (7, 6, 12, 5);
INSERT INTO public.task_nomenclature_hist (id, nomenclature_id, task_id, quantity) VALUES (8, 7, 13, 15);


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

INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id, creator_id, uuid) VALUES (351, '-', '2024-07-02 17:43:57.837131', '2024-07-02 18:12:52.049227', 50, 13, 8, 45, 1, '33a256cc-6c0a-44db-aae7-f43579a8a4cd');
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id, creator_id, uuid) VALUES (352, '', '2024-07-02 18:48:55.485351', '2024-07-02 18:49:46.129652', 50, 13, 1, 21, 1, 'ac9e1cd2-c920-444b-8fc5-470927763981');
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id, creator_id, uuid) VALUES (353, '', '2024-07-02 18:50:20.503016', '2024-07-02 18:50:44.158218', 50, 13, 2, 21, 1, '331fa441-7b46-4223-ae8a-cc4b94c1d5b3');
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id, creator_id, uuid) VALUES (354, '-', '2024-07-05 09:42:05.864416', '2024-07-09 04:50:45.943848', 50, 10, 8, 21, 1, 'c94a5025-3f87-408b-b7b4-5646fb8a59d4');
INSERT INTO public.tasks (id, comments, create_date, edit_date, constructor_id, task_status_id, task_type, user_id, creator_id, uuid) VALUES (355, '-', '2024-07-09 04:49:48.375794', '2024-07-09 04:50:55.804769', 50, 10, 8, 21, 1, '2e683ecc-4a5d-4855-94c6-fa95ddb1ce89');


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

INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (45, 'Аудитор', 'jason', 'jason', 'jason');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (46, 'Грузчик', 'marlen', 'marlen', 'marlen');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (1, 'Заведующий складом', 'Testovich', 'Tect', 'Test');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (21, 'Заведующий складом', 'Алла', 'Владимировна', 'Карцева ');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (24, 'Кладовщик', 'Қанат ', 'Парахатұлы', 'Әбдікәрім ');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (25, 'Кладовщик', 'Анзур ', 'Мусагалиевич', 'Гучаев ');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (26, 'Карщик', 'Даулет ', 'Абдижапарович', 'Ахметов ');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (27, 'Карщик', 'Куаныш ', 'Суйунчович ', 'Кобенов ');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (29, 'Грузчик', 'Александр ', 'Анатольевич', 'Чернявский ');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (28, 'Аудитор', 'Марғұлан ', 'Мақсатұлы', 'Тоқтасын ');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (22, 'Комплектовщик', 'Сандугаш ', 'Молдахановна', 'Чотобаева ');
INSERT INTO public.users (id, job_title, name, patronymic, surname) VALUES (23, 'Кладовщик', 'Дидар', 'Тилеубердиұл', 'Алипбаев');


--
-- Data for Name: walls; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (228, '88.99999999999979', '131.33332824707014', true, 'black', 14.340855774301303, 'wall', 1, 0, 631.1238175062574, 50);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (229, '89.91379310344813', '138.49137931034466', true, 'black', 437.5000000000001, 'wall', 1, 0, 18.74999999999996, 50);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (230, '707.5', '134.375', true, 'black', 440, 'wall', 1, 0, 12.499999999999883, 50);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (231, '88.74999999999999', '564.9999999999999', true, 'black', 12.50000000000023, 'wall', 1, 0, 630.6249999999999, 50);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (219, '135.99999999999994', '223.0000000000001', true, 'black', 359.99999999999983, 'wall', 1, 0, 44.99999999999999, NULL);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (218, '133.99999999999994', '89.00000000000001', true, 'black', 387, 'wall', 1, 0, 44.99999999999998, NULL);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (220, '136', '135.00000000000009', true, 'black', 489.99999999999994, 'wall', 1, 0, 44.99999999999999, NULL);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (221, '134', '89', true, 'black', 368.99999999999994, 'wall', 1, 0, 45, NULL);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (222, '133.99999999999991', '176.00000000000017', true, 'black', 540, 'wall', 1, 0, 44.999999999999964, NULL);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (223, '177', '49', true, 'black', 45, 'wall', 1, 0, 45, NULL);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (224, '201', '459', true, 'black', 45, 'wall', 1, 0, 45, NULL);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (225, '130', '439', true, 'black', 45, 'wall', 1, 0, 45, NULL);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (226, '1', '0', true, 'black', 45, 'wall', 1, 0, 45, NULL);
INSERT INTO public.walls (id, coordinate_x, coordinate_y, draggable, fill, height, name, opacity, rotation, width, constructor_id) VALUES (227, '87', '90', true, 'black', 45, 'wall', 1, 0, 45, NULL);


--
-- Data for Name: windows; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.windows (id, coordinate_x, coordinate_y, draggable, fill_pattern_image, height, name, opacity, rotation, width, constructor_id) VALUES (46, '719.0000000000005', '226.00000000000003', true, 'orange', 11, 'window', 1, 90, 144, 50);
INSERT INTO public.windows (id, coordinate_x, coordinate_y, draggable, fill_pattern_image, height, name, opacity, rotation, width, constructor_id) VALUES (45, '293.99999999999966', '566.9999999999997', true, 'orange', 7, 'window', 1, 0, 231, 50);


--
-- Data for Name: zone_shelves; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: zones; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (147, '109.50000000000003', '146.37499999999994', 'test123123', true, '#f00000', 296.8644244023477, 'zone', 0.5, 0, 'sadsad', 296.8644244023477, 50);
INSERT INTO public.zones (id, coordinate_x, coordinate_y, description, draggable, fill, height, name, opacity, rotation, title, width, constructor_id) VALUES (148, '448.0000000000002', '180.00000000000017', 'пробный', true, '#38e296', 221.56827390219905, 'zone', 0.5, 0, 'test', 221.56827390219905, 50);


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 50, true);


--
-- Name: constructor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.constructor_id_seq', 52, true);


--
-- Name: doorways_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doorways_id_seq', 43, true);


--
-- Name: item_attr_shelves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_attr_shelves_id_seq', 78, true);


--
-- Name: item_attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_attributes_id_seq', 310, true);


--
-- Name: nomenclature_hist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nomenclature_hist_id_seq', 7, true);


--
-- Name: shelves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shelves_id_seq', 718, true);


--
-- Name: task_file_hist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_file_hist_id_seq', 14, true);


--
-- Name: task_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_file_id_seq', 78, true);


--
-- Name: task_hist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_hist_id_seq', 14, true);


--
-- Name: task_nomenclature_hist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_nomenclature_hist_id_seq', 8, true);


--
-- Name: task_nomenclature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_nomenclature_id_seq', 369, true);


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

SELECT pg_catalog.setval('public.tasks_id_seq', 355, true);


--
-- Name: user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_role_id_seq', 6, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 47, true);


--
-- Name: walls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.walls_id_seq', 231, true);


--
-- Name: windows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.windows_id_seq', 46, true);


--
-- Name: zone_shelves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.zone_shelves_id_seq', 1, false);


--
-- Name: zones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.zones_id_seq', 148, true);


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
-- Name: item_attr_shelves item_attr_shelves_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_attr_shelves
    ADD CONSTRAINT item_attr_shelves_pkey PRIMARY KEY (id);


--
-- Name: item_attributes item_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_attributes
    ADD CONSTRAINT item_attributes_pkey PRIMARY KEY (id);


--
-- Name: item_attributes item_attributes_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_attributes
    ADD CONSTRAINT item_attributes_uuid_unique UNIQUE (uuid);


--
-- Name: nomenclature_hist nomenclature_hist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenclature_hist
    ADD CONSTRAINT nomenclature_hist_pkey PRIMARY KEY (id);


--
-- Name: shelves shelves_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shelves
    ADD CONSTRAINT shelves_pkey PRIMARY KEY (id);


--
-- Name: shelves shelves_rack_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shelves
    ADD CONSTRAINT shelves_rack_id_pk UNIQUE (rack_id);


--
-- Name: task_file_hist task_file_hist_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_file_hist
    ADD CONSTRAINT task_file_hist_pk PRIMARY KEY (id);


--
-- Name: task_file task_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_file
    ADD CONSTRAINT task_file_pkey PRIMARY KEY (id);


--
-- Name: task_hist task_hist_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_hist
    ADD CONSTRAINT task_hist_pk PRIMARY KEY (id);


--
-- Name: task_nomenclature_hist task_nomenclature_hist_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_nomenclature_hist
    ADD CONSTRAINT task_nomenclature_hist_pk PRIMARY KEY (id);


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
-- Name: tasks tasks_uk_uuid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_uk_uuid UNIQUE (uuid);


--
-- Name: accounts unique_accounts_usernames; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT unique_accounts_usernames UNIQUE (username);


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
-- Name: item_attr_shelves fk_shelf_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_attr_shelves
    ADD CONSTRAINT fk_shelf_id FOREIGN KEY (shelf_id) REFERENCES public.shelves(id);


--
-- Name: task_file fk_task_file_task; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_file
    ADD CONSTRAINT fk_task_file_task FOREIGN KEY (task_id) REFERENCES public.tasks(id);


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
-- Name: item_attr_shelves item_attr_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_attr_shelves
    ADD CONSTRAINT item_attr_fk FOREIGN KEY (item_attr_id) REFERENCES public.item_attributes(id);


--
-- Name: task_nomenclature item_attr_shelf_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_nomenclature
    ADD CONSTRAINT item_attr_shelf_fk FOREIGN KEY (item_attribute_shelf_id) REFERENCES public.item_attr_shelves(id);


--
-- Name: task_file_hist task_file_hist_task_hist_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_file_hist
    ADD CONSTRAINT task_file_hist_task_hist_fk FOREIGN KEY (task_id) REFERENCES public.task_hist(id);


--
-- Name: task_nomenclature_hist task_nomenclature_hist_nomenclature_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_nomenclature_hist
    ADD CONSTRAINT task_nomenclature_hist_nomenclature_fk FOREIGN KEY (nomenclature_id) REFERENCES public.nomenclature_hist(id);


--
-- Name: task_nomenclature_hist task_nomenclature_hist_task_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_nomenclature_hist
    ADD CONSTRAINT task_nomenclature_hist_task_fk FOREIGN KEY (task_id) REFERENCES public.task_hist(id);


--
-- Name: tasks tasks_creator_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_creator_fk FOREIGN KEY (creator_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

