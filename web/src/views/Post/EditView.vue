<template>
  <div class="container">
    <div class="post-whole">
      <h2>Post Edit</h2>
      <form @submit.prevent="updatePost">
        <div class="post-title">
          <input
            type="text"
            name="title"
            placeholder="Post Title"
            v-model="postForm.title"
          />
          <p class="error-message">
            {{ errors?.title ? errors.title[0] : "" }}
          </p>
        </div>
        <div class="category">
          <div class="multiSelect">
            <v-select
              v-model="selectedCategories"
              :options="categories"
              label="title"
              placeholder="select category"
              multiple
            ></v-select>
          </div>

          <svg xmlns="http://www.w3.org/2000/svg" style="display: none">
            <symbol
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              id="iconX"
            >
              <g stroke-linecap="round" stroke-linejoin="round">
                <line x1="18" y1="6" x2="6" y2="18"></line>
                <line x1="6" y1="6" x2="18" y2="18"></line>
              </g>
            </symbol>
          </svg>

          <p class="error-message">
            {{ errors?.category ? errors.category[0] : "" }}
          </p>
        </div>
        <div class="file">
          <input
            type="file"
            name="image"
            value=""
            @change="handleImageChange"
          />

          <p class="error-message">
            {{ errors?.image ? errors.image[0] : "" }}
          </p>
          <img
            :src="previewImage"
            v-if="previewImage"
            id="output"
            onerror="this.onerror=null;this.src='./img/image1.jpg';"
          />
          <img :src="url + post?.image" v-else id="output" />
        </div>
        <div class="description">
          <textarea
            id="description-area"
            name="description"
            rows="5"
            v-model="postForm.description"
            placeholder="write  Description about post"
          ></textarea>

          <p class="error-message">
            {{ errors?.description ? errors.description[0] : "" }}
          </p>
        </div>
        <button type="submit" class="publish">Publish</button>
      </form>
    </div>
  </div>
</template>

<script setup>
import axios from "axios";
import { ref, onMounted, reactive } from "vue";
import { useRouter, useRoute } from "vue-router";
import Swal from "sweetalert2";

const router = useRouter();
const route = useRoute();
const imageFile = ref(null);
const previewImage = ref(null);
const currentUser = ref(JSON.parse(localStorage.getItem("user")));
const categories = ref([]);
const errors = ref(null);
const post = ref(null);
const selectedCategories = ref(null);
const url = ref(import.meta.env.VITE_BASE_URL);
const postForm = reactive({
  title: "",
  category_id: [],
  image: "",
  description: "",
  user_id: currentUser.value.id,
});

onMounted(() => {
  axios
    .get(`${import.meta.env.VITE_PUBLIC_API_URL}/posts/${route.params.id}`)
    .then((response) => {
      categories.value = response.data.categories;
      post.value = response.data.post;
      postForm.title = response.data.post.title;
      selectedCategories.value = response.data.post.categories;
      postForm.description = response.data.post.description;
      previewImage.value = url.value + post.value.image.url;
    });
});

// for image
const handleImageChange = (event) => {
  const file = event.target.files[0];
  if (file) {
    imageFile.value = file;
    postForm.image = file;
    const reader = new FileReader();
    reader.onload = (e) => {
      previewImage.value = e.target.result;
    };
    reader.readAsDataURL(file);
  }
};

//update Post
const updatePost = async () => {
  postForm.category_id = JSON.stringify(
    selectedCategories.value.map((category) => category.id)
  );
  const config = {
    headers: {
      "content-type": "multipart/form-data",
    },
  };
  await axios
    .put(
      `${import.meta.env.VITE_PUBLIC_API_URL}/posts/${route.params.id}`,
      postForm,
      config
    )
    .then((response) => {
      const Toast = Swal.mixin({
        toast: true,
        position: "top",
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        didOpen: (toast) => {
          toast.addEventListener("mouseenter", Swal.stopTimer);
          toast.addEventListener("mouseleave", Swal.resumeTimer);
        },
      });

      Toast.fire({
        icon: "success",
        title: "Post is updated successfully",
      });

      router.push({ name: "home" });
    })
    .catch(function (error) {
      errors.value = error.response.data.errors;
    });
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Roboto+Condensed&family=Sofia+Sans+Condensed&display=swap");

.category {
  width: 100% !important;
}

.container {
  width: 1000px;
  margin: 0 auto;
}

#output {
  width: 130px;
  height: 130px;
  margin: 10px 0;
  border-radius: 10px;
}

