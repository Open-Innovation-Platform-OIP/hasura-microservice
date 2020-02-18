create sequence "public"."invited_users_id_seq";

drop trigger if exists "notify_hasura_index_problems_deploy_INSERT" on "public"."problems";

drop trigger if exists "notify_hasura_index_problems_deploy_UPDATE" on "public"."problems";

drop trigger if exists "notify_hasura_problems_insert_INSERT" on "public"."problems";

drop trigger if exists "notify_hasura_index_solution_deploy_INSERT" on "public"."solutions";

drop trigger if exists "notify_hasura_index_solution_deploy_UPDATE" on "public"."solutions";

drop trigger if exists "notify_hasura_index_users_deploy_INSERT" on "public"."users";

drop trigger if exists "notify_hasura_index_users_deploy_UPDATE" on "public"."users";

alter table "public"."users" drop constraint "users_organization_id_fkey";

alter table "public"."organizations" drop constraint "organizations_pkey";

drop index if exists "public"."organizations_pkey";











    "table_schema" text not null,
    "table_name" text not null,
    "computed_field_name" text not null,
    "definition" jsonb not null,
    "comment" text
);


create table "public"."invited_users" (
    "email" text not null,
    "id" integer not null default nextval('invited_users_id_seq'::regclass),
    "accepted" boolean not null default false,
    "admin_invited" boolean,
    "name" text,
    "organization" integer
);





alter table "public"."domains" add column "is_primary" boolean not null default false;

alter table "public"."locations" add column "city" text;

alter table "public"."locations" add column "country" text;

alter table "public"."locations" add column "state" text;

alter table "public"."locations" add column "type" text;

alter table "public"."users" add column "email_private" boolean default false;

alter table "public"."users" add column "interests_private" boolean default false;

alter table "public"."users" add column "location_private" boolean default false;

alter table "public"."users" add column "number_private" boolean default false;

alter table "public"."users" add column "organization_private" boolean default false;

alter table "public"."users" add column "persona_private" boolean default false;

set check_function_bodies = off;

        CASE
        END AS function_name,
        CASE
        END AS function_schema


 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row(OLD );
      _new := row(NEW );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', NULL,
      'new', row_to_json(NEW )
    );
    BEGIN
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
        END IF;
    END;

    RETURN NULL;
  END;
$function$
;

 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row((SELECT  "e"  FROM  (SELECT  OLD."embed_urls" , OLD."attachments" , OLD."resources_needed" , OLD."is_draft" , OLD."max_population" , OLD."image_urls" , OLD."is_deleted" , OLD."beneficiary_attributes" , OLD."reported_by" , OLD."extent" , OLD."min_population" , OLD."organization_id" , OLD."featured_url" , OLD."updated_at" , OLD."featured_type" , OLD."edited_at" , OLD."impact" , OLD."created_at" , OLD."id" , OLD."title" , OLD."organization" , OLD."user_id" , OLD."video_urls" , OLD."description"        ) AS "e"      ) );
      _new := row((SELECT  "e"  FROM  (SELECT  NEW."embed_urls" , NEW."attachments" , NEW."resources_needed" , NEW."is_draft" , NEW."max_population" , NEW."image_urls" , NEW."is_deleted" , NEW."beneficiary_attributes" , NEW."reported_by" , NEW."extent" , NEW."min_population" , NEW."organization_id" , NEW."featured_url" , NEW."updated_at" , NEW."featured_type" , NEW."edited_at" , NEW."impact" , NEW."created_at" , NEW."id" , NEW."title" , NEW."organization" , NEW."user_id" , NEW."video_urls" , NEW."description"        ) AS "e"      ) );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', row_to_json(OLD ),
      'new', row_to_json(NEW )
    );
    BEGIN
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
        END IF;
    END;

    RETURN NULL;
  END;
$function$
;

 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row(OLD );
      _new := row(NEW );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', NULL,
      'new', row_to_json(NEW )
    );
    BEGIN
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
        END IF;
    END;

    RETURN NULL;
  END;
