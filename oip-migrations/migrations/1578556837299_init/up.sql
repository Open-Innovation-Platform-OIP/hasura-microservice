CREATE FUNCTION public.add_creator_to_owners() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO problem_owners(user_id, problem_id, timestamp) VALUES (new.created_by, new.id, current_timestamp);
	RETURN NEW;
END;$$;
CREATE FUNCTION public.add_new_collaborator_notifications() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE 
	_user integer;
BEGIN
    FOR _user IN SELECT get_watchers(new.problem_id) UNION SELECT get_problem_owners(new.problem_id) UNION SELECT get_collaborators(new.problem_id)
		LOOP
			IF _user != NEW.user_id THEN
				RAISE NOTICE 'Adding notification for user with id %', _user;
				INSERT INTO notifications(user_id, is_update, problem_id, collaborator, timestamp) VALUES (_user, true, new.problem_id, new.user_id, current_timestamp);
			END IF;
		END LOOP;
	RETURN NEW;
END;$$;
CREATE FUNCTION public.add_new_mention_notification() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE 
	_user integer;
	_problem_id integer;
BEGIN
	SELECT discussions.problem_id INTO _problem_id  from discussions where id=new.discussion_id;
	INSERT INTO notifications(user_id, is_update, problem_id, discussion_id, timestamp) VALUES (new.user_id, true, _problem_id, new.discussion_id, current_timestamp);
	RETURN NEW;
END;$$;
CREATE FUNCTION public.add_new_problem_notifications() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE 
	_user integer;
BEGIN
    FOR _user IN SELECT get_relevant_users(new.problem_id) EXCEPT SELECT get_problem_owners(new.problem_id)
		LOOP
			RAISE NOTICE 'Adding notification for user with id %', _user;
			INSERT INTO notifications(user_id, is_update, problem_id, tag_id, timestamp) VALUES (_user, false, new.problem_id, new.tag_id, current_timestamp);
		END LOOP;
	RETURN NEW;
END;$$;
CREATE FUNCTION public.add_new_updated_enrichment_notifications() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE 
	_user integer;
BEGIN
    FOR _user IN SELECT get_watchers(new.problem_id) UNION SELECT get_problem_owners(new.problem_id)
		LOOP
			IF _user != NEW.created_by THEN
				RAISE NOTICE 'Adding notification for user with id %', _user;
				INSERT INTO notifications(user_id, is_update, problem_id, enrichment_id, timestamp) VALUES (_user, true, new.problem_id, new.id, current_timestamp);
			END IF;
		END LOOP;
	RETURN NEW;
END;$$;
CREATE FUNCTION public.add_new_updated_validation_notifications() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE 
	_user integer;
BEGIN
    FOR _user IN SELECT get_watchers(new.problem_id) UNION SELECT get_problem_owners(new.problem_id)
		LOOP
			IF _user != NEW.validated_by THEN
				RAISE NOTICE 'Adding notification for user with id %', _user;
				INSERT INTO notifications(user_id, is_update, problem_id, validated_by, timestamp) VALUES (_user, true, new.problem_id, new.validated_by, current_timestamp);
			END IF;
		END LOOP;
	RETURN NEW;
END;$$;
CREATE FUNCTION public.add_notifications(_id integer) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_user integer;
BEGIN
    FOR _user IN SELECT get_relevant_users(_id)
		LOOP
			RAISE NOTICE 'Adding notification for user with id %', _user;
			INSERT INTO notifications(user_id,is_update, problem_id, timestamp) VALUES (_user, false, _id, current_timestamp);
			RETURN next _user;
		END LOOP;
	RETURN;
END;
$$;
CREATE FUNCTION public.add_solution_collaborator_notifications() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE 
	_user integer;
BEGIN
    FOR _user IN SELECT get_watchers(new.solution_id, false) UNION SELECT get_solution_owners(new.solution_id) UNION SELECT get_collaborators(new.solution_id, false)
		LOOP
			IF _user != NEW.user_id THEN
				RAISE NOTICE 'Adding notification for user with id %', _user;
				INSERT INTO notifications(user_id, is_update, solution_id, collaborator, timestamp) VALUES (_user, true, new.solution_id, new.user_id, current_timestamp);
			END IF;
		END LOOP;
	RETURN NEW;
END;$$;
CREATE FUNCTION public.add_solution_enrichment_notifications() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE 
	_user integer;
BEGIN
    FOR _user IN SELECT get_watchers(new.solution_id, false) UNION SELECT get_solution_owners(new.solution_id)
		LOOP
			IF _user != NEW.created_by THEN
				RAISE NOTICE 'Adding notification for user with id %', _user;
				INSERT INTO notifications(user_id, is_update, solution_id, enrichment_id, timestamp) VALUES (_user, true, new.solution_id, new.id, current_timestamp);
			END IF;
		END LOOP;
	RETURN NEW;
