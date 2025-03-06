
$(document).ready(function() {
  setTimeout(function() {
    $(".flash-notice-alert").hide('blind', {}, 500)
  }, 5000);
});
});


$(document).on('turbolinks:load', function() {
  $("#searchWidgetTrigger").trigger('click');
})