$function$
;

 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row((SELECT  "e"  FROM  (SELECT  OLD."embed_urls" , OLD."website_url" , OLD."attachments" , OLD."pilots" , OLD."is_draft" , OLD."image_urls" , OLD."min_budget" , OLD."is_deleted" , OLD."beneficiary_attributes" , OLD."extent" , OLD."max_budget" , OLD."resources" , OLD."featured_url" , OLD."updated_at" , OLD."featured_type" , OLD."edited_at" , OLD."budget_title" , OLD."impact" , OLD."created_at" , OLD."id" , OLD."title" , OLD."timeline" , OLD."user_id" , OLD."video_urls" , OLD."technology" , OLD."description" , OLD."deployment"        ) AS "e"      ) );
      _new := row((SELECT  "e"  FROM  (SELECT  NEW."embed_urls" , NEW."website_url" , NEW."attachments" , NEW."pilots" , NEW."is_draft" , NEW."image_urls" , NEW."min_budget" , NEW."is_deleted" , NEW."beneficiary_attributes" , NEW."extent" , NEW."max_budget" , NEW."resources" , NEW."featured_url" , NEW."updated_at" , NEW."featured_type" , NEW."edited_at" , NEW."budget_title" , NEW."impact" , NEW."created_at" , NEW."id" , NEW."title" , NEW."timeline" , NEW."user_id" , NEW."video_urls" , NEW."technology" , NEW."description" , NEW."deployment"        ) AS "e"      ) );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', row_to_json(OLD ),
      'new', row_to_json(NEW )
    );
    BEGIN
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
        END IF;
    END;

    RETURN NULL;
  END;
$function$
;

 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row(OLD );
      _new := row(NEW );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', NULL,
      'new', row_to_json(NEW )
    );
    BEGIN
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
        END IF;
    END;

    RETURN NULL;
  END;
$function$
;

 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row((SELECT  "e"  FROM  (SELECT  OLD."email" , OLD."location_private" , OLD."phone_number" , OLD."photo_url" , OLD."is_funder" , OLD."is_ngo" , OLD."is_expert" , OLD."persona_private" , OLD."notify_sms" , OLD."organization_id" , OLD."name" , OLD."interests_private" , OLD."edited_at" , OLD."created_at" , OLD."notify_app" , OLD."is_innovator" , OLD."id" , OLD."is_government" , OLD."notify_email" , OLD."is_verified" , OLD."organization" , OLD."is_beneficiary" , OLD."email_private" , OLD."is_entrepreneur" , OLD."is_incubator" , OLD."number_private" , OLD."qualification" , OLD."organization_private"        ) AS "e"      ) );
      _new := row((SELECT  "e"  FROM  (SELECT  NEW."email" , NEW."location_private" , NEW."phone_number" , NEW."photo_url" , NEW."is_funder" , NEW."is_ngo" , NEW."is_expert" , NEW."persona_private" , NEW."notify_sms" , NEW."organization_id" , NEW."name" , NEW."interests_private" , NEW."edited_at" , NEW."created_at" , NEW."notify_app" , NEW."is_innovator" , NEW."id" , NEW."is_government" , NEW."notify_email" , NEW."is_verified" , NEW."organization" , NEW."is_beneficiary" , NEW."email_private" , NEW."is_entrepreneur" , NEW."is_incubator" , NEW."number_private" , NEW."qualification" , NEW."organization_private"        ) AS "e"      ) );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', row_to_json(OLD ),
      'new', row_to_json(NEW )
    );
    BEGIN
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
        END IF;
    END;

    RETURN NULL;
  END;
