<template>
    <div class="">
        <header>
            <div>
                <p class="btn-gnavi" @click="showNav">
                    <span></span>
                    <span></span>
                    <span></span>
                </p>
                <div class="login-header">
                    <div class="lright-menu">
                        <div class="login-hright">
                            <h1>
                                <RouterLink to="/"><img src="../assets/template/logo.png" alt="" />
                                </RouterLink>
                            </h1>
                            <div class="input-group">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                    <path fill-rule="evenodd" clip-rule="evenodd"
                                        d="M4.1 11.06a6.95 6.95 0 1 1 13.9 0 6.95 6.95 0 0 1-13.9 0zm6.94-8.05a8.05 8.05 0 1 0 5.13 14.26l3.75 3.75a.56.56 0 1 0 .8-.79l-3.74-3.73A8.05 8.05 0 0 0 11.04 3v.01z"
                                        fill="currentColor"></path>
                                </svg>
                                <form @submit.prevent="postSearch" method="get" class="search-form">
                                    <input type="text" class="search" placeholder="Search Medium" v-model="searchVal" />
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="left-aside">
                        <nav id="global-navi">
                            <ul class="menu">
                                <router-link to="/post/create">
                                    <li class="left-write">
                                        <a href="{{ route('post.create') }}" class="write-link">
                                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                aria-label="Write">
                                                <path
                                                    d="M14 4a.5.5 0 0 0 0-1v1zm7 6a.5.5 0 0 0-1 0h1zm-7-7H4v1h10V3zM3 4v16h1V4H3zm1 17h16v-1H4v1zm17-1V10h-1v10h1zm-1 1a1 1 0 0 0 1-1h-1v1zM3 20a1 1 0 0 0 1 1v-1H3zM4 3a1 1 0 0 0-1 1h1V3z"
                                                    fill="currentColor"></path>
                                                <path
                                                    d="M17.5 4.5l-8.46 8.46a.25.25 0 0 0-.06.1l-.82 2.47c-.07.2.12.38.31.31l2.47-.82a.25.25 0 0 0 .1-.06L19.5 6.5m-2-2l2.32-2.32c.1-.1.26-.1.36 0l1.64 1.64c.1.1.1.26 0 .36L19.5 6.5m-2-2l2 2"
                                                    stroke="currentColor"></path>
                                            </svg><span>Write</span></a>
                                    </li>
                                </router-link>

                                <li class="menu-toggle" @click="slideBoard">
                                    <div class="select-box">
                                        <div class="small-menu">
                                            <!-- <eimg :src="url + user.profile" alt="" /> -->
                                            <p class="down-icon">
                                                <svg width="12px" height="12px" viewBox="0 0 15 15">
                                                    <path
                                                        d="M3.85 5.15a.5.5 0 0 0-.7.7l4.35 4.36 4.35-4.36a.5.5 0 1 0-.7-.7L7.5 8.79 3.85 5.15z"
                                                        fill-rule="evenodd"></path>
                                                </svg>
                                            </p>
                                        </div>
                                    </div>
                                </li>
                                <div class="custom-dashboard">
                                    <p>
                                        <!-- <router-link :to="{ name: 'profile', params: { id: user?.id } }"
                                            @click="customBoard = false"><svg width="24" height="24" viewBox="0 0 24 24"
                                                fill="none" aria-label="Profile">
                                                <circle cx="12" cy="7" r="4.5" stroke="currentColor"></circle>
                                                <path d="M3.5 21.5v-4.34C3.5 15.4 7.3 14 12 14s8.5 1.41 8.5 3.16v4.34"
                                                    stroke="currentColor" stroke-linecap="round"></path>
                                            </svg>
                                            profile</router-link> -->
                                    </p>
                                    <p>
                                        <router-link to="/"><svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                aria-label="Lists">
                                                <path
                                                    d="M6.44 6.69h0a1.5 1.5 0 0 1 1.06-.44h9c.4 0 .78.16 1.06.44l.35-.35-.35.35c.28.28.44.66.44 1.06v14l-5.7-4.4-.3-.23-.3.23-5.7 4.4v-14c0-.4.16-.78.44-1.06z"
                                                    stroke="currentColor"></path>
                                                <path d="M12.5 2.75h-8a2 2 0 0 0-2 2v11.5" stroke="currentColor"
                                                    stroke-linecap="round"></path>
                                            </svg>post list</router-link>
                                    </p>

                                    <p class="custom-logout">
                                        <svg width="28" height="29" viewBox="0 0 28 29" fill="none" class="ih y">
                                            <path fill="#fff" d="M0 .8h28v28H0z"></path>
                                            <g opacity="0.8" clip-path="url(#trending_svg__clip0)">
                                                <path fill="#fff" d="M4 4.8h20v20H4z"></path>
                                                <circle cx="14" cy="14.79" r="9.5" stroke="#000"></circle>
                                                <path
                                                    d="M5.46 18.36l4.47-4.48M9.97 13.87l3.67 3.66M13.67 17.53l5.1-5.09M16.62 11.6h3M19.62 11.6v3"
                                                    stroke="#000" stroke-linecap="round"></path>
                                            </g>
                                            <defs>
                                                <clipPath id="trending_svg__clip0">
                                                    <path fill="#fff" transform="translate(4 4.8)" d="M0 0h20v20H0z">
                                                    </path>
                                                </clipPath>
                                            </defs>
                                        </svg>
                                        <button @click="logout">logout</button>
                                    </p>
                                </div>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </header>
    </div>
