<template>
  <div>
    <form @submit.prevent="authorizeUser">
      <input v-model="username" placeholder="Username" required />
      <input v-model="password" type="password" placeholder="Password" required />
      <button type="submit">Authorize</button>
    </form>
  </div>


    <div>
    <div class="container text-dark">
      <div class="row justify-content-md-center">
        <div class="col-md-5 p-3 login justify-md-center">
          <h1 class="h3 mb-3 font-weight-normal text-center">Please Sign In</h1>

          <!-- <p v-if="incorrectAuth">Incorrect Username</p> -->
          <form v-on:submit.prevent="authorizeUser">
            <div class="field">
              <label>Username</label>
              <div class="form-group">
                <input
                  type="text"
                  name="username"
                  id="user"
                  v-model="username"
                  class="input"
                />
              </div>
            </div>
            <div class="field">
              <label>Password</label>
              <div class="form-group">
                <input
                  type="password"
                  name="password"
                  id="pass"
                  v-model="password"
                  class="input"
                />
              </div>
            </div>
            <div class="field">
              <div class="form-group">
                <button type="submit" class="">Login</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
import axios from 'axios';

export default {
  data() {
    return {
      username: '',
      password: '',
    };
  },
  computed: {
    email() {
      return this.username ? `${this.username}@gmail.com` : '';
    }
  },
  methods: {
    async authorizeUser() {
      const url = '/api/v1/freeradius/authorize/';
      // const url = '/api/v1/radius/organization/default/account/';
      const token = '5ndQh7KVntJW7F63rsIvb0fUH3EsPE0b'; // Replace with your actual token
      const orgUuid = '4b6049d4-4545-4e9a-a18c-cc845a9acd2b'; // Replace with your actual org-uuid

      if (!this.username || !this.password) {
        console.error('Username and password are required');
        return;
      }

      try {
        const response = await axios.post(
          url,
          new URLSearchParams({
            username: this.username,
            password: this.password,
            // password2: this.password,
            // email: this.email
          }),
          {
            headers: {
              'Authorization': `Bearer ${orgUuid} ${token}`,
              'Content-Type': 'application/x-www-form-urlencoded',
            },
          }
        );
        console.log('Authorization successful:', response.data);
      } catch (error) {
        console.error('Error authorizing user:', error);
      }
    },
  },
};
</script>

<!-- <script>
import { mapActions, mapGetters } from "vuex";

export default {
  data() {
    return {
      username: "",
      password: "",
      type: "OPERATIONS",
      incorrectAuth: false,
    };
  },
  computed: {
    ...mapGetters("auth", {
      loginState: "getLoginState",
    }),
  },
  // created() {
  //     this.actionLogin();
  // },

  methods: {
    ...mapActions("auth", {
      actionLogin: "actionLogin",
    }),

    // ...mapActions(["actionLogin"]),

    async login() {
      console.log(this.username, this.password);

      let config = {
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer 4b6049d4-4545-4e9a-a18c-cc845a9acd2b 5ndQh7KVntJW7F63rsIvb0fUH3EsPE0b",
          "Access-Control-Allow-Origin": "http://localhost:8000/",
        },
      };

      const payload = {
        username: this.username,
        password: this.password,
        type: this.type,
      };
      await this.actionLogin(payload, config);
      if (this.loginState == "success") {
        this.$router.push({ name: "Home" });
      } else {
        this.incorrectAuth = true;
      }
    },
  },
};
</script> -->
