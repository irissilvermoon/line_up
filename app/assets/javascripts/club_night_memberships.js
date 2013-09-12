$(document).ready(function() {
  $('#new-member-link').on("click", function (event) {
    event.stopPropagation();
    event.preventDefault();

    var link = $(event.currentTarget);

    console.log("link href:", link.attr('href'));

    $(".membership-modal").foundation('reveal', 'open', { url: '#new-member-link'});
  });
});


