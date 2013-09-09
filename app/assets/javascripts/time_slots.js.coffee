# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  form = $('.time-slot-form')

  minTime = form.data('start-time')
  maxTime = form.data('end-time')

  $("#time_slot_start_time, #time_slot_end_time").timepicker({
                                        step: 15,
                                        minTime: minTime,
                                        maxTime: maxTime,
                                        showDuration: false
                                       })


  input = $('#time_slot_dj_id_list')
  url = input.data('url')
  prePopulate = input.data('pre-populate')

  input.tokenInput(url, theme: 'facebook', propertyToSearch: 'dj_name', prePopulate: prePopulate)