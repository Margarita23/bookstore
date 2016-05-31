// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require owl.carousel
//= require_tree .

 $(document).ready(function() {
     
      $("#owl-demo").owlCarousel({
     
          navigation : true, // Show next and prev buttons
          slideSpeed : 300,
          paginationSpeed : 400,
          singleItem:true
     
      });
     
    });

$(document).ready(function() {
  $('#checkbox_use_same_address').on('click', function(){
    $("#shipping_add").slideToggle(200);
  });
});

//stars_count
$(document).ready(function() {
  var full_star = '<span class="glyphicon glyphicon-star" aria-hidden="true"></span>';
  var empty_star = '<span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span>'
  for(var i = 0; i < $('.grade').length; i++){
    var count = $('.grade')[i].innerHTML;
    if(count=='0'){
      $('.grade')[i].innerHTML = empty_star + empty_star + empty_star + empty_star + empty_star;
    }
    if(count=='1'){
      $('.grade')[i].innerHTML = full_star + empty_star + empty_star + empty_star + empty_star;
    }
    if(count=='2'){
      $('.grade')[i].innerHTML = full_star + full_star + empty_star + empty_star + empty_star;
    }
    if(count=='3'){
      $('.grade')[i].innerHTML = full_star + full_star + full_star + empty_star + empty_star;
    }
    if(count=='4'){
      $('.grade')[i].innerHTML = full_star + full_star + full_star + full_star + empty_star;
    }
    if(count=='5'){
      $('.grade')[i].innerHTML = full_star + full_star + full_star + full_star + full_star;
    }
  }
});











