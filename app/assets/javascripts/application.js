// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require ui/jquery-ui-1.8.21.custom.min

//= require twitter/bootstrap
//= require facebox
//= require metadata
//= require jquery.validate.min
//= require jquery.fancybox-1.3.4.pack
//= require jsCarousel-2.0.0
//= require infinite_buyer
//= require validate_date
//= require ib_validations



//Ajax
$.ajaxSetup({
    cache:false,
    'beforeSend':function (xhr) {
        xhr.setRequestHeader("Accept", "");
        xhr.setRequestHeader("Accept", "text/javascript")
    }
});

// Global ajax activity indicators.
$(document).ajaxStart(
    function () {
        $('#ajax-indicator').show();

    }).ajaxStop(function () {
    $('#ajax-indicator').hide();
});

jQuery(document).ready(function() {
    $("[data-youtube='true']").click(function() {
        $.fancybox({
            'padding'		: 0,
            'autoScale'		: false,
            'transitionIn'	: 'none',
            'transitionOut'	: 'none',
            'title'			: this.title,
            'width'		: 680,
            'height'		: 495,
            'href'			: this.href.replace(new RegExp("watch\\?v=", "i"), 'v/'),
            'type'			: 'swf',
            'swf'			: {
                'wmode'		: 'transparent',
                'allowfullscreen'	: 'true'
            }
        });

        return false;
    });

    var offer_price = $('div.offer-price > input');
    offer_price.val(parseFloat(offer_price.val()).toFixed(2));

    //Function to restrict some keys
    var restrict_keys = function(event) {
        // Allow: backspace, delete, tab, escape, and enter
        if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
            // Allow: Ctrl+A
            (event.keyCode == 65 && event.ctrlKey === true) || event.keyCode == 110 || event.keyCode == 190 ||
            // Allow: home, end, left, right
            (event.keyCode >= 35 && event.keyCode <= 39)) {
            // let it happen, don't do anything
            return;
        }
        else {
            // Ensure that it is a number and stop the keypress
            if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105 )) {
                event.preventDefault();
            }
        }
    }

    $(offer_price).focusout(function() {
        if ($(this).val() == '') {
            $(this).val(0.00);
        }
        $(this).val(parseFloat($(this).val()).toFixed(2)); // IMPORTANT
    });

    $(offer_price).keydown(function(event) {
        restrict_keys(event);
    });


    var check_status = function() {
        if ($('div.admin-seller-search input:checkbox:checked').length > 0) {
            $('div.admin-seller-search input[type="submit"]').removeAttr('disabled', 'disabled');
        }
        else {
            $('div.admin-seller-search input[type="submit"]').attr('disabled', 'disabled');
        }
    }
    check_status();
    $('div.admin-seller-search input:checkbox').click(function() {
        $(check_status);
    });

    $('input[type=checkbox]').click(function(){
        if($(this).is(':checked')){
            $(this).parent('div').next('div.nested-messages').find('input[type=checkbox]').attr('checked','checked');
        }
        else {
            $(this).parent('div').next('div.nested-messages').find('input[type=checkbox]').removeAttr('checked','checked');
        }

    });

});

function categories(category_id, category_type){
    $(".category_type_0").hide();
    $(".category_type_1").hide();
    $(".category_type_" + category_type).show();
    $("ul#navlist li a.category_type_" + category_type).removeClass('active');
    $("ul#navlist li a.category_type_" + category_type + ":first").addClass('active')
    //$('.children').hide();
    //$("#category_" + category_id).show();
    $('.nested-messages').hide();

    //Raghu
    $('div.ib-seller-content-key textarea').hide();
    $('div.ib-seller-content-key textarea.text-category-' + category_id).show();
    $('div.ib-seller-content-key textarea.neg-text-category-' + category_id).show();

    var text_category = "textarea.text-category-"+ category_id
    var neg_text_category = 'textarea.neg-text-category-' + category_id


    var old_txt_val = $(text_category).val();
    var old_neg_txt_val = $(neg_text_category).val();

    var checked_len = $('div#category_' + category_id).find('input[type="checkbox"]:checked').length;
    
    var default_text = /please select category to enter additonal keywords/i;

    if (checked_len <= 0 ) {
        $(text_category).attr('disabled', 'disabled');
        $(neg_text_category).attr('disabled', 'disabled');
        $(text_category).val("Please select category to enter additonal keywords")
        $(neg_text_category).val("Please select category to enter additonal keywords")
        $(text_category).css('color','grey');
        $(neg_text_category).css('color','grey');
    }

    $('div#category_' + category_id).find('input[type="checkbox"]').click(function() {
        var checked_len = $('div#category_' + category_id).find('input[type="checkbox"]:checked').length;
        if(checked_len > 0) {

            if(!default_text.test($(text_category).val())) {
                old_txt_val = $(text_category).val();
            }

            if(!default_text.test($(neg_text_category).val())) {
                old_neg_txt_val = $(neg_text_category).val();
            }

            $(text_category).removeAttr('disabled');
            $(neg_text_category).removeAttr('disabled');

            $(text_category).val(old_txt_val);
            $(neg_text_category).val(old_neg_txt_val)

            $(text_category).css('color', 'black');
            $(neg_text_category).css('color', 'black');
        }
        else {
            old_txt_val = $(text_category).val();
            old_neg_txt_val = $(neg_text_category).val();

            $(text_category).attr('disabled', 'disabled');
            $(neg_text_category).attr('disabled', 'disabled');

            $(text_category).val("Please select category to enter additonal keywords")
            $(neg_text_category).val("Please select category to enter additonal keywords")
            $(text_category).css('color','grey');
            $(neg_text_category).css('color','grey');
        }
        
    });

    $('textarea').focus(function(){
        if(default_text.test($(this).val())) {
            $(this).val("")
        }
    })

    
    return false;
}







