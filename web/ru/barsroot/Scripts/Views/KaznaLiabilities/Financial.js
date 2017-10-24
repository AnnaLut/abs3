$(function () {
  $('.tiptip a.button, .tiptip button').tipTip();
  $('#tableFinancial').jungGridView({
    updateTableUrl: '/barsroot/kaznaliabilities/financiallist/',
    userUpdateParamFunc: tableFinancialParam,
    updateTableFunc: function () { refreshTableFinancial(); },
    viewTfoot: true,
    autoLoad: true,
    viewFilter: true,
    buttonToUpdateId: 'btSubmitFinancial',
    trClickFunk: function () { selectFinancial(); },
    sort: ' a.IDF ,a.ID  ',
    sortDir: 'DESC'
  });
});
function tableFinancialParam() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  var getSelectZzag = $('#tableLiabilitiesZag').jungGridView('selectedrow');
  var selectedLegal = $('#tableLegal').jungGridView('selectedrow');
  //var kpk = typeof (selectedGroup) != 'undefined' ? selectedGroup.data('kpk') : null;
  //var krk = typeof (selectedGroup) != 'undefined' ? selectedGroup.data('krk') : null;
  var bud = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('bud') : null;
  //var kvk = typeof (selectedGroup) != 'undefined' ? selectedGroup.data('kvk') : null;
  var fon = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('fon') : null;
  var kvk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kvk') : null;
  var kfk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kfk') : null;
  var nr = (typeof (getSelectZzag) != 'undefined' && getSelectZzag!= null)? getSelectZzag.data('nr') : null;
  var idu = (typeof (selectedLegal) != 'undefined' && selectedLegal != null) ? selectedLegal.data('idu') : null;
  var viewOldYear = document.getElementById('viewOldYear') != null ? document.getElementById('viewOldYear').checked : false;
  var param = {
    filterStr: '',
    krk: $('#krk-kod').val(),
    kpk: $('#newLegal tr').data('kpk'),
    idu: idu,
    bud: bud,
    fon: fon,
    kfk: kfk,
    kvk: kvk,
    nr: nr,
    viewOldYear: viewOldYear
};
  return param;
}
function refreshTableFinancial() {
  //selectedFinancial = null;
  $('#bt_removeFinancial').removeClass('hover');
  $('#bt_editFinancial').removeClass('hover');
  $('#bt_oblicFinancial').removeClass('hover');
  $('#bt_payFinancial').removeClass('hover');
}
function selectFinancial(elem) {
  //selectedFinancial = $(elem);
  $('#bt_removeFinancial').addClass('hover');
  $('#bt_editFinancial').addClass('hover');
  $('#bt_oblicFinancial').addClass('hover');
  $('#bt_payFinancial').addClass('hover');
}

