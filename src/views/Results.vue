<template>
    <div class="result-container">

        <div :class="['menu', { 'responsive': isResponsive }]">

            <h1 class="title">Result of the quiz : {{ emails.result }}/{{ emails.length }}</h1>

            <div class="emails">
                <div :class="['email', { 'active': email.emailId === selectedEmailId }]" v-for="email in emails"
                    :key="email.id" @click="emailIconClick(email.emailId)">
                    <div class="email-icon">
                        <img src="../assets/sncf-logo.png" alt="email icon">
                    </div>
                    <div class="email-content">
                        <div class="email-title">
                            <div class="email-title_text">
                                {{ email.emailName }} :
                            </div>
                            <div class="email-title_icon"
                                v-if="email.isPhishing === true && email.user_rating === 'like' || email.isPhishing === false && email.user_rating === 'nope'">
                                <img src="../assets/happy_logo.png" alt="email title icon true">
                            </div>
                            <div class="email-title_icon" v-else>
                                <img src="../assets/not-happy_logo.png" alt="">
                            </div>

                        </div>

                        <div class="email-paragraph">
                            You answered <span v-if="email.user_rating == 'like'">True</span><span v-else>False</span> to
                            this question
                        </div>
                        <div class="email-subparagraph"
                            v-if="email.isPhishing === true && email.user_rating === 'nope' || email.isPhishing === false && email.user_rating === 'like'">
                            For a tip <span @click="showModal()">click here</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div :class="['menu-btn', { 'responsive': isResponsive }]">
            <svg width="50px" height="50px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"
                @click="toggleMenu">
                <path d="M5 8H13.75M5 12H19M10.25 16L19 16" stroke="#111" stroke-linecap="round" stroke-linejoin="round" />
            </svg>
        </div>

        <div :class="['result-content', { 'responsive': isResponsive }]">

            <div class="modal" v-if="isModalOpen">
                <div class="modal-content">
                    <span class="close" @click="closeModal">&times;</span>
                    <img src="../assets/tips_icon.png" alt="" width="100px" style="border-radius: 50%;">
                    <p>
                        to spot phishing emails and avoid fraud attempts, please follow this advice :
                    </p>
                    <p style="font-style: italic;">
                        {{ emails[selectedEmailId - 1].tips }}
                    </p>
                </div>
            </div>

            <div :class="['result-btn', { 'responsive': isResponsive }]" onclick="location.reload()">
                <a href="">Retry the quiz</a>
            </div>

            <div :class="['result-iframe', { 'responsive': isResponsive }]">
                <iframe :src=URLemail frameborder="0" scrolling="yes">
                </iframe>
            </div>

        </div>

    </div>
</template>

<script>

export default {
    name: 'appResults',
    components: {},

    props: {
        emails: {}
    },

    data: () => ({
        URLemail: "https://chris-973.github.io/iframe/1",
        isResponsive: false,
        selectedEmailId: 1,
        isModalOpen: false
    }),

    methods: {
        toggleMenu() {
            this.isResponsive = !this.isResponsive;
        },

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
.result-container {
    display: flex;
}

.menu {
    cursor: pointer;
    display: none;
    transition: all .3s ease-in-out;
}

.menu.responsive {
    display: block;
    transition: all .3s ease-in-out;
    width: 30%;
}

.menu-btn {
    cursor: pointer;
    padding-top: 15px;
    position: absolute;
}

.menu-btn.responsive {
    left: 19%;
}

.menu .title {
    font-size: 30px;
    color: #EB535F;
}

.emails {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.email {
    display: flex;
    align-items: center;
    gap: 10px;
    transition: all .3s ease-in-out;
    padding: 20px;
}

.email.active {
    transition: all .3s ease-in-out;
    background-color: #EDF4F6;
}

.email-icon img {
    width: 130px;
}

.email-content {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.email-title {
    display: flex;
    align-items: center;
    gap: 10px;
}

.email-title_text {
    font-size: 20px;
    color: #EB535F;
    font-weight: 550;
}

.email-title_icon img {
    width: 40px;
}

.email-paragraph {
    font-size: 18px;
}

.email-paragraph span {
    color: #EB535F;
    font-weight: 550;
}

.email-subparagraph {
    font-style: italic;
    color: #1d1d1d;
}

.email-subparagraph span {
    color: #EB535F;
    cursor: pointer;
}

.result-content {
    width: 100%;
    height: 100vh;
    background-color: #EDF4F6;
}

.result-btn a {
    position: absolute;
    background-color: #EB535F;
    color: #fff;
    padding: 10px;
    border-radius: 8px;
    left: 40%;
    margin-top: 20px;
    text-decoration: none;

}

.result-iframe {
    /* display: none; */
    position: absolute;
    top: 5%;
    left: 30%;
}

.result-iframe iframe {
    width: 650px;
    height: 750px;
}

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

@media screen and (max-width: 850px) {

    .menu-btn svg {
        width: 38px;
    }

    .menu-btn.menu-btn.responsive {
        top: -2%;
        left: 30%;
    }

    .menu .title {
        font-size: 20px;
    }

    .menu.responsive {
        width: 40%;
    }

    .email-icon img {
        width: 80px;
    }

    .email-title_text {
        font-size: 16px;
    }

    .email-title_icon img {
        width: 30px;
    }

    .email-paragraph {
        font-size: 14px;
    }

    .result-content.responsive {
        width: 60%;
    }

    .result-btn.responsive a {
        left: 60%;
    }

    .result-iframe {
        left: 10%;
    }

    .result-iframe.responsive {
        left: 41%;
    }

    .result-iframe.responsive iframe {
        width: 440px;
        height: 750px;
    }

}
</style>