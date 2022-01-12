import Chart from "chart.js/auto";
global.Chart = Chart;
window.addEventListener("DOMContentLoaded", function () {
  const ctx = document.getElementById("myChart");
  const type = "line";
  let datasets = [
    {
      /* グラフ全体のラベル */
      label: "充実度",
      /* グラフのデータ(x軸 & y軸) */
      data: JSON.parse(ctx.dataset.data),
      /* 背景色 */
      backgroundColor: "rgba(255, 99, 132, 0.2)",
      /* 枠線色 */
      borderColor: "rgb(255, 99, 132)",
      /* ポイントを塗りつぶす色 */
      pointBackgroundColor: "rgb(255, 99, 132)",
      /* ポイントの太さ */
      pointBorderWidth: 5,
      pointHoverRadius: 5,
      /* ホバー時のポイントの背景色 */
      pointHoverBackgroundColor: "#fff",
      /* ホバー時のポイントの枠線色 */
      pointHoverBorderColor: "rgb(255, 99, 132)",
      lineTension: 0,
    },
  ];
  const scales = {
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
          return value + "歳";
        },
      },
    },
    y: {
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
      min: -100,
      max: 100,
      ticks: {
        callback: function (value) {
          return value + "%";
        },
        color: function (context) {
          if (context.tick.value === 0) {
            return "#4557BB";
          }
          return "#6A6A6A";
        },
      },
      grid: {
        drawBorder: false,
        color: function (context) {
          if (context.tick.value === 0) {
            return "#4557BB";
          }
          return "#E1E1E2";
        },
      },
    },
  };
  const elements = {
    line: {
      /* 枠線の太さ */
      borderWidth: 2,
      tension: 0.1,
      responsive: true,
      maintainAspectRatio: false,
    },
  };
  Chart.defaults.font.size = 20;

  new Chart(ctx, {
    type: type,
    data: {
      labels: JSON.parse(ctx.dataset.labels),
      datasets: datasets,
    },
    options: {
      scales: scales,
      elements: elements,
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
              return `${tooltipItem[0].parsed.x}歳`;
            },
            label: function (tooltipItem) {
              return `充実度:${tooltipItem.parsed.y}%`;
            },
          },
        },
      },
      onResize: function () {
        if (window.innerWidth <= 767) {
          Chart.defaults.font.size = 10;
        }
      },
    },
  });
});
