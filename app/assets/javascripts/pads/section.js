$(document).on('ready page:load', function () {
  // Actions to do
  console.log('section.js load');
  /*
    $('.add_section_btn').click(function()
     {
      //console.log('click');
      create_section($(this).attr('id'));
    });
    function create_section(chapter_id)
    {
      console.log('/chapters/'+chapter_id+'/sections');
      $.post('/chapters/'+chapter_id+'/sections');
    }
*/
  
  

    $('.test').click(function()
    {
      console.log('test clicked');
      chat();
    });
    $('.copy_section_btn').click(function()
    {
      copy_section($(this).attr('id'));
    });

    function copy_section(section_id)
    {
      $.post('/sections/'+section_id+'/copy'); 
    }

   

    
    function chat()
    {
      
      console.log(dispatcher);
      var message = {
        name: 'Start taking advantage of WebSockets',
        completed: false
      }    
      dispatcher.trigger('message', message);
    }
});


