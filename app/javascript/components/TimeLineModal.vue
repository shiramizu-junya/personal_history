<template>
  <div class="modal">
    <div
      class="modal-background"
    />
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">
          イベント追加
        </p>
      </header>
      <section class="modal-card-body">
        <form>
          <div class="field">
            <label class="label">年齢</label>
            <div class="control">
              <input
                class="input"
                type="number"
                name="age"
              >
            </div>
          </div>
          <div class="field">
            <label class="label">タイトル</label>
            <div class="control">
              <input
                class="input"
                type="text"
                name="title"
              >
            </div>
          </div>
          <div class="field">
            <label class="label">エピソード</label>
            <div class="control">
              <textarea
                class="textarea"
                name="episode"
              />
            </div>
          </div>
          <div class="field">
            <label class="label">充実度</label>
            <div class="control">
              <input
                class="input"
                type="number"
                name="happiness"
              >
            </div>
          </div>
        </form>
      </section>
      <footer class="modal-card-foot">
        <button
          class="button is-success"
        >
          追加
        </button>
        <button
          class="button"
        >
          キャンセル
        </button>
      </footer>
    </div>
  </div>
</template>

<script>
export default {
  name: "TimeLineModal",
};
</script>
