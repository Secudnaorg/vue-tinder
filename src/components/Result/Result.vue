<template>
    <div class="resultat">

        <div class="menu">
        <div class="title">Results of the quiz :</div>
        <div class="emails">

            <div class="modal" v-if="isModalOpen">
            <div class="modal-content">
                <span class="close" @click="closeModal">&times;</span>
                <img src="../../assets/tips_icon.png" alt="" width="100px" style="border-radius: 50%;">
                <p>
                    to spot phishing emails and avoid fraud attempts, please follow this advice :
                </p>
                <p style="font-style: italic;">
                    {{ emails[selectedEmailId - 1].tips }}
                </p>
            </div>
            </div>

            <div v-for="email in emails" :key="email.id" >

                    <div class="email" :class="{ 'active': email.emailId === selectedEmailId }" @click="emailIconClick(email.emailId)">

                        <div class="email_img">
                            <img src="../../assets/sncf-logo.png" alt="">
                        </div>

                        <div class="email_content">

                            <div class="email_title">
                                <div class="email_title_text">
                                    Question {{ email.emailId }} :
                                </div>
                                <div class="img_title_icon" v-if="email.isPhishing === true && email.user_rating === 'like' || email.isPhishing === false && email.user_rating === 'nope'">
                                    <img src="../../assets/happy_logo.png" alt="">
                                </div>
                                <div class="img_title_icon" v-else>
                                    <img src="../../assets/not-happy_logo.png" alt="">
                                </div>
                            </div>

                            <div class="email_paragraph">
                                You answered <span v-if="email.user_rating == 'like'">True</span><span v-else>False</span> to this question
                            </div>
                            <div class="email_subparagraph" v-if="email.isPhishing === true && email.user_rating === 'nope' || email.isPhishing === false && email.user_rating === 'like'">
                                For a tip <span @click="showModal()">click here</span>
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
                        scrolling="yes"
                    >
                    </iframe>
                </div>

            </div>

            <!-- <div class="resultat_tips">  
                <div class="resultat_tips_icon">
                    <img src="../../assets/tips_icon.png" alt="">
                </div> 
                <div class="resultat_tips_text">
                    {{ TipsEmail }}
                </div>
                
            </div> -->
        </div>
        
    </div>
</template>

<script>

import axios from 'axios'

export default {
    name: 'Result',
    components: { },

    props: {
        emails: {}
    },

    // created() {
    //     if (this.emails.length > 0) {
    //         this.TipsEmail = this.emails[0].tips;
    //     } else {
    //         this.TipsEmail = "Cliquez sur une icon pour obtenir un tips"
    //     }
    // },

    data: () => ({
        URLemail: "https://chris-973.github.io/iframe/1",
        selectedEmailId: 1,
        isModalOpen: false
    }),

    methods: {
        
        /**
         * Allows you to change the mail displayed when the section is clicked with the emailID
         */
        emailIconClick(emailId) {
            this.URLemail = 'https://chris-973.github.io/iframe/' + emailId
            this.selectedEmailId = emailId; 
        },

        /**
         * Displays the tips modal
         */
        showModal() {
            this.isModalOpen = true;
        },

        /**
         * hides the tips modal
         */
        closeModal() {
            this.isModalOpen = false;
        },
    }
}  

</script>

<style>


/* ///////// MENU //////////// */

.menu {
    display: flex;
    flex-direction: column;
    width: 40%;
}


.title {
    font-size: 45px;
    font-weight: 500;
    margin-bottom: 10px;
    color: #EB535F;
    padding: 20px 0 20px 20px;
}


.email_img img {
    width: 150px;
    /* border-radius: 0%; */
}
.email {
    display: flex;
    align-items: center;
    padding: 0 0 50px 0;
    gap: 20px;
    width: 500px;
    padding: 20px;

    transition: all .3s ease-in-out;
    width: 100%;
    cursor: pointer;
}
.email.active {
    transition: all .3s ease-in-out;
    background-color: #EDF4F6;
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
    /* font-weight: 700; */
    font-size: 20px;
    color: #EB535F;
}

.email_subparagraph {
    font-style: italic;
    margin-top: 10px;
}

.email_subparagraph span {
    color: #EB535F;
    
}

/* //////////////////////////////////// */

.resultat {
    display: flex;
}

.resultat_content {
    display: flex;
    background-color: #EDF4F6;
    width: 100%;
    height: 100vh;
}
.resultat_iframe {
    /* position: relative; */
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
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

.resultat_iframe_cart iframe{
    width: 800px;
    height: 800px;
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

@media screen and (max-width: 850px) {
    .menu {
        width: 90%;
    }
    .title {
        font-size: 30px;
    }

    .email_img img{
        width: 100px;
    }

    .email_title .email_title_text {
        font-size: 20px;
    }

    .email_title .img_title_icon img{
        width: 50px;
    }

    .email_content .email_paragraph {
        font-size: 14px;
    }

    .email_paragraph span {
        font-size: 16px;
    }

    .email_content .email_subparagraph {
        font-size: 14px;
    }
    .resultat_content {
        position: relative;
    }
    .resutat_iframe_button {
        font-size: 14px;
    }
    .resultat_iframe_cart iframe{
        position: absolute;
        right: 0;
        /* background-color: red; */
        max-width: 400px;
        max-height: 500px;

    }
}

</style>