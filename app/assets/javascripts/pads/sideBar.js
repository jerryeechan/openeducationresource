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
        update: function( event, ui ) {showList();}
    }).disableSelection;

    addStyle();
});

function Data(chapter, section){
    this.chapter = chapter;
    this.section = section;
}

//section方面的sortable
function addSortable(i){
    $( "#"+i ).sortable({
        handle: ".header",
        connectWith: ".connectedSortable",
        placeholder: "ui-state-highlight-sec",
        update: function( event, ui ) {showList();}
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
            .prepend( "<span class='ui-icon ui-icon-minusthick portlet-toggle'></span>");
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
        var mid = parent.children(".closeThis").children(".connectedSortable");
        var sec = mid.children(".ui-state-default");

        // array.push(mid[0].id.substring(7));


        for(i = 0;i < sec.length; i++){
            array.push(sec[i].id.substring(3));
        }

        datas[index] = new Data(mid[0].id.substring(7), array);
        index++;
    });
    var json = JSON.stringify(datas);
    $.post('note/reorder',json);


    console.log(json);
}



function move(){
    $(".chapter-header").addClass( "header" );
    $(".sec-header").addClass( "header" );
}

function nonmove(){
    $(".chapter-header").removeClass( "header" );
    $(".sec-header").removeClass( "header" );
}

function edit(i){
    name = $("#id").val();
    $( i ).children("span").text(name);
}

function del(i){
    $(i).remove();
}