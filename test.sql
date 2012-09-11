--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: betpixforum; Type: COMMENT; Schema: -; Owner: singlelife_user
--

COMMENT ON DATABASE betpixforum IS 'test db for ivory php forum - using for sport bet pix';


--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

--
-- Name: plpythonu; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE PROCEDURAL LANGUAGE plpythonu;


ALTER PROCEDURAL LANGUAGE plpythonu OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- Name: plpgsql_call_handler(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION plpgsql_call_handler() RETURNS language_handler
    LANGUAGE c
    AS '/usr/lib/postgresql/8.4/lib/plpgsql.so', 'plpgsql_call_handler';


ALTER FUNCTION public.plpgsql_call_handler() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: posts; Type: TABLE; Schema: public; Owner: singlelife_user; Tablespace: 
--

CREATE TABLE posts (
    post_id bigint NOT NULL,
    post_text text NOT NULL,
    post_date timestamp without time zone NOT NULL,
    post_topic integer NOT NULL,
    post_by integer NOT NULL
);


ALTER TABLE public.posts OWNER TO singlelife_user;

--
-- Name: TABLE posts; Type: COMMENT; Schema: public; Owner: singlelife_user
--

COMMENT ON TABLE posts IS 'posts';


--
-- Name: posts_post_id_seq; Type: SEQUENCE; Schema: public; Owner: singlelife_user
--

CREATE SEQUENCE posts_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.posts_post_id_seq OWNER TO singlelife_user;

--
-- Name: posts_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: singlelife_user
--

ALTER SEQUENCE posts_post_id_seq OWNED BY posts.post_id;


--
-- Name: topics; Type: TABLE; Schema: public; Owner: singlelife_user; Tablespace: 
--

CREATE TABLE topics (
    topic_id integer NOT NULL,
    topic_title character varying NOT NULL,
    topic_date timestamp without time zone DEFAULT now() NOT NULL,
    topic_by integer NOT NULL,
    topic_score numeric NOT NULL,
    topic_replies integer NOT NULL,
    sticky smallint DEFAULT 0 NOT NULL,
    locked smallint DEFAULT 0 NOT NULL,
    topic_text text NOT NULL
);


ALTER TABLE public.topics OWNER TO singlelife_user;

--
-- Name: topics_topic_id_seq; Type: SEQUENCE; Schema: public; Owner: singlelife_user
--

CREATE SEQUENCE topics_topic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.topics_topic_id_seq OWNER TO singlelife_user;

--
-- Name: topics_topic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: singlelife_user
--

ALTER SEQUENCE topics_topic_id_seq OWNED BY topics.topic_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: singlelife_user; Tablespace: 
--

CREATE TABLE users (
    user_id integer NOT NULL,
    user_name character varying NOT NULL,
    user_pass bytea NOT NULL,
    permissions smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.users OWNER TO singlelife_user;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: singlelife_user
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO singlelife_user;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: singlelife_user
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: post_id; Type: DEFAULT; Schema: public; Owner: singlelife_user
--

ALTER TABLE ONLY posts ALTER COLUMN post_id SET DEFAULT nextval('posts_post_id_seq'::regclass);


--
-- Name: topic_id; Type: DEFAULT; Schema: public; Owner: singlelife_user
--

ALTER TABLE ONLY topics ALTER COLUMN topic_id SET DEFAULT nextval('topics_topic_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: singlelife_user
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: singlelife_user; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (post_id);


--
-- Name: topics_pkey; Type: CONSTRAINT; Schema: public; Owner: singlelife_user; Tablespace: 
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (topic_id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: singlelife_user; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: posts_post_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: singlelife_user
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_post_by_fkey FOREIGN KEY (post_by) REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: posts_post_topic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: singlelife_user
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_post_topic_fkey FOREIGN KEY (post_topic) REFERENCES topics(topic_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: topics_topic_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: singlelife_user
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_topic_by_fkey FOREIGN KEY (topic_by) REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--
