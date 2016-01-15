$(document).on('ready page:load', function () {
	$( ".switch input" ).on( "click", function() {
    if($( "input:checked" ).val()=="Note")
    {
      $("#qa-area").addClass('hidden');
      $("#note-pad").removeClass('hidden');
    }
    else
    {
      $("#qa-area").removeClass('hidden');
      $("#note-pad").addClass('hidden'); 
    }		
        
        
	});
});