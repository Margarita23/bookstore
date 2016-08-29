//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require owl.carousel
//= require_tree .
//= require jquery.raty
//= require ratyrate

$(document).ready(function() {
  $("#owl-demo").owlCarousel({
          navigation : true,
          slideSpeed : 300,
          paginationSpeed : 400,
          singleItem:true
      }); 

  $('#checkbox_use_same_address').on('click', function(){
    $("#shipping_add").slideToggle(200);
  });
  
  if ($('#checkbox_use_same_address').prop("checked")){
    $("#shipping_add").css( "display", "none" );
  }
  
  $('#CVV_info').on('click', function(){
    $(".what_cvv").slideToggle(200);
  });
});

$(document).ready(function() {
  var full_star = '<img src = "http://res.cloudinary.com/nmetau/image/upload/c_scale,h_18,w_18/v1470213961/star_on_kipzbw.png" >';
  var empty_star = '<img src = "http://res.cloudinary.com/nmetau/image/upload/c_scale,w_18/v1470213961/star_of_nwm4nm.png" >';
  for(var i = 0; i < $('.grade').length; i++){
    var count = $('.grade')[i].innerHTML;
    if(count=='1'){
      $('.grade')[i].innerHTML = full_star + empty_star.repeat(4) ;
    }
    if(count=='2'){
      $('.grade')[i].innerHTML = full_star.repeat(2) + empty_star.repeat(3);
    }
    if(count=='3'){
      $('.grade')[i].innerHTML = full_star.repeat(3) + empty_star.repeat(2);
    }
    if(count=='4'){
      $('.grade')[i].innerHTML = full_star.repeat(4) + empty_star;
    }
    if(count=='5'){
      $('.grade')[i].innerHTML = full_star.repeat(5);
    }
  }
});

  function statusChangeCallback(response) {
   
    if (response.status === 'connected') {
      testAPI();
    } else if (response.status === 'not_authorized') {
      document.getElementById('status').innerHTML = 'Please log ' +
        'into this app.';
    } else {
      document.getElementById('status').innerHTML = 'Please log ' +
        'into Facebook.';
    }
  }

  function checkLoginState() {
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  }
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '1605409069769187',
      cookie     : true,
      xfbml      : true,
      version    : 'v2.2'
    });
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  };

  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  function testAPI() {
    FB.api('/me', function(response) {
      document.getElementById('status').innerHTML =
        'Thanks for logging in, ' + response.name + '!';
    });
  }