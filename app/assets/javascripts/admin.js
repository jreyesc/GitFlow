// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery-ui/sortable
//= require jquery-ui/effect-highlight
//= require 'jquery.rich_textarea.js'
//= require 'jquery.ui.autocomplete.html.js'
//= require bootstrap
//= require bootstrap-datepicker
//= require turbolinks
//= require_tree ./admin
//= require jquery.validationEngine
//= require jquery.validationEngine-en
//= require jquery_nested_form
//= require bootstrap-wysihtml5
//= require bootstrap-wysihtml5/locales/en-US

$(document).ready(function (){
	$('.wysihtml5').each(function(i, elem) {
		$(elem).wysihtml5({
			toolbar: {
				"font-styles": true, //Font styling, e.g. h1, h2, etc. Default true
				"emphasis": true, //Italics, bold, etc. Default true
				"lists": false, //(Un)ordered lists, e.g. Bullets, Numbers. Default true
				"html": true, //Button which allows you to edit the generated HTML. Default false
				"link": true, //Button to insert a link. Default true
				"image": false, //Button to insert an image. Default true,
				"color": true, //Button to change color of font  
				"blockquote": false, //Blockquote  
			}
		});
	});
});

$(document).on('page:load', function(){
	window['rangy'].initialized = false;

	$('.wysihtml5').each(function(i, elem) {
		$(elem).wysihtml5({
			toolbar: {
				"font-styles": true, //Font styling, e.g. h1, h2, etc. Default true
				"emphasis": true, //Italics, bold, etc. Default true
				"lists": false, //(Un)ordered lists, e.g. Bullets, Numbers. Default true
				"html": true, //Button which allows you to edit the generated HTML. Default false
				"link": true, //Button to insert a link. Default true
				"image": false, //Button to insert an image. Default true,
				"color": true, //Button to change color of font  
				"blockquote": false, //Blockquote  
			}
		});
	});
});