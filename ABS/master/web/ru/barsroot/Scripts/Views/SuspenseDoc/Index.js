//var selectedDoc = null;

$(function () {
  $('.tiptip a.button, .tiptip button').tipTip();
  $('#tableSuspenseDoc').jungGridView({
    updateTableUrl: '/barsroot/kaznasuspensedoc/doclist/',
    userUpdateParamFunc: tableSusDocParam,
    updateTableFunc: function () { refreshTableSusDoc(); },
    viewTfoot: true,
    autoLoad: true,
    viewFilter: true,
    buttonToUpdateId: 'btSubmitSusDoc',
    trClickFunk: function () { selectDoc(); },
    sort: 'REF',
    sortDir: 'DESC'
  });
});
function tableSusDocParam() {
  var param = {

  };
  return param;
}

function selectDoc(elem) {
  //selectedDoc = $(elem);
  $('#bt_removeDoc').addClass('hover');
  $('#bt_restoreDoc').addClass('hover');
  $('#bt_perecreditDoc').addClass('hover');
}
function refreshTableSusDoc() {
  //selectedDoc = null;
  $('#bt_removeDoc').removeClass('hover');
  $('#bt_restoreDoc').removeClass('hover');
  $('#bt_perecreditDoc').removeClass('hover');
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
function restoreDoc(type) {
  var selDoc = $('#tableSuspenseDoc').jungGridView('selectedrow');
  if (selDoc != null) {
    $.post('/barsroot/kaznasuspensedoc/restoredoc/',
         {
           id: selDoc.data('ref'),
           type: type,
           resultType: 'url'
         },
        function (data, textStatus) {
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              window.showModalDialog(data.message, null, 'dialogWidth:610px;dialogHeight:570px;scroll:no;');
            }
            if (data.status == 'error') {
              barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
  }
}

function deleteDoc() {
  var selDoc = $('#tableSuspenseDoc').jungGridView('selectedrow');
  if (selDoc != null) {
    $.post('/barsroot/kaznasuspensedoc/deletedoc/',
         {
           id: selDoc.data('ref')
         },
        function (data, textStatus) {
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              $('#tableSuspenseDoc').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
  }
}