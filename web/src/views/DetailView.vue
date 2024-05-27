<template>
  <div>
    <div class="container detail-whole">
      <div class="clearfix">
        <div class="detail-post">
          <div class="">
            <div class="post-header">
              <div class="clearfix">
                <div class="left-header">
                  <div class="clearfix">
                    <router-link
                      :to="{ name: 'profile', params: { id: post?.user?.id } }"
                    >
                      <div class="profile-picture">
                        <img
                          :src="url + post.user?.profile"
                          alt=""
                          width="20px"
                          height="20px"
                        />
                      </div>
                      <div class="name-date">
                        <p>{{ post?.user?.name }}</p>
                        <p class="date">
                          {{ formatDate(post?.user?.created_at) }}
                        </p>
                      </div>
                    </router-link>
                  </div>
                </div>

                <div
                  class="right-header"
                  v-if="currentUser?.id == post.user?.id"
                >
                  <router-link
                    :to="{
                      name: 'edit',
                      params: post.id,
                    }"
                  >
                    <span class="edit-btn">Edit</span>
                  </router-link>
                  <form action="" method="post">
                    <p class="del-btn" @click="postDelete">Delete</p>
                  </form>
                </div>
              </div>
            </div>
            <div class="post-img">
              <img :src="url + post.image.url" alt="" />
            </div>
            <h2 class="post-title">{{ post.title }}</h2>
            <p class="post-description">{{ post.description }}</p>
          </div>
          <!--detail psot-->
        </div>

        <div class="right-detail">
          <div class="detail-left-profile">
            <div class="left-profile-image">
              <img :src="url + post.user?.profile" alt="" />
            </div>
            <p class="profile-name">{{ post.user?.name }}</p>
            <p class="count-post">{{ countPost }}</p>
            <p class="post-reasion">
              <!--{{ $post->bio }}-->
            </p>
          </div>

          <!--related post-->
          <div class="related-category">
            <h2>More from Medium</h2>
            <div
              class="category-post clearfix"
              v-for="(relatePost, index) in relatedPosts"
              :key="index"
            >
              <div class="left-side">
                <router-link
                  :to="{
                    name: 'profile',
                    params: { id: relatePost?.user?.id },
                  }"
                >
                  <div class="left-side-header">
                    <img
                      :src="url + relatePost.user?.profile"
                      alt=""
                      class="category-profile"
                    />
                    <p class="category-profile-name">
                      {{ relatePost.user?.name }}
                    </p>
                  </div>
                </router-link>
                <router-link
                  :to="{ name: 'detail', params: { id: relatePost?.id } }"
                >
                  <div class="rel-detail">
                    <p class="category-short-description">
                      {{ relatePost.title }}
                    </p>
                    <svg
                      width="25"
                      height="25"
                      viewBox="0 0 25 25"
                      fill="none"
                      class="mb"
                    >
                      <path
                        d="M18 2.5a.5.5 0 0 1 1 0V5h2.5a.5.5 0 0 1 0 1H19v2.5a.5.5 0 1 1-1 0V6h-2.5a.5.5 0 0 1 0-1H18V2.5zM7 7a1 1 0 0 1 1-1h3.5a.5.5 0 0 0 0-1H8a2 2 0 0 0-2 2v14a.5.5 0 0 0 .8.4l5.7-4.4 5.7 4.4a.5.5 0 0 0 .8-.4v-8.5a.5.5 0 0 0-1 0v7.48l-5.2-4a.5.5 0 0 0-.6 0l-5.2 4V7z"
                        fill="#292929"
                      ></path>
                    </svg>
                  </div>
                </router-link>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="line"></div>

      <!-- comment  -->
      <!-- <section class="comment">
        <h2 class="">
          <span class="comment-count">{{ commentCount }}</span>
        </h2>
        <p class="comment-here">Message in here</p>
        <form @submit.prevent="createComment">
          <textarea
            name="comment"
            id=""
            v-model="commentForm.comment"
            placeholder="write comment"
            class="comment-description"
            required
          ></textarea>
          <input type="hidden" name="post_id" v-model="commentForm.post_id" />
          <button type="submit" class="comment-btn">create</button>
        </form>

        <ReplyView
          :comments="comments"
          :postId="post.id"
          :userId="user_id"
          @listComment="commentList()"
        >
        </ReplyView>
      </section> -->
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, watchEffect } from "vue";
import ReplyView from "./ReplyView.vue";
import axios from "axios";
import moment from "moment";
import { useRoute, useRouter, RouterLink } from "vue-router";

