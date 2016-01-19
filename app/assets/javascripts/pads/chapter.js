$(document).on('ready page:load', function () {
  // Actions to do
//  console.log('chapter.js load');
    $('.add_chapter_button').click(function()
    {
      console.log('click add chapter button');
      create_chapter();
    });  


    function create_chapter()
    {
      var note_id = $('.note').attr('id');
      console.log($('.note'));
      console.log(note_id);
      $.post('/notes/'+note_id+'/chapters');
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


    $('.bip-chapter-title').bind("ajax:success", function(){
      var chater_id = $(this).attr('chater_id');
      var title = $(this).html();
      var index = $(this).attr('index');
      change_chapter(chater_id,title,index);
    });

    $('.bip-section-title').bind("ajax:success", function(){
      var section_id = $(this).attr('section_id')
      var title = $(this).html();
      var index = $(this).attr('index');
      change_section(section_id,title,index);
    });


    function change_note(note_id,title)
    {
      var chapter = {
        title: title,
        id: note_id,
        index : index
      }
      dispatcher.trigger('note.change_title', chapter);
    }

    function change_chapter(chapter_id,title,index)
    {
      var chapter = {
        title: title,
        id: chapter_id,
        index : index
      }
      dispatcher.trigger('chapter.change_title', chapter);
    }

    function change_section(section_id,title,index)
    {
      var section = {
        title: title,
        id: section_id,
        index : index
      }
      dispatcher.trigger('section.change_title', section);
    }
});


