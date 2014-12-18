# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


@validateForm = ->
	if $('.send_email :checkbox:checked').length == 0
		### an item is required for complete the form ###
		$('.content_alert').append("<div class='alert alert-info'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>Note!</strong> An item is required for complete the form.</div>")
		false
	else
		inputs = $('.send_email input[name!=reachability][type!=radio]:checked')
		for input in inputs
			$("#hidden_values").append('<input type="hidden" name="item_ids[]" value="' + input.id + '">');
			sockets = $(input).parent().parent().children(".sockets").children("input:checked").val();
			if sockets != undefined
				$("#hidden_values").append('<input type="hidden" name="item_sockets[]" value="' + sockets + '">');
			else
				$("#hidden_values").append('<input type="hidden" name="item_sockets[]" value="0">');
	  	true

ready = ->
	checkboxState = false
	$(".expandable > label").click ->
		div = $(this).parent().children("div")
		$(div).toggleClass("hide")
		if ($(div).hasClass("hide"))
			$(div).find("div:not(.hide)").addClass("hide")
			$(div).find("span.glyphicon-chevron-down").removeClass("glyphicon-chevron-down")
			$(this).parent().find("input").prop('checked', false)
		$(this).children("span").toggleClass("glyphicon-chevron-down")

	$(".send_email input[type='checkbox']").click ->
		$(this).parent().parent().find("input[type='radio']").prop("checked", false)
		$(this).parent().parent().find("label").removeClass("selected")

	$(".sockets input").click ->
		checkbox = $(this).parent().parent().find("input[type='checkbox']")
		if $(checkbox).prop('checked')
			if checkboxState
				$(this).parent().find("label").removeClass("selected")
				$(this).prop('checked', false)
			else
				id = $(this).attr("id")
				$(this).parent().find("label").removeClass("selected")
				$(this).parent().find("label[for=" + id + "]").addClass("selected")

	$(".sockets label").mouseup ->
		checkboxState = $(this).parent().find('input[id=' + $(this).attr('for') + ']').prop('checked')

$(document).ready(ready)
$(document).on('page:load', ready)