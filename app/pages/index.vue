<script lang="ts" setup>
const supabase = useSupabaseClient();

async function logout() {
  await supabase.auth.signOut();
  await navigateTo("/auth/login");
}

const { data, pending, refresh } = useAsyncData("terrains", async () => {
  const { data } = await supabase.from("terrains").select("*");
  return data;
});

async function handleDelete(id: string) {
  await supabase.from("terrains").delete().eq("id", id);
  await refresh();
}
</script>

<template>
  <div>
    <UHeader title="Terrains" :toggle="false">
      <template #right>
        <UButton icon="i-lucide-log-out" variant="ghost" @click="logout" />
      </template>
    </UHeader>

    <UContainer class="p-4">
      <div class="mb-4 flex justify-end">
        <UButton
          to="/terrains/create"
          label="Ajouter un terrain"
          icon="i-lucide-plus"
        />
      </div>
      <div v-if="pending">Chargement des terrains...</div>
      <ListView
        v-else
        :terrains="data!"
        @edit="navigateTo(`/terrains/${$event}`)"
        @delete="handleDelete($event)"
      />
    </UContainer>
  </div>
</template>
