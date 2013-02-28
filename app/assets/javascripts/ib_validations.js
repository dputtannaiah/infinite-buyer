var status;

$('input#SellerSubmit').live('click',function(event){
  if (IB_ACCOUNT_STATUS == "true") {
    status = "true";
    status = SellerAccountValidate();
    if(status == "false"){
      event.preventDefault();
    }
    else {
      return;
    }
  }
});

$('input#BuyerSubmit').live('click',function(event){
  if (IB_ACCOUNT_STATUS == "true") {
    status = "true";
    status = BuyerAccountValidate();
    if(status == "false"){
      event.preventDefault();
    }
    else {
      return ;
    }
  }
});
    
$('input#make-offer').live('click', function(event){
  status = "true";
  status = BuyerOfferValidate();
  if(status == "false") {
    event.preventDefault();
  }
  else {
    return;
  }
});

// Buyer and Seller Registration validation
$('input#BuyerRegister, input#SellerRegister').live('click', function(event){
  status = "true";
  status = UserRegistration();
  if(status == "false") {
    event.preventDefault();
  }
  else {
    return;
  }
});

// Accept Counter date validations

function bidDateValidate(expiry_date) {
  if(isDate(expiry_date)) {
    return true;
  }
  else {
    return false;
  }
}



function SellerAccountValidate()
{
  var zip_code    = /^[0-9][0-9][0-9][0-9][0-9]$/;
  var company_name_format = /^[a-zA-Z0-9]{1,}(.){0,}$/i;
  var Firstname   = $('#SellerFName').val();
  var Lastname    = $('#SellerLName').val();
  var Company     = $('input#SellerCompany').val();
  var Username    = $('#SellerName').val();
  var Email       = $('#SellerEmail').val();
  var PaypalEmail = $('#PaypadEmailID').val();
  var email_status = validateEmail(PaypalEmail);
  var city           = $('#SellerCity').val();
  var suite      = $('#BuyerApt').val();
  var Zip         = $('#SellerZip').val();
  var Phone1      = $('#Phone1').val();
  var Phone2      = $('#Phone2').val();
  var Phone3      = $('#Phone3').val();
  var Address = $('#SellerAddress').val();
  var email_status_normal = validateEmail(Email);
  var address_status = validateUsername(Address);
  var uname_status = validateUsername(Username);
  var city_status = validateUsername(city);
  var suite_status = validatesuite(suite);
  var Firstname_status = validateUsername(Firstname);
  var Lastname_status = validateUsername(Lastname);
  //var phone_length = (Phone1 + Phone2 + Phone3).length
  //var SName     = $('#SellerSName').val();
  //var SEmail    = $('#SellerEmail').val();

  if(Company != '' && !company_name_format.test(Company)) {
    $('#SellerCompanyError').show();
    $('#SellerCompanyError').html("Company name is invalid.")
    status = "false";
  }
  
  else {
    $('#SellerCompanyError').hide();
  }

  if(suite != '' && suite_status == 'false')
  {
    $('#BuyerAptError').show();
    $('#BuyerAptError').html("apt suite doesnot accept only special characters ")
    status = "false";
  }
  
  else
  {
    $('#BuyerAptError').hide();
  }
  if(city != '' && city_status == 'false')
  {
    $('#SellerCityError').show();
    $('#SellerCityError').html("City doesnot accept only special characters or numbers.")
    status = "false";
  }
  
  else
  {
    $('#SellerCityError').hide();
  }

  // copy from here

  if(Firstname == '')
  {
    $('#SellerFnameError').show();
    $('#SellerFnameError').html("First Name is a required field.")
    status = "false";

  }
  else if(Firstname != '' && Firstname_status =='false' )
  {
    $('#SellerFnameError').show();
    $('#SellerFnameError').html("First Name doesnot accept only special character or number")
    status = "false";

  }

  else
  {
    $('#SellerFnameError').hide();
  }

  if(Lastname == '' && (Firstname == '' || Firstname_status == "false"))
  {
    $('#SellerLnameError').show();
    $('#SellerFnameError').show();
    $('#SellerLnameError').html('Lastname is a required field');
    status = "false";
  }
  else if(Lastname != '' && Lastname_status =='false' && (Firstname == '' || Firstname_status == "false"))
  {

    $('#SellerFnameError').show();
    $('#SellerLnameError').show();
    $('#SellerLnameError').html("Last Name doesnot accept only special character or number")
    status = "false";

  }

  else if( (Firstname != '' || Firstname_status == "true") && (Lastname == ''))
  {

    $('#SellerFnameError').show();
    $('#SellerFnameError').html('&nbsp;');
    $('#SellerLnameError').show();
    $('#SellerLnameError').html('Lastname is a required field');
    status = "false";

  }

  else if( (Firstname != '' || Firstname_status == "true") && (Lastname != '' && Lastname_status == "false"))
  {

    $('#SellerFnameError').show();
    $('#SellerFnameError').html('&nbsp;');
    $('#SellerLnameError').show();
    $('#SellerLnameError').html('Last Name doesnot accept only special character or number');
    status = "false";
  }

  else {
    $('#SellerLnameError').hide();
  }

  //COPY ENDS

  if($('#SellerName').length > 0) {
    if(Username == '')
    {
      $('#SellerUsernameError').show();
      $('#SellerUsernameError').html("Please enter Infinite Buyer Screen Name to register.");
      status = "false";

    }
    else if(Username.length < 6 )
    {
      $('#SellerUsernameError').show();
      $('#SellerUsernameError').html("Please enter Infinite Buyer Screen Name of at least 6 characters.");
      status = "false";

    }
    else if(Username != '' && uname_status == 'false' ){
      $('#SellerUsernameError').show();
      $('#SellerUsernameError').html("Infinite Buyer Screen Name should atleast contain one character");
      status = "false";
    }

    else
    {
      $('#SellerUsernameError').hide();

    }
  }
  
  if(Address != '' && address_status == 'false')
  {
    $('#SellerAddressError').show();
    $('#SellerAddressError').html("Address doesnot accept only special characters or numbers.");
    status = "false";
  }
  else
  {
    $('#SellerAddressError').hide();

  }

  if($('#SellerEmail').length > 0) {
    
    if(Email == '' && Username != '' && Username.length >= 6)
    {
      $('#SellerEmailError').show();
      $('#SellerEmailError').html("Email is a required field.");
      $('#SellerUsernameError').show();
      $('#SellerUsernameError').html('&nbsp;');
      status = "false";

    }
    else if(email_status_normal == "false" && Username != '' && Username.length >= 6 ) {
      $('#SellerEmailError').show();
      $('#SellerEmailError').html('Please enter valid Email ID.');
      $('#SellerUsernameError').show();
      $('#SellerUsernameError').html('&nbsp;');
      status = "false";
    }
    else if(Email == '')
    {
      $('#SellerEmailError').show();
      $('#SellerEmailError').html("Email is a required field.");
      status = "false";
    }

    else if(email_status_normal == "false")
    {
      $('#SellerEmailError').show();
      $('#SellerEmailError').html("Please enter valid Email ID.");
      status = "false";
    }


    else {
      $('#SellerEmailError').hide();
    }
    
  }

  if(PaypalEmail == '') {
    $('#SellerPaypalEmailError').show();
    $('#SellerPaypalEmailError').html("Plese enter Paypal Email ID");
    status = "false";
  }
  else if(email_status == "false") {
    $('#SellerPaypalEmailError').show();
    $('#SellerPaypalEmailError').html('Please enter valid Paypal Email ID.');
    status = "false";
  }
  else {
    $('#SellerPaypalEmailError').hide();
  }

  if(Zip == '')
  {
    $('#SellerZipError').show();
    $('#SellerZipError').html("Zip code is a required field.");
    status = "false";
  }
  else if(zip_code.test(Zip) && (Zip.length >=1 && Zip.length < 5) || Zip.length > 5)
  {
    $('#SellerZipError').show();
    $('#SellerZipError').html("Zip code should be exactly 5 digits.");
    status = "false";
  }
  else if(!zip_code.test(Zip)) {
    $('#SellerZipError').show();
    $('#SellerZipError').html("Zip code should be numeric.");
    status = "false";
  }
  else
  {
    $('#SellerZipError').hide();
  }

  if(Phone1 == '')
  {
    $('#SellerPhone1Error').show();
    $('#SellerPhone1Error').html("Phone Number Area code is required.");
    status = "false";
  }
  else if(Phone1.length >=1 && Phone1.length < 3)
  {
    $('#SellerPhone1Error').show();
    $('#SellerPhone1Error').html("Phone Number Area code is invalid.");
    status = "false";
  }
  else {
    $('#SellerPhone1Error').hide();
  }

  if(Phone2 == '')
  {
    $('#SellerPhone2Error').show();
    $('#SellerPhone2Error').html("Phone Number Prefix is required.");
    status = "false";
  }
  else if(Phone2.length >=1 && Phone2.length < 3)
  {
    $('#SellerPhone2Error').show();
    $('#SellerPhone2Error').html("Phone Number Prefix is invalid.");
    status = "false";
  }
  else {
    $('#SellerPhone2Error').hide();
  }

  if(Phone3 == '')
  {
    $('#SellerPhone3Error').show();
    $('#SellerPhone3Error').html("Phone Number Suffix is required");

    status = "false";
  }
  else if(Phone3.length >= 1 && Phone3.length < 4)
  {
    $('#SellerPhone3Error').show();
    $('#SellerPhone3Error').html("Phone Number Suffix is invalid.");
    status = "false";
  }
  else {
    $('#SellerPhone3Error').hide();
  }

  return status;
}