const route = useRoute();
const router = useRouter();
const post = ref({});
const relatedPosts = ref();
const comments = ref();
const user_id = ref();
const commentCount = ref("");
const post_id = ref();
const countPost = ref();
const currentUser = ref(JSON.parse(localStorage.getItem("user")));
const url = ref(import.meta.env.VITE_BASE_URL);
const commentForm = reactive({
  comment: "",
  user_id: user_id,
  post_id: post_id,
});

watchEffect(async () => {
  await axios
    .get(`${import.meta.env.VITE_PUBLIC_API_URL}/posts/${route.params.id}`)
    .then((response) => {
      post.value = response.data.post;
      relatedPosts.value = response.data.relatedPosts;
      commentCount.value = response.data.commentsTotal;
      countPost.value = response.data.countPosts;
      post_id.value = post.value.id;
    });
  const user = JSON.parse(localStorage.getItem("user"));
  if (user) {
    user_id.value = user.id;
  }

  commentList();
  commentForm.comment = "";
});

// format date
function formatDate(date) {
  return moment(date).format("MMMM Do");
}

//comment List
const commentList = async () => {
  await axios
    .get(`http://127.0.0.1:8000/api/comment/${route.params.id}`)
    .then((response) => {
      comments.value = response.data;
    });
};

//delete Post
const postDelete = async () => {
  await axios
    .delete(`${import.meta.env.VITE_PUBLIC_API_URL}/posts/${route.params.id}`)
    .then((response) => {
      console.log(response.data);
      router.push({ name: "home" });
    });
};

