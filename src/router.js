import Vue from 'vue';
import VueRouter from 'vue-router';

// Importez vos composants associés à chaque route
import Home from './views/Home.vue';
import Instructions from './views/Instructions.vue';
import Game from './views/Game.vue';
import Results from './views/Results.vue';

import VueModal from 'vue-js-modal';

Vue.use(VueModal)
Vue.use(VueRouter);

const routes = [
  { path: '/', component: Home },
  { path: '/instructions', component: Instructions },
  { path: '/game', component: Game },
  { path: '/results', component: Results, props: (route) => ({ emails: route.query.emails }) },
  { path: '*', redirect: '/' }
];

const router = new VueRouter({
  routes,
  mode: 'history'
});

export default router;