$function$
;

    invited_users.id,
    invited_users.accepted,
    invited_users.admin_invited,
    invited_users.name,
    invited_users.organization
   FROM invited_users;


 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  DECLARE r "public"."invited_users"%ROWTYPE;
  DECLARE conflict_clause jsonb;
  DECLARE action text;
  DECLARE constraint_name text;
  DECLARE set_expression text;
  BEGIN
    conflict_clause = current_setting('hasura.conflict_clause')::jsonb;
    IF ('true') THEN
      CASE
        WHEN conflict_clause = 'null'::jsonb THEN INSERT INTO "public"."invited_users" VALUES (NEW.*) RETURNING * INTO r;
        ELSE
          action = conflict_clause ->> 'action';
          constraint_name = quote_ident(conflict_clause ->> 'constraint');
          set_expression = conflict_clause ->> 'set_expression';
          IF action is NOT NULL THEN
            CASE
              WHEN action = 'ignore'::text AND constraint_name IS NULL THEN
                INSERT INTO "public"."invited_users" VALUES (NEW.*) ON CONFLICT DO NOTHING RETURNING * INTO r;
              WHEN action = 'ignore'::text AND constraint_name is NOT NULL THEN
                EXECUTE 'INSERT INTO "public"."invited_users" VALUES ($1.*) ON CONFLICT ON CONSTRAINT ' || constraint_name ||
                           ' DO NOTHING RETURNING *' INTO r USING NEW;
              ELSE
                EXECUTE 'INSERT INTO "public"."invited_users" VALUES ($1.*) ON CONFLICT ON CONSTRAINT ' || constraint_name ||
                           ' DO UPDATE ' || set_expression || ' RETURNING *' INTO r USING NEW;
            END CASE;
            ELSE
              RAISE internal_error using message = 'action is not found'; RETURN NULL;
          END IF;
      END CASE;
      IF r IS NULL THEN RETURN null; ELSE RETURN r; END IF;
     ELSE RAISE check_violation using message = 'insert check constraint failed'; RETURN NULL;
     END IF;
  END $function$
;

CREATE OR REPLACE FUNCTION public.get_problems_title()
 RETURNS text
 LANGUAGE sql
AS $function$select title from problems$function$
;

CREATE OR REPLACE FUNCTION public.get_tags_name()
 RETURNS text
 LANGUAGE sql