// create comment
const createComment = async () => {
  if (currentUser.value == null) {
    router.push({ name: "login" });
  }

  user_id.value = currentUser.value.id;

  await axios
    .post(`${import.meta.env.VITE_PUBLIC_API_URL}/comment`, commentForm)
    .then((response) => {
      commentList();
      router.push({ name: "detail", query: { comment: commentForm.comment } });
    });
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Roboto+Condensed&family=Sofia+Sans+Condensed&display=swap");

body {
  font-family: "Roboto Condensed", sans-serif;
}

.edit-btn {
  display: block;
  margin: 0 3px 6px 0;
  padding: 8px 28px;
  text-align: center;
  border: none;
  color: #ffffff;
  background: #0093ff;
  border-radius: 20px;
}

.mg-6 {
  margin-left: 100px;
}

.container {
  width: 1150px;
  margin: 0 auto;
}

.detail-whole {
  margin-top: 100px !important;
}

.detail-post {
  float: left;
  width: 60%;
  border-right: 1px solid #e7e7e7;
}

.edit-form {
  display: none;
}

.reply-box {
  width: 100%;
  margin-bottom: 10px;
  padding: 10px;
  white-space: pre !important;
  border-radius: 10px;
}

.comment-reply {
  width: 69px;
  padding: 5px 0;
  background-color: #8180f9;
  color: white;
  border: none;
  text-align: center;
  text-transform: capitalize;
  border-radius: 10px;
}

.reply-form {
  margin-left: 20px;
}

.reply-btn {
  padding: 8px 15px;
  border: none;
  border: none;
  background: #6060c1;
  color: #fff;
  /* float: right; */
  font-size: 0.8em;
  font-weight: 600;
  border-radius: 10px;
}

.post-header {
  margin-bottom: 20px;
}

.left-header {
  float: left;
  width: 30%;
}

.profile-picture {
  float: left;
  width: 40px;
  height: 40px;
  overflow: hidden;
  border-radius: 50%;
}

.profile-picture img {
  width: 100%;
  height: 100%;
}

.name-date {
  float: right;
  width: 130px;
  margin-top: 3px;
}

.name-date p {
  margin-bottom: 5px;
  font-size: 15px;
  font-weight: bold;
}

.name-date .date {
  color: rgb(131, 131, 131);
  font-size: 13px;
}

.right-header {
  float: right;
  display: flex;
  align-items: center;
  width: auto;
}

.right-header p {
  display: inline-block;
  padding: 10px 15px;
  border: none;
  cursor: pointer;
  background-color: rgb(255, 0, 0);
  color: #fff;
  border-radius: 20px;
}

.post-img {
  width: 94%;
  margin-bottom: 20px;
}

.post-img img {
  width: 100%;
  object-fit: contain;
  height: 45vh;
}

.post-title {
  margin-bottom: 20px;
  color: #000;
  font-size: 30px;
}

.post-description {
  margin-bottom: 20px;
  color: rgb(98 98 98);
  font-size: 20px;
}

.line {
  width: 100%;
  margin-bottom: 10px;
  padding: 0.2px;
  background-color: #e6e6e6;
}

.comment h2 {
  margin-bottom: 10px;
  color: #000;
  font-size: 20px;
}

.comment-count {
  margin-left: 5px;
  padding: 5px 10px;
  background-color: rgb(206, 206, 206);
  color: #fff;
  font-size: 15px;
  border-radius: 50%;
}

.comment-here {
  font-size: 15px;
  column-rule: rgb(211, 205, 205);
}

.comment-description {
  width: 100%;
  margin-top: 10px;
  padding: 25px;
  border: 1px solid #504c4c;
  outline: none;
}

.comment-btn-group {
  display: flex;
  align-items: center;
}

.delete-comment {
  display: inline-block;
  margin-right: 10px;
  border: none;
  padding: 5px 10px;
  background-color: #ff0a0a;
  color: #fff;
  border-radius: 10px;
}

.comment-btn {
  display: inline-block;
  margin: 10px 10px 10px 92%;
  padding: 12px 23px;
  border: none;
  background-color: rgb(139 139 139);
  color: #fff;
  border-radius: 10px;
}

#edit-comtext {
  width: 300px;
  margin: 5px;
  padding: 10px;
  white-space: pre !important;
  border-radius: 5px;
}

.reply {
  margin-bottom: 25px;
  padding: 5px 10px;
  border-radius: 10px;
  border: 1px solid #6b6a6a;
}

.reply-header {
  margin-bottom: 5px;
}

.reply-profile {
  float: left;
  width: 40px;
  height: 40px;
  overflow: hidden;
  border-radius: 50%;
}

.reply-profile img {
  width: 100%;
  height: 100%;
}

.left-detail {
  float: right;
  width: 95%;
  margin-top: 3px;
}

.left-detail h3 {
  font-size: 16px;
}

.mg-3 {
  margin-left: 40px;
}

.left-detail p {
  color: rgb(135 135 135);
  font-size: 13px;
}

.reply-text {
  margin: 8px 0;
  font-size: 17px;
  white-space: pre !important;
}

/* left detail post  */

.right-detail {
  float: right;
  width: 38%;
}

.left-profile-image {
  width: 50px;
  height: 50px;
  overflow: hidden;
  margin-bottom: 10px;
  border-radius: 50%;
}

.left-profile-image img {
  width: 100%;
  height: 100%;
}

.profile-name {
  margin-bottom: 10px;
  font-size: 20px;
  font-weight: bold;
}

