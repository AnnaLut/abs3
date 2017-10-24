//var getSelectZzag = null;

$(function () {
  $('#tableLiabilitiesZag').jungGridView({
    updateTableUrl: '/barsroot/kaznaliabilities/zaglist/',
    userUpdateParamFunc: tableZzagParam,
    updateTableFunc: function () { updateZzag(); },
    viewTfoot: true,
    autoLoad: true,
    viewFilter: true,
    buttonToUpdateId: 'btRefrLiabZag',
    trClickFunk: function () { selectZzag(); },
    sort: 'NR',
    sortDir: 'DESC'
  });
});

function tableZzagParam() {
  var param = {
    type: document.getElementById('typeZag').value,
    viewMy: document.getElementById('CheckViewMy').checked,
    viewNotPaid: document.getElementById('CheckViewNotPaid').checked
  };
  return param;
}

function selectZzag(elem) {
  $('#bt_oblicAllZag').addClass('hover');
  //var $elem = $(elem);
  //getSelectZzag = $elem;
  loadDocum();
}

function updateZzag() {
  $('#bt_oblicAllZag').removeClass('hover');
  //getSelectZzag = null;
  $('#workContent').html('');
}
function loadDocum() {
  var getSelectZzag = $('#tableLiabilitiesZag').jungGridView('selectedrow');
  $('#main').loader();
  var url = '';
  var zk = getSelectZzag.data('zk');
  if (zk == 0)
    url = '/barsroot/kaznaliabilities/legal/';
  if (zk == 1)
    url = '/barsroot/kaznaliabilities/financial/';
  if (zk == 2)
    url = '/barsroot/kaznaliabilities/documents/';
  $('#workContent').load(
      url,
      {
        nr: getSelectZzag.data('nr')
      },
      function () {
        $('#main').loader('remove');
      });
}
function viewSelDocum(ref) {
  window.showModalDialog('/barsroot/documentview/default.aspx?ref=' + ref, null, 'dialogWidth:790px;dialogHeight:550px');
  /*$('#main').loader();
  $('#childDocumentContent')
      .load('/barsroot/documents/document/?id=' + ref, {},
          function () {
              $('#mainDocument').hide().loader('remove');
              $('#childDocument').show();
          }
      );*/
}

function payAllZag() {
  var getSelectZzag = $('#tableLiabilitiesZag').jungGridView('selectedrow');
  if (getSelectZzag != null) {
    var url = '';
    var zk = getSelectZzag.data('zk');
    if (zk == 0)
      url = '/barsroot/kaznaliabilities/legalpay/';
    if (zk == 1)
      url = '/barsroot/kaznaliabilities/financialoblic/';
    if (zk == 2)
      url = '/barsroot/kaznaliabilities/documentspay/';
    $('#main').loader();
    $.post(url,
      { nr: getSelectZzag.data('nr') },
      function (data, textStatus) {
        $('#main').loader('remove');
        if (textStatus == 'success') {
          if (data.status == 'ok') {
            barsUiAlert(data.message, 'Повідомлення');
            loadDocum();
            //$('#tableLiabilitiesZag').jungGridView('refresh');
          }
          if (data.status == 'error') {
            barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
          }
        }
      }, 'json');
  }
}

function removeLiabZag() {
  var getSelectZzag = $('#tableLiabilitiesZag').jungGridView('selectedrow');
  if (getSelectZzag != null) {
    barsUiConfirm('Документи будуть видалені', function () {
      $('#main').loader();
      $.post('/barsroot/kaznaliabilities/zagremove/',
        { nr: getSelectZzag.data('nr') },
        function (data, textStatus) {
          $('#main').loader('remove');
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              barsUiAlert(data.message, 'Повідомлення');
              $('#tableLiabilitiesZag').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
    });
  }
}

function importDocum(tp, krk) {
  var $form = $('<div />',{'id': 'dialogImportDocum'});
  $form.dialog({
         autoOpen: true,
         modal: true,
         resizable: false,
         position: 'center',
         title: '',
         width: '680', height: '480',
         close: function () {$form.remove(); }
       }).loader();
  $('<iframe>', {
    src: '/barsroot/docinput/impkpdbf.aspx?tp=' + tp + '&krk=' + (krk == undefined ? '' : krk),
    id: 'myFrame',
    frameborder: 0,
    height: 420,
    width: 650
  }).appendTo($form).on('load', function () { $form.loader('remove'); });
}

