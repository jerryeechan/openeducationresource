$(document).on('ready page:load', function () {
	$( ".switch input" ).on( "click", function() {
  		$( "#log" ).html( $( "input:checked" ).val() + " is checked!" );
	});
});