END;$$;
CREATE FUNCTION public.add_solution_validation_notifications() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE 
	_user integer;
BEGIN
    FOR _user IN SELECT get_watchers(new.solution_id, false) UNION SELECT get_solution_owners(new.solution_id)
		LOOP
			IF _user != NEW.validated_by THEN
				RAISE NOTICE 'Adding notification for user with id %', _user;
				INSERT INTO notifications(user_id, is_update, solution_id, validated_by, timestamp) VALUES (_user, true, new.solution_id, new.validated_by, current_timestamp);
			END IF;
		END LOOP;
	RETURN NEW;
END;$$;
CREATE FUNCTION public.add_updated_problem_notifications() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE 
	_user integer;
BEGIN
    FOR _user IN SELECT get_watchers(new.id)
		LOOP
			RAISE NOTICE 'Adding notification for user with id %', _user;
			INSERT INTO notifications(user_id, is_update, problem_id, timestamp) VALUES (_user, true, new.id, current_timestamp);
		END LOOP;
	RETURN NEW;
END;$$;
CREATE FUNCTION public.add_updated_solution_notifications() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE 
	_user integer;
BEGIN
    FOR _user IN SELECT get_watchers(new.id, false)
		LOOP
			RAISE NOTICE 'Adding notification for user with id %', _user;
			INSERT INTO notifications(user_id, is_update, solution_id, timestamp) VALUES (_user, true, new.id, current_timestamp);
		END LOOP;
	RETURN NEW;
