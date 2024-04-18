/*
 */
import { store } from '@/store/model.store';

import { createRouter, createWebHashHistory } from 'vue-router'
import { GET_SESSION_USER } from '@/store/user_session.store';

import Dashboard from '@/components/dashboard/dashboard.vue';

// Login
import LoginScreen from '@/components/login/login_screen.vue'
import ForgotPassword from '@/components/login/forgot_password.vue'
import Login from '@/components/login/login.vue';
import NewPassword from '@/components/login/new_password.vue';
import RegistrantsManage from '@/components/registrants/registrants_manage.vue';
import StaffManage from '@/components/registrants/staff_manage.vue';
import UsersManage from '@/components/users/users_manage.vue';

import PrinterManage from '@/components/printer/printer_manage.vue';

// import Tr from "@/i18n/translation"

const loginRoutes = [
  { path: 'forgot', component: ForgotPassword },
  { path: 'password-reset', component: NewPassword },
  { path: '', component: Login, name: "login" },
]

export const router = createRouter({
  // Provide the history implementation to use. We are using the hash history for simplicity here.
  history: createWebHashHistory(), //import.meta.env.BASE_URL), //(process.env.BASE_URL),
  routes: [
    {
      path: '/login',
      component: LoginScreen,
      children: loginRoutes,
      meta: { guest: true },
      props: true
    },
    {
      path: '/dashboard',
      component: Dashboard,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/registrants',
      component: RegistrantsManage,
      meta: {
        requiresAuth: true
      }
    },    
    {
      path: '/staff',
      component: StaffManage,
      meta: {
        requiresAuth: true
      }
    },    
    {
      path: '/users',
      component: UsersManage,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/printer',
      component: PrinterManage,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '',
      redirect: '/dashboard'
    }
  ]
})


router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    store.dispatch(GET_SESSION_USER).then((session) => {
      if (!session.id) {
        next({
          path: '/login',
          query: { redirect: to.fullPath }
        })
      } else {
        next()
      }
    }).catch((error) => {
      console.error(error)
      next();
    })
  } else {
    next() // make sure to always call next()!
  }
})
