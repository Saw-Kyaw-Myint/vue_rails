<template>
    <div id="overlay" v-if="updateProfile || changePassword" @click="(updateProfile = false), (changePassword = false)">
    </div>

    <!-- edit profile  -->
    <div id="edit-profile" class=" " v-if="updateProfile">
        <p class="x" @click="updateProfile = false">
            <i class="fa-solid fa-x"></i>
        </p>
        <form @submit.prevent="updateUserDetail">
            <h3 class="edit-ttl">Edit Your Information</h3>
            <div class="profile-image">
                <img :src="previewImage" v-if="previewImage" id="output" />
                <img :src="url + loginUser?.profile" v-else id="output" /><br />
                <input type="file" name="profile" @change="handleImageChange" /><br />
            </div>

            <label for="">Name</label>
            <input type="text" name="name" v-model="changeProfile.name" /><br />

            <p class="error-message">{{ errors?.name ? errors.name[0] : '' }}</p>

            <label for="">Email</label>
            <input type="text" name="email" v-model="changeProfile.email" /><br />

            <p class="error-message">{{ errors?.email ? errors.email[0] : '' }}</p>

            <label for="">Bio</label>
            <input type="text" name="bio" v-model="changeProfile.bio" /><br />

            <div class="error-message">{{ errors?.bio ? errors.bio[0] : '' }}</div>

            <div>
                <button class="cancel" type="reset">Cancel</button>
                <button class="button-primary" type="submit">Update</button>
            </div>

        </form>
    </div>

    <!-- password change  -->
    <div id="password-change" class="" v-if="changePassword">
        <p class="x" @click="changePassword = false"><i class="fa-solid fa-x"></i></p>
        <h2 class="cps-title">ChangePassword Form</h2>
        <form @submit.prevent="passwordUpdate">
            <div class="cps-input-group">
                <label for="">Current Password</label>
                <input type="password" name="current_password" id="current_password" placeholder="Enter current password..."
                    v-model="updatePassword.current_password" />
                <span class="error-message">{{ passwordErrors?.current_password ? passwordErrors.current_password[0] : '' }}</span>
            </div>
            <div class="cps-input-group">
                <label for="">New Password</label>
                <input type="password" name="new_password" id="new_password" placeholder="Enter new password..."
                    v-model="updatePassword.new_password" />
                <span class="error-message">{{ passwordErrors?.new_password ? passwordErrors.new_password[0] : ' ' }}</span>
            </div>
            <div class="cps-input-group">
                <label for="">Confirm Passwor</label>
                <input type="password" name="confirm_password" id="confirm_password" placeholder="Enter confirm password..."
                    v-model="updatePassword.confirm_password" />
                <span class="error-message">{{ passwordErrors?.confirm_password ? passwordErrors.confirm_password : '' }}</span>
            </div>
            <div class="input-gp change-blk">
                <input type="submit" value="Change Password" class="change-btn" />
            </div>
        </form>
    </div>

    <div class="container">
        <div class="profile">
            <div class="clearfix">
                <div class="profile-left-side">
                    <div class="left-profile-header">
                        <div class="clearfix">
                            <div class="pf-left-side">
                                <img :src="url + currentUser?.profile" alt="" class="pfl-profile" />
                                <h2>{{ currentUser?.name }}</h2>
                            </div>

                            <div class="pf-right-side" v-if="loginUser != null && loginUser.id == route.params.id">
                                <div class="edit-update">
                                    <p id="ex1" @click="updateProfile = !updateProfile">
                                        <a href="#">Edit Profile</a>
                                    </p>
                                    <p id="ex2" @click="changePassword = !changePassword">
                                        <a href="#"> Update Password</a>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="pls-content">
                        <h2>Information</h2>
                        <div class="pls-email">
                            <h3>Email</h3>
                            <p>{{ currentUser?.email }}</p>
                        </div>
                        <div class="pls-post-count">
                            <h3>Post Count</h3>
                            <p>{{ (posts.length) }}</p>
                        </div>
                        <div class="pls-Bio">
                            <h3>Bio</h3>
                            <p>{{ currentUser?.bio }}</p>
                        </div>
                        <h2>My Posts</h2>
                        <!-- mypost  -->
                        <div class="mypost-whole" v-for="(post, index) in posts" :key="index">
                            <router-link :to="{ name: 'profile', parms: { id: post?.user?.id } }">
                                <div class="pls-myPost">
                                    <p>
                                        <img :src="url + post?.user?.profile" alt="" />
                                        <span>{{ post?.user?.name }}
                                            <span>{{ minuteAgo(post?.created_at) }}</span>
                                        </span>
                                    </p>
                                </div>
                            </router-link>
                            <div class="pf-post-content">
                                <div class="clearfix">
                                    <div class="prof-post">
                                        <div class="prof-left-post">
                                            <router-link :to="{ name: 'detail', params: { id: post?.id } }">
                                                <h3>{{ post?.title }}</h3>
                                                <p>{{ post?.description }}</p>
                                            </router-link>
                                            <div class="prof-leftPost-footer">
                                                <div class="cat-group" v-for="(category, index) in post.categories"
                                                    :key="index">
                                                    <span href="#" @click="categorySearch(category.ctitle)">{{
                                                        category.ctitle }}</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <router-link :to="{ name: 'detail', params: { id: post?.id } }">
                                        <div class="prof-right-post">
                                            <img :src="url + post?.image" alt="" />
                                        </div>
                                    </router-link>
                                </div>
                            </div>


                            <div class="postfo-right">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" class="tr">
                                    <path
                                        d="M17.5 1.25a.5.5 0 0 1 1 0v2.5H21a.5.5 0 0 1 0 1h-2.5v2.5a.5.5 0 0 1-1 0v-2.5H15a.5.5 0 0 1 0-1h2.5v-2.5zm-11 4.5a1 1 0 0 1 1-1H11a.5.5 0 0 0 0-1H7.5a2 2 0 0 0-2 2v14a.5.5 0 0 0 .8.4l5.7-4.4 5.7 4.4a.5.5 0 0 0 .8-.4v-8.5a.5.5 0 0 0-1 0v7.48l-5.2-4a.5.5 0 0 0-.6 0l-5.2 4V5.75z"
                                        fill="#000"></path>
                                </svg>


                                <p class="see-tools" @click="post.edit = !post.edit"
                                    v-if="loginUser != null && loginUser.id == post.user.id">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                        <path d="M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18zM8.25 12h7.5" stroke="currentColor"
                                            stroke-linecap="round" stroke-linejoin="round"></path>
                                    </svg>
                                </p>

                                <div class="tools" v-if="post.edit == 1">
                                    <button class="del-btn" @click="postDelete(post.id)">
                                        Delete
                                    </button>
                                    <div class="">
                                        <router-link :to="{ name: 'edit', params: { id: post?.id } }">Edit
                                        </router-link>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="">
                    <div class="profile-right-side">
                        <div class="category-list">
                            <h2 class="cate-name">2022 IN Latest Post</h2>
                            <div class="latest-post-whole" v-for="(latestpost, index) in latestPosts" :key="index">
                                <div class="latest-post">
                                    <router-link :to="{
                                        name: 'profile',
                                        params: { id: latestpost.user?.id },
                                    }">
                                        <div class="list-latest-profile">
                                            <img :src="url + latestpost.user?.profile" />
                                            <p class="name">{{ latestpost?.user?.name }}</p>
                                        </div>
                                    </router-link>
                                    <router-link :to="{ name: 'detail', params: { id: latestpost.id } }">
                                        <p class="latest-description">{{ latestpost?.title }}</p>
                                    </router-link>
                                </div>
                            </div>
                        </div>
                        <div class="category-item">
                            <p v-for="(category, index) in categories" :key="index">
                                <span @click="categorySearch(category.ctitle)">{{
                                    category.ctitle
                                }}</span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup >
