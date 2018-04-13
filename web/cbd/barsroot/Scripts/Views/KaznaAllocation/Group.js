$(function () {
  $("#tabsAllocationGroup").tabs();

});
function loadGeneral() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  $('#tabsAllocationGroup-2').loader();
  var krk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('krk') : null;
  var kpk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kpk') : null;
  var kvk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kvk') : null;
  var kfk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kfk') : null;
  var bud = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('bud') : null;
  var srk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('srk') : null;
  var nr = typeof (selectedZag) != 'undefined' ? selectedZag.data('nr') : null;
  $('#tabsAllocationGroup-2').load('/barsroot/kaznaallocation/general/',
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
        $('#tabsAllocationGroup-2').loader('remove');
      });
}
function loadSpecial() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');  
  $('#tabsAllocationGroup-3').loader();
  var krk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null)? selectedGroup.data('krk') : null;
  var kpk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null)? selectedGroup.data('kpk') : null;
  var kvk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null)? selectedGroup.data('kvk') : null;
  var kfk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null)? selectedGroup.data('kfk') : null;
  var bud = (typeof (selectedGroup) != 'undefined' && selectedGroup != null)? selectedGroup.data('bud') : null;
  var srk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null)? selectedGroup.data('srk') : null;
  var nr = typeof (selectedZag) != 'undefined' ? selectedZag.data('nr') : null;
  $('#tabsAllocationGroup-3').load('/barsroot/kaznaallocation/special/',
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
        $('#tabsAllocationGroup-3').loader('remove');
      });
}