<template>
  <div>
    <section class="vender" v-if="notAuth">
      <div class="container">
        <h2>Stay Curious</h2>
        <p>
          Discover sotories,thing,and expertise <br />
          from writers on any topic
        </p>
        <a href="#">Start reading</a>
      </div>
    </section>

    <div class="container">
      <div class="postlist-content">
        <div class="clearfix">
          <div class="post-list">
            <h2 class="search-result">{{ search }}</h2>
            <!--post-user-->
            <div v-for="(post, index) in posts" :key="index">
              <div class="post">
                <!-- <div class="people">
                  <router-link
                    :to="{ name: 'profile', params: { id: post?.user?.id } }"
                  >
                    <div class="clearfix">
                      <div class="profile-img">
                        <img
                          :src="url + post.user?.profile"
                          class="create-user-img"
                        />
                      </div>
                      <p class="name">{{ post.user.name }}</p>
                    </div>
                  </router-link>
                </div> -->

                <div class="clearfix">
                  <div class="post-text">
                    <div>
                      <router-link
                        :to="{ name: 'detail', params: { id: post.id } }"
                      >
                        <h2 class="post-title">{{ post?.title }}</h2>
                        <p class="post-description">
                          {{ short(post?.description) }}
                        </p>
                      </router-link>
                      <div class="post-footer">
                        <div class="postfo-left">
                          <a
                            v-for="(category, index) in post.categories"
                            :key="index"
                            @click="searchCategory(category.ctitle)"
                          >
                            <span>{{ category.title }}</span>
                          </a>
                        </div>
                        <router-link
                          :to="{ name: 'detail', params: { id: post.id } }"
                        >
                          <p class="post-date">
                            <!-- {{ formatDate(post.created_at) }}  -->
                            <span>{{ minuteAgo(post?.created_at) }}</span>
                          </p>
                        </router-link>
                      </div>
                    </div>
                  </div>
                  <router-link
                    :to="{ name: 'detail', params: { id: post.id } }"
                  >
                    <div class="post-img">
                      <img
                        :src="url + post.image.url"
                        alt=""
                        width="100%"
                        height="100%"
                        onerror="this.onerror=null;this.src='../assets/template/people.jfif';"
                      />
                    </div>
                  </router-link>
                  <!--post-left-->
                </div>

                <div class="postfo-right">
                  <svg
                    width="24"
                    height="24"
                    viewBox="0 0 24 24"
                    fill="none"
                    class="tr"
                  >
                    <path
                      d="M17.5 1.25a.5.5 0 0 1 1 0v2.5H21a.5.5 0 0 1 0 1h-2.5v2.5a.5.5 0 0 1-1 0v-2.5H15a.5.5 0 0 1 0-1h2.5v-2.5zm-11 4.5a1 1 0 0 1 1-1H11a.5.5 0 0 0 0-1H7.5a2 2 0 0 0-2 2v14a.5.5 0 0 0 .8.4l5.7-4.4 5.7 4.4a.5.5 0 0 0 .8-.4v-8.5a.5.5 0 0 0-1 0v7.48l-5.2-4a.5.5 0 0 0-.6 0l-5.2 4V5.75z"
                      fill="#000"
                    ></path>
                  </svg>

                  <!-- <p
                    class="see-tools"
                    onclick="editDelete({{ $post->id }})"
                    v-if="notAuth == false && user.id == post.user.id"
                    @click="post.edit = !post.edit"
                  >
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                      <path
                        d="M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18zM8.25 12h7.5"
                        stroke="currentColor"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      ></path>
                    </svg>
                  </p> -->

                  <div class="tools" v-if="post?.edit == 1">
                    <button class="del-btn" @click="postDelete(post.id)">
                      Delete
                    </button>
                    <div class="">
                      <router-link
                        :to="{ name: 'edit', params: { id: post?.id } }"
                        >Edit
                      </router-link>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <!--paginate-->
            <vue-awesome-paginate
              :total-items="paginatePage.total_pages + 1"
              :items-per-page="paginatePage.total_pages"
              :max-pages-shown="paginatePage.total_pages"
              v-model="currentPage"
              :on-click="onClickHandler"
            />
          </div>

          <div class="category">
            <div class="category-list">
              <h2 class="cate-name">2022 IN Latest Post</h2>
              <div v-for="(lpost, index) in latestPosts" :key="index">
                <div class="latest-post-whole">
                  <div class="latest-post">
                    <router-link
                      :to="{ name: 'profile', params: { id: lpost?.user?.id } }"
                    >
                      <div class="list-latest-profile">
                        <a href="#">
                          <img
                            :src="url + lpost.user.profile"
                            alt=""
                            width="100%"
                            height="100%"
                            onerror="this.onerror=null;this.src='{{ asset('template/people.jfif') }}';"
                          />
                          <p class="name">{{ lpost.user.name }}</p>
                        </a>
                      </div>
                    </router-link>
                  </div>
                  <router-link
                    :to="{ name: 'detail', params: { id: lpost?.id } }"
                  >
                    <a href="{{ route('post.show', $lpost->id) }}">
                      <div class="latest-description">
                        {{ latestShort(lpost.description) }}
                      </div>
                    </a>
                  </router-link>
                </div>
              </div>
            </div>
            <div class="category-item">
              <a
                v-for="(category, index) in categories"
                :key="index"
                @click="searchCategory(category.ctitle)"
                >{{ category.ctitle }}</a
              >
            </div>
          </div>
          <!--category-->
        </div>
      </div>
    </div>
  </div>
