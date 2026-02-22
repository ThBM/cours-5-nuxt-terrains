<script setup lang="ts">
import * as z from "zod";
import type { FormSubmitEvent, AuthFormField } from "@nuxt/ui";

const toast = useToast();

const fields: AuthFormField[] = [
  {
    name: "email",
    type: "email",
    label: "Email",
    required: true,
  },
  {
    name: "password",
    label: "Mot de passe",
    type: "password",
    required: true,
  },
];

const schema = z.object({
  email: z.email("Email invalide"),
  password: z.string("Le mot de passe est requis"),
});

type Schema = z.output<typeof schema>;

const supabase = useSupabaseClient();

async function onSubmit(payload: FormSubmitEvent<Schema>) {
  await supabase.auth
    .signInWithPassword({
      email: payload.data.email,
      password: payload.data.password,
    })
    .then(({ data, error }) => {
      if (error) {
        toast.add({
          title: error.message,
          color: "error",
        });
        throw error;
      }
      return data;
    });

  await navigateTo("/");
}
</script>

<template>
  <div class="h-screen flex flex-col items-center justify-center gap-4 p-4">
    <UPageCard class="w-full max-w-md">
      <UAuthForm
        :schema="schema"
        title="Connexion"
        description="Renseignez vos informations pour vous connecter."
        icon="i-lucide-user"
        :fields="fields"
        :submit="{ label: 'Se connecter' }"
        @submit="onSubmit"
      >
        <template #description>
          Vous n'avez pas de compte ?
          <ULink to="/auth/register" class="text-primary font-medium"
            >Créer un compte</ULink
          >.
        </template>
      </UAuthForm>
    </UPageCard>
  </div>
</template>
