<template>
    <div class="container">
        <div class="login-whole">
            <h2>Sign Up</h2>
            <form @submit.prevent="register" method="POST">
                <div class="input-group">
                    <div class="left-form">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" id="name" name="name" placeholder="Your Name" v-model="form.name">
                            <p class="error-message">{{ errors?.name ? errors.name[0] : '' }}</p>
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" v-model="form.password"
                                placeholder="Password">
                            <p class="error-message">{{ errors?.password ? errors.password[0] : '' }}</p>
                        </div>
                    </div>

                    <div class="right-form">
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="text" id="email" name="email" v-model="form.email"
                                placeholder="Your Email(example@gmail.com">
                            <p class="error-message">{{ errors?.email ? errors.email[0] : '' }}</p>
                        </div>
                        <div class="form-group">
                            <label for="password">Confirm Password</label>
                            <input type="password" id="confirmpassword" v-model="form.confirm_password"
                                name="confirm_password" placeholder="Confirm Password">
                            <p class="error-message">{{ errors?.confirm_password ? errors.confirm_password[0] : '' }}</p>
                        </div>
                    </div>
                </div>
                <div class="bio-input">
                    <label for="bio">Bio</label>
                    <input type="text" placeholder="Your bio" id="bio" name="bio" v-model="form.bio">
                    <p class="error-message">{{ errors?.bio ? errors.bio[0] : '' }}</p>
                </div>
                <button type="submit" class="signUp">SignUP</button>
            </form>
        </div>
    </div>
</template>
<script setup>

import { ref, reactive } from 'vue'
import axios from 'axios'
import { useRouter } from "vue-router";
const router = useRouter();

const form = reactive(
    {
        name: '',
        email: '',
        password: '',
        confirm_password: '',
        bio: ''
    });
const errors = ref({})
const error = ref();

//register method
const register = async () => {
    await axios.post('http://127.0.0.1:8000/api/register', form).then(res => {
        console.log(res.data.message.email);

            axios.post('http://127.0.0.1:8000/api/login', res.data.message).then(res => {
                localStorage.setItem('token', res.data.token)
                const token = localStorage.getItem('token');
                axios.get('http://127.0.0.1:8000/api/user', {
                    headers: {
                        Authorization: `Bearer ${token}`
                    }
                }).then((response) => {
                    localStorage.setItem('user', JSON.stringify(response.data));
                    localStorage.setItem('auth', true);
                    router.push({ name: 'home' })
                });

            }).catch(function (error) {
                errors.value = error.response.data.errors;
            });
    
    }).catch(function (error) {
        errors.value = error.response.data.errors;
    });
}

//store current user
const authUser = async () => {

}
</script>
<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Roboto+Condensed&family=Sofia+Sans+Condensed&display=swap');

body {
    font-family: 'Roboto Condensed', sans-serif;
}

.container {
    width: 1100px;
    margin: 0 auto;
}



.contianer {
    width: 1000px;
    margin: 0 aut0;
}

.error-message {
    display: inline-block;
    color: #ff0000;
    font-size: 16px;
    top: 76px;
    margin: 5px 0;
    width: 100%;
    left: 4px;
    position: absolute;
}

.login-whole {
    margin: 80px;
    margin-top: 140px;
    border: 2px solid #cbcbcb;
    border-radius: 20px;
    padding: 30px;
}

.login-whole h2 {
    font-size: 25px;
    margin-bottom: 20px;
    font-weight: bold;
}

.input-group {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.form-group {
    margin-bottom: 34px;
    position: relative;
}

.left-form {
    margin-right: 20px;
    width: 100%;
}

.right-form {
    width: 100%;
}

label {
    font-size: 20px;
    display: inline-block;
    margin-bottom: 10px;
    color: #675858;
}

::placeholder {
    font-size: 13px;
}

input {
    width: 100%;
    padding: 9px;
    outline: none;
    border-color: rgb(124, 124, 124);
    border-radius: 5px;
}

.bio-input {
    margin-bottom: 30px;
    position: relative;
}

.signUp {
    padding: 8px 15px;
    border: none;
    border-radius: 10px;
    color: #fff;
    background-color: #6b6b6b;
}

@media screen and (max-width:768px) {
    .contianer {
        width: auto !important;
        padding: 5.208vw 9 !important;
    }

    .error-message {
        top: 8.203vw;
        margin: 0.651vw 0;
    }

    .login-whole {
        margin: 9.115vw;
        margin-top: 23vw;
        border: 0.26vw solid #cbcbcb;
        border-radius: 2.344vw;
        padding: 3.646vw;
    }

    .login-whole h2 {
        font-size: 2.995vw;
        margin-bottom: 2.344vw;
    }

    .form-group {
        margin-bottom: 4.042vw;
    }

    .left-form {
        margin-right: 2.344vw;
        width: 100%;
    }

    .right-form {
        width: 100%;
    }

    label {
        font-size: 2.344vw;
        margin-bottom: 1.042vw;
    }

    ::placeholder {
        font-size: 1.302vw;
    }

    input {
        width: 100%;
        padding: 0.651vw;
        border-radius: 0.391vw;
    }

    .bio-input {
        margin-bottom: 4.042vw;
    }

    .signUp {
        padding: 0.781vw 1.563vw;
        border-radius: 1.042vw;
    }
}


@media screen and (max-width:640px) {

    .container {
        width: 100%;
        padding: 0 20px;
    }

    .login-whole {
        margin: 3.375vw;
        margin-top: 18.75vw;
        border: 0.313vw solid #cbcbcb;
        border-radius: 2.5vw;
        padding: 4.375vw;
    }

    .login-whole h2 {
        font-size: 3.313vw;
        margin-bottom: 2.5vw;
    }

    .form-group {
        margin-bottom: 2.838vw;
    }

    .left-form {
        margin-right: 2.5vw;
        width: 100%;
    }

    .right-form {
        width: 100%;
    }

    label {
        font-size: 2.5vw;
        margin-bottom: 0.938vw;
    }

    ::placeholder {
        font-size: 1.25vw;
        margin-top: 0.381vw;
    }

    input {
        width: 100%;
        padding: 0.625vw;
        height: 4vw;
        border-radius: 0.469vw;
    }

    .error-message {
        font-size: 1.8vw;
        margin: 4.998px 0;
        top: 8.125vw;
        left: 0.313vw;
    }

    .bio-input {
        margin-bottom: 3.938vw;
    }

    .signUp {
        padding: 0.625vw 1.563vw;
        font-size: 2.344vw;
        border-radius: 0.938vw;
    }
}
</style>
