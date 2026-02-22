<template>

  <div class="container">

    <!-- ✅ Hero / Banner -->
    <div class="bg-light p-5 mb-4 shadow-sm rounded">
      <div class="container text-center">
        <h1 class="fw-bold">ยินดีต้อนรับสู่ ร้าน Jenny.j แม่ค้าคนสวย และน่ารักที่สู๊ดดด</h1>
        <p class="text-muted">สินค้าคุณภาพระดับพรีเมี่ยม ราคาพิเศษช่วงโปรโมชั่น</p>
        <a class="btn btn-primary" href="/show_product" role="button">เลือกซื้อสินค้าได้เลยนะงับ  ลูกค้าที่น่ารักทุกคน</a>
      </div>
    </div>
    <h1>Contact to Parita Thararak (jenny)</h1>
    <h3>Tel.092-467-0266</h3>
    <img alt="Vue logo" src="../assets/sea.jpg" />
    <br /><br /><br />

    <div class="container">
      
      <div class="row">
        <!--column 1 -->
        <div class="col-sm-6">
          <img alt="Vue logo" width="90%" src="../assets/sea.jpg" />
        </div>
       <!--column 2 -->
        <div class="col-sm-6 bg-body-tertiary">
          <div class="mb-3 mt-4">
            <label for="exampleFormControlInput1" class="form-label"
              >Email address</label
            >
            <input
              type="email"
              class="form-control"
              id="exampleFormControlInput1"
              placeholder="name@example.com"
            />
          </div>
          <div class="mb-3">
            <label for="exampleFormControlTextarea1" class="form-label"
              >Detail</label
            >
            <textarea
              class="form-control"
              id="exampleFormControlTextarea1"
              rows="3"
            ></textarea>
          </div>
          <div class="mb-3 text-center">
            <button type="button" class="btn btn-primary">Submit</button>&nbsp;
            <button type="button" class="btn btn-danger">Cancel</button>
          </div>
        </div>
      </div>
    </div>



    <br /><br />
  </div>
</template>