import axios from "axios";
import moment from 'moment';
import { onMounted, reactive, ref, watchEffect } from "vue";
import { useRouter, useRoute } from "vue-router";

const router = new useRouter();
const route = new useRoute();
const currentUser = ref(null);
const categories = ref(null);
const latestPosts = ref(null);
const posts = ref(null);
const updateProfile = ref(false);
const changePassword = ref(false);
const imageFile = ref(null);
const loginUser = ref(null);
const previewImage = ref(null);
const updateCount = ref(0);
const changeTime = ref(0);
const errors = ref(null);
const passwordErrors = ref(null);
const url = ref("http://127.0.0.1:8000/storage/");
const changeProfile = reactive({
    image: '',
    name: '',
    email: '',
    user_id: '',
    bio: ''
})
const updatePassword = reactive({
    current_password: '',
    new_password: '',
    confirm_password: '',
    user_id: '',
})

//for image
const handleImageChange = (event) => {
    const file = event.target.files[0];
    if (file) {
        imageFile.value = file;
        changeProfile.image = file;
        const reader = new FileReader();
        reader.onload = (e) => {
            previewImage.value = e.target.result;
        };
        reader.readAsDataURL(file);
    }
};

watchEffect(async () => {
    await axios
        .get(`http://127.0.0.1:8000/api/profile/${route.params.id}`)
        .then((response) => {
            currentUser.value = response.data.user;
            updatePassword.user_id = response.data.user.id;
            categories.value = response.data.categories;
            latestPosts.value = response.data.latestPosts;
            posts.value = response.data.posts;
        });

    const token = localStorage.getItem('token');
    axios.get('http://127.0.0.1:8000/api/user', {
        headers: {
            Authorization: `Bearer ${token}`
        }
    }).then((response) => {
        loginUser.value = response.data;

        changeProfile.name = loginUser.value.name;
        changeProfile.email = loginUser.value.email;
        changeProfile.bio = loginUser.value.bio
        changeProfile.user_id = loginUser.value.id;
        localStorage.setItem('user', JSON.stringify(response.data));
    });

    console.log(loginUser.value);

});

