import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  

  {
    path: '/customer',
    name: 'customer',
    component: () => import('../views/Customer.vue'),
    meta: { requiresAuth: true }   // ✅ บังคับ login
  },

  {
    path: '/contact',
    name: 'contact',
    component: () => import('../views/Contact.vue')
  },

  {
    path: '/type',
    name: 'type',
    component: () => import('../views/Type.vue'),
    meta: { requiresAuth: true }   // ✅ บังคับ login
  },

  {
    path: '/employee',
    name: 'employee',
    component: () => import('../views/Employee.vue'),
    meta: { requiresAuth: true }   // ✅ บังคับ login
  },

  {
    path: '/add_customer',
    name: 'add_customer',
    component: () => import('../views/Add_customer.vue'),
    meta: { requiresAuth: true }   // ✅ บังคับ login
   
  },

  {
    path: '/add_employee',
    name: 'add_employee',
    component: () => import('../views/Add_employee.vue'),
    meta: { requiresAuth: true }   // ✅ บังคับ login
  },

  {
    path: '/product',
    name: 'product',
    component: () => import('../views/Product.vue'),
    meta: { requiresAuth: true }   // ✅ บังคับ login
  },

  {
    path: '/product_api',
    name: 'product_api',
    component: () => import('../views/Product_api.vue'),
    meta: { requiresAuth: true }   // ✅ บังคับ login
  },

  {
    path: '/show_product',
    name: 'show_product',
    component: () => import('../views/Show_product.vue')
  },

  {
    path: '/customer_crud',
    name: 'customer_crud',
    component: () => import('../views/Customer_crud.vue'),
    meta: { requiresAuth: true }   // ✅ บังคับ login
  },

  {
    path: '/employee_crud',
    name: 'employee_crud',
    component: () => import('../views/Employee_crud.vue'),
    meta: { requiresAuth: true }   // ✅ บังคับ login
  },

  {
    path: '/employee_crud_image',
    name: 'employee_crud_image',
    component: () => import('../views/Employee_crud_image.vue'),
    meta: { requiresAuth: true }   // ✅ บังคับ login
  },

  {
    path: '/product_crud',
    name: 'product_crud',
    component: () => import('../views/Product_crud.vue'),
    meta: { requiresAuth: true }   // ✅ บังคับ login
  },

  {
    path: '/login',
    name: 'login',
    component: () => import('../views/Login.vue')
  },
  
  {
    path: '/productDetail',
    name: 'productDetail',
    component: () => import('../views/ProductDetail.vue'),
    meta: { requiresAuth: true }   // ✅ บังคับ login
  }
 
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

/* ✅ ROUTE GUARD */
router.beforeEach((to, from, next) => {

  const isLoggedIn = localStorage.getItem("adminLogin")

  // ถ้าหน้านั้นต้อง login แต่ยังไม่ login
  if (to.meta.requiresAuth && !isLoggedIn) {
    next('/login')
  } 
  // ถ้า login แล้วแต่พยายามเข้าหน้า login
  else if (to.path === '/login' && isLoggedIn) {
    next('/')   // หรือ dashboard
  }
  else {
    next()
  }
})

export default router