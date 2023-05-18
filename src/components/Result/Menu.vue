<template>
    
</template>

<script>

export default {
    name: 'Menu',
    components: {},
    props: {
        emails: {}
    },

    methods: {
        afficherMessage(emailID) {
            console.log(this.emails[emailID]);
        }
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