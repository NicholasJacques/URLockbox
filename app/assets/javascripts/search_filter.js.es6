$( document ).ready(function(){
  $('#search-filter').keyup( function (data) {
    let query = data.currentTarget.value.toLowerCase()
    searchLinks(query)
  })  
})

function searchLinks(query) {
  $('.link').filter(function() {
    let linkUrl = $(this).data('link-url').toLowerCase()
    let linkTitle = $(this).data('link-title').toLowerCase()

    return linkUrl.includes(query) || linkTitle.includes(query)
  }).show()

  $('.link').not(function() {
    let linkUrl = $(this).data('link-url').toLowerCase()
    let linkTitle = $(this).data('link-title').toLowerCase()

    return linkUrl.includes(query) || linkTitle.includes(query)
  }).fadeOut();
}