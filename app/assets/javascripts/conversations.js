var chose;

chose = function(){
  $('.chosen-select').chosen({
    no_results_text: 'No result matched'
  });
}

$(document).ready(chose);

$(document).on("turbolinks:load", chose);
