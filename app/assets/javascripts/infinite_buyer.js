/*jQuery('input#offer_price').keyup(function(e){
dec = $(this).val().split('.')[1];
if(dec.length > 2) {
$(this).val(parseFloat($(this).val()).toFixed(2));
}
}); */

var IB_ACCOUNT_STATUS = "true";
jQuery(document).ready(function($) {
  // Loading Facebox
  $('a[rel*=facebox]').facebox();

  $(document).bind('loading.facebox', function() {
    $('#facebox_overlay').unbind('click');
  });
    
  $("#new_contact").validate();
    
  jQuery.validator.addMethod("phoneUS", function (phone_number, element) {
    phone_number = phone_number.replace(/\s+/g, "");
    return this.optional(element) || phone_number.length > 9 &&
    phone_number.match(/^(1-?)?(\([2-9]\d{2}\)|[2-9]\d{2})-?[2-9]\d{2}-?\d{4}$/);
  }, "Please specify a valid phone number");

  $('a#create-my-offer').click(function(e){
    e.preventDefault();
    var search_radius = $('input#search_radius').val();
    var zip = $('input#zip').val();
    var link_val = $(this).attr('href');
    link_val = link_val + '?' + 'search_radius=' + search_radius + '&zip=' + zip;
    $(this).attr('href',link_val);
  });

  $('select#sort_key_canceled').change(function(){
    $('form#canceled-offers-form').submit();
  });

  //    if($("#BuyerRegForm").length > 0)
  //    {
  //        $("#BuyerRegForm").validate();
  //    }

  if($('input.datepicker').length > 0) {
    $('input.datepicker').datepicker({
      buttonImage: '/assets/ib_myoffer_extend.png',
      buttonImageOnly: true,
      showOn: 'both',
      minDate: +0,
      maxDate: +6,
      onSelect: function(date, instance ) {
        var offer_id = $(this).attr('id').split('-')[1];
        var data = 'date='+date+'&offer_id='+offer_id;
        $.get('/extend-offer', data);
      }
    });

  }

  // Accepted and Counter offers
  $('input#accept-submit').click(function(e){
    var expiry_date = $('input#accept-datepicker').val();
    if(bidDateValidate(expiry_date)) {
      $('div#counter-bid-form').remove();
      $('form#accept-counter-form').submit();
    }
    else {
      e.preventDefault();
      $('#acceptDateError').show();
    }
  });

  $('input#counter-submit').click(function(e){
    var expiry_date = $('input#counter-datepicker').val();
    if(bidDateValidate(expiry_date)) {
      $('div#accept-bid-form').remove();
      $('form#accept-counter-form').submit();
    }
    else {
      e.preventDefault();
      $('#counterDateError').show();
    }

  });

  if($('input#counter-datepicker').length > 0) {
    $('input#counter-datepicker').datepicker({
      minDate: +0,
      dateFormat: "yy-mm-dd",
      showOn: 'button',
      buttonImage: '/assets/ib_calender.png',
      buttonImageOnly: true
    });
  }

  if($('input#accept-datepicker').length > 0) {
    $('input#accept-datepicker').datepicker({
      minDate: +0,
      dateFormat: "yy-mm-dd",
      showOn: 'button',
      buttonImage: '/assets/ib_calender.png',
      buttonImageOnly: true
    });
  }

  // MyAccount settings
  if($('li#myaccount-disabled').length > 0) {
    $('li#myaccount-disabled > a').css('color','grey')
    $('li#myaccount-disabled,li#myaccount-disabled > a ').click(function(e){
      e.preventDefault();
      $('div.ib-buyer-account-form').html('');
      $('div.ib-buyer-account-form').css('height','50px')
    });
  }

  // Home Page Offer price validation
  var offer_price = $('div.offer-price > input, div.offer-price-small > input');
  if(offer_price.length > 0){
    offer_price.val(parseFloat(offer_price.val()).toFixed(2));
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


  var check_admin_status = function() {
    if ($('div.admin-seller-search input:checkbox:checked').length > 0) {
      $('div.admin-seller-search input[type="submit"]').removeAttr('disabled', 'disabled');
    }
    else {
      $('div.admin-seller-search input[type="submit"]').attr('disabled', 'disabled');
    }
  }
  check_admin_status();
  $('div.admin-seller-search input:checkbox').click(function() {
    $(check_admin_status);
  });

  $('div.remove-photos-path > a').click(function(e) {
    e.preventDefault();
  });

  //Home Page Offer price limit number of decimal places to 2 digits
  $('input#offer_price').keyup(function(){
    var dec = $(this).val().split('.')[1];
    if(dec.length > 2) {
      $(this).val($(this).val().slice(0, -1));
      $(this).val(parseFloat($(this).val()).toFixed(2));
    }
  });

  //check_status();
  $('input.ib-buyer-seller-account-submit').click(function(event){
    if(($('input.ib-buyer-seller-account-chk').is(':checked'))) {
      IB_ACCOUNT_STATUS = "true";
      return;
    }
    else {
      event.preventDefault();
      IB_ACCOUNT_STATUS = "false";
      alert("Please accept the Terms and Conditions and Submit");
      $('.error').hide();
    }
  });

  //Seller Inventory
  $('input.ib-seller-submit').click(function(event){
    var len = $('div.parent').find("input[type='checkbox']:checked").length;
    if(len <= 0) {
      alert("Please select atleast one category")
      event.preventDefault();
    }
    else {
      return;
    }

  });

  // WYMEditor update all the instances
  $('.wymupdate').mousedown(function()
  {
    var i;
    var c = WYMeditor.INSTANCES.length;
    for(i = 0; i < c; i++) {
      jQuery.wymeditors(i).update();
    }

  });

}); // Document.Ready ends here...

$('input#BuyerZip').live('keydown', function(event) {
  restrict_keys(event);
});

$('input#SellerZip').live('keydown', function(event) {
  restrict_keys(event);
});
  
  
// Phone - automatically focus to next text box
$('input#Phone1, input#Phone2, input#Phone3').live('keydown',function(event){
  restrict_phone_keys(event);
});

$('input#Phone1').live('keydown',function(event){
  if(((event.keyCode >= 48 && event.keyCode <= 57)||(event.keyCode >= 96 && event.keyCode <= 105)) && $(this).val().length == 3 ) {
    $("input#Phone2").focus();
  }
});

$('input#Phone2').live('keydown',function(event){
  if(((event.keyCode >= 48 && event.keyCode <= 57)||(event.keyCode >= 96 && event.keyCode <= 105)) && $(this).val().length == 3 ) {
    $("input#Phone3").focus();
  }
});

$("input#BuyerFName, input#BuyerLName, input#SellerLName, input#SellerFName,input#BuyerApt,input#BuyerCity,input#SellerCity").live('keydown', function(event){
  allow_alphanumeric_keys(event);
});


// Phone ends here

//jQuery('a#myAccountBuyerLink').live('click', function(event){
//  jQuery.ajax({
//    url: '/edit-buyer',
//    type: 'GET'
//  });
//  return false;
////}
//});

//jQuery('a#seller_account').live('click', function(event){
//  jQuery.ajax({
//    url: '/edit-seller',
//    type: 'GET'
//  });
//  //}
//  return false;
//});
var isShiftKey = false;

var allow_alphanumeric_keys = function(event){
  console.log(event.keyCode);
  // Allow: backspace, delete, tab, escape, and enter
  if(event.shiftKey) isShiftKey = true;
  if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 || event.keyCode == 32 || 
    // Allow: Ctrl+A
    (event.keyCode == 65 && event.ctrlKey === true) || 
    // Allow: home, end, left, right
    (event.keyCode >= 35 && event.keyCode <= 39) ||
    //Allow alphabets
    (event.keyCode >= 65 && event.keyCode <= 90) ||
    // Allow Numbers
    (event.keyCode >= 48 && event.keyCode <= 57 && !isShiftKey) ||
    (event.keyCode >= 96 && event.keyCode <= 105) ||
    // Allow Underscore character
    (event.keyCode == 109 && isShiftKey) ||
    //Allow period character
    ((event.keyCode == 190 && !isShiftKey) || event.keyCode == 110)) {
    // let it happen, don't do anything
    isShiftKey = false;
    return;
  }
  else {
    isShiftKey = false;
    event.preventDefault();
  }

}

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

var restrict_phone_keys = function(event) {
  // Allow: backspace, delete, tab, escape, and enter
  if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
    // Allow: Ctrl+A
    (event.keyCode == 65 && event.ctrlKey === true) ||
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

var check_status = function() {
  if($('input.ib-buyer-seller-account-chk').length > 0 ) {
    if($('input.ib-buyer-seller-account-chk').is(':checked')) {
      $('input.ib-buyer-seller-account-submit').removeAttr('disabled')
    }
    else {
      $('input.ib-buyer-seller-account-submit').attr('disabled', 'disabled')
    }
  }

}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).parent("div.add-photos-path").hide();
}

function restrict_numbers(event) {
  if((event.keyCode >= 48 && event.keyCode <= 57)||(event.keyCode >= 96 && event.keyCode <= 105)) {
    return true;
  }
  else {
    return false;
  }
}

$('select#sort_key').live('change', function(){
  $(this).closest('form').submit();
});



