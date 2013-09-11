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
