<template>
    <div class="menu">
        <div class="title">Résultats :</div>
        <div v-for="email in emails" :key="email.id">
            <div class="email">
                <div class="logo"></div>
                <div class="email_content">
                    <div class="email_content_title">Question {{ email.emailId }} <span v-if="email.isPhishing === true && email.user_rating === 'like' || email.isPhishing === false && email.user_rating === 'nope'"><img src="../../assets/true.png" alt=""></span><span v-else><img src="../../assets/false.png" alt=""></span></div>
                    <div class="email_content_paragraph">
                        Vous avez répondu <span v-if="email.user_rating == 'like'">Vrai</span><span v-else>Faux</span> à cette question
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

<style></style>