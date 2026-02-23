<script lang="ts" setup>
import { z } from "zod";
import type { FormSubmitEvent } from "@nuxt/ui";

const toast = useToast();

const supabase = useSupabaseClient();

const formSchema = z.object({
  nom: z
    .string()
    .min(2, "Le nom du terrain doit contenir au moins 2 caractères"),
  latitude: z.number().min(-90).max(90),
  longitude: z.number().min(-180).max(180),
  surface: z.number().min(1),
  surface_constructible: z.number().min(0),
  prix: z.number().min(0),
  longueur_facade: z.number().min(0),
  orientation_facade: z.enum(["NORD", "SUD", "EST", "OUEST"]),
  photos: z.file().array(),
});

type FormSchema = z.infer<typeof formSchema>;

const form = reactive<Partial<FormSchema>>({
  // // dummy values for easier testing
  // nom: "Terrain de test",
  // latitude: 48.8566,
  // longitude: 2.3522,
  // surface: 1000,
  // surface_constructible: 800,
  // prix: 50000,
  // longueur_facade: 20,
  // orientation_facade: "SUD",
});

const loading = ref(false);

const onSubmit = async (event: FormSubmitEvent<FormSchema>) => {
  try {
    loading.value = true;

    const user = await supabase.auth.getUser().then(({ data, error }) => {
      if (error) throw error;
      return data.user;
    });

    const data = await supabase
      .from("terrains")
      .insert({
        nom: event.data.nom,
        latitude: event.data.latitude,
        longitude: event.data.longitude,
        surface: event.data.surface,
        surface_constructible: event.data.surface_constructible,
        prix: event.data.prix,
        longueur_facade: event.data.longueur_facade,
        orientation_facade: event.data.orientation_facade,
        user_id: user.id,
      })
      .select()
      .single()
      .then(({ data, error }) => {
        if (error) throw error;
        return data;
      });

    toast.add({
      title: "Terrain créé",
      description: `Le terrain "${data.nom}" a été créé avec succès.`,
    });

    await navigateTo("/");
  } catch (error) {
    toast.add({
      title: "Erreur",
      description:
        error instanceof Error
          ? error.message
          : "Une erreur est survenue lors de la création du terrain.",
      color: "error",
    });
  } finally {
    loading.value = false;
  }
};
</script>

<template>
  <UContainer class="py-4">
    <div class="mb-4">
      <UButton
        to="/"
        label="Retour à la liste"
        variant="ghost"
        color="neutral"
        icon="i-lucide-arrow-left"
      />
    </div>

    <UCard>
      <template #header>
        <h3 class="font-bold text-xl">Créer un nouveau terrain</h3>
      </template>

      <UForm
        :schema="formSchema"
        :state="form"
        class="space-y-4"
        @submit="onSubmit"
      >
        <UFormField name="nom" label="Nom du terrain" required>
          <UInput
            v-model="form.nom"
            placeholder="Nom du terrain"
            class="w-full"
          />
        </UFormField>

        <div class="grid grid-cols-2 gap-4">
          <UFormField name="latitude" label="Latitude" required>
            <UInput
              v-model="form.latitude"
              type="number"
              placeholder="Latitude"
              class="w-full"
            />
          </UFormField>
          <UFormField name="longitude" label="Longitude" required>
            <UInput
              v-model="form.longitude"
              type="number"
              placeholder="Longitude"
              class="w-full"
            />
          </UFormField>
        </div>

        <div class="grid grid-cols-2 gap-4">
          <UFormField name="surface" label="Surface (m²)" required>
            <UInput
              v-model="form.surface"
              type="number"
              placeholder="Surface"
              class="w-full"
            />
          </UFormField>
          <UFormField
            name="surface_constructible"
            label="Surface Constructible (m²)"
            required
          >
            <UInput
              v-model="form.surface_constructible"
              type="number"
              placeholder="Surface Constructible"
              class="w-full"
            />
          </UFormField>
        </div>

        <UFormField name="prix" label="Prix (€)" required>
          <UInput
            v-model="form.prix"
            type="number"
            placeholder="Prix"
            class="w-full"
          />
        </UFormField>

        <div class="grid grid-cols-2 gap-4">
          <UFormField
            name="longueur_facade"
            label="Longueur de la Façade (m)"
            required
          >
            <UInput
              v-model="form.longueur_facade"
              type="number"
              placeholder="Longueur de la Façade"
              class="w-full"
            />
          </UFormField>
          <UFormField
            name="orientation_facade"
            label="Orientation de la Façade"
            required
          >
            <USelect
              v-model="form.orientation_facade"
              class="w-full"
              :items="['NORD', 'SUD', 'EST', 'OUEST']"
            />
          </UFormField>
        </div>

        <div>
          <UFormField name="photos" label="Photos du terrain" required>
            <UFileUpload
              v-model="form.photos"
              accept="image/*"
              multiple
              class="w-96 min-h-48"
            />
          </UFormField>
        </div>

        <div>
          <UButton
            type="submit"
            color="primary"
            label="Créer le terrain"
            :loading="loading"
          />
        </div>
      </UForm>
    </UCard>
  </UContainer>
</template>
