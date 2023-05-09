<template>
  <div id="app">
    <Tinder
      ref="tinder"
      key-name="id"
      :queue.sync="queue"
      :max="3"
      :offset-y="10"
      allow-down
      @submit="onSubmit"
    >
      <template slot-scope="scope">
        <div class="Tinder">
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
              :src="scope.data.iframeUrl"
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
</template>

<script>
import Tinder from '@/components/vue-tinder/Tinder.vue'
import source from '@/bing'

export default {
  name: 'App',
  components: { Tinder },
  data: () => ({
    queue: [
      { id: 1, iframeUrl: 'https://chris-973.github.io/iframe/1.html' },
      { id: 2, iframeUrl: 'https://chris-973.github.io/iframe/2.html' },
      { id: 3, iframeUrl: 'https://chris-973.github.io/iframe/3.html' }
    ],
    offset: 0,
    history: []
  }),
  created() {
    this.mock()
  },
  methods: {
    onSubmit({ /* item */ data }) {
      if (this.queue.length > 0) {
        // Vérifie si la file d'attente est non vide
        const idx = this.queue.findIndex(item => item.id === data.id)

        if (this.queue.length < 3) {
          this.queue.splice(idx, 1) // Supprime l'élément swipé
        }
        this.history.push({
          id: this.queue.length + 1,
          iframeUrl: this.getNextIframeUrl()
        })
      }
    },
    async decide(choice) {
      if (choice === 'rewind') {
        if (this.history.length) {
          //一个个 rewind
          // this.$refs.tinder.rewind([this.history.pop()])
          // 一次性 rewind 全部
          // this.$refs.tinder.rewind(this.history)
          // this.history = []
          // 一次随机 rewind 多个
          this.$refs.tinder.rewind(
            this.history.splice(-Math.ceil(Math.random() * 3))
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
        //
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
  width: 1000px;
  height: calc(100% - 23px - 65px - 47px - 16px);
  min-width: 300px;
  /* max-width: 355px; */
}

.Tinder {
  display: flex;
  justify-content: center;
  width: 100%;
  height: 100%;
  /* background-color: blue; */
}

.left {
  transform: rotate(90deg);
}

.right {
  transform: rotate(-90deg);
}

.left,
.right {
  width: 100px;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.iframe {
  width: 750px;
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
</style>
