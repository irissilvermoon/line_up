
//time slot time picker
$(document).ready(function() {
  var form = $('.time-slot-form');

  var minTime = form.data('start-time');
  var maxTime = form.data('end-time');

  $("#time_slot_start_time, #time_slot_end_time").timepicker({
                                        step: 15,
                                        minTime: minTime,
                                        maxTime: maxTime,
                                        showDuration: false
                                       });

//tokenInput DJ picker
  var input = $('#time_slot_dj_id_list');
  var url = input.data('url');
  var prePopulate = input.data('pre-populate');

  input.tokenInput(url, { theme: 'facebook', propertyToSearch: 'dj_name', prePopulate: prePopulate });
});


//confirmed checkbox code

$(document).ready(function() {
  $('.custom_checkbox').on('click', function(event) {
    var checkbox = $(event.target);
    var url = checkbox.data('url');
    var email = checkbox.data('email');
    var confirmation = checkbox.siblings('.confirmation');

    console.log(url, checkbox.is(':checked'));
    // $.post('ajax/test.html', function(data) {
    //   $('.result').html(data);
    // });
    if (checkbox.is(':checked')) {
      $.post(url, function(data) {
        console.log('success');
      });

      confirmation.text("Confirmed by " + email);
    }
    else {
      $.ajax({
        url: url,
        type: 'DELETE',
        complete: function(){
          console.log('deleted');
        }
      });

      confirmation.text("Confirmed?");
    }
  });
});
