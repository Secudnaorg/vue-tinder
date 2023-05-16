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
              class="iframeCart"
              :src="email.data.emailUrl"
              frameborder="0"
              style="width: 100%;height: 100%;"
              scrolling="yes"
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
      <img class="like-pointer" slot="like" src="./assets/like-txt.png" />
      <img class="nope-pointer" slot="nope" src="./assets/nope-txt.png" />
      <img class="super-pointer" slot="super" src="~img/super-txt.png" />
      <img class="down-pointer" slot="down" src="~img/down-txt.png" />
      <img class="rewind-pointer" slot="rewind" src="./assets/super-txt.png" />
    </Tinder>

    <div class="btns">
      <img src="~img/rewind.png" @click="decide('rewind')" />
      <img src="~img/nope.png" @click="decide('nope')" />
      <img src="~img/super-like.png" @click="decide('super')" />
      <img src="~img/like.png" @click="decide('like')" />
      <img src="~img/help.png" @click="decide('help')" />
    </div>
    </div>

    <div v-else>

      <Result :emails = "emails" />

      <!-- 
        <h1>Result list of the Quiz : </h1>

        <div v-for="email in emails" :key="email.id">

          <div class="iframe">
            <img src="./assets/email.png" alt="" width="500px">
          </div>
          
          <div class="content">
            <h3>ID of the email : {{ email.emailId }}</h3>
            <h3>Name of the email : {{ email.emailName }}</h3>
            <h3>Url of the email : {{ email.emailUrl }}</h3>
            <h3>Is that a phishing email ? : {{ email.isPhishing }}</h3> 
            <h3>Your answer : {{ email.user_rating }}</h3>
            <h3 
              v-if="email.user_rating === 'like' && email.isPhishing === false || email.user_rating === 'nope' && email.isPhishing === true"
            >
              Votre réponse est fausse, la véritable réponse est : {{ email.isPhishing }}
            </h3>

            <hr>

            <br><br><br>

          </div>

        </div>

      -->

    </div>

  </div>
</template>

<script>
import Tinder from '@/components/vue-tinder/Tinder.vue'
import axios from 'axios'
import Result from './components/Result/Result.vue'
// import source from '@/bing'

export default {
  name: 'App',
  components: { Tinder, Result },
  data: () => ({
    JSONPath: 'mails.json',
    count: 0, // var utiliser pour stocker la tailler du tableau data quand on récupère les données du fichier JSON
    queue: [],
    emails: [],
    offset: 0, // cmpt globale
    history: [],
    ok: true // bool pour afficher les resultats du quiz
  }),

  created() {
    this.mock()
  },
  methods: {
    
    /**
     * Permet de récupérer les données d'un fichier JSON et de les ajoutés à une liste 
     */
    mock() {
      const list = []

      axios
        .get(this.JSONPath)
        .then(response => {

          this.count = response.data.length;

          for(let i = 0; i < this.count; i++) {
            list.push({
              emailId: response.data[this.offset].id,
              emailName: response.data[this.offset].name,
              emailUrl: response.data[this.offset].url,
              isPhishing: response.data[this.offset].phishing,
              error: response.data[this.offset].error,
            })

            this.offset++
            
          }

          this.queue = this.queue.concat(list)
          this.emails = this.emails.concat(list)

          this.offset = 0

      }).catch(error => { console.log(error); })
    },

    /**
     * Permet de gérer la soumission de l'item afficher sur le composant Tinder
     * 
     * @param {*} item : le mail en tête de liste 
     */
    onSubmit(item) {

      /*
        Permet d'afficher les resultats si la queue est vide
      */
      if(this.queue.length === 0){ 
        this.ok = false; 
      }

      this.emails[this.offset]['user_rating'] = item['type'] // ajoute le choix de l'utilisateur à l'item de la liste

      if(this.emails[this.offset].user_rating === 'super') { this.emails[this.offset].user_rating = this.randRating() }

      this.history.push(item.item)

      this.offset++
    },

    /**
      Choisit aléatoirement un des strings entre : like et nope
    */
    randRating() {
      const rating = Math.floor(Math.random() * 2) === 0
      return rating ? "like" : "nope"
    },

    /**
     * Permet de gérer le choix de l'utilisateur 
     * Ajoute le choix de l'utilisateur à la liste des emails
     * 
     * @param {*} choice : le choix de l'utilisateur
     */
    async decide(choice) {

      if (choice === 'rewind') {

        if (this.history.length) {
          this.$refs.tinder.rewind(this.history.splice(-Math.ceil(Math.random()))) // rewind la queue des emails afficher de 1
        }

        /* Métode rewind de base

          // Si l'historique n'est pas vide alors on reviens sur le mail précédent
          if (this.history.length) {
            //一个个 rewind
            // this.$refs.tinder.rewind([this.history.pop()])
            // 一次性 rewind 全部
            // this.$refs.tinder.rewind(this.history)
            // this.history = []
            // 一次随机 rewind 多个
            this.$refs.tinder.rewind(
              this.history.splice(-Math.ceil(Math.random() * 3 ))
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

        */

      } else if (choice === 'help') {
        console.log('tu veux un indice ?')
      } else {
        this.$refs.tinder.decide(choice)
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
  background-color: #fff;
  overflow: auto;
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

.result {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.result .content {
  text-align: center;
}

@media screen and (max-width: 768px) {
  #app .vue-tinder {
    width: 800px;
  }
}
</style>
