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

$(document).ready(function() {
  $('#CVV_info').on('click', function(){
    $(".what_cvv").slideToggle(200);
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
// This is called with the results from from FB.getLoginStatus().
  function statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response);
   
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      testAPI();
    } else if (response.status === 'not_authorized') {
      // The person is logged into Facebook, but not your app.
      document.getElementById('status').innerHTML = 'Please log ' +
        'into this app.';
    } else {
      // The person is not logged into Facebook, so we're not sure if
      // they are logged into this app or not.
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
    cookie     : true,  // enable cookies to allow the server to access 
                        // the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.2' // use version 2.2
  });

  FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
  });

  };

  // Load the SDK asynchronously
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  // Here we run a very simple test of the Graph API after login is
  // successful.  See statusChangeCallback() for when this call is made.
  function testAPI() {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me', function(response) {
      console.log('Successful login for: ' + response.name);
      document.getElementById('status').innerHTML =
        'Thanks for logging in, ' + response.name + '!';
    });
  }

/*
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '1605409069769187',
      xfbml      : true,
      version    : 'v2.6'
    });
  };

  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "//connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));
   
   */