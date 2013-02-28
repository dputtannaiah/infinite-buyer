// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require facebox
//= require twitter/bootstrap
//= require jquery-ui
//= require jquery.fancybox-1.3.4.pack
//= require bootstrap/admin_validations

$(document).ready(function () {
    $(".ib-fancybox").fancybox(
        {
            'hideOnContentClick': false,
            'padding' : 15,
            'scrolling': 'auto',
            'centerOnScroll': true,
            'transitionIn': 'fade',
            'transitionOut': 'fade',
            'speedIn': 500,
            'speedOut': 500,
            'height': 400,
            'autoDimensions' : false,
            'overlayShow' : true
        });

  $(".datetime_select").datepicker({
    dateFormat: 'yy-mm-dd',
    showAnim: 'slide',
    showButtonPanel: true
  });

  validation_div_element = $('#error_explanation')
  validation_div_element.addClass("alert alertblock alerterror fade in")
  $('#error_explanation > h2').replaceWith('<h4>' + $('#error_explanation > h2').html() + '</h4>');

  $('.allAdminOffers select option:first-child').toggle(function() {
    $(this).closest('select').css('height','300px');
  }, function() {
    $(this).closest('select').css('height','75px');
  });

//  As this is admin functionality Its not required to put client side validation. There is already server side validation exists.
//  $('input.jqueryAdminSearch').click(function(event){
//    var option_size = $(this).closest('tr').find('select#category_ids option:selected').length;
//    if (option_size == 0) {
//      event.preventDefault();
//      alert("Please select at least one Category for searching")
//      return false;
//    }
//    else {
//      return true;
//    }
//  });

  var reg = /^(.)+[@]{1}B$/
  $('.selectAdminCategories option').each(function() {
    if(reg.test($(this).text())) {
      $(this).text($(this).text().split('@')[0]);
      $(this).css({
        "font-weight": 'bold',
        "font-style": 'italic'
      });
    }
  });

});
