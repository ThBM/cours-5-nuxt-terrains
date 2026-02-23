grant delete on table "public"."terrains" to "postgres";

grant insert on table "public"."terrains" to "postgres";

grant references on table "public"."terrains" to "postgres";

grant select on table "public"."terrains" to "postgres";

grant trigger on table "public"."terrains" to "postgres";

grant truncate on table "public"."terrains" to "postgres";

grant update on table "public"."terrains" to "postgres";


  create policy "Authenticated user can see terrains"
  on "public"."terrains"
  as permissive
  for select
  to authenticated
using (true);



  create policy "Insert terrain affected to the user"
  on "public"."terrains"
  as permissive
  for insert
  to authenticated
with check ((user_id = auth.uid()));



  create policy "update terrain for a user"
  on "public"."terrains"
  as permissive
  for update
  to authenticated
using ((user_id = auth.uid()))
with check ((user_id = auth.uid()));



  create policy "user cans delete their terrain"
  on "public"."terrains"
  as permissive
  for delete
  to public
using ((user_id = auth.uid()));



