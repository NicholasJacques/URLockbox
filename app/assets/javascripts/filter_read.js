$( document ).ready(function() {
  $("#show-read").on("click", showRead);
})

function showRead() {
  $('.link').filter(function() {
    return $(this).data('read')
  }).show()

  $('.link').not(function() {
    return $(this).data('read')
  }).fadeOut()
}