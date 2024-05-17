<template>
  <div class="container">
    <div class="login-form">
      <p class="error-message text-align-center" v-if="error">{{ error }}</p>
      <h2>Login</h2>

      <form @submit.prevent="login">
        <div class="form-group">
          <label for="email">Email</label>
          <input
            type="text"
            id="email"
            name="email"
            v-model="form.email"
            placeholder="Youremail(example@gmail.com)"
          />
          <p class="error-message">
            {{ errors?.email ? errors.email[0] : "" }}
          </p>
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <input
            type="password"
            id="password"
            v-model="form.password"
            name="password"
            placeholder="Password"
          />
          <p class="error-message">
            {{ errors?.password ? errors.password[0] : "" }}
          </p>
        </div>
        <button type="submit" class="login">Login</button>
      </form>
    </div>
  </div>
</template>
<script setup>
import Swal from "sweetalert2";
import { ref, reactive, watchEffect, watch } from "vue";
import axios from "axios";
import { useRouter } from "vue-router";

const router = useRouter();
const form = reactive({
  email: "",
  password: "",
});
const error = ref("");
const errors = ref({});
const Auth = ref("");

//login method
const login = async () => {
  await axios
    .post(`${import.meta.env.VITE_PUBLIC_API_URL}/api/login`, form)
    .then((res) => {
      if (res.data.success) {
        const Toast = Swal.mixin({
          toast: true,
          position: "top-end",
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
          title: "login is successfully",
        });

        localStorage.setItem("token", res.data.token);
        const token = localStorage.getItem("token");
        axios
          .get("http://127.0.0.1:8000/api/user", {
            headers: {
              Authorization: `Bearer ${token}`,
            },
          })
          .then((response) => {
            localStorage.setItem("user", JSON.stringify(response.data));
            localStorage.setItem("auth", true);
            router.push({ name: "home" });
          });
      } else {
        error.value = res.data.message;
      }
    })
    .catch(function (error) {
      errors.value = error.response.data.errors;
    });
};

watchEffect(() => {
  Auth.value = localStorage.getItem("auth");
  console.log(Auth.value);
  if (Auth.value === "true") {
    console.log("hello test");
    localStorage.setItem("auth", false);
    Auth.value = localStorage.getItem("auth");
    location.reload();
  }
});
</script>
<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Roboto+Condensed&family=Sofia+Sans+Condensed&display=swap");

body {
  font-family: "Roboto Condensed", sans-serif;
}

.error-message {
  display: inline-block;
  color: #ff0000;
  font-size: 16px;
  margin: 5px 0;
}

.alert-box {
  text-align: center;
}

.alert-fail {
  padding: 10px 60px;
  display: inline-block;
  margin-top: 75px;
  background: #ff0000;
  color: #fff;
  border-radius: 10px;
}
.text-align-center {
  text-align: center;
  width: 100%;
}

.alert-message {
  padding: 10px 60px;
  display: inline-block;
  margin-top: 75px;
  background: #1fb91f;
  color: #fff;
  border-radius: 10px;
}

.container {
  width: 1100px;
  margin: 0 auto;
}

.login-form {
  margin: 150px;
  padding: 40px;
  margin-top: 140px;
  border-radius: 20px;
  border: 2px solid #cdcdcd;
}

.login-form h2 {
  font-size: 25px;
  margin-bottom: 10px;
}

.form-group {
  margin-bottom: 10px;
}

label {
  display: inline-block;
  font-size: 20px;
  margin-bottom: 5px;
}

::placeholder {
  font-size: 15px;
  color: #cdcdcd;
}

input {
  width: 100%;
  padding: 10px 10px;
  border-radius: 10px;
  outline: none;
  border: 1px solid #cdcdcd;
}

.login {
  padding: 10px 20px;
  font-size: 15px;
  border-radius: 10px;
  border: none;
  color: #fff;
  background-color: #808080;
}

@media screen and (max-width: 768px) {
  .container {
    width: auto;
    padding: 5.208vw;
  }

  .login-form {
    margin: 19.531vw 0;
    padding: 5.208vw;
    margin-top: 9.115vw;
    border-radius: 2.344vw;
    border: 0.26vw solid #cdcdcd;
  }

  .login-form h2 {
    font-size: 2.995vw;
    margin-bottom: 1.042vw;
  }

  .form-group {
    margin-bottom: 1.042vw;
  }

  label {
    display: inline-block;
    font-size: 2.344vw;
    margin-bottom: 0.391vw;
  }

  ::placeholder {
    font-size: 1.563vw;
  }

  input {
    width: 100%;
    padding: 1.042vw 1.042vw;
    border-radius: 1.042vw;
    border: 0.13vw solid #cdcdcd;
  }

  .login {
    padding: 1.042vw 2.344vw;
    font-size: 1.563vw;
    border-radius: 1.042vw;
  }
}

/* mobile  */
@media screen and (max-width: 640px) {
  .container {
    width: auto;
    padding: 0 30px;
  }

  .login-form {
    margin: 18.75vw 0;
    padding: 4.688vw;
    margin-top: 20.625vw;
    border-radius: 2.5vw;
    border: 0.313vw solid #cdcdcd;
  }

  .error-message {
    display: inline-block;
    color: #ff0000;
    font-size: 2.5vw;
    margin: 0.781vw 0;
  }

  .login-form h2 {
    font-size: 3.125vw;
    margin-bottom: 0.938vw;
  }

  .form-group {
    margin-bottom: 0.938vw;
  }

  label {
    display: inline-block;
    font-size: 2.5vw;
    margin-bottom: 0.313vw;
  }

  ::placeholder {
    font-size: 1.563vw;
  }

  input {
    width: 100%;
    height: 4vw;
    padding: 0.938vw 0.938vw;
    border-radius: 0.938vw;
    border: 0.156vw solid #cdcdcd;
  }

  .login {
    padding: 0.938vw 2.5vw;
    font-size: 1.563vw;
    border-radius: 0.938vw;
  }

  .alert-message {
    padding: 1.563vw 9.375vw;
    margin-top: 11.719vw;
    border-radius: 1.563vw;
  }

  .alert-fail {
    padding: 1.563vw 9.375vw;
    margin-top: 11.719vw;
    border-radius: 1.563vw;
  }
}
</style>
