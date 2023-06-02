<template>
    <div class="game">

        <div key="1" v-if="ok">
            <template>
                <div class="modal" v-if="isModalOpen">
                    <div class="modal-content">
                        <span class="close" @click="closeModal">&times;</span>
                        <img src="../assets/tips_icon.png" alt="" width="100px" style="border-radius: 50%;">
                        <p>
                            to spot phishing emails and avoid fraud attempts, please follow this advice :
                        </p>
                        <p style="font-style: italic;">
                            {{ emails[offset].tips }}</p>
                    </div>
                </div>
                <!-- 
          <div class="modal" v-if="isModalOpen">
            <div class="modal-content">
              <span class="close" @click="closeModal">&times;</span>
              <h2>Mon Modal</h2>
              <p>Contenu du modal...</p>
            </div>
          </div>
         -->
            </template>
            <Tinder ref="tinder" key-name="emailId" :queue.sync="queue" :max="3" :offset-y="10" allow-down
                @submit="onSubmit">
                <template slot-scope="email">
                    <div class="pic">

                        <div class="left">

                            <div class="arrow animated bounce">
                                <svg height="18" width="32">
                                    <polyline points="0,0 16,17 32,0" style="fill:none;stroke:#212121;stroke-width:3" />
                                </svg>
                            </div>

                        </div>

                        <div class="iframe">

                            <iframe class="iframeCart" :src="email.data.emailUrl" frameborder="0"
                                style="width: 100%;height: 100%;" scrolling="yes">
                            </iframe>

                        </div>

                        <div class="right">

                            <div class="arrow animated bounce">
                                <svg height="18" width="32">
                                    <polyline points="0,0 16,17 32,0" style="fill:none;stroke:#212121;stroke-width:3" />
                                </svg>
                            </div>

                        </div>

                    </div>
                </template>

                <img class="like-pointer" slot="like" src="../assets/like-txt.png" />
                <img class="nope-pointer" slot="nope" src="../assets/nope-txt.png" />
                <img class="super-pointer" slot="super" src="~img/super-txt.png" />
                <img class="down-pointer" slot="down" src="~img/down-txt.png" />
                <img class="rewind-pointer" slot="rewind" src="../assets/super-txt.png" />

            </Tinder>

            <div class="btns">

                <img src="~img/rewind.png" @click="decide('rewind')" />
                <img src="~img/nope.png" @click="decide('nope')" />
                <img src="~img/like.png" @click="decide('like')" />
                <img src="~img/help.png" @click="decide('help')" />

            </div>

            <div class="progress-bar">
                <div class="progress-bar-fill" :style="fillStyle"></div>
            </div>

        </div>

        <!-- <div v-else>

            <Results :emails="emails" />

        </div> -->

    </div>
</template>

<script>

import Tinder from '@/components/vue-tinder/Tinder.vue'
import axios from 'axios'
import Results from './Results.vue'
import { ok } from 'assert'


// import source from '@/bing'

