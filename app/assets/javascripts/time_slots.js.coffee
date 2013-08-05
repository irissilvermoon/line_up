# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  form = $('#new_time_slot, #edit_time_slot')

  minTime = form.data('start-time')
  maxTime = form.data('end-time')

  $("#time_slot_start_time, #time_slot_end_time").timepicker({
                                        step: 15,
                                        minTime: minTime,
                                        maxTime: maxTime,
                                        showDuration: false
                                       });