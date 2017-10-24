//var selectedGroup = null;
$(function () {
  $("#tabsLiabGroup").tabs();
  $('#inp_find_krk').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  $('#inp_find_edrpou').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });

  $("#dateStart,#dateEnd").mask('99/99/9999');

  /*$('#tableGroup tbody').on('click','tr',function () {
    var $thisTr = $(this);
    //$thisTr.parent().find('tr.selected').removeClass('selected');
    //$thisTr.addClass('selected');
    //$('#bt_openDdl').addClass('hover');
    selectedGroup = $thisTr;
    submitFormLiab($thisTr);
  });*/
  
});

function clickOnGroup() {
  //var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  submitFormLiab();
}

function submitFormLiab() {
  var elem = $('#tableGroup').jungGridView('selectedrow');
  if (elem != null) {
    $('#workContent').loader();
    $('#workContent').load('/barsroot/kaznaliabilities/liabgroup/',
      {
        krk: elem.data('krk'),
        kvk: elem.data('kvk'),
        kpk: elem.data('kpk'),
        kfk: elem.data('kfk'),
        bud: elem.data('bud'),
        fon: elem.data('fon')
      },
      function() {
        $('#workContent').loader('remove');
      });
  }
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
  $('#workContent').loader();
  var selectedLegal = $('#tableLegal').jungGridView('selectedrow');
  //if (selectedFinancial) selectedFinancial = null;
  $('#tabsLiabGroup-2').load('/barsroot/kaznaliabilities/financial/',
      {
        krk: $('#krk-kod').val(),
        idu: selectedLegal != null ? selectedLegal.data('idu') : '',
        kpk: selectedGroup != null ? selectedGroup.data('kpk'):'',
        bud: selectedGroup != null ? selectedGroup.data('bud') : '',
        fon: selectedGroup != null ? selectedGroup.data('fon') : '',
        kfk: selectedGroup != null ? selectedGroup.data('kfk') : ''
      },
      function () {
        $('#workContent').loader('remove');
      });
}
function loadDocuments() { 
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  var selectedFinancial = $('#tableFinancial').jungGridView('selectedrow');
  $('#workContent').loader();
  $('#tabsLiabGroup-3').load('/barsroot/kaznaliabilities/documents/',
      {
        krk: $('#krk-kod').val(),
        idf: selectedFinancial != null ? selectedFinancial.data('id') : '',
        kpk: selectedGroup != null ? selectedGroup.data('kpk') : '',
        bud: selectedGroup != null ? selectedGroup.data('bud') : '',
        fon: selectedGroup != null ? selectedGroup.data('fon') : '',
        kfk: selectedGroup != null ? selectedGroup.data('kfk') : ''
      },
      function () {
        $('#workContent').loader('remove');
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
function importDocum(tp, krk) {
  var $form = $('<div />', {'id': 'dialogImportDocum'});
  $form.dialog({
         autoOpen: true,
         modal: true,
         resizable: false,
         position: 'center',
         title: '',
         width: '680', height: '480',
         close: function () { $form.remove(); }
       }).loader();
  $('<iframe>', {
    src: '/barsroot/docinput/impkpdbf.aspx?tp=' + tp + '&krk=' + (krk == undefined ? '' : krk),
    id: 'myFrame',
    frameborder: 0,
    height: 420,
    width: 650
  }).appendTo($form).on('load', function () { $form.loader('remove'); });
}