// search category 
const categorySearch = async (searchVal) => {
    router.push({ name: "home", query: { category: searchVal } });
};

//delete Post
const postDelete = async (id) => {
    await axios
        .delete(`http://127.0.0.1:8000/api/posts/${id}`)
        .then((response) => {
            router.push({ name: "profile", query: { deletedId: id } });
        });
};

// update user detail 
const updateUserDetail = async () => {
    const token = localStorage.getItem('token');
    const config = {
        headers: {
            "content-type": "multipart/form-data",
        },
    }
    axios.post('http://127.0.0.1:8000/api/userProfile', changeProfile, config, {
        headers: {
            Authorization: `Bearer ${token}`
        }
    }).then((response) => {
        updateCount.value++;
        router.push({ name: 'profile', query: { update: updateCount.value } });
        updateProfile.value = false;
    }).catch(function (error) {
        errors.value = error.response.data.errors;
    })
}

// update password 
const passwordUpdate = async () => {
    const token = localStorage.getItem('token');
    axios.post('http://127.0.0.1:8000/api/changePassword/update', updatePassword, {
        headers: {
            Authorization: `Bearer ${token}`
        }
    }).then((response) => {
        console.log(response.data);
        router.push({ name: 'profile' });
        updatePassword.current_password = '';
        updatePassword.new_password = '';
        updatePassword.confirm_password = '';
        passwordErrors.value = null;
        alert('password is updated successfully');
        changePassword.value = false;
    }).catch(function (error) {
        passwordErrors.value = error.response.data.errors;
    })
}

//minute format
const minuteAgo = (date) => {
    return moment(date).fromNow();
}

</script>

<style scoped>
:root {
    --content: #7e7e7e;
    --title: #2e2e2e;
    --title-font: 18px;
    --content-font: 15px;
}

.container {
    width: 1000px;
    margin: 0 auto;
}

#overlay {
    position: fixed;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 4;
    cursor: pointer;
}

.see-tools {
    cursor: pointer;
}