</template>
<script setup>
// import "bootstrap/dist/js/bootstrap.js";
import "vue-awesome-paginate/dist/style.css";
import { ref, onMounted, watchEffect } from "vue";
import Swal from "sweetalert2";
import { useRouter, RouterLink, useRoute } from "vue-router";
import moment from "moment";
import axios from "axios";

const router = useRouter();
const currentPage = ref(1);
const getroute = useRoute();
const posts = ref([]);
const latestPosts = ref([]);
const categories = ref([]);
const search = ref("");
const notAuth = ref(null);
const user = ref(null);
const paginatePage = ref({});
const url = ref(`${import.meta.env.VITE_BASE_URL}/`);

watchEffect(async () => {
  notAuth.value = localStorage.getItem("user") ? false : true;
  user.value = JSON.parse(localStorage.getItem("user"));

  const searchCategory = ref(getroute.query.category || "");
  axios
    .get(
      `${import.meta.env.VITE_PUBLIC_API_URL}/posts?page=${currentPage.value}`,
      {
        params: {
          q: getroute.query.q,
        },
      }
    )
    .then((response) => {
      console.log("response", response);
      //   search.value = response.data.search;
      posts.value = response.data.posts;
      console.log("post ", posts.value);
      latestPosts.value = response.data.latestPosts;
      categories.value = response.data.categories;
      paginatePage.value = response.data.meta;
    });

  //   await axios
  //     .get(`${import.meta.env.VITE_PUBLIC_API_URL}${searchCategory.value}`)
  //     .then((response) => {
  //       console.log(response.data);
  //       posts.value = response.data.posts;
  //       search.value = response.data.search;
  //       latestPosts.value = response.data.latestPosts;
  //       categories.value = response.data.categories;
  //     });
});

// search by category
const searchCategory = async (category) => {
  router.push({ name: "home", query: { category: category } });
};

// date format
const formatDate = (date) => {
  return moment(date).format("MMMM Do");
};

// minute format
const minuteAgo = (date) => {
  return moment(date).fromNow();
};

// cut description
const short = (value) => {
  if (value.length > 70) {
    return value.slice(0, 100) + "...";
  } else {
    return value;
  }
};

