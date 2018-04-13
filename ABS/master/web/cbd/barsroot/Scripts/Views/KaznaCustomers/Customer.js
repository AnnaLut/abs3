$(function() {
  var customer = $('#customer');
  customer.find('input[name="edrpou"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  customer.find('input[name="koatuu"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  customer.find('input[name="dpi"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  customer.find('input[name="zip"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  customer.find('input[name="mtk"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  customer.find('input[name="tel1"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  customer.find('input[name="tel2"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  customer.find('input[name="fax"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
});

