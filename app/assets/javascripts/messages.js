//jQuery(function($) {
////
////    $('div#messages-container table').on('ajax:complete', 'a.mark-as-read',
////        function(event, xhr, status) {
////        alert('aye');
////    });
//    $('a.mark-as-read').bind('ajax:complete', function(event,xhr,status) {
//        alert('yo');
//    });
//});

$('a.mark-as-read').bind('ajax:complete', function(event,xhr,status) {
    alert('yo');
});