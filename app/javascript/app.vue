<!-- １、templateタグにはブラウザ上に表示させたい内容をHTMLで記述することが可能 -->
<template>
  <div id="app">
    <PersonalHistory />
  </div>
</template>

<script>
import PersonalHistory from "./components/PersonalHistory";

export default {
  name: "App",
  components: {
    PersonalHistory
  }
};
</script>