.cancel {
    background-color: #be2284;
    padding: 5px 10px;
    border-radius: 5px;
    color: white;
}

button {
    border: none;
    outline: none;
}

label {
    font-size: 19px;
    display: inline-block;
    margin: 4px 0px;
}

.button-primary {
    padding: 5px 10px;
    background: #2235d4;
    border-radius: 5px;
    color: white;
    margin-left: 5px;
}

.latest-post-whole {
    margin-bottom: 20px;
    border-bottom: 1px solid #cdcdcd;
    padding-bottom: 10px;
}

.list-latest-profile {
    display: flex;
    width: 100%;
    align-items: center;
}

.list-latest-profile img {
    width: 25px;
    height: 25px;
    margin-right: 5px;
    border-radius: 50%;
}

.latest-post .name {
    font-size: 14px;
    font-weight: bold;
    color: rgb(56, 56, 56);
}

.latest-description {
    margin-top: 5px;
    font-size: 23px;
    color: rgb(29, 29, 29);
    font-weight: bold;
}

.category-item p {
    display: inline-block;
    cursor: pointer;
    margin: 10px 34px 3px 0;
    padding: 8px 20px;
    border: 1px solid rgb(133 133 133);
    color: #4b4b4b;
    font-size: 15px;
    border-radius: 20px;
}

.postfo-right {
    display: flex;
    position: absolute;
    bottom: 1px;
    left: 390px;
    align-items: center;
    z-index: 2;
}

.error-message {
    display: inline-block;
    margin-bottom: 4px;
    color: red;
}

.profile-image {
    display: flex;
    align-items: center;
    margin: 5px 0;
}

.cat-group {
    display: inline-block;
    margin-bottom: 6px;
}

.cat-group span {
    margin-right: 5px;
    padding: 4px;
    background-color: #adadad;
    font-size: 12px;
    color: #040404;
    border-radius: 10px;
}

.profile-image input {
    width: 50% !important;
    padding: 0px !important;
}

.profile-image #output {
    width: 200px;
    height: 200px;
    margin-right: 10px;
    border-radius: 50%;
}

.edit-update {
    display: flex;
    align-items: center;
}

.edit-update p {
    margin-right: 10px;
}

.user-edit input {
    width: 100%;
    margin-bottom: 10px;
    padding: 7px 10px;
    border: 1px solid #adadad;
    outline: none;
    border-color: 1px solid #fff;
    border-radius: 10px;
}

.user-edit .cancel {
    padding: 10px 15px;
    border: none;
    background-color: #4bd1f0;
    color: #fff !important;
    font-weight: bold;
    border-radius: 10px;
}

.user-edit .button-primary {
    padding: 10px 15px;
    border: none;
    background-color: rgb(19 0 235);
    color: #fff;
    font-weight: bold;
    border-radius: 10px;
}

.del-btn {
    margin-bottom: 3px;
    padding: 0;
    border: none;
    background: transparent;
    color: red;
    text-align: center;
}

.del-btn i {
    color: red;
}

.tools {
    position: absolute;
    left: -2px;
    bottom: -52px;
    padding: 8px;
    background: rgb(255 255 255);
    text-align: center;
    box-shadow: rgb(0 0 0 / 25%) 0px 54px 55px, rgb(0 0 0 / 12%) 0px -12px 30px,
        rgb(0 0 0 / 12%) 0px 4px 6px, rgb(0 0 0 / 17%) 0px 12px 13px,
        rgb(0 0 0 / 9%) 0px -3px 5px;
    border-radius: 10px;
}

.profile {
    margin-top: 100px;
}

.profile-left-side {
    float: left;
    width: 60%;
    padding-right: 10px;
    border-right: 1px solid #ffdfdf;
}

.pf-left-side {
    display: flex;
    float: left;
    align-items: center;
    width: 50%;
    margin-bottom: 20px;
}

.pfl-profile {
    width: 45px;
    height: 45px;
    margin-right: 5px;
    border-radius: 50%;
}

.pf-left-side h2 {
    margin-top: 3px;
    margin-left: 5px;
    font-size: 25px;
    font-weight: bold;
}