function BuyerAccountValidate()
{
  var zip_code = /^[0-9][0-9][0-9][0-9][0-9]$/;
  var Firstname = $('#BuyerFName').val();
  var Lastname  = $('#BuyerLName').val();
  var Zip       = $('#BuyerZip').val();
  var Username  = $('#BuyerName').val();
  var Email     = $('#BuyerEmail').val();
  var email_status_normal = validateEmail(Email);
  var Phone1        = $('#Phone1').val();
  var Phone2        = $('#Phone2').val();
  var Phone3        = $('#Phone3').val();
  var uname_status  = validateUsername(Username);
  var Address       = $('#BuyerAddress').val();
  var city          = $('#BuyerCity').val();
  var suite         = $('#BuyerApt').val();

  //var SName     = $('#SellerSName').val();
  //var SEmail    = $('#SellerEmail').val();
  var address_status = validateUsername(Address);
  var city_status = validateUsername(city);
  var suite_status = validatesuite(suite);
  var Firstname_status = validateUsername(Firstname);
  var Lastname_status = validateUsername(Lastname);

  // copy from here
  
  if(Firstname == '')
  {
    $('#BuyerFnameError').show();
    $('#BuyerFnameError').html("First Name is a required field.")
    status = "false";

  }
  else if(Firstname != '' && Firstname_status =='false' )
  {
    $('#BuyerFnameError').show();
    $('#BuyerFnameError').html("First Name doesnot accept only special character or number")
    status = "false";

  }
  
  else
  {
    $('#BuyerFnameError').hide();
  }

  if(Lastname == '' && (Firstname == '' || Firstname_status == "false"))
  {
    $('#BuyerLnameError').show();
    $('#BuyerFnameError').show();
    $('#BuyerLnameError').html('Lastname is a required field');
    status = "false";
  }
  else if(Lastname != '' && Lastname_status =='false' && (Firstname == '' || Firstname_status == "false"))
  {
    
    $('#BuyerFnameError').show();
    $('#BuyerLnameError').show();
    $('#BuyerLnameError').html("Last Name doesnot accept only special character or number")
    status = "false";

  }

  else if( (Firstname != '' || Firstname_status == "true") && (Lastname == ''))
  {

    $('#BuyerFnameError').show();
    $('#BuyerFnameError').html('&nbsp;');
    $('#BuyerLnameError').show();
    $('#BuyerLnameError').html('Lastname is a required field');
    status = "false";

  }

  else if( (Firstname != '' || Firstname_status == "true") && (Lastname != '' && Lastname_status == "false"))
  {

    $('#BuyerFnameError').show();
    $('#BuyerFnameError').html('&nbsp;');
    $('#BuyerLnameError').show();
    $('#BuyerLnameError').html('Last Name doesnot accept only special character or number');
    status = "false";
  }
  
  else {
    $('#BuyerLnameError').hide();
  }

  //COPY ENDS

  if($('#BuyerName').length > 0) {
    
    if(Username == '')
    {
      $('#BuyerUsernameError').show();
      $('#BuyerUsernameError').html("Infinite Buyer Screen Name is a required field.");
      status = "false";

    }
    else if(Username.length < 6 )
    {
      $('#BuyerUsernameError').show();
      $('#BuyerUsernameError').html("Please enter Infinite Buyer Screen Name of at least 6 characters.");
      status = "false";

    }
    else if(Username != '' && uname_status == 'false' ){
      $('#BuyerUsernameError').show();
      $('#BuyerUsernameError').html("Infinite Buyer Screen Name should atleast contain one character");
      status = "false";
    }
    else
    {
      $('#BuyerUsernameError').hide();

    }
  }
  
  if(Address != '' && address_status == 'false')
  {
    $('#BuyerAddressError').show();
    $('#BuyerAddressError').html("Address doesnot accept only special characters or numbers.");
    status = "false";
  }
  else
  {
    $('#BuyerAddressError').hide();

  }

  if($('#BuyerEmail').length > 0) {

    if(Email == '' && Username != '' && Username.length >= 6)
    {
      $('#BuyerEmailError').show();
      $('#BuyerEmailError').html("Email is a required field.");
      $('#BuyerUsernameError').show();
      $('#BuyerUsernameError').html('&nbsp;');
      status = "false";

    }
    else if(email_status_normal == "false" && Username != '' && Username.length >= 6) {
      $('#BuyerEmailError').show();
      $('#BuyerEmailError').html('Please enter valid Email ID.');
      $('#BuyerUsernameError').show();
      $('#BuyerUsernameError').html('&nbsp;');
      status = "false";
    }
    else if(Email == '')
    {
      $('#BuyerEmailError').show();
      $('#BuyerEmailError').html("Email is a required field.");
      status = "false";
    }

    else if(email_status_normal == "false")
    {
      $('#BuyerEmailError').show();
      $('#BuyerEmailError').html("Please enter valid Email ID.");
      status = "false";
    }


    else {
      $('#BuyerEmailError').hide();
    }
    
  }
  
  if(suite != '' && suite_status == 'false')
  {
    $('#BuyerAptError').show();
    $('#BuyerAptError').html("apt suite doesnot accept only special characters ")
    status = "false";
  }
  else
  {
    $('#BuyerAptError').hide();
  }

  if(city != '' && city_status == 'false')
  {
    $('#BuyerCityError').show();
    $('#BuyerCityError').html("City doesnot accept only special characters or numbers.")
    status = "false";
  }
  else
  {
    $('#BuyerCityError').hide();
  }
  

  if(Zip == '')
  {
    $('#BuyerZipError').show();
    $('#BuyerZipError').html("Zip Code is a required field.");
    status = "false";
  }
  else if(zip_code.test(Zip) && (Zip.length >=1 && Zip.length < 5) || Zip.length > 5)
  {
    $('#BuyerZipError').show();
    $('#BuyerZipError').html("Zip Code should be exactly 5 digits.");
    status = "false";
  }

  else if(!zip_code.test(Zip)) {
    $('#BuyerZipError').show();
    $('#BuyerZipError').html("Zip Code should be numeric.");
    status = "false";
  }
  else
  {
    $('#BuyerZipError').hide();
  }

  if(Phone1.length >=1 && Phone1.length < 3)
  {
    $('#BuyerPhone1Error').show();
    $('#BuyerPhone1Error').html("Phone Number Area code is invalid.");
    status = "false";
  }
  else {
    $('#BuyerPhone1Error').hide();
  }

  if(Phone2.length >=1 && Phone2.length < 3)
  {
    $('#BuyerPhone2Error').show();
    $('#BuyerPhone2Error').html("Phone Number Prefix is invalid.");
    status = "false";
  }
  else {
    $('#BuyerPhone2Error').hide();
  }

  if(Phone3.length >=1 && Phone3.length < 3)
  {
    $('#BuyerPhone3Error').show();
    $('#BuyerPhone3Error').html("Phone Number Suffix is invalid.");
    status = "false";
  }
  else {
    $('#BuyerPhone3Error').hide();
  }

  return status;
}