// latestPosts cut description
const latestShort = (value) => {
  if (value.length > 20) {
    return value.slice(0, 20) + "...";
  } else {
    return value;
  }
};

//delete Post
const postDelete = async (id) => {
  await axios
    .delete(`http://127.0.0.1:8000/api/posts/${id}`)
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
        title: "deleted post is  successfully",
      });
      router.push({ name: "home", query: { deletedId: id } });
    });
};
</script>
<style>
@import url("https://fonts.googleapis.com/css2?family=Roboto+Condensed&family=Sofia+Sans+Condensed&display=swap");

.create-user-img {
  width: 35px;
  border-radius: 50%;
}

body {
  font-family: "Roboto Condensed", sans-serif;
}

.container {
  width: 1100px;
  margin: 0 auto;
}

.see-tools {
  cursor: pointer;
  margin: 0;
}

.vender {
  margin-bottom: 30px;
  padding: 90px 0;
  margin-top: 40px;
  background: #f8ba16;
  border-bottom: 1px solid rgba(0, 0, 0, 0.759);
}

.vender h2 {
  margin-bottom: 10px;
  font-size: 50px;
}

.vender p {
  margin: 10px 0 20px 0;
  font-size: 20px;
}

.vender a {
  display: inline-block;
  margin-top: 20px;
  padding: 10px 30px;
  background-color: #2e2e2e;
  color: #fff;
  border-radius: 30px;
}

.search-result {
  margin: 10px 0;
  color: #100909;
  font-size: 35px;
  text-decoration: underline;
  text-transform: capitalize;
}

.del-btn {
  margin-bottom: 9px;
  padding: 0;
  border: none;
  background: transparent;
  color: #d00d0d;
  text-align: center;
}

.tools {
  display: block;
  position: absolute;
  left: 12px;
  box-shadow: rgba(0, 0, 0, 0.07) 0px 1px 2px, rgba(0, 0, 0, 0.07) 0px 2px 4px,
    rgba(0, 0, 0, 0.07) 0px 4px 8px, rgba(0, 0, 0, 0.07) 0px 8px 16px,
    rgba(0, 0, 0, 0.07) 0px 16px 32px, rgba(0, 0, 0, 0.07) 0px 32px 64px;
  padding: 5px 0px 5px 5px;
  padding: 6px 20px;
  border: 1px solid #d5d5d5;
  background: rgb(255 255 255);
  text-align: center;
  border-radius: 5px;
  top: 28px;
}

.right-menu {
  float: left;
  width: 20%;
}

.postlist-content {
  margin-top: 100px;
}

.right-menu h1 {
  display: inline;
}

.right-menu h1 img {
  width: 30px;
  height: 30px;
  border: 1px solid;
}

.pagination-container {
  display: flex;
  column-gap: 10px;
}
.paginate-buttons {
  height: 40px;
  width: 40px;
  border-radius: 20px;
  cursor: pointer;
  background-color: rgb(242, 242, 242);
  border: 1px solid rgb(217, 217, 217);
  color: black;
}
.paginate-buttons:hover {
  background-color: #d8d8d8;
}
.active-page {
  background-color: #3498db;
  border: 1px solid #3498db;
  color: white;
}
.active-page:hover {
  background-color: #2988c8;
}
.input-group {
  display: flex;
  height: 32px;
  overflow: hidden;
  margin-left: 10px;
  padding: 0;
  border: 1px solid rgb(237, 237, 237);
  background-color: #ebebeb;
  border-radius: 20px;
}

.input-group i {
  margin: 10px;
}

.input-group .search {
  border: none;
  background-color: #ebebeb;
  outline: none;
}

.left-menu {
  float: right;
  width: 15%;
  line-height: 2;
}

.write p {
  display: inline;
}

.profile-img {
  display: inline;
  width: 20px;
  height: 20px;
  overflow: hidden;
  border-radius: 50%;
}

/* post  */