export default {
    name: 'App',
    components: { Tinder, Results },
    data: () => ({
        JSONPath: 'mails.json',
        count: 0, // var utiliser pour stocker la tailler du tableau data quand on récupère les données du fichier JSON
        queue: [],
        emails: [],
        offset: 0, // cmpt globale
        history: [],
        ok: true, // bool pour afficher les resultats du quiz
        progressBarWidth: 0,
        isModalOpen: false
    }),

    
    computed: {
        fillStyle() {
            return `width: ${this.progressBarWidth}%`;
        },
    },

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

                    for (let i = 0; i < this.count; i++) {
                        list.push({
                            emailId: response.data[this.offset].id,
                            emailName: response.data[this.offset].name,
                            emailUrl: response.data[this.offset].url,
                            isPhishing: response.data[this.offset].phishing,
                            error: response.data[this.offset].error,
                            tips: response.data[this.offset].tips
                        })

                        this.offset++

                    }

                    this.queue = this.queue.concat(list)
                    this.emails = this.emails.concat(list)

                    this.emails['result'] = 0

                    this.offset = 0

                    console.log(this.emails.length);

                }).catch(error => { console.log(error); })
        },

        /**
         * Permet de gérer la soumission de l'item afficher sur le composant Tinder
         * 
         * @param {*} item : le mail en tête de liste 
         */
        onSubmit(item) {
            this.emails[this.offset]['user_rating'] = item['type'] // ajoute le choix de l'utilisateur à l'item de la liste

            if (this.emails[this.offset].user_rating === 'super') { this.emails[this.offset].user_rating = this.randRating() }

            /*
            Pour chaque bonne réponses ajoute +1 au resultat
            */
            if (this.emails[this.offset].isPhishing === true && this.emails[this.offset].user_rating === 'like' || this.emails[this.offset].isPhishing === false && this.emails[this.offset].user_rating === 'nope') {
                this.emails['result']++
            }

            this.emails[this.emails.length - 1]['resultat'] = this.emails['result']

            this.history.push(item.item)

            this.offset++

            // Mettez à jour la barre de progression
            const progressStep = this.emails.length * 10;
            this.progressBarWidth += progressStep;

            /*
            Permet d'afficher les resultats si la queue est vide
            */
            if (this.queue.length === 0) {
                // this.ok = false

                this.$router.push({ path: 'results', query: { emails: this.emails } });
            }
        },

        showModal() {
            this.isModalOpen = true;
        },
        closeModal() {
            this.isModalOpen = false;
        },

        /**
            Choisit aléatoirement un des strings entre : like et nope
        */
        randRating() {
            const rating = Math.floor(Math.random() * 2) === 0
            return rating ? "like" : "nope"
        },

        /**
         * Permet de calculer le resultat du quiz
         */
        getResult() {
            const result = 0

            this.emails.forEach(email => {

                if (email.isPhishing === true && email.user_rating === 'like' || email.isPhishing === false && email.user_rating === 'nope') {
                    console.log(email);
                    result++
                    console.log(result);
                }

            });
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
                    const progressStep = this.emails.length * 10;
                    this.progressBarWidth -= progressStep;
                    console.log(this.emails.length);
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
                console.log('veux tu un indice?');

                this.showModal()
            } else {
                this.$refs.tinder.decide(choice)
            }

        }
    },

}
</script>

<style>
* {
    /* margin: 0;
    padding: 0; */
}

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



/* .result {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.result .content {
  text-align: center;
} */

.bars {
    position: absolute;
    bottom: -0;
    left: 50%;
    transform: translate(-50%, -50%);
    height: 10px;
    width: 50%;
    /* background-color: red; */
    border: 1px solid #111;

}

@media screen and (max-width: 768px) {
    #app .vue-tinder {
        width: 800px;
    }
}

.progress-bar {
    /* width: 100%;
  height: 20px; */
    background-color: #ccc;

    position: absolute;
    bottom: -0;
    left: 50%;
    transform: translate(-50%, -50%);
    height: 10px;
    width: 50%;
    /* background-color: red; */
}

.progress-bar-fill {
    height: 100%;
    background: linear-gradient(135deg, #FF6B6B, #FF8989);
    transition: width 0.5s ease-in-out;
}


/* /////////////////////////////////////////////// */

.modal {
    z-index: 999;
    background-color: #fff;
    box-shadow: rgba(99, 99, 99, 0.2) 0px 2px 8px 0px;
    text-align: center;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
}

.modal-content {
    position: relative;
    padding: 20px;
}

.close {
    position: absolute;
    top: 0;
    right: 10px;
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}



/* 

.modal {
  display: none;
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
  background-color: #fefefe;
  margin: 15% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
  cursor: pointer;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

*/

@media screen and (max-width: 850px) {
    #app .vue-tinder {
        /* display: none; */
        width: 600px;
    }
}
</style>
