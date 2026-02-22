<template>
  <div class="container mt-4 col-md-4 bg-body-secondary">
    <h2 class="text-center mb-3">เพิ่มข้อมูลพนักงาน</h2>

    <form @submit.prevent="addData">

      <div class="mb-2">
        <input v-model="employee.full_name"
               class="form-control"
               placeholder="ชื่อ-นามสกุล"
               required />
      </div>

      <div class="mb-2">
        <input v-model="employee.department"
               class="form-control"
               placeholder="แผนก"
               required />
      </div>

      <div class="mb-2">
        <input type="number"
               v-model="employee.salary"
               class="form-control"
               placeholder="เงินเดือน"
               required />
      </div>

      <!-- 🔥 เลือกรูป -->
      <div class="mb-2">
        <input type="file"
               @change="handleImage"
               class="form-control"
               accept="image/*" />
      </div>

      <!-- 🔥 Preview -->
      <div v-if="previewImage" class="text-center mt-3">
        <p>Preview:</p>
        <img :src="previewImage"
             width="150"
             class="rounded border" />
      </div>

      <div class="text-center mt-4">
        <button type="submit" class="btn btn-primary mb-4">
          บันทึก
        </button>
        &nbsp;
        <button type="reset"
                class="btn btn-secondary mb-4"
                @click="resetForm">
          ยกเลิก
        </button>
      </div>

    </form>

    <div v-if="message" class="alert alert-info mt-3">
      {{ message }}
    </div>

  </div>
</template>

<script>
export default {
  data() {
    return {
      employee: {
        full_name: "",
        department: "",
        salary: "",
        active: "1"
      },
      selectedFile: null,
      previewImage: null,
      message: ""
    };
  },

  methods: {

    // 🔥 เมื่อเลือกรูป
    handleImage(event) {
      const file = event.target.files[0];
      if (!file) return;

      this.selectedFile = file;
      this.previewImage = URL.createObjectURL(file);
    },

    async addData() {
      try {

        const formData = new FormData();
        formData.append("action", "add");
        formData.append("full_name", this.employee.full_name);
        formData.append("department", this.employee.department);
        formData.append("salary", this.employee.salary);
        formData.append("active", this.employee.active);

        if (this.selectedFile) {
          formData.append("image", this.selectedFile);
        }

        const res = await fetch(
          "http://localhost/app-vue01/php_api/api_employee.php",
          {
            method: "POST",
            body: formData
          }
        );

        const data = await res.json();
        this.message = data.message;

        if (data.message) {
          this.resetForm();
        }

      } catch (err) {
        this.message = "เกิดข้อผิดพลาด: " + err.message;
      }
    },

    resetForm() {
      this.employee = {
        full_name: "",
        department: "",
        salary: "",
        active: "1"
      };
      this.selectedFile = null;
      this.previewImage = null;
    }

  }
}
</script>