</template>

<script setup>
import { ref, watchEffect } from "vue";
import { useRouter } from "vue-router";
import $ from "jquery";
import axios from "axios";

const router = useRouter();
const searchVal = ref();
const customBoard = ref(false);
const user = ref();
const btnGnavi = ref();
const url = ref(import.meta.env.VITE_BASE_URL);

watchEffect(() => {
    const user = JSON.parse(localStorage.getItem("user"));
    const token=user.token
    // axios
    //     .get(`${import.meta.env.VITE_PUBLIC_API_URL}/user/${user.id}`, {
    //         headers: {
    //             Authorization: `${token}`,
    //         },
    //     })
    //     .then((response) => {
    //         localStorage.setItem("user", JSON.stringify(response.data));
    //     });
    user.value = JSON.parse(localStorage.getItem("user")) ?? '';
});

//slide custom board
const slideBoard = () => {
    $(".custom-dashboard").slideToggle();
};

//search post
const postSearch = () => {
    if (searchVal.value.trim() !== "") {
        router.push({ name: "home", query: { q: searchVal.value } });
        searchVal.value = "";
    } else {
        router.push({ name: "home" });
    }
};

//logout

const logout = async () => {
    const user =JSON.parse(localStorage.getItem('user'));
    console.log(user)
    await axios.delete(`${import.meta.env.VITE_PUBLIC_API_URL}/auth/logout/${user.id}`,
       {
        headers: {
           'Authorization': user.token
        }
    }
    ).then(response=>{
      console.log('response',response)
      localStorage.removeItem("token");
      localStorage.removeItem("user");
      localStorage.setItem("auth", false);
      router.push({ name: "login" });
    }).catch(error =>{
     console.error(error)
    })
};

//show Navbar
const showNav = () => {
    var rightVal = 0;
    if ($(".btn-gnavi").hasClass("hb-open")) {
        rightVal = -500;
        $(".btn-gnavi").removeClass("hb-open");
    } else {
        $(".btn-gnavi").addClass("hb-open");
    }
    $("#global-navi").stop().animate(
        {
            top: rightVal,
        },
        500
    );
};
</script>

<style scoped>
/* custom select with image  */

svg {
    color: rgba(117, 117, 117, 1) !important;
    margin-right: 3px;
}

