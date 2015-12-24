$(window).bind('page:change', function(){
  jQuery(".best_in_place").best_in_place();
});


$(document).on('ready page:load', function () {
  // Actions to do
    $('.button').click(function()
     {
      //console.log('click');
      create_chapter();
    });  
});

function create_chapter()
{
  $.post('chapters');
}

function delete_chapter(id)
{
  $.ajax({
    url: 'chapters/'+id,
    type: 'DELETE',
    success: function(result) {
        // Do something with the result
    }
  });
  
}

function exchange_chapter(id1,id2)
{

}