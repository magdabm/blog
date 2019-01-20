// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require_tree .

window.addEventListener('load', function () {
  console.log('Hello from rails!');

  var summaryElements = document.querySelectorAll(".summary");

  for(var i = 0; i < summaryElements.length; i++) {
    var element = summaryElements[i];
    var request = new XMLHttpRequest();
    request.open("GET", element.href + ".json");
    request.responseType = "json";
    request.addEventListener("load", function () {
      var summary = document.getElementById("summary-" + this.response.id);
      var text = "Comments: " + this.response.comments_count;
      text += "\nLikes: " + this.response.likes_count;
      text += "\nViews: " + this.response.views_count;
      summary.innerText = text;
    });
    element.innerText = "Loading";
    request.send();
    }
})

// window.addEventListener('load', function () {
//   console.log('Hello from rails!');
//
//   var summaryElements = document.querySelectorAll(".summary");
//
//   for(var i = 0; i < summaryElements.length; i++) {
//     summaryElements[i].addEventListener("click", function(e) {
//       e.preventDefault();
//       var request = new XMLHttpRequest();
//       request.open("GET", this.href + ".json");
//       request.responseType = "json";
//       request.addEventListener("load", function () {
//         var summary = document.getElementById("summary-" + this.response.id);
//         var text = "Comments: " + this.response.comments_count;
//         text += " | Likes: " + this.response.likes_count;
//         text += " | Views: " + this.response.views_count;
//         summary.innerText = text;
//       });
//       this.innerText = "Loading";
//       request.send();
//     })
//   }
// })
