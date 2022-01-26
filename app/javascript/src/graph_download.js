$(function () {
  let canvas = document.getElementById("myChart");
  let downloadLink = document.getElementById("download_link");
  let filename = "my_graph.jpeg";
  let button = document.getElementById("graph-download-button");
  if(button != null){
    button.addEventListener("click", function () {
      downloadLink.href = canvas.toDataURL("image/jpeg", 1);
      downloadLink.download = filename;
      downloadLink.click();
    });
  }
});