function addFinancial() {
  var getSelectZzag = $('#tableLiabilitiesZag').jungGridView('selectedrow');
  var selectedLegal = $('#tableLegal').jungGridView('selectedrow');
  if (getSelectZzag == null) {
    if (selectedLegal != null) {
      var newFinancialRow = $('#newFinancial tr').clone();
      newFinancialRow.find('input[name="krk"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newFinancialRow.find('input[name="kvk"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newFinancialRow.find('input[name="kpk"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newFinancialRow.find('input[name="kekv"]').attr('disabled', 'disabled').val(selectedLegal.data('kekv')).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newFinancialRow.find('input[name="idu"]').attr('disabled', 'disabled').val(selectedLegal.data('id'));
      newFinancialRow.find('input[name="ndu"]').attr('disabled', 'disabled').val(selectedLegal.data('nd'));
      newFinancialRow.find('input[name="datdu"]').attr('disabled', 'disabled').val(selectedLegal.data('datd'));
      newFinancialRow.find('input[name="nlsk"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newFinancialRow.find('input[name="mfok"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newFinancialRow.find('input[name="okpok"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });

      newFinancialRow.find('input[name^="s"]')
        .focus(function() { this.select(); })
        .change(function() { this.value = separateMoney(this.value); })
        .numberMask({ beforePoint: 10, pattern: /^(-)?([\d])*(\.|\,)?([0-9])*$/ });
      //newFinancialRow.find('input[name^="s"]').maskMoney({ allowZero: true, allowNegative: true, thousands: ' ' });

      newFinancialRow.find('input[name="datd"]').mask('99/99/9999');

      $('#tableFinancial tbody').prepend(newFinancialRow);
      
    } else {
      barsUiAlert('Виберіть юридичне зобов`язяння', 'Повідомлення');
    }
  }
}

function editFinancial() {
  var selectedFinancial = $('#tableFinancial').jungGridView('selectedrow');
  if (selectedFinancial != null) {
    var ref = selectedFinancial.data('ref');
    if (ref != '') {
      var dialog = $('<div/>');
      var input = $('<input type="text" value="0.00" />');
      input.focus(function () { this.select(); })
        .change(function () { this.value = separateMoney(this.value); })
        .numberMask({ beforePoint: 10, pattern: /^(-)?([\d])*(\.|\,)?([0-9])*$/ });
      dialog.text('Введіть суму зміни: ');
      dialog.append(input);
      dialog.dialog({
        autoOpen: true,
        modal: true,
        resizable: false,
        position: 'center',
        title: '',
        width: '400',
        height: '150',
        close: function () { dialog.remove(); },
        buttons: [{
          text: 'Готово', click: function () {
            var delta = dialog.find('input').val();
            if (delta == '0.00' || delta == '-0.00') {
              barsUiAlert('Введіть суму яка відрізняється від 0.', 'Помилка', 'error');
            } else {
              dialog.dialog('close');
              $('#main').loader();
              $.post('/barsroot/kaznaliabilities/financialoblic/',
                    {
                      id: selectedFinancial.data('id'),
                      delta: delta.replace('.', '')
                    },
                    function (data, textStatus) {
                      $('#main').loader('remove');
                      if (textStatus == 'success') {
                        if (data.status == 'ok') {
                          barsUiAlert('Зміни збережені.', 'Повідомлення');
                          $('#tableFinancial').jungGridView('refresh');
                        }
                        if (data.status == 'error') {
                          barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
                        }
                      }
                    },
                    'json'
                );
            }
          }
        }],
        open: function () { }

      });
      //barsUiAlert('Заборонено редагування взятого на облік показника', 'Помилка', 'error');
    }
    else {
      var newFinancialRow = $('#newFinancial tr').clone();

      var column = 0;
      var tt = selectedFinancial.find('td').eq(column = column + 2).html();
      var kekv = selectedFinancial.find('td').eq(++column).html();
      var ndu = selectedFinancial.find('td').eq(++column).html();
      var datdu = selectedFinancial.find('td').eq(++column).html();
      var nd = selectedFinancial.find('td').eq(++column).html();
      var datd = selectedFinancial.find('td').eq(++column).html();
      var s = selectedFinancial.find('td').eq(++column).html();
      var so = selectedFinancial.find('td').eq(++column).html();
      var s1 = selectedFinancial.find('td').eq(++column).html();
      var s2 = selectedFinancial.find('td').eq(++column).html();
      var mfok = selectedFinancial.find('td').eq(++column).html();
      var nlsk = selectedFinancial.find('td').eq(++column).html();
      var okpok = selectedFinancial.find('td').eq(++column).html();
      var nmk = selectedFinancial.find('td').eq(++column).html();
      var note = selectedFinancial.find('td').eq(++column).html();
      var comm = selectedFinancial.find('td').eq(++column).html();

      newFinancialRow.data('id', selectedFinancial.data('id'));
      newFinancialRow.data('idu', selectedFinancial.data('idu'));
      newFinancialRow.data('krk', selectedFinancial.data('krk'));
      newFinancialRow.data('kvk', selectedFinancial.data('kvk'));
      newFinancialRow.data('kpk', selectedFinancial.data('kpk'));
      newFinancialRow.data('kfk', selectedFinancial.data('kfk'));
      newFinancialRow.data('fon', selectedFinancial.data('fon'));
      newFinancialRow.data('bud', selectedFinancial.data('bud'));
      
      newFinancialRow.find('select[name="tt"]').find('option[value="' + tt + '"]').prop('selected', 'selected');
      newFinancialRow.find('input[name="kekv"]').val(kekv);
      newFinancialRow.find('input[name="ndu"]').val(ndu);
      newFinancialRow.find('input[name="datdu"]').val(datdu);
      newFinancialRow.find('input[name="nd"]').val(nd);
      newFinancialRow.find('input[name="datd"]').val(datd);
      newFinancialRow.find('input[name="s"]').val(s);
      newFinancialRow.find('input[name="so"]').val(so);
      newFinancialRow.find('input[name="s1"]').val(s1);
      newFinancialRow.find('input[name="s2"]').val(s2);      
      newFinancialRow.find('input[name="mfok"]').val(mfok);
      newFinancialRow.find('input[name="nlsk"]').val(nlsk);
      newFinancialRow.find('input[name="okpok"]').val(okpok);
      newFinancialRow.find('input[name="nmk"]').val(nmk);
      newFinancialRow.find('input[name="note"]').val(note);
      newFinancialRow.find('input[name="comm"]').val(comm);


      newFinancialRow.find('input[name^="s"]')
        .focus(function () { this.select(); })
        .change(function () { this.value = separateMoney(this.value); })
        .numberMask({ beforePoint: 10, pattern: /^(-)?([\d])*(\.|\,)?([0-9])*$/ });
      //newFinancialRow.find('input[name^="s"]').maskMoney({ allowZero: true, allowNegative: true, thousands: ' ' });

      newFinancialRow.find('input[name="datd"]').mask('99/99/9999');

      newFinancialRow.insertAfter(selectedFinancial);
      selectedFinancial.remove();
      selectedFinancial = null;

    }
  }
}

function saveFinancial(elem) {
  $('#tabsLiabGroup-2').loader();
  var thisTr = $(elem).parentsUntil('tr').parent();
  if (validNewFinancial(thisTr)) {
    $.post('/barsroot/kaznaliabilities/financialadd/',
            {
              ID: thisTr.data('id'),
              idu: thisTr.data('idu'),
              BUD: thisTr.data('bud'),
              KRK: thisTr.data('krk'),
              kpk: thisTr.data('kpk'),
              kfk: thisTr.data('kfk'),
              KVK: thisTr.data('kvk'),
              fon: thisTr.data('fon'),
              kekv: thisTr.find('input[name="kekv"]').val(),
              S: thisTr.find('input[name="s"]').val().replace(/\s+/g, ''),
              SO: thisTr.find('input[name="so"]').val().replace(/\s+/g, ''),
              NR: thisTr.find('input[name="nr"]').val(),
              ND: thisTr.find('input[name="nd"]').val(),
              mfok: thisTr.find('input[name="mfok"]').val(),
              nlsk: thisTr.find('input[name="nlsk"]').val(),
              okpok: thisTr.find('input[name="okpok"]').val(),
              nmk: thisTr.find('input[name="nmk"]').val().substring(0,38),
              DATD: thisTr.find('input[name="datd"]').val(),
              NOTE: thisTr.find('input[name="note"]').val(),
              COMM: thisTr.find('input[name="comm"]').val(),
              fn: null,
              tt: thisTr.find('select[name="tt"] option:selected').val()

            },
            function (data, textStatus) {
              $('#tabsLiabGroup-2').loader('remove');
              if (textStatus == 'success') {
                if (data.status == 'ok') {
                  barsUiAlert(data.message, 'Повідомлення');
                  $('#tableFinancial').jungGridView('refresh');
                }
                if (data.status == 'error') {
                  barsUiAlert('При збереженні виникли помилки: ' + data.message, 'Помилка', 'error');
                }
              }
            }, 'json');
  }
  else { $('#tabsLiabGroup-2').loader('remove'); }
}
//валідація форми вводу фін. зобов"язання
function validNewFinancial(elem) {
  var result = true;
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
  if (nmk.val() == '' && nmk.val().length < 3) {
    nmk.on('change', function () {
      if (nmk.val() == '') nmk.addClass('error');
      else nmk.removeClass('error');
    }).addClass('error');
    result = false;
  }

  /*var so = elem.find('input[name="so"]');
  if (so.val() == '' || so.val() == '0.00') {
      so.on('change', function () {
          if (so.val() == '' || s.val() == '0.00') so.addClass('error');
          else so.removeClass('error');
      }).addClass('error');
      result = false;
  }*/
  if (!result) barsUiAlert('Незаповнені обов"язкові поля.', 'Помилка', 'error');
  return result;
}

function removeFinancial() {
  var selectedFinancial = $('#tableFinancial').jungGridView('selectedrow');
  if (selectedFinancial != null) {
    /*if (selectedFinancial.data('ref') != '') {
      barsUiAlert('Заборонено видалення взятого на облік показника.', '', 'error');
    } else {*/
      barsUiConfirm('Зобов`язання буде видалено', function() {
        var ref = selectedFinancial.find('td').eq(0).text();
        if (ref != '') barsUiAlert('Заборонено видалення сплаченого документу', 'Помилка', 'error');
        else {
          $('#tabsLiabGroup-2').loader();
          $.post('/barsroot/kaznaliabilities/financialremove/',
            { id: selectedFinancial.data('id') },
            function(data, textStatus) {
              $('#tabsLiabGroup-2').loader('remove');
              if (textStatus == 'success') {
                if (data.status == 'ok') {
                  barsUiAlert(data.message, 'Повідомлення');
                  $('#btSubmitFinancial').click();
                }
                if (data.status == 'error') {
                  barsUiAlert('При видаленні виникли помилки: ' + data.message, 'Помилка', 'error');
                }
              }
            }, 'json');
        }
      });
    }
  //}
}
function oblicFinancial() {
  var check = $('#tableFinancial').jungGridView('checked');
  if (check.length == 0) {
    barsUiAlert('Невідмічено жодного документу.');
  }
  else {
    $('#main').loader();
    $.post('/barsroot/kaznaliabilities/financialoblic/',
        { id: check.arr },
        function (data, textStatus) {
          $('#main').loader('remove');
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              barsUiAlert(data.message, 'Повідомлення');
              $('#tableFinancial').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('При видаленні виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
  }
}
function payFinancial(type, elem) {
  var selectedFinancial = $('#tableFinancial').jungGridView('selectedrow');
  var id = '';
  if (elem != undefined) {
    id = $(elem).parent().data('id');
  }
  else {
    if (selectedFinancial != null) {
      id = selectedFinancial.data('id');
    }
  }
  if (id != '') {
    $.post('/barsroot/kaznaliabilities/financialpay/',
         {
           id: id,
           conf: type,
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

  /*$('#main').loader();
  $('#childDocumentContent').load('/barsroot/kaznaliabilities/financialpay/',
      {
          id: selectedFinancial.data('id'),
          conf: type 
      },
      function () {
          $('#childDocument').show();
          $('#mainDocument').hide().loader('remove');
      });*/
}
function oblicAllFinancial() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  var getSelectZzag = $('#tableLiabilitiesZag').jungGridView('selectedrow');
  $('#tabsLiabGroup-2').loader();
  var kpk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kpk') : null;
  var kfk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kfk') : null;  
  var krk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('krk') : null;
  var bud = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('bud') : null;
  var kvk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kvk') : null;
  var fon = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('fon') : null;
  var nr = (typeof (getSelectZzag) != 'undefined' && getSelectZzag != null) ? getSelectZzag.data('nr') : null;
  $.post('/barsroot/kaznaliabilities/financialoblic/',
      {
        krk: krk,
        kvk: kvk,
        kpk: kpk,
        kfk: kfk,
        bud: bud,
        fon: fon,
        nr: nr
      },
      function (data, textStatus) {
        $('#tabsLiabGroup-2').loader('remove');
        if (textStatus == 'success') {
          if (data.status == 'ok') {
            barsUiAlert(data.message, 'Повідомлення');
            $('#tableFinancial').jungGridView('refresh');
          }
          if (data.status == 'error') {
            barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
          }
        }
      }, 'json');

}
function checkConfFin() {
  if ($('#confFin').prop('checked')) {
    $('#confFin').removeProp('checked');
  }
  else {
    $('#confFin').prop('checked', 'checked');
  }
}
function editDateFinancial() {
  var selectedFinancial = $('#tableFinancial').jungGridView('selectedrow');
  if (selectedFinancial != null) {
    var edit = $('<input name="grp" value="' + selectedFinancial.find('td').eq(6).text() + '" type="text" />')
              .width('100px')
              .data('id', selectedFinancial.data('id'))
              /*.datepicker({
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
                  catch (e) { $this.addClass('error').attr('title', 'Некоректне значення.'); }
                }
              })*/.mask('99/99/9999');
    var btSave = $('<input type="image" src="/common/images/default/16/save.png" />').on('click', function () { saveDateNameFinancial(this, 'date'); });
    selectedFinancial.find('td').eq(6).html('').append(btSave).append(edit);
  }
}
function editSoFinancial() {
  var selectedFinancial = $('#tableFinancial').jungGridView('selectedrow');
  if (selectedFinancial != null) {
    var edit = $('<input name="grp" value="' + selectedFinancial.find('td').eq(8).text() + '" type="text" />')
              .width('100px')
              .data('id', selectedFinancial.data('id'))
              .focus(function () { this.select(); })
              .change(function () { this.value = separateMoney(this.value); })
              .numberMask({ beforePoint: 10, pattern: /^(-)?([\d])*(\.|\,)?([0-9])*$/ });;
    var btSave = $('<input type="image" src="/common/images/default/16/save.png" />').on('click', function () { saveDateNameFinancial(this, 'so'); });
    selectedFinancial.find('td').eq(8).html('').append(btSave).append(edit);
  }
}
function editNameFinancial() {
  var selectedFinancial = $('#tableFinancial').jungGridView('selectedrow');
  if (selectedFinancial != null) {
    var edit = $('<input name="grp" value="' + selectedFinancial.find('td').eq(14).text() + '" type="text" />')
              .width('200px')
              .data('id', selectedFinancial.data('id'));
    var btSave = $('<input type="image" src="/common/images/default/16/save.png" />').on('click', function () { saveDateNameFinancial(this, 'name'); });
    selectedFinancial.find('td').eq(14).html('').append(btSave).append(edit);
  }
}

function editMfokFinancial(elem) {
  var $elem = $(elem);
  var parentTr = $elem.parentsUntil('tr').parent();
  var selectedFinancial = $('#tableFinancial').jungGridView('selectedrow');
  if (selectedFinancial != null) {
    var edit = $('<input name="grp" value="' + $elem.text() + '" type="text" />')
              .width('200px')
              .data('id', selectedFinancial.data('id'))
              .numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    var btSave = $('<input type="image" src="/common/images/default/16/save.png" />').on('click', function () { saveDateNameFinancial(this, 'mfok'); });
    $elem.html('').append(btSave).append(edit);
  }
}
function editNlskFinancial(elem) {
  var $elem = $(elem);
  var parentTr = $elem.parentsUntil('tr').parent();
  var selectedFinancial = $('#tableFinancial').jungGridView('selectedrow');
  if (selectedFinancial != null) {
    var edit = $('<input name="grp" value="' + $elem.text() + '" type="text" />')
              .width('200px')
              .data('id', selectedFinancial.data('id'))
              .numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    var btSave = $('<input type="image" src="/common/images/default/16/save.png" />').on('click', function () { saveDateNameFinancial(this, 'nlsk'); });
    $elem.html('').append(btSave).append(edit);
  }
}
function editOkpokFinancial(elem) {
  var $elem = $(elem);
  var parentTr = $elem.parentsUntil('tr').parent();
  var selectedFinancial = $('#tableFinancial').jungGridView('selectedrow');
  if (selectedFinancial != null) {
    var edit = $('<input name="grp" value="' + $elem.text() + '" type="text" />')
              .width('100px')
              .data('id', selectedFinancial.data('id'));
    var btSave = $('<input type="image" src="/common/images/default/16/save.png" />').on('click', function () { saveDateNameFinancial(this, 'okpok'); });
    $elem.html('').append(btSave).append(edit);
  }
}
function editNoteFinancial(elem) {
  var $elem = $(elem);
  var parentTr = $elem.parentsUntil('tr').parent();
  var selectedFinancial = $('#tableFinancial').jungGridView('selectedrow');
  if (selectedFinancial != null) {
    var edit = $('<input name="grp" value="' + $elem.text() + '" type="text" />')
              .width('200px')
              .data('id', selectedFinancial.data('id'));
    var btSave = $('<input type="image" src="/common/images/default/16/save.png" />').on('click', function () { saveDateNameFinancial(this, 'note'); });
    $elem.html('').append(btSave).append(edit);
  }
}

function saveDateNameFinancial(elem, type) {
  $('#tabsLiabGroup-2').loader();
  var $elem = $(elem);
  var inp = $elem.parent().find('input[type="text"]');
  if (inp.val() != '') {
    var postData = type == 'so' ? inp.val().replace(/\s+/g, '') : inp.val();
// ReSharper disable once AssignedValueIsNeverUsed
    var post = $.post('/barsroot/kaznaliabilities/zobDateNameEdit/',
            {
              ID: inp.data('id'),
              date: type == 'date' ? postData : null,
              name: type == 'name' ? postData : null,
              so: type == 'so' ? postData : null,
              mfok: type == 'mfok' ? postData : null,
              nlsk: type == 'nlsk' ? postData : null,
              okpok: type == 'okpok' ? postData : null,
              note: type == 'note' ? postData : null              
            },
            function (data, textStatus) {
              $('#tabsLiabGroup-2').loader('remove');
              if (textStatus == 'success') {
                if (data.status == 'ok') {
                  barsUiAlert(data.message, 'Повідомлення');
                  $('#tableFinancial').jungGridView('refresh');
                }
                if (data.status == 'error') {
                  barsUiAlert('При збереженні виникли помилки: ' + data.message, 'Помилка', 'error');
                }
              }
              post = null;
            }, 'json');
  }
  else { $('#tabsLiabGroup-2').loader('remove'); }
}