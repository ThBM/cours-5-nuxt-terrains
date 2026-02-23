
  create table "public"."terrains" (
    "id" uuid not null default gen_random_uuid(),
    "nom" text not null,
    "latitude" numeric not null,
    "longitude" numeric not null,
    "surface" numeric not null,
    "surface_constructible" numeric not null,
    "prix" numeric not null,
    "longueur_facade" numeric not null,
    "orientation_facade" text not null,
    "user_id" uuid
      );


alter table "public"."terrains" enable row level security;

CREATE UNIQUE INDEX terrains_pkey ON public.terrains USING btree (id);

alter table "public"."terrains" add constraint "terrains_pkey" PRIMARY KEY using index "terrains_pkey";

alter table "public"."terrains" add constraint "terrains_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."terrains" validate constraint "terrains_user_id_fkey";

grant delete on table "public"."terrains" to "anon";

grant insert on table "public"."terrains" to "anon";

grant references on table "public"."terrains" to "anon";

grant select on table "public"."terrains" to "anon";

grant trigger on table "public"."terrains" to "anon";

grant truncate on table "public"."terrains" to "anon";

grant update on table "public"."terrains" to "anon";

grant delete on table "public"."terrains" to "authenticated";

grant insert on table "public"."terrains" to "authenticated";

grant references on table "public"."terrains" to "authenticated";

grant select on table "public"."terrains" to "authenticated";

grant trigger on table "public"."terrains" to "authenticated";

grant truncate on table "public"."terrains" to "authenticated";

grant update on table "public"."terrains" to "authenticated";

grant delete on table "public"."terrains" to "postgres";

grant insert on table "public"."terrains" to "postgres";

grant references on table "public"."terrains" to "postgres";

grant select on table "public"."terrains" to "postgres";

grant trigger on table "public"."terrains" to "postgres";

grant truncate on table "public"."terrains" to "postgres";

grant update on table "public"."terrains" to "postgres";

grant delete on table "public"."terrains" to "service_role";

grant insert on table "public"."terrains" to "service_role";

grant references on table "public"."terrains" to "service_role";

grant select on table "public"."terrains" to "service_role";

grant trigger on table "public"."terrains" to "service_role";

grant truncate on table "public"."terrains" to "service_role";

grant update on table "public"."terrains" to "service_role";


