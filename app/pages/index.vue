<script lang="ts" setup>
const supabase = useSupabaseClient();

async function logout() {
  await supabase.auth.signOut();
  await navigateTo("/auth/login");
}

const { data, pending } = useAsyncData("terrains", async () => {
  const { data } = await supabase.from("terrains").select("*");
  return data;
});
</script>

<template>
  <div>
    <UHeader title="Terrains" :toggle="false">
      <template #right>
        <UButton label="Se déconnecter" @click="logout" />
      </template>
    </UHeader>
    <UContainer class="p-4">
      <div />
      <div v-if="pending">Chargement des terrains...</div>
      <ListView v-else :terrains="data!" />
    </UContainer>
  </div>
</template>
