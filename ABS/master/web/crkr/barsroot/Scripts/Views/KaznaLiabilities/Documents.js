//var selectedDocuments = null;
$(function () {
  $('.tiptip a.button, .tiptip button').tipTip();
  $('#tableDocuments').jungGridView({
    updateTableUrl: '/barsroot/kaznaliabilities/documentslist/',
    userUpdateParamFunc: tableDocumentsParam,
    updateTableFunc: function () { refreshTableDocuments(); },
    viewTfoot: true,
    autoLoad: true,
    viewFilter: true,
    buttonToUpdateId: 'btSubmitDocuments',
    trClickFunk: function () { selectDocuments(); },
    sort: 'ID',
    sortDir: 'DESC'
  });
});
function refreshTableDocuments() {
  //selectedDocuments = null;
  $('#bt_removeDocuments').removeClass('hover');
  $('#bt_editDocuments').removeClass('hover');
  $('#bt_payDocuments').removeClass('hover');
  $('#bt_payDocuments0').removeClass('hover');

}
function selectDocuments(elem) {
  //selectedDocuments = $(elem);
  $('#bt_removeDocuments').addClass('hover');
  $('#bt_editDocuments').addClass('hover');
  $('#bt_payDocuments').addClass('hover');
  $('#bt_payDocuments0').addClass('hover');
}
function tableDocumentsParam() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  var getSelectZzag = $('#tableLiabilitiesZag').jungGridView('selectedrow');
  var selectedFinancial = $('#tableFinancial').jungGridView('selectedrow');
  var krk = $('#krk-kod').val() != 'undefined' ? $('#krk-kod').val() : null;
  var idf = (typeof (selectedFinancial) != 'undefined' && selectedFinancial != null) ? selectedFinancial.data('idf') : null;
  var kpk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kpk') : null;
  var bud = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('bud') : null;
  var fon = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('fon') : null;
  var kfk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kfk') : null;
  var kvk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kvk') : null;  
  var nr = (typeof (getSelectZzag) != 'undefined' && getSelectZzag != null) ? getSelectZzag.data('nr') : null;
  var viewOldYear = document.getElementById('viewOldYear') != null ? document.getElementById('viewOldYear').checked : false;
  var param = {
    krk: krk,
    nr: nr,
    idf: idf,
    kpk: kpk,
    bud: bud,
    fon: fon,
    kfk: kfk,
    kvk: kvk,
    viewOldYear: viewOldYear
  };
  return param;
}
function addDocuments() {
  /*var newFinancialRow = $('#newFinancial tr').clone();
  newFinancialRow.find('input[name="krk"]').val($('#krk-kod').val());
  newFinancialRow.find('input[name="kvk"]').val($('#kvk-kod').val());
  newFinancialRow.find('input[name="kpk"]').val($('#kvk-kod').val());
  newFinancialRow.find('input[name="kekv"]').attr('disabled','disabled').val(selectedLegal.data('kekv'));
  newFinancialRow.find('input[name="idu"]').attr('disabled','disabled').val(selectedLegal.data('id'));
  newFinancialRow.find('input[name="ndu"]').attr('disabled','disabled').val(selectedLegal.data('nd'));
  newFinancialRow.find('input[name="datdu"]').attr('disabled','disabled').val(selectedLegal.data('datd'));


  newFinancialRow.find('input[name="datd"]').datepicker({
      changeMonth: true,
      changeYear: true,
      showButtonPanel: true,
      firstDay: 1,
      dateFormat: 'dd/mm/yy',
      onClose: function (selectedDate) {
          var $this = $(this);
          try {
              $this.removeClass('error').attr('title', '');
              var instance = $(this).data('datepicker');
              var date = $.datepicker.parseDate(
              instance.settings.dateFormat ||
              $.datepicker._defaults.dateFormat,
              selectedDate, instance.settings);
              //$this.datepicker("option", 'maxDate', date);
          }
          catch (e) { var t = e; $this.addClass('error').attr('title', 'Некоректне значення.'); }
      }
  }).mask('99/99/9999');

  $('#tableFinancial tbody').prepend(newFinancialRow);*/
}
function saveDocuments(elem) {
  $('#main').loader();
  //var thisTr = $(elem).parentsUntil('tr').parent();
  if (validNewDocuments(elem)) {
    $.post('/barsroot/kaznaliabilities/documentsadd/',
            {
              ID: elem.find('input[name="id"]').val(),
              idf: elem.find('input[name="idf"]').val(),
              BUD: elem.find('input[name="bud"]').val(),
              KRK: elem.find('input[name="krk"]').val(),
              kpk: elem.find('input[name="kpk"]').val(),
              kfk: elem.find('input[name="kfk"]').val(),
              KVK: elem.find('input[name="kvk"]').val(),
              fon: elem.find('input[name="fon"]').val(),
              ref: elem.find('input[name="ref"]').val(),
              tt: elem.find('select[name="tt"]').val(),
              kekv: elem.find('input[name="kekv"]').val(),
              ndf: elem.find('input[name="ndf"]').val(),
              datdf: elem.find('input[name="datdf"]').val(),
              nd: elem.find('input[name="nd"]').val(),
              datd: elem.find('input[name="datd"]').val(),
              S: elem.find('input[name="s"]').val().replace(/\s+/g, ''),
              mfok: elem.find('input[name="mfok"]').val(),
              nlsk: elem.find('input[name="nlsk"]').val(),
              nazn: elem.find('textarea[name="nazn"]').text(),
              okpok: elem.find('input[name="okpok"]').val(),
              nmk: elem.find('textarea[name="nmk"]').text(),
              COMM: elem.find('textarea[name="comm"]').text()
            },
            function (data, textStatus) {
              $('#main').loader('remove');
              if (textStatus == 'success') {
                if (data.status == 'ok') {
                  barsUiAlert(data.message, 'Повідомлення');
                  $('#tableDocuments').jungGridView('refresh');
                }
                if (data.status == 'error') {
                  barsUiAlert('При збереженні виникли помилки: ' + data.message, 'Помилка', 'error');
                }
              }
            }, 'json');
  }
  else { $('#main').loader('remove'); }

}
//валідація форми вводу фін. зобов"язання
function validNewDocuments(elem) {
  var result = true;
  var kekv = elem.find('input[name="kekv"]');
  if (kekv.val() == '') {
    kekv.on('change', function () {
      if (kekv.val() == '') kekv.addClass('error');
      else kekv.removeClass('error');
    }).addClass('error');
    result = false;
  }
  var datd = elem.find('input[name="datd"]');
  if (datd.val() == '') {
    datd.on('change', function () {
      if (datd.val() == '') datd.addClass('error');
      else datd.removeClass('error');
    }).addClass('error');
    result = false;
  }
  var nd = elem.find('input[name="nd"]');
  if (nd.val() == '') {
    nd.on('change', function () {
      if (nd.val() == '') nd.addClass('error');
      else nd.removeClass('error');
    }).addClass('error');
    result = false;
  }
  var s = elem.find('input[name="s"]');
  if (s.val() == '' || s.val() == '0.00') {
    s.on('change', function () {
      if (s.val() == '' || s.val() == '0.00') s.addClass('error');
      else s.removeClass('error');
    }).addClass('error');
    result = false;
  }

  var mfok = elem.find('input[name="mfok"]');
  if (mfok.val() == '') {
    mfok.on('change', function () {
      if (mfok.val() == '') mfok.addClass('error');
      else mfok.removeClass('error');
    }).addClass('error');
    result = false;
  }
  var nlsk = elem.find('input[name="nlsk"]');
  if (nlsk.val() == '') {
    nlsk.on('change', function () {
      if (nlsk.val() == '') nlsk.addClass('error');
      else nlsk.removeClass('error');
    }).addClass('error');
    result = false;
  }
  var okpok = elem.find('input[name="okpok"]');
  if (okpok.val() == '') {
    okpok.on('change', function () {
      if (okpok.val() == '') okpok.addClass('error');
      else okpok.removeClass('error');
    }).addClass('error');
    result = false;
  }
  var nmk = elem.find('input[name="nmk"]');
  if (nmk.val() == '') {
    nmk.on('change', function () {
      if (nmk.val() == '') nmk.addClass('error');
      else nmk.removeClass('error');
    }).addClass('error');
    result = false;
  }

  if (!result) barsUiAlert('Незаповнені обов`язкові поля.', 'Помилка', 'error');

  return result;
}


