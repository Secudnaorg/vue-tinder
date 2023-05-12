<template>
  <div id="app">
    <div key="1" v-if="ok">

      <Tinder
        ref="tinder"
        key-name="emailId"
        :queue.sync="queue"
        :max="3"
        :offset-y="10"
        allow-down
        @submit="onSubmit"
      >

      <template slot-scope="email">

        <div class="pic">
          
          <div class="left">
            <div class="arrow animated bounce">
              <svg height="18" width="32">
                <polyline
                  points="0,0 16,17 32,0"
                  style="fill:none;stroke:#212121;stroke-width:3"
                />
              </svg>
            </div>
          </div>

          <div class="iframe">
            <iframe
              :src="email.data.emailUrl"
              frameborder="0"
              style="width: 100%;height: 100%;"
              scrolling="no"
            >
            </iframe>
          </div>

          <div class="right">
            <div class="arrow animated bounce">
              <svg height="18" width="32">
                <polyline
                  points="0,0 16,17 32,0"
                  style="fill:none;stroke:#212121;stroke-width:3"
                />
              </svg>
            </div>

          </div>

        </div>
      </template>
      <img class="like-pointer" slot="like" src="~img/like-txt.png" />
      <img class="nope-pointer" slot="nope" src="~img/nope-txt.png" />
      <img class="super-pointer" slot="super" src="~img/super-txt.png" />
      <img class="down-pointer" slot="down" src="~img/down-txt.png" />
      <img class="rewind-pointer" slot="rewind" src="~img/rewind-txt.png" />
    </Tinder>
    <div class="btns">
      <img src="~img/rewind.png" @click="decide('rewind')" />
      <img src="~img/nope.png" @click="decide('nope')" />
      <img src="~img/super-like.png" @click="decide('super')" />
      <img src="~img/like.png" @click="decide('like')" />
      <img src="~img/help.png" @click="decide('help')" />
    </div>
    </div>

    <div v-else style="color: white;">

      <h1>Result list of the Quiz : </h1>

      <div v-for="email in emails" :key="email.id">
        <h3>ID of the email : {{ email.emailId }}</h3>
        <h3>Name of the email : {{ email.emailName }}</h3>
        <h3>Url of the email : {{ email.emailUrl }}</h3>
        <h3>Is that a phishing email ? : {{ email.isPhishing }}</h3> 
        <h3>Your answer : {{ email }}</h3><br><br>
      </div>
    </div>
  </div>
</template>

<script>
import Tinder from '@/components/vue-tinder/Tinder.vue'
import axios from 'axios'
// import source from '@/bing'

export default {
  name: 'App',
  components: { Tinder },
  data: () => ({
    count: 3,
    queue: [],
    emails: [],
    offset: 0,
    history: [],
    ok: true,

  }),

  created() {
    this.mock()
  },
  methods: {

    mock() {
      const list = []

      axios
        .get('mails.json')
        .then(response => {
          for(let i = 0; i < this.count; i++) {
            list.push({
              emailId: response.data[this.offset].id,
              emailName: response.data[this.offset].name,
              emailUrl: response.data[this.offset].url,
              isPhishing: response.data[this.offset].phishing,
              error: response.data[this.offset].error
            })

            this.offset++
          }

          this.queue = this.queue.concat(list);
          this.emails = this.emails.concat(list);

          this.offset = 0;

          this.emails['result'] = 0;
          this.emails['total'] = 0;

        }).catch(error => { console.log(error); });
    },

    onSubmit({ item }) {

      if(this.queue.length == 0){ 
        this.ok = false; 
      }

      // switch(this.movies[this.offset]['user_rating']){
      //   case 'nope':
      //     console.log('nope');
      //     break;

      //   case 'super':
      //     console.log('super');
      //     break;

      //   case 'like':
      //     console.log('like');
      //     break;
      // }

      this.offset++;

    },

    async decide(choice) {
      this.cpt = 0

      if (choice === 'rewind') {
        if (this.history.length) {
          //一个个 rewind
          // this.$refs.tinder.rewind([this.history.pop()])
          // 一次性 rewind 全部
          // this.$refs.tinder.rewind(this.history)
          // this.history = []
          // 一次随机 rewind 多个
          this.$refs.tinder.rewind(
            this.history.splice(-Math.ceil(Math.random()))
          )
          // 非 api调用的添加
          // this.queue.unshift(this.history.pop())
          // this.queue.push(this.history.pop())
          // 非头部添加
          // this.queue.splice(1, 0, this.history.pop())
          // 一次性 rewind 多个，并且含有非头部添加的 item
          // this.queue.unshift(this.history.pop())
          // this.queue.unshift(...this.history)
        }
      } else if (choice === 'help') {
        console.log('tu veux un indice ?')
      } else {

        this.$refs.tinder.decide(choice)

        if(choice === 'like') {
          this.emails[this.offset]['user_rating'] = "like"
          console.log(this.emails[this.offset]);
        } else if(choice === 'nope') {
          this.emails[this.offset]['user_rating'] = "nope"
          console.log(this.emails[this.offset]);
        } else if(choice === 'super') {
          this.emails[this.offset]['user_rating'] = "super"
          console.log(this.emails[this.offset]);
        }
      }
    
    }
  }
}
</script>