.error-message {
  color: red;
  font-size: 15px;
}

.select2-container {
  width: 100%;
}

.post-whole {
  margin: 140px;
  margin-top: 100px;
  padding: 37px;
  border: 2px solid rgb(178 178 178);
  border-radius: 10px;
}

.multiSelect {
  position: relative;
  width: 100%;
  margin: 10px 0;
}

.wrapper {
  max-width: 75%;
  margin: auto;
}

h3 {
  color: #000000;
  margin: 40px 0;
  padding: 0;
  font-size: 28px;
  text-align: center;
}

select {
  width: 100%;
  min-height: 100px;
  border-radius: 3px;
  border: 1px solid #444;
  padding: 10px;
  color: #444444;
  font-size: 14px;
}

.post-whole h2 {
  margin-bottom: 10px;
  font-size: 28px;
}

form input {
  width: 100%;
  margin-bottom: 10px;
  padding: 6px;
  border: 1px solid rgb(82, 82, 82);
  outline: none;
  border-radius: 5px;
}

select {
  width: 100%;
  margin-bottom: 10px;
  padding: 10px;
  border-radius: 5px;
}

option {
  font-size: 13px;
  border-radius: px;
}

.description {
  margin-bottom: 10px;
}

#description-area {
  width: 100%;
}

.publish {
  padding: 8px 15px;
  border: none;
  background-color: rgb(178 178 178);
  color: #fff;
  font-size: 15px;
  border-radius: 5px;
}

@media screen and (max-width: 768px) {
  .container {
    width: auto;
    padding: 0 5.208vw;
  }

  .post-whole {
    margin: 3.906vw;
    margin-top: 5.859vw;
    padding: 4.427vw;
    border: 0.26vw solid rgb(178 178 178);
    border-radius: 1.042vw;
  }

  .post-whole h2 {
    margin-bottom: 2.474vw;
    font-size: 3.385vw;
  }

  form input {
    width: 100%;
    margin-bottom: 1.042vw;
    padding: 0.651vw;
    outline: none;
    border-radius: 0.651vw;
  }

  select {
    width: 100%;
    margin-bottom: 1.042vw;
    padding: 0.651vw;
    border-radius: 0.651vw;
  }

  option {
    font-size: 1.042vw;
    border-radius: 0.651vw px;
  }

  .description {
    margin-bottom: 1.042vw;
  }

  .publish {
    padding: 0.781vw 1.693vw;
    border: none;
    background-color: rgb(178 178 178);
    color: #fff;
    font-size: 1.693vw;
    border-radius: 0.521vw;
  }
}

@media screen and (max-width: 640px) {
  .container {
    width: auto;
    padding: 0 40px;
  }

  #output {
    width: 130.003px;
    height: 130.003px;
    margin: 10.003px 0;
    border-radius: 10.003px;
  }

  .post-whole {
    margin: 27.002px;
    margin-top: 50.003px;
    margin-top: 120px;
    padding: 20px;
    border: 2.003px solid rgb(178 178 178);
    border-radius: 6.003px;
  }

  .post-whole h2 {
    margin-bottom: 15.002px;
    font-size: 24px;
  }

  form input {
    width: 100%;
    margin-bottom: 6.003px;
    padding: 4.998px;
    outline: none;
    border-radius: 4px;
  }

  select {
    width: 100%;
    margin-bottom: 6.003px;
    padding: 4.998px;
    border-radius: 4px;
  }

  option {
    font-size: 6.003px;
    border-radius: 4px px;
  }

  .description {
    margin-bottom: 6.003px;
  }

  .error-message {
    font-size: 2.344vw;
  }

  .publish {
    padding: 4.998px 12px;
    border: none;
    background-color: rgb(178 178 178);
    color: #fff;
    font-size: 11.002px;
    border-radius: 3.002px;
  }
}
</style>
