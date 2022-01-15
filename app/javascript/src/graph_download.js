$(function () {
  let canvas = document.getElementById("myChart");
  let downloadLink = document.getElementById("download_link");
  let filename = "my_graph.png";
  let button = document.getElementById("graph-download-button");

  if(button != null){
    button.addEventListener("click", function () {
      downloadLink.href = canvas.toDataURL("image/png");
      downloadLink.download = filename;
      downloadLink.click();
    });
  }
});