/* post  */
.post-list {
  float: left;
  width: 55%;
  margin-top: 10px;
  padding-right: 30px;
  border-right: 1px solid #e9e9e9;
}

.post {
  position: relative;
  margin-bottom: 30px;
  padding-bottom: 20px;
  border-bottom: 1px solid #e7e7e7;
}

.post-text {
  float: left;
  width: 60%;
}

.people {
  margin-bottom: 0px;
}

.profile-img {
  width: 30px;
  height: 30px;
  overflow: hidden;
  margin-bottom: 10px;
  border-radius: 50%;
}

.people p {
  float: right;
  width: 93%;
  margin-top: 5px;
  color: #676767;
  font-size: 18px;
}

.post-title {
  margin-bottom: 0px;
  color: #2f2d29;
  font-size: 30px;
}

.post-description {
  margin: 10px 0;
  color: rgb(47 47 59);
  font-size: 18px;
}

.post-date {
  color: rgb(187 187 198);
  font-size: 15px;
}

.post-img {
  float: right;
  width: 30%;
}

.post-img img {
  width: 100%;
  height: 150px;
  margin-top: 0px;
}

.post-footer {
  display: flex;
  align-items: top;
}

.postfo-left {
  width: 154px;
}

.postfo-right svg {
  margin-right: 5px;
}

.postfo-left a {
  display: inline-block;
  cursor: pointer;
}

.postfo-left span {
  display: inline-block;
  margin-right: 10px;
  padding: 5px 10px;
  margin-bottom: 5px;
  background-color: #e1e1e1;
  font-size: 10px;
  border-radius: 20px;
}

.home-footer {
  display: flex;
}

.postfo-right {
  display: flex;
  position: absolute;
  bottom: 10%;
  left: 300px;
  align-items: center;
  z-index: 2;
}

.postfo-right i {
  margin-right: 5px;
}

.category {
  float: right;
  width: 40%;
}

.category-list {
  margin-bottom: 30px;
}

.category-list h2 {
  margin-bottom: 10px;
  color: #323232;
  font-size: 21px;
}

.latest-post-whole {
  margin-bottom: 20px;
  border-bottom: 1px solid #cdcdcd;
  padding-bottom: 10px;
}

.latest-post {
  font-size: 23px;

  font-weight: bold;
}

.list-latest-profile a {
  display: flex;
  align-items: center;
}

.latest-post img {
  width: 25px;
  height: 25px;
  margin-right: 5px;
  border-radius: 50%;
}

.latest-post .name {
  font-size: 14px;
  margin: 0;
  color: #484848;
  font-weight: bold;
}

.latest-description {
  margin-top: 5px;
  font-size: 23px;
  color: #333333;
  font-weight: bold;
}

.category-item a {
  cursor: pointer;
  display: inline-block;
  margin: 10px 34px 3px 0;
  padding: 8px 20px;
  border: 1px solid rgb(133 133 133);
  color: #4b4b4b;
  font-size: 15px;
  border-radius: 20px;
}

.category-item a:hover {
  background-color: #b7b9bd;
}

.category-item a:nth-child(3n) {
  margin-right: 0 !important;
}