h1 {
    margin-top: 3px;
}

.write-link {
    display: flex;
    align-items: center;
}

/* custom select    */
header {
    height: 60px !important;
    line-height: 60px !important;
    position: fixed;
    width: 100%;
    z-index: 3;
    top: 0;
    margin-bottom: 40px !important;
    background-color: #ffffff;
    border-bottom: 1px solid #bcbcbc;
}

select option .gugu {
    color: red;
}

.login-bg {
    background-color: #ffffff !important;
    border-bottom: 1px solid #272020 !important;
}

.login-hright {
    display: flex !important;
    align-items: center !important;
}

.search-form {
    display: flex;
}

.custom-dashboard {
    position: absolute !important;
    right: 0px !important;
    width: 100% !important;
    overflow: hidden !important;
    top: 53px;
    border-radius: 3px;
}

.small-menu {
    display: flex !important;
    align-items: center !important;
}

.custom-dashboard p {
    height: 50px !important;
    padding: -10px !important;
    padding: 0 10px !important;
    font-size: 14px !important;
}

.login-hright h1 a img {
    width: 30px !important;
    height: 30px !important;
    border-radius: 50% !important;
}

.input-group {
    align-items: center;
    display: flex !important;
    height: 32px !important;
    overflow: hidden !important;
    margin-left: 10px !important;
    padding: 7px !important;
    border: 1px solid rgb(237, 237, 237) !important;
    background-color: #ebebeb !important;
    border-radius: 20px !important;
}

.input-group i {
    margin: 10px;
}

.language-change {
    margin-right: 10px;
    margin-top: 3px;
}

.language-img {
    display: flex;
    align-items: center;
}

.language-img img {
    margin-right: 10px;
}

.input-group .search {
    border: none !important;
    background-color: #ebebeb !important;
    outline: none !important;
    margin-bottom: 0 !important;
}

.login-header {
    display: flex !important;
    justify-content: space-between !important;
    align-items: center;
    padding: 0 30px;
}

ul li a {
    color: #0c0b0b;
    margin-right: 10px;
}

.custom-logout button {
    border: none;
    background: transparent;
    color: rgb(177, 27, 27);
    font-weight: bold;
}

.custom-logout svg {
    color: red;
}

.custom-dashboard {
    background: rgb(255, 251, 251);
    position: absolute !important;
    right: 6px !important;
    width: auto !important;
    box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
    overflow: hidden !important;
    top: 43px;
    display: none;
    border-radius: 3px;
}

.down-icon {
    padding: 0px;
    font-size: 13px;
}

.down-icon i {
    color: rgb(163, 163, 163);
}

.custom-dashboard p {
    display: flex;
    height: 40px;
    align-items: center;
    line-height: 3;
    padding: 3px 23px 0px 10px !important;
    border-bottom: 1px solid #8d8d8d;
}

.custom-dashboard p svg {
    margin: 0px 5px -5px 5px;
}

a {
    display: block;
    color: #333333;
    text-decoration: none;
}

.select-box {
    display: flex;
    height: 100%;
    align-items: center;
}

.select-box img {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    margin-right: 5px;
}

header nav {
    z-index: 1;
}

.sign-black {
    padding: 5px 10px;
    border-radius: 20px;
    color: #fff;
    line-height: 2;
    margin-top: 10px;
    background-color: #050505;
}

.left-write {
    margin-right: 10px;
}

.left-write a span {
    font-size: 18px;
}

ul li {
    width: auto;
    list-style: none;
}

.select-box {
    justify-content: center;
    position: relative;
}

.menu {
    display: flex;
    justify-content: space-around;
    margin: 0 auto;
    max-width: 980px;
}

/* left_aside */
.left-aside {
    display: flex;
    align-items: center;
}

.left-aside select {
    margin-right: 10px;
    padding: 5px;
    margin-top: 2px;
    border: 1px solid #bcbcbc;
    border-radius: 5px;
    outline: none;
}

