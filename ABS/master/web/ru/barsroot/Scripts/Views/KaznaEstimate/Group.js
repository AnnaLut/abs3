$(function () {
  $("#tabsEstimateGroup").tabs();

});
function loadGeneral() {
  $('#tabsEstimateGroup-2').loader();
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  var krk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('krk') : null;
  var kpk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kpk') : null;
  var kvk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kvk') : null;
  var kfk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kfk') : null;
  var bud = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('bud') : null;
  var srk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('srk') : null;
  var nr = typeof (selectedZag) != 'undefined' ? selectedZag.data('nr') : null;
  $('#tabsEstimateGroup-2').load('/barsroot/kaznaEstimate/general/',
      {
        krk: krk,
        kpk: kpk,
        kvk: kvk,
        kfk: kfk,
        bud: bud,
        srk: srk,
        nr: nr
      },
      function () {
        $('#tabsEstimateGroup-2').loader('remove');
      });
}
function loadSpecial() {
  $('#tabsEstimateGroup-3').loader();
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');  
  var krk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null )? selectedGroup.data('krk') : null;
  var kpk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null )? selectedGroup.data('kpk') : null;
  var kvk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null )? selectedGroup.data('kvk') : null;
  var kfk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null )? selectedGroup.data('kfk') : null;
  var bud = (typeof (selectedGroup) != 'undefined' && selectedGroup != null )? selectedGroup.data('bud') : null;
  var srk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null )? selectedGroup.data('srk') : null;
  var nr = typeof (selectedZag) != 'undefined' ? selectedZag.data('nr') : null;
  $('#tabsEstimateGroup-3').load('/barsroot/kaznaEstimate/special/',
      {
        krk: krk,
        kpk: kpk,
        kvk: kvk,
        kfk: kfk,
        bud: bud,
        srk: srk,
        nr: nr
      },
      function () {
        $('#tabsEstimateGroup-3').loader('remove');
      });
}