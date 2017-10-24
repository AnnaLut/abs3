var selectedYear = null;
$(function () {
  $('.tiptip a.button, .tiptip button').tipTip();
  $('#tableEstimateZag').jungGridView({
    updateTableUrl: '/barsroot/kaznaestimate/zaglist/',
    userUpdateParamFunc: tableKzagParam,
    updateTableFunc: function () { refrachTableZag(); },
    viewTfoot: true,
    autoLoad: true,
    viewFilter: true,
    buttonToUpdateId: 'bt_tableKzag',
    //trClickFunk: function () { /*showButton(); */ },
    sort: 'NR',
    sortDir: 'DESC'
  });
});

function tableKzagParam() {
  var param = {

  };
  return param;
}
function refrachTableZag() {
  selectedZag = null;
  $('#workContent').html('');
  $('#bt_visaKzag').removeClass('hover');
  $('#bt_removeKzag').removeClass('hover');
}

function selectKZag(elem) {
  selectedZag = $(elem);
  $('#bt_visaKzag').addClass('hover');
  $('#bt_removeKzag').addClass('hover');
  loadGroup();
}

function loadGroup() {
  $('#main').loader();
  $('#workContent').load('/barsroot/kaznaestimate/group/',
      {
        nr: selectedZag.data('nr')
      },
      function () {
        $('#main').loader('remove');
      });
}