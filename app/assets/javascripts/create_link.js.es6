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
  .done(checkResponse)
}

function checkResponse(response) {
  clearErrors()
  if (response.status == 500) {
    flashErrors(response)
  } else {
    addLink(response)
  }
}

function addLink(response) {
  $("#links").prepend(response);
  $('input[name="link[url]"]').val("");
  $('input[name="link[title]"]').val("");
}

function flashErrors(response) {
 $(".errors").append("<p class='error'>" + response.errors.join('. ') + '.' + '</p>');
}

function clearErrors() {
  $(".errors").empty();
}

$(document).ready(function(){
  $(".new-link").on("click", "#submit-link", createLink);
})

