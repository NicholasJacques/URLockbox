function updateLinkStatus(e) {
  e.preventDefault();

  var $link = $(this).parents('.link');
  var linkId = $link.data('link-id');

  $.ajax({
    type: "PATCH",
    url: "/api/v1/links/" + linkId,
    data: e.data,
  }).then(updatePageLinkStatus)
    .fail(displayFailure);
}

function updatePageLinkStatus(link) {
  $(`.link[data-link-id=${link.id}]`)
    .find(".read-status")
    .text("Read? " + link.read);

  $(`.link[data-link-id=${link.id}]`).toggleClass('read');
  
  updateReadButton(link);
  updateHotReads(link)
}

function updateHotReads(link) {
  $.ajax({
    type: "POST",
    url: "https://ndj-hot-reads.herokuapp.com//api/v1/reads",
    data: {link: link},
  }).then(logResult)
    .fail(displayFailure);
}

function logResult(data) {
  console.log(data)
}

function updateReadButton(link) {
  var button = $(`.link[data-link-id=${link.id}]`).find(".read-button");
  link.read ? button.text("Mark as Unread") : button.text("Mark as Read");
  button.toggleClass("mark-as-read mark-as-unread" );
}

function displayFailure(failureData){
  console.log("FAILED attempt to update Link: " + failureData.responseText);
}

$( document ).ready(function() {
  $("body").on("click", ".mark-as-read", { read: true }, updateLinkStatus);
  $("body").on("click", ".mark-as-unread", { read: false }, updateLinkStatus);  
})