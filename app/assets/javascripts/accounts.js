// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
    $('input#account_phone1').keydown(function(){
    var leng = $('input#account_phone1').val().length;
    if(leng >= 3) {
        $('input#account_phone2').select();
    }
});

$('input#account_phone2').keydown(function(){
    var leng = $('input#account_phone2').val().length;
    if(leng >= 3) {
        $('input#account_phone3').select();
    }
});

    
});
