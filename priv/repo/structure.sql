--
-- PostgreSQL database dump
--

\restrict xVEE46UqMPwIIeUtDT4PeB8aAjn4nsfcA8t7AI0XhijauJghp2rSSPUVleZqkyg

-- Dumped from database version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)

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
-- Name: announcement_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.announcement_settings (
    announcement_setting_id bigint NOT NULL,
    announcement_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE announcement_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.announcement_settings IS 'More data about announcements, including localized properties like names and contents.';


--
-- Name: announcement_type_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.announcement_type_settings (
    announcement_type_setting_id bigint NOT NULL,
    type_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text,
    setting_type character varying(6)
);


--
-- Name: TABLE announcement_type_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.announcement_type_settings IS 'More data about announcement types, including localized properties like their names.';


--
-- Name: announcement_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.announcement_types (
    type_id bigint NOT NULL,
    context_id bigint
);


--
-- Name: TABLE announcement_types; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.announcement_types IS 'Announcement types allow for announcements to optionally be categorized.';


--
-- Name: announcements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.announcements (
    announcement_id bigint NOT NULL,
    assoc_type smallint,
    assoc_id bigint,
    type_id bigint,
    date_expire date,
    date_posted timestamp without time zone NOT NULL
);


--
-- Name: TABLE announcements; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.announcements IS 'Announcements are messages that can be presented to users e.g. on the homepage.';


--
-- Name: author_affiliation_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.author_affiliation_settings (
    author_affiliation_setting_id bigint NOT NULL,
    author_affiliation_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE author_affiliation_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.author_affiliation_settings IS 'More data about author affiliations';


--
-- Name: author_affiliations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.author_affiliations (
    author_affiliation_id bigint NOT NULL,
    author_id bigint NOT NULL,
    ror character varying(255)
);


--
-- Name: TABLE author_affiliations; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.author_affiliations IS 'Author affiliations';


--
-- Name: author_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.author_settings (
    author_setting_id bigint NOT NULL,
    author_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE author_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.author_settings IS 'More data about authors, including localized properties such as their name and affiliation.';


--
-- Name: authors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authors (
    author_id bigint NOT NULL,
    email character varying(90),
    include_in_browse smallint NOT NULL,
    publication_id bigint NOT NULL,
    seq double precision NOT NULL,
    user_group_id bigint
);


--
-- Name: TABLE authors; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.authors IS 'The authors of a publication.';


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    category_id bigint NOT NULL,
    context_id bigint NOT NULL,
    parent_id bigint,
    seq bigint,
    path character varying(255),
    image text
);


--
-- Name: TABLE categories; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.categories IS 'Categories permit the organization of submissions into a heirarchical structure.';


--
-- Name: category_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.category_settings (
    category_setting_id bigint NOT NULL,
    category_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE category_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.category_settings IS 'More data about categories, including localized properties such as names.';


--
-- Name: citation_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.citation_settings (
    citation_setting_id bigint NOT NULL,
    citation_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text,
    setting_type character varying(6)
);


--
-- Name: TABLE citation_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.citation_settings IS 'Additional data about citations, including localized content.';


--
-- Name: citations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.citations (
    citation_id bigint NOT NULL,
    publication_id bigint NOT NULL,
    raw_citation text,
    seq bigint NOT NULL
);


--
-- Name: TABLE citations; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.citations IS 'A citation made by an associated publication.';


--
-- Name: completed_payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.completed_payments (
    completed_payment_id bigint NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    payment_type bigint NOT NULL,
    context_id bigint NOT NULL,
    user_id bigint,
    assoc_id bigint,
    amount numeric(8,2),
    currency_code_alpha character varying(3),
    payment_method_plugin_name character varying(80)
);


--
-- Name: TABLE completed_payments; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.completed_payments IS 'A list of completed (fulfilled) payments relating to a payment type such as a subscription payment.';


--
-- Name: controlled_vocab_entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.controlled_vocab_entries (
    controlled_vocab_entry_id bigint NOT NULL,
    controlled_vocab_id bigint NOT NULL,
    seq double precision
);


--
-- Name: TABLE controlled_vocab_entries; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.controlled_vocab_entries IS 'The order that a word or phrase used in a controlled vocabulary should appear. For example, the order of keywords in a publication.';


--
-- Name: controlled_vocab_entry_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.controlled_vocab_entry_settings (
    controlled_vocab_entry_setting_id bigint NOT NULL,
    controlled_vocab_entry_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE controlled_vocab_entry_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.controlled_vocab_entry_settings IS 'More data about a controlled vocabulary entry, including localized properties such as the actual word or phrase.';


--
-- Name: controlled_vocabs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.controlled_vocabs (
    controlled_vocab_id bigint NOT NULL,
    symbolic character varying(64),
    assoc_type bigint NOT NULL,
    assoc_id bigint
);


--
-- Name: TABLE controlled_vocabs; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.controlled_vocabs IS 'Every word or phrase used in a controlled vocabulary. Controlled vocabularies are used for submission metadata like keywords and subjects, reviewer interests, and wherever a similar dictionary of words or phrases is required. Each entry corresponds to a word or phrase like "cellular reproduction" and a type like "submissionKeyword".';


--
-- Name: custom_issue_orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_issue_orders (
    custom_issue_order_id bigint NOT NULL,
    issue_id bigint NOT NULL,
    journal_id bigint NOT NULL,
    seq double precision NOT NULL
);


--
-- Name: TABLE custom_issue_orders; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.custom_issue_orders IS 'Ordering information for the issue list, when custom issue ordering is specified.';


--
-- Name: custom_section_orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_section_orders (
    custom_section_order_id bigint NOT NULL,
    issue_id bigint NOT NULL,
    section_id bigint NOT NULL,
    seq double precision NOT NULL
);


--
-- Name: TABLE custom_section_orders; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.custom_section_orders IS 'Ordering information for sections within issues, when issue-specific section ordering is specified.';


--
-- Name: data_object_tombstone_oai_set_objects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.data_object_tombstone_oai_set_objects (
    object_id bigint NOT NULL,
    tombstone_id bigint NOT NULL,
    assoc_type bigint NOT NULL,
    assoc_id bigint NOT NULL
);


--
-- Name: TABLE data_object_tombstone_oai_set_objects; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.data_object_tombstone_oai_set_objects IS 'Relationships between tombstones and other data that can be collected in OAI sets, e.g. sections.';


--
-- Name: data_object_tombstone_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.data_object_tombstone_settings (
    tombstone_setting_id bigint NOT NULL,
    tombstone_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text,
    setting_type character varying(6)
);


--
-- Name: TABLE data_object_tombstone_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.data_object_tombstone_settings IS 'More data about data object tombstones, including localized content.';


--
-- Name: COLUMN data_object_tombstone_settings.setting_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.data_object_tombstone_settings.setting_type IS '(bool|int|float|string|object)';


--
-- Name: data_object_tombstones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.data_object_tombstones (
    tombstone_id bigint NOT NULL,
    data_object_id bigint NOT NULL,
    date_deleted timestamp without time zone NOT NULL,
    set_spec character varying(255),
    set_name character varying(255),
    oai_identifier character varying(255)
);


--
-- Name: TABLE data_object_tombstones; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.data_object_tombstones IS 'Entries for published data that has been removed. Usually used in the OAI endpoint.';


--
-- Name: doi_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.doi_settings (
    doi_setting_id bigint NOT NULL,
    doi_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE doi_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.doi_settings IS 'More data about DOIs, including the registration agency.';


--
-- Name: dois; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dois (
    doi_id bigint NOT NULL,
    context_id bigint NOT NULL,
    doi character varying(255),
    status smallint NOT NULL
);


--
-- Name: TABLE dois; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.dois IS 'Stores all DOIs used in the system.';


--
-- Name: edit_decisions; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: TABLE edit_decisions; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.edit_decisions IS 'Editorial decisions recorded on a submission, such as decisions to accept or decline the submission, as well as decisions to send for review, send to copyediting, request revisions, and more.';


--
-- Name: COLUMN edit_decisions.decision; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.edit_decisions.decision IS 'A numeric constant indicating the decision that was taken. Possible values are listed in the Decision class.';


--
-- Name: email_log; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: TABLE email_log; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.email_log IS 'A record of email messages that are sent in relation to an associated entity, such as a submission.';


--
-- Name: email_log_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email_log_users (
    email_log_user_id bigint NOT NULL,
    email_log_id bigint NOT NULL,
    user_id bigint NOT NULL
);


--
-- Name: TABLE email_log_users; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.email_log_users IS 'A record of users associated with an email log entry.';


--
-- Name: email_templates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email_templates (
    email_id bigint NOT NULL,
    email_key character varying(255),
    context_id bigint NOT NULL,
    alternate_to character varying(255)
);


--
-- Name: TABLE email_templates; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.email_templates IS 'Custom email templates created by each context, and overrides of the default templates.';


--
-- Name: COLUMN email_templates.email_key; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.email_templates.email_key IS 'Unique identifier for this email.';


--
-- Name: email_templates_default_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email_templates_default_data (
    email_templates_default_data_id bigint NOT NULL,
    email_key character varying(255),
    locale character varying(28),
    name character varying(255),
    subject character varying(255),
    body text
);


--
-- Name: TABLE email_templates_default_data; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.email_templates_default_data IS 'Default email templates created for every installed locale.';


--
-- Name: COLUMN email_templates_default_data.email_key; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.email_templates_default_data.email_key IS 'Unique identifier for this email.';


--
-- Name: email_templates_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email_templates_settings (
    email_template_setting_id bigint NOT NULL,
    email_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE email_templates_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.email_templates_settings IS 'More data about custom email templates, including localized properties such as the subject and body.';


--
-- Name: event_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event_log (
    log_id bigint NOT NULL,
    assoc_type bigint NOT NULL,
    assoc_id bigint NOT NULL,
    user_id bigint,
    date_logged timestamp without time zone NOT NULL,
    event_type bigint,
    message text,
    is_translated integer
);


--
-- Name: TABLE event_log; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.event_log IS 'A log of all events related to an object like a submission.';


--
-- Name: COLUMN event_log.user_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.event_log.user_id IS 'NULL if it''s system or automated event';


--
-- Name: event_log_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event_log_settings (
    event_log_setting_id bigint NOT NULL,
    log_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE event_log_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.event_log_settings IS 'Data about an event log entry. This data is commonly used to display information about an event to a user.';


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    connection text,
    queue text,
    payload text,
    exception text,
    failed_at timestamp without time zone NOT NULL
);


--
-- Name: TABLE failed_jobs; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.failed_jobs IS 'A log of all failed jobs.';


--
-- Name: files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.files (
    file_id bigint NOT NULL,
    path character varying(255),
    mimetype character varying(255)
);


--
-- Name: TABLE files; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.files IS 'Records information in the database about files tracked by the system, linking them to the local filesystem.';


--
-- Name: filter_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.filter_groups (
    filter_group_id bigint NOT NULL,
    symbolic character varying(255),
    display_name character varying(255),
    description character varying(255),
    input_type character varying(255),
    output_type character varying(255)
);


--
-- Name: TABLE filter_groups; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.filter_groups IS 'Filter groups are used to organized filters into named sets, which can be retrieved by the application for invocation.';


--
-- Name: filter_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.filter_settings (
    filter_setting_id bigint NOT NULL,
    filter_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text,
    setting_type character varying(6)
);


--
-- Name: TABLE filter_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.filter_settings IS 'More data about filters, including localized content.';


--
-- Name: filters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.filters (
    filter_id bigint NOT NULL,
    filter_group_id bigint NOT NULL,
    context_id bigint,
    display_name character varying(255),
    class_name character varying(255),
    is_template smallint NOT NULL,
    parent_filter_id bigint,
    seq bigint NOT NULL
);


--
-- Name: TABLE filters; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.filters IS 'Filters represent a transformation of a supported piece of data from one form to another, such as a PHP object into an XML document.';


--
-- Name: genre_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.genre_settings (
    genre_setting_id bigint NOT NULL,
    genre_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text,
    setting_type character varying(6)
);


--
-- Name: TABLE genre_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.genre_settings IS 'More data about file genres, including localized properties such as the genre name.';


--
-- Name: COLUMN genre_settings.setting_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.genre_settings.setting_type IS '(bool|int|float|string|object)';


--
-- Name: genres; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.genres (
    genre_id bigint NOT NULL,
    context_id bigint NOT NULL,
    seq bigint NOT NULL,
    enabled smallint NOT NULL,
    category bigint NOT NULL,
    dependent smallint NOT NULL,
    supplementary smallint NOT NULL,
    required smallint NOT NULL,
    entry_key character varying(30)
);


--
-- Name: TABLE genres; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.genres IS 'The types of submission files configured for each context, such as Article Text, Data Set, Transcript, etc.';


--
-- Name: COLUMN genres.required; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.genres.required IS 'Whether or not at least one file of this genre is required for a new submission.';


--
-- Name: highlight_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.highlight_settings (
    highlight_setting_id bigint NOT NULL,
    highlight_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE highlight_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.highlight_settings IS 'More data about highlights, including localized properties like title and description.';


--
-- Name: highlights; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.highlights (
    highlight_id bigint NOT NULL,
    context_id bigint,
    sequence bigint NOT NULL,
    url character varying(2047)
);


--
-- Name: TABLE highlights; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.highlights IS 'Highlights are featured items that can be presented to users, for example on the homepage.';


--
-- Name: institution_ip; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.institution_ip (
    institution_ip_id bigint NOT NULL,
    institution_id bigint NOT NULL,
    ip_string character varying(40),
    ip_start bigint NOT NULL,
    ip_end bigint
);


--
-- Name: TABLE institution_ip; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.institution_ip IS 'Records IP address ranges and associates them with institutions.';


--
-- Name: institution_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.institution_settings (
    institution_setting_id bigint NOT NULL,
    institution_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE institution_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.institution_settings IS 'More data about institutions, including localized properties like names.';


--
-- Name: institutional_subscriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.institutional_subscriptions (
    institutional_subscription_id bigint NOT NULL,
    subscription_id bigint NOT NULL,
    institution_id bigint NOT NULL,
    mailing_address character varying(255),
    domain character varying(255)
);


--
-- Name: TABLE institutional_subscriptions; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.institutional_subscriptions IS 'A list of institutional subscriptions, linking a subscription with an institution.';


--
-- Name: institutions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.institutions (
    institution_id bigint NOT NULL,
    context_id bigint NOT NULL,
    ror character varying(255),
    deleted_at timestamp without time zone
);


--
-- Name: TABLE institutions; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.institutions IS 'Institutions for statistics and subscriptions.';


--
-- Name: COLUMN institutions.ror; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.institutions.ror IS 'ROR (Research Organization Registry) ID';


--
-- Name: invitations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invitations (
    invitation_id bigint NOT NULL,
    key_hash character varying(255),
    type character varying(255),
    user_id bigint,
    inviter_id bigint,
    expiry_date timestamp without time zone,
    payload text,
    status character varying(11),
    email character varying(255),
    context_id bigint,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: TABLE invitations; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.invitations IS 'Invitations are sent to request a person (by email) to allow them to accept or reject an operation or position, such as a board membership or a submission peer review.';


--
-- Name: COLUMN invitations.email; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.invitations.email IS 'When present, the email address of the invitation recipient; when null, user_id must be set and the email can be fetched from the users table.';


--
-- Name: issue_files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.issue_files (
    file_id bigint NOT NULL,
    issue_id bigint NOT NULL,
    file_name character varying(90),
    file_type character varying(255),
    file_size bigint NOT NULL,
    content_type bigint NOT NULL,
    original_file_name character varying(127),
    date_uploaded timestamp without time zone NOT NULL,
    date_modified timestamp without time zone NOT NULL
);


--
-- Name: TABLE issue_files; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.issue_files IS 'Relationships between issues and issue files, such as cover images.';


--
-- Name: issue_galley_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.issue_galley_settings (
    issue_galley_setting_id bigint NOT NULL,
    galley_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text,
    setting_type character varying(6)
);


--
-- Name: TABLE issue_galley_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.issue_galley_settings IS 'More data about issue galleys, including localized content such as labels.';


--
-- Name: COLUMN issue_galley_settings.setting_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.issue_galley_settings.setting_type IS '(bool|int|float|string|object)';


--
-- Name: issue_galleys; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.issue_galleys (
    galley_id bigint NOT NULL,
    locale character varying(28),
    issue_id bigint NOT NULL,
    file_id bigint NOT NULL,
    label character varying(255),
    seq double precision NOT NULL,
    url_path character varying(64)
);


--
-- Name: TABLE issue_galleys; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.issue_galleys IS 'Issue galleys are representations of the entire issue in a single file, such as a complete issue PDF.';


--
-- Name: issue_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.issue_settings (
    issue_setting_id bigint NOT NULL,
    issue_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE issue_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.issue_settings IS 'More data about issues, including localized properties such as issue titles.';


--
-- Name: issues; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.issues (
    issue_id bigint NOT NULL,
    journal_id bigint NOT NULL,
    volume smallint,
    number character varying(40),
    year smallint,
    published smallint NOT NULL,
    date_published timestamp without time zone,
    date_notified timestamp without time zone,
    last_modified timestamp without time zone,
    access_status smallint NOT NULL,
    open_access_date timestamp without time zone,
    show_volume smallint NOT NULL,
    show_number smallint NOT NULL,
    show_year smallint NOT NULL,
    show_title smallint NOT NULL,
    style_file_name character varying(90),
    original_style_file_name character varying(255),
    url_path character varying(64),
    doi_id bigint
);


--
-- Name: TABLE issues; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.issues IS 'A list of all journal issues, with identifying information like year, number, volume, etc.';


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.job_batches (
    id character varying(255),
    name character varying(255),
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


--
-- Name: TABLE job_batches; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.job_batches IS 'Job batches allow jobs to be collected into groups for managed processing.';


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255),
    payload text,
    attempts integer NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


--
-- Name: TABLE jobs; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.jobs IS 'All pending or in-progress jobs.';


--
-- Name: journal_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.journal_settings (
    journal_setting_id bigint NOT NULL,
    journal_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE journal_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.journal_settings IS 'More data about journals, including localized properties like policies.';


--
-- Name: journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.journals (
    journal_id bigint NOT NULL,
    path character varying(32),
    seq double precision NOT NULL,
    primary_locale character varying(28),
    enabled smallint NOT NULL,
    current_issue_id bigint
);


--
-- Name: TABLE journals; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.journals IS 'A list of all journals in the installation of OJS.';


--
-- Name: COLUMN journals.seq; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.journals.seq IS 'Used to order lists of journals';


--
-- Name: COLUMN journals.enabled; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.journals.enabled IS 'Controls whether or not the journal is considered "live" and will appear on the website. (Note that disabled journals may still be accessible, but only if the user knows the URL.)';


--
-- Name: library_file_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.library_file_settings (
    library_file_setting_id bigint NOT NULL,
    file_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text,
    setting_type character varying(6)
);


--
-- Name: TABLE library_file_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.library_file_settings IS 'More data about library files, including localized content such as names.';


--
-- Name: COLUMN library_file_settings.setting_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.library_file_settings.setting_type IS '(bool|int|float|string|object|date)';


--
-- Name: library_files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.library_files (
    file_id bigint NOT NULL,
    context_id bigint NOT NULL,
    file_name character varying(255),
    original_file_name character varying(255),
    file_type character varying(255),
    file_size bigint NOT NULL,
    type smallint NOT NULL,
    date_uploaded timestamp without time zone NOT NULL,
    date_modified timestamp without time zone NOT NULL,
    submission_id bigint,
    public_access smallint
);


--
-- Name: TABLE library_files; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.library_files IS 'Library files can be associated with the context (press/server/journal) or with individual submissions, and are typically forms, agreements, and other administrative documents that are not part of the scholarly content.';


--
-- Name: metrics_context; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metrics_context (
    metrics_context_id bigint NOT NULL,
    load_id character varying(50),
    context_id bigint NOT NULL,
    date date NOT NULL,
    metric integer NOT NULL
);


--
-- Name: TABLE metrics_context; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.metrics_context IS 'Daily statistics for views of the homepage.';


--
-- Name: metrics_counter_submission_daily; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metrics_counter_submission_daily (
    metrics_counter_submission_daily_id bigint NOT NULL,
    load_id character varying(50),
    context_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    date date NOT NULL,
    metric_investigations integer NOT NULL,
    metric_investigations_unique integer NOT NULL,
    metric_requests integer NOT NULL,
    metric_requests_unique integer NOT NULL
);


--
-- Name: TABLE metrics_counter_submission_daily; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.metrics_counter_submission_daily IS 'Daily statistics matching the COUNTER R5 protocol for views and downloads of published submissions and galleys.';


--
-- Name: metrics_counter_submission_institution_daily; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metrics_counter_submission_institution_daily (
    metrics_counter_submission_institution_daily_id bigint NOT NULL,
    load_id character varying(50),
    context_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    institution_id bigint NOT NULL,
    date date NOT NULL,
    metric_investigations integer NOT NULL,
    metric_investigations_unique integer NOT NULL,
    metric_requests integer NOT NULL,
    metric_requests_unique integer NOT NULL
);


--
-- Name: TABLE metrics_counter_submission_institution_daily; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.metrics_counter_submission_institution_daily IS 'Daily statistics matching the COUNTER R5 protocol for views and downloads from institutions.';


--
-- Name: metrics_counter_submission_institution_monthly; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: TABLE metrics_counter_submission_institution_monthly; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.metrics_counter_submission_institution_monthly IS 'Monthly statistics matching the COUNTER R5 protocol for views and downloads from institutions.';


--
-- Name: metrics_counter_submission_monthly; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: TABLE metrics_counter_submission_monthly; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.metrics_counter_submission_monthly IS 'Monthly statistics matching the COUNTER R5 protocol for views and downloads of published submissions and galleys.';


--
-- Name: metrics_issue; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metrics_issue (
    metrics_issue_id bigint NOT NULL,
    load_id character varying(50),
    context_id bigint NOT NULL,
    issue_id bigint NOT NULL,
    issue_galley_id bigint,
    date date NOT NULL,
    metric integer NOT NULL
);


--
-- Name: TABLE metrics_issue; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.metrics_issue IS 'Daily statistics for views and downloads of published issues.';


--
-- Name: metrics_submission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metrics_submission (
    metrics_submission_id bigint NOT NULL,
    load_id character varying(50),
    context_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    representation_id bigint,
    submission_file_id bigint,
    file_type bigint,
    assoc_type bigint NOT NULL,
    date date NOT NULL,
    metric integer NOT NULL
);


--
-- Name: TABLE metrics_submission; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.metrics_submission IS 'Daily statistics for views and downloads of published submissions and galleys.';


--
-- Name: metrics_submission_geo_daily; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metrics_submission_geo_daily (
    metrics_submission_geo_daily_id bigint NOT NULL,
    load_id character varying(50),
    context_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    country character varying(2),
    region character varying(3),
    city character varying(255),
    date date NOT NULL,
    metric integer NOT NULL,
    metric_unique integer NOT NULL
);


--
-- Name: TABLE metrics_submission_geo_daily; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.metrics_submission_geo_daily IS 'Daily statistics by country, region and city for views and downloads of published submissions and galleys.';


--
-- Name: metrics_submission_geo_monthly; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metrics_submission_geo_monthly (
    metrics_submission_geo_monthly_id bigint NOT NULL,
    context_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    country character varying(2),
    region character varying(3),
    city character varying(255),
    month integer NOT NULL,
    metric integer NOT NULL,
    metric_unique integer NOT NULL
);


--
-- Name: TABLE metrics_submission_geo_monthly; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.metrics_submission_geo_monthly IS 'Monthly statistics by country, region and city for views and downloads of published submissions and galleys.';


--
-- Name: navigation_menu_item_assignment_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.navigation_menu_item_assignment_settings (
    navigation_menu_item_assignment_setting_id bigint NOT NULL,
    navigation_menu_item_assignment_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text,
    setting_type character varying(6)
);


--
-- Name: TABLE navigation_menu_item_assignment_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.navigation_menu_item_assignment_settings IS 'More data about navigation menu item assignments to navigation menus, including localized content.';


--
-- Name: navigation_menu_item_assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.navigation_menu_item_assignments (
    navigation_menu_item_assignment_id bigint NOT NULL,
    navigation_menu_id bigint NOT NULL,
    navigation_menu_item_id bigint NOT NULL,
    parent_id bigint,
    seq bigint
);


--
-- Name: TABLE navigation_menu_item_assignments; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.navigation_menu_item_assignments IS 'Links navigation menu items to navigation menus.';


--
-- Name: navigation_menu_item_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.navigation_menu_item_settings (
    navigation_menu_item_setting_id bigint NOT NULL,
    navigation_menu_item_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text,
    setting_type character varying(6)
);


--
-- Name: TABLE navigation_menu_item_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.navigation_menu_item_settings IS 'More data about navigation menu items, including localized content such as names.';


--
-- Name: navigation_menu_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.navigation_menu_items (
    navigation_menu_item_id bigint NOT NULL,
    context_id bigint,
    path character varying(255),
    type character varying(255)
);


--
-- Name: TABLE navigation_menu_items; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.navigation_menu_items IS 'Navigation menu items are single elements within a navigation menu.';


--
-- Name: navigation_menus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.navigation_menus (
    navigation_menu_id bigint NOT NULL,
    context_id bigint,
    area_name character varying(255),
    title character varying(255)
);


--
-- Name: TABLE navigation_menus; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.navigation_menus IS 'Navigation menus on the website are installed with the software as a default set, and can be customized.';


--
-- Name: notes; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: TABLE notes; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.notes IS 'Notes allow users to annotate associated entities, such as submissions.';


--
-- Name: notification_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notification_settings (
    notification_setting_id bigint NOT NULL,
    notification_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(64),
    setting_value text,
    setting_type character varying(6)
);


--
-- Name: TABLE notification_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.notification_settings IS 'More data about notifications, including localized properties.';


--
-- Name: COLUMN notification_settings.setting_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.notification_settings.setting_type IS '(bool|int|float|string|object)';


--
-- Name: notification_subscription_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notification_subscription_settings (
    setting_id bigint NOT NULL,
    setting_name character varying(64),
    setting_value text,
    user_id bigint NOT NULL,
    context_id bigint,
    setting_type character varying(6)
);


--
-- Name: TABLE notification_subscription_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.notification_subscription_settings IS 'Which email notifications a user has chosen to unsubscribe from.';


--
-- Name: COLUMN notification_subscription_settings.setting_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.notification_subscription_settings.setting_type IS '(bool|int|float|string|object)';


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: TABLE notifications; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.notifications IS 'User notifications created during certain operations.';


--
-- Name: oai_resumption_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oai_resumption_tokens (
    oai_resumption_token_id bigint NOT NULL,
    token character varying(32),
    expire bigint NOT NULL,
    record_offset integer NOT NULL,
    params text
);


--
-- Name: TABLE oai_resumption_tokens; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.oai_resumption_tokens IS 'OAI resumption tokens are used to allow for pagination of large result sets into manageable pieces.';


--
-- Name: plugin_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plugin_settings (
    plugin_setting_id bigint NOT NULL,
    plugin_name character varying(80),
    context_id bigint,
    setting_name character varying(80),
    setting_value text,
    setting_type character varying(6)
);


--
-- Name: TABLE plugin_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.plugin_settings IS 'More data about plugins, including localized properties. This table is frequently used to store plugin-specific configuration.';


--
-- Name: COLUMN plugin_settings.setting_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.plugin_settings.setting_type IS '(bool|int|float|string|object)';


--
-- Name: publication_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.publication_categories (
    publication_category_id bigint NOT NULL,
    publication_id bigint NOT NULL,
    category_id bigint NOT NULL
);


--
-- Name: TABLE publication_categories; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.publication_categories IS 'Associates publications (and thus submissions) with categories.';


--
-- Name: publication_galley_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.publication_galley_settings (
    publication_galley_setting_id bigint NOT NULL,
    galley_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE publication_galley_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.publication_galley_settings IS 'More data about publication galleys, including localized content such as labels.';


--
-- Name: publication_galleys; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.publication_galleys (
    galley_id bigint NOT NULL,
    locale character varying(28),
    publication_id bigint NOT NULL,
    label character varying(255),
    submission_file_id bigint,
    seq double precision NOT NULL,
    remote_url character varying(2047),
    is_approved smallint NOT NULL,
    url_path character varying(64),
    doi_id bigint
);


--
-- Name: TABLE publication_galleys; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.publication_galleys IS 'Publication galleys are representations of a publication in a specific format, e.g. a PDF.';


--
-- Name: publication_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.publication_settings (
    publication_setting_id bigint NOT NULL,
    publication_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE publication_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.publication_settings IS 'More data about publications, including localized properties such as the title and abstract.';


--
-- Name: publications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.publications (
    publication_id bigint NOT NULL,
    access_status bigint,
    date_published date,
    last_modified timestamp without time zone,
    primary_contact_id bigint,
    section_id bigint,
    seq double precision NOT NULL,
    submission_id bigint NOT NULL,
    status smallint NOT NULL,
    url_path character varying(64),
    version bigint,
    doi_id bigint,
    issue_id bigint
);


--
-- Name: TABLE publications; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.publications IS 'Each publication is one version of a submission.';


--
-- Name: queries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.queries (
    query_id bigint NOT NULL,
    assoc_type bigint NOT NULL,
    assoc_id bigint NOT NULL,
    stage_id smallint NOT NULL,
    seq double precision NOT NULL,
    date_posted timestamp without time zone,
    date_modified timestamp without time zone,
    closed smallint NOT NULL
);


--
-- Name: TABLE queries; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.queries IS 'Discussions, usually related to a submission, created by editors, authors and other editorial staff.';


--
-- Name: query_participants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.query_participants (
    query_participant_id bigint NOT NULL,
    query_id bigint NOT NULL,
    user_id bigint NOT NULL
);


--
-- Name: TABLE query_participants; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.query_participants IS 'The users assigned to a discussion.';


--
-- Name: queued_payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.queued_payments (
    queued_payment_id bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    date_modified timestamp without time zone NOT NULL,
    expiry_date date,
    payment_data text
);


--
-- Name: TABLE queued_payments; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.queued_payments IS 'Unfulfilled (queued) payments, i.e. payments that have not yet been completed via an online payment system.';


--
-- Name: review_assignment_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.review_assignment_settings (
    review_assignment_settings_id bigint NOT NULL,
    review_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: COLUMN review_assignment_settings.review_assignment_settings_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.review_assignment_settings.review_assignment_settings_id IS 'Primary key.';


--
-- Name: COLUMN review_assignment_settings.review_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.review_assignment_settings.review_id IS 'Foreign key referencing record in review_assignments table';


--
-- Name: COLUMN review_assignment_settings.locale; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.review_assignment_settings.locale IS 'Locale key.';


--
-- Name: COLUMN review_assignment_settings.setting_name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.review_assignment_settings.setting_name IS 'Name of settings record.';


--
-- Name: COLUMN review_assignment_settings.setting_value; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.review_assignment_settings.setting_value IS 'Settings value.';


--
-- Name: review_assignments; Type: TABLE; Schema: public; Owner: -
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
    reminder_was_automatic smallint NOT NULL,
    declined smallint NOT NULL,
    cancelled smallint NOT NULL,
    date_cancelled timestamp without time zone,
    date_rated timestamp without time zone,
    date_reminded timestamp without time zone,
    quality smallint,
    review_round_id bigint NOT NULL,
    stage_id smallint NOT NULL,
    review_method smallint NOT NULL,
    round smallint NOT NULL,
    step smallint NOT NULL,
    review_form_id bigint,
    considered smallint,
    request_resent smallint NOT NULL
);


--
-- Name: TABLE review_assignments; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.review_assignments IS 'Data about peer review assignments for all submissions.';


--
-- Name: review_files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.review_files (
    review_file_id bigint NOT NULL,
    review_id bigint NOT NULL,
    submission_file_id bigint NOT NULL
);


--
-- Name: TABLE review_files; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.review_files IS 'A list of the submission files made available to each assigned reviewer.';


--
-- Name: review_form_element_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.review_form_element_settings (
    review_form_element_setting_id bigint NOT NULL,
    review_form_element_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text,
    setting_type character varying(6)
);


--
-- Name: TABLE review_form_element_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.review_form_element_settings IS 'More data about review form elements, including localized content such as question text.';


--
-- Name: review_form_elements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.review_form_elements (
    review_form_element_id bigint NOT NULL,
    review_form_id bigint NOT NULL,
    seq double precision,
    element_type bigint,
    required smallint,
    included smallint
);


--
-- Name: TABLE review_form_elements; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.review_form_elements IS 'Each review form element represents a single question on a review form.';


--
-- Name: review_form_responses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.review_form_responses (
    review_form_response_id bigint NOT NULL,
    review_form_element_id bigint NOT NULL,
    review_id bigint NOT NULL,
    response_type character varying(6),
    response_value text
);


--
-- Name: TABLE review_form_responses; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.review_form_responses IS 'Each review form response records a reviewer''s answer to a review form element associated with a peer review.';


--
-- Name: review_form_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.review_form_settings (
    review_form_setting_id bigint NOT NULL,
    review_form_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text,
    setting_type character varying(6)
);


--
-- Name: TABLE review_form_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.review_form_settings IS 'More data about review forms, including localized content such as names.';


--
-- Name: review_forms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.review_forms (
    review_form_id bigint NOT NULL,
    assoc_type bigint NOT NULL,
    assoc_id bigint NOT NULL,
    seq double precision,
    is_active smallint
);


--
-- Name: TABLE review_forms; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.review_forms IS 'Review forms provide custom templates for peer reviews with several types of questions.';


--
-- Name: review_round_files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.review_round_files (
    review_round_file_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    review_round_id bigint NOT NULL,
    stage_id smallint NOT NULL,
    submission_file_id bigint NOT NULL
);


--
-- Name: TABLE review_round_files; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.review_round_files IS 'Records the files made available to reviewers for a round of reviews. These can be further customized on a per review basis with review_files.';


--
-- Name: review_rounds; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.review_rounds (
    review_round_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    stage_id bigint,
    round smallint NOT NULL,
    review_revision bigint,
    status bigint
);


--
-- Name: TABLE review_rounds; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.review_rounds IS 'Peer review assignments are organized into multiple rounds on a submission.';


--
-- Name: reviewer_suggestion_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviewer_suggestion_settings (
    reviewer_suggestion_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE reviewer_suggestion_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.reviewer_suggestion_settings IS 'Reviewer suggestion settings table to contain multilingual or extra information';


--
-- Name: COLUMN reviewer_suggestion_settings.reviewer_suggestion_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.reviewer_suggestion_settings.reviewer_suggestion_id IS 'The foreign key mapping of this setting to reviewer_suggestions table';


--
-- Name: reviewer_suggestions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviewer_suggestions (
    reviewer_suggestion_id bigint NOT NULL,
    suggesting_user_id bigint,
    submission_id bigint NOT NULL,
    email character varying(255),
    orcid_id character varying(255),
    approved_at timestamp without time zone,
    approver_id bigint,
    reviewer_id bigint,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: TABLE reviewer_suggestions; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.reviewer_suggestions IS 'Author suggested reviewers at the submission time';


--
-- Name: COLUMN reviewer_suggestions.suggesting_user_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.reviewer_suggestions.suggesting_user_id IS 'The user/author who has made the suggestion';


--
-- Name: COLUMN reviewer_suggestions.submission_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.reviewer_suggestions.submission_id IS 'Submission at which the suggestion was made';


--
-- Name: COLUMN reviewer_suggestions.email; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.reviewer_suggestions.email IS 'Suggested reviewer email address';


--
-- Name: COLUMN reviewer_suggestions.orcid_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.reviewer_suggestions.orcid_id IS 'Suggested reviewer optional Orcid Id';


--
-- Name: COLUMN reviewer_suggestions.approved_at; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.reviewer_suggestions.approved_at IS 'If and when the suggestion approved to add/invite suggested_reviewer';


--
-- Name: COLUMN reviewer_suggestions.approver_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.reviewer_suggestions.approver_id IS 'The user who has approved the suggestion';


--
-- Name: COLUMN reviewer_suggestions.reviewer_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.reviewer_suggestions.reviewer_id IS 'The reviewer who has been added/invited through this suggestion';


--
-- Name: ror_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ror_settings (
    ror_setting_id bigint NOT NULL,
    ror_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE ror_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.ror_settings IS 'More data about Ror registry dataset cache';


--
-- Name: rors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rors (
    ror_id bigint NOT NULL,
    ror character varying(255),
    display_locale character varying(28),
    is_active smallint NOT NULL,
    search_phrase text
);


--
-- Name: TABLE rors; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.rors IS 'Ror registry dataset cache';


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: section_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.section_settings (
    section_setting_id bigint NOT NULL,
    section_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE section_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.section_settings IS 'More data about sections, including localized properties like section titles.';


--
-- Name: sections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sections (
    section_id bigint NOT NULL,
    journal_id bigint NOT NULL,
    review_form_id bigint,
    seq double precision NOT NULL,
    editor_restricted smallint NOT NULL,
    meta_indexed smallint NOT NULL,
    meta_reviewed smallint NOT NULL,
    abstracts_not_required smallint NOT NULL,
    hide_title smallint NOT NULL,
    hide_author smallint NOT NULL,
    is_inactive smallint NOT NULL,
    abstract_word_count bigint
);


--
-- Name: TABLE sections; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.sections IS 'A list of all sections into which submissions can be organized, forming the table of contents.';


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id character varying(255),
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    last_activity integer NOT NULL,
    payload text
);


--
-- Name: TABLE sessions; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.sessions IS 'Session data for logged-in users.';


--
-- Name: site; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.site (
    site_id bigint NOT NULL,
    redirect_context_id bigint,
    primary_locale character varying(28),
    min_password_length smallint NOT NULL,
    installed_locales character varying(1024),
    supported_locales character varying(1024),
    original_style_file_name character varying(255)
);


--
-- Name: TABLE site; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.site IS 'A singleton table describing basic information about the site.';


--
-- Name: COLUMN site.redirect_context_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.site.redirect_context_id IS 'If not null, redirect to the specified journal/conference/... site.';


--
-- Name: COLUMN site.primary_locale; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.site.primary_locale IS 'Primary locale for the site.';


--
-- Name: COLUMN site.installed_locales; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.site.installed_locales IS 'Locales for which support has been installed.';


--
-- Name: COLUMN site.supported_locales; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.site.supported_locales IS 'Locales supported by the site (for hosted journals/conferences/...).';


--
-- Name: site_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.site_settings (
    site_setting_id bigint NOT NULL,
    setting_name character varying(255),
    locale character varying(28),
    setting_value text
);


--
-- Name: TABLE site_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.site_settings IS 'More data about the site, including localized properties such as its name.';


--
-- Name: stage_assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stage_assignments (
    stage_assignment_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    user_group_id bigint NOT NULL,
    user_id bigint NOT NULL,
    date_assigned timestamp without time zone NOT NULL,
    recommend_only smallint NOT NULL,
    can_change_metadata smallint NOT NULL
);


--
-- Name: TABLE stage_assignments; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.stage_assignments IS 'Who can access a submission while it is in the editorial workflow. Includes all editorial and author assignments. For reviewers, see review_assignments.';


--
-- Name: static_page_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.static_page_settings (
    static_page_setting_id bigint NOT NULL,
    static_page_id bigint NOT NULL,
    locale character varying(14),
    setting_name character varying(255),
    setting_value text,
    setting_type character varying(6)
);


--
-- Name: COLUMN static_page_settings.setting_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.static_page_settings.setting_type IS '(bool|int|float|string|object)';


--
-- Name: static_pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.static_pages (
    static_page_id bigint NOT NULL,
    path character varying(255),
    context_id bigint NOT NULL
);


--
-- Name: subeditor_submission_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subeditor_submission_group (
    subeditor_submission_group_id bigint NOT NULL,
    context_id bigint NOT NULL,
    assoc_id bigint NOT NULL,
    assoc_type bigint NOT NULL,
    user_id bigint NOT NULL,
    user_group_id bigint NOT NULL
);


--
-- Name: TABLE subeditor_submission_group; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.subeditor_submission_group IS 'Subeditor assignments to e.g. sections and categories';


--
-- Name: submission_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.submission_comments (
    comment_id bigint NOT NULL,
    comment_type bigint,
    role_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    assoc_id bigint NOT NULL,
    author_id bigint NOT NULL,
    comment_title text,
    comments text,
    date_posted timestamp without time zone,
    date_modified timestamp without time zone,
    viewable smallint
);


--
-- Name: TABLE submission_comments; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.submission_comments IS 'Comments on a submission, e.g. peer review comments';


--
-- Name: submission_file_revisions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.submission_file_revisions (
    revision_id bigint NOT NULL,
    submission_file_id bigint NOT NULL,
    file_id bigint NOT NULL
);


--
-- Name: TABLE submission_file_revisions; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.submission_file_revisions IS 'Revisions map submission_file entries to files on the data store.';


--
-- Name: submission_file_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.submission_file_settings (
    submission_file_setting_id bigint NOT NULL,
    submission_file_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE submission_file_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.submission_file_settings IS 'Localized data about submission files like published metadata.';


--
-- Name: submission_files; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: TABLE submission_files; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.submission_files IS 'All files associated with a submission, such as those uploaded during submission, as revisions, or by copyeditors or layout editors for production.';


--
-- Name: submission_search_keyword_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.submission_search_keyword_list (
    keyword_id bigint NOT NULL,
    keyword_text character varying(60)
);


--
-- Name: TABLE submission_search_keyword_list; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.submission_search_keyword_list IS 'A list of all keywords used in the search index';


--
-- Name: submission_search_object_keywords; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.submission_search_object_keywords (
    submission_search_object_keyword_id bigint NOT NULL,
    object_id bigint NOT NULL,
    keyword_id bigint NOT NULL,
    pos integer NOT NULL
);


--
-- Name: TABLE submission_search_object_keywords; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.submission_search_object_keywords IS 'Relationships between search objects and keywords in the search index';


--
-- Name: COLUMN submission_search_object_keywords.pos; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.submission_search_object_keywords.pos IS 'Word position of the keyword in the object.';


--
-- Name: submission_search_objects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.submission_search_objects (
    object_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    type integer NOT NULL,
    assoc_id bigint
);


--
-- Name: TABLE submission_search_objects; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.submission_search_objects IS 'A list of all search objects indexed in the search index';


--
-- Name: COLUMN submission_search_objects.type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.submission_search_objects.type IS 'Type of item. E.g., abstract, fulltext, etc.';


--
-- Name: COLUMN submission_search_objects.assoc_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.submission_search_objects.assoc_id IS 'Optional ID of an associated record (e.g., a file_id)';


--
-- Name: submission_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.submission_settings (
    submission_setting_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE submission_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.submission_settings IS 'Localized data about submissions';


--
-- Name: submissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.submissions (
    submission_id bigint NOT NULL,
    context_id bigint NOT NULL,
    current_publication_id bigint,
    date_last_activity timestamp without time zone,
    date_submitted timestamp without time zone,
    last_modified timestamp without time zone,
    stage_id bigint NOT NULL,
    locale character varying(28),
    status smallint NOT NULL,
    submission_progress character varying(50),
    work_type smallint
);


--
-- Name: TABLE submissions; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.submissions IS 'All submissions submitted to the context, including incomplete, declined and unpublished submissions.';


--
-- Name: subscription_type_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subscription_type_settings (
    subscription_type_setting_id bigint NOT NULL,
    type_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text,
    setting_type character varying(6)
);


--
-- Name: TABLE subscription_type_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.subscription_type_settings IS 'More data about subscription types, including localized properties such as names.';


--
-- Name: subscription_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subscription_types (
    type_id bigint NOT NULL,
    journal_id bigint NOT NULL,
    cost numeric(8,2),
    currency_code_alpha character varying(3),
    duration smallint,
    format smallint NOT NULL,
    institutional smallint NOT NULL,
    membership smallint NOT NULL,
    disable_public_display smallint NOT NULL,
    seq double precision NOT NULL
);


--
-- Name: TABLE subscription_types; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.subscription_types IS 'Subscription types represent the kinds of subscriptions that a user or institution may have, such as an annual subscription or a discounted subscription.';


--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subscriptions (
    subscription_id bigint NOT NULL,
    journal_id bigint NOT NULL,
    user_id bigint NOT NULL,
    type_id bigint NOT NULL,
    date_start date,
    date_end timestamp without time zone,
    status smallint NOT NULL,
    membership character varying(40),
    reference_number character varying(40),
    notes text
);


--
-- Name: TABLE subscriptions; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.subscriptions IS 'A list of subscriptions, both institutional and individual, for journals that use subscription-based publishing.';


--
-- Name: temporary_files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.temporary_files (
    file_id bigint NOT NULL,
    user_id bigint NOT NULL,
    file_name character varying(90),
    file_type character varying(255),
    file_size bigint NOT NULL,
    original_file_name character varying(127),
    date_uploaded timestamp without time zone NOT NULL
);


--
-- Name: TABLE temporary_files; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.temporary_files IS 'Temporary files, e.g. where files are kept during an upload process before they are moved somewhere more appropriate.';


--
-- Name: usage_stats_institution_temporary_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usage_stats_institution_temporary_records (
    usage_stats_temp_institution_id bigint NOT NULL,
    load_id character varying(50),
    line_number bigint NOT NULL,
    institution_id bigint NOT NULL
);


--
-- Name: TABLE usage_stats_institution_temporary_records; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.usage_stats_institution_temporary_records IS 'Temporary stats for views and downloads from institutions based on visitor log records. Data in this table is provisional. See the metrics_* tables for compiled stats.';


--
-- Name: usage_stats_total_temporary_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usage_stats_total_temporary_records (
    usage_stats_temp_total_id bigint NOT NULL,
    date timestamp without time zone NOT NULL,
    ip character varying(64),
    user_agent character varying(255),
    line_number bigint NOT NULL,
    canonical_url character varying(255),
    issue_id bigint,
    issue_galley_id bigint,
    context_id bigint NOT NULL,
    submission_id bigint,
    representation_id bigint,
    submission_file_id bigint,
    assoc_type bigint NOT NULL,
    file_type smallint,
    country character varying(2),
    region character varying(3),
    city character varying(255),
    load_id character varying(50)
);


--
-- Name: TABLE usage_stats_total_temporary_records; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.usage_stats_total_temporary_records IS 'Temporary stats totals based on visitor log records. Data in this table is provisional. See the metrics_* tables for compiled stats.';


--
-- Name: usage_stats_unique_item_investigations_temporary_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usage_stats_unique_item_investigations_temporary_records (
    usage_stats_temp_unique_item_id bigint NOT NULL,
    date timestamp without time zone NOT NULL,
    ip character varying(64),
    user_agent character varying(255),
    line_number bigint NOT NULL,
    context_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    representation_id bigint,
    submission_file_id bigint,
    assoc_type bigint NOT NULL,
    file_type smallint,
    country character varying(2),
    region character varying(3),
    city character varying(255),
    load_id character varying(50)
);


--
-- Name: TABLE usage_stats_unique_item_investigations_temporary_records; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.usage_stats_unique_item_investigations_temporary_records IS 'Temporary stats on unique downloads based on visitor log records. Data in this table is provisional. See the metrics_* tables for compiled stats.';


--
-- Name: usage_stats_unique_item_requests_temporary_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usage_stats_unique_item_requests_temporary_records (
    usage_stats_temp_item_id bigint NOT NULL,
    date timestamp without time zone NOT NULL,
    ip character varying(64),
    user_agent character varying(255),
    line_number bigint NOT NULL,
    context_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    representation_id bigint,
    submission_file_id bigint,
    assoc_type bigint NOT NULL,
    file_type smallint,
    country character varying(2),
    region character varying(3),
    city character varying(255),
    load_id character varying(50)
);


--
-- Name: TABLE usage_stats_unique_item_requests_temporary_records; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.usage_stats_unique_item_requests_temporary_records IS 'Temporary stats on unique views based on visitor log records. Data in this table is provisional. See the metrics_* tables for compiled stats.';


--
-- Name: user_group_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_group_settings (
    user_group_setting_id bigint NOT NULL,
    user_group_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE user_group_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.user_group_settings IS 'More data about user groups, including localized properties such as the name.';


--
-- Name: user_group_stage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_group_stage (
    user_group_stage_id bigint NOT NULL,
    context_id bigint NOT NULL,
    user_group_id bigint NOT NULL,
    stage_id bigint NOT NULL
);


--
-- Name: TABLE user_group_stage; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.user_group_stage IS 'Which stages of the editorial workflow the user_groups can access.';


--
-- Name: user_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_groups (
    user_group_id bigint NOT NULL,
    context_id bigint,
    role_id bigint NOT NULL,
    is_default smallint NOT NULL,
    show_title smallint NOT NULL,
    permit_self_registration smallint NOT NULL,
    permit_metadata_edit smallint NOT NULL,
    permit_settings smallint NOT NULL,
    masthead smallint NOT NULL
);


--
-- Name: TABLE user_groups; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.user_groups IS 'All defined user roles in a context, such as Author, Reviewer, Section Editor and Journal Manager.';


--
-- Name: user_interests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_interests (
    user_interest_id bigint NOT NULL,
    user_id bigint NOT NULL,
    controlled_vocab_entry_id bigint NOT NULL
);


--
-- Name: TABLE user_interests; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.user_interests IS 'Associates users with user interests (which are stored in the controlled vocabulary tables).';


--
-- Name: user_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_settings (
    user_setting_id bigint NOT NULL,
    user_id bigint NOT NULL,
    locale character varying(28),
    setting_name character varying(255),
    setting_value text
);


--
-- Name: TABLE user_settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.user_settings IS 'More data about users, including localized properties like their name and affiliation.';


--
-- Name: user_user_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_user_groups (
    user_user_group_id bigint NOT NULL,
    user_group_id bigint NOT NULL,
    user_id bigint NOT NULL,
    date_start timestamp without time zone,
    date_end timestamp without time zone,
    masthead smallint
);


--
-- Name: TABLE user_user_groups; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.user_user_groups IS 'Maps users to their assigned user_groups.';


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    user_id bigint NOT NULL,
    username character varying(32),
    password character varying(255),
    email character varying(255),
    url character varying(2047),
    phone character varying(32),
    mailing_address character varying(255),
    billing_address character varying(255),
    country character varying(90),
    locales character varying(255),
    gossip text,
    date_last_email timestamp without time zone,
    date_registered timestamp without time zone NOT NULL,
    date_validated timestamp without time zone,
    date_last_login timestamp without time zone,
    must_change_password smallint,
    auth_id bigint,
    auth_str character varying(255),
    disabled smallint NOT NULL,
    disabled_reason text,
    inline_help smallint,
    remember_token character varying(100)
);


--
-- Name: TABLE users; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.users IS 'All registered users, including authentication data and profile data.';


--
-- Name: users_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users_tokens (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    token bytea NOT NULL,
    context character varying(255) NOT NULL,
    sent_to character varying(255),
    authenticated_at timestamp(0) without time zone,
    inserted_at timestamp(0) without time zone NOT NULL
);


--
-- Name: users_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_tokens_id_seq OWNED BY public.users_tokens.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.versions (
    version_id bigint NOT NULL,
    major integer NOT NULL,
    minor integer NOT NULL,
    revision integer NOT NULL,
    build integer NOT NULL,
    date_installed timestamp without time zone NOT NULL,
    current smallint NOT NULL,
    product_type character varying(30),
    product character varying(30),
    product_class_name character varying(80),
    lazy_load smallint NOT NULL,
    sitewide smallint NOT NULL
);


--
-- Name: TABLE versions; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.versions IS 'Describes the installation and upgrade version history for the application and all installed plugins.';


--
-- Name: COLUMN versions.major; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.versions.major IS 'Major component of version number, e.g. the 2 in OJS 2.3.8-0';


--
-- Name: COLUMN versions.minor; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.versions.minor IS 'Minor component of version number, e.g. the 3 in OJS 2.3.8-0';


--
-- Name: COLUMN versions.revision; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.versions.revision IS 'Revision component of version number, e.g. the 8 in OJS 2.3.8-0';


--
-- Name: COLUMN versions.build; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.versions.build IS 'Build component of version number, e.g. the 0 in OJS 2.3.8-0';


--
-- Name: COLUMN versions.current; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.versions.current IS '1 iff the version entry being described is currently active. This permits the table to store past installation history for forensic purposes.';


--
-- Name: COLUMN versions.product_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.versions.product_type IS 'Describes the type of product this row describes, e.g. "plugins.generic" (for a generic plugin) or "core" for the application itself';


--
-- Name: COLUMN versions.product; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.versions.product IS 'Uniquely identifies the product this version row describes, e.g. "ojs2" for OJS 2.x, "languageToggle" for the language toggle block plugin, etc.';


--
-- Name: COLUMN versions.product_class_name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.versions.product_class_name IS 'Specifies the class name associated with this product, for plugins, or the empty string where not applicable.';


--
-- Name: COLUMN versions.lazy_load; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.versions.lazy_load IS '1 iff the row describes a lazy-load plugin; 0 otherwise';


--
-- Name: COLUMN versions.sitewide; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.versions.sitewide IS '1 iff the row describes a site-wide plugin; 0 otherwise';


--
-- Name: users_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_tokens ALTER COLUMN id SET DEFAULT nextval('public.users_tokens_id_seq'::regclass);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_unique UNIQUE (user_id);


--
-- Name: users_tokens users_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_tokens
    ADD CONSTRAINT users_tokens_pkey PRIMARY KEY (id);


--
-- Name: users_tokens_context_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_tokens_context_index ON public.users_tokens USING btree (context);


--
-- Name: users_tokens_token_context_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_tokens_token_context_index ON public.users_tokens USING btree (token, context);


--
-- Name: users_tokens_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_tokens_user_id_index ON public.users_tokens USING btree (user_id);


--
-- Name: users_tokens users_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_tokens
    ADD CONSTRAINT users_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict xVEE46UqMPwIIeUtDT4PeB8aAjn4nsfcA8t7AI0XhijauJghp2rSSPUVleZqkyg

INSERT INTO public."schema_migrations" (version) VALUES (20260723043341);
INSERT INTO public."schema_migrations" (version) VALUES (20260724044658);
