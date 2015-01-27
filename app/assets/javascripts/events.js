$( document ).ready(function() {

	// FLASH NOTICE ANIMATION
	var show_ajax_message = function(msg, type) {
	    $("#flash-message").html('<div id="'+type+'">'+msg+'</div>');
	    $("#flash-message").fadeIn("slow");
   	    $("#flash-message").delay(2000).fadeOut("slow");
	};

	$(document).ajaxComplete(function(event, request) {
	    var msg = request.getResponseHeader('X-Message');
	    var type = request.getResponseHeader('X-Message-Type');
	    // alert(msg)
	    show_ajax_message(msg, type); //use whatever popup, notification or whatever plugin you want
	});
}); // DocReady