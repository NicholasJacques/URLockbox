function createLink(e) {
  e.preventDefault()

  let linkData = {
    link: {
      url: $('input[name="link[url]"]').val(),
      title: $('input[name="link[title]"]').val()
    }
  }

  $.ajax({
    url: "/api/v1/links",
    method: "POST",
    data: linkData
  })
  .done(function(newLinkMarkup) {
    $("#links").prepend(newLinkMarkup);
    $('input[name="link[url]"]').val("");
    $('input[name="link[title]"]').val("");
  });
}

$(document).ready(function(){
  $(".new-link").on("click", "#submit-link", createLink);
})