.pf-right-side {
    float: right;
    width: 40%;
    margin-top: 12px;
}

.pf-right-side a {
    display: inline-block;
    padding: 5px 15px;
    background-color: #6c6363;
    color: #fff;
    font-size: 13px;
    border-radius: 20px;
}

.pls-content h2 {
    margin-bottom: 15px;
    padding-bottom: 11px;
    color: var(--title);
    font-size: 24px;
    border-bottom: 2px solid #f7f7f7;
}

.pls-email {
    margin-bottom: 20px;
}

.pls-email h3 {
    margin-bottom: 10px;
    font-size: var(--title-font);
}

.pls-email p {
    color: var(--content);
    font-size: 13px;
}

.pls-post-count {
    margin-bottom: 25px;
}

.pls-post-count h3 {
    margin-bottom: 10px;
    color: var(--title);
    font-size: 15px;
}

.pls-post-count p {
    width: fit-content;
    padding: 2px 7px;
    background-color: rgb(212, 212, 212);
    color: #fff;
    font-size: 12px;
    border-radius: 50%;
}

.pls-Bio {
    margin-bottom: 30px;
}

.pls-Bio h3 {
    margin-bottom: 10px;
    color: var(--title);
    font-size: var(--title-font);
}

.pls-Bio p {
    color: var(--content);
    font-size: var(--content-font);
}

.pls-myPost {
    margin-bottom: 10px;
}

.pls-myPost h2 {
    padding-bottom: 10px;
    color: #4c4c4c;
    font-size: 23px;
    border-bottom: 1px solid rgb(233, 233, 233);
}

.pls-myPost p {
    display: flex;
    align-items: center;
    color: #4c4c4c;
    font-size: 15px;
}

.pls-myPost p img {
    width: 30px;
    height: 30px;
    border-radius: 50%;
}

.pls-myPost p span {
    margin-left: 10px;
    color: #4c4c4c;
    font-size: 12px;
}

.prof-left-post {
    float: left;
    width: 70%;
    padding: 10px;
}

.prof-left-post h3 {
    margin-bottom: 10px;
    color: #1d0808;
    font-weight: bold;
    font-size: 23px;
}

.prof-left-post p {
    margin-bottom: 10px;
    color: #4c4c4c;
    font-size: 15px;
}

.prof-leftPost-footer {
    width: 110px;
}

.prof-leftPost-footer a {
    padding: 5px;
    background: #dfdfdf;
    color: #5c5c5c;
    font-size: 12px;
    border-radius: 10px;
}

.mypost-whole {
    position: relative;
    margin-bottom: 20px;
    border-bottom: 1px solid #d6c9c9;
}

.leftfo-right {
    display: flex;
    position: absolute;
    right: 173px;
    bottom: 17px;
}

.prof-right-post {
    float: right;
    width: 20%;
}

.prof-right-post img {
    width: 100%;
    height: 100px;
}

/*right aside */
.profile-right-side {
    float: right;
    width: 38%;
    height: 100vh;
}

.prors-content {
    padding-left: 80px;
}

.profile-right-side h2 {
    margin-bottom: 20px;
    font-size: 30px;
}

.prors-post {
    margin-bottom: 25px;
}

.prors-head {
    display: flex;
    align-items: center;
}

.error {
    color: red;
    margin-bottom: 5px;
    font-size: 18px;
}

.edit-ttl {
    font-size: 30px;
}

#edit-profile {
    position: absolute;
    margin-left: 30%;
    z-index: 4;
    background: #fff;
    padding: 10px;
    transition: 0.5s;
    margin-top: 30px;
    box-shadow: rgb(100 100 111 / 20%) 0px 7px 29px 0px;
    border-radius: 20px;
}

#edit-profile input {
    width: 100%;
    padding: 5px 2px;
    outline: none;
    margin-bottom: 5px;
}