END;$$;
CREATE FUNCTION public.fibonacci(n integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$DECLARE
   counter INTEGER := 0 ; 
   i INTEGER := 0 ; 
   j INTEGER := 1 ;
BEGIN
 IF (n < 1) THEN
 RETURN 0 ;
 END IF; 
 WHILE counter < n LOOP
 counter := counter + 1 ; 
 SELECT j, i + j INTO i, j ;
 END LOOP ; 
 RETURN i ;
END ;
$$;
CREATE FUNCTION public.for_loop_through_query(n integer DEFAULT 10) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec RECORD;
	owner TEXT[];
BEGIN
    FOR rec IN SELECT owners
        FROM problems 
		WHERE owners IS NOT NULL
        LIMIT n 
		LOOP
			FOREACH owner SLICE 1 IN ARRAY rec.owners
			   LOOP
				  RAISE NOTICE '%', owner;
			   END LOOP;
		END LOOP;
END;
$$;
CREATE FUNCTION public.get_collaborators(_id integer, is_problem boolean DEFAULT true) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec RECORD;
	_user RECORD;
BEGIN
	CASE WHEN is_problem=true THEN
		FOR rec IN SELECT user_id
        	FROM collaborators 
 			WHERE problem_id=_id
			LOOP
				RETURN next rec.user_id;
			END LOOP;
			return;
	ELSE
		FOR rec IN SELECT user_id
        	FROM solution_collaborators 
 			WHERE solution_id=_id
			LOOP
				RETURN next rec.user_id;
			END LOOP;
			return;
	END CASE;
END;
$$;
CREATE FUNCTION public.get_enrichment_watchers(_id integer) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    _rec RECORD;
	_watchers RECORD;
	_user_id INTEGER[];
BEGIN
	FOR _rec IN SELECT problem_id
		FROM enrichments
		WHERE id=_id
 		LOOP
		FOR _watchers IN SELECT watched_by
			FROM problems
			WHERE id=_rec.problem_id AND watched_by IS NOT NULL
			LOOP
 				FOREACH _user_id SLICE 1 IN ARRAY _watchers.watched_by
 				LOOP
					return next _user_id[1];
 					RAISE NOTICE 'User % is watching problem %', _user_id[1], _rec.problem_id;
 				END LOOP;
 			END LOOP;
 		END LOOP;
 		return;
END;
$$;
CREATE FUNCTION public.get_mentions(_id integer) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec RECORD;
	_user RECORD;
BEGIN
	FOR rec IN SELECT user_id
		FROM discussion_mentions 
		WHERE discussion_id=_id
		LOOP
			RETURN next rec.user_id;
		END LOOP;
		return;
END;
$$;
CREATE FUNCTION public.get_problem_owners(_id integer) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec RECORD;
	_user RECORD;
BEGIN
	FOR rec IN SELECT user_id
        	FROM problem_owners 
 			WHERE problem_id=_id
			UNION SELECT created_by as user_id FROM problems WHERE id=_id
			LOOP
				RETURN next rec.user_id;
			END LOOP;
			return;
END;
$$;
CREATE FUNCTION public.get_problem_tags(_id integer) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec RECORD;
BEGIN
	FOR rec IN SELECT tag_id
        FROM problems_tags 
 		WHERE problem_id=_id
 		LOOP
			return next rec;
  			RAISE NOTICE '%', rec.tag_id;
 		END LOOP;
		return;
END;
$$;
CREATE FUNCTION public.get_problem_title(_title text) RETURNS SETOF text
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec RECORD;
BEGIN
	FOR rec IN SELECT title
        FROM problems 
 		WHERE problem_id=_id
 		LOOP
			return next rec;
  			RAISE NOTICE '%', rec.tag_id;
 		END LOOP;
		return;
END;
$$;
CREATE FUNCTION public.get_problems_title() RETURNS text
    LANGUAGE sql
    AS $$select title from problems$$;
CREATE FUNCTION public.get_relevant_users(_id integer, is_problem boolean DEFAULT true) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec RECORD;
	_user RECORD;
BEGIN
	CASE WHEN is_problem=true THEN
		FOR rec IN SELECT tag_id
        	FROM problems_tags 
 			WHERE problem_id=_id
			LOOP
				FOR _user in SELECT user_id
					FROM users_tags
					WHERE tag_id=rec.tag_id
					LOOP
						return next _user;
					END LOOP;
			END LOOP;
			return;
	ELSE
		FOR rec IN SELECT tag_id
			FROM solutions_tags 
			WHERE solution_id=_id
			LOOP
				FOR _user in SELECT user_id
					FROM users_tags
					WHERE tag_id=rec.tag_id
					LOOP
						return next _user;
					END LOOP;
			END LOOP;
		return;
	END CASE;
END;
$$;
CREATE FUNCTION public.get_solution_owners(_id integer) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec RECORD;
	_user RECORD;
BEGIN
	FOR rec IN SELECT user_id
        	FROM solution_owners 
 			WHERE solution_id=_id
			UNION SELECT created_by as user_id FROM solutions WHERE id=_id
			LOOP
				RETURN next rec.user_id;
			END LOOP;
			return;
END;
$$;
CREATE FUNCTION public.get_tags_name() RETURNS text
    LANGUAGE sql
    AS $$select name from tags$$;
CREATE FUNCTION public.get_tags_name(_title text) RETURNS SETOF text
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec RECORD;
BEGIN
	FOR rec IN SELECT name
        FROM tags 
 		WHERE problem_id=_id
 		LOOP
			return next rec;
  			RAISE NOTICE '%', rec.tag_id;
 		END LOOP;
		return;
END;
$$;
CREATE FUNCTION public.get_watchers(_id integer, is_problem boolean DEFAULT true) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec RECORD;
	_user RECORD;
BEGIN
	CASE WHEN is_problem=true THEN
		FOR rec IN SELECT user_id
        	FROM problem_watchers 
 			WHERE problem_id=_id
			LOOP
				RETURN next rec.user_id;
			END LOOP;
			return;
	ELSE
		FOR rec IN SELECT user_id
        	FROM solution_watchers 
 			WHERE solution_id=_id
			LOOP
				RETURN next rec.user_id;
			END LOOP;
			return;
	END CASE;
END;
$$;
CREATE FUNCTION public.print_relevant_users(_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	_user RECORD;
BEGIN
    FOR _user IN SELECT get_relevant_users(_id)
		LOOP
			RAISE NOTICE '%', _user;
		END LOOP;
END;
$$;
CREATE TABLE public.problems (
    id integer NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    resources_needed text,
    organization text NOT NULL,
    impact text,
    extent text,
    beneficiary_attributes text,
    reported_by jsonb,
    created_at timestamp with time zone,
    image_urls jsonb,
    video_urls jsonb,
    is_deleted boolean DEFAULT false NOT NULL,
    min_population integer DEFAULT 0 NOT NULL,
    featured_url text,
    embed_urls jsonb,
    featured_type text DEFAULT 'image'::text,
    is_draft boolean DEFAULT true NOT NULL,
    max_population numeric NOT NULL,
    attachments jsonb,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    edited_at timestamp with time zone DEFAULT now() NOT NULL,
    organization_id integer,
    user_id integer NOT NULL
);
CREATE FUNCTION public.search_problems_multiword(search text) RETURNS SETOF public.problems
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    arr TEXT ARRAY;
	_problem RECORD;
BEGIN
    arr := regexp_split_to_array(search, '\s+');
     FOR i IN 1..array_length(arr, 1)
	 LOOP
	    IF LENGTH(arr[i])>3 THEN
         RAISE NOTICE '%', arr[i];
		 FOR _problem IN SELECT DISTINCT * FROM problems 
		 	WHERE title ilike ('%' || arr[i] || '%') OR description ilike ('%' || arr[i] || '%')
			LOOP
				RETURN next _problem;
			END LOOP;
		END IF;
     END LOOP;
     RETURN;
END
$$;
CREATE FUNCTION public.search_problems_v2(search text) RETURNS SETOF public.problems
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    arr TEXT ARRAY;
	_problem RECORD;
BEGIN
    arr := regexp_split_to_array(search, '\s+');
     FOR i IN 1..array_length(arr, 1)
	 LOOP
	    IF LENGTH(arr[i])>=3 THEN
         RAISE NOTICE '%', arr[i];
		 FOR _problem IN SELECT DISTINCT * FROM problems 
		 	WHERE title ilike ('%' || arr[i] || '%') OR description ilike ('%' || arr[i] || '%')
			LOOP
				RETURN next _problem;
			END LOOP;
		END IF;
     END LOOP;
     RETURN;
END
$$;
CREATE TABLE public.solutions (
    id integer NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    created_at timestamp with time zone,
    technology text NOT NULL,
    impact text NOT NULL,
    website_url text,
    deployment integer NOT NULL,
    image_urls jsonb NOT NULL,
    video_urls jsonb NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    featured_url text NOT NULL,
    embed_urls jsonb NOT NULL,
    featured_type text NOT NULL,
    is_draft boolean DEFAULT false NOT NULL,
    attachments jsonb,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    timeline text,
    pilots text,
    resources text,
    extent text,
    beneficiary_attributes text,
    min_budget integer DEFAULT 0 NOT NULL,
    max_budget integer,
    budget_title text,
    edited_at timestamp with time zone DEFAULT now() NOT NULL,
    user_id integer NOT NULL
);
CREATE FUNCTION public.search_solutions_v2(search text) RETURNS SETOF public.solutions
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    arr TEXT ARRAY;
	_solution RECORD;
BEGIN
    arr := regexp_split_to_array(search, '\s+');
     FOR i IN 1..array_length(arr, 1)
	 LOOP
	    IF LENGTH(arr[i])>=3 THEN
         RAISE NOTICE '%', arr[i];
		 FOR _solution IN SELECT DISTINCT * FROM solutions 
		 	WHERE title ilike ('%' || arr[i] || '%') OR description ilike ('%' || arr[i] || '%')
			LOOP
				RETURN next _solution;
			END LOOP;
		END IF;
     END LOOP;
     RETURN;
END
$$;
CREATE TABLE public.users (
    id integer NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    token text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    organization text DEFAULT 'Unknown'::text NOT NULL,
    name text DEFAULT 'Anonymous'::text NOT NULL,
    qualification text,
    photo_url jsonb,
    phone_number text,
    is_ngo boolean DEFAULT false,
    is_innovator boolean DEFAULT false,
    is_entrepreneur boolean DEFAULT false,
    is_expert boolean DEFAULT false,
    is_incubator boolean DEFAULT false,
    is_funder boolean DEFAULT false,
    is_government boolean DEFAULT false,
    is_beneficiary boolean DEFAULT false,
    edited_at timestamp with time zone DEFAULT now(),
    notify_email boolean DEFAULT true,
    notify_sms boolean DEFAULT true,
    notify_app boolean DEFAULT true,
    otp text,
    is_verified boolean DEFAULT false NOT NULL,
    organization_id integer,
    is_admin boolean DEFAULT false NOT NULL,
    is_approved boolean DEFAULT false NOT NULL,
    email_private boolean DEFAULT false,
    number_private boolean DEFAULT false,
    organization_private boolean DEFAULT false,
    persona_private boolean DEFAULT false,
    interests_private boolean DEFAULT false,
    location_private boolean DEFAULT false
);
CREATE FUNCTION public.search_users(search text) RETURNS SETOF public.users
    LANGUAGE sql STABLE
    AS $$
    SELECT *
    FROM users
    WHERE
      name ilike ('%' || search || '%')
      OR email ilike ('%' || search || '%')
$$;
CREATE FUNCTION public.select_problem_tags(_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec RECORD;
	_user RECORD;
BEGIN
    FOR rec IN SELECT watchers_id
        FROM problems 
		WHERE problem_id=_id
		LOOP
			FOR _user in SELECT user_id
				FROM problems
				WHERE watchers_id=rec.watchers_id
				LOOP
					INSERT INTO test_notifications(user_id, is_update, problem_id, timestamp) VALUES (_user.user_id, true, _id, current_timestamp); 
					RAISE NOTICE '%', _user.user_id;
				END LOOP;
		END LOOP;
END;
$$;
CREATE FUNCTION public.set_created_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$;
CREATE FUNCTION public.set_problem_updated_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE problems 
		SET updated_at = now()
	WHERE id=NEW.problem_id;
	RETURN NEW;
END;$$;
CREATE FUNCTION public.text_to_arr(text) RETURNS void
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
DECLARE
    arr TEXT ARRAY;
BEGIN
    arr := regexp_split_to_array($1, '\s+');
     FOR i IN 1..array_length(arr, 1) LOOP
         RAISE NOTICE '%', arr[i];
		 PERFORM search_problems(arr[i]);
     END LOOP;
     RETURN;
END
$_$;
CREATE TABLE public.discussion_mentions (
    discussion_id integer NOT NULL,
    user_id integer NOT NULL
);
CREATE TABLE public.discussion_voters (
    user_id integer NOT NULL,
    discussion_id integer NOT NULL
);
CREATE TABLE public.discussions (
    id integer NOT NULL,
    problem_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    text text NOT NULL,
    solution_id integer,
    linked_comment_id integer,
    attachments jsonb DEFAULT '[]'::json,
    is_deleted boolean DEFAULT false NOT NULL,
    edited_at timestamp with time zone DEFAULT now() NOT NULL,
    user_id integer NOT NULL
);
CREATE TABLE public.domain_tags (
    domain_id integer NOT NULL,
    tag_id integer NOT NULL
);
CREATE TABLE public.domains (
    url text NOT NULL,
    colour text NOT NULL,
    id integer NOT NULL,
    is_primary boolean DEFAULT false NOT NULL
);
CREATE TABLE public.enrichment_locations (
    enrichment_id integer NOT NULL,
    location_id integer NOT NULL
);
CREATE TABLE public.enrichment_voters (
    user_id integer NOT NULL,
    enrichment_id integer NOT NULL
);
CREATE TABLE public.enrichments (
    id integer NOT NULL,
    problem_id integer,
    solution_id integer,
    description text NOT NULL,
    organization text NOT NULL,
    impact text,
    extent text,
    beneficiary_attributes text,
    resources_needed text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    edited_at timestamp with time zone DEFAULT now() NOT NULL,
    image_urls jsonb,
    video_urls jsonb,
    is_deleted boolean DEFAULT false NOT NULL,
    min_population integer DEFAULT 0 NOT NULL,
    featured_url text,
    featured_type text,
    embed_urls jsonb,
    max_population numeric NOT NULL,
    attachments jsonb,
    user_id integer NOT NULL
);
CREATE TABLE public.invited_users (
    email text NOT NULL,
    id integer NOT NULL,
    accepted boolean DEFAULT false NOT NULL,
    admin_invited boolean,
    name text,
    organization integer
);
CREATE TABLE public.locations (
    id integer NOT NULL,
    location public.geometry NOT NULL,
    location_name text NOT NULL,
    lat numeric NOT NULL,
    long numeric NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    city text,
    state text,
    country text,
    type text
);
CREATE TABLE public.notifications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    problem_id integer,
    solution_id integer,
    enrichment_id integer,
    discussion_id integer,
    "timestamp" text DEFAULT now() NOT NULL,
    is_update boolean DEFAULT false NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    validated_by integer,
    collaborator integer,
    tag_id integer
);
CREATE TABLE public.organizations (
    id integer NOT NULL,
    name text NOT NULL
);
CREATE TABLE public.problem_collaborators (
    user_id integer NOT NULL,
    problem_id integer NOT NULL,
    intent text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    edited_at timestamp with time zone DEFAULT now() NOT NULL,
    is_ngo boolean DEFAULT false,
    is_entrepreneur boolean DEFAULT false,
    is_expert boolean DEFAULT false,
    is_incubator boolean DEFAULT false,
    is_innovator boolean DEFAULT false,
    is_funder boolean DEFAULT false,
    is_government boolean DEFAULT false,
    is_beneficiary boolean DEFAULT false
);
CREATE TABLE public.problem_locations (
    problem_id integer NOT NULL,
    location_id integer NOT NULL
);
CREATE TABLE public.problem_owners (
    user_id integer NOT NULL,
    problem_id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT now() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE TABLE public.problem_validations (
    user_id integer NOT NULL,
    problem_id integer NOT NULL,
    comment text NOT NULL,
    agree boolean NOT NULL,
    files jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    edited_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE TABLE public.problem_voters (
    user_id integer NOT NULL,
    problem_id integer NOT NULL
);
CREATE TABLE public.problem_watchers (
    user_id integer NOT NULL,
    problem_id integer NOT NULL
);
CREATE TABLE public.problems_solutions (
    problem_id integer NOT NULL,
    solution_id integer NOT NULL
);
CREATE TABLE public.problems_tags (
    problem_id integer NOT NULL,
    tag_id integer NOT NULL
);
CREATE TABLE public.solution_collaborators (
    solution_id integer NOT NULL,
    user_id integer NOT NULL,
    intent text NOT NULL,
    edited_at timestamp with time zone DEFAULT now() NOT NULL,
    is_ngo boolean DEFAULT false,
    is_innovator boolean DEFAULT false,
    is_entrepreneur boolean DEFAULT false,
    is_expert boolean DEFAULT false,
    is_incubator boolean DEFAULT false,
    is_funder boolean DEFAULT false,
    is_government boolean DEFAULT false,
    is_beneficiary boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE TABLE public.solution_owners (
    user_id integer NOT NULL,
    solution_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE TABLE public.solution_validations (
    solution_id integer NOT NULL,
    comment text NOT NULL,
    agree boolean DEFAULT false NOT NULL,
    files jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    edited_at timestamp with time zone DEFAULT now() NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    user_id integer NOT NULL
);
CREATE TABLE public.solution_voters (
    user_id integer NOT NULL,
    solution_id integer NOT NULL
);
CREATE TABLE public.solution_watchers (
    user_id integer NOT NULL,
    solution_id integer NOT NULL
);
CREATE TABLE public.solutions_tags (
    solution_id integer NOT NULL,
    tag_id integer NOT NULL
);
CREATE TABLE public.tags (
    id integer NOT NULL,
    name text NOT NULL
);
CREATE TABLE public.user_locations (
    user_id integer NOT NULL,
    location_id integer NOT NULL
);
CREATE TABLE public.users_tags (
    user_id integer NOT NULL,
    tag_id integer NOT NULL
);
CREATE SEQUENCE public.discussions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.discussions_id_seq OWNED BY public.discussions.id;
CREATE SEQUENCE public.domains_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.domains_id_seq OWNED BY public.domains.id;
CREATE SEQUENCE public.enrichments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.enrichments_id_seq OWNED BY public.enrichments.id;
CREATE SEQUENCE public.invited_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.invited_users_id_seq OWNED BY public.invited_users.id;
CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;
CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;
CREATE SEQUENCE public.organizations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.organizations_id_seq OWNED BY public.organizations.id;
CREATE SEQUENCE public.problems_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.problems_id_seq OWNED BY public.problems.id;
CREATE SEQUENCE public.solutions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.solutions_id_seq OWNED BY public.solutions.id;
CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;
CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
ALTER TABLE ONLY public.discussions ALTER COLUMN id SET DEFAULT nextval('public.discussions_id_seq'::regclass);
ALTER TABLE ONLY public.domains ALTER COLUMN id SET DEFAULT nextval('public.domains_id_seq'::regclass);
ALTER TABLE ONLY public.enrichments ALTER COLUMN id SET DEFAULT nextval('public.enrichments_id_seq'::regclass);
ALTER TABLE ONLY public.invited_users ALTER COLUMN id SET DEFAULT nextval('public.invited_users_id_seq'::regclass);
ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);
ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);
ALTER TABLE ONLY public.organizations ALTER COLUMN id SET DEFAULT nextval('public.organizations_id_seq'::regclass);
ALTER TABLE ONLY public.problems ALTER COLUMN id SET DEFAULT nextval('public.problems_id_seq'::regclass);
ALTER TABLE ONLY public.solutions ALTER COLUMN id SET DEFAULT nextval('public.solutions_id_seq'::regclass);
ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);
ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
ALTER TABLE ONLY public.discussion_mentions
    ADD CONSTRAINT discussion_mentions_pkey PRIMARY KEY (discussion_id, user_id);
ALTER TABLE ONLY public.discussion_voters
    ADD CONSTRAINT discussion_voters_pkey PRIMARY KEY (user_id, discussion_id);
ALTER TABLE ONLY public.discussions
    ADD CONSTRAINT discussions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.domain_tags
    ADD CONSTRAINT domain_tags_pkey PRIMARY KEY (tag_id, domain_id);
ALTER TABLE ONLY public.domains
    ADD CONSTRAINT domains_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.enrichment_locations
    ADD CONSTRAINT enrichment_locations_pkey PRIMARY KEY (enrichment_id, location_id);
ALTER TABLE ONLY public.enrichment_voters
    ADD CONSTRAINT enrichment_voters_pkey PRIMARY KEY (user_id, enrichment_id);
ALTER TABLE ONLY public.enrichments
    ADD CONSTRAINT enrichments_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.invited_users
    ADD CONSTRAINT invited_users_email_key UNIQUE (email);
ALTER TABLE ONLY public.invited_users
    ADD CONSTRAINT invited_users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_id_key UNIQUE (id);
ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_location_name_key UNIQUE (location_name);
ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id, lat, long);
ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_id_key UNIQUE (id);
ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_name_key UNIQUE (name);
ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (name, id);
ALTER TABLE ONLY public.problem_collaborators
    ADD CONSTRAINT problem_collaborators_pkey PRIMARY KEY (user_id, problem_id);
ALTER TABLE ONLY public.problem_locations
    ADD CONSTRAINT problem_locations_pkey PRIMARY KEY (problem_id, location_id);
ALTER TABLE ONLY public.problem_owners
    ADD CONSTRAINT problem_owners_pkey PRIMARY KEY (user_id, problem_id);
ALTER TABLE ONLY public.problem_validations
    ADD CONSTRAINT problem_validations_pkey PRIMARY KEY (user_id, problem_id);
ALTER TABLE ONLY public.problem_voters
    ADD CONSTRAINT problem_voters_pkey PRIMARY KEY (user_id, problem_id);
ALTER TABLE ONLY public.problem_watchers
    ADD CONSTRAINT problem_watchers_pkey PRIMARY KEY (user_id, problem_id);
ALTER TABLE ONLY public.problems
    ADD CONSTRAINT problems_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.problems_solutions
    ADD CONSTRAINT problems_solutions_pkey PRIMARY KEY (problem_id, solution_id);
ALTER TABLE ONLY public.problems_tags
    ADD CONSTRAINT problems_tags_pkey PRIMARY KEY (problem_id, tag_id);
ALTER TABLE ONLY public.solution_collaborators
    ADD CONSTRAINT solution_collaborators_pkey PRIMARY KEY (solution_id, user_id);
ALTER TABLE ONLY public.solution_owners
    ADD CONSTRAINT solution_owners_pkey PRIMARY KEY (user_id, solution_id);
ALTER TABLE ONLY public.solution_validations
    ADD CONSTRAINT solution_validations_pkey PRIMARY KEY (solution_id, user_id);
ALTER TABLE ONLY public.solution_voters
    ADD CONSTRAINT solution_voters_pkey PRIMARY KEY (user_id, solution_id);
ALTER TABLE ONLY public.solution_watchers
    ADD CONSTRAINT solution_watchers_pkey PRIMARY KEY (user_id, solution_id);
ALTER TABLE ONLY public.solutions
    ADD CONSTRAINT solutions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.solutions_tags
    ADD CONSTRAINT solutions_tags_pkey PRIMARY KEY (solution_id, tag_id);
ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_name_key UNIQUE (name);
ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_locations
    ADD CONSTRAINT user_locations_pkey PRIMARY KEY (user_id, location_id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users_tags
    ADD CONSTRAINT users_tags_pkey PRIMARY KEY (user_id, tag_id);
CREATE TRIGGER set_problem_updated AFTER INSERT OR UPDATE ON public.discussions FOR EACH ROW EXECUTE PROCEDURE public.set_problem_updated_timestamp();
ALTER TABLE ONLY public.discussion_mentions
    ADD CONSTRAINT discussion_mentions_discussion_id_fkey FOREIGN KEY (discussion_id) REFERENCES public.discussions(id);
ALTER TABLE ONLY public.discussion_mentions
    ADD CONSTRAINT discussion_mentions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
ALTER TABLE ONLY public.discussion_voters
    ADD CONSTRAINT discussion_voters_discussion_id_fkey FOREIGN KEY (discussion_id) REFERENCES public.discussions(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.discussion_voters
    ADD CONSTRAINT discussion_voters_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
ALTER TABLE ONLY public.discussions
    ADD CONSTRAINT discussions_linked_comment_id_fkey FOREIGN KEY (linked_comment_id) REFERENCES public.discussions(id);
ALTER TABLE ONLY public.discussions
    ADD CONSTRAINT discussions_problem_id_fkey FOREIGN KEY (problem_id) REFERENCES public.problems(id);
ALTER TABLE ONLY public.discussions
    ADD CONSTRAINT discussions_solution_id_fkey FOREIGN KEY (solution_id) REFERENCES public.solutions(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.discussions
    ADD CONSTRAINT discussions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.domain_tags
    ADD CONSTRAINT domain_tags_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES public.domains(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.domain_tags
    ADD CONSTRAINT domain_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.enrichment_locations
    ADD CONSTRAINT enrichment_locations_enrichment_id_fkey FOREIGN KEY (enrichment_id) REFERENCES public.enrichments(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.enrichment_locations
    ADD CONSTRAINT enrichment_locations_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.enrichment_voters
    ADD CONSTRAINT enrichment_voters_enrichment_id_fkey FOREIGN KEY (enrichment_id) REFERENCES public.enrichments(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.enrichment_voters
    ADD CONSTRAINT enrichment_voters_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.enrichments
    ADD CONSTRAINT enrichments_problem_id_fkey FOREIGN KEY (problem_id) REFERENCES public.problems(id);
ALTER TABLE ONLY public.enrichments
    ADD CONSTRAINT enrichments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.invited_users
    ADD CONSTRAINT invited_users_organization_fkey FOREIGN KEY (organization) REFERENCES public.organizations(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_collaborator_fkey FOREIGN KEY (collaborator) REFERENCES public.users(id);
ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_discussion_id_fkey FOREIGN KEY (discussion_id) REFERENCES public.discussions(id);
ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_enrichment_id_fkey FOREIGN KEY (enrichment_id) REFERENCES public.enrichments(id);
ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_problem_id_fkey FOREIGN KEY (problem_id) REFERENCES public.problems(id);
ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_solution_id_fkey FOREIGN KEY (solution_id) REFERENCES public.solutions(id);
ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id);
ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_validated_by_fkey FOREIGN KEY (validated_by) REFERENCES public.users(id);
ALTER TABLE ONLY public.problem_collaborators
    ADD CONSTRAINT problem_collaborators_problem_id_fkey FOREIGN KEY (problem_id) REFERENCES public.problems(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.problem_collaborators
    ADD CONSTRAINT problem_collaborators_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.problem_locations
    ADD CONSTRAINT problem_locations_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.problem_locations
    ADD CONSTRAINT problem_locations_problem_id_fkey FOREIGN KEY (problem_id) REFERENCES public.problems(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.problem_owners
    ADD CONSTRAINT problem_owners_problem_id_fkey FOREIGN KEY (problem_id) REFERENCES public.problems(id);
ALTER TABLE ONLY public.problem_owners
    ADD CONSTRAINT problem_owners_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
ALTER TABLE ONLY public.problem_validations
    ADD CONSTRAINT problem_validations_problem_id_fkey FOREIGN KEY (problem_id) REFERENCES public.problems(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.problem_validations
    ADD CONSTRAINT problem_validations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.problem_voters
    ADD CONSTRAINT problem_voters_problem_id_fkey FOREIGN KEY (problem_id) REFERENCES public.problems(id);
ALTER TABLE ONLY public.problem_voters
    ADD CONSTRAINT problem_voters_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
ALTER TABLE ONLY public.problem_watchers
    ADD CONSTRAINT problem_watchers_problem_id_fkey FOREIGN KEY (problem_id) REFERENCES public.problems(id);
ALTER TABLE ONLY public.problem_watchers
    ADD CONSTRAINT problem_watchers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
ALTER TABLE ONLY public.problems_solutions
    ADD CONSTRAINT problems_solutions_problem_id_fkey FOREIGN KEY (problem_id) REFERENCES public.problems(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.problems_solutions
    ADD CONSTRAINT problems_solutions_solution_id_fkey FOREIGN KEY (solution_id) REFERENCES public.solutions(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.problems_tags
    ADD CONSTRAINT problems_tags_problem_id_fkey FOREIGN KEY (problem_id) REFERENCES public.problems(id);
ALTER TABLE ONLY public.problems_tags
    ADD CONSTRAINT problems_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id);
ALTER TABLE ONLY public.problems
    ADD CONSTRAINT problems_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.solution_collaborators
    ADD CONSTRAINT solution_collaborators_solution_id_fkey FOREIGN KEY (solution_id) REFERENCES public.solutions(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.solution_collaborators
    ADD CONSTRAINT solution_collaborators_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.solution_owners
    ADD CONSTRAINT solution_owners_solution_id_fkey FOREIGN KEY (solution_id) REFERENCES public.solutions(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.solution_owners
    ADD CONSTRAINT solution_owners_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.solution_validations
    ADD CONSTRAINT solution_validations_solution_id_fkey FOREIGN KEY (solution_id) REFERENCES public.solutions(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.solution_validations
    ADD CONSTRAINT solution_validations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.solution_voters
    ADD CONSTRAINT solution_voters_solution_id_fkey FOREIGN KEY (solution_id) REFERENCES public.solutions(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.solution_voters
    ADD CONSTRAINT solution_voters_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.solution_watchers
    ADD CONSTRAINT solution_watchers_solution_id_fkey FOREIGN KEY (solution_id) REFERENCES public.solutions(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.solution_watchers
    ADD CONSTRAINT solution_watchers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.solutions_tags
    ADD CONSTRAINT solutions_tags_solution_id_fkey FOREIGN KEY (solution_id) REFERENCES public.solutions(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.solutions_tags
    ADD CONSTRAINT solutions_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.solutions
    ADD CONSTRAINT solutions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.user_locations
    ADD CONSTRAINT user_locations_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.user_locations
    ADD CONSTRAINT user_locations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.users_tags
    ADD CONSTRAINT users_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id);
ALTER TABLE ONLY public.users_tags
    ADD CONSTRAINT users_tags_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
