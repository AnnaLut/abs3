$(function () {
  $("#tabsLiabGroup").tabs();
  $('#inp_find_krk').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  $('#inp_find_edrpou').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });

  /*$('#tableGroupLiab tbody tr').click(function () {
    var $thisTr = $(this);
    $thisTr.parent().find('tr.selected').removeClass('selected');
    $thisTr.addClass('selected');
    $('#bt_openDdl').addClass('hover');
    selectedGroup = $thisTr;
    submitFormLiab($thisTr);
  });*/
});
function submitFormLiab(elem) {
  $('#liabGroup').loader();
  $('#liabGroup').load('/barsroot/kaznaliabilities/liabgroup/',
      {
        krk: elem.data('krk'),
        kvk: elem.data('kvk'),
        kpk: elem.data('kpk'),
        kfk: elem.data('kfk'),
        bud: elem.data('bud')
      },
      function () {
        $('#liabGroup').loader('remove');
      });
}


function findCust() {
  var krk = $('#inp_find_krk').val();
  var edrpou = $('#inp_find_edrpou').val();
  var name = $('#inp_find_name').val();
  if (krk != '' || edrpou != '' || name != '') {
    $('#main').loader();
    document.location.href = '/barsroot/kaznaliabilities/index/?krk=' + krk + '&edrpou=' + edrpou + '&name=' + name;
    /*$('#custAcc').load('/barsroot/kaznacustacc/customer/',
        {
            krk: krk
        },
        function () { $('#main').loader('remove'); $('#bt_openDdl').removeClass('hover'); }
    );*/
  }
}
function loadFinancial() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  $('#tabsLiabGroup-2').loader();
  $('#tabsLiabGroup-2').load('/barsroot/kaznaliabilities/financial/',
      {
        krk: $('#krk-kod').val(),
        idu: selectedLegal ? selectedLegal.data('id') : null,
        kpk: selectedGroup != null? selectedGroup.data('kpk'):''
      },
      function () {
        $('#tabsLiabGroup-2').loader('remove');
      });
}
function loadDocuments() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  $('#tabsLiabGroup-3').loader();
  $('#tabsLiabGroup-3').load('/barsroot/kaznaliabilities/documents/',
      {
        krk: $('#krk-kod').val(),
        idf: selectedFinancial ? selectedFinancial.data('id') : null,
        kpk: selectedGroup != null? selectedGroup.data('kpk'):''
      },
      function () {
        $('#tabsLiabGroup-3').loader('remove');
      });
}
function showFindCustParam() {
  $('#find_cust_div').slideToggle();
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
function importDocum(tp) {
  var $form = $('<div />', { 'id': 'dialogImportDocum' });
  $form.dialog({
    autoOpen: true,
    modal: true,
    resizable: false,
    position: 'center',
    title: '',
    width: '680', height: '480',
    close: function () { $('#tableAllocationZag').jungGridView('refresh'); $form.remove(); }
  });
  $('<iframe>', {
    src: '/barsroot/docinput/impkpdbf.aspx?tp=' + tp,
    id: 'myFrame',
    frameborder: 0,
    height: 420,
    width: 650
  }).appendTo($form).on('load', function () { $form.loader('remove'); });
}
function removeAzag() {
  var selectedZag = $('#tableAllocationZag').jungGridView('selectedrow');
  if (selectedZag != null) {
    barsUiConfirm('Документи будуть видалені', function () {
      $('#main').loader();
      $.post('/barsroot/kaznaallocation/zagremove/',
        { nr: selectedZag.data('nr') },
        function (data, textStatus) {
          $('#main').loader('remove');
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              barsUiAlert(data.message, 'Повідомлення');
              $('#tableAllocationZag').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
    });
  }
}
function visaAzag() {
  var selectedZag = $('#tableAllocationZag').jungGridView('selectedrow');
  if (selectedZag != null) {
    $('#main').loader();
    $.post('/barsroot/kaznaallocation/zagvisa/',
        { nr: selectedZag.data('nr') },
        function (data, textStatus) {
          $('#main').loader('remove');
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              barsUiAlert(data.message, 'Повідомлення');
              $('#tableAllocationZag').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
  }
}