#password-change {
    margin-left: 38.5%;
    width: 325px;
    transition: 0.5s;
    z-index: 4;
    position: absolute;
    background: #fff;
    margin-top: 140px;
    padding: 10px;
    box-shadow: rgb(100 100 111 / 20%) 0px 7px 29px 0px;
    border-radius: 20px;
}

.x {
    position: absolute;
    right: -8px;
    top: -9px;
    padding: 6px;
    border-radius: 50%;
    color: #fff;
    background: #5f5f5f;
}

.show {
    display: block !important;
}

.hide {
    display: none;
}

.prors-head img {
    width: 30px;
    height: 30px;
    border-radius: 50%;
}

.prors-head p {
    margin-left: 20px;
    font-size: 17px;
    font-weight: bold;
}

.prors-title {
    margin-top: 10px;
    font-size: 18px;
}

.profile-category a {
    display: inline-block;
    margin-bottom: 10px;
    padding: 5px 10px;
    background-color: #dfdfdf;
    color: #000;
    border-radius: 20px;
}

/* change password  */
.cps-title {
    margin-bottom: 20px;
    color: #3030af;
    font-size: 25px;
    text-align: center;
}

.modal {
    max-width: 400px !important;
}

.cps-input-group input {
    width: 100%;
    margin-bottom: 10px;
    padding: 5px 10px;
    outline: none;
    border-radius: 10px;
}

.change-btn {
    padding: 5px 10px;
    border: none;
    background: #0101d1;
    color: #fff;
    font-weight: 4000;
    border-radius: 10px;
}

