<template>
    <div class="home">
        <v-row class="text-center" style="margin-top: 100px;">
            <v-col cols="12">
                <h1 class="display-2 font-weight-bold mb-3">Gottaphish Vue-Tinder Quiz App</h1>
                <p>
                    This project concerns phishing training by the startup <a href="https://gottaphish.com/">Gottaphish</a>. 
                    The aim is to learn how to recognize and deal with phishing emails.
                </p>
                <p>
                    To achieve this, we used several tools :
                </p>

                <strong>VueJS 2</strong><br>
                <p>
                    framework JavaScript utilisé pour la construction d'interfaces utilisateur interactives et réactives en fournissant une approche basée sur les composants.
                </p>
                <strong>Vue-Tinder</strong><br>
                <p>This plugin syncs all my grades from the TMBD api via WP api rest.</p>

                <p>
                   open-source library based on Vue.js, which enables the creation of interfaces similar to the popular dating application "Tinder".
                </p>
                <br>

                <router-link to="/instructions">
                    See instructions
                </router-link>
            </v-col>
        </v-row>
    </div>
</template>

<script>

export default {
    name: 'appHome',
    components: {

    },

    data() {
        return {
            e1: 1,
        };
    },
}
</script>

<style></style>
