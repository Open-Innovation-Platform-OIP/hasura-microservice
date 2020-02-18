create sequence "public"."invited_users_id_seq";

alter table "public"."users" drop constraint "users_organization_id_fkey";

alter table "public"."organizations" drop constraint "organizations_pkey";

drop index if exists "public"."organizations_pkey";

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
