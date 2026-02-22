
<template>
<div >
 
<nav class="navbar navbar-expand-lg " style="background-color: #e3f2fd;" data-bs-theme="light" >
  <div class="container">
    <a class="navbar-brand" href="/">Jenny.j</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/">Home</a>
        </li>

         <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/show_product">Product</a>
        </li>
        
        <li class="nav-item" v-if="isLoggedIn">
          <a class="nav-link" href="/customer">Customer</a>
        </li>
         <li class="nav-item" v-if="isLoggedIn">
          <a class="nav-link" href="/customer_crud">Customer Crud</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/contact">Contact</a>
        </li>
         <li class="nav-item" v-if="isLoggedIn">
          <a class="nav-link" href="/type">Type</a>
        </li>

     <li class="nav-item dropdown" v-if="isLoggedIn">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Employee
          </a>
          <ul class="dropdown-menu" >
            <li><a class="dropdown-item" href="/employee">Employee</a></li>
            <li v-if="isLoggedIn"><a class="dropdown-item" href="/employee_crud">Employee_crud</a></li>
            <li v-if="isLoggedIn"><a class="dropdown-item" href="/employee_crud_image">Employee_crud_image</a></li>
          </ul>
        </li>
       <li class="nav-item dropdown" v-if="isLoggedIn" >
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Product
          </a>
          <ul class="dropdown-menu" >
            <li v-if="isLoggedIn"><a class="dropdown-item" href="/product_api">Product_api</a></li>
            <li v-if="isLoggedIn"><a class="dropdown-item" href="product_crud">Product_crud</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="/show_product">Show Product</a></li>
          </ul>
        </li>
        
      </ul>
         <!-- ✅ ส่วนแสดงสถานะ Login -->
        <div class="d-flex align-items-center">

          <!-- แสดงชื่อผู้ใช้ -->
          <span v-if="isLoggedIn" class="me-3">
            👤 <span class="badge bg-success">{{ userName }}</span>
          </span>

          <!-- ปุ่ม Login (ถ้ายังไม่ Login) -->
          <router-link
            v-if="!isLoggedIn"
            to="/login"
            class="btn btn-primary"
          >
            Login
          </router-link>

          <!-- ปุ่ม Logout (ถ้า Login แล้ว) -->
          <button
            v-if="isLoggedIn"
            @click="logout"
            class="btn btn-danger"
          >
            Logout
          </button>

        </div>
    </div>
  </div>
</nav>

    <!-- ✅ แสดงหน้าที่เลือก -->
  <div class="container mt-3">
    <router-view/>
  </div>

</div>
</template>




<script>
export default {
  data() {
    return {
      // ✅ ตัวแปรเก็บสถานะ Login
      isLoggedIn: false,

      // ✅ ตัวแปรเก็บชื่อผู้ใช้
      userName: ""
    }
  },

  // ✅ ทำงานทันทีเมื่อโหลด Component
  mounted() {
    this.checkLogin()
  },

  methods: {

    // ✅ ตรวจสอบสถานะ Login จาก localStorage
    checkLogin() {

      // ถ้ามี adminLogin → ถือว่า Login แล้ว
      this.isLoggedIn = !!localStorage.getItem("adminLogin")

      if (this.isLoggedIn) {

        // ดึงข้อมูล user
        const user = JSON.parse(localStorage.getItem("user"))

        // แสดงชื่อ ถ้าไม่มีใช้ "Admin"
        this.userName = user?.name || "Admin"
      }
    },

    // ✅ Logout
    logout() {

      // ลบข้อมูล Login
      localStorage.removeItem("adminLogin")
      localStorage.removeItem("user")

      // รีเซ็ตค่า
      this.isLoggedIn = false
      this.userName = ""

      // ไปหน้า Login
      this.$router.push("/login")
    }
  },

  // ✅ ถ้าเปลี่ยนหน้า → เช็ค Login ใหม่
  watch: {
    '$route'() {
      this.checkLogin()
    }
  }
}
</script>