<style>
html,
body {
  height: 100%;
}

body {
  margin: 0;
  background-color: #20262e;
  overflow: hidden;
}

#app .vue-tinder {
  position: absolute;
  z-index: 1;
  left: 0;
  right: 0;
  top: 23px;
  margin: auto;
  width: 900px;
  height: calc(100% - 23px - 65px - 47px - 16px);
  min-width: 300px;
  /* max-width: 600px; */
}

.left {
  transform: rotate(90deg);
}

.right {
  transform: rotate(-90deg);
}

.left,
.right {
  display: flex;
  align-items: center;
  width: 150px;
  justify-content: center;
}

.iframe {
  /* background-color: red; */
  border-left: 1px solid #111;
  border-right: 1px solid #111;
  width: 100%;
}

/* Animated arrow */

.bounce {
  -webkit-animation-name: bounce;
  -moz-animation-name: bounce;
  -o-animation-name: bounce;
  animation-name: bounce;
}
.animated {
  -webkit-animation-fill-mode: both;
  -moz-animation-fill-mode: both;
  -ms-animation-fill-mode: both;
  -o-animation-fill-mode: both;

  animation-iteration-count: infinite;
  -moz-animation-iteration-count: infinite;
  -webkit-animation-iteration-count: infinite;

  animation-fill-mode: both;
  -webkit-animation-duration: 2s;
  -moz-animation-duration: 2s;
  -ms-animation-duration: 2s;
  -o-animation-duration: 2s;
  animation-duration: 2s;
}

@keyframes bounce {
  0%,
  20%,
  50%,
  80%,
  100% {
    transform: translateY(0);
  }
  40% {
    transform: translateY(-30px);
  }
  60% {
    transform: translateY(-15px);
  }
}

.nope-pointer,
.like-pointer {
  position: absolute;
  z-index: 1;
  top: 20px;
  width: 64px;
  height: 64px;
}

.nope-pointer {
  right: 10px;
}

.like-pointer {
  left: 10px;
}

.super-pointer,
.down-pointer {
  position: absolute;
  z-index: 1;
  left: 0;
  right: 0;
  margin: auto;
  width: 112px;
  height: 78px;
}

.super-pointer {
  bottom: 40px;
}

.down-pointer {
  top: 40px;
}

.rewind-pointer {
  position: absolute;
  z-index: 1;
  top: 20px;
  right: 10px;
  width: 112px;
  height: 78px;
}

.pic {
  width: 100%;
  height: 100%;
  background-size: cover;
  background-position: center;
  display: flex;
}

.btns {
  position: absolute;
  left: 0;
  right: 0;
  bottom: 30px;
  margin: auto;
  height: 65px;
  display: flex;
  align-items: center;
  justify-content: center;
  min-width: 300px;
  max-width: 355px;
}

.btns img {
  margin-right: 12px;
  box-shadow: 0 4px 9px rgba(0, 0, 0, 0.15);
  border-radius: 50%;
  cursor: pointer;
  -webkit-tap-highlight-color: transparent;
}

.btns img:nth-child(2n + 1) {
  width: 53px;
}

.btns img:nth-child(2n) {
  width: 65px;
}

.btns img:nth-last-child(1) {
  margin-right: 0;
}

/* .vue-tinder.right-end,
.vue-tinder.left-end {
  transform: translateZ(20px);
}
.vue-tinder.right-end .tinder-card:nth-child(1) {
  animation: rightEnd 0.2s ease-in-out;
}
.vue-tinder.left-end .tinder-card:nth-child(1) {
  animation: leftEnd 0.2s ease-in-out;
}
@keyframes leftEnd {
  50% {
    transform: rotateY(8deg);
  }
}
@keyframes rightEnd {
  50% {
    transform: rotateY(-8deg);
  }
} */

@media screen and (max-width: 768px) {
  #app .vue-tinder {
    width: 800px;
  }
}
</style>