@media screen and (max-width: 768px) {
  .container {
    width: auto;
    padding: 0 39.997px;
  }

  .login-hright h1 a img {
    width: 29.998px;
    height: 29.998px;
    border-radius: 50%;
  }

  .right-menu {
    float: left;
    width: 20%;
  }

  .login-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 0px;
  }

  .login-hright {
    display: flex;
    align-items: center;
  }

  .right-menu h1 {
    display: inline;
  }

  .right-menu h1 img {
    width: 29.998px;
    height: 29.998px;
    border: 0.998px solid;
  }

  .input-group {
    display: flex;
    height: 32.003px;
    overflow: hidden;
    margin-left: 9.999px;
    padding: 0;
    border: 0.998px solid rgb(237, 237, 237);
    background-color: #ebebeb;
    border-radius: 19.999px;
  }

  .input-group i {
    margin: 9.999px;
  }

  .input-group .search {
    border: none;
    background-color: #ebebeb;
    outline: none;
  }

  .left-menu {
    float: right;
    width: 15%;
    line-height: 2;
  }

  .write p {
    display: inline;
  }

  .profile-img {
    display: inline;
    width: 19.999px;
    height: 19.999px;
    overflow: hidden;
    border-radius: 50%;
  }

  /* post  */

  /* post  */
  .post-list {
    float: none;
    width: 100%;
    margin-bottom: 19.999px;
    border-bottom: 0.998px solid #d3d3d3;
  }

  .post {
    margin-bottom: 29.998px;
  }

  .post-text {
    float: left;
    width: 60%;
  }

  .people {
    margin-bottom: 0px;
  }

  .profile-img {
    float: left;
    width: 29.998px;
    height: 29.998px;
    overflow: hidden;
    margin-bottom: 9.999px;
    border-radius: 50%;
  }

  .people p {
    float: right;
    width: 89%;
    margin-top: 5px;
    color: #676767;
    font-size: 18.002px;
  }

  .post-title {
    margin-bottom: 0px;
    color: #2f2d29;
    font-size: 29.998px;
  }

  .post-description {
    margin: 9.999px 0;
    color: rgb(187 187 198);
    font-size: 18.002px;
  }

  .post-date {
    color: rgb(187 187 198);
    font-size: 14.999px;
  }

  .post-img {
    float: right;
    width: 30%;
    height: 20.313vw;
  }

  .post-img img {
    width: 100%;
    height: 100%;
  }

  .category {
    float: none;
    width: 100%;
  }

  .category-list {
    margin-bottom: 29.998px;
  }

  .category-list h2 {
    margin-bottom: 9.999px;
    color: #000;
    font-size: 24.998px;
  }

  .latest-post-whole {
    margin-bottom: 14.999px;
  }

  .latest-post {
    font-size: 23.002px;

    font-weight: bold;
  }

  .list-latest-profile {
    display: flex;
    align-items: center;
  }

  .latest-post img {
    width: 24.998px;
    height: 24.998px;
    margin-right: 5px;
    border-radius: 50%;
  }

  .latest-post .name {
    font-size: 14.001px;
    font-weight: bold;
  }

  .latest-description {
    margin-top: 5px;
    font-size: 23.002px;
    font-weight: bold;
  }

  .postfo-left a span {
    display: inline-block;
    margin-right: 9.999px;
    padding: 5px 9.999px;
    background-color: #b7b9bd;
    font-size: 9.999px;
    border-radius: 19.999px;
  }

  .postfo-right {
    display: flex;
    align-items: center;
  }

  .postfo-right i {
    margin-right: 5px;
  }

  .category-item a {
    display: inline-block;
    margin: 9.999px 33.999px 3.003px 0;
    padding: 8.003px 19.999px;
    border: 0.998px solid rgb(202, 202, 202);
    color: #b7b9bd;
    font-size: 14.999px;
    border-radius: 19.999px;
  }

  .category-item a:nth-child(3n) {
    margin-right: 0 !important;
  }
}

