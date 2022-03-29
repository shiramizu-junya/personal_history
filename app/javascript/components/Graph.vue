<template>
  <div>
    <div class="columns mt-2 mb-1 is-centered is-mobile">
      <div class="column pd-sm is-10-mobile is-11-tablet is-two-fifths-desktop is-two-thirds-widescreen is-7-fullhd">
        <h1 class="title has-text-centered mb-5">
          {{ textJudgementFlag ? "自分史作成" : "自分史編集" }}
        </h1>
      </div>
    </div>
    <div class="columns is-centered is-mobile">
      <div class="chart-container column graph-area is-11-mobile is-11-tablet is-9-desktop is-9-widescreen is-10-fullhd">
        <LineChart
          v-bind="lineChartProps"
          class="myChart"
        />
      </div>
    </div>
  </div>
</template>

<script>
import { LineChart, useLineChart } from "vue-chart-3";
import { computed, watchEffect, ref } from "@vue/composition-api";
import { Chart, registerables } from "chart.js";
import axios from "axios";
Chart.register(...registerables);

export default {
  name: "Graph",
  components: {
    LineChart,
  },
  props: {
    textJudgementFlag:
    {
      type: Boolean,
      required: true,
    },
    graphLabel:
    {
      type: Array,
      required: true,
    },
    graphData:
    {
      type: Array,
      required: true,
    },
    graphImageFlag:
    {
      type: Boolean,
      required: true,
    }
  },
  setup(props, context) {
    let imgData = ref(null);

    const options = computed(() => ({
      scales: {
        x: {
          title: {
            display: true,
            text: "年齢",
            color: "#272343",
            font: {
              family: "Comic Sans MS",
              weight: "bold",
              lineHeight: 1.2,
            },
            padding: { top: 10, right: -100, bottom: 10, left: 0 },
          },
          ticks: {
            callback: function (value) {
              return `${this.getLabelForValue(value)}歳`;
            },
            color: function () {
              return "#484848";
            },
          },
          grid: {
            drawBorder: false,
            color: function () {
              return "#adadb0";
            },
          },
        },
        y: {
          min: -100,
          max: 100,
          title: {
            display: true,
            text: "充実度",
            color: "#272343",
            font: {
              family: "Comic Sans MS",
              weight: "bold",
              lineHeight: 1.2,
            },
            padding: { top: 10, right: -100, bottom: 10, left: 0 },
          },
          ticks: {
            stepSize: 20,
            callback: function (value) {
              return value + "%";
            },
            color: function (context) {
              if (context.tick.value === 0) {
                return "#4557BB";
              }
              return "#484848";
            },
          },
          grid: {
            drawBorder: false,
            color: function (context) {
              if (context.tick.value === 0) {
                return "#4557BB";
              }
              return "#adadb0";
            },
          },
        },
      },
      elements: {
        line: {
          /* 枠線の太さ */
          borderWidth: 2,
          tension: 0.1,
          responsive: true,
          maintainAspectRatio: false,
        },
      },
      plugins: {
        tooltip: {
          mode: "nearest",
          intersect: false,
          // 吹き出しの背景色
          backgroundColor: "rgba(19, 56, 95, 0.9)",
          // 吹き出し内の余白
          xPadding: 12,
          yPadding: 12,
          // マーカーによって変更するもの
          callbacks: {
            title: function (tooltipItem) {
              return `${tooltipItem[0].label}歳`;
            },
            label: function (tooltipItem) {
              return `充実度:${tooltipItem.formattedValue}%`;
            },
          },
        },
      },
      onResize: function (node, size) {
        if (window.innerWidth <= 1024) {
          node.canvas.parentNode.style.height = `${size.width / 1.4}px`;
        } else {
          node.canvas.parentNode.style.height = `${size.width / 2}px`;
        }
        if (window.innerWidth <= 767) {
          Chart.defaults.font.size = 10;
        }else{
          Chart.defaults.font.size = 20;
        }
      },
    }));

    let plugins = [{
      id: "custom_canvas_background_color",
      beforeDraw: (chart) => {
        const ctx = chart.canvas.getContext("2d");
        ctx.save();
        ctx.globalCompositeOperation = "destination-over";
        ctx.fillStyle = "#fff";
        ctx.fillRect(0, 0, chart.width, chart.height);
        ctx.restore();
      },
    }];

    let chartData = computed(() => ({
      labels: props.graphLabel,
      datasets: [
        {
          data: props.graphData,
          label: "充実度",
          backgroundColor: "rgba(255, 99, 132, 0.2)",
          borderColor: "rgb(255, 99, 132)",
          pointBackgroundColor: "rgb(255, 99, 132)",
          pointBorderWidth: 5,
          pointHoverRadius: 5,
          pointHoverBackgroundColor: "#fff",
          pointHoverBorderColor: "rgb(255, 99, 132)",
          lineTension: 0,
        },
      ],
    }));

    let { lineChartProps, lineChartRef } = useLineChart({
      chartData,
      options,
      plugins
    });

    watchEffect(
      () => {
        if(props.graphImageFlag){
          setTimeout(function() {
            imgData.value = lineChartRef.value.chartInstance.toBase64Image("image/jpeg", 1);
            let obj = {
              my_history: {
                graph_image: imgData.value
              }
            };
            axios
              .patch("/api/my_history/graph_image_upload",
                obj,
              ).then(() => {
                context.emit("changeGraphImageFlag");
              });
          }, 1000);
        }
      }
    );
    return { lineChartProps, lineChartRef, imgData };
  },
};
</script>

<style lang="scss" scoped>
.graph-area {
  border: 3px solid #eff2f6;
  border-radius: 5px;
}
</style>
