// This adds 'placeholder' to the items listed in the jQuery .support object.
jQuery(function () {
  jQuery.support.placeholder = false;
  var test = document.createElement('input');
  if ('placeholder' in test) jQuery.support.placeholder = true;
});
// This adds placeholder support to browsers that wouldn't otherwise support it.
$(function () {
  if (!$.support.placeholder) {
    //var active = document.activeElement;
    $(':text').focus(function () {
      var $this = $(this);
      if ($this.attr('placeholder') != '' && $this.val() == $this.attr('placeholder')) {
        $this.val('').removeClass('hasPlaceholder');
      }
    }).blur(function () {
      var $this = $(this);      
      if ($this.attr('placeholder') != '' && ($this.val() == '' || $this.val() == $this.attr('placeholder'))) {
        $this.val($this.attr('placeholder')).addClass('hasPlaceholder');
      }
    });
    $(':text').blur();
    //$(active).focus();
    $('form:eq(0)').submit(function () {
      $(':text.hasPlaceholder').val('');
    });
  }
});