function removeDocuments() {
  var selectedDocuments = $('#tableDocuments').jungGridView('selectedrow');
  if (selectedDocuments != null) {
    barsUiConfirm('Документ буде видалено', function () {
      var ref = selectedDocuments.data('ref');
      var sos = selectedDocuments.data('sos');
      if (ref != '' && sos != '-1') {
        barsUiAlert('Неможливо видалити сплачений документ', 'Помилка', 'error');
      }
      else {
        $('#tabsLiabGroup-3').loader();
        $.post('/barsroot/kaznaliabilities/documentsremove/',
            { id: selectedDocuments.data('id') },
            function (data, textStatus) {
              $('#tabsLiabGroup-3').loader('remove');
              if (textStatus == 'success') {
                if (data.status == 'ok') {
                  barsUiAlert(data.message, 'Повідомлення');
                  $('#btSubmitDocuments').click();
                }
                if (data.status == 'error') {
                  barsUiAlert('При видаленні виникли помилки: ' + data.message, 'Помилка', 'error');
                }
              }
            }, 'json');
      }
    });
  }
}
function payDocuments(type) {
  var check = $('#tableDocuments').jungGridView('checked');
  if (check.length == 0) {
    barsUiAlert('Невідмічено жодного документу.');
  }
  else {
    $('#main').loader();
    $.post('/barsroot/kaznaliabilities/documentspay/',
        {
          id: check.arr,
          conf: type 
        },
        function (data, textStatus) {
          $('#main').loader('remove');
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              barsUiAlert(data.message, 'Повідомлення');
              $('#tableDocuments').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
  }
}
function payAllDocuments() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  var getSelectZzag = $('#tableLiabilitiesZag').jungGridView('selectedrow');
  $('#main').loader();
  var kpk = (typeof (selectedGroup) != 'undefined' && selectedGroup !=null )? selectedGroup.data('kpk') : null;
  var krk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('krk') : null;
  var bud = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('bud') : null;
  var kvk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kvk') : null;
  var fon = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('fon') : null;
  var kfk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kfk') : null;
  var nr = (typeof (getSelectZzag) != 'undefined' && getSelectZzag != null)? getSelectZzag.data('nr') : null;
  $.post('/barsroot/kaznaliabilities/documentspay/',
      {
        krk: krk,
        kvk: kvk,
        kpk: kpk,
        bud: bud,
        fon: fon,
        kfk: kfk,
        nr: nr,
        conf: true
      },
      function (data, textStatus) {
        $('#main').loader('remove');
        if (textStatus == 'success') {
          if (data.status == 'ok') {
            barsUiAlert(data.message, 'Повідомлення');
            $('#tableDocuments').jungGridView('refresh');
          }
          if (data.status == 'error') {
            barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
          }
        }
      }, 'json');

}
function checkConfDoc() {
  if ($('#confDoc').prop('checked')) {
    $('#confDoc').removeProp('checked');
  }
  else {
    $('#confDoc').prop('checked', 'checked');
  }
}
function editDocuments2() {
  var selDoc = $('#tableDocuments').jungGridView('selectedrow');
  if (selDoc != null) {
    var ref = selDoc.data('ref');
    var newDocumentsRow = $('#newDocuments tr').clone();
    if (ref != '') {
      newDocumentsRow.find('input:text,select').not('[name="kekv"]').prop('disabled', 'disabled');
    }
    var _ref = selDoc.data('ref');

    var column = 0;
    var tt = selDoc.find('td').eq(column = column + 2).html();
    var kekv = selDoc.find('td').eq(++column).html();
    var ndf = selDoc.find('td').eq(++column).html();
    var datdf = selDoc.find('td').eq(++column).html();
    var nd = selDoc.find('td').eq(++column).html();
    var datd = selDoc.find('td').eq(++column).html();
    var s = selDoc.find('td').eq(++column).html();
    var mfok = selDoc.find('td').eq(++column).html();
    var nlsk = selDoc.find('td').eq(++column).html();
    var nazn = selDoc.find('td').eq(++column).html();
    var okpok = selDoc.find('td').eq(++column).html();
    var nmk = selDoc.find('td').eq(++column).html();
    var comm = selDoc.find('td').eq(++column).html();

    newDocumentsRow.data('id', selDoc.data('id'));
    newDocumentsRow.find('input[name="idf"]').val(selDoc.data('idf'));
    newDocumentsRow.find('input[name="krk"]').val(selDoc.data('krk'));
    newDocumentsRow.find('input[name="kvk"]').val(selDoc.data('kvk'));
    newDocumentsRow.find('input[name="kpk"]').val(selDoc.data('kpk'));
    newDocumentsRow.find('input[name="kfk"]').val(selDoc.data('kfk'));
    newDocumentsRow.find('input[name="fon"]').val(selDoc.data('fon'));
    newDocumentsRow.find('input[name="bud"]').val(selDoc.data('bud'));
    newDocumentsRow.find('input[name="ref"]').val(selDoc.data('ref'));


    newDocumentsRow.find('td').eq(1).text(_ref);
    newDocumentsRow.find('option[value="' + tt + '"]').attr("selected", "selected");
    newDocumentsRow.find('input[name="tt"]').val(tt);
    newDocumentsRow.find('input[name="kekv"]').val(kekv);
    newDocumentsRow.find('input[name="ndf"]').val(ndf);
    newDocumentsRow.find('input[name="datdf"]').val(datdf);
    newDocumentsRow.find('input[name="nd"]').val(nd);
    newDocumentsRow.find('input[name="datd"]').val(datd);
    newDocumentsRow.find('input[name="s"]').val(s);
    newDocumentsRow.find('input[name="mfok"]').val(mfok);
    newDocumentsRow.find('input[name="nlsk"]').val(nlsk);
    newDocumentsRow.find('textarea[name="nazn"]').text(nazn);    
    newDocumentsRow.find('input[name="okpok"]').val(okpok);
    newDocumentsRow.find('textarea[name="nmk"]').text(nmk);
    newDocumentsRow.find('textarea[name="comm"]').text(comm);

    newDocumentsRow.find('input[name^="s"]')
       .focus(function () { this.select(); })
       .change(function () { this.value = separateMoney(this.value); })
       .numberMask({ beforePoint: 10, pattern: /^(-)?([\d])*(\.|\,)?([0-9])*$/ });

    newDocumentsRow.find('input[name="datd"]').mask('99/99/9999');

    newDocumentsRow.insertAfter(selDoc);
    selDoc.remove();
    selDoc = null;

    //}
  }
}
function editDocuments() {
  var selRow = $('#tableDocuments').jungGridView('selectedrow');
  if (selRow != null) {
    var $form = $('<div />', {'id':'dialogEditDoc'});
    //$form.attr('id', 'dialogEditDoc');
    $form.load('/barsroot/kaznaliabilities/editdocument/?id=' + selRow.data('id') + '&random=' + Math.random(),
      function() { $form.parent().loader('remove'); })
      .dialog({
        autoOpen: true,
        modal: true,
        resizable: false,
        position: 'center',
        title: '',
        width: '560',
        height: '460',
        close: function() {
          $form.dialog('close').remove();
          $(document).unbind('keydown.showR')
            .unbind('keydown.showS');
        },
        buttons: [
          {
            text: 'відмінити',
            'class': 'ui-button-link',
            click:
              function() {
                $form.dialog('close').remove();
              }
          },
          {
            text: 'Зберегти',
            'id': 'bt_saveDoc',
            click: function() { saveDocuments($form); }
          }
        ]
        /*buttons: [{ text: 'Відкрити', click: function () { /*btSelFilterClick(); * /} }],*/
        //open: function () { }
      }).parent().loader();
  }
}