@media screen and (max-width: 640px) {
    @keyframes active-menu-bar02 {
        100% {
            height: 0;
        }
    }

    .login-hright {
        margin-top: -0.456vw;
    }

    .language-change {
        margin-top: -0.656vw !important;
    }

    .logo {
        margin-top: -2.344vw;
    }

    header {
        background-color: #ffffff;
        margin-top: 0vw;
        position: fixed;
        top: 0;
        z-index: 2;
        width: 100%;
    }

    .input-group {
        display: flex;
        height: 5vw;
        overflow: hidden;
        margin-left: 1.563vw;
        padding: 0;
        border: 0.156vw solid rgb(237, 237, 237);
        background-color: #ebebeb;
        border-radius: 3.125vw;
    }

    .input-group i {
        margin: 0.938vw;
    }

    .input-group .search {
        border: none;
        background-color: #ebebeb;
        outline: none;
    }

    .menu {
        display: block;

        padding: 1.563vw 1.563vw 3.125vw;
    }

    .login-hright h1 a img {
        width: 4.688vw;
        height: 4.688vw;
        border-radius: 50%;
    }

    .select-box {
        width: 100%;
    }

    /**レスポンシブにした時のナビの見せ方**/
    header nav {
        position: fixed;
        top: -78.125vw;
        right: 0vw;
        z-index: 1;
        width: 100%;
        height: auto;
        padding-top: 9.375vw;
        border-radius: 1.563vw;
        box-shadow: 0 1.25vw 2.813vw 0 rgba(0, 0, 0, 0.3);
        background-color: #ffffff;
    }

    header nav ul li {
        width: 100%;
        border-bottom: 1px solid rgb(132, 132, 132);
        margin-bottom: 0.781vw;
    }

    header nav ul li a {
        color: #363636;
        align-items: center;
        text-align: center;
        justify-content: center;
        height: 33px;
        line-height: 1.8;
    }

    .btn-gnavi {
        margin: 0 !important;
    }

    .btn-gnavi,
    .btn-gnavi span {
        display: inline-block;
        box-sizing: border-box;
        transition: all 0.4s;
    }

    .custom-dashboard p {
        /* display: block; */
        height: auto;
        padding: -10px;
        padding: 0 10px;
        text-align: center;
    }

    header .btn-gnavi {
        position: fixed;
        top: 3.125vw;
        right: 3.125vw;
        z-index: 3;
        width: 4.688vw;
        height: 3.75vw;
        border: none;
        background: none;
        cursor: pointer;
        transition: all 400ms;
        -webkit-transition: all 400ms;
        appearance: none;
    }

    header .btn-gnavi span {
        position: absolute;
        left: 0;
        width: 4.688vw;
        height: 0.625vw;
        background: #666;
        -webkit-transition: all 400ms;
        transition: all 400ms;
        border-radius: 1.563vw;
    }

    .language-change {
        margin-right: 26px;
        margin-top: 13px;
    }

    .custom-dashboard {
        right: 0 !important;
        width: 100% !important;
        top: 22.156vw;
        border-radius: 0.469vw;
    }

    header .btn-gnavi span:nth-child(1) {
        top: 0vw;
    }

    header .btn-gnavi span:nth-child(2) {
        top: 1.563vw;
    }

    header .btn-gnavi span:nth-child(3) {
        bottom: 0;
    }

    .btn-gnavi.hb-open {
        margin-top: 2.344vw;
    }

    .btn-gnavi.hb-open span {
        background-color: #040000;
    }

    .btn-gnavi.hb-open span:nth-of-type(1) {
        transform: rotate(-45deg);
    }

    .btn-gnavi.hb-open span:nth-of-type(2) {
        animation: active-menu-bar02 0.4s forwards;
    }

    .btn-gnavi.hb-open span:nth-of-type(3) {
        transform: translateY(-3.125vw) rotate(45deg);
    }
}
</style>
