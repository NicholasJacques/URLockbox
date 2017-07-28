$(document).ready(function(){
  getHotReads()
})

function getHotReads() {
  $.ajax({
    type: "GET",
    url: "https://ndj-hot-reads.herokuapp.com/api/v1/reads"
  }).then(styleHotReads)
    .fail(wtf);
}

function wtf(data) {
  console.log("Something went wrong!")
}

function styleHotReads(data) {
  data.forEach(function(topLink, index) {
    $('.link').each(function(i, link) {
      let linkUrl = $(this).data('link-url').toLowerCase()

      if ((linkUrl === topLink.url) && (index == 0)) {
        $(link).prepend('***TOP LINK***')
        $(link).addClass('top-link')        
      } else if (linkUrl === topLink.url) {
        $(link).addClass('hot')
      }
    })
  })
}