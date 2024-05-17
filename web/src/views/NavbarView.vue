<template>
    <div >
    <header>
        <div class="container">
            <p class="btn-gnavi" @click="showNav">
                <span></span>
                <span></span>
                <span></span>
            </p>
            <div class="header-content">
                <h1 class="logo"><RouterLink to="/" ><img src="../assets/template/logo.png" alt="">Medium</RouterLink>
                </h1>
                <nav id="global-navi">
                    <ul class="menu">
                        <li><a href="#">Write</a></li>
                        <li>
                            <RouterLink to="/login" >Sign In</RouterLink>
                        </li>
                        <li>
                            <RouterLink to="/register" class="get-button">Get start</RouterLink>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </header>
</div>
</template>
<script setup >
import $ from "jquery"
import { RouterLink } from 'vue-router'

//slide navbar
const showNav=()=>{
        var rightVal = 0;
        if ($('.btn-gnavi').hasClass('hb-open')) {
          rightVal = -500;
          $('.btn-gnavi').removeClass('hb-open');
        } else {
          $('.btn-gnavi').addClass('hb-open');
        }
        $('#global-navi').stop().animate({
          top: rightVal
        }, 500);
}

</script>
<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Roboto+Condensed&family=Sofia+Sans+Condensed&display=swap');

.container {
    margin: 0 auto;
    max-width: 1100px;
}

header {
    background-color: #f8ba16;
    border-bottom: 1px solid #181212;
    position: fixed;
    top: 0;
    z-index: 10;
    width: 100%;
}

.get-button {
    margin-top: 0;
    padding: 8px;
    background-color: #000;
    color: #fff;
    border-radius: 20px;
}

.header-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
}

.logo {
    float: left;
    font-size: 30px;
}

.logo img {
    margin-bottom: -10px;
}

a {
    display: block;
    color: #333333;
    text-decoration: none;
}

ul li {
    list-style: none;
    margin-right: 20px;
}

.menu {
    display: flex;
    justify-content: space-around;
    align-items: center;
    margin: 0 auto;
    max-width: 980px;
}


@media screen and (max-width: 768px) {

.container {
    padding: 0 40px;
     width: 100%;
}

header {
    background-color: #f8ba16;
    border-bottom: 1px solid #181212;
    position: fixed;
    top: 0;
    z-index: 10;
    width: 100%;
}

.get-button {
    margin-top: 0;
    padding: 8px;
    background-color: #000;
    color: #fff;
    border-radius: 20px;
}

.header-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
}

.logo {
    float: left;
    font-size: 30px;
}

.logo img {
    margin-bottom: -10px;
}

a {
    display: block;
    color: #333333;
    text-decoration: none;
}

ul li {
    list-style: none;
    margin-right: 20px;
}

.menu {
    display: flex;
    justify-content: space-around;
    align-items: center;
    margin: 0 auto;
    max-width: 980px;
}

}

@media screen and (max-width: 640px) {

    @keyframes active-menu-bar02 {
        100% {
            height: 0;
        }
    }

    .logo {
        float: left;
    }

    .logo img {
        width: 6.25vw;
        height: 6.094vw;
        margin-bottom: -1.563vw;
    }

    header {
        position: fixed;
        top: 0;
        z-index: 2;
        width: 100%;
        background-color: #ffffff;

    }

    .get-button {
        margin-top: 0;
        padding: 1.25vw;
        border-radius: 3.125vw;
    }

    .header-content {
        padding: 0.781vw 0;
    }

    .menu {
        display: block;
        padding: 1.563vw 1.563vw 3.125vw;
    }

    .logo {
        float: left;
        font-size: 4.688vw;
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
        box-shadow: 0 1.25vw 2.813vw 0 rgba(0, 0, 0, 0.3);
        background-color: #ffffff;
        border-radius: 1.563vw;
    }

    header nav ul li {
        width: 100%;
        margin-bottom: 0.781vw;
        background-color: rgb(175 175 175 / 84%);
        border-radius: 1.563vw;
    }

    header nav ul li a {
        margin-bottom: 1.563vw;
        padding: 1.094vw;
        color: #ffffff;
        text-align: center;

    }

    .btn-gnavi,
    .btn-gnavi span {
        display: inline-block;
        box-sizing: border-box;
        transition: all .4s;
    }

    header .btn-gnavi {
        position: fixed;
        top: 2.125vw;
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
        animation: active-menu-bar02 .4s forwards;
    }

    .btn-gnavi.hb-open span:nth-of-type(3) {
        transform: translateY(-3.125vw) rotate(45deg);

    }
}
</style>
