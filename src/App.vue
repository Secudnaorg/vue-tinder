<template>
  <div id="app">
    <v-app>
      <v-main>
        <transition name="fade" mode="out-in">
          <router-view></router-view>
        </transition>
      </v-main>
    </v-app>
  </div>
</template>

<script>

export default {
  name: 'App'
}

</script>

<style>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s;
}

.fade-enter,
.fade-leave-to {
  opacity: 0;
}
</style>
