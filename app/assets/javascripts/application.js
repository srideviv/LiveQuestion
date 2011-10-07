// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){

				// Accordion
				$("#Stats").accordion({ speed: "5", autoHeight: false, collapsible: true});
				//$("#accordion3").accordion({ speed: "5", fillSpace: false, autoHeight: false, header:"h5", collapsible: true});
				// Tabs
				$("#tabs").tabs({event:"mouseover"});
			});
