<template>
  <div class="columns my-6 is-centered is-mobile">
    <div class="column pd-sm is-10-mobile is-three-quarters-tablet is-two-fifths-desktop is-two-thirds-widescreen is-half-fullhd">
      <div class="page">
        <div class="timeline">
          <!-- 一塊の自分史 ここから -->
          <div
            v-for="event in getEvents"
            :key="event.id"
            class="timeline-group"
          >
            <div
              class="timeline-age time is-size-5"
              aria-hidden="true"
            >
              <!-- 「35歳」の出来事 -->
              「{{ event.age }}歳」の出来事
            </div>
            <!-- 同年齢１個分の自分史 ここから -->
            <div class="timeline-card ml-7 mb-5">
              <div class="timeline-icon">
                <span class="fullness has-text-weight-semibold">
                  充実度
                </span>
                <span class="fullness-data has-text-weight-semibold">
                  {{ event.happiness }}%
                </span>
              </div>
              <article class="media">
                <div class="media-content">
                  <div class="content">
                    <div class="columns">
                      <div class="column is-9-tablet is-10-desktop is-10-widescreen is-10-fullhd">
                        <h4 class="title is-4">
                          <!-- イベントタイトル -->
                          {{ event.title }}
                        </h4>
                      </div>
                    </div>
                  </div>
                  <div class="content">
                    <div class="columns">
                      <p class="column timeline-episode">
                        <!-- 出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事
                        出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事 -->
                        {{ event.episode }}
                      </p>
                    </div>
                  </div>
                  <nav class="level is-mobile">
                    <div class="level-left">
                      <div class="buttons">
                        <button class="button is-primary">
                          編集
                        </button>
                        <button class="button is-link">
                          削除
                        </button>
                      </div>
                    </div>
                  </nav>
                </div>
              </article>
            </div>
            <!-- 同年齢１個分の自分史 ここまで -->

            <!-- 同年齢１個分の自分史 ここから -->
            <div class="timeline-card ml-7 mb-5">
              <div class="timeline-icon">
                <span class="fullness has-text-weight-semibold">
                  充実度
                </span>
                <span class="fullness-data has-text-weight-semibold">
                  30%
                </span>
              </div>
              <article class="media">
                <div class="media-content">
                  <div class="content">
                    <div class="columns">
                      <div class="column is-9-tablet is-10-desktop is-10-widescreen is-10-fullhd">
                        <h4 class="title is-4">
                          イベントタイトル
                        </h4>
                      </div>
                    </div>
                  </div>
                  <div class="content">
                    <div class="columns">
                      <p class="column timeline-episode">
                        出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事
                        出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事
                      </p>
                    </div>
                  </div>
                  <nav class="level is-mobile">
                    <div class="level-left">
                      <div class="buttons">
                        <button class="button is-primary">
                          編集
                        </button>
                        <button class="button is-link">
                          削除
                        </button>
                      </div>
                    </div>
                  </nav>
                </div>
              </article>
            </div>
            <!-- 同年齢１個分の自分史 ここまで -->
          </div>
          <!-- 一塊の自分史 ここまで -->

          <!-- 一塊の自分史 -->
          <div class="timeline-group">
            <div
              class="timeline-age time is-size-5"
              aria-hidden="true"
            >
              「35歳」の出来事
            </div>
            <!-- 同年齢１個分の自分史 -->
            <div class="timeline-card ml-7 mb-5">
              <div class="timeline-icon">
                <span class="fullness has-text-weight-semibold">
                  充実度
                </span>
                <span class="fullness-data has-text-weight-semibold">
                  30%
                </span>
              </div>
              <article class="media">
                <div class="media-content">
                  <div class="content">
                    <div class="columns">
                      <div class="column is-9-tablet is-10-desktop is-10-widescreen is-10-fullhd">
                        <h4 class="title is-4">
                          イベントタイトル
                        </h4>
                      </div>
                    </div>
                  </div>
                  <div class="content">
                    <div class="columns">
                      <p class="column timeline-episode">
                        出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事
                        出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事
                      </p>
                    </div>
                  </div>
                  <nav class="level is-mobile">
                    <div class="level-left">
                      <div class="buttons">
                        <button class="button is-primary">
                          編集
                        </button>
                        <button class="button is-link">
                          削除
                        </button>
                      </div>
                    </div>
                  </nav>
                </div>
              </article>
            </div>

            <!-- 同年齢１個分の自分史 -->
            <div class="timeline-card ml-7 mb-5">
              <div class="timeline-icon">
                <span class="fullness has-text-weight-semibold">
                  充実度
                </span>
                <span class="fullness-data has-text-weight-semibold">
                  30%
                </span>
              </div>
              <article class="media">
                <div class="media-content">
                  <div class="content">
                    <div class="columns">
                      <div class="column is-9-tablet is-10-desktop is-10-widescreen is-10-fullhd">
                        <h4 class="title is-4">
                          イベントタイトル
                        </h4>
                      </div>
                    </div>
                  </div>
                  <div class="content">
                    <div class="columns">
                      <p class="column timeline-episode">
                        出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事
                        出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事出来事
                      </p>
                    </div>
                  </div>
                  <nav class="level is-mobile">
                    <div class="level-left">
                      <div class="buttons">
                        <button class="button is-primary">
                          編集
                        </button>
                        <button class="button is-link">
                          削除
                        </button>
                      </div>
                    </div>
                  </nav>
                </div>
              </article>
            </div>
          </div>
        </div>
      </div>

      <!-- 公開/非公開設定 -->
      <form>
        <div class="field mb-5 published-field">
          <div class="published-title">
            <h5 class="label is-size-5">
              公開範囲
            </h5>
          </div>
          <div class="publish-wrap">
            <div class="control">
              <label class="radio mb-2">
                <input
                  type="radio"
                  name="question"
                >
                公開
              </label>
            </div>
            <div class="control">
              <label class="radio">
                <input
                  type="radio"
                  name="question"
                >
                非公開
              </label>
            </div>
          </div>
        </div>

        <div class="field has-text-centered mb-5">
          <div class="control">
            <input
              type="submit"
              name="commit"
              value="自分史作成"
              class="button is-btn-yellow btn-design has-text-weight-semibold"
            >
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  name: "TimeLine",
  computed: {
    getEvents: function() {
      return this.$store.getters.getEvents;
    }
  },
};
</script>
