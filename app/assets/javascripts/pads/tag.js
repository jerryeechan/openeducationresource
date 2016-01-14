$(document).on('ready page:load', function () { 'use strict';
  function showTags(tags) {
      console.log(tags); 
      var string = "Tags (label : value)\r\n";
      string += "--------\r\n";
      var i;
      for (i in tags) {
          string += tags[i].label + " : " + tags[i].value + "\r\n";
      }
      alert(string);
  }
  $.post('/tags/get',function(response)
  {
      var database = response;
      console.log(response);
      $('#add-tag-field').tagit({tagSource:database,sortable:true,caseSensitive:true,tagsChanged:tagsChanged});
      $('#search-tag-field').tagit({tagSource:database,caseSensitive:true,tagsChanged:tagsChanged});

  });
  

  
  $('#demoGetTags').click(function () {
      showTags($('#search-tag-field').tagit('tags'));
  });

  function tagsChanged(tagValue, action, element)
  {
    if(action =="added")
    {
      $.post('/tags/create?text='+tagValue);
    }
  }
});