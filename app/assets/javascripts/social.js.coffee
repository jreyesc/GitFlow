fb_root = null
fb_events_bound = false

ready = ->
  loadFacebookSDK()
  bindFacebookEvents() unless fb_events_bound

bindFacebookEvents = ->
  $(document)
    .on('page:fetch', saveFacebookRoot)
    .on('page:change', restoreFacebookRoot)
    .on('page:load', ->
      FB?.XFBML.parse()
    )
  fb_events_bound = true

saveFacebookRoot = ->
  fb_root = $('#fb-root').detach()

restoreFacebookRoot = ->
  if $('#fb-root').length > 0
    $('#fb-root').replaceWith fb_root
  else
    $('body').append fb_root

loadFacebookSDK = ->
  $.getScript("//connect.facebook.net/en_US/all.js#xfbml=1")
  window.fbAsyncInit = initializeFacebookSDK

initializeFacebookSDK = ->
  FB.init
    appId     : '594345320687634'
    status    : true
    cookie    : true

$(document).ready(ready)
$(document).on('page:load', ready)