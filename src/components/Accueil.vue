<template>
    <div class="accueil">
        <div class="title">
            hey ! there how are you ?
        </div>

        <div class="container">
            <div class="content"> 
                Do you know what phishing is? <br><br>
               
                If you are curious, you can take this quiz to train yourself...
            </div>
        </div>
        
        <div class="subtitle">
            <h3>Let's start!</h3>
        </div>
        <router-link to="/game">
            <img src="../assets/start_btn.png" alt="" width="200px">
        </router-link>
    </div>
</template>

<script>

export default {
    name: 'Accueil',
    components: {},
    methods: {

    }
}

</script>

<style>

    .accueil {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
    }

    .subtitle {
        font-size: 30px;
        font-weight: 500;
        margin-top: 20px;
    }
</style>