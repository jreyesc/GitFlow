# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'change', '#area_id', (evt) ->
    $.ajax
      url: window.update_recommendations_admin_steps_path,
      type: 'GET'
      dataType: 'script'
      data: {
        area_id: $("#area_id option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic area select OK!")