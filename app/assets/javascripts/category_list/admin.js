$('div.major-category').live('click',function() {
  if($(this).siblings('div.nested-messages_1').css('display') == 'none') {
    $(this).siblings('div.nested-messages_1').css('display','block')
    $(this).prev('div.major-category').find('span').html("<img src='assets/plus_icon.png'></img>")
  }
  else
  {
    $(this).next('div.nested-messages_1').css('display','none')
    $(this).prev('div.major-category').find('span').html("<img src='assets/minus_icon.png'></img>")
  }
});

$('.sub > span.expand-collapse, .sub > .nested-label-class').live('click', function() {
  $(this).parent('div.sub-category').next('.nested-messages_1').toggle('slow', function(){
    var dis = $(this).css('display')
    if(dis == 'none') {
      $(this).prev('div.sub').find('span').html("<img src='assets/plus_icon.png'></img>")
    }
    else
    {
      $(this).prev('div.sub').find('span').html("<img src='assets/minus_icon.png'></img>")
    }
  });
});

$('.sub-category').live('hover', function(){
  $(this).find('input[type=text]').toggle();
});

$('.childless_textbox').live('keypress', function(event) {
  if($(this).siblings('input[type=checkbox]').is(':checked')) {
    return true;
  }
  else {
    event.preventDefault();
    return false;
  }

});

function categories(category_type){
  $(".category_type_0").hide();
  $('.nested-messages_1').hide();
  $(".category_type_" + category_type).show();


  $('a#product').click(function() {
    $(this).addClass('active');
    $('a#jqueryService').removeClass('active');
  });

  $('a#jqueryService').click(function() {
    $(this).addClass('active');
    $('a#product').removeClass('active');
  });

  $('a.jqueryCategoryType').first().addClass('active');
  $('a.jqueryCategoryType').click(function(){
    $('a.jqueryCategoryType').removeClass('active');
    $(this).addClass('active');
  });
}

//Document Ready function starts here

jQuery(document).ready(function($) {
  $('.nested-messages_1').hide();
  $('.expand-collapse').next('label').css({
    'font-size' : '15px',
    'color': '#144E8D',
    'font-weight': 'bold'
  });

  jQuery('#facebox .fbx-close').click(function(){
    $('#facebox_overlay').remove();
    $('#facebox').hide();
  });

//  $('div.major-category').click(function() {
//    if($(this).siblings('div.nested-messages_1').css('display') == 'none') {
//      $(this).siblings('div.nested-messages_1').css('display','block')
//      $(this).prev('div.major-category').find('span').html("<img src='assets/plus_icon.png'></img>")
//    }
//    else
//    {
//      $(this).siblings('div.nested-messages_1').css('display','none')
//      $(this).prev('div.major-category').find('span').html("<img src='assets/minus_icon.png'></img>")
//    }
//  });


});

$('.expand-collapse').next('label').css({
  'font-size' : '15px',
  'color': '#144E8D',
  'font-weight': 'bold'
});

