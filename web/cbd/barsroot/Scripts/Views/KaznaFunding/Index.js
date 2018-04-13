//var selectedZag = null;
$(function () {
  $('.tiptip a.button, .tiptip button').tipTip();

});
function refrachTableZag() {
  //selectedZag = null;
  $('#workContent').html('');
  $('#bt_visaFzag').removeClass('hover');
  $('#bt_removeFzag').removeClass('hover');
}

function selectFZag() {
  //selectedZag = $(elem);
  $('#bt_visaFzag').addClass('hover');
  $('#bt_removeFzag').addClass('hover');
  loadFunding();
}

function loadFunding() {
  var selectedZag = $('#tableFundingZag').jungGridView('selectedrow');
  $('#main').loader();
  $('#workContent').load('/barsroot/kaznafunding/funding/',
      {
        nr: selectedZag.data('nr')
      },
      function () {
        $('#main').loader('remove');
      });
}

function visaFzag() {
  var selectedZag = $('#tableFundingZag').jungGridView('selectedrow');
  if (selectedZag != null) {
    $('#main').loader();
    $.post('/barsroot/kaznafunding/fundingzagvisa/',
        { nr: selectedZag.data('nr') },
        function (data, textStatus) {
          $('#main').loader('remove');
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              barsUiAlert(data.message, 'Повідомлення');
              $('#tableFunding').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
              $('#tableFunding').jungGridView('refresh');
            }
          }
        }, 'json');
  }
}

function importDocum(tp) {
  var $form = $('<div />', { 'id': 'dialogImportDocum' });
  $form.dialog({
                autoOpen: true,
                modal: true,
                resizable: false,
                position: 'center',
                title: '',
                width: '680', height: '480',
                close: function () { $('#tableFundingZag').jungGridView('refresh'); $form.remove(); },
                open: function () { }
              }).loader();
  $('<iframe>', {
    src: '/barsroot/docinput/impkpdbf.aspx?tp=' + tp,
    id: 'myFrame',
    frameborder: 0,
    height: 420,
    width: 650
  }).appendTo($form).on('load', function () { $form.loader('remove'); });
}

function viewSelDocum(ref) {
  window.showModalDialog('/barsroot/documentview/default.aspx?ref=' + ref, null, 'dialogWidth:790px;dialogHeight:550px');
}
function removeFzag() {
  var selectedZag = $('#tableFundingZag').jungGridView('selectedrow');
  if (selectedZag != null) {
    barsUiConfirm('Показники будуть видалені', function () {
      $('#main').loader();
      $.post('/barsroot/kaznafunding/fundingzagremove/',
        { nr: selectedZag.data('nr') },
        function (data, textStatus) {
          $('#main').loader('remove');
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              barsUiAlert(data.message, 'Повідомлення');
              $('#tableFundingZag').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
    });
  }
}