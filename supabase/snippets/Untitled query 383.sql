create table public.terrains (
  id uuid not null default gen_random_uuid (),
  nom text not null,
  latitude numeric not null,
  longitude numeric not null,
  surface numeric not null,
  surface_constructible numeric not null,
  prix numeric not null,
  longueur_facade numeric not null,
  orientation_facade text not null,
  user_id uuid null,
  constraint terrains_pkey primary key (id),
  constraint terrains_user_id_fkey foreign KEY (user_id) references auth.users (id) on update CASCADE on delete CASCADE
) TABLESPACE pg_default;