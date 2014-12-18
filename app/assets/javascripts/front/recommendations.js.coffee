# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@removeDummy = (x) ->
	elem = document.getElementById('to_delete_'+x)
	elem.parentNode.removeChild(elem)
	false