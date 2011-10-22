jQuery(function() {
  jQuery.support.borderRadius = false;
  jQuery.each(['BorderRadius','MozBorderRadius','WebkitBorderRadius','OBorderRadius','KhtmlBorderRadius'], function() {
    if(document.body.style[this] !== undefined) jQuery.support.borderRadius = true;
    return (!jQuery.support.borderRadius);
  });
});
$(function() {
  if(!$.support.borderRadius) {
    $('.button').each(function() {
      $(this).wrap('<div class="buttonwrap"></div>')
      .before('<div class="corner tl"></div><div class="corner tr"></div>')
      .after('<div class="corner bl"></div><div class="corner br"></div>');
    });
  }
});
