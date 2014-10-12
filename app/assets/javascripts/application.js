// listed below.
// This is a manifest file that'll be compiled into application.js, which will include all the files
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery-ui/autocomplete
//= require bootstrap
//
//= require api/api
//
//= require notifiers
//= require events
//= require_self
//

$.ajaxSettings.dataType = 'json';


$(document).on('ready page:load', function() {
    var backToTop = $('div#back-to-top');
    var $window = $(window);

    $.api.controller     = this.body.id;
    $.api.action         = this.body.attributes['data-action'].value;

    if ( typeof $.api[ $.camelCase($.api.controller) ] === 'object' ) $.api[ $.camelCase($.api.controller) ].init();

    $.api.loading = false
});
