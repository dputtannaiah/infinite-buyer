/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
jQuery(document).ready(function($){
  // Loading Facebox
  $('a[rel*=facebox]').facebox();
});

$('.allAdminOffers input[type="submit"]').live('click', function(event){
  var status = "true";
  var offer_text = $(this).closest('tr').find('.offerText').val();
  status = adminOfferValidate(offer_text);
  if(status == "false") {
    $(this).closest('tr').find('div.adminOfferTextError').show();
    event.preventDefault();
  }
  else {
    $(this).closest('tr').find('div.adminOfferTextError').hide();
    return;
  }
});

function adminOfferValidate(offer_text) {
  var status;
  var offer_text_format = /^\s*$/;
  if (offer_text_format.test(offer_text)) {
    status = "false";
  }
  else {
    status = "true";
  }
  return status;
}