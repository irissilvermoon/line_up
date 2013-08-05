# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#event_date').datepicker
    dateFormat: 'M d, yy'
  $("#event_start_time").timepicker();
  $("#event_end_time").timepicker();