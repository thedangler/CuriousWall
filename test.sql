--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;


CREATE TABLE posts (
    post_id bigint NOT NULL,
    post_text text NOT NULL,
    post_date timestamp without time zone NOT NULL,
    post_topic integer NOT NULL,
    post_by integer NOT NULL
);


COMMENT ON TABLE posts IS 'posts';


CREATE SEQUENCE posts_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;



ALTER SEQUENCE posts_post_id_seq OWNED BY posts.post_id;



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


CREATE SEQUENCE topics_topic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;



ALTER SEQUENCE topics_topic_id_seq OWNED BY topics.topic_id;



CREATE TABLE users (
    user_id integer NOT NULL,
    user_name character varying NOT NULL,
    user_pass bytea NOT NULL,
    permissions smallint DEFAULT 0 NOT NULL
);


CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE ONLY posts ALTER COLUMN post_id SET DEFAULT nextval('posts_post_id_seq'::regclass);



ALTER TABLE ONLY topics ALTER COLUMN topic_id SET DEFAULT nextval('topics_topic_id_seq'::regclass);



ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);




ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (post_id);




ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (topic_id);



ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);



ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_post_by_fkey FOREIGN KEY (post_by) REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;




ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_post_topic_fkey FOREIGN KEY (post_topic) REFERENCES topics(topic_id) ON UPDATE CASCADE ON DELETE CASCADE;




ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_topic_by_fkey FOREIGN KEY (topic_by) REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


