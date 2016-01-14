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

  var database = [
    //put all the data here!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    "OS",
    "OS_final",
    "OSSSS",
    "鍾葉清",
    "周志遠"
  ]
  $('#demo').tagit({tagSource:database,sortable:true});
  $('#demoGetTags').click(function () {
      showTags($('#demo').tagit('tags'));
  });
});