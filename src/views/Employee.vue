<template>
  <div class="container mt-4">
    <h2 class="mb-3">รายชื่อพนักงาน</h2>
    
    <div class="mb-3 text-end">
    <a class="btn btn-primary" href="/add_employee" role="button">Add+</a>
</div>

    <!-- ตารางแสดงข้อมูลลูกค้า -->
    <table class="table table-bordered table-striped">
      <thead class="table-dark">
        <tr>
          <th>ลำดับที่</th>
          <th>รหัสพนักงาน</th>
          <th>ชื่อ-นามสกุล</th>
          <th>แผนก</th>
          <th>เงินเดือน</th>
          <th>สถานะ</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(customer,index) in customers" :key="customer.customer_id">
          <td>{{ index + 1 }}</td>   <!--แสดงลำดับที่-->
          <td>{{ customer.emp_id }}</td>
          <td>{{ customer.full_name }}</td>
          <td>{{ customer.department }}</td>
          <td>{{ customer.salary }}</td>
          <td>
<span v-if="customer.active == 1">ปกติ</span>
<span v-else>ลาออก</span>
          </td>
        </tr>
      </tbody>
    </table>

    <!-- Loading -->
    <div v-if="loading" class="text-center">
      <p>กำลังโหลดข้อมูล...</p>
    </div>

    <!-- Error -->
    <div v-if="error" class="alert alert-danger">
      {{ error }}
    </div>
  </div>
</template>


<script>
import { ref, onMounted } from "vue";

export default {
  name: "CustomerList",
  setup() {
    const customers = ref([]);
    const loading = ref(true);
    const error = ref(null);

    // ฟังก์ชันดึงข้อมูลจาก API
    const fetchCustomers = async () => {
      try {
        const response = await fetch("http://localhost/App-vue01/php_api/show_employee.php");
        if (!response.ok) {
          throw new Error("ไม่สามารถดึงข้อมูลได้");
        }
        customers.value = await response.json();
      } catch (err) {
        error.value = err.message;
      } finally {
        loading.value = false;
      }
    };

    onMounted(() => {
      fetchCustomers();
    });

    return {
      customers,
      loading,
      error
    };
  }
};
</script>
