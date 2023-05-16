<template>
    <div class="menu">
        <div class="title">Résultats :</div>
        <div v-for="email in emails" :key="email.id">
            <div class="emails">
                <div class="email">

                    <div class="email_img">
                        <img src="../../assets/result_logo.png" alt="">
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
</template>

<script>

export default {
    name: 'Menu',
    components: {},
    props: {
        emails: {}
    },

    created() {
        console.log(this.emails);
    },

    methods: {

    }
}

</script>

<style>
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
</style>