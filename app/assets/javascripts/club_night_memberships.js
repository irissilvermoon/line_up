$(document).ready(function() {
  $('#new-member-link').on("click", function (event) {
    event.stopPropegation();
    event.preventDefault();

    var link = $(event.currentTarget);

    console.log("link href:", link.attr('href'));
  });
});