AS $function$select name from tags$function$
;

         SELECT fkey.table_schema AS src_table_schema,
            fkey.table_name AS src_table_name,
            (fkey.columns ->> 0) AS src_column_name,
            json_agg(json_build_object('schema', fkey.ref_table_table_schema, 'name', fkey.ref_table)) AS ref_tables
          WHERE (json_array_length(fkey.columns) = 1)
          GROUP BY fkey.table_schema, fkey.table_name, (fkey.columns ->> 0)
        )
 SELECT columns.table_schema,
    columns.table_name,
    columns.column_name AS name,
    columns.udt_name AS type,
    columns.is_nullable,
    columns.ordinal_position,
    COALESCE(pkey_refs.ref_tables, '[]'::json) AS primary_key_references,
    col_description(pg_class.oid, (columns.ordinal_position)::integer) AS description
   FROM (((information_schema.columns
     JOIN pg_class ON ((pg_class.relname = (columns.table_name)::name)))
     JOIN pg_namespace ON (((pg_namespace.oid = pg_class.relnamespace) AND (pg_namespace.nspname = (columns.table_schema)::name))))
     LEFT JOIN primary_key_references pkey_refs ON ((((columns.table_schema)::text = pkey_refs.src_table_schema) AND ((columns.table_name)::text = pkey_refs.src_table_name) AND ((columns.column_name)::text = pkey_refs.src_column_name))));


    (pn.nspname)::text AS function_schema,
    pd.description,
        CASE
            WHEN (p.provariadic = (0)::oid) THEN false
            ELSE true
        END AS has_variadic,
        CASE
            WHEN ((p.provolatile)::text = ('i'::character(1))::text) THEN 'IMMUTABLE'::text
            WHEN ((p.provolatile)::text = ('s'::character(1))::text) THEN 'STABLE'::text
            WHEN ((p.provolatile)::text = ('v'::character(1))::text) THEN 'VOLATILE'::text
            ELSE NULL::text
        END AS function_type,
    pg_get_functiondef(p.oid) AS function_definition,
    (rtn.nspname)::text AS return_type_schema,
    (rt.typname)::text AS return_type_name,
    (rt.typtype)::text AS return_type_type,
    p.proretset AS returns_set,
    ( SELECT COALESCE(json_agg(json_build_object('schema', q.schema, 'name', q.name, 'type', q.type)), '[]'::json) AS "coalesce"
           FROM ( SELECT pt.typname AS name,
                    pns.nspname AS schema,
                    pt.typtype AS type,
                    pat.ordinality
                   FROM ((unnest(COALESCE(p.proallargtypes, (p.proargtypes)::oid[])) WITH ORDINALITY pat(oid, ordinality)
                     LEFT JOIN pg_type pt ON ((pt.oid = pat.oid)))
                     LEFT JOIN pg_namespace pns ON ((pt.typnamespace = pns.oid)))
                  ORDER BY pat.ordinality) q) AS input_arg_types,
    to_json(COALESCE(p.proargnames, ARRAY[]::text[])) AS input_arg_names,
    p.pronargdefaults AS default_args,
    (p.oid)::integer AS function_oid
   FROM ((((pg_proc p
     JOIN pg_namespace pn ON ((pn.oid = p.pronamespace)))
     JOIN pg_type rt ON ((rt.oid = p.prorettype)))
     JOIN pg_namespace rtn ON ((rtn.oid = rt.typnamespace)))
     LEFT JOIN pg_description pd ON ((p.oid = pd.objoid)))
           FROM pg_aggregate
          WHERE ((pg_aggregate.aggfnoid)::oid = p.oid)))));


    row_to_json(( SELECT e.*::record AS e
                    (EXISTS ( SELECT 1
                           FROM information_schema.tables


    tables.table_schema,
    descriptions.description,
    COALESCE(columns.columns, '[]'::json) AS columns,
    COALESCE(pk.columns, '[]'::json) AS primary_key_columns,
    COALESCE(constraints.constraints, '[]'::json) AS constraints,
    COALESCE(views.view_info, 'null'::json) AS view_info
   FROM (((((information_schema.tables tables
     LEFT JOIN ( SELECT c.table_name,
            c.table_schema,
            json_agg(json_build_object('name', c.name, 'type', c.type, 'is_nullable', (c.is_nullable)::boolean, 'references', c.primary_key_references, 'description', c.description)) AS columns
          GROUP BY c.table_schema, c.table_name) columns ON ((((tables.table_schema)::text = (columns.table_schema)::text) AND ((tables.table_name)::text = (columns.table_name)::text))))
     LEFT JOIN ( SELECT c.table_schema,
            c.table_name,
            json_agg(c.constraint_name) AS constraints
           FROM information_schema.table_constraints c
          WHERE (((c.constraint_type)::text = 'UNIQUE'::text) OR ((c.constraint_type)::text = 'PRIMARY KEY'::text))
          GROUP BY c.table_schema, c.table_name) constraints ON ((((tables.table_schema)::text = (constraints.table_schema)::text) AND ((tables.table_name)::text = (constraints.table_name)::text))))
     LEFT JOIN ( SELECT v.table_schema,
            v.table_name,
            json_build_object('is_updatable', ((v.is_updatable)::boolean OR (v.is_trigger_updatable)::boolean), 'is_deletable', ((v.is_updatable)::boolean OR (v.is_trigger_deletable)::boolean), 'is_insertable', ((v.is_insertable_into)::boolean OR (v.is_trigger_insertable_into)::boolean)) AS view_info
           FROM information_schema.views v) views ON ((((tables.table_schema)::text = (views.table_schema)::text) AND ((tables.table_name)::text = (views.table_name)::text))))
     LEFT JOIN ( SELECT pc.relname AS table_name,
            pn.nspname AS table_schema,
            pd.description
           FROM ((pg_class pc
             LEFT JOIN pg_namespace pn ON ((pn.oid = pc.relnamespace)))
             LEFT JOIN pg_description pd ON ((pd.objoid = pc.oid)))
          WHERE (pd.objsubid = 0)) descriptions ON ((((tables.table_schema)::name = descriptions.table_schema) AND ((tables.table_name)::name = descriptions.table_name))));


 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row(OLD );
      _new := row(NEW );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', NULL,
      'new', row_to_json(NEW )
    );
    BEGIN
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
        END IF;
    END;

    RETURN NULL;
  END;
$function$
;

 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row(OLD );
      _new := row(NEW );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', NULL,
      'new', row_to_json(NEW )
    );
    BEGIN
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
        END IF;
    END;

    RETURN NULL;
  END;
$function$
;

 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row(OLD );
      _new := row(NEW );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', NULL,
      'new', row_to_json(NEW )
    );
    BEGIN
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
        END IF;
    END;

    RETURN NULL;
  END;
$function$
;

 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row(OLD );
      _new := row(NEW );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', NULL,
      'new', row_to_json(NEW )
    );
    BEGIN
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
        END IF;
    END;

    RETURN NULL;
  END;
$function$
;

 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row((SELECT  "e"  FROM  (SELECT  OLD."is_draft"        ) AS "e"      ) );
      _new := row((SELECT  "e"  FROM  (SELECT  NEW."is_draft"        ) AS "e"      ) );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', row_to_json(OLD ),
      'new', row_to_json(NEW )
    );
    BEGIN
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
        END IF;
    END;

    RETURN NULL;
  END;
