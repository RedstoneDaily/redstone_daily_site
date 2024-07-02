import { createRouter, createWebHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";
import RSSearchView from "../views/RSSearchView.vue";
import NotFoundView from "../views/NotFoundView.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: "/", name: "home", component: HomeView },
    { path: "/index.html", redirect: "/" },
    // {
    //   path: '/about',
    //   name: 'about',
    //   // route level code-splitting
    //   // this generates a separate chunk (About.[hash].js) for this route
    //   // which is lazy-loaded when the route is visited.
    //   component: () => import('../views/AboutView.vue')
    // },
    // {
    //   path: '/home',
    //   name: 'home1',
    //   component: () => import('../views/HomePage.vue')
    // },
    { path: "/rs_search", name: "rs_search", component: RSSearchView },
	{ path: '/:pathMatch(.*)*', name: 'not_found', component: NotFoundView }
  ],
});

export default router;
