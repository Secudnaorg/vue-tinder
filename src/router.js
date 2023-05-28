import Vue from 'vue';
import VueRouter from 'vue-router';

// Importez vos composants associés à chaque route
import Accueil from './components/Accueil.vue';
import Game from './components/Game.vue';
import Result from './components/Result/Result.vue';

import VueModal from 'vue-js-modal';

Vue.use(VueModal)
Vue.use(VueRouter);

const routes = [
  { path: '/', component: Accueil },
  { path: '/game', component: Game },
  { path: '/result', component: Result },
  { path: '*', redirect: '/' }
];

const router = new VueRouter({
  routes,
  mode: 'history' // Utilisez le mode 'history' pour avoir des URLs propres sans le hash (#)
});

export default router;