.count-post {
  margin-bottom: 15px;
  color: rgb(156, 156, 156);
  font-size: 18px;
}

.post-reasion {
  margin-bottom: 15px;
  color: rgb(156, 156, 156);
  font-size: 15px;
}

.related-category h2 {
  margin-bottom: 10px;
  color: #000;
  font-size: 25px;
}

.category-post {
  margin-bottom: 20px;
}

.category-post .left-side {
  float: left;
  width: 100%;
  border-bottom: 1px solid #eccece;
}

.left-side-header {
  display: flex;
}

.left-side-header img {
  width: 40px;
  height: 40px;
  overflow: hidden;
  margin-right: 8px;
  margin-bottom: 10px;
  border-radius: 50%;
}

.rel-detail {
  display: flex;
  justify-content: space-between;
}

.left-side-header p {
  margin-top: 10px;
  color: #5d5959;
  font-size: 15px;
}

.category-short-description {
  color: rgb(29 29 29);
  font-size: 18px;
  font-weight: 600;
}

.right-side {
  float: right;
  width: 75px;
}

.right-side a {
  display: inline-block;
  padding: 15px;
  border: 1px solid #cec9c9;
  color: #80918f;
}

@media screen and (max-width: 768px) {
  .container {
    width: auto;
    padding: 0 39.997px;
  }

  .delete-comment {
    margin-right: 10px;
    padding: 4px 9px;
    border-radius: 10px;
  }

  .comment-reply {
    width: 8.724vw;
    padding: 0.521vw 0;
    border-radius: 1.302vw;
  }

  .detail-post {
    float: none;
    width: 100%;
    border-right: none;
  }

  .post-header {
    margin-bottom: 19.999px;
  }

  .left-header {
    float: left;
    width: 30%;
  }

  .profile-picture {
    float: left;
    width: 39.997px;
    height: 39.997px;
    overflow: hidden;
    border-radius: 50%;
  }

  .profile-picture img {
    width: 100%;
    height: 100%;
  }

  .name-date {
    float: right;
    width: 115px;
    margin-top: 3.003px;
  }

  .name-date p {
    margin-bottom: 5px;
    font-size: 14.999px;
    font-weight: bold;
  }

  .name-date .date {
    color: rgb(131, 131, 131);
    font-size: 13.002px;
  }

  .right-header {
    float: right;
    width: 80.003px;
  }

  .right-header a {
    display: inline-block;
    padding: 5px 9.999px;
    background-color: rgb(255, 0, 0);
    color: #fff;
    border-radius: 19.999px;
  }

  .post-img {
    width: 94%;
    margin-bottom: 19.999px;
  }

  .post-img img {
    width: 100%;
    height: 45vh;
  }

  .post-title {
    margin-bottom: 14.001px;
    color: #000;
    font-size: 24px;
  }

  .post-description {
    margin-bottom: 19.999px;
    color: rgb(211, 205, 205);
    font-size: 14.999px;
  }

  .line {
    width: 100%;
    margin-bottom: 9.999px;
    padding: 0.2px;
    background-color: #999;
  }

  .comment h2 {
    margin-bottom: 9.999px;
    color: #000;
    font-size: 18.002px;
  }

  .comment-count {
    margin-left: 5px;
    padding: 3.003px 5.998px;
    background-color: rgb(206, 206, 206);
    color: #fff;
    font-size: 12.004px;
    border-radius: 50%;
  }

  .comment-here {
    font-size: 12.004px;
    column-rule: rgb(211, 205, 205);
  }

  .comment-description {
    width: 100%;
    margin-top: 9.999px;
    padding: 14.001px;
    border: 0.998px solid;
    white-space: pre !important;
  }

  .comment-btn {
    margin: 11.999px 9.999px 9.999px 92%;
    /* margin-left: 502.003px !important; */
    padding: 5px 10px;
    font-size: 12.004px;
    border-radius: 9.999px;
  }

  .reply {
    margin-bottom: 24.998px;
  }

  .reply-header {
    margin-bottom: 5px;
  }

  .reply-profile {
    float: left;
    width: 24.998px;
    height: 24.998px;
    overflow: hidden;
    border-radius: 50%;
  }

  .reply-profile img {
    width: 100%;
    height: 100%;
  }

  .left-detail {
    float: right;
    width: 93%;
    margin-top: 3.003px;
  }

  .left-detail h3 {
    font-size: 13.002px;
  }

  .left-detail p {
    color: rgb(135 135 135);
    font-size: 9.999px;
  }

  .reply-text {
    margin-top: 8.003px;
    font-size: 13.002px;
  }

  /* left detail post  */

  .right-detail {
    float: none;
    width: 100%;
  }

  .left-profile-image {
    width: 39.997px;
    height: 39.997px;
    overflow: hidden;
    margin-bottom: 9.999px;
    border-radius: 50%;
  }

  .left-profile-image img {
    width: 100%;
    height: 100%;
  }

  .profile-name {
    margin-bottom: 8.003px;
    font-size: 18.002px;
    font-weight: bold;
  }

  .count-post {
    margin-bottom: 9.999px;
    color: rgb(156, 156, 156);
    font-size: 14.999px;
  }

  .post-reasion {
    margin-bottom: 8.003px;
    color: rgb(156, 156, 156);
    font-size: 13.002px;
  }

  .related-category h2 {
    margin-bottom: 9.999px;
    color: #000;
    font-size: 18.002px;
  }

  .category-post {
    margin-bottom: 19.999px;
  }

  .category-post .left-side {
    float: left;
  }

  .left-side-header {
    display: flex;
  }

  .left-side-header img {
    width: 29.998px;
    height: 29.998px;
    overflow: hidden;
    margin-right: 8.003px;
    margin-bottom: 9.999px;
    border-radius: 50%;
  }

  .left-side-header p {
    margin-top: 9.999px;
    color: #999;
    font-size: 14.999px;
  }

  .category-short-description {
    color: rgb(0, 0, 0);
    font-size: 18.002px;
    font-weight: bold;
  }

  .right-side {
    float: right;
    width: 75.003px;
  }

  .right-side a {
    display: inline-block;
    padding: 14.999px;
    border: 0.998px solid #cec9c9;
    color: #80918f;
  }
}

