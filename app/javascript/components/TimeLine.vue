<template>
  <div class="columns my-6 is-centered is-mobile">
    <div class="column pd-sm is-10-mobile is-three-quarters-tablet is-two-fifths-desktop is-two-thirds-widescreen is-half-fullhd">
      <div class="page">
        <div class="timeline">
          <div
            v-for="(events, key) in getEvents"
            :key="key"
            class="timeline-group"
          >
            <div
              class="timeline-age time is-size-5"
              aria-hidden="true"
            >
              「{{ events.age }}歳」の出来事
            </div>
            <div
              v-for="(data, index) in events.data"
              :key="index"
              class="timeline-card ml-7 mb-5"
            >
              <div class="timeline-icon">
                <span class="fullness has-text-weight-semibold">
                  充実度
                </span>
                <span class="fullness-data has-text-weight-semibold">
                  {{ data.happiness }}%
                </span>
              </div>
              <article class="media">
                <div class="media-content">
                  <div class="content">
                    <div class="columns  is-mobile">
                      <div class="column is-9-tablet is-10-desktop is-10-widescreen is-10-fullhd">
                        <h4 class="title is-4">
                          {{ data.title }}
                        </h4>
                      </div>
                      <div class="column has-text-centered">
                        <span class="tag is-warning">{{ data.category_name }}</span>
                      </div>
                    </div>
                  </div>
                  <div class="content">
                    <div class="columns">
                      <p class="column timeline-episode">
                        {{ data.episode }}
                      </p>
                    </div>
                  </div>
                  <nav class="level is-mobile">
                    <div class="level-left">
                      <div class="buttons">
                        <button
                          class="button is-primary"
                          @click.stop="editEventFlagChange(key, index)"
                        >
                          編集
                        </button>
                        <button
                          class="button is-link"
                          @click.stop="eventDelete(data, key, index)"
                        >
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
              <label
                class="radio mb-2"
                for="published"
              >
                <input
                  id="published"
                  v-model="editMyHistory.status"
                  type="radio"
                  name="status"
                  value="published"
                >
                公開
              </label>
            </div>
            <div class="control">
              <label
                class="radio"
                for="unpublished"
              >
                <input
                  id="unpublished"
                  v-model="editMyHistory.status"
                  type="radio"
                  name="status"
                  value="unpublished"
                >
                非公開
              </label>
            </div>
          </div>
        </div>
        <div class="has-text-danger">
          <ul>
            <li
              v-if="!!formError['status']"
            >
              {{ formError["status"][0] }}
            </li>
          </ul>
        </div>
      </form>
      <div class="field has-text-centered mb-5">
        <div class="control">
          <input
            type="submit"
            name="commit"
            value="自分史作成"
            class="button is-btn-yellow btn-design has-text-weight-semibold"
            @click="editStatus"
          >
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import "vuejs-dialog/dist/vuejs-dialog.min.css";
import axios from "axios";

export default {
  name: "TimeLine",
  data() {
    return {
      editMyHistory: {
        id: null,
        status: null,
      },
      formError: {}
    };
  },
  computed: {
    getEvents: function() {
      return this.$store.getters.getEvents;
    },
    getMyHistory: function() {
      return this.$store.getters.getMyHistory;
    }
  },
  created() {
    this.editMyHistory.id = this.getMyHistory.id;
    this.editMyHistory.status = this.getMyHistory.status;
  },
  methods: {
    editEventFlagChange(key, index) {
      this.$emit("editEventFlagChange", key, index, true);
    },
    eventDelete(data, key, index) {
      let message = {
        title: "最終確認",
        body: "本当に削除してもよろしいですか？"
      };

      let options = {
        okText: "はい",
        cancelText: "キャンセル",
        animation: "zoom",
        backdropClose: true,
      };

      this.$dialog.confirm(message, options)
        .then(() => {
          this.$store.dispatch("eventDelete", { data: data, key: key, index: index })
            .then(() => {
              this.$emit("deleteEventSuccess");
            });
        })
        .catch(function () {
        });
    },
    editStatus() {
      axios
        .patch(`/api/my_histories/${this.editMyHistory.id}`, {
          status: this.editMyHistory.status,
        })
        .then((responce) => {
          window.location.href = `http://localhost:3000/my_histories/${responce.data.id}`;
        })
        .catch((error) => {
          console.log("error");
          if (error.response.data && error.response.data.errors) {
            this.formError = error.response.data.errors;
          }
        });
    },
  }
};
</script>

<style scoped>
.dg-title {
  margin: 0 0 10px 0;
  padding: 0;
  font-size: 18px;
}

.dg-content-body--has-title .dg-content {
  font-size: 14px;
}

.dg-content {
  font-size: 16px;
  line-height: 1.3em;
}
</style>
