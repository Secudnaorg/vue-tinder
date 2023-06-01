<template>
    <div class="instructions">
        <v-stepper v-model="e1" class="elevation-0 text-center" style="margin-top: 100px;">
            <h2>You have two ways to rating</h2>

            <v-stepper-items>
                <v-stepper-content step="1" class="text-center">
                    <v-card class="elevation-0">
                        <h3>Swipe System</h3>
                        <v-avatar size="100">
                            <img :src="require('../assets/burger-menu.svg')">
                        </v-avatar>
                        <p>Yoy can rating swipping poster films, like tinder!</p>
                        <v-row class="mb-6" justify="center" no-gutters>
                            <v-col>
                                <strong>Left</strong><br>
                                <v-avatar size="50"><img :src="require('../assets/burger-menu.svg')"></v-avatar><br>
                                You dont like it
                            </v-col>
                            <v-col>
                                <strong>Up</strong><br>
                                <v-avatar size="50"><img :src="require('../assets/burger-menu.svg')"></v-avatar><br>
                                A film that you love
                            </v-col>
                            <v-col>
                                <strong>Down</strong><br>
                                <v-avatar size="50"><img :src="require('../assets/burger-menu.svg')"></v-avatar><br>
                                You haven't seen it
                            </v-col>
                            <v-col>
                                <strong>Right</strong><br>
                                <v-avatar size="50"><img :src="require('../assets/burger-menu.svg')"></v-avatar><br>
                                You like it
                            </v-col>
                        </v-row>
                    </v-card>
                    <br>
                    <v-btn @click="e1 = 2" icon width="auto" height="auto" class="ma-3" elevation="5">
                        <v-avatar size="100">
                            <img :src="require('../assets/burger-menu.svg')">
                        </v-avatar>
                    </v-btn>
                </v-stepper-content>

                <v-stepper-content step="2" class=" text-center">
                    <v-card class="elevation-0">
                        <h3>Click System</h3>
                        <v-avatar size="100">
                            <img :src="require('../assets/burger-menu.svg')">
                        </v-avatar>
                        <p>Also have the possibility to use the buttons under the film poster</p>
                    </v-card>
                    <v-row class="mb-6" justify="center" no-gutters>
                        <v-col>
                            <strong>Left</strong><br>
                            <v-avatar size="50"><img :src="require('../assets/burger-menu.svg')"></v-avatar><br>
                            You dont like it
                        </v-col>
                        <v-col>
                            <strong>Up</strong><br>
                            <v-avatar size="50"><img :src="require('../assets/burger-menu.svg')"></v-avatar><br>
                            A film that you love
                        </v-col>
                        <v-col>
                            <strong>Down</strong><br>
                            <v-avatar size="50"><img :src="require('../assets/burger-menu.svg')"></v-avatar><br>
                            You haven't seen it
                        </v-col>
                        <v-col>
                            <strong>Right</strong><br>
                            <v-avatar size="50"><img :src="require('../assets/burger-menu.svg')"></v-avatar><br>
                            You like it
                        </v-col>
                    </v-row>

                    <router-link to="/game">
                        Playing quiz
                    </router-link>
                </v-stepper-content>
            </v-stepper-items>
        </v-stepper>
    </div>
</template>

<script>

// import { RouterLink } from 'vue-router';

export default {
    name: 'appInstructions',
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