/*ipad */
@media screen and (max-width: 768px) {
    .container {
        width: auto;
        padding: 0 40px;
    }


    .category-item p {
        margin: 1.302vw 4.427vw 0.391vw 0;
        padding: 1.042vw 2.604vw;
        font-size: 1.953vw;
        border-radius: 2.604vw;
    }

    .postfo-right {
        bottom: 0.13vw;
        left: 59.896vw;
        z-index: 2;
    }

    .error {
        color: red;
        margin-bottom: 0.651vw;
        font-size: 1.693vw;
    }

    .edit-ttl {
        font-size: 3.906vw;
    }

    #edit-profile {
        padding: 1.302vw;
        left: -10.854vw;
        transition: 0.5s;
        margin-top: 3.906vw;
        box-shadow: rgb(100 100 111 / 20%) 0vw 0.911vw 3.776vw 0vw;
        border-radius: 2.604vw;
    }

    .error {
        color: red;
        margin-bottom: 0.651vw;
        font-size: 2.693vw;
    }

    .edit-ttl {
        font-size: 3.906vw;
    }


    #password-change {
    max-width: 40.104vw;
    transition: 0.5s;
    left: -9.167vw;
    margin-top: 7.813vw;
    padding: 1.302vw;
    box-shadow: rgb(100 100 111 / 20%) 0vw 0.911vw 3.776vw 0vw;
    border-radius: 2.604vw;
    }

    .x {
        position: absolute;
        right: -1.042vw;
        top: -1.172vw;
        padding: 0.781vw;
    }



    .x {
        position: absolute;
        right: -1.042vw;
        top: -1.172vw;
        padding: 0.781vw;
    }

    .profile-left-side {
        float: none;
        width: 100%;
    }

    .pf-left-side {
        display: flex;
        float: left;
        align-items: center;
        width: 50%;
        margin-bottom: 20px;
    }

    .pfl-profile {
        width: 45px;
        height: 45px;
        margin-right: 5px;
        border-radius: 50%;
    }

    .pf-left-side h2 {
        margin-top: 3px;
        margin-left: 5px;
        font-size: 25px;
        font-weight: bold;
    }

    .pf-right-side {
        float: right;
        width: 44%;
    }

    .pf-right-side a {
        display: inline-block;
        padding: 5px 15px;
        background-color: #d3d3d3;
        color: #fff;
        font-size: 13px;
        border-radius: 20px;
    }

    .pls-content h2 {
        margin-bottom: 15px;
        padding-bottom: 11px;
        color: var(--title);
        font-size: 24px;
        border-bottom: 2px solid #f7f7f7;
    }

    .pls-email {
        margin-bottom: 20px;
    }

    .pls-email h3 {
        margin-bottom: 10px;
        font-size: var(--title-font);
    }

    .pls-email p {
        color: var(--content);
        font-size: 13px;
    }

    .pls-post-count {
        margin-bottom: 25px;
    }

    .pls-post-count h3 {
        margin-bottom: 10px;
        color: var(--title);
        font-size: 15px;
    }

    .pls-post-count p {
        width: fit-content;
        padding: 2px 7px;
        background-color: rgb(212, 212, 212);
        color: #fff;
        font-size: 12px;
        border-radius: 50%;
    }

    .pls-Bio {
        margin-bottom: 30px;
    }

    .pls-Bio h3 {
        margin-bottom: 10px;
        color: var(--title);
        font-size: var(--title-font);
    }

    .pls-Bio p {
        color: var(--content);
        font-size: var(--content-font);
    }

    .pls-myPost {
        margin-bottom: 10px;
    }

    .pls-myPost h2 {
        padding-bottom: 10px;
        color: var(--title);
        font-size: 23px;
        border-bottom: 1px solid rgb(233, 233, 233);
    }

    .pls-myPost p {
        color: var(--content);
        font-size: 15px;
    }

    .pls-myPost p span {
        margin-left: 10px;
        color: var(--content);
        font-size: 12px;
    }

    .prof-left-post {
        float: left;
        width: 70%;
    }

    .prof-left-post h3 {
        margin-bottom: 10px;
        color: #000;
        font-size: 23px;
    }

    .prof-left-post p {
        margin-bottom: 10px;
        color: var(--content);
        font-size: 15px;
    }

    .prof-leftPost-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .prof-leftPost-footer a {
        padding: 5px;
        background: #dfdfdf;
        color: #5c5c5c;
        font-size: 12px;
        border-radius: 10px;
    }

    .leftfo-right {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .leftfo-right i {
        margin-left: 10px;
        color: rgb(202, 201, 201);
    }

    .prof-right-post {
        float: right;
        width: 20%;
    }

    .prof-right-post img {
        width: 100%;
        height: 100px;
    }

    /*right aside */
    .profile-right-side {
        float: none;
        width: 100%;
        height: auto;
        margin-top: 30px;
        border-left: none;
        border-top: 1px solid #dfdfdf;
    }

    .prors-content {
        padding-top: 30px;
        padding-left: 0;
    }

    .profile-right-side h2 {
        margin-bottom: 20px;
        font-size: 30px;
    }

    .prors-post {
        margin-bottom: 25px;
    }

    .prors-head {
        display: flex;
        align-items: center;
    }

    .prors-head img {
        width: 30px;
        height: 30px;
        border-radius: 50%;
    }

    .prors-head p {
        margin-left: 20px;
        font-size: 17px;
        font-weight: bold;
    }

    .prors-title {
        margin-top: 10px;
        font-size: 18px;
    }

    .profile-category a {
        display: inline-block;
        margin-bottom: 10px;
        padding: 5px 10px;
        background-color: #dfdfdf;
        color: #000;
        border-radius: 20px;
    }
}

