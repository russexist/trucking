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
//= require turbolinks
//= require jquery
//= require jquery-ui
//= require jquery3
//= require jquery_ujs
//= require bootstrap
//= require_tree .

var ready;
ready = function() {
  $("#datepicker").datepicker({
    minDate: 0,
    dateFormat: "dd/mm/yy",
    showAnim: "drop",
    showOtherMonths: true
  });
  datepickerRu();

  var currentFs, nextFs, previousFs;
  var left, opacity, scale; 
  var animating;

  $(".next").click(function(){
    if(animating) return false;
    animating = true;

    currentFs = $(this).parent();
    nextFs = $(this).parent().next();

    nextFs.show();
    $('.active').next().addClass('active');

    currentFs.animate({opacity: 0}, {
      step: function(now, mx) {
        scale = 1 - (1 - now) * 0.2;
        left = (now * 50)+"%";
        opacity = 1 - now;
        currentFs.css({'transform': 'scale('+scale+')'});
        nextFs.css({'left': left, 'opacity': opacity});
      },
      duration: 800,
      complete: function(){
        currentFs.hide();
        animating = false;
      },
      easing: 'easeInOutBack'
    });
  });

  $(".previous").click(function(){
    if(animating) return false;
    animating = true;

    currentFs = $(this).parent();
    previousFs = $(this).parent().prev();

    previousFs.show();

    if ($('.last').hasClass('active')){
      $('.last').removeClass('active');
    }
    else {
      $('.second').removeClass('active');
    }

    currentFs.animate({opacity: 0}, {
      step: function(now, mx) {
        scale = 0.8 + (1 - now) * 0.2;
        left = ((1-now) * 50)+"%";
        opacity = 1 - now;
        currentFs.css({'left': left});
        previousFs.css({'transform': 'scale('+scale+')', 'opacity': opacity});
      },
      duration: 800,
      complete: function(){
        currentFs.hide();
        animating = false;
      },
      easing: 'easeInOutBack'
    });
  });
}
$(document).on('turbolinks:load', ready);
