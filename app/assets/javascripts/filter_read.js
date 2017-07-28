function showRead() {
  $('.link').filter(function() {
    return $(this).data('read')
  }).show()

  $('.link').not(function() {
    return $(this).data('read')
  }).fadeOut()
}

function showUnread() {
  $('.link').filter(function() {
    return $(this).data('read')
  }).fadeOut()

  $('.link').not(function() {
    return $(this).data('read')
  }).show()  
}

$( document ).ready(function() {
  $("#show-read").on("click", showRead);
  $("#show-unread").on("click", showUnread);
})