$function$
;

 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row((SELECT  "e"  FROM  (SELECT  OLD."embed_urls" , OLD."attachments" , OLD."resources_needed" , OLD."max_population" , OLD."image_urls" , OLD."is_deleted" , OLD."beneficiary_attributes" , OLD."reported_by" , OLD."extent" , OLD."min_population" , OLD."organization_id" , OLD."featured_url" , OLD."updated_at" , OLD."featured_type" , OLD."edited_at" , OLD."impact" , OLD."created_at" , OLD."title" , OLD."organization" , OLD."user_id" , OLD."video_urls" , OLD."description"        ) AS "e"      ) );
      _new := row((SELECT  "e"  FROM  (SELECT  NEW."embed_urls" , NEW."attachments" , NEW."resources_needed" , NEW."max_population" , NEW."image_urls" , NEW."is_deleted" , NEW."beneficiary_attributes" , NEW."reported_by" , NEW."extent" , NEW."min_population" , NEW."organization_id" , NEW."featured_url" , NEW."updated_at" , NEW."featured_type" , NEW."edited_at" , NEW."impact" , NEW."created_at" , NEW."title" , NEW."organization" , NEW."user_id" , NEW."video_urls" , NEW."description"        ) AS "e"      ) );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', row_to_json(OLD ),
      'new', row_to_json(NEW )
    );
    BEGIN
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
        END IF;
    END;

    RETURN NULL;
  END;
$function$
;

 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row(OLD );
      _new := row(NEW );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', NULL,
      'new', row_to_json(NEW )
    );
    BEGIN
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
        END IF;
    END;

    RETURN NULL;
  END;
$function$
;

 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row(OLD );
      _new := row(NEW );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', NULL,
      'new', row_to_json(NEW )
    );
    BEGIN
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
        END IF;
    END;

    RETURN NULL;
  END;
$function$
;

 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row((SELECT  "e"  FROM  (SELECT  OLD."is_draft"        ) AS "e"      ) );
      _new := row((SELECT  "e"  FROM  (SELECT  NEW."is_draft"        ) AS "e"      ) );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', row_to_json(OLD ),
      'new', row_to_json(NEW )
    );
    BEGIN
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
        END IF;
    END;

    RETURN NULL;
  END;