@media screen and (max-width: 640px) {
  .container {
    width: auto;
    padding: 0 6.25vw;
  }

  .comment-reply {
    width: 7.724vw;
    padding: 0.421vw 0;
    border-radius: 1.302vw;
  }

  .delete-comment {
    margin-right: px;
    padding: 0.469vw 1.25vw;
    border-radius: 1.563vw;
  }

  .detail-post {
    float: none;
    width: 100%;
    border-right: none;
  }

  .post-header {
    margin-bottom: 3.125vw;
  }

  .left-header {
    float: left;
    width: 30%;
  }

  .profile-picture {
    float: left;
    width: 6.25vw;
    height: 6.25vw;
    overflow: hidden;
    border-radius: 50%;
  }

  .profile-picture img {
    width: 100%;
    height: 100%;
  }

  .name-date {
    float: right;
    width: 17.969vw;
    margin-top: 0.469vw;
  }

  .name-date p {
    margin-bottom: 0.781vw;
    font-size: 2.344vw;
    font-weight: bold;
  }

  .name-date .date {
    color: rgb(131, 131, 131);
    font-size: 2.031vw;
  }

  .right-header {
    float: right;
    width: 12.5vw;
  }

  .right-header a {
    display: inline-block;
    padding: 0.781vw 1.563vw;
    border: none;
    background-color: rgb(255, 0, 0);
    color: #fff;
    border-radius: 3.125vw;
  }

  .post-img {
    width: 94%;
    margin-bottom: 3.125vw;
  }

  .post-img img {
    width: 100%;
    height: 45vh;
  }

  .post-title {
    margin-bottom: 2.188vw;
    color: #000;
    font-size: 3.75vw;
  }

  .post-description {
    margin-bottom: 3.125vw;
    color: rgb(211, 205, 205);
    font-size: 2.344vw;
  }

  .line {
    width: 100%;
    margin-bottom: 1.563vw;
    padding: 0.031vw;
    background-color: #999;
  }

  .comment h2 {
    margin-bottom: 1.563vw;
    color: #000;
    font-size: 2.813vw;
  }

  .comment-count {
    margin-left: 0.781vw;
    padding: 0.469vw 0.938vw;
    background-color: rgb(206, 206, 206);
    color: #fff;
    font-size: 1.875vw;
    border-radius: 50%;
  }

  .comment-here {
    font-size: 1.875vw;
    column-rule: rgb(211, 205, 205);
  }

  .comment-description {
    width: 100%;
    margin-top: 1.563vw;
    padding: 2.188vw;
    border: 0.156vw solid;
    white-space: pre !important;
  }

  .comment-btn {
    display: inline-block;
    margin: 1.563vw 1.563vw 1.563vw 92%;
    margin-left: 78.438vw !important;
    padding: 0.781vw;
    background-color: rgb(206, 206, 206);
    color: #fff;
    font-size: 1.875vw;
    border-radius: 1.563vw;
  }

  .reply {
    margin-bottom: 3.906vw;
  }

  .reply-header {
    margin-bottom: 0.781vw;
  }

  .reply-profile {
    float: left;
    width: 3.906vw;
    height: 3.906vw;
    overflow: hidden;
    border-radius: 50%;
  }

  .reply-profile img {
    width: 100%;
    height: 100%;
  }

  .left-detail {
    float: right;
    width: 93%;
    margin-top: 0.469vw;
  }

  .left-detail h3 {
    font-size: 2.031vw;
  }

  .left-detail p {
    color: rgb(135 135 135);
    font-size: 1.563vw;
  }

  .reply-text {
    margin-top: 1.25vw;
    font-size: 2.031vw;
  }

  /* left detail post  */

  .right-detail {
    float: none;
    width: 100%;
  }

  .left-profile-image {
    width: 6.25vw;
    height: 6.25vw;
    overflow: hidden;
    margin-bottom: 1.563vw;
    border-radius: 50%;
  }

  .left-profile-image img {
    width: 100%;
    height: 100%;
  }

  .profile-name {
    margin-bottom: 1.25vw;
    font-size: 2.813vw;
    font-weight: bold;
  }

  .count-post {
    margin-bottom: 1.563vw;
    color: rgb(156, 156, 156);
    font-size: 2.344vw;
  }

  .post-reasion {
    margin-bottom: 1.25vw;
    color: rgb(156, 156, 156);
    font-size: 2.031vw;
  }

  .related-category h2 {
    margin-bottom: 1.563vw;
    color: #000;
    font-size: 2.813vw;
  }

  .category-post {
    margin-bottom: 3.125vw;
  }

  .category-post .left-side {
    float: left;
    width: 80%;
  }

  .left-side-header {
    display: flex;
  }

  .left-side-header img {
    width: 4.688vw;
    height: 4.688vw;
    overflow: hidden;
    margin-right: 1.25vw;
    margin-bottom: 1.563vw;
    border-radius: 50%;
  }

  .left-side-header p {
    margin-top: 1.563vw;
    color: #999;
    font-size: 2.344vw;
  }

  .category-short-description {
    color: rgb(0, 0, 0);
    font-size: 2.813vw;
    font-weight: bold;
  }

  .right-side {
    float: right;
    width: 11.719vw;
  }

  .right-side a {
    display: inline-block;
    padding: 2.344vw;
    border: 0.156vw solid #cec9c9;
    color: #80918f;
  }
}
</style>