@media screen and (max-width: 640px) {
  .container {
    width: auto;
    padding: 0 40px;
  }

  .postlist-content {
    margin-top: 70.003px;
  }

  .login-hright h1 a img {
    width: 30.003px;
    height: 30.003px;
    border-radius: 50%;
  }

  .right-menu {
    float: left;
    width: 20%;
  }

  .login-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 0px;
  }

  .login-hright {
    display: flex;
    align-items: center;
  }

  .right-menu h1 {
    display: inline;
  }

  .right-menu h1 img {
    width: 28px;
    height: 28px;
    border: 0.998px solid;
  }

  .input-group {
    display: flex;
    height: 32px;
    overflow: hidden;
    margin-left: 10.003px;
    padding: 0;
    border: 0.998px solid rgb(237, 237, 237);
    background-color: #ebebeb;
    border-radius: 20px;
  }

  .input-group i {
    margin: 6.003px;
  }

  .input-group .search {
    margin: 0;
    border: none;
    background-color: #ebebeb;
    font-size: 10.003px;
    outline: none;
  }

  .left-menu {
    float: right;
    width: 15%;
    line-height: 2;
  }

  .write p {
    display: inline;
  }

  .profile-img {
    display: inline;
    width: 18.003px;
    height: 18.003px;
    overflow: hidden;
    border-radius: 50%;
  }

  /* post  */

  /* post  */
  .post-list {
    float: none;
    width: 100%;
    margin-bottom: 18.003px;
    border: none;
    border-bottom: 0.998px solid #d3d3d3;
  }

  .post {
    margin-bottom: 28px;
  }

  .post-text {
    float: left;
    width: 60%;
  }

  .people {
    margin-bottom: 0px;
  }

  .select-box {
    position: relative;
    justify-content: center;
  }

  html .profile-img {
    float: left;
    width: 28px;
    height: 28px;
    overflow: hidden;
    margin-bottom: 8px;
    border-radius: 50%;
  }

  .postfo-left a span {
    margin-right: 10.003px;
    padding: 4.998px 10.003px;
    font-size: 10.003px;
    border-radius: 20px;
  }

  .people p {
    float: right;
    width: 89%;
    margin-top: 4px;
    color: #676767;
    font-size: 16px;
  }

  .post-title {
    margin-bottom: 0px;
    color: #2f2d29;
    font-size: 28px;
  }

  .post-description {
    margin: 8px 0;
    color: rgb(187 187 198);
    font-size: 15.002px;
  }

  .post-date {
    color: rgb(187 187 198);
    font-size: 12.998px;
  }

  .post-img {
    float: right;
    width: 30%;
    height: 140px;
  }

  .post-img img {
    width: 100%;
    height: 100%;
  }

  .category {
    float: none;
    width: 100%;
  }

  .category-list {
    margin-bottom: 28px;
  }

  .category-list h2 {
    margin-bottom: 8px;
    color: #000;
    font-size: 23.002px;
  }

  .latest-post-whole {
    margin-bottom: 12px;
    padding-bottom: 1.563vw;
    border-bottom: 0.156vw solid #e2e2e2;
  }

  .latest-post {
    font-size: 22.003px;
    font-weight: bold;
  }

  .list-latest-profile {
    display: flex;
    align-items: center;
  }

  .latest-post img {
    width: 23.002px;
    height: 23.002px;
    margin-right: 3.002px;
    border-radius: 50%;
  }

  .latest-post .name {
    font-size: 12px;
    font-weight: bold;
  }

  .latest-description {
    margin-top: 3.002px;
    font-size: 20px;
    font-weight: bold;
  }

  .search-result {
    margin: 10.003px 0;
    color: #979797;
    font-size: 24.998px;
  }

  .post-footer {
    display: flex;
  }

  .postfo-left {
    width: 28.125vw;
  }

  .postfo-left a span {
    display: inline-block;
    margin-right: 8px;
    padding: 4.998px 10.003px;
    background-color: #b7b9bd;
    font-size: 8px;
    border-radius: 20px;
  }

  .postfo-right {
    bottom: 26.002px;
    left: 245.002px;
    align-items: center;
    z-index: 0;
  }

  .postfo-right i {
    margin-right: 3.002px;
  }

  .category-item a {
    display: inline-block;
    margin: 8px 26.003px 3.002px 0;
    padding: 4.998px 16.998px;
    border: 0.998px solid rgb(202, 202, 202);
    color: #b7b9bd;
    font-size: 12.998px;
    border-radius: 18.003px;
  }

  .category-item a:nth-child(3n) {
    margin-right: 26.003px !important;
  }
}
</style>
