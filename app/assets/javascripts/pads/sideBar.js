$(document).on('ready page:load', function () {

    //遍歷全部的chapter，將其所有的section加上sortable性質
    temp = $("#chapter").children("#chapter_out");
    temp.each(function()
    {
        var parent = $(this);
        var mid = parent.children(".closeThis").children(".connectedSortable");

        var secId = mid[0].id;

        addSortable(secId);
    });

    //將chapter加上sortable性質
    $( "#chapter" ).sortable({
        placeholder: "ui-state-highlight ui-corner-all", 
        handle: ".header",
        cancel: ".portlet-toggle",
        update: function( event, ui ) {showList();},
        start: function( event, ui ) {startMoving(ui.item);},
        stop: function( event, ui ) {stopMoving(ui.item);}
    }).disableSelection;

    
    bind_like();
    addStyle();
    $('.tgl-flip').click(toggleSideBar);
});
function toggleSideBar()
{
    $('.tag-container').toggleClass('hidden');
    $('.index-container').toggleClass('hidden');
}
//like or not
function bind_like(){
    $(".icon")
    .click(function() {
        var icon = $(this);
        var like_id = icon.attr('id');
        //icon.toggleClass("like-state");
        var type = icon.attr('type');

        //not like
        var value = 1;
        if(icon.hasClass("like-state"))
        {
        //already like
           value = -1; 
        }

        var changeValue = parseInt(icon.next().text())+value;
        icon.toggleClass("like-state");
        icon.next().find('span').text(changeValue);

        $.post('/likes/'+like_id+'/'+type+'_toggle',function(response)
        {
            //icon.toggleClass("like-state");

            if(type=='like')
            {
                var value = 0;
                if(response==true)
                    value = 1;
                else
                    value = -1;

                //var addOne = parseInt(icon.next().text())+value;
                //icon.next().find('span').text(addOne);
            }
        });
    });
}

//section方面的sortable
function addSortable(i){
    $( "#"+i ).sortable({
        handle: ".header",
        connectWith: ".connectedSortable",
        placeholder: "ui-state-highlight-sec",
        update: function( event, ui ) {showList();},
        start: function( event, ui ) {startMoving(ui.item.children(".sec-header"));},
        stop: function( event, ui ) {stopMoving(ui.item.children(".sec-header"));}
    }).disableSelection();
}

//加上header的style
function addStyle(){
    temp  = $(".ui-state-chapter");
    temp.each(function()
    {
        var node = $(this);

        console.log(node.hasClass( "ui-widget" ));
        if(!node.hasClass( "ui-widget" )){
            
            node.addClass( "ui-widget ui-widget-content ui-helper-clearfix ui-corner-all" )
            .find( ".chapter-header" )
            .addClass( "ui-widget-header ui-corner-all" )
            .prepend( "<span class='ui-icon ui-icon-minusthick portlet-toggle chapter-expand-close'></span>");
        }
    });


    temp  = $(".portlet-toggle");
    temp.each(function()
    {
        var node = $(this);

        if(!node.hasClass( "done" )){
            
            node.addClass( "done" )
            .click(function() {
                var icon = $( this );
                icon.toggleClass( "ui-icon-minusthick ui-icon-plusthick" );
                icon.closest( ".ui-state-chapter" ).find( ".closeThis" ).toggle(500);
            });
        }
    });

    //add edit/nonedit button style
    $( '#nonedit' ).addClass( 'hidden' ) 
}

//get order
function showList(){
    index = 0;
    datas = new Array();
    temp = $("#chapter").children("#chapter_out");

    temp.each(function()
    {
        array = [];
        var parent = $(this);
        // var ch = parent.children(".chapter-header");
        var chapter = parent.children(".closeThis").children(".connectedSortable");
        var sections = chapter.children(".ui-state-default");

        // array.push(mid[0].id.substring(7));


        for(i = 0;i < sections.length; i++){
            array.push(sections[i].id.substring(3));
        }

        var object = new Object;
        object.chapter = chapter[0].id.substring(7);
        object.sections = array;


        datas[index] = object;
        index++;
    });
    
    var obj = new Object();
    obj.json = datas;
    var json = JSON.stringify(obj);
    $.post('/notes/reorder',json);
    

    console.log(json);
}

function startMoving(item){
    item.addClass("momImHere");
    console.log(item);
}

function stopMoving(item){
    item.removeClass("momImHere");
}


/* edit */
function move(){
    $(".chapter-header").addClass( "header shake" );
    $(".sec-header").addClass( "header shake" );
    $(".sec-header a").css( "cursor", "move" )
    $("#edit").addClass( "hidden" )
    $("#nonedit").removeClass( "hidden" )
    $(".delButton").css({display: "inline"});
    $(".connectedSortable").css({"list-style": "none"});

}
/* nonedit */
function nonmove(){
    $(".chapter-header").removeClass( "header shake" );
    $(".sec-header").removeClass( "header shake" );
    $(".sec-header a").css( "cursor", "pointer" )
    $("#edit").removeClass( "hidden" )
    $("#nonedit").addClass( "hidden" )
    $(".delButton").css({display: "none"});
    $(".connectedSortable").css({"list-style-type": "circle"});

}


function edit(i){
    name = $("#id").val();
    $( i ).children("span").text(name);
}

function deleteSection(i){
    var id = i.id;
    console.log(i);
    $(i).remove();

    console.log('/sections/'+id.substring(3));
    $.ajax({
         url: '/sections/'+id.substring(3),
         type: 'DELETE',
         success: function(result) {
             // Do something with the result
         }
     });
}


function deleteChapter(i){
    var item = i.parentNode;

    $(item).remove();
    console.log(i.id.substring(13));


     $.ajax({
         url: '/chapters/'+i.id.substring(13),
         type: 'DELETE',
         success: function(result) {
             // Do something with the result
         }
     });
}