/*mobile */
/*ipad */
@media screen and (max-width: 640px) {
    :root {
        --content: #7e7e7e;
        --title: #2e2e2e;
        --title-font: 10px;
        --content-font: 13px;
    }

    .category-item p {
        margin: 0.563vw 3.313vw 0.369vw 0;
        padding: 1.05vw 2.125vw;
        font-size: 2.344vw;
        border-radius: 3.125vw;
    }

    #edit-profile {
        padding: 1.302vw;
        left: -15.854vw;
        transition: 0.5s;
        margin-top: 3.906vw;
        box-shadow: rgb(100 100 111 / 20%) 0vw 0.911vw 3.776vw 0vw;
        border-radius: 2.604vw;
    }

    .container {
        width: auto;
        margin: 0 auto;
    }

    .profile-left-side {
        float: none;
        width: 100%;
    }

    .pf-left-side {
        display: flex;
        float: left;
        align-items: center;
        width: 50%;
        margin-bottom: 20px;
    }

    .pfl-profile {
        width: 45px;
        height: 45px;
        margin-right: 5px;
        border-radius: 50%;
    }

    .pf-left-side h2 {
        margin-top: 3px;
        margin-left: 5px;
        font-size: 25px;
        font-weight: bold;
    }

    .pf-right-side {
        float: right;
        width: 43%;
    }

    .pf-right-side a {
        display: inline-block;
        padding: 5px 15px;
        background-color: #d3d3d3;
        color: #fff;
        font-size: 13px;
        border-radius: 20px;
    }

    .pls-content h2 {
        margin-bottom: 15px;
        padding-bottom: 11px;
        color: var(--title);
        font-size: 24px;
        border-bottom: 2px solid #f7f7f7;
    }

    .pls-email {
        margin-bottom: 20px;
    }

    .pls-email h3 {
        margin-bottom: 10px;
        font-size: var(--title-font);
    }

    .pls-email p {
        color: var(--content);
        font-size: 13px;
    }

    .pls-post-count {
        margin-bottom: 25px;
    }

    .pls-post-count h3 {
        margin-bottom: 10px;
        color: var(--title);
        font-size: 15px;
    }

    .pls-post-count p {
        width: fit-content;
        padding: 2px 7px;
        background-color: rgb(212, 212, 212);
        color: #fff;
        font-size: 12px;
        border-radius: 50%;
    }

    .pls-Bio {
        margin-bottom: 30px;
    }

    .pls-Bio h3 {
        margin-bottom: 10px;
        color: var(--title);
        font-size: var(--title-font);
    }

    .pls-Bio p {
        color: var(--content);
        font-size: var(--content-font);
    }

    .pls-myPost {
        margin-bottom: 10px;
    }

    .pls-myPost h2 {
        padding-bottom: 10px;
        color: var(--title);
        font-size: 23px;
        border-bottom: 1px solid rgb(233, 233, 233);
    }

    .pls-myPost p {
        color: var(--content);
        font-size: 15px;
    }

    .pls-myPost p span {
        margin-left: 10px;
        color: var(--content);
        font-size: 10px;
    }

    .prof-left-post {
        float: left;
        width: 70%;
    }

    .prof-left-post h3 {
        margin-bottom: 10px;
        color: #000;
        font-size: 20px;
    }

    .prof-left-post p {
        margin-bottom: 10px;
        color: var(--content);
        font-size: 13px;
    }

    .prof-leftPost-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .prof-leftPost-footer a {
        padding: 5px;
        background: #dfdfdf;
        color: #5c5c5c;
        font-size: 10px;
        border-radius: 10px;
    }

    .leftfo-right {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .leftfo-right i {
        margin-left: 10px;
        color: rgb(202, 201, 201);
    }

    .prof-right-post {
        float: right;
        width: 20%;
    }

    .prof-right-post img {
        width: 100%;
        height: 100px;
    }

    /*right aside */
    .profile-right-side {
        float: none;
        width: 100%;
        height: auto;
        margin-top: 25px;
        border-left: none;
        border-top: 1px solid #dfdfdf;
    }

    .prors-content {
        padding-top: 30px;
        padding-left: 0;
    }

    .profile-right-side h2 {
        margin-bottom: 20px;
        font-size: 25px;
    }

    .prors-post {
        margin-bottom: 25px;
    }

    .prors-head {
        display: flex;
        align-items: center;
    }

    .prors-head img {
        width: 30px;
        height: 30px;
        border-radius: 50%;
    }

    .prors-head p {
        margin-left: 20px;
        font-size: 15px;
        font-weight: bold;
    }

    .prors-title {
        margin-top: 10px;
        font-size: 16px;
    }

    .profile-category a {
        display: inline-block;
        margin-bottom: 10px;
        padding: 5px 10px;
        background-color: #dfdfdf;
        color: #000;
        font-size: 10px;
        border-radius: 20px;
    }
}
</style>