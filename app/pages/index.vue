<script lang="ts" setup>
const supabase = useSupabaseClient();

async function logout() {
  await supabase.auth.signOut();
  await navigateTo("/auth/login");
}
</script>

<template>
  <div>
    <h1>Hello from index.vue</h1>
    <UButton label="Se déconnecter" @click="logout" />
  </div>
</template>
