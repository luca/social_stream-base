//= require hoverIntent
//= require superfish
//
$(function() {
    jQuery('ul.sf-menu').superfish({
        delay: 2000, // one second delay on mouseout
        animation: {
            height: 'show'
        }, // fade-in and slide-down animation
        speed: 'fast', // faster animation speed
        autoArrows: false,
        dropShadows: false // disable drop shadows
    });

    $('#tabright> ul').tabs({
        fx: {
             height: 'toggle',
            opacity: 'toggle'
        }
    });
});
