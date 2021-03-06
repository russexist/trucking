//= require rails-ujs
//= require jquery
//= require jquery-ui
//= require jquery3
//= require jquery_ujs
//= require jcrop
//= require turbolinks
//= require bootstrap
//= require_self
//= require_tree .

function flashMessages() {
  $('#flash_wrapper').hide()
  $(document).ready(function() {
    $('#flash_wrapper').fadeIn('slow',function(){
      $('#flash_wrapper').show();
    });
    setTimeout(function(){
      $('#flash_wrapper').fadeOut('slow', function() {
        $(this).remove();
      });
    }, 3000);
  });
}

function datepickerOn() {
  $("#datepicker").datepicker({
    minDate: 0,
    dateFormat: "yy-mm-dd",
    showAnim: "drop",
    showOtherMonths: true
  });
  datepickerRu();
}

function multiStepFrom() {
  var currentFs, nextFs, previousFs;
  var left, opacity, scale;
  var animating;
  var width = 33.3

  $(".next").click(function(){
    if(animating) return false;
    animating = true;

    currentFs = $(this).parent();
    nextFs = $(this).parent().next();

    if (width == 33.3)
      width = width * 2;
    else {
      width = 100;
    }
    $('.progress-bar').css('width', width+'%');

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

    if (width == 100)
      width = 66.6;
    else {
      if (width == 66.6) {
        width = width/2;
      }
    }
    $('.progress-bar').css('width', width+'%');

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

$(document).on('turbolinks:load', function(){
  flashMessages();
  multiStepFrom();
  datepickerOn();
});
