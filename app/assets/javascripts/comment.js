$(document).ready(function() {
  $('#comments-link').click (function(event) {
    event.preventDefault();
    $('#comments-section').fadeToggle();
  });
});