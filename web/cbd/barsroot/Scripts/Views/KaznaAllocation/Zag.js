//var selectedZag = null;
$(function () {
  $('.tiptip a.button, .tiptip button').tipTip();
  $('#tableAllocationZag').jungGridView({
    updateTableUrl: '/barsroot/kaznaallocation/zaglist/',
    userUpdateParamFunc: tableAzagParam,
    updateTableFunc: function () { refrachTableZag(); },
    viewTfoot: true,
    autoLoad: true,
    viewFilter: true,
    buttonToUpdateId: 'bt_tableAzag',
    trClickFunk: function () { selectAZag(); },
    sort: 'NR',
    sortDir: 'DESC'
  });
});

function tableAzagParam() {
  var param = {

  };
  return param;
}
function refrachTableZag() {
  //selectedZag = null;
  $('#workContent').html('');
  $('#bt_visaAzag').removeClass('hover');
  $('#bt_removeAzag').removeClass('hover');
}

function selectAZag(elem) {
  //selectedZag = $(elem);
  $('#bt_visaAzag').addClass('hover');
  $('#bt_removeAzag').addClass('hover');
  loadGroup();
}

function loadGroup() {
  var selectedZag = $('#tableAllocationZag').jungGridView('selectedrow');
  if (selectedZag != null) {
    $('#main').loader();
    $('#workContent').load('/barsroot/kaznaallocation/group/',
      {
        nr: selectedZag.data('nr')
      },
      function() {
        $('#main').loader('remove');
      });
  }
}