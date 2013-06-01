jQuery(function($) {

    $('a.mark-as-read').bind('ajax:success', function(event,xhr,status) {
        $(this).parents("tr").removeClass("warning");
        $('a.mark-as-read').remove();
    });
});