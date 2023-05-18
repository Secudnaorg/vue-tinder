<template>
    <div class="resultat">

        <div class="menu">
            <Menu :emails="emails" />
        </div>

        <div class="resultat_content">
            <div class="resultat_iframe">
                <div class="title"></div>
                <div class="resultat_iframe_cart"></div>
                <div class="resutat_iframe_buttons">
                    <div class="resutat_iframe_button">
                        Votre résultat : {{ emails.result }}/{{ emails.length }}
                    </div>
                    <div class="resutat_iframe_button" onclick="location.reload()" style="cursor: pointer;">
                        Recommencez
                    </div>
                </div>
            </div>

            <div class="resultat_tips">  
                <div class="resultat_tips_icon">
                    <img src="../../assets/tips_icon.png" alt="">
                </div> 
                <div class="resultat_tips_text">
                    Lorem ipsum, dolor sit amet consectetur adipisicing elit. Neque quaerat quam quos sapiente iste repellat odio, aut unde! Perferendis similique animi placeat, laboriosam molestias possimus asperiores. Delectus fugiat iste quos.
                    Lorem ipsum dolor sit amet consectetur, adipisicing elit. Voluptate aliquam doloribus nostrum itaque id, repellat possimus omnis suscipit et molestiae quasi non autem dolore tempora, in unde dolorum corporis! Saepe.
                </div>
                
            </div>
        </div>
        
    </div>
</template>

<script>

import Menu from './Menu.vue';


export default {
    name: 'Result',
    components: { Menu },
    props: {
        emails: {}
    },

    methods: {

    }
}  

</script>

<style>
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
    position: relative;
    width: 100%;
}
.resutat_iframe_buttons {
    position: absolute;
    bottom: 0;
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