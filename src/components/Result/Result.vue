<template>
    <div>
        <Menu :emails="emails" />
        <h1>Result component</h1>
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

</style>