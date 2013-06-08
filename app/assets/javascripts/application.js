// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require alertify


$.fn.alignCenter = function () {
    var left = (screen.width / 2) - ($(this).width() / 2);
    var top = (screen.height / 2) - ($(this).height() / 2);
    return $(this).css({'left': left, 'top': top - 100});
};

$(document).ready(function () {
    $('.contact-link').click(function () {
        var contactId = $(this).data("contact");
        $("#contact_message_contact_id").val(contactId);
        $("#opaco").show();
        $('#popup').alignCenter();
        $("#popup").fadeIn(300);
    });

    $('a.close').click(function(){
        $("#popup").fadeOut(300);
        $("#opaco").hide();
        clear_form();
    });

    $("div.listings-all table tr:odd").addClass("odd")

});

clear_form = function(){

    if ($("form.contact_message")){
        $("form.contact_message input#contact_message_from_email")[0].value = "";
        $("form.contact_message textarea#contact_message_body")[0].value = ""
    }
}