$function$
;

 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row((SELECT  "e"  FROM  (SELECT  OLD."embed_urls" , OLD."website_url" , OLD."attachments" , OLD."pilots" , OLD."image_urls" , OLD."min_budget" , OLD."is_deleted" , OLD."beneficiary_attributes" , OLD."extent" , OLD."max_budget" , OLD."resources" , OLD."featured_url" , OLD."updated_at" , OLD."featured_type" , OLD."edited_at" , OLD."budget_title" , OLD."impact" , OLD."created_at" , OLD."id" , OLD."title" , OLD."timeline" , OLD."user_id" , OLD."video_urls" , OLD."technology" , OLD."description" , OLD."deployment"        ) AS "e"      ) );
      _new := row((SELECT  "e"  FROM  (SELECT  NEW."embed_urls" , NEW."website_url" , NEW."attachments" , NEW."pilots" , NEW."image_urls" , NEW."min_budget" , NEW."is_deleted" , NEW."beneficiary_attributes" , NEW."extent" , NEW."max_budget" , NEW."resources" , NEW."featured_url" , NEW."updated_at" , NEW."featured_type" , NEW."edited_at" , NEW."budget_title" , NEW."impact" , NEW."created_at" , NEW."id" , NEW."title" , NEW."timeline" , NEW."user_id" , NEW."video_urls" , NEW."technology" , NEW."description" , NEW."deployment"        ) AS "e"      ) );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', row_to_json(OLD ),
      'new', row_to_json(NEW )
    );
    BEGIN
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
        END IF;
    END;

    RETURN NULL;
  END;
$function$
;

    domains.colour,
    domains.id,
    domains.is_primary
   FROM domains;


    locations.location,
    locations.location_name,
    locations.lat,
    locations.long,
    locations.created_at,
    locations.city,
    locations.state,
    locations.country,
    locations.type
   FROM locations;


    users.email,
    users.password,
    users.token,
    users.created_at,
    users.organization,
    users.name,
    users.qualification,
    users.photo_url,
    users.phone_number,
    users.is_ngo,
    users.is_innovator,
    users.is_entrepreneur,
    users.is_expert,
    users.is_incubator,
    users.is_funder,
    users.is_government,
    users.is_beneficiary,
    users.edited_at,
    users.notify_email,
    users.notify_sms,
    users.notify_app,
    users.otp,
    users.is_verified,
    users.organization_id,
    users.is_admin,
    users.is_approved,
    users.email_private,
    users.number_private,
    users.organization_private,
    users.persona_private,
    users.interests_private,
    users.location_private
   FROM users;




CREATE UNIQUE INDEX invited_users_email_key ON public.invited_users USING btree (email);

CREATE UNIQUE INDEX invited_users_pkey ON public.invited_users USING btree (id);

CREATE UNIQUE INDEX organizations_id_key ON public.organizations USING btree (id);

CREATE UNIQUE INDEX organizations_name_key ON public.organizations USING btree (name);

CREATE UNIQUE INDEX organizations_pkey ON public.organizations USING btree (name, id);


alter table "public"."invited_users" add constraint "invited_users_pkey" PRIMARY KEY using index "invited_users_pkey";

alter table "public"."organizations" add constraint "organizations_pkey" PRIMARY KEY using index "organizations_pkey";



alter table "public"."invited_users" add constraint "invited_users_email_key" UNIQUE using index "invited_users_email_key";

alter table "public"."invited_users" add constraint "invited_users_organization_fkey" FOREIGN KEY (organization) REFERENCES organizations(id) ON UPDATE RESTRICT ON DELETE RESTRICT;

alter table "public"."organizations" add constraint "organizations_id_key" UNIQUE using index "organizations_id_key";

alter table "public"."organizations" add constraint "organizations_name_key" UNIQUE using index "organizations_name_key";

alter table "public"."users" add constraint "users_organization_id_fkey" FOREIGN KEY (organization_id) REFERENCES organizations(id) ON UPDATE RESTRICT ON DELETE RESTRICT;









