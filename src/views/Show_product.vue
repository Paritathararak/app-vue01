<template>


 <div class="container my-5">



    
    <h2 class="text-center mb-4">รายการสินค้า</h2>

    <!-- Loading -->
    <div v-if="loading" class="text-center my-5">
      <div class="spinner-border text-primary"></div>
      <p class="mt-2">กำลังโหลดข้อมูล...</p>
    </div>

    <!-- Error -->
    <div v-else-if="error" class="alert alert-danger text-center">
      {{ error }}
    </div>

    <!-- Product List -->
    <div v-else class="row">
      <div 
        class="col-md-3 mb-4" 
        v-for="data in Alldata" 
        :key="data.product_id"
      >

        <div class="card h-100 shadow-sm">

          <!-- รูปสินค้า -->
          <img
            :src="getImage(data.image)"
            class="card-img-top"
            style="height:250px; object-fit:cover;"
            :alt="data.product_name"
          >

          <!-- เนื้อหา -->
          <div class="card-body text-center">
            <h6 class="card-title">
              {{ data.product_name }}
            </h6>

            <p class="text-primary fw-bold fs-5">
              {{ formatPrice(data.price) }} บาท
            </p>
          </div>

          <!-- ปุ่ม -->
          <div class="card-footer bg-white border-0">

            <router-link 
              :to="'/ProductDetail?id=' + data.product_id"
              class="btn btn-sm btn-outline-primary w-100 mb-2"
            >
              ดูรายละเอียด
            </router-link>

            <button 
              class="btn btn-sm btn-primary w-100"
              @click="addToCart(data)"
            >
              เพิ่มลงตะกร้า
            </button>

          </div>

        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";

export default {
  name: "DataList",
  setup() {

    const Alldata = ref([]);
    const loading = ref(true);
    const error = ref(null);

    // จัดรูปแบบราคา
    const formatPrice = (price) => {
      return new Intl.NumberFormat("th-TH").format(price);
    };

    // สร้าง URL รูปภาพ
    const getImage = (image) => {
      if (!image) {
        return "https://via.placeholder.com/300x200?text=No+Image";
      }
      return `http://localhost/app-vue01/php_api/uploads/${image}`;
    };

    // เพิ่มลงตะกร้า
    const addToCart = (product) => {
      let cart = JSON.parse(localStorage.getItem("cart")) || [];
      cart.push(product);
      localStorage.setItem("cart", JSON.stringify(cart));
      alert(`เพิ่ม ${product.product_name} ลงตะกร้าแล้ว 🛒`);
    };

    // ดึงข้อมูลจาก API
    const fetchData = async () => {
      try {
        const response = await fetch(
          "http://localhost/app-vue01/php_api/show_product.php"
        );

        if (!response.ok) {
          throw new Error("ไม่สามารถดึงข้อมูลได้");
        }

        Alldata.value = await response.json();

      } catch (err) {
        error.value = err.message;
      } finally {
        loading.value = false;
      }
    };

    onMounted(() => {
      fetchData();
    });

    return {
      Alldata,
      loading,
      error,
      formatPrice,
      getImage,
      addToCart
    };
  }
};
</script>

<style>
.card {
  transition: 0.3s;
}

.card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0,0,0,0.15);
}
</style>