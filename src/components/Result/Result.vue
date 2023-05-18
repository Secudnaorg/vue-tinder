<template>
    <div class="resultat">

        <div class="menu">
        <div class="title">Résultats :</div>
        <div v-for="email in emails" :key="email.id">
            <div class="emails">
                <div class="email">

                    <div class="email_img">
                        <img src="../../assets/result_logo.png" alt="" @click="emailIconClick(email.emailId)">
                    </div>

                    <div class="email_content">

                        <div class="email_title">
                            <div class="email_title_text">
                                Question {{ email.emailId }} :
                            </div>
                            <div class="img_title_icon" v-if="email.isPhishing === true && email.user_rating === 'like' || email.isPhishing === false && email.user_rating === 'nope'">
                                <img src="../../assets/true.png" alt="">
                            </div>
                            <div class="img_title_icon" v-else>
                                <img src="../../assets/false.png" alt="">
                            </div>
                        </div>

                        <div class="email_paragraph">
                            Vous avez répondu <span v-if="email.user_rating == 'like'">Vrai</span><span v-else>Faux</span> à cette question
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>

        <div class="resultat_content">
            <div class="resultat_iframe">

                <div class="title"></div>

                <div class="resutat_iframe_buttons">
                    <div class="resutat_iframe_button">
                        Votre résultat : {{ emails.result }}/{{ emails.length }}
                    </div>
                    <div class="resutat_iframe_button" onclick="location.reload()" style="cursor: pointer;">
                        Recommencez
                    </div>
                </div>

                <div class="resultat_iframe_cart">
                    <iframe
                        class="iframeCart"
                        :src = URLemail
                        frameborder="0"
                        style="width: 100%; height: 400px;"
                        scrolling="yes"
                    >
                    </iframe>
                </div>

            </div>

            <div class="resultat_tips">  
                <div class="resultat_tips_icon">
                    <img src="../../assets/tips_icon.png" alt="">
                </div> 
                <div class="resultat_tips_text">
                    {{ TipsEmail }}
                </div>
                
            </div>
        </div>
        
    </div>
</template>

<script>

import Menu from './Menu.vue';
import axios from 'axios'

export default {
    name: 'Result',
    components: { Menu },

    props: {
        emails: {}
    },

    created() {
        if (this.emails.length > 0) {
            this.TipsEmail = this.emails[0].tips;
        } else {
            this.TipsEmail = "Cliquez sur une icon pour obtenir un tips"
        }
    },

    data: () => ({
        URLemail: "https://chris-973.github.io/iframe/1",
        TipsEmail: ""
    }),

    methods: {

        emailIconClick(emailId) {
            this.URLemail = 'https://chris-973.github.io/iframe/' + emailId
            this.TipsEmail = this.emails[emailId - 1].tips
            
        }
    }
}  

</script>

<style>


/* ///////// MENU //////////// */

.menu {
    padding: 20px 10px 0 10px;
    width: 40%;
}
.title {
    font-size: 45px;
    font-weight: 500;
    margin-bottom: 30px;
    color: #EB535F;
}

.email_img img {
    width: 150px;
}
.email {
    display: flex;
    align-items: center;
    padding: 0 0 50px 0;
    gap: 20px;
    width: 500px;
}
.email_content {
    display: flex;
    flex-direction: column;
}
.email_title {
    display: flex;
    align-items: center;
}
.email_title_text {
    color: #EB535F;
    font-size: 30px;
}
.email_title img {
    width: 80px;
}
.email_paragraph {
    font-size: 17px;
}
.email_paragraph span {
    font-weight: 700;
    font-size: 20px;
}

/* //////////////////////////////////// */

.resultat {
    display: flex;
}

.resultat_content {
    display: flex;
    justify-content: space-between;
    background-color: #EDF4F6;
    width: 80%;
    height: 100vh;
}
.resultat_iframe {
    /* position: relative; */
    width: 100%;
}
.resutat_iframe_buttons {
    /* position: absolute;
    bottom: 0; */
    display: flex;
    gap: 15vw;
    padding: 0 0 20px 50px;
}
.resutat_iframe_button {
    
    background-color: #EB535F;
    font-size: 20px;
    padding: 10px;
    border-radius: 15px;
    color: #fff;
}

.resultat_tips {
    border-left: 1px solid #111;
    padding: 50px;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 30px;
}

.resultat_tips_text {
    max-width: 200px;
}
</style>