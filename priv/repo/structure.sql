--
-- PostgreSQL database dump
--

\restrict JMljA9UNgfSCB1QYQXkqnglw2ypURTeJ6cKDce7576iUZfgwaJ3W2cOpxMer7xL

-- Dumped from database version 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)

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
-- Name: announcement_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.announcement_settings (
    announcement_setting_id bigint NOT NULL,
    announcement_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.announcement_settings OWNER TO adrianasofi;

--
-- Name: announcement_settings_announcement_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.announcement_settings_announcement_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.announcement_settings_announcement_setting_id_seq OWNER TO adrianasofi;

--
-- Name: announcement_settings_announcement_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.announcement_settings_announcement_setting_id_seq OWNED BY public.announcement_settings.announcement_setting_id;


--
-- Name: announcement_type_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.announcement_type_settings (
    announcement_type_setting_id bigint NOT NULL,
    type_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text,
    setting_type character varying(6) NOT NULL
);


ALTER TABLE public.announcement_type_settings OWNER TO adrianasofi;

--
-- Name: announcement_type_settings_announcement_type_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.announcement_type_settings_announcement_type_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.announcement_type_settings_announcement_type_setting_id_seq OWNER TO adrianasofi;

--
-- Name: announcement_type_settings_announcement_type_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.announcement_type_settings_announcement_type_setting_id_seq OWNED BY public.announcement_type_settings.announcement_type_setting_id;


--
-- Name: announcement_types; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.announcement_types (
    type_id bigint NOT NULL,
    context_id bigint
);


ALTER TABLE public.announcement_types OWNER TO adrianasofi;

--
-- Name: announcement_types_type_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.announcement_types_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.announcement_types_type_id_seq OWNER TO adrianasofi;

--
-- Name: announcement_types_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.announcement_types_type_id_seq OWNED BY public.announcement_types.type_id;


--
-- Name: announcements; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.announcements (
    announcement_id bigint NOT NULL,
    assoc_type smallint,
    assoc_id bigint,
    type_id bigint,
    date_expire date,
    date_posted timestamp without time zone NOT NULL
);


ALTER TABLE public.announcements OWNER TO adrianasofi;

--
-- Name: announcements_announcement_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.announcements_announcement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.announcements_announcement_id_seq OWNER TO adrianasofi;

--
-- Name: announcements_announcement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.announcements_announcement_id_seq OWNED BY public.announcements.announcement_id;


--
-- Name: author_affiliation_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.author_affiliation_settings (
    author_affiliation_setting_id bigint NOT NULL,
    author_affiliation_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.author_affiliation_settings OWNER TO adrianasofi;

--
-- Name: author_affiliation_settings_author_affiliation_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.author_affiliation_settings_author_affiliation_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.author_affiliation_settings_author_affiliation_setting_id_seq OWNER TO adrianasofi;

--
-- Name: author_affiliation_settings_author_affiliation_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.author_affiliation_settings_author_affiliation_setting_id_seq OWNED BY public.author_affiliation_settings.author_affiliation_setting_id;


--
-- Name: author_affiliations; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.author_affiliations (
    author_affiliation_id bigint NOT NULL,
    author_id bigint NOT NULL,
    ror character varying(255)
);


ALTER TABLE public.author_affiliations OWNER TO adrianasofi;

--
-- Name: author_affiliations_author_affiliation_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.author_affiliations_author_affiliation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.author_affiliations_author_affiliation_id_seq OWNER TO adrianasofi;

--
-- Name: author_affiliations_author_affiliation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.author_affiliations_author_affiliation_id_seq OWNED BY public.author_affiliations.author_affiliation_id;


--
-- Name: author_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.author_settings (
    author_setting_id bigint NOT NULL,
    author_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.author_settings OWNER TO adrianasofi;

--
-- Name: author_settings_author_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.author_settings_author_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.author_settings_author_setting_id_seq OWNER TO adrianasofi;

--
-- Name: author_settings_author_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.author_settings_author_setting_id_seq OWNED BY public.author_settings.author_setting_id;


--
-- Name: authors; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.authors (
    author_id bigint NOT NULL,
    email character varying(90) NOT NULL,
    include_in_browse smallint DEFAULT 1 NOT NULL,
    publication_id bigint NOT NULL,
    seq double precision DEFAULT 0 NOT NULL,
    user_group_id bigint
);


ALTER TABLE public.authors OWNER TO adrianasofi;

--
-- Name: authors_author_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.authors_author_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.authors_author_id_seq OWNER TO adrianasofi;

--
-- Name: authors_author_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.authors_author_id_seq OWNED BY public.authors.author_id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.categories (
    category_id bigint NOT NULL,
    context_id bigint NOT NULL,
    parent_id bigint,
    seq bigint,
    path character varying(255) NOT NULL,
    image text
);


ALTER TABLE public.categories OWNER TO adrianasofi;

--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.categories_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_category_id_seq OWNER TO adrianasofi;

--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- Name: category_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.category_settings (
    category_setting_id bigint NOT NULL,
    category_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.category_settings OWNER TO adrianasofi;

--
-- Name: category_settings_category_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.category_settings_category_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.category_settings_category_setting_id_seq OWNER TO adrianasofi;

--
-- Name: category_settings_category_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.category_settings_category_setting_id_seq OWNED BY public.category_settings.category_setting_id;


--
-- Name: citation_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.citation_settings (
    citation_setting_id bigint NOT NULL,
    citation_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text,
    setting_type character varying(6)
);


ALTER TABLE public.citation_settings OWNER TO adrianasofi;

--
-- Name: citation_settings_citation_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.citation_settings_citation_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.citation_settings_citation_setting_id_seq OWNER TO adrianasofi;

--
-- Name: citation_settings_citation_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.citation_settings_citation_setting_id_seq OWNED BY public.citation_settings.citation_setting_id;


--
-- Name: citations; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.citations (
    citation_id bigint NOT NULL,
    publication_id bigint NOT NULL,
    raw_citation text NOT NULL,
    seq bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.citations OWNER TO adrianasofi;

--
-- Name: citations_citation_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.citations_citation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.citations_citation_id_seq OWNER TO adrianasofi;

--
-- Name: citations_citation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.citations_citation_id_seq OWNED BY public.citations.citation_id;


--
-- Name: completed_payments; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.completed_payments (
    completed_payment_id bigint NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    payment_type bigint NOT NULL,
    context_id bigint NOT NULL,
    user_id bigint,
    assoc_id bigint,
    amount numeric(8,2) NOT NULL,
    currency_code_alpha character varying(3),
    payment_method_plugin_name character varying(80)
);


ALTER TABLE public.completed_payments OWNER TO adrianasofi;

--
-- Name: completed_payments_completed_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.completed_payments_completed_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.completed_payments_completed_payment_id_seq OWNER TO adrianasofi;

--
-- Name: completed_payments_completed_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.completed_payments_completed_payment_id_seq OWNED BY public.completed_payments.completed_payment_id;


--
-- Name: controlled_vocab_entries; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.controlled_vocab_entries (
    controlled_vocab_entry_id bigint NOT NULL,
    controlled_vocab_id bigint NOT NULL,
    seq double precision
);


ALTER TABLE public.controlled_vocab_entries OWNER TO adrianasofi;

--
-- Name: controlled_vocab_entries_controlled_vocab_entry_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.controlled_vocab_entries_controlled_vocab_entry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.controlled_vocab_entries_controlled_vocab_entry_id_seq OWNER TO adrianasofi;

--
-- Name: controlled_vocab_entries_controlled_vocab_entry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.controlled_vocab_entries_controlled_vocab_entry_id_seq OWNED BY public.controlled_vocab_entries.controlled_vocab_entry_id;


--
-- Name: controlled_vocab_entry_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.controlled_vocab_entry_settings (
    controlled_vocab_entry_setting_id bigint NOT NULL,
    controlled_vocab_entry_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.controlled_vocab_entry_settings OWNER TO adrianasofi;

--
-- Name: controlled_vocab_entry_settin_controlled_vocab_entry_settin_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.controlled_vocab_entry_settin_controlled_vocab_entry_settin_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.controlled_vocab_entry_settin_controlled_vocab_entry_settin_seq OWNER TO adrianasofi;

--
-- Name: controlled_vocab_entry_settin_controlled_vocab_entry_settin_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.controlled_vocab_entry_settin_controlled_vocab_entry_settin_seq OWNED BY public.controlled_vocab_entry_settings.controlled_vocab_entry_setting_id;


--
-- Name: controlled_vocabs; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.controlled_vocabs (
    controlled_vocab_id bigint NOT NULL,
    symbolic character varying(64) NOT NULL,
    assoc_type bigint DEFAULT 0 NOT NULL,
    assoc_id bigint
);


ALTER TABLE public.controlled_vocabs OWNER TO adrianasofi;

--
-- Name: controlled_vocabs_controlled_vocab_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.controlled_vocabs_controlled_vocab_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.controlled_vocabs_controlled_vocab_id_seq OWNER TO adrianasofi;

--
-- Name: controlled_vocabs_controlled_vocab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.controlled_vocabs_controlled_vocab_id_seq OWNED BY public.controlled_vocabs.controlled_vocab_id;


--
-- Name: custom_issue_orders; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.custom_issue_orders (
    custom_issue_order_id bigint NOT NULL,
    issue_id bigint NOT NULL,
    journal_id bigint NOT NULL,
    seq double precision DEFAULT 0 NOT NULL
);


ALTER TABLE public.custom_issue_orders OWNER TO adrianasofi;

--
-- Name: custom_issue_orders_custom_issue_order_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.custom_issue_orders_custom_issue_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.custom_issue_orders_custom_issue_order_id_seq OWNER TO adrianasofi;

--
-- Name: custom_issue_orders_custom_issue_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.custom_issue_orders_custom_issue_order_id_seq OWNED BY public.custom_issue_orders.custom_issue_order_id;


--
-- Name: custom_section_orders; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.custom_section_orders (
    custom_section_order_id bigint NOT NULL,
    issue_id bigint NOT NULL,
    section_id bigint NOT NULL,
    seq double precision DEFAULT 0 NOT NULL
);


ALTER TABLE public.custom_section_orders OWNER TO adrianasofi;

--
-- Name: custom_section_orders_custom_section_order_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.custom_section_orders_custom_section_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.custom_section_orders_custom_section_order_id_seq OWNER TO adrianasofi;

--
-- Name: custom_section_orders_custom_section_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.custom_section_orders_custom_section_order_id_seq OWNED BY public.custom_section_orders.custom_section_order_id;


--
-- Name: data_object_tombstone_oai_set_objects; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.data_object_tombstone_oai_set_objects (
    object_id bigint NOT NULL,
    tombstone_id bigint NOT NULL,
    assoc_type bigint NOT NULL,
    assoc_id bigint NOT NULL
);


ALTER TABLE public.data_object_tombstone_oai_set_objects OWNER TO adrianasofi;

--
-- Name: data_object_tombstone_oai_set_objects_object_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.data_object_tombstone_oai_set_objects_object_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.data_object_tombstone_oai_set_objects_object_id_seq OWNER TO adrianasofi;

--
-- Name: data_object_tombstone_oai_set_objects_object_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.data_object_tombstone_oai_set_objects_object_id_seq OWNED BY public.data_object_tombstone_oai_set_objects.object_id;


--
-- Name: data_object_tombstone_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.data_object_tombstone_settings (
    tombstone_setting_id bigint NOT NULL,
    tombstone_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text,
    setting_type character varying(6) NOT NULL
);


ALTER TABLE public.data_object_tombstone_settings OWNER TO adrianasofi;

--
-- Name: data_object_tombstone_settings_tombstone_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.data_object_tombstone_settings_tombstone_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.data_object_tombstone_settings_tombstone_setting_id_seq OWNER TO adrianasofi;

--
-- Name: data_object_tombstone_settings_tombstone_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.data_object_tombstone_settings_tombstone_setting_id_seq OWNED BY public.data_object_tombstone_settings.tombstone_setting_id;


--
-- Name: data_object_tombstones; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.data_object_tombstones (
    tombstone_id bigint NOT NULL,
    data_object_id bigint NOT NULL,
    date_deleted timestamp without time zone NOT NULL,
    set_spec character varying(255) NOT NULL,
    set_name character varying(255) NOT NULL,
    oai_identifier character varying(255) NOT NULL
);


ALTER TABLE public.data_object_tombstones OWNER TO adrianasofi;

--
-- Name: data_object_tombstones_tombstone_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.data_object_tombstones_tombstone_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.data_object_tombstones_tombstone_id_seq OWNER TO adrianasofi;

--
-- Name: data_object_tombstones_tombstone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.data_object_tombstones_tombstone_id_seq OWNED BY public.data_object_tombstones.tombstone_id;


--
-- Name: doi_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.doi_settings (
    doi_setting_id bigint NOT NULL,
    doi_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.doi_settings OWNER TO adrianasofi;

--
-- Name: doi_settings_doi_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.doi_settings_doi_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.doi_settings_doi_setting_id_seq OWNER TO adrianasofi;

--
-- Name: doi_settings_doi_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.doi_settings_doi_setting_id_seq OWNED BY public.doi_settings.doi_setting_id;


--
-- Name: dois; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.dois (
    doi_id bigint NOT NULL,
    context_id bigint NOT NULL,
    doi character varying(255) NOT NULL,
    status smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.dois OWNER TO adrianasofi;

--
-- Name: dois_doi_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.dois_doi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dois_doi_id_seq OWNER TO adrianasofi;

--
-- Name: dois_doi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.dois_doi_id_seq OWNED BY public.dois.doi_id;


--
-- Name: edit_decisions; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.edit_decisions (
    edit_decision_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    review_round_id bigint,
    stage_id bigint,
    round smallint,
    editor_id bigint NOT NULL,
    decision smallint NOT NULL,
    date_decided timestamp without time zone NOT NULL
);


ALTER TABLE public.edit_decisions OWNER TO adrianasofi;

--
-- Name: edit_decisions_edit_decision_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.edit_decisions_edit_decision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.edit_decisions_edit_decision_id_seq OWNER TO adrianasofi;

--
-- Name: edit_decisions_edit_decision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.edit_decisions_edit_decision_id_seq OWNED BY public.edit_decisions.edit_decision_id;


--
-- Name: email_log; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.email_log (
    log_id bigint NOT NULL,
    assoc_type bigint NOT NULL,
    assoc_id bigint NOT NULL,
    sender_id bigint,
    date_sent timestamp without time zone NOT NULL,
    event_type bigint,
    from_address character varying(255),
    recipients text,
    cc_recipients text,
    bcc_recipients text,
    subject character varying(255),
    body text
);


ALTER TABLE public.email_log OWNER TO adrianasofi;

--
-- Name: email_log_log_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.email_log_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.email_log_log_id_seq OWNER TO adrianasofi;

--
-- Name: email_log_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.email_log_log_id_seq OWNED BY public.email_log.log_id;


--
-- Name: email_log_users; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.email_log_users (
    email_log_user_id bigint NOT NULL,
    email_log_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.email_log_users OWNER TO adrianasofi;

--
-- Name: email_log_users_email_log_user_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.email_log_users_email_log_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.email_log_users_email_log_user_id_seq OWNER TO adrianasofi;

--
-- Name: email_log_users_email_log_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.email_log_users_email_log_user_id_seq OWNED BY public.email_log_users.email_log_user_id;


--
-- Name: email_templates; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.email_templates (
    email_id bigint NOT NULL,
    email_key character varying(255) NOT NULL,
    context_id bigint NOT NULL,
    alternate_to character varying(255)
);


ALTER TABLE public.email_templates OWNER TO adrianasofi;

--
-- Name: email_templates_default_data; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.email_templates_default_data (
    email_templates_default_data_id bigint NOT NULL,
    email_key character varying(255) NOT NULL,
    locale character varying(28) DEFAULT '''en'''::character varying NOT NULL,
    name character varying(255) NOT NULL,
    subject character varying(255) NOT NULL,
    body text
);


ALTER TABLE public.email_templates_default_data OWNER TO adrianasofi;

--
-- Name: email_templates_default_data_email_templates_default_data_i_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.email_templates_default_data_email_templates_default_data_i_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.email_templates_default_data_email_templates_default_data_i_seq OWNER TO adrianasofi;

--
-- Name: email_templates_default_data_email_templates_default_data_i_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.email_templates_default_data_email_templates_default_data_i_seq OWNED BY public.email_templates_default_data.email_templates_default_data_id;


--
-- Name: email_templates_email_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.email_templates_email_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.email_templates_email_id_seq OWNER TO adrianasofi;

--
-- Name: email_templates_email_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.email_templates_email_id_seq OWNED BY public.email_templates.email_id;


--
-- Name: email_templates_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.email_templates_settings (
    email_template_setting_id bigint NOT NULL,
    email_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.email_templates_settings OWNER TO adrianasofi;

--
-- Name: email_templates_settings_email_template_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.email_templates_settings_email_template_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.email_templates_settings_email_template_setting_id_seq OWNER TO adrianasofi;

--
-- Name: email_templates_settings_email_template_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.email_templates_settings_email_template_setting_id_seq OWNED BY public.email_templates_settings.email_template_setting_id;


--
-- Name: event_log; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.event_log (
    log_id bigint NOT NULL,
    assoc_type bigint NOT NULL,
    assoc_id bigint NOT NULL,
    user_id bigint,
    date_logged timestamp without time zone NOT NULL,
    event_type bigint,
    message text,
    is_translated smallint
);


ALTER TABLE public.event_log OWNER TO adrianasofi;

--
-- Name: event_log_log_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.event_log_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.event_log_log_id_seq OWNER TO adrianasofi;

--
-- Name: event_log_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.event_log_log_id_seq OWNED BY public.event_log.log_id;


--
-- Name: event_log_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.event_log_settings (
    event_log_setting_id bigint NOT NULL,
    log_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.event_log_settings OWNER TO adrianasofi;

--
-- Name: event_log_settings_event_log_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.event_log_settings_event_log_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.event_log_settings_event_log_setting_id_seq OWNER TO adrianasofi;

--
-- Name: event_log_settings_event_log_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.event_log_settings_event_log_setting_id_seq OWNED BY public.event_log_settings.event_log_setting_id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO adrianasofi;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO adrianasofi;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: files; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.files (
    file_id bigint NOT NULL,
    path character varying(255) NOT NULL,
    mimetype character varying(255) NOT NULL
);


ALTER TABLE public.files OWNER TO adrianasofi;

--
-- Name: files_file_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.files_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.files_file_id_seq OWNER TO adrianasofi;

--
-- Name: files_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.files_file_id_seq OWNED BY public.files.file_id;


--
-- Name: filter_groups; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.filter_groups (
    filter_group_id bigint NOT NULL,
    symbolic character varying(255),
    display_name character varying(255),
    description character varying(255),
    input_type character varying(255),
    output_type character varying(255)
);


ALTER TABLE public.filter_groups OWNER TO adrianasofi;

--
-- Name: filter_groups_filter_group_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.filter_groups_filter_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.filter_groups_filter_group_id_seq OWNER TO adrianasofi;

--
-- Name: filter_groups_filter_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.filter_groups_filter_group_id_seq OWNED BY public.filter_groups.filter_group_id;


--
-- Name: filter_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.filter_settings (
    filter_setting_id bigint NOT NULL,
    filter_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text,
    setting_type character varying(6) NOT NULL
);


ALTER TABLE public.filter_settings OWNER TO adrianasofi;

--
-- Name: filter_settings_filter_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.filter_settings_filter_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.filter_settings_filter_setting_id_seq OWNER TO adrianasofi;

--
-- Name: filter_settings_filter_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.filter_settings_filter_setting_id_seq OWNED BY public.filter_settings.filter_setting_id;


--
-- Name: filters; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.filters (
    filter_id bigint NOT NULL,
    filter_group_id bigint NOT NULL,
    context_id bigint,
    display_name character varying(255),
    class_name character varying(255),
    is_template smallint DEFAULT 0 NOT NULL,
    parent_filter_id bigint,
    seq bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.filters OWNER TO adrianasofi;

--
-- Name: filters_filter_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.filters_filter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.filters_filter_id_seq OWNER TO adrianasofi;

--
-- Name: filters_filter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.filters_filter_id_seq OWNED BY public.filters.filter_id;


--
-- Name: genre_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.genre_settings (
    genre_setting_id bigint NOT NULL,
    genre_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text,
    setting_type character varying(6) NOT NULL
);


ALTER TABLE public.genre_settings OWNER TO adrianasofi;

--
-- Name: genre_settings_genre_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.genre_settings_genre_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genre_settings_genre_setting_id_seq OWNER TO adrianasofi;

--
-- Name: genre_settings_genre_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.genre_settings_genre_setting_id_seq OWNED BY public.genre_settings.genre_setting_id;


--
-- Name: genres; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.genres (
    genre_id bigint NOT NULL,
    context_id bigint NOT NULL,
    seq bigint NOT NULL,
    enabled smallint DEFAULT 1 NOT NULL,
    category bigint DEFAULT 1 NOT NULL,
    dependent smallint DEFAULT 0 NOT NULL,
    supplementary smallint DEFAULT 0 NOT NULL,
    required smallint DEFAULT 0 NOT NULL,
    entry_key character varying(30)
);


ALTER TABLE public.genres OWNER TO adrianasofi;

--
-- Name: genres_genre_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.genres_genre_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genres_genre_id_seq OWNER TO adrianasofi;

--
-- Name: genres_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.genres_genre_id_seq OWNED BY public.genres.genre_id;


--
-- Name: highlight_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.highlight_settings (
    highlight_setting_id bigint NOT NULL,
    highlight_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.highlight_settings OWNER TO adrianasofi;

--
-- Name: highlight_settings_highlight_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.highlight_settings_highlight_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.highlight_settings_highlight_setting_id_seq OWNER TO adrianasofi;

--
-- Name: highlight_settings_highlight_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.highlight_settings_highlight_setting_id_seq OWNED BY public.highlight_settings.highlight_setting_id;


--
-- Name: highlights; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.highlights (
    highlight_id bigint NOT NULL,
    context_id bigint,
    sequence bigint NOT NULL,
    url character varying(2047) NOT NULL
);


ALTER TABLE public.highlights OWNER TO adrianasofi;

--
-- Name: highlights_highlight_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.highlights_highlight_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.highlights_highlight_id_seq OWNER TO adrianasofi;

--
-- Name: highlights_highlight_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.highlights_highlight_id_seq OWNED BY public.highlights.highlight_id;


--
-- Name: institution_ip; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.institution_ip (
    institution_ip_id bigint NOT NULL,
    institution_id bigint NOT NULL,
    ip_string character varying(40) NOT NULL,
    ip_start bigint NOT NULL,
    ip_end bigint
);


ALTER TABLE public.institution_ip OWNER TO adrianasofi;

--
-- Name: institution_ip_institution_ip_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.institution_ip_institution_ip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.institution_ip_institution_ip_id_seq OWNER TO adrianasofi;

--
-- Name: institution_ip_institution_ip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.institution_ip_institution_ip_id_seq OWNED BY public.institution_ip.institution_ip_id;


--
-- Name: institution_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.institution_settings (
    institution_setting_id bigint NOT NULL,
    institution_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.institution_settings OWNER TO adrianasofi;

--
-- Name: institution_settings_institution_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.institution_settings_institution_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.institution_settings_institution_setting_id_seq OWNER TO adrianasofi;

--
-- Name: institution_settings_institution_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.institution_settings_institution_setting_id_seq OWNED BY public.institution_settings.institution_setting_id;


--
-- Name: institutional_subscriptions; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.institutional_subscriptions (
    institutional_subscription_id bigint NOT NULL,
    subscription_id bigint NOT NULL,
    institution_id bigint NOT NULL,
    mailing_address character varying(255),
    domain character varying(255)
);


ALTER TABLE public.institutional_subscriptions OWNER TO adrianasofi;

--
-- Name: institutional_subscriptions_institutional_subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.institutional_subscriptions_institutional_subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.institutional_subscriptions_institutional_subscription_id_seq OWNER TO adrianasofi;

--
-- Name: institutional_subscriptions_institutional_subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.institutional_subscriptions_institutional_subscription_id_seq OWNED BY public.institutional_subscriptions.institutional_subscription_id;


--
-- Name: institutions; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.institutions (
    institution_id bigint NOT NULL,
    context_id bigint NOT NULL,
    ror character varying(255),
    deleted_at timestamp without time zone
);


ALTER TABLE public.institutions OWNER TO adrianasofi;

--
-- Name: institutions_institution_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.institutions_institution_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.institutions_institution_id_seq OWNER TO adrianasofi;

--
-- Name: institutions_institution_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.institutions_institution_id_seq OWNED BY public.institutions.institution_id;


--
-- Name: invitations; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.invitations (
    invitation_id bigint NOT NULL,
    key_hash character varying(255),
    type character varying(255) NOT NULL,
    user_id bigint,
    inviter_id bigint,
    expiry_date timestamp without time zone,
    payload text,
    status character varying(255) NOT NULL,
    email character varying(255),
    context_id bigint,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.invitations OWNER TO adrianasofi;

--
-- Name: invitations_invitation_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.invitations_invitation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invitations_invitation_id_seq OWNER TO adrianasofi;

--
-- Name: invitations_invitation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.invitations_invitation_id_seq OWNED BY public.invitations.invitation_id;


--
-- Name: issue_files; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.issue_files (
    file_id bigint NOT NULL,
    issue_id bigint NOT NULL,
    file_name character varying(90) NOT NULL,
    file_type character varying(255) NOT NULL,
    file_size bigint NOT NULL,
    content_type bigint NOT NULL,
    original_file_name character varying(127),
    date_uploaded timestamp without time zone NOT NULL,
    date_modified timestamp without time zone NOT NULL
);


ALTER TABLE public.issue_files OWNER TO adrianasofi;

--
-- Name: issue_files_file_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.issue_files_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.issue_files_file_id_seq OWNER TO adrianasofi;

--
-- Name: issue_files_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.issue_files_file_id_seq OWNED BY public.issue_files.file_id;


--
-- Name: issue_galley_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.issue_galley_settings (
    issue_galley_setting_id bigint NOT NULL,
    galley_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text,
    setting_type character varying(6) NOT NULL
);


ALTER TABLE public.issue_galley_settings OWNER TO adrianasofi;

--
-- Name: issue_galley_settings_issue_galley_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.issue_galley_settings_issue_galley_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.issue_galley_settings_issue_galley_setting_id_seq OWNER TO adrianasofi;

--
-- Name: issue_galley_settings_issue_galley_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.issue_galley_settings_issue_galley_setting_id_seq OWNED BY public.issue_galley_settings.issue_galley_setting_id;


--
-- Name: issue_galleys; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.issue_galleys (
    galley_id bigint NOT NULL,
    locale character varying(28),
    issue_id bigint NOT NULL,
    file_id bigint NOT NULL,
    label character varying(255),
    seq double precision DEFAULT 0 NOT NULL,
    url_path character varying(64)
);


ALTER TABLE public.issue_galleys OWNER TO adrianasofi;

--
-- Name: issue_galleys_galley_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.issue_galleys_galley_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.issue_galleys_galley_id_seq OWNER TO adrianasofi;

--
-- Name: issue_galleys_galley_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.issue_galleys_galley_id_seq OWNED BY public.issue_galleys.galley_id;


--
-- Name: issue_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.issue_settings (
    issue_setting_id bigint NOT NULL,
    issue_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.issue_settings OWNER TO adrianasofi;

--
-- Name: issue_settings_issue_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.issue_settings_issue_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.issue_settings_issue_setting_id_seq OWNER TO adrianasofi;

--
-- Name: issue_settings_issue_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.issue_settings_issue_setting_id_seq OWNED BY public.issue_settings.issue_setting_id;


--
-- Name: issues; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.issues (
    issue_id bigint NOT NULL,
    journal_id bigint NOT NULL,
    volume smallint,
    number character varying(40),
    year smallint,
    published smallint DEFAULT 0 NOT NULL,
    date_published timestamp without time zone,
    date_notified timestamp without time zone,
    last_modified timestamp without time zone,
    access_status smallint DEFAULT 1 NOT NULL,
    open_access_date timestamp without time zone,
    show_volume smallint DEFAULT 0 NOT NULL,
    show_number smallint DEFAULT 0 NOT NULL,
    show_year smallint DEFAULT 0 NOT NULL,
    show_title smallint DEFAULT 0 NOT NULL,
    style_file_name character varying(90),
    original_style_file_name character varying(255),
    url_path character varying(64),
    doi_id bigint
);


ALTER TABLE public.issues OWNER TO adrianasofi;

--
-- Name: issues_issue_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.issues_issue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.issues_issue_id_seq OWNER TO adrianasofi;

--
-- Name: issues_issue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.issues_issue_id_seq OWNED BY public.issues.issue_id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO adrianasofi;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO adrianasofi;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO adrianasofi;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: journal_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.journal_settings (
    journal_setting_id bigint NOT NULL,
    journal_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.journal_settings OWNER TO adrianasofi;

--
-- Name: journal_settings_journal_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.journal_settings_journal_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.journal_settings_journal_setting_id_seq OWNER TO adrianasofi;

--
-- Name: journal_settings_journal_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.journal_settings_journal_setting_id_seq OWNED BY public.journal_settings.journal_setting_id;


--
-- Name: journals; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.journals (
    journal_id bigint NOT NULL,
    path character varying(32) NOT NULL,
    seq double precision DEFAULT 0 NOT NULL,
    primary_locale character varying(28) NOT NULL,
    enabled smallint DEFAULT 1 NOT NULL,
    current_issue_id bigint
);


ALTER TABLE public.journals OWNER TO adrianasofi;

--
-- Name: journals_journal_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.journals_journal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.journals_journal_id_seq OWNER TO adrianasofi;

--
-- Name: journals_journal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.journals_journal_id_seq OWNED BY public.journals.journal_id;


--
-- Name: library_file_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.library_file_settings (
    library_file_setting_id bigint NOT NULL,
    file_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text,
    setting_type character varying(6) NOT NULL
);


ALTER TABLE public.library_file_settings OWNER TO adrianasofi;

--
-- Name: library_file_settings_library_file_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.library_file_settings_library_file_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.library_file_settings_library_file_setting_id_seq OWNER TO adrianasofi;

--
-- Name: library_file_settings_library_file_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.library_file_settings_library_file_setting_id_seq OWNED BY public.library_file_settings.library_file_setting_id;


--
-- Name: library_files; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.library_files (
    file_id bigint NOT NULL,
    context_id bigint NOT NULL,
    file_name character varying(255) NOT NULL,
    original_file_name character varying(255) NOT NULL,
    file_type character varying(255) NOT NULL,
    file_size bigint NOT NULL,
    type smallint NOT NULL,
    date_uploaded timestamp without time zone NOT NULL,
    date_modified timestamp without time zone NOT NULL,
    submission_id bigint,
    public_access smallint DEFAULT 0
);


ALTER TABLE public.library_files OWNER TO adrianasofi;

--
-- Name: library_files_file_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.library_files_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.library_files_file_id_seq OWNER TO adrianasofi;

--
-- Name: library_files_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.library_files_file_id_seq OWNED BY public.library_files.file_id;


--
-- Name: metrics_context; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.metrics_context (
    metrics_context_id bigint NOT NULL,
    load_id character varying(50) NOT NULL,
    context_id bigint NOT NULL,
    date date NOT NULL,
    metric integer NOT NULL
);


ALTER TABLE public.metrics_context OWNER TO adrianasofi;

--
-- Name: metrics_context_metrics_context_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.metrics_context_metrics_context_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.metrics_context_metrics_context_id_seq OWNER TO adrianasofi;

--
-- Name: metrics_context_metrics_context_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.metrics_context_metrics_context_id_seq OWNED BY public.metrics_context.metrics_context_id;


--
-- Name: metrics_counter_submission_daily; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.metrics_counter_submission_daily (
    metrics_counter_submission_daily_id bigint NOT NULL,
    load_id character varying(50) NOT NULL,
    context_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    date date NOT NULL,
    metric_investigations integer NOT NULL,
    metric_investigations_unique integer NOT NULL,
    metric_requests integer NOT NULL,
    metric_requests_unique integer NOT NULL
);


ALTER TABLE public.metrics_counter_submission_daily OWNER TO adrianasofi;

--
-- Name: metrics_counter_submission_da_metrics_counter_submission_da_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.metrics_counter_submission_da_metrics_counter_submission_da_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.metrics_counter_submission_da_metrics_counter_submission_da_seq OWNER TO adrianasofi;

--
-- Name: metrics_counter_submission_da_metrics_counter_submission_da_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.metrics_counter_submission_da_metrics_counter_submission_da_seq OWNED BY public.metrics_counter_submission_daily.metrics_counter_submission_daily_id;


--
-- Name: metrics_counter_submission_institution_monthly; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.metrics_counter_submission_institution_monthly (
    metrics_counter_submission_institution_monthly_id bigint NOT NULL,
    context_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    institution_id bigint NOT NULL,
    month integer NOT NULL,
    metric_investigations integer NOT NULL,
    metric_investigations_unique integer NOT NULL,
    metric_requests integer NOT NULL,
    metric_requests_unique integer NOT NULL
);


ALTER TABLE public.metrics_counter_submission_institution_monthly OWNER TO adrianasofi;

--
-- Name: metrics_counter_submission_in_metrics_counter_submission_i_seq1; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.metrics_counter_submission_in_metrics_counter_submission_i_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.metrics_counter_submission_in_metrics_counter_submission_i_seq1 OWNER TO adrianasofi;

--
-- Name: metrics_counter_submission_in_metrics_counter_submission_i_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.metrics_counter_submission_in_metrics_counter_submission_i_seq1 OWNED BY public.metrics_counter_submission_institution_monthly.metrics_counter_submission_institution_monthly_id;


--
-- Name: metrics_counter_submission_institution_daily; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.metrics_counter_submission_institution_daily (
    metrics_counter_submission_institution_daily_id bigint NOT NULL,
    load_id character varying(50) NOT NULL,
    context_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    institution_id bigint NOT NULL,
    date date NOT NULL,
    metric_investigations integer NOT NULL,
    metric_investigations_unique integer NOT NULL,
    metric_requests integer NOT NULL,
    metric_requests_unique integer NOT NULL
);


ALTER TABLE public.metrics_counter_submission_institution_daily OWNER TO adrianasofi;

--
-- Name: metrics_counter_submission_in_metrics_counter_submission_in_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.metrics_counter_submission_in_metrics_counter_submission_in_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.metrics_counter_submission_in_metrics_counter_submission_in_seq OWNER TO adrianasofi;

--
-- Name: metrics_counter_submission_in_metrics_counter_submission_in_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.metrics_counter_submission_in_metrics_counter_submission_in_seq OWNED BY public.metrics_counter_submission_institution_daily.metrics_counter_submission_institution_daily_id;


--
-- Name: metrics_counter_submission_monthly; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.metrics_counter_submission_monthly (
    metrics_counter_submission_monthly_id bigint NOT NULL,
    context_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    month integer NOT NULL,
    metric_investigations integer NOT NULL,
    metric_investigations_unique integer NOT NULL,
    metric_requests integer NOT NULL,
    metric_requests_unique integer NOT NULL
);


ALTER TABLE public.metrics_counter_submission_monthly OWNER TO adrianasofi;

--
-- Name: metrics_counter_submission_mo_metrics_counter_submission_mo_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.metrics_counter_submission_mo_metrics_counter_submission_mo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.metrics_counter_submission_mo_metrics_counter_submission_mo_seq OWNER TO adrianasofi;

--
-- Name: metrics_counter_submission_mo_metrics_counter_submission_mo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.metrics_counter_submission_mo_metrics_counter_submission_mo_seq OWNED BY public.metrics_counter_submission_monthly.metrics_counter_submission_monthly_id;


--
-- Name: metrics_issue; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.metrics_issue (
    metrics_issue_id bigint NOT NULL,
    load_id character varying(50) NOT NULL,
    context_id bigint NOT NULL,
    issue_id bigint NOT NULL,
    issue_galley_id bigint,
    date date NOT NULL,
    metric integer NOT NULL
);


ALTER TABLE public.metrics_issue OWNER TO adrianasofi;

--
-- Name: metrics_issue_metrics_issue_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.metrics_issue_metrics_issue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.metrics_issue_metrics_issue_id_seq OWNER TO adrianasofi;

--
-- Name: metrics_issue_metrics_issue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.metrics_issue_metrics_issue_id_seq OWNED BY public.metrics_issue.metrics_issue_id;


--
-- Name: metrics_submission; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.metrics_submission (
    metrics_submission_id bigint NOT NULL,
    load_id character varying(50) NOT NULL,
    context_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    representation_id bigint,
    submission_file_id bigint,
    file_type bigint,
    assoc_type bigint NOT NULL,
    date date NOT NULL,
    metric integer NOT NULL
);


ALTER TABLE public.metrics_submission OWNER TO adrianasofi;

--
-- Name: metrics_submission_geo_daily; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.metrics_submission_geo_daily (
    metrics_submission_geo_daily_id bigint NOT NULL,
    load_id character varying(50) NOT NULL,
    context_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    country character varying(2) DEFAULT ''''''::character varying NOT NULL,
    region character varying(3) DEFAULT ''''''::character varying NOT NULL,
    city character varying(255) DEFAULT ''''''::character varying NOT NULL,
    date date NOT NULL,
    metric integer NOT NULL,
    metric_unique integer NOT NULL
);


ALTER TABLE public.metrics_submission_geo_daily OWNER TO adrianasofi;

--
-- Name: metrics_submission_geo_daily_metrics_submission_geo_daily_i_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.metrics_submission_geo_daily_metrics_submission_geo_daily_i_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.metrics_submission_geo_daily_metrics_submission_geo_daily_i_seq OWNER TO adrianasofi;

--
-- Name: metrics_submission_geo_daily_metrics_submission_geo_daily_i_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.metrics_submission_geo_daily_metrics_submission_geo_daily_i_seq OWNED BY public.metrics_submission_geo_daily.metrics_submission_geo_daily_id;


--
-- Name: metrics_submission_geo_monthly; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.metrics_submission_geo_monthly (
    metrics_submission_geo_monthly_id bigint NOT NULL,
    context_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    country character varying(2) DEFAULT ''''''::character varying NOT NULL,
    region character varying(3) DEFAULT ''''''::character varying NOT NULL,
    city character varying(255) DEFAULT ''''''::character varying NOT NULL,
    month integer NOT NULL,
    metric integer NOT NULL,
    metric_unique integer NOT NULL
);


ALTER TABLE public.metrics_submission_geo_monthly OWNER TO adrianasofi;

--
-- Name: metrics_submission_geo_monthl_metrics_submission_geo_monthl_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.metrics_submission_geo_monthl_metrics_submission_geo_monthl_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.metrics_submission_geo_monthl_metrics_submission_geo_monthl_seq OWNER TO adrianasofi;

--
-- Name: metrics_submission_geo_monthl_metrics_submission_geo_monthl_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.metrics_submission_geo_monthl_metrics_submission_geo_monthl_seq OWNED BY public.metrics_submission_geo_monthly.metrics_submission_geo_monthly_id;


--
-- Name: metrics_submission_metrics_submission_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.metrics_submission_metrics_submission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.metrics_submission_metrics_submission_id_seq OWNER TO adrianasofi;

--
-- Name: metrics_submission_metrics_submission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.metrics_submission_metrics_submission_id_seq OWNED BY public.metrics_submission.metrics_submission_id;


--
-- Name: navigation_menu_item_assignment_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.navigation_menu_item_assignment_settings (
    navigation_menu_item_assignment_setting_id bigint NOT NULL,
    navigation_menu_item_assignment_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text,
    setting_type character varying(6) NOT NULL
);


ALTER TABLE public.navigation_menu_item_assignment_settings OWNER TO adrianasofi;

--
-- Name: navigation_menu_item_assignme_navigation_menu_item_assignm_seq1; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.navigation_menu_item_assignme_navigation_menu_item_assignm_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.navigation_menu_item_assignme_navigation_menu_item_assignm_seq1 OWNER TO adrianasofi;

--
-- Name: navigation_menu_item_assignme_navigation_menu_item_assignm_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.navigation_menu_item_assignme_navigation_menu_item_assignm_seq1 OWNED BY public.navigation_menu_item_assignment_settings.navigation_menu_item_assignment_setting_id;


--
-- Name: navigation_menu_item_assignments; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.navigation_menu_item_assignments (
    navigation_menu_item_assignment_id bigint NOT NULL,
    navigation_menu_id bigint NOT NULL,
    navigation_menu_item_id bigint NOT NULL,
    parent_id bigint,
    seq bigint DEFAULT 0
);


ALTER TABLE public.navigation_menu_item_assignments OWNER TO adrianasofi;

--
-- Name: navigation_menu_item_assignme_navigation_menu_item_assignme_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.navigation_menu_item_assignme_navigation_menu_item_assignme_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.navigation_menu_item_assignme_navigation_menu_item_assignme_seq OWNER TO adrianasofi;

--
-- Name: navigation_menu_item_assignme_navigation_menu_item_assignme_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.navigation_menu_item_assignme_navigation_menu_item_assignme_seq OWNED BY public.navigation_menu_item_assignments.navigation_menu_item_assignment_id;


--
-- Name: navigation_menu_item_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.navigation_menu_item_settings (
    navigation_menu_item_setting_id bigint NOT NULL,
    navigation_menu_item_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text,
    setting_type character varying(6) NOT NULL
);


ALTER TABLE public.navigation_menu_item_settings OWNER TO adrianasofi;

--
-- Name: navigation_menu_item_settings_navigation_menu_item_setting__seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.navigation_menu_item_settings_navigation_menu_item_setting__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.navigation_menu_item_settings_navigation_menu_item_setting__seq OWNER TO adrianasofi;

--
-- Name: navigation_menu_item_settings_navigation_menu_item_setting__seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.navigation_menu_item_settings_navigation_menu_item_setting__seq OWNED BY public.navigation_menu_item_settings.navigation_menu_item_setting_id;


--
-- Name: navigation_menu_items; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.navigation_menu_items (
    navigation_menu_item_id bigint NOT NULL,
    context_id bigint,
    path character varying(255) DEFAULT ''''''::character varying,
    type character varying(255) DEFAULT ''''''::character varying
);


ALTER TABLE public.navigation_menu_items OWNER TO adrianasofi;

--
-- Name: navigation_menu_items_navigation_menu_item_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.navigation_menu_items_navigation_menu_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.navigation_menu_items_navigation_menu_item_id_seq OWNER TO adrianasofi;

--
-- Name: navigation_menu_items_navigation_menu_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.navigation_menu_items_navigation_menu_item_id_seq OWNED BY public.navigation_menu_items.navigation_menu_item_id;


--
-- Name: navigation_menus; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.navigation_menus (
    navigation_menu_id bigint NOT NULL,
    context_id bigint,
    area_name character varying(255) DEFAULT ''''''::character varying,
    title character varying(255) NOT NULL
);


ALTER TABLE public.navigation_menus OWNER TO adrianasofi;

--
-- Name: navigation_menus_navigation_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.navigation_menus_navigation_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.navigation_menus_navigation_menu_id_seq OWNER TO adrianasofi;

--
-- Name: navigation_menus_navigation_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.navigation_menus_navigation_menu_id_seq OWNED BY public.navigation_menus.navigation_menu_id;


--
-- Name: notes; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.notes (
    note_id bigint NOT NULL,
    assoc_type bigint NOT NULL,
    assoc_id bigint NOT NULL,
    user_id bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    date_modified timestamp without time zone,
    title character varying(255),
    contents text
);


ALTER TABLE public.notes OWNER TO adrianasofi;

--
-- Name: notes_note_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.notes_note_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notes_note_id_seq OWNER TO adrianasofi;

--
-- Name: notes_note_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.notes_note_id_seq OWNED BY public.notes.note_id;


--
-- Name: notification_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.notification_settings (
    notification_setting_id bigint NOT NULL,
    notification_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(64) NOT NULL,
    setting_value text NOT NULL,
    setting_type character varying(6) NOT NULL
);


ALTER TABLE public.notification_settings OWNER TO adrianasofi;

--
-- Name: notification_settings_notification_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.notification_settings_notification_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_settings_notification_setting_id_seq OWNER TO adrianasofi;

--
-- Name: notification_settings_notification_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.notification_settings_notification_setting_id_seq OWNED BY public.notification_settings.notification_setting_id;


--
-- Name: notification_subscription_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.notification_subscription_settings (
    setting_id bigint NOT NULL,
    setting_name character varying(64) NOT NULL,
    setting_value text NOT NULL,
    user_id bigint NOT NULL,
    context_id bigint,
    setting_type character varying(6) NOT NULL
);


ALTER TABLE public.notification_subscription_settings OWNER TO adrianasofi;

--
-- Name: notification_subscription_settings_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.notification_subscription_settings_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_subscription_settings_setting_id_seq OWNER TO adrianasofi;

--
-- Name: notification_subscription_settings_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.notification_subscription_settings_setting_id_seq OWNED BY public.notification_subscription_settings.setting_id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.notifications (
    notification_id bigint NOT NULL,
    context_id bigint,
    user_id bigint,
    level bigint NOT NULL,
    type bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    date_read timestamp without time zone,
    assoc_type bigint,
    assoc_id bigint
);


ALTER TABLE public.notifications OWNER TO adrianasofi;

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.notifications_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_notification_id_seq OWNER TO adrianasofi;

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.notifications_notification_id_seq OWNED BY public.notifications.notification_id;


--
-- Name: oai_resumption_tokens; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.oai_resumption_tokens (
    oai_resumption_token_id bigint NOT NULL,
    token character varying(32) NOT NULL,
    expire bigint NOT NULL,
    record_offset integer NOT NULL,
    params text
);


ALTER TABLE public.oai_resumption_tokens OWNER TO adrianasofi;

--
-- Name: oai_resumption_tokens_oai_resumption_token_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.oai_resumption_tokens_oai_resumption_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oai_resumption_tokens_oai_resumption_token_id_seq OWNER TO adrianasofi;

--
-- Name: oai_resumption_tokens_oai_resumption_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.oai_resumption_tokens_oai_resumption_token_id_seq OWNED BY public.oai_resumption_tokens.oai_resumption_token_id;


--
-- Name: plugin_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.plugin_settings (
    plugin_setting_id bigint NOT NULL,
    plugin_name character varying(80) NOT NULL,
    context_id bigint,
    setting_name character varying(80) NOT NULL,
    setting_value text,
    setting_type character varying(6) NOT NULL
);


ALTER TABLE public.plugin_settings OWNER TO adrianasofi;

--
-- Name: plugin_settings_plugin_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.plugin_settings_plugin_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.plugin_settings_plugin_setting_id_seq OWNER TO adrianasofi;

--
-- Name: plugin_settings_plugin_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.plugin_settings_plugin_setting_id_seq OWNED BY public.plugin_settings.plugin_setting_id;


--
-- Name: publication_categories; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.publication_categories (
    publication_category_id bigint NOT NULL,
    publication_id bigint NOT NULL,
    category_id bigint NOT NULL
);


ALTER TABLE public.publication_categories OWNER TO adrianasofi;

--
-- Name: publication_categories_publication_category_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.publication_categories_publication_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publication_categories_publication_category_id_seq OWNER TO adrianasofi;

--
-- Name: publication_categories_publication_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.publication_categories_publication_category_id_seq OWNED BY public.publication_categories.publication_category_id;


--
-- Name: publication_galley_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.publication_galley_settings (
    publication_galley_setting_id bigint NOT NULL,
    galley_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.publication_galley_settings OWNER TO adrianasofi;

--
-- Name: publication_galley_settings_publication_galley_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.publication_galley_settings_publication_galley_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publication_galley_settings_publication_galley_setting_id_seq OWNER TO adrianasofi;

--
-- Name: publication_galley_settings_publication_galley_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.publication_galley_settings_publication_galley_setting_id_seq OWNED BY public.publication_galley_settings.publication_galley_setting_id;


--
-- Name: publication_galleys; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.publication_galleys (
    galley_id bigint NOT NULL,
    locale character varying(28),
    publication_id bigint NOT NULL,
    label character varying(255),
    submission_file_id bigint,
    seq double precision DEFAULT 0 NOT NULL,
    remote_url character varying(2047),
    is_approved smallint DEFAULT 0 NOT NULL,
    url_path character varying(64),
    doi_id bigint
);


ALTER TABLE public.publication_galleys OWNER TO adrianasofi;

--
-- Name: publication_galleys_galley_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.publication_galleys_galley_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publication_galleys_galley_id_seq OWNER TO adrianasofi;

--
-- Name: publication_galleys_galley_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.publication_galleys_galley_id_seq OWNED BY public.publication_galleys.galley_id;


--
-- Name: publication_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.publication_settings (
    publication_setting_id bigint NOT NULL,
    publication_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.publication_settings OWNER TO adrianasofi;

--
-- Name: publication_settings_publication_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.publication_settings_publication_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publication_settings_publication_setting_id_seq OWNER TO adrianasofi;

--
-- Name: publication_settings_publication_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.publication_settings_publication_setting_id_seq OWNED BY public.publication_settings.publication_setting_id;


--
-- Name: publications; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.publications (
    publication_id bigint NOT NULL,
    access_status bigint DEFAULT 0,
    date_published date,
    last_modified timestamp without time zone,
    primary_contact_id bigint,
    section_id bigint,
    seq double precision DEFAULT 0 NOT NULL,
    submission_id bigint NOT NULL,
    status smallint DEFAULT 1 NOT NULL,
    url_path character varying(64),
    version bigint,
    doi_id bigint,
    issue_id bigint
);


ALTER TABLE public.publications OWNER TO adrianasofi;

--
-- Name: publications_publication_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.publications_publication_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publications_publication_id_seq OWNER TO adrianasofi;

--
-- Name: publications_publication_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.publications_publication_id_seq OWNED BY public.publications.publication_id;


--
-- Name: queries; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.queries (
    query_id bigint NOT NULL,
    assoc_type bigint NOT NULL,
    assoc_id bigint NOT NULL,
    stage_id smallint NOT NULL,
    seq double precision DEFAULT 0 NOT NULL,
    date_posted timestamp without time zone,
    date_modified timestamp without time zone,
    closed smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.queries OWNER TO adrianasofi;

--
-- Name: queries_query_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.queries_query_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.queries_query_id_seq OWNER TO adrianasofi;

--
-- Name: queries_query_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.queries_query_id_seq OWNED BY public.queries.query_id;


--
-- Name: query_participants; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.query_participants (
    query_participant_id bigint NOT NULL,
    query_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.query_participants OWNER TO adrianasofi;

--
-- Name: query_participants_query_participant_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.query_participants_query_participant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.query_participants_query_participant_id_seq OWNER TO adrianasofi;

--
-- Name: query_participants_query_participant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.query_participants_query_participant_id_seq OWNED BY public.query_participants.query_participant_id;


--
-- Name: queued_payments; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.queued_payments (
    queued_payment_id bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    date_modified timestamp without time zone NOT NULL,
    expiry_date date,
    payment_data text
);


ALTER TABLE public.queued_payments OWNER TO adrianasofi;

--
-- Name: queued_payments_queued_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.queued_payments_queued_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.queued_payments_queued_payment_id_seq OWNER TO adrianasofi;

--
-- Name: queued_payments_queued_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.queued_payments_queued_payment_id_seq OWNED BY public.queued_payments.queued_payment_id;


--
-- Name: review_assignment_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.review_assignment_settings (
    review_assignment_settings_id bigint NOT NULL,
    review_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.review_assignment_settings OWNER TO adrianasofi;

--
-- Name: review_assignment_settings_review_assignment_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.review_assignment_settings_review_assignment_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.review_assignment_settings_review_assignment_settings_id_seq OWNER TO adrianasofi;

--
-- Name: review_assignment_settings_review_assignment_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.review_assignment_settings_review_assignment_settings_id_seq OWNED BY public.review_assignment_settings.review_assignment_settings_id;


--
-- Name: review_assignments; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.review_assignments (
    review_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    reviewer_id bigint NOT NULL,
    competing_interests text,
    recommendation smallint,
    date_assigned timestamp without time zone,
    date_notified timestamp without time zone,
    date_confirmed timestamp without time zone,
    date_completed timestamp without time zone,
    date_considered timestamp without time zone,
    date_acknowledged timestamp without time zone,
    date_due timestamp without time zone,
    date_response_due timestamp without time zone,
    last_modified timestamp without time zone,
    reminder_was_automatic smallint DEFAULT 0 NOT NULL,
    declined smallint DEFAULT 0 NOT NULL,
    cancelled smallint DEFAULT 0 NOT NULL,
    date_cancelled timestamp without time zone,
    date_rated timestamp without time zone,
    date_reminded timestamp without time zone,
    quality smallint,
    review_round_id bigint NOT NULL,
    stage_id smallint NOT NULL,
    review_method smallint DEFAULT 1 NOT NULL,
    round smallint DEFAULT 1 NOT NULL,
    step smallint DEFAULT 1 NOT NULL,
    review_form_id bigint,
    considered smallint,
    request_resent smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.review_assignments OWNER TO adrianasofi;

--
-- Name: review_assignments_review_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.review_assignments_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.review_assignments_review_id_seq OWNER TO adrianasofi;

--
-- Name: review_assignments_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.review_assignments_review_id_seq OWNED BY public.review_assignments.review_id;


--
-- Name: review_files; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.review_files (
    review_file_id bigint NOT NULL,
    review_id bigint NOT NULL,
    submission_file_id bigint NOT NULL
);


ALTER TABLE public.review_files OWNER TO adrianasofi;

--
-- Name: review_files_review_file_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.review_files_review_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.review_files_review_file_id_seq OWNER TO adrianasofi;

--
-- Name: review_files_review_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.review_files_review_file_id_seq OWNED BY public.review_files.review_file_id;


--
-- Name: review_form_element_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.review_form_element_settings (
    review_form_element_setting_id bigint NOT NULL,
    review_form_element_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text,
    setting_type character varying(6) NOT NULL
);


ALTER TABLE public.review_form_element_settings OWNER TO adrianasofi;

--
-- Name: review_form_element_settings_review_form_element_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.review_form_element_settings_review_form_element_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.review_form_element_settings_review_form_element_setting_id_seq OWNER TO adrianasofi;

--
-- Name: review_form_element_settings_review_form_element_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.review_form_element_settings_review_form_element_setting_id_seq OWNED BY public.review_form_element_settings.review_form_element_setting_id;


--
-- Name: review_form_elements; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.review_form_elements (
    review_form_element_id bigint NOT NULL,
    review_form_id bigint NOT NULL,
    seq double precision,
    element_type bigint,
    required smallint,
    included smallint
);


ALTER TABLE public.review_form_elements OWNER TO adrianasofi;

--
-- Name: review_form_elements_review_form_element_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.review_form_elements_review_form_element_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.review_form_elements_review_form_element_id_seq OWNER TO adrianasofi;

--
-- Name: review_form_elements_review_form_element_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.review_form_elements_review_form_element_id_seq OWNED BY public.review_form_elements.review_form_element_id;


--
-- Name: review_form_responses; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.review_form_responses (
    review_form_response_id bigint NOT NULL,
    review_form_element_id bigint NOT NULL,
    review_id bigint NOT NULL,
    response_type character varying(6),
    response_value text
);


ALTER TABLE public.review_form_responses OWNER TO adrianasofi;

--
-- Name: review_form_responses_review_form_response_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.review_form_responses_review_form_response_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.review_form_responses_review_form_response_id_seq OWNER TO adrianasofi;

--
-- Name: review_form_responses_review_form_response_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.review_form_responses_review_form_response_id_seq OWNED BY public.review_form_responses.review_form_response_id;


--
-- Name: review_form_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.review_form_settings (
    review_form_setting_id bigint NOT NULL,
    review_form_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text,
    setting_type character varying(6) NOT NULL
);


ALTER TABLE public.review_form_settings OWNER TO adrianasofi;

--
-- Name: review_form_settings_review_form_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.review_form_settings_review_form_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.review_form_settings_review_form_setting_id_seq OWNER TO adrianasofi;

--
-- Name: review_form_settings_review_form_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.review_form_settings_review_form_setting_id_seq OWNED BY public.review_form_settings.review_form_setting_id;


--
-- Name: review_forms; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.review_forms (
    review_form_id bigint NOT NULL,
    assoc_type bigint NOT NULL,
    assoc_id bigint NOT NULL,
    seq double precision,
    is_active smallint
);


ALTER TABLE public.review_forms OWNER TO adrianasofi;

--
-- Name: review_forms_review_form_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.review_forms_review_form_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.review_forms_review_form_id_seq OWNER TO adrianasofi;

--
-- Name: review_forms_review_form_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.review_forms_review_form_id_seq OWNED BY public.review_forms.review_form_id;


--
-- Name: review_round_files; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.review_round_files (
    review_round_file_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    review_round_id bigint NOT NULL,
    stage_id smallint NOT NULL,
    submission_file_id bigint NOT NULL
);


ALTER TABLE public.review_round_files OWNER TO adrianasofi;

--
-- Name: review_round_files_review_round_file_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.review_round_files_review_round_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.review_round_files_review_round_file_id_seq OWNER TO adrianasofi;

--
-- Name: review_round_files_review_round_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.review_round_files_review_round_file_id_seq OWNED BY public.review_round_files.review_round_file_id;


--
-- Name: review_rounds; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.review_rounds (
    review_round_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    stage_id bigint,
    round smallint NOT NULL,
    review_revision bigint,
    status bigint
);


ALTER TABLE public.review_rounds OWNER TO adrianasofi;

--
-- Name: review_rounds_review_round_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.review_rounds_review_round_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.review_rounds_review_round_id_seq OWNER TO adrianasofi;

--
-- Name: review_rounds_review_round_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.review_rounds_review_round_id_seq OWNED BY public.review_rounds.review_round_id;


--
-- Name: reviewer_suggestion_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.reviewer_suggestion_settings (
    reviewer_suggestion_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.reviewer_suggestion_settings OWNER TO adrianasofi;

--
-- Name: reviewer_suggestions; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.reviewer_suggestions (
    reviewer_suggestion_id bigint NOT NULL,
    suggesting_user_id bigint,
    submission_id bigint NOT NULL,
    email character varying(255) NOT NULL,
    orcid_id character varying(255),
    approved_at timestamp without time zone,
    approver_id bigint,
    reviewer_id bigint,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.reviewer_suggestions OWNER TO adrianasofi;

--
-- Name: reviewer_suggestions_reviewer_suggestion_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.reviewer_suggestions_reviewer_suggestion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviewer_suggestions_reviewer_suggestion_id_seq OWNER TO adrianasofi;

--
-- Name: reviewer_suggestions_reviewer_suggestion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.reviewer_suggestions_reviewer_suggestion_id_seq OWNED BY public.reviewer_suggestions.reviewer_suggestion_id;


--
-- Name: ror_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.ror_settings (
    ror_setting_id bigint NOT NULL,
    ror_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.ror_settings OWNER TO adrianasofi;

--
-- Name: ror_settings_ror_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.ror_settings_ror_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ror_settings_ror_setting_id_seq OWNER TO adrianasofi;

--
-- Name: ror_settings_ror_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.ror_settings_ror_setting_id_seq OWNED BY public.ror_settings.ror_setting_id;


--
-- Name: rors; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.rors (
    ror_id bigint NOT NULL,
    ror character varying(255) NOT NULL,
    display_locale character varying(28) NOT NULL,
    is_active smallint DEFAULT 1 NOT NULL,
    search_phrase text
);


ALTER TABLE public.rors OWNER TO adrianasofi;

--
-- Name: rors_ror_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.rors_ror_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rors_ror_id_seq OWNER TO adrianasofi;

--
-- Name: rors_ror_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.rors_ror_id_seq OWNED BY public.rors.ror_id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: section_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.section_settings (
    section_setting_id bigint NOT NULL,
    section_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.section_settings OWNER TO adrianasofi;

--
-- Name: section_settings_section_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.section_settings_section_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.section_settings_section_setting_id_seq OWNER TO adrianasofi;

--
-- Name: section_settings_section_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.section_settings_section_setting_id_seq OWNED BY public.section_settings.section_setting_id;


--
-- Name: sections; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.sections (
    section_id bigint NOT NULL,
    journal_id bigint NOT NULL,
    review_form_id bigint,
    seq double precision DEFAULT 0 NOT NULL,
    editor_restricted smallint DEFAULT 0 NOT NULL,
    meta_indexed smallint DEFAULT 0 NOT NULL,
    meta_reviewed smallint DEFAULT 1 NOT NULL,
    abstracts_not_required smallint DEFAULT 0 NOT NULL,
    hide_title smallint DEFAULT 0 NOT NULL,
    hide_author smallint DEFAULT 0 NOT NULL,
    is_inactive smallint DEFAULT 0 NOT NULL,
    abstract_word_count bigint
);


ALTER TABLE public.sections OWNER TO adrianasofi;

--
-- Name: sections_section_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.sections_section_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sections_section_id_seq OWNER TO adrianasofi;

--
-- Name: sections_section_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.sections_section_id_seq OWNED BY public.sections.section_id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    last_activity integer NOT NULL,
    payload text NOT NULL
);


ALTER TABLE public.sessions OWNER TO adrianasofi;

--
-- Name: site; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.site (
    site_id bigint NOT NULL,
    redirect_context_id bigint,
    primary_locale character varying(28) NOT NULL,
    min_password_length smallint DEFAULT 6 NOT NULL,
    installed_locales character varying(1024) DEFAULT '''en'''::character varying NOT NULL,
    supported_locales character varying(1024),
    original_style_file_name character varying(255)
);


ALTER TABLE public.site OWNER TO adrianasofi;

--
-- Name: site_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.site_settings (
    site_setting_id bigint NOT NULL,
    setting_name character varying(255) NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_value text
);


ALTER TABLE public.site_settings OWNER TO adrianasofi;

--
-- Name: site_settings_site_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.site_settings_site_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.site_settings_site_setting_id_seq OWNER TO adrianasofi;

--
-- Name: site_settings_site_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.site_settings_site_setting_id_seq OWNED BY public.site_settings.site_setting_id;


--
-- Name: site_site_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.site_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.site_site_id_seq OWNER TO adrianasofi;

--
-- Name: site_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.site_site_id_seq OWNED BY public.site.site_id;


--
-- Name: stage_assignments; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.stage_assignments (
    stage_assignment_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    user_group_id bigint NOT NULL,
    user_id bigint NOT NULL,
    date_assigned timestamp without time zone NOT NULL,
    recommend_only smallint DEFAULT 0 NOT NULL,
    can_change_metadata smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.stage_assignments OWNER TO adrianasofi;

--
-- Name: stage_assignments_stage_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.stage_assignments_stage_assignment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stage_assignments_stage_assignment_id_seq OWNER TO adrianasofi;

--
-- Name: stage_assignments_stage_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.stage_assignments_stage_assignment_id_seq OWNED BY public.stage_assignments.stage_assignment_id;


--
-- Name: static_page_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.static_page_settings (
    static_page_setting_id bigint NOT NULL,
    static_page_id bigint NOT NULL,
    locale character varying(14) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text,
    setting_type character varying(6) NOT NULL
);


ALTER TABLE public.static_page_settings OWNER TO adrianasofi;

--
-- Name: static_page_settings_static_page_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.static_page_settings_static_page_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.static_page_settings_static_page_setting_id_seq OWNER TO adrianasofi;

--
-- Name: static_page_settings_static_page_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.static_page_settings_static_page_setting_id_seq OWNED BY public.static_page_settings.static_page_setting_id;


--
-- Name: static_pages; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.static_pages (
    static_page_id bigint NOT NULL,
    path character varying(255) NOT NULL,
    context_id bigint NOT NULL
);


ALTER TABLE public.static_pages OWNER TO adrianasofi;

--
-- Name: static_pages_static_page_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.static_pages_static_page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.static_pages_static_page_id_seq OWNER TO adrianasofi;

--
-- Name: static_pages_static_page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.static_pages_static_page_id_seq OWNED BY public.static_pages.static_page_id;


--
-- Name: subeditor_submission_group; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.subeditor_submission_group (
    subeditor_submission_group_id bigint NOT NULL,
    context_id bigint NOT NULL,
    assoc_id bigint NOT NULL,
    assoc_type bigint NOT NULL,
    user_id bigint NOT NULL,
    user_group_id bigint NOT NULL
);


ALTER TABLE public.subeditor_submission_group OWNER TO adrianasofi;

--
-- Name: subeditor_submission_group_subeditor_submission_group_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.subeditor_submission_group_subeditor_submission_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subeditor_submission_group_subeditor_submission_group_id_seq OWNER TO adrianasofi;

--
-- Name: subeditor_submission_group_subeditor_submission_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.subeditor_submission_group_subeditor_submission_group_id_seq OWNED BY public.subeditor_submission_group.subeditor_submission_group_id;


--
-- Name: submission_comments; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.submission_comments (
    comment_id bigint NOT NULL,
    comment_type bigint,
    role_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    assoc_id bigint NOT NULL,
    author_id bigint NOT NULL,
    comment_title text NOT NULL,
    comments text,
    date_posted timestamp without time zone,
    date_modified timestamp without time zone,
    viewable smallint
);


ALTER TABLE public.submission_comments OWNER TO adrianasofi;

--
-- Name: submission_comments_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.submission_comments_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.submission_comments_comment_id_seq OWNER TO adrianasofi;

--
-- Name: submission_comments_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.submission_comments_comment_id_seq OWNED BY public.submission_comments.comment_id;


--
-- Name: submission_file_revisions; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.submission_file_revisions (
    revision_id bigint NOT NULL,
    submission_file_id bigint NOT NULL,
    file_id bigint NOT NULL
);


ALTER TABLE public.submission_file_revisions OWNER TO adrianasofi;

--
-- Name: submission_file_revisions_revision_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.submission_file_revisions_revision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.submission_file_revisions_revision_id_seq OWNER TO adrianasofi;

--
-- Name: submission_file_revisions_revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.submission_file_revisions_revision_id_seq OWNED BY public.submission_file_revisions.revision_id;


--
-- Name: submission_file_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.submission_file_settings (
    submission_file_setting_id bigint NOT NULL,
    submission_file_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.submission_file_settings OWNER TO adrianasofi;

--
-- Name: submission_file_settings_submission_file_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.submission_file_settings_submission_file_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.submission_file_settings_submission_file_setting_id_seq OWNER TO adrianasofi;

--
-- Name: submission_file_settings_submission_file_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.submission_file_settings_submission_file_setting_id_seq OWNED BY public.submission_file_settings.submission_file_setting_id;


--
-- Name: submission_files; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.submission_files (
    submission_file_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    file_id bigint NOT NULL,
    source_submission_file_id bigint,
    genre_id bigint,
    file_stage bigint NOT NULL,
    direct_sales_price character varying(255),
    sales_type character varying(255),
    viewable smallint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    uploader_user_id bigint,
    assoc_type bigint,
    assoc_id bigint
);


ALTER TABLE public.submission_files OWNER TO adrianasofi;

--
-- Name: submission_files_submission_file_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.submission_files_submission_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.submission_files_submission_file_id_seq OWNER TO adrianasofi;

--
-- Name: submission_files_submission_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.submission_files_submission_file_id_seq OWNED BY public.submission_files.submission_file_id;


--
-- Name: submission_search_keyword_list; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.submission_search_keyword_list (
    keyword_id bigint NOT NULL,
    keyword_text character varying(60) NOT NULL
);


ALTER TABLE public.submission_search_keyword_list OWNER TO adrianasofi;

--
-- Name: submission_search_keyword_list_keyword_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.submission_search_keyword_list_keyword_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.submission_search_keyword_list_keyword_id_seq OWNER TO adrianasofi;

--
-- Name: submission_search_keyword_list_keyword_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.submission_search_keyword_list_keyword_id_seq OWNED BY public.submission_search_keyword_list.keyword_id;


--
-- Name: submission_search_object_keywords; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.submission_search_object_keywords (
    submission_search_object_keyword_id bigint NOT NULL,
    object_id bigint NOT NULL,
    keyword_id bigint NOT NULL,
    pos integer NOT NULL
);


ALTER TABLE public.submission_search_object_keywords OWNER TO adrianasofi;

--
-- Name: submission_search_object_keyw_submission_search_object_keyw_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.submission_search_object_keyw_submission_search_object_keyw_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.submission_search_object_keyw_submission_search_object_keyw_seq OWNER TO adrianasofi;

--
-- Name: submission_search_object_keyw_submission_search_object_keyw_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.submission_search_object_keyw_submission_search_object_keyw_seq OWNED BY public.submission_search_object_keywords.submission_search_object_keyword_id;


--
-- Name: submission_search_objects; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.submission_search_objects (
    object_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    type integer NOT NULL,
    assoc_id bigint
);


ALTER TABLE public.submission_search_objects OWNER TO adrianasofi;

--
-- Name: submission_search_objects_object_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.submission_search_objects_object_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.submission_search_objects_object_id_seq OWNER TO adrianasofi;

--
-- Name: submission_search_objects_object_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.submission_search_objects_object_id_seq OWNED BY public.submission_search_objects.object_id;


--
-- Name: submission_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.submission_settings (
    submission_setting_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.submission_settings OWNER TO adrianasofi;

--
-- Name: submission_settings_submission_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.submission_settings_submission_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.submission_settings_submission_setting_id_seq OWNER TO adrianasofi;

--
-- Name: submission_settings_submission_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.submission_settings_submission_setting_id_seq OWNED BY public.submission_settings.submission_setting_id;


--
-- Name: submissions; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.submissions (
    submission_id bigint NOT NULL,
    context_id bigint NOT NULL,
    current_publication_id bigint,
    date_last_activity timestamp without time zone,
    date_submitted timestamp without time zone,
    last_modified timestamp without time zone,
    stage_id bigint DEFAULT 1 NOT NULL,
    locale character varying(28),
    status smallint DEFAULT 1 NOT NULL,
    submission_progress character varying(50) DEFAULT '''start'''::character varying NOT NULL,
    work_type smallint DEFAULT 0
);


ALTER TABLE public.submissions OWNER TO adrianasofi;

--
-- Name: submissions_submission_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.submissions_submission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.submissions_submission_id_seq OWNER TO adrianasofi;

--
-- Name: submissions_submission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.submissions_submission_id_seq OWNED BY public.submissions.submission_id;


--
-- Name: subscription_type_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.subscription_type_settings (
    subscription_type_setting_id bigint NOT NULL,
    type_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text,
    setting_type character varying(6) NOT NULL
);


ALTER TABLE public.subscription_type_settings OWNER TO adrianasofi;

--
-- Name: subscription_type_settings_subscription_type_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.subscription_type_settings_subscription_type_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscription_type_settings_subscription_type_setting_id_seq OWNER TO adrianasofi;

--
-- Name: subscription_type_settings_subscription_type_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.subscription_type_settings_subscription_type_setting_id_seq OWNED BY public.subscription_type_settings.subscription_type_setting_id;


--
-- Name: subscription_types; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.subscription_types (
    type_id bigint NOT NULL,
    journal_id bigint NOT NULL,
    cost numeric(8,2) NOT NULL,
    currency_code_alpha character varying(3) NOT NULL,
    duration smallint,
    format smallint NOT NULL,
    institutional smallint DEFAULT 0 NOT NULL,
    membership smallint DEFAULT 0 NOT NULL,
    disable_public_display smallint NOT NULL,
    seq double precision NOT NULL
);


ALTER TABLE public.subscription_types OWNER TO adrianasofi;

--
-- Name: subscription_types_type_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.subscription_types_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscription_types_type_id_seq OWNER TO adrianasofi;

--
-- Name: subscription_types_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.subscription_types_type_id_seq OWNED BY public.subscription_types.type_id;


--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.subscriptions (
    subscription_id bigint NOT NULL,
    journal_id bigint NOT NULL,
    user_id bigint NOT NULL,
    type_id bigint NOT NULL,
    date_start date,
    date_end timestamp without time zone,
    status smallint DEFAULT 1 NOT NULL,
    membership character varying(40),
    reference_number character varying(40),
    notes text
);


ALTER TABLE public.subscriptions OWNER TO adrianasofi;

--
-- Name: subscriptions_subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.subscriptions_subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscriptions_subscription_id_seq OWNER TO adrianasofi;

--
-- Name: subscriptions_subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.subscriptions_subscription_id_seq OWNED BY public.subscriptions.subscription_id;


--
-- Name: temporary_files; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.temporary_files (
    file_id bigint NOT NULL,
    user_id bigint NOT NULL,
    file_name character varying(90) NOT NULL,
    file_type character varying(255),
    file_size bigint NOT NULL,
    original_file_name character varying(127),
    date_uploaded timestamp without time zone NOT NULL
);


ALTER TABLE public.temporary_files OWNER TO adrianasofi;

--
-- Name: temporary_files_file_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.temporary_files_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.temporary_files_file_id_seq OWNER TO adrianasofi;

--
-- Name: temporary_files_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.temporary_files_file_id_seq OWNED BY public.temporary_files.file_id;


--
-- Name: usage_stats_institution_temporary_records; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.usage_stats_institution_temporary_records (
    usage_stats_temp_institution_id bigint NOT NULL,
    load_id character varying(50) NOT NULL,
    line_number bigint NOT NULL,
    institution_id bigint NOT NULL
);


ALTER TABLE public.usage_stats_institution_temporary_records OWNER TO adrianasofi;

--
-- Name: usage_stats_institution_tempo_usage_stats_temp_institution__seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.usage_stats_institution_tempo_usage_stats_temp_institution__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usage_stats_institution_tempo_usage_stats_temp_institution__seq OWNER TO adrianasofi;

--
-- Name: usage_stats_institution_tempo_usage_stats_temp_institution__seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.usage_stats_institution_tempo_usage_stats_temp_institution__seq OWNED BY public.usage_stats_institution_temporary_records.usage_stats_temp_institution_id;


--
-- Name: usage_stats_total_temporary_records; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.usage_stats_total_temporary_records (
    usage_stats_temp_total_id bigint NOT NULL,
    date timestamp without time zone NOT NULL,
    ip character varying(64) NOT NULL,
    user_agent character varying(255) NOT NULL,
    line_number bigint NOT NULL,
    canonical_url character varying(255) NOT NULL,
    issue_id bigint,
    issue_galley_id bigint,
    context_id bigint NOT NULL,
    submission_id bigint,
    representation_id bigint,
    submission_file_id bigint,
    assoc_type bigint NOT NULL,
    file_type smallint,
    country character varying(2) DEFAULT ''''''::character varying NOT NULL,
    region character varying(3) DEFAULT ''''''::character varying NOT NULL,
    city character varying(255) DEFAULT ''''''::character varying NOT NULL,
    load_id character varying(50) NOT NULL
);


ALTER TABLE public.usage_stats_total_temporary_records OWNER TO adrianasofi;

--
-- Name: usage_stats_total_temporary_recor_usage_stats_temp_total_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.usage_stats_total_temporary_recor_usage_stats_temp_total_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usage_stats_total_temporary_recor_usage_stats_temp_total_id_seq OWNER TO adrianasofi;

--
-- Name: usage_stats_total_temporary_recor_usage_stats_temp_total_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.usage_stats_total_temporary_recor_usage_stats_temp_total_id_seq OWNED BY public.usage_stats_total_temporary_records.usage_stats_temp_total_id;


--
-- Name: usage_stats_unique_item_investigations_temporary_records; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.usage_stats_unique_item_investigations_temporary_records (
    usage_stats_temp_unique_item_id bigint NOT NULL,
    date timestamp without time zone NOT NULL,
    ip character varying(64) NOT NULL,
    user_agent character varying(255) NOT NULL,
    line_number bigint NOT NULL,
    context_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    representation_id bigint,
    submission_file_id bigint,
    assoc_type bigint NOT NULL,
    file_type smallint,
    country character varying(2) DEFAULT ''''''::character varying NOT NULL,
    region character varying(3) DEFAULT ''''''::character varying NOT NULL,
    city character varying(255) DEFAULT ''''''::character varying NOT NULL,
    load_id character varying(50) NOT NULL
);


ALTER TABLE public.usage_stats_unique_item_investigations_temporary_records OWNER TO adrianasofi;

--
-- Name: usage_stats_unique_item_inves_usage_stats_temp_unique_item__seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.usage_stats_unique_item_inves_usage_stats_temp_unique_item__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usage_stats_unique_item_inves_usage_stats_temp_unique_item__seq OWNER TO adrianasofi;

--
-- Name: usage_stats_unique_item_inves_usage_stats_temp_unique_item__seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.usage_stats_unique_item_inves_usage_stats_temp_unique_item__seq OWNED BY public.usage_stats_unique_item_investigations_temporary_records.usage_stats_temp_unique_item_id;


--
-- Name: usage_stats_unique_item_requests_temporary_records; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.usage_stats_unique_item_requests_temporary_records (
    usage_stats_temp_item_id bigint NOT NULL,
    date timestamp without time zone NOT NULL,
    ip character varying(64) NOT NULL,
    user_agent character varying(255) NOT NULL,
    line_number bigint NOT NULL,
    context_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    representation_id bigint,
    submission_file_id bigint,
    assoc_type bigint NOT NULL,
    file_type smallint,
    country character varying(2) DEFAULT ''''''::character varying NOT NULL,
    region character varying(3) DEFAULT ''''''::character varying NOT NULL,
    city character varying(255) DEFAULT ''''''::character varying NOT NULL,
    load_id character varying(50) NOT NULL
);


ALTER TABLE public.usage_stats_unique_item_requests_temporary_records OWNER TO adrianasofi;

--
-- Name: usage_stats_unique_item_requests_t_usage_stats_temp_item_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.usage_stats_unique_item_requests_t_usage_stats_temp_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usage_stats_unique_item_requests_t_usage_stats_temp_item_id_seq OWNER TO adrianasofi;

--
-- Name: usage_stats_unique_item_requests_t_usage_stats_temp_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.usage_stats_unique_item_requests_t_usage_stats_temp_item_id_seq OWNED BY public.usage_stats_unique_item_requests_temporary_records.usage_stats_temp_item_id;


--
-- Name: user_group_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.user_group_settings (
    user_group_setting_id bigint NOT NULL,
    user_group_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.user_group_settings OWNER TO adrianasofi;

--
-- Name: user_group_settings_user_group_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.user_group_settings_user_group_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_group_settings_user_group_setting_id_seq OWNER TO adrianasofi;

--
-- Name: user_group_settings_user_group_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.user_group_settings_user_group_setting_id_seq OWNED BY public.user_group_settings.user_group_setting_id;


--
-- Name: user_group_stage; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.user_group_stage (
    user_group_stage_id bigint NOT NULL,
    context_id bigint NOT NULL,
    user_group_id bigint NOT NULL,
    stage_id bigint NOT NULL
);


ALTER TABLE public.user_group_stage OWNER TO adrianasofi;

--
-- Name: user_group_stage_user_group_stage_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.user_group_stage_user_group_stage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_group_stage_user_group_stage_id_seq OWNER TO adrianasofi;

--
-- Name: user_group_stage_user_group_stage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.user_group_stage_user_group_stage_id_seq OWNED BY public.user_group_stage.user_group_stage_id;


--
-- Name: user_groups; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.user_groups (
    user_group_id bigint NOT NULL,
    context_id bigint,
    role_id bigint NOT NULL,
    is_default smallint DEFAULT 0 NOT NULL,
    show_title smallint DEFAULT 1 NOT NULL,
    permit_self_registration smallint DEFAULT 0 NOT NULL,
    permit_metadata_edit smallint DEFAULT 0 NOT NULL,
    permit_settings smallint DEFAULT 0 NOT NULL,
    masthead smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_groups OWNER TO adrianasofi;

--
-- Name: user_groups_user_group_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.user_groups_user_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_groups_user_group_id_seq OWNER TO adrianasofi;

--
-- Name: user_groups_user_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.user_groups_user_group_id_seq OWNED BY public.user_groups.user_group_id;


--
-- Name: user_interests; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.user_interests (
    user_interest_id bigint NOT NULL,
    user_id bigint NOT NULL,
    controlled_vocab_entry_id bigint NOT NULL
);


ALTER TABLE public.user_interests OWNER TO adrianasofi;

--
-- Name: user_interests_user_interest_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.user_interests_user_interest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_interests_user_interest_id_seq OWNER TO adrianasofi;

--
-- Name: user_interests_user_interest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.user_interests_user_interest_id_seq OWNED BY public.user_interests.user_interest_id;


--
-- Name: user_settings; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.user_settings (
    user_setting_id bigint NOT NULL,
    user_id bigint NOT NULL,
    locale character varying(28) DEFAULT ''''''::character varying NOT NULL,
    setting_name character varying(255) NOT NULL,
    setting_value text
);


ALTER TABLE public.user_settings OWNER TO adrianasofi;

--
-- Name: user_settings_user_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.user_settings_user_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_settings_user_setting_id_seq OWNER TO adrianasofi;

--
-- Name: user_settings_user_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.user_settings_user_setting_id_seq OWNED BY public.user_settings.user_setting_id;


--
-- Name: user_user_groups; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.user_user_groups (
    user_user_group_id bigint NOT NULL,
    user_group_id bigint NOT NULL,
    user_id bigint NOT NULL,
    date_start timestamp without time zone,
    date_end timestamp without time zone,
    masthead smallint
);


ALTER TABLE public.user_user_groups OWNER TO adrianasofi;

--
-- Name: user_user_groups_user_user_group_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.user_user_groups_user_user_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_user_groups_user_user_group_id_seq OWNER TO adrianasofi;

--
-- Name: user_user_groups_user_user_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.user_user_groups_user_user_group_id_seq OWNED BY public.user_user_groups.user_user_group_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.users (
    user_id bigint NOT NULL,
    username character varying(32) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    url character varying(2047),
    phone character varying(32),
    mailing_address character varying(255),
    billing_address character varying(255),
    country character varying(90),
    locales character varying(255) DEFAULT '''[]'''::character varying NOT NULL,
    gossip text,
    date_last_email timestamp without time zone,
    date_registered timestamp without time zone NOT NULL,
    date_validated timestamp without time zone,
    date_last_login timestamp without time zone,
    must_change_password smallint,
    auth_id bigint,
    auth_str character varying(255),
    disabled smallint DEFAULT 0 NOT NULL,
    disabled_reason text,
    inline_help smallint,
    remember_token character varying(100)
);


ALTER TABLE public.users OWNER TO adrianasofi;

--
-- Name: users_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_tokens (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    token bytea NOT NULL,
    context character varying(255) NOT NULL,
    sent_to character varying(255),
    authenticated_at timestamp(0) without time zone,
    inserted_at timestamp(0) without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users_tokens OWNER TO postgres;

--
-- Name: users_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_tokens_id_seq OWNER TO postgres;

--
-- Name: users_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_tokens_id_seq OWNED BY public.users_tokens.id;


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO adrianasofi;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: adrianasofi
--

CREATE TABLE public.versions (
    version_id bigint NOT NULL,
    major integer DEFAULT 0 NOT NULL,
    minor integer DEFAULT 0 NOT NULL,
    revision integer DEFAULT 0 NOT NULL,
    build integer DEFAULT 0 NOT NULL,
    date_installed timestamp without time zone NOT NULL,
    current smallint DEFAULT 0 NOT NULL,
    product_type character varying(30),
    product character varying(30),
    product_class_name character varying(80),
    lazy_load smallint DEFAULT 0 NOT NULL,
    sitewide smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.versions OWNER TO adrianasofi;

--
-- Name: versions_version_id_seq; Type: SEQUENCE; Schema: public; Owner: adrianasofi
--

CREATE SEQUENCE public.versions_version_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.versions_version_id_seq OWNER TO adrianasofi;

--
-- Name: versions_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adrianasofi
--

ALTER SEQUENCE public.versions_version_id_seq OWNED BY public.versions.version_id;


--
-- Name: announcement_settings announcement_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.announcement_settings ALTER COLUMN announcement_setting_id SET DEFAULT nextval('public.announcement_settings_announcement_setting_id_seq'::regclass);


--
-- Name: announcement_type_settings announcement_type_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.announcement_type_settings ALTER COLUMN announcement_type_setting_id SET DEFAULT nextval('public.announcement_type_settings_announcement_type_setting_id_seq'::regclass);


--
-- Name: announcement_types type_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.announcement_types ALTER COLUMN type_id SET DEFAULT nextval('public.announcement_types_type_id_seq'::regclass);


--
-- Name: announcements announcement_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.announcements ALTER COLUMN announcement_id SET DEFAULT nextval('public.announcements_announcement_id_seq'::regclass);


--
-- Name: author_affiliation_settings author_affiliation_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.author_affiliation_settings ALTER COLUMN author_affiliation_setting_id SET DEFAULT nextval('public.author_affiliation_settings_author_affiliation_setting_id_seq'::regclass);


--
-- Name: author_affiliations author_affiliation_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.author_affiliations ALTER COLUMN author_affiliation_id SET DEFAULT nextval('public.author_affiliations_author_affiliation_id_seq'::regclass);


--
-- Name: author_settings author_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.author_settings ALTER COLUMN author_setting_id SET DEFAULT nextval('public.author_settings_author_setting_id_seq'::regclass);


--
-- Name: authors author_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.authors ALTER COLUMN author_id SET DEFAULT nextval('public.authors_author_id_seq'::regclass);


--
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- Name: category_settings category_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.category_settings ALTER COLUMN category_setting_id SET DEFAULT nextval('public.category_settings_category_setting_id_seq'::regclass);


--
-- Name: citation_settings citation_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.citation_settings ALTER COLUMN citation_setting_id SET DEFAULT nextval('public.citation_settings_citation_setting_id_seq'::regclass);


--
-- Name: citations citation_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.citations ALTER COLUMN citation_id SET DEFAULT nextval('public.citations_citation_id_seq'::regclass);


--
-- Name: completed_payments completed_payment_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.completed_payments ALTER COLUMN completed_payment_id SET DEFAULT nextval('public.completed_payments_completed_payment_id_seq'::regclass);


--
-- Name: controlled_vocab_entries controlled_vocab_entry_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.controlled_vocab_entries ALTER COLUMN controlled_vocab_entry_id SET DEFAULT nextval('public.controlled_vocab_entries_controlled_vocab_entry_id_seq'::regclass);


--
-- Name: controlled_vocab_entry_settings controlled_vocab_entry_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.controlled_vocab_entry_settings ALTER COLUMN controlled_vocab_entry_setting_id SET DEFAULT nextval('public.controlled_vocab_entry_settin_controlled_vocab_entry_settin_seq'::regclass);


--
-- Name: controlled_vocabs controlled_vocab_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.controlled_vocabs ALTER COLUMN controlled_vocab_id SET DEFAULT nextval('public.controlled_vocabs_controlled_vocab_id_seq'::regclass);


--
-- Name: custom_issue_orders custom_issue_order_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.custom_issue_orders ALTER COLUMN custom_issue_order_id SET DEFAULT nextval('public.custom_issue_orders_custom_issue_order_id_seq'::regclass);


--
-- Name: custom_section_orders custom_section_order_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.custom_section_orders ALTER COLUMN custom_section_order_id SET DEFAULT nextval('public.custom_section_orders_custom_section_order_id_seq'::regclass);


--
-- Name: data_object_tombstone_oai_set_objects object_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.data_object_tombstone_oai_set_objects ALTER COLUMN object_id SET DEFAULT nextval('public.data_object_tombstone_oai_set_objects_object_id_seq'::regclass);


--
-- Name: data_object_tombstone_settings tombstone_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.data_object_tombstone_settings ALTER COLUMN tombstone_setting_id SET DEFAULT nextval('public.data_object_tombstone_settings_tombstone_setting_id_seq'::regclass);


--
-- Name: data_object_tombstones tombstone_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.data_object_tombstones ALTER COLUMN tombstone_id SET DEFAULT nextval('public.data_object_tombstones_tombstone_id_seq'::regclass);


--
-- Name: doi_settings doi_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.doi_settings ALTER COLUMN doi_setting_id SET DEFAULT nextval('public.doi_settings_doi_setting_id_seq'::regclass);


--
-- Name: dois doi_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.dois ALTER COLUMN doi_id SET DEFAULT nextval('public.dois_doi_id_seq'::regclass);


--
-- Name: edit_decisions edit_decision_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.edit_decisions ALTER COLUMN edit_decision_id SET DEFAULT nextval('public.edit_decisions_edit_decision_id_seq'::regclass);


--
-- Name: email_log log_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.email_log ALTER COLUMN log_id SET DEFAULT nextval('public.email_log_log_id_seq'::regclass);


--
-- Name: email_log_users email_log_user_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.email_log_users ALTER COLUMN email_log_user_id SET DEFAULT nextval('public.email_log_users_email_log_user_id_seq'::regclass);


--
-- Name: email_templates email_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.email_templates ALTER COLUMN email_id SET DEFAULT nextval('public.email_templates_email_id_seq'::regclass);


--
-- Name: email_templates_default_data email_templates_default_data_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.email_templates_default_data ALTER COLUMN email_templates_default_data_id SET DEFAULT nextval('public.email_templates_default_data_email_templates_default_data_i_seq'::regclass);


--
-- Name: email_templates_settings email_template_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.email_templates_settings ALTER COLUMN email_template_setting_id SET DEFAULT nextval('public.email_templates_settings_email_template_setting_id_seq'::regclass);


--
-- Name: event_log log_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.event_log ALTER COLUMN log_id SET DEFAULT nextval('public.event_log_log_id_seq'::regclass);


--
-- Name: event_log_settings event_log_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.event_log_settings ALTER COLUMN event_log_setting_id SET DEFAULT nextval('public.event_log_settings_event_log_setting_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: files file_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.files ALTER COLUMN file_id SET DEFAULT nextval('public.files_file_id_seq'::regclass);


--
-- Name: filter_groups filter_group_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.filter_groups ALTER COLUMN filter_group_id SET DEFAULT nextval('public.filter_groups_filter_group_id_seq'::regclass);


--
-- Name: filter_settings filter_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.filter_settings ALTER COLUMN filter_setting_id SET DEFAULT nextval('public.filter_settings_filter_setting_id_seq'::regclass);


--
-- Name: filters filter_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.filters ALTER COLUMN filter_id SET DEFAULT nextval('public.filters_filter_id_seq'::regclass);


--
-- Name: genre_settings genre_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.genre_settings ALTER COLUMN genre_setting_id SET DEFAULT nextval('public.genre_settings_genre_setting_id_seq'::regclass);


--
-- Name: genres genre_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.genres ALTER COLUMN genre_id SET DEFAULT nextval('public.genres_genre_id_seq'::regclass);


--
-- Name: highlight_settings highlight_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.highlight_settings ALTER COLUMN highlight_setting_id SET DEFAULT nextval('public.highlight_settings_highlight_setting_id_seq'::regclass);


--
-- Name: highlights highlight_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.highlights ALTER COLUMN highlight_id SET DEFAULT nextval('public.highlights_highlight_id_seq'::regclass);


--
-- Name: institution_ip institution_ip_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.institution_ip ALTER COLUMN institution_ip_id SET DEFAULT nextval('public.institution_ip_institution_ip_id_seq'::regclass);


--
-- Name: institution_settings institution_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.institution_settings ALTER COLUMN institution_setting_id SET DEFAULT nextval('public.institution_settings_institution_setting_id_seq'::regclass);


--
-- Name: institutional_subscriptions institutional_subscription_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.institutional_subscriptions ALTER COLUMN institutional_subscription_id SET DEFAULT nextval('public.institutional_subscriptions_institutional_subscription_id_seq'::regclass);


--
-- Name: institutions institution_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.institutions ALTER COLUMN institution_id SET DEFAULT nextval('public.institutions_institution_id_seq'::regclass);


--
-- Name: invitations invitation_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.invitations ALTER COLUMN invitation_id SET DEFAULT nextval('public.invitations_invitation_id_seq'::regclass);


--
-- Name: issue_files file_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.issue_files ALTER COLUMN file_id SET DEFAULT nextval('public.issue_files_file_id_seq'::regclass);


--
-- Name: issue_galley_settings issue_galley_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.issue_galley_settings ALTER COLUMN issue_galley_setting_id SET DEFAULT nextval('public.issue_galley_settings_issue_galley_setting_id_seq'::regclass);


--
-- Name: issue_galleys galley_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.issue_galleys ALTER COLUMN galley_id SET DEFAULT nextval('public.issue_galleys_galley_id_seq'::regclass);


--
-- Name: issue_settings issue_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.issue_settings ALTER COLUMN issue_setting_id SET DEFAULT nextval('public.issue_settings_issue_setting_id_seq'::regclass);


--
-- Name: issues issue_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.issues ALTER COLUMN issue_id SET DEFAULT nextval('public.issues_issue_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: journal_settings journal_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.journal_settings ALTER COLUMN journal_setting_id SET DEFAULT nextval('public.journal_settings_journal_setting_id_seq'::regclass);


--
-- Name: journals journal_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.journals ALTER COLUMN journal_id SET DEFAULT nextval('public.journals_journal_id_seq'::regclass);


--
-- Name: library_file_settings library_file_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.library_file_settings ALTER COLUMN library_file_setting_id SET DEFAULT nextval('public.library_file_settings_library_file_setting_id_seq'::regclass);


--
-- Name: library_files file_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.library_files ALTER COLUMN file_id SET DEFAULT nextval('public.library_files_file_id_seq'::regclass);


--
-- Name: metrics_context metrics_context_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_context ALTER COLUMN metrics_context_id SET DEFAULT nextval('public.metrics_context_metrics_context_id_seq'::regclass);


--
-- Name: metrics_counter_submission_daily metrics_counter_submission_daily_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_counter_submission_daily ALTER COLUMN metrics_counter_submission_daily_id SET DEFAULT nextval('public.metrics_counter_submission_da_metrics_counter_submission_da_seq'::regclass);


--
-- Name: metrics_counter_submission_institution_daily metrics_counter_submission_institution_daily_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_counter_submission_institution_daily ALTER COLUMN metrics_counter_submission_institution_daily_id SET DEFAULT nextval('public.metrics_counter_submission_in_metrics_counter_submission_in_seq'::regclass);


--
-- Name: metrics_counter_submission_institution_monthly metrics_counter_submission_institution_monthly_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_counter_submission_institution_monthly ALTER COLUMN metrics_counter_submission_institution_monthly_id SET DEFAULT nextval('public.metrics_counter_submission_in_metrics_counter_submission_i_seq1'::regclass);


--
-- Name: metrics_counter_submission_monthly metrics_counter_submission_monthly_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_counter_submission_monthly ALTER COLUMN metrics_counter_submission_monthly_id SET DEFAULT nextval('public.metrics_counter_submission_mo_metrics_counter_submission_mo_seq'::regclass);


--
-- Name: metrics_issue metrics_issue_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_issue ALTER COLUMN metrics_issue_id SET DEFAULT nextval('public.metrics_issue_metrics_issue_id_seq'::regclass);


--
-- Name: metrics_submission metrics_submission_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_submission ALTER COLUMN metrics_submission_id SET DEFAULT nextval('public.metrics_submission_metrics_submission_id_seq'::regclass);


--
-- Name: metrics_submission_geo_daily metrics_submission_geo_daily_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_submission_geo_daily ALTER COLUMN metrics_submission_geo_daily_id SET DEFAULT nextval('public.metrics_submission_geo_daily_metrics_submission_geo_daily_i_seq'::regclass);


--
-- Name: metrics_submission_geo_monthly metrics_submission_geo_monthly_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_submission_geo_monthly ALTER COLUMN metrics_submission_geo_monthly_id SET DEFAULT nextval('public.metrics_submission_geo_monthl_metrics_submission_geo_monthl_seq'::regclass);


--
-- Name: navigation_menu_item_assignment_settings navigation_menu_item_assignment_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.navigation_menu_item_assignment_settings ALTER COLUMN navigation_menu_item_assignment_setting_id SET DEFAULT nextval('public.navigation_menu_item_assignme_navigation_menu_item_assignm_seq1'::regclass);


--
-- Name: navigation_menu_item_assignments navigation_menu_item_assignment_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.navigation_menu_item_assignments ALTER COLUMN navigation_menu_item_assignment_id SET DEFAULT nextval('public.navigation_menu_item_assignme_navigation_menu_item_assignme_seq'::regclass);


--
-- Name: navigation_menu_item_settings navigation_menu_item_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.navigation_menu_item_settings ALTER COLUMN navigation_menu_item_setting_id SET DEFAULT nextval('public.navigation_menu_item_settings_navigation_menu_item_setting__seq'::regclass);


--
-- Name: navigation_menu_items navigation_menu_item_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.navigation_menu_items ALTER COLUMN navigation_menu_item_id SET DEFAULT nextval('public.navigation_menu_items_navigation_menu_item_id_seq'::regclass);


--
-- Name: navigation_menus navigation_menu_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.navigation_menus ALTER COLUMN navigation_menu_id SET DEFAULT nextval('public.navigation_menus_navigation_menu_id_seq'::regclass);


--
-- Name: notes note_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.notes ALTER COLUMN note_id SET DEFAULT nextval('public.notes_note_id_seq'::regclass);


--
-- Name: notification_settings notification_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.notification_settings ALTER COLUMN notification_setting_id SET DEFAULT nextval('public.notification_settings_notification_setting_id_seq'::regclass);


--
-- Name: notification_subscription_settings setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.notification_subscription_settings ALTER COLUMN setting_id SET DEFAULT nextval('public.notification_subscription_settings_setting_id_seq'::regclass);


--
-- Name: notifications notification_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.notifications ALTER COLUMN notification_id SET DEFAULT nextval('public.notifications_notification_id_seq'::regclass);


--
-- Name: oai_resumption_tokens oai_resumption_token_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.oai_resumption_tokens ALTER COLUMN oai_resumption_token_id SET DEFAULT nextval('public.oai_resumption_tokens_oai_resumption_token_id_seq'::regclass);


--
-- Name: plugin_settings plugin_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.plugin_settings ALTER COLUMN plugin_setting_id SET DEFAULT nextval('public.plugin_settings_plugin_setting_id_seq'::regclass);


--
-- Name: publication_categories publication_category_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.publication_categories ALTER COLUMN publication_category_id SET DEFAULT nextval('public.publication_categories_publication_category_id_seq'::regclass);


--
-- Name: publication_galley_settings publication_galley_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.publication_galley_settings ALTER COLUMN publication_galley_setting_id SET DEFAULT nextval('public.publication_galley_settings_publication_galley_setting_id_seq'::regclass);


--
-- Name: publication_galleys galley_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.publication_galleys ALTER COLUMN galley_id SET DEFAULT nextval('public.publication_galleys_galley_id_seq'::regclass);


--
-- Name: publication_settings publication_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.publication_settings ALTER COLUMN publication_setting_id SET DEFAULT nextval('public.publication_settings_publication_setting_id_seq'::regclass);


--
-- Name: publications publication_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.publications ALTER COLUMN publication_id SET DEFAULT nextval('public.publications_publication_id_seq'::regclass);


--
-- Name: queries query_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.queries ALTER COLUMN query_id SET DEFAULT nextval('public.queries_query_id_seq'::regclass);


--
-- Name: query_participants query_participant_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.query_participants ALTER COLUMN query_participant_id SET DEFAULT nextval('public.query_participants_query_participant_id_seq'::regclass);


--
-- Name: queued_payments queued_payment_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.queued_payments ALTER COLUMN queued_payment_id SET DEFAULT nextval('public.queued_payments_queued_payment_id_seq'::regclass);


--
-- Name: review_assignment_settings review_assignment_settings_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_assignment_settings ALTER COLUMN review_assignment_settings_id SET DEFAULT nextval('public.review_assignment_settings_review_assignment_settings_id_seq'::regclass);


--
-- Name: review_assignments review_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_assignments ALTER COLUMN review_id SET DEFAULT nextval('public.review_assignments_review_id_seq'::regclass);


--
-- Name: review_files review_file_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_files ALTER COLUMN review_file_id SET DEFAULT nextval('public.review_files_review_file_id_seq'::regclass);


--
-- Name: review_form_element_settings review_form_element_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_form_element_settings ALTER COLUMN review_form_element_setting_id SET DEFAULT nextval('public.review_form_element_settings_review_form_element_setting_id_seq'::regclass);


--
-- Name: review_form_elements review_form_element_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_form_elements ALTER COLUMN review_form_element_id SET DEFAULT nextval('public.review_form_elements_review_form_element_id_seq'::regclass);


--
-- Name: review_form_responses review_form_response_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_form_responses ALTER COLUMN review_form_response_id SET DEFAULT nextval('public.review_form_responses_review_form_response_id_seq'::regclass);


--
-- Name: review_form_settings review_form_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_form_settings ALTER COLUMN review_form_setting_id SET DEFAULT nextval('public.review_form_settings_review_form_setting_id_seq'::regclass);


--
-- Name: review_forms review_form_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_forms ALTER COLUMN review_form_id SET DEFAULT nextval('public.review_forms_review_form_id_seq'::regclass);


--
-- Name: review_round_files review_round_file_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_round_files ALTER COLUMN review_round_file_id SET DEFAULT nextval('public.review_round_files_review_round_file_id_seq'::regclass);


--
-- Name: review_rounds review_round_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_rounds ALTER COLUMN review_round_id SET DEFAULT nextval('public.review_rounds_review_round_id_seq'::regclass);


--
-- Name: reviewer_suggestions reviewer_suggestion_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.reviewer_suggestions ALTER COLUMN reviewer_suggestion_id SET DEFAULT nextval('public.reviewer_suggestions_reviewer_suggestion_id_seq'::regclass);


--
-- Name: ror_settings ror_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.ror_settings ALTER COLUMN ror_setting_id SET DEFAULT nextval('public.ror_settings_ror_setting_id_seq'::regclass);


--
-- Name: rors ror_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.rors ALTER COLUMN ror_id SET DEFAULT nextval('public.rors_ror_id_seq'::regclass);


--
-- Name: section_settings section_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.section_settings ALTER COLUMN section_setting_id SET DEFAULT nextval('public.section_settings_section_setting_id_seq'::regclass);


--
-- Name: sections section_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.sections ALTER COLUMN section_id SET DEFAULT nextval('public.sections_section_id_seq'::regclass);


--
-- Name: site site_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.site ALTER COLUMN site_id SET DEFAULT nextval('public.site_site_id_seq'::regclass);


--
-- Name: site_settings site_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.site_settings ALTER COLUMN site_setting_id SET DEFAULT nextval('public.site_settings_site_setting_id_seq'::regclass);


--
-- Name: stage_assignments stage_assignment_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.stage_assignments ALTER COLUMN stage_assignment_id SET DEFAULT nextval('public.stage_assignments_stage_assignment_id_seq'::regclass);


--
-- Name: static_page_settings static_page_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.static_page_settings ALTER COLUMN static_page_setting_id SET DEFAULT nextval('public.static_page_settings_static_page_setting_id_seq'::regclass);


--
-- Name: static_pages static_page_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.static_pages ALTER COLUMN static_page_id SET DEFAULT nextval('public.static_pages_static_page_id_seq'::regclass);


--
-- Name: subeditor_submission_group subeditor_submission_group_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.subeditor_submission_group ALTER COLUMN subeditor_submission_group_id SET DEFAULT nextval('public.subeditor_submission_group_subeditor_submission_group_id_seq'::regclass);


--
-- Name: submission_comments comment_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_comments ALTER COLUMN comment_id SET DEFAULT nextval('public.submission_comments_comment_id_seq'::regclass);


--
-- Name: submission_file_revisions revision_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_file_revisions ALTER COLUMN revision_id SET DEFAULT nextval('public.submission_file_revisions_revision_id_seq'::regclass);


--
-- Name: submission_file_settings submission_file_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_file_settings ALTER COLUMN submission_file_setting_id SET DEFAULT nextval('public.submission_file_settings_submission_file_setting_id_seq'::regclass);


--
-- Name: submission_files submission_file_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_files ALTER COLUMN submission_file_id SET DEFAULT nextval('public.submission_files_submission_file_id_seq'::regclass);


--
-- Name: submission_search_keyword_list keyword_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_search_keyword_list ALTER COLUMN keyword_id SET DEFAULT nextval('public.submission_search_keyword_list_keyword_id_seq'::regclass);


--
-- Name: submission_search_object_keywords submission_search_object_keyword_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_search_object_keywords ALTER COLUMN submission_search_object_keyword_id SET DEFAULT nextval('public.submission_search_object_keyw_submission_search_object_keyw_seq'::regclass);


--
-- Name: submission_search_objects object_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_search_objects ALTER COLUMN object_id SET DEFAULT nextval('public.submission_search_objects_object_id_seq'::regclass);


--
-- Name: submission_settings submission_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_settings ALTER COLUMN submission_setting_id SET DEFAULT nextval('public.submission_settings_submission_setting_id_seq'::regclass);


--
-- Name: submissions submission_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submissions ALTER COLUMN submission_id SET DEFAULT nextval('public.submissions_submission_id_seq'::regclass);


--
-- Name: subscription_type_settings subscription_type_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.subscription_type_settings ALTER COLUMN subscription_type_setting_id SET DEFAULT nextval('public.subscription_type_settings_subscription_type_setting_id_seq'::regclass);


--
-- Name: subscription_types type_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.subscription_types ALTER COLUMN type_id SET DEFAULT nextval('public.subscription_types_type_id_seq'::regclass);


--
-- Name: subscriptions subscription_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.subscriptions ALTER COLUMN subscription_id SET DEFAULT nextval('public.subscriptions_subscription_id_seq'::regclass);


--
-- Name: temporary_files file_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.temporary_files ALTER COLUMN file_id SET DEFAULT nextval('public.temporary_files_file_id_seq'::regclass);


--
-- Name: usage_stats_institution_temporary_records usage_stats_temp_institution_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.usage_stats_institution_temporary_records ALTER COLUMN usage_stats_temp_institution_id SET DEFAULT nextval('public.usage_stats_institution_tempo_usage_stats_temp_institution__seq'::regclass);


--
-- Name: usage_stats_total_temporary_records usage_stats_temp_total_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.usage_stats_total_temporary_records ALTER COLUMN usage_stats_temp_total_id SET DEFAULT nextval('public.usage_stats_total_temporary_recor_usage_stats_temp_total_id_seq'::regclass);


--
-- Name: usage_stats_unique_item_investigations_temporary_records usage_stats_temp_unique_item_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.usage_stats_unique_item_investigations_temporary_records ALTER COLUMN usage_stats_temp_unique_item_id SET DEFAULT nextval('public.usage_stats_unique_item_inves_usage_stats_temp_unique_item__seq'::regclass);


--
-- Name: usage_stats_unique_item_requests_temporary_records usage_stats_temp_item_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.usage_stats_unique_item_requests_temporary_records ALTER COLUMN usage_stats_temp_item_id SET DEFAULT nextval('public.usage_stats_unique_item_requests_t_usage_stats_temp_item_id_seq'::regclass);


--
-- Name: user_group_settings user_group_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.user_group_settings ALTER COLUMN user_group_setting_id SET DEFAULT nextval('public.user_group_settings_user_group_setting_id_seq'::regclass);


--
-- Name: user_group_stage user_group_stage_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.user_group_stage ALTER COLUMN user_group_stage_id SET DEFAULT nextval('public.user_group_stage_user_group_stage_id_seq'::regclass);


--
-- Name: user_groups user_group_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.user_groups ALTER COLUMN user_group_id SET DEFAULT nextval('public.user_groups_user_group_id_seq'::regclass);


--
-- Name: user_interests user_interest_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.user_interests ALTER COLUMN user_interest_id SET DEFAULT nextval('public.user_interests_user_interest_id_seq'::regclass);


--
-- Name: user_settings user_setting_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.user_settings ALTER COLUMN user_setting_id SET DEFAULT nextval('public.user_settings_user_setting_id_seq'::regclass);


--
-- Name: user_user_groups user_user_group_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.user_user_groups ALTER COLUMN user_user_group_id SET DEFAULT nextval('public.user_user_groups_user_user_group_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Name: users_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_tokens ALTER COLUMN id SET DEFAULT nextval('public.users_tokens_id_seq'::regclass);


--
-- Name: versions version_id; Type: DEFAULT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.versions ALTER COLUMN version_id SET DEFAULT nextval('public.versions_version_id_seq'::regclass);


--
-- Name: announcement_settings announcement_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.announcement_settings
    ADD CONSTRAINT announcement_settings_pkey PRIMARY KEY (announcement_setting_id);


--
-- Name: announcement_settings announcement_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.announcement_settings
    ADD CONSTRAINT announcement_settings_unique UNIQUE (announcement_id, locale, setting_name);


--
-- Name: announcement_type_settings announcement_type_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.announcement_type_settings
    ADD CONSTRAINT announcement_type_settings_pkey PRIMARY KEY (announcement_type_setting_id);


--
-- Name: announcement_type_settings announcement_type_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.announcement_type_settings
    ADD CONSTRAINT announcement_type_settings_unique UNIQUE (type_id, locale, setting_name);


--
-- Name: announcement_types announcement_types_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.announcement_types
    ADD CONSTRAINT announcement_types_pkey PRIMARY KEY (type_id);


--
-- Name: announcements announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.announcements
    ADD CONSTRAINT announcements_pkey PRIMARY KEY (announcement_id);


--
-- Name: author_affiliation_settings author_affiliation_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.author_affiliation_settings
    ADD CONSTRAINT author_affiliation_settings_pkey PRIMARY KEY (author_affiliation_setting_id);


--
-- Name: author_affiliation_settings author_affiliation_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.author_affiliation_settings
    ADD CONSTRAINT author_affiliation_settings_unique UNIQUE (author_affiliation_id, locale, setting_name);


--
-- Name: author_affiliations author_affiliations_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.author_affiliations
    ADD CONSTRAINT author_affiliations_pkey PRIMARY KEY (author_affiliation_id);


--
-- Name: author_settings author_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.author_settings
    ADD CONSTRAINT author_settings_pkey PRIMARY KEY (author_setting_id);


--
-- Name: author_settings author_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.author_settings
    ADD CONSTRAINT author_settings_unique UNIQUE (author_id, locale, setting_name);


--
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (author_id);


--
-- Name: controlled_vocab_entry_settings c_v_e_s_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.controlled_vocab_entry_settings
    ADD CONSTRAINT c_v_e_s_pkey UNIQUE (controlled_vocab_entry_id, locale, setting_name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- Name: categories category_path; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT category_path UNIQUE (context_id, path);


--
-- Name: category_settings category_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.category_settings
    ADD CONSTRAINT category_settings_pkey PRIMARY KEY (category_setting_id);


--
-- Name: category_settings category_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.category_settings
    ADD CONSTRAINT category_settings_unique UNIQUE (category_id, locale, setting_name);


--
-- Name: citation_settings citation_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.citation_settings
    ADD CONSTRAINT citation_settings_pkey PRIMARY KEY (citation_setting_id);


--
-- Name: citation_settings citation_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.citation_settings
    ADD CONSTRAINT citation_settings_unique UNIQUE (citation_id, locale, setting_name);


--
-- Name: citations citations_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.citations
    ADD CONSTRAINT citations_pkey PRIMARY KEY (citation_id);


--
-- Name: citations citations_publication_seq; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.citations
    ADD CONSTRAINT citations_publication_seq UNIQUE (publication_id, seq);


--
-- Name: completed_payments completed_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.completed_payments
    ADD CONSTRAINT completed_payments_pkey PRIMARY KEY (completed_payment_id);


--
-- Name: controlled_vocab_entries controlled_vocab_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.controlled_vocab_entries
    ADD CONSTRAINT controlled_vocab_entries_pkey PRIMARY KEY (controlled_vocab_entry_id);


--
-- Name: controlled_vocab_entry_settings controlled_vocab_entry_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.controlled_vocab_entry_settings
    ADD CONSTRAINT controlled_vocab_entry_settings_pkey PRIMARY KEY (controlled_vocab_entry_setting_id);


--
-- Name: controlled_vocabs controlled_vocab_symbolic; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.controlled_vocabs
    ADD CONSTRAINT controlled_vocab_symbolic UNIQUE (symbolic, assoc_type, assoc_id);


--
-- Name: controlled_vocabs controlled_vocabs_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.controlled_vocabs
    ADD CONSTRAINT controlled_vocabs_pkey PRIMARY KEY (controlled_vocab_id);


--
-- Name: custom_issue_orders custom_issue_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.custom_issue_orders
    ADD CONSTRAINT custom_issue_orders_pkey PRIMARY KEY (custom_issue_order_id);


--
-- Name: custom_issue_orders custom_issue_orders_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.custom_issue_orders
    ADD CONSTRAINT custom_issue_orders_unique UNIQUE (issue_id);


--
-- Name: custom_section_orders custom_section_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.custom_section_orders
    ADD CONSTRAINT custom_section_orders_pkey PRIMARY KEY (custom_section_order_id);


--
-- Name: custom_section_orders custom_section_orders_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.custom_section_orders
    ADD CONSTRAINT custom_section_orders_unique UNIQUE (issue_id, section_id);


--
-- Name: data_object_tombstone_oai_set_objects data_object_tombstone_oai_set_objects_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.data_object_tombstone_oai_set_objects
    ADD CONSTRAINT data_object_tombstone_oai_set_objects_pkey PRIMARY KEY (object_id);


--
-- Name: data_object_tombstone_settings data_object_tombstone_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.data_object_tombstone_settings
    ADD CONSTRAINT data_object_tombstone_settings_pkey PRIMARY KEY (tombstone_setting_id);


--
-- Name: data_object_tombstone_settings data_object_tombstone_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.data_object_tombstone_settings
    ADD CONSTRAINT data_object_tombstone_settings_unique UNIQUE (tombstone_id, locale, setting_name);


--
-- Name: data_object_tombstones data_object_tombstones_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.data_object_tombstones
    ADD CONSTRAINT data_object_tombstones_pkey PRIMARY KEY (tombstone_id);


--
-- Name: doi_settings doi_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.doi_settings
    ADD CONSTRAINT doi_settings_pkey PRIMARY KEY (doi_setting_id);


--
-- Name: doi_settings doi_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.doi_settings
    ADD CONSTRAINT doi_settings_unique UNIQUE (doi_id, locale, setting_name);


--
-- Name: dois dois_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.dois
    ADD CONSTRAINT dois_pkey PRIMARY KEY (doi_id);


--
-- Name: edit_decisions edit_decisions_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.edit_decisions
    ADD CONSTRAINT edit_decisions_pkey PRIMARY KEY (edit_decision_id);


--
-- Name: email_log email_log_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.email_log
    ADD CONSTRAINT email_log_pkey PRIMARY KEY (log_id);


--
-- Name: email_log_users email_log_user_id; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.email_log_users
    ADD CONSTRAINT email_log_user_id UNIQUE (email_log_id, user_id);


--
-- Name: email_log_users email_log_users_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.email_log_users
    ADD CONSTRAINT email_log_users_pkey PRIMARY KEY (email_log_user_id);


--
-- Name: email_templates_default_data email_templates_default_data_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.email_templates_default_data
    ADD CONSTRAINT email_templates_default_data_pkey PRIMARY KEY (email_templates_default_data_id);


--
-- Name: email_templates_default_data email_templates_default_data_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.email_templates_default_data
    ADD CONSTRAINT email_templates_default_data_unique UNIQUE (email_key, locale);


--
-- Name: email_templates email_templates_email_key; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.email_templates
    ADD CONSTRAINT email_templates_email_key UNIQUE (email_key, context_id);


--
-- Name: email_templates email_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.email_templates
    ADD CONSTRAINT email_templates_pkey PRIMARY KEY (email_id);


--
-- Name: email_templates_settings email_templates_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.email_templates_settings
    ADD CONSTRAINT email_templates_settings_pkey PRIMARY KEY (email_template_setting_id);


--
-- Name: email_templates_settings email_templates_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.email_templates_settings
    ADD CONSTRAINT email_templates_settings_unique UNIQUE (email_id, locale, setting_name);


--
-- Name: event_log event_log_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.event_log
    ADD CONSTRAINT event_log_pkey PRIMARY KEY (log_id);


--
-- Name: event_log_settings event_log_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.event_log_settings
    ADD CONSTRAINT event_log_settings_pkey PRIMARY KEY (event_log_setting_id);


--
-- Name: event_log_settings event_log_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.event_log_settings
    ADD CONSTRAINT event_log_settings_unique UNIQUE (log_id, setting_name, locale);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (file_id);


--
-- Name: filter_groups filter_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.filter_groups
    ADD CONSTRAINT filter_groups_pkey PRIMARY KEY (filter_group_id);


--
-- Name: filter_groups filter_groups_symbolic; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.filter_groups
    ADD CONSTRAINT filter_groups_symbolic UNIQUE (symbolic);


--
-- Name: filter_settings filter_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.filter_settings
    ADD CONSTRAINT filter_settings_pkey PRIMARY KEY (filter_setting_id);


--
-- Name: filter_settings filter_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.filter_settings
    ADD CONSTRAINT filter_settings_unique UNIQUE (filter_id, locale, setting_name);


--
-- Name: filters filters_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.filters
    ADD CONSTRAINT filters_pkey PRIMARY KEY (filter_id);


--
-- Name: genre_settings genre_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.genre_settings
    ADD CONSTRAINT genre_settings_pkey PRIMARY KEY (genre_setting_id);


--
-- Name: genre_settings genre_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.genre_settings
    ADD CONSTRAINT genre_settings_unique UNIQUE (genre_id, locale, setting_name);


--
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genre_id);


--
-- Name: highlight_settings highlight_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.highlight_settings
    ADD CONSTRAINT highlight_settings_pkey PRIMARY KEY (highlight_setting_id);


--
-- Name: highlight_settings highlight_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.highlight_settings
    ADD CONSTRAINT highlight_settings_unique UNIQUE (highlight_id, locale, setting_name);


--
-- Name: highlights highlights_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.highlights
    ADD CONSTRAINT highlights_pkey PRIMARY KEY (highlight_id);


--
-- Name: institution_ip institution_ip_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.institution_ip
    ADD CONSTRAINT institution_ip_pkey PRIMARY KEY (institution_ip_id);


--
-- Name: institution_settings institution_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.institution_settings
    ADD CONSTRAINT institution_settings_pkey PRIMARY KEY (institution_setting_id);


--
-- Name: institution_settings institution_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.institution_settings
    ADD CONSTRAINT institution_settings_unique UNIQUE (institution_id, locale, setting_name);


--
-- Name: institutional_subscriptions institutional_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.institutional_subscriptions
    ADD CONSTRAINT institutional_subscriptions_pkey PRIMARY KEY (institutional_subscription_id);


--
-- Name: institutions institutions_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.institutions
    ADD CONSTRAINT institutions_pkey PRIMARY KEY (institution_id);


--
-- Name: invitations invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.invitations
    ADD CONSTRAINT invitations_pkey PRIMARY KEY (invitation_id);


--
-- Name: issue_files issue_files_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.issue_files
    ADD CONSTRAINT issue_files_pkey PRIMARY KEY (file_id);


--
-- Name: issue_galley_settings issue_galley_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.issue_galley_settings
    ADD CONSTRAINT issue_galley_settings_pkey PRIMARY KEY (issue_galley_setting_id);


--
-- Name: issue_galley_settings issue_galley_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.issue_galley_settings
    ADD CONSTRAINT issue_galley_settings_unique UNIQUE (galley_id, locale, setting_name);


--
-- Name: issue_galleys issue_galleys_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.issue_galleys
    ADD CONSTRAINT issue_galleys_pkey PRIMARY KEY (galley_id);


--
-- Name: issue_settings issue_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.issue_settings
    ADD CONSTRAINT issue_settings_pkey PRIMARY KEY (issue_setting_id);


--
-- Name: issue_settings issue_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.issue_settings
    ADD CONSTRAINT issue_settings_unique UNIQUE (issue_id, locale, setting_name);


--
-- Name: issues issues_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_pkey PRIMARY KEY (issue_id);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: journal_settings journal_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.journal_settings
    ADD CONSTRAINT journal_settings_pkey PRIMARY KEY (journal_setting_id);


--
-- Name: journal_settings journal_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.journal_settings
    ADD CONSTRAINT journal_settings_unique UNIQUE (journal_id, locale, setting_name);


--
-- Name: journals journals_path; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.journals
    ADD CONSTRAINT journals_path UNIQUE (path);


--
-- Name: journals journals_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.journals
    ADD CONSTRAINT journals_pkey PRIMARY KEY (journal_id);


--
-- Name: library_file_settings library_file_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.library_file_settings
    ADD CONSTRAINT library_file_settings_pkey PRIMARY KEY (library_file_setting_id);


--
-- Name: library_file_settings library_file_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.library_file_settings
    ADD CONSTRAINT library_file_settings_unique UNIQUE (file_id, locale, setting_name);


--
-- Name: library_files library_files_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.library_files
    ADD CONSTRAINT library_files_pkey PRIMARY KEY (file_id);


--
-- Name: metrics_context metrics_context_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_context
    ADD CONSTRAINT metrics_context_pkey PRIMARY KEY (metrics_context_id);


--
-- Name: metrics_counter_submission_daily metrics_counter_submission_daily_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_counter_submission_daily
    ADD CONSTRAINT metrics_counter_submission_daily_pkey PRIMARY KEY (metrics_counter_submission_daily_id);


--
-- Name: metrics_counter_submission_institution_daily metrics_counter_submission_institution_daily_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_counter_submission_institution_daily
    ADD CONSTRAINT metrics_counter_submission_institution_daily_pkey PRIMARY KEY (metrics_counter_submission_institution_daily_id);


--
-- Name: metrics_counter_submission_institution_monthly metrics_counter_submission_institution_monthly_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_counter_submission_institution_monthly
    ADD CONSTRAINT metrics_counter_submission_institution_monthly_pkey PRIMARY KEY (metrics_counter_submission_institution_monthly_id);


--
-- Name: metrics_counter_submission_monthly metrics_counter_submission_monthly_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_counter_submission_monthly
    ADD CONSTRAINT metrics_counter_submission_monthly_pkey PRIMARY KEY (metrics_counter_submission_monthly_id);


--
-- Name: metrics_issue metrics_issue_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_issue
    ADD CONSTRAINT metrics_issue_pkey PRIMARY KEY (metrics_issue_id);


--
-- Name: metrics_submission_geo_daily metrics_submission_geo_daily_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_submission_geo_daily
    ADD CONSTRAINT metrics_submission_geo_daily_pkey PRIMARY KEY (metrics_submission_geo_daily_id);


--
-- Name: metrics_submission_geo_monthly metrics_submission_geo_monthly_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_submission_geo_monthly
    ADD CONSTRAINT metrics_submission_geo_monthly_pkey PRIMARY KEY (metrics_submission_geo_monthly_id);


--
-- Name: metrics_submission metrics_submission_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_submission
    ADD CONSTRAINT metrics_submission_pkey PRIMARY KEY (metrics_submission_id);


--
-- Name: metrics_counter_submission_daily msd_uc_load_id_context_id_submission_id_date; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_counter_submission_daily
    ADD CONSTRAINT msd_uc_load_id_context_id_submission_id_date UNIQUE (load_id, context_id, submission_id, date);


--
-- Name: metrics_submission_geo_daily msgd_uc_load_context_submission_c_r_c_date; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_submission_geo_daily
    ADD CONSTRAINT msgd_uc_load_context_submission_c_r_c_date UNIQUE (load_id, context_id, submission_id, country, region, city, date);


--
-- Name: metrics_submission_geo_monthly msgm_uc_context_submission_c_r_c_month; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_submission_geo_monthly
    ADD CONSTRAINT msgm_uc_context_submission_c_r_c_month UNIQUE (context_id, submission_id, country, region, city, month);


--
-- Name: metrics_counter_submission_institution_daily msid_uc_load_id_context_id_submission_id_institution_id_date; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_counter_submission_institution_daily
    ADD CONSTRAINT msid_uc_load_id_context_id_submission_id_institution_id_date UNIQUE (load_id, context_id, submission_id, institution_id, date);


--
-- Name: metrics_counter_submission_institution_monthly msim_uc_context_id_submission_id_institution_id_month; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_counter_submission_institution_monthly
    ADD CONSTRAINT msim_uc_context_id_submission_id_institution_id_month UNIQUE (context_id, submission_id, institution_id, month);


--
-- Name: metrics_counter_submission_monthly msm_uc_context_id_submission_id_month; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.metrics_counter_submission_monthly
    ADD CONSTRAINT msm_uc_context_id_submission_id_month UNIQUE (context_id, submission_id, month);


--
-- Name: navigation_menu_item_assignment_settings navigation_menu_item_assignment_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.navigation_menu_item_assignment_settings
    ADD CONSTRAINT navigation_menu_item_assignment_settings_pkey PRIMARY KEY (navigation_menu_item_assignment_setting_id);


--
-- Name: navigation_menu_item_assignment_settings navigation_menu_item_assignment_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.navigation_menu_item_assignment_settings
    ADD CONSTRAINT navigation_menu_item_assignment_settings_unique UNIQUE (navigation_menu_item_assignment_id, locale, setting_name);


--
-- Name: navigation_menu_item_assignments navigation_menu_item_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.navigation_menu_item_assignments
    ADD CONSTRAINT navigation_menu_item_assignments_pkey PRIMARY KEY (navigation_menu_item_assignment_id);


--
-- Name: navigation_menu_item_settings navigation_menu_item_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.navigation_menu_item_settings
    ADD CONSTRAINT navigation_menu_item_settings_pkey PRIMARY KEY (navigation_menu_item_setting_id);


--
-- Name: navigation_menu_item_settings navigation_menu_item_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.navigation_menu_item_settings
    ADD CONSTRAINT navigation_menu_item_settings_unique UNIQUE (navigation_menu_item_id, locale, setting_name);


--
-- Name: navigation_menu_items navigation_menu_items_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.navigation_menu_items
    ADD CONSTRAINT navigation_menu_items_pkey PRIMARY KEY (navigation_menu_item_id);


--
-- Name: navigation_menus navigation_menus_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.navigation_menus
    ADD CONSTRAINT navigation_menus_pkey PRIMARY KEY (navigation_menu_id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (note_id);


--
-- Name: notification_settings notification_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.notification_settings
    ADD CONSTRAINT notification_settings_pkey PRIMARY KEY (notification_setting_id);


--
-- Name: notification_settings notification_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.notification_settings
    ADD CONSTRAINT notification_settings_unique UNIQUE (notification_id, locale, setting_name);


--
-- Name: notification_subscription_settings notification_subscription_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.notification_subscription_settings
    ADD CONSTRAINT notification_subscription_settings_pkey PRIMARY KEY (setting_id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);


--
-- Name: oai_resumption_tokens oai_resumption_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.oai_resumption_tokens
    ADD CONSTRAINT oai_resumption_tokens_pkey PRIMARY KEY (oai_resumption_token_id);


--
-- Name: oai_resumption_tokens oai_resumption_tokens_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.oai_resumption_tokens
    ADD CONSTRAINT oai_resumption_tokens_unique UNIQUE (token);


--
-- Name: plugin_settings plugin_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.plugin_settings
    ADD CONSTRAINT plugin_settings_pkey PRIMARY KEY (plugin_setting_id);


--
-- Name: plugin_settings plugin_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.plugin_settings
    ADD CONSTRAINT plugin_settings_unique UNIQUE (plugin_name, context_id, setting_name);


--
-- Name: publication_categories publication_categories_id; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.publication_categories
    ADD CONSTRAINT publication_categories_id UNIQUE (publication_id, category_id);


--
-- Name: publication_categories publication_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.publication_categories
    ADD CONSTRAINT publication_categories_pkey PRIMARY KEY (publication_category_id);


--
-- Name: publication_galley_settings publication_galley_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.publication_galley_settings
    ADD CONSTRAINT publication_galley_settings_pkey PRIMARY KEY (publication_galley_setting_id);


--
-- Name: publication_galley_settings publication_galley_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.publication_galley_settings
    ADD CONSTRAINT publication_galley_settings_unique UNIQUE (galley_id, locale, setting_name);


--
-- Name: publication_galleys publication_galleys_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.publication_galleys
    ADD CONSTRAINT publication_galleys_pkey PRIMARY KEY (galley_id);


--
-- Name: publication_settings publication_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.publication_settings
    ADD CONSTRAINT publication_settings_pkey PRIMARY KEY (publication_setting_id);


--
-- Name: publication_settings publication_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.publication_settings
    ADD CONSTRAINT publication_settings_unique UNIQUE (publication_id, locale, setting_name);


--
-- Name: publications publications_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.publications
    ADD CONSTRAINT publications_pkey PRIMARY KEY (publication_id);


--
-- Name: queries queries_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.queries
    ADD CONSTRAINT queries_pkey PRIMARY KEY (query_id);


--
-- Name: query_participants query_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.query_participants
    ADD CONSTRAINT query_participants_pkey PRIMARY KEY (query_participant_id);


--
-- Name: query_participants query_participants_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.query_participants
    ADD CONSTRAINT query_participants_unique UNIQUE (query_id, user_id);


--
-- Name: queued_payments queued_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.queued_payments
    ADD CONSTRAINT queued_payments_pkey PRIMARY KEY (queued_payment_id);


--
-- Name: review_assignment_settings review_assignment_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_assignment_settings
    ADD CONSTRAINT review_assignment_settings_pkey PRIMARY KEY (review_assignment_settings_id);


--
-- Name: review_assignment_settings review_assignment_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_assignment_settings
    ADD CONSTRAINT review_assignment_settings_unique UNIQUE (review_id, locale, setting_name);


--
-- Name: review_assignments review_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_assignments
    ADD CONSTRAINT review_assignments_pkey PRIMARY KEY (review_id);


--
-- Name: review_files review_files_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_files
    ADD CONSTRAINT review_files_pkey PRIMARY KEY (review_file_id);


--
-- Name: review_files review_files_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_files
    ADD CONSTRAINT review_files_unique UNIQUE (review_id, submission_file_id);


--
-- Name: review_form_element_settings review_form_element_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_form_element_settings
    ADD CONSTRAINT review_form_element_settings_pkey PRIMARY KEY (review_form_element_setting_id);


--
-- Name: review_form_element_settings review_form_element_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_form_element_settings
    ADD CONSTRAINT review_form_element_settings_unique UNIQUE (review_form_element_id, locale, setting_name);


--
-- Name: review_form_elements review_form_elements_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_form_elements
    ADD CONSTRAINT review_form_elements_pkey PRIMARY KEY (review_form_element_id);


--
-- Name: review_form_responses review_form_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_form_responses
    ADD CONSTRAINT review_form_responses_pkey PRIMARY KEY (review_form_response_id);


--
-- Name: review_form_settings review_form_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_form_settings
    ADD CONSTRAINT review_form_settings_pkey PRIMARY KEY (review_form_setting_id);


--
-- Name: review_form_settings review_form_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_form_settings
    ADD CONSTRAINT review_form_settings_unique UNIQUE (review_form_id, locale, setting_name);


--
-- Name: review_forms review_forms_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_forms
    ADD CONSTRAINT review_forms_pkey PRIMARY KEY (review_form_id);


--
-- Name: review_round_files review_round_files_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_round_files
    ADD CONSTRAINT review_round_files_pkey PRIMARY KEY (review_round_file_id);


--
-- Name: review_round_files review_round_files_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_round_files
    ADD CONSTRAINT review_round_files_unique UNIQUE (submission_id, review_round_id, submission_file_id);


--
-- Name: review_rounds review_rounds_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_rounds
    ADD CONSTRAINT review_rounds_pkey PRIMARY KEY (review_round_id);


--
-- Name: review_rounds review_rounds_submission_id_stage_id_round_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.review_rounds
    ADD CONSTRAINT review_rounds_submission_id_stage_id_round_pkey UNIQUE (submission_id, stage_id, round);


--
-- Name: reviewer_suggestion_settings reviewer_suggestion_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.reviewer_suggestion_settings
    ADD CONSTRAINT reviewer_suggestion_settings_unique UNIQUE (reviewer_suggestion_id, locale, setting_name);


--
-- Name: reviewer_suggestions reviewer_suggestions_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.reviewer_suggestions
    ADD CONSTRAINT reviewer_suggestions_pkey PRIMARY KEY (reviewer_suggestion_id);


--
-- Name: ror_settings ror_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.ror_settings
    ADD CONSTRAINT ror_settings_pkey PRIMARY KEY (ror_setting_id);


--
-- Name: ror_settings ror_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.ror_settings
    ADD CONSTRAINT ror_settings_unique UNIQUE (ror_id, locale, setting_name);


--
-- Name: rors rors_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.rors
    ADD CONSTRAINT rors_pkey PRIMARY KEY (ror_id);


--
-- Name: rors rors_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.rors
    ADD CONSTRAINT rors_unique UNIQUE (ror);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: subeditor_submission_group section_editors_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.subeditor_submission_group
    ADD CONSTRAINT section_editors_unique UNIQUE (context_id, assoc_id, assoc_type, user_id, user_group_id);


--
-- Name: section_settings section_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.section_settings
    ADD CONSTRAINT section_settings_pkey PRIMARY KEY (section_setting_id);


--
-- Name: section_settings section_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.section_settings
    ADD CONSTRAINT section_settings_unique UNIQUE (section_id, locale, setting_name);


--
-- Name: sections sections_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (section_id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: site site_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.site
    ADD CONSTRAINT site_pkey PRIMARY KEY (site_id);


--
-- Name: site_settings site_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.site_settings
    ADD CONSTRAINT site_settings_pkey PRIMARY KEY (site_setting_id);


--
-- Name: site_settings site_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.site_settings
    ADD CONSTRAINT site_settings_unique UNIQUE (setting_name, locale);


--
-- Name: stage_assignments stage_assignment; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.stage_assignments
    ADD CONSTRAINT stage_assignment UNIQUE (submission_id, user_group_id, user_id);


--
-- Name: stage_assignments stage_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.stage_assignments
    ADD CONSTRAINT stage_assignments_pkey PRIMARY KEY (stage_assignment_id);


--
-- Name: static_page_settings static_page_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.static_page_settings
    ADD CONSTRAINT static_page_settings_pkey PRIMARY KEY (static_page_setting_id);


--
-- Name: static_page_settings static_page_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.static_page_settings
    ADD CONSTRAINT static_page_settings_unique UNIQUE (static_page_id, locale, setting_name);


--
-- Name: static_pages static_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.static_pages
    ADD CONSTRAINT static_pages_pkey PRIMARY KEY (static_page_id);


--
-- Name: subeditor_submission_group subeditor_submission_group_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.subeditor_submission_group
    ADD CONSTRAINT subeditor_submission_group_pkey PRIMARY KEY (subeditor_submission_group_id);


--
-- Name: submission_comments submission_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_comments
    ADD CONSTRAINT submission_comments_pkey PRIMARY KEY (comment_id);


--
-- Name: submission_file_revisions submission_file_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_file_revisions
    ADD CONSTRAINT submission_file_revisions_pkey PRIMARY KEY (revision_id);


--
-- Name: submission_file_settings submission_file_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_file_settings
    ADD CONSTRAINT submission_file_settings_pkey PRIMARY KEY (submission_file_setting_id);


--
-- Name: submission_file_settings submission_file_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_file_settings
    ADD CONSTRAINT submission_file_settings_unique UNIQUE (submission_file_id, locale, setting_name);


--
-- Name: submission_files submission_files_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_files
    ADD CONSTRAINT submission_files_pkey PRIMARY KEY (submission_file_id);


--
-- Name: submission_search_keyword_list submission_search_keyword_list_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_search_keyword_list
    ADD CONSTRAINT submission_search_keyword_list_pkey PRIMARY KEY (keyword_id);


--
-- Name: submission_search_keyword_list submission_search_keyword_text; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_search_keyword_list
    ADD CONSTRAINT submission_search_keyword_text UNIQUE (keyword_text);


--
-- Name: submission_search_object_keywords submission_search_object_keywords_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_search_object_keywords
    ADD CONSTRAINT submission_search_object_keywords_pkey PRIMARY KEY (submission_search_object_keyword_id);


--
-- Name: submission_search_object_keywords submission_search_object_keywords_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_search_object_keywords
    ADD CONSTRAINT submission_search_object_keywords_unique UNIQUE (object_id, pos);


--
-- Name: submission_search_objects submission_search_objects_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_search_objects
    ADD CONSTRAINT submission_search_objects_pkey PRIMARY KEY (object_id);


--
-- Name: submission_settings submission_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_settings
    ADD CONSTRAINT submission_settings_pkey PRIMARY KEY (submission_setting_id);


--
-- Name: submission_settings submission_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submission_settings
    ADD CONSTRAINT submission_settings_unique UNIQUE (submission_id, locale, setting_name);


--
-- Name: submissions submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (submission_id);


--
-- Name: subscription_type_settings subscription_type_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.subscription_type_settings
    ADD CONSTRAINT subscription_type_settings_pkey PRIMARY KEY (subscription_type_setting_id);


--
-- Name: subscription_type_settings subscription_type_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.subscription_type_settings
    ADD CONSTRAINT subscription_type_settings_unique UNIQUE (type_id, locale, setting_name);


--
-- Name: subscription_types subscription_types_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.subscription_types
    ADD CONSTRAINT subscription_types_pkey PRIMARY KEY (type_id);


--
-- Name: subscriptions subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (subscription_id);


--
-- Name: temporary_files temporary_files_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.temporary_files
    ADD CONSTRAINT temporary_files_pkey PRIMARY KEY (file_id);


--
-- Name: user_interests u_e_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.user_interests
    ADD CONSTRAINT u_e_pkey UNIQUE (user_id, controlled_vocab_entry_id);


--
-- Name: usage_stats_institution_temporary_records usage_stats_institution_temporary_records_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.usage_stats_institution_temporary_records
    ADD CONSTRAINT usage_stats_institution_temporary_records_pkey PRIMARY KEY (usage_stats_temp_institution_id);


--
-- Name: usage_stats_total_temporary_records usage_stats_total_temporary_records_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.usage_stats_total_temporary_records
    ADD CONSTRAINT usage_stats_total_temporary_records_pkey PRIMARY KEY (usage_stats_temp_total_id);


--
-- Name: usage_stats_unique_item_investigations_temporary_records usage_stats_unique_item_investigations_temporary_records_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.usage_stats_unique_item_investigations_temporary_records
    ADD CONSTRAINT usage_stats_unique_item_investigations_temporary_records_pkey PRIMARY KEY (usage_stats_temp_unique_item_id);


--
-- Name: usage_stats_unique_item_requests_temporary_records usage_stats_unique_item_requests_temporary_records_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.usage_stats_unique_item_requests_temporary_records
    ADD CONSTRAINT usage_stats_unique_item_requests_temporary_records_pkey PRIMARY KEY (usage_stats_temp_item_id);


--
-- Name: user_group_settings user_group_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.user_group_settings
    ADD CONSTRAINT user_group_settings_pkey PRIMARY KEY (user_group_setting_id);


--
-- Name: user_group_settings user_group_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.user_group_settings
    ADD CONSTRAINT user_group_settings_unique UNIQUE (user_group_id, locale, setting_name);


--
-- Name: user_group_stage user_group_stage_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.user_group_stage
    ADD CONSTRAINT user_group_stage_pkey PRIMARY KEY (user_group_stage_id);


--
-- Name: user_group_stage user_group_stage_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.user_group_stage
    ADD CONSTRAINT user_group_stage_unique UNIQUE (context_id, user_group_id, stage_id);


--
-- Name: user_groups user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.user_groups
    ADD CONSTRAINT user_groups_pkey PRIMARY KEY (user_group_id);


--
-- Name: user_interests user_interests_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.user_interests
    ADD CONSTRAINT user_interests_pkey PRIMARY KEY (user_interest_id);


--
-- Name: user_settings user_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.user_settings
    ADD CONSTRAINT user_settings_pkey PRIMARY KEY (user_setting_id);


--
-- Name: user_settings user_settings_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.user_settings
    ADD CONSTRAINT user_settings_unique UNIQUE (user_id, locale, setting_name);


--
-- Name: user_user_groups user_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.user_user_groups
    ADD CONSTRAINT user_user_groups_pkey PRIMARY KEY (user_user_group_id);


--
-- Name: users users_email; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users_tokens users_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_tokens
    ADD CONSTRAINT users_tokens_pkey PRIMARY KEY (id);


--
-- Name: users users_username; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username UNIQUE (username);


--
-- Name: usage_stats_institution_temporary_records usitr_load_id_line_number_institution_id; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.usage_stats_institution_temporary_records
    ADD CONSTRAINT usitr_load_id_line_number_institution_id UNIQUE (load_id, line_number, institution_id);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (version_id);


--
-- Name: versions versions_unique; Type: CONSTRAINT; Schema: public; Owner: adrianasofi
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_unique UNIQUE (product_type, product, major, minor, revision, build);


--
-- Name: users_tokens_context_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_tokens_context_index ON public.users_tokens USING btree (context);


--
-- Name: users_tokens_token_context_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_tokens_token_context_index ON public.users_tokens USING btree (token, context);


--
-- Name: users_tokens_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_tokens_user_id_index ON public.users_tokens USING btree (user_id);


--
-- Name: users_tokens users_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_tokens
    ADD CONSTRAINT users_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict JMljA9UNgfSCB1QYQXkqnglw2ypURTeJ6cKDce7576iUZfgwaJ3W2cOpxMer7xL