function BuyerOfferValidate(){
  var OfferText = $('input#offer_text').val();
  var OfferPrice = $('input#offer_price').val();

  if(OfferText == '') {
    $('#OfferItemError').show();
    $('#OfferItemError').html("Please enter your item description.");
    status = "false";
  }
  else {
    $('#OfferItemError').hide();
  }

  if(OfferText != '' && OfferPrice == '') {
    $('#OfferPriceError').show();
    $('#OfferItemError').show();
    $('#OfferItemError').html("&nbsp;");
    status = "false";
  }
  else if(OfferPrice == '0.00' && OfferText != '') {
    $('#OfferPriceError').show();
    $('#OfferPriceError').html("Offer price must be greater than $0.00")
    $('#OfferItemError').show();
    $('#OfferItemError').html('&nbsp;');
    status = "false";
  }
    

  if(OfferPrice == '0.00' && OfferText == '') {
    $('#OfferPriceError').show();
    $('#OfferPriceError').html("Offer price must be greater than $0.00")
    $('#OfferItemError').show();
    $('#OfferItemError').html('Please enter your item description.');
    status = "false";
  }

  return status;
}

function UserRegistration(){
  var Username = $('input#UserScreen').val();
  var Email = $('input#UserEmail').val();
  var email_status = validateEmail(Email);
  var Password = $('input#UserPassword').val();
  var PasswordConfirm = $('input#UserPasswordConfirm').val();
  var username_status = validateUsername(Username);

  if(Username == '') {
    $('#IBUsernameError').show();
    $('#IBUsernameError').html('Please enter Infinite Buyer Screen Name to Register.');
    status = "false";
  }

  else if(Username.length >=1 && Username.length < 6 ) {
    $('#IBUsernameError').show();
    $('#IBUsernameError').html('Please enter Infinite Buyer Screen Name of at least 6 characters to Register.');
    status = "false";
  }

  else if(Username.length > 100 ) {
    $('#IBUsernameError').show();
    $('#IBUsernameError').html('Please enter Infinite Buyer Screen Name of less than 100 characters to Register.');
    status = "false";
  }
  else if(Username != '' && username_status == "false" ) {
    $('#IBUsernameError').show();
    $('#IBUsernameError').html('Infinite Buyer Screen Name should atleast contain one character');
    status = "false";
  }
  else {
    $('#IBUsernameError').hide();
  }

  if(Email == '') {
    $('#IBEmailError').show();
    $('#IBEmailError').html('Please enter Email to Register.');
    status = "false";
  }

  else if(email_status == "false") {
    $('#IBEmailError').show();
    $('#IBEmailError').html('Please enter valid Email to Register.');
    status = "false";
  }
  else {
    $('#IBEmailError').hide();
  }

  if ($('input#UserPassword').length > 0 && $('input#UserPasswordConfirm').length > 0 ) {

    if (Password == ''){
      $('#IBPasswordError').show();
      $('#IBPasswordError').html('Please enter Password to register');
      status = "false";
    }
    else if(Password.length >=1 && Password.length <= 6 )
    {
      $('#IBPasswordError').show();
      $('#IBPasswordError').html('Password is too short');
      status = "false";
    }
    else {
      $('#IBPasswordError').hide();
    }


    if(Password != '' && (PasswordConfirm == ''|PasswordConfirm != '') && Password != PasswordConfirm ){
      $('#IBPasswordConfirmError').show();
      $('#IBPasswordConfirmError').html('Please enter Correct Password to match');
      status = "false";
    }

    else {
      $('#IBPasswordConfirmError').hide();
    }
    
  }
  
  return status;
}

function validatesuite(suite){
  var f = /[a-zA-Z0-9]{1,}/;
  if(!f.test(suite)){
    return "false";
  }
  else{
    return "true";
  }
}
function validateUsername(Username){
  var f = /[a-zA-Z]{1,}/;
  if(f.test(Username)){
    return "true";
  }
  else{
    return "false";
  }
}

function validateEmail(email){
  var filter = /^((\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*?)\s*;?\s*)+/;
  if(filter.test(email)){
    return "true";
  }
  else{
    return "false";
  }
}


