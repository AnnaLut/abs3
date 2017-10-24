//var selectedLegal = null;
//var selectedFinancial = null;
$('.tiptip a.button, .tiptip button').tipTip();
$(function () {
  $('#tableLegal').jungGridView({
    updateTableUrl: '/barsroot/kaznaliabilities/legallist/',
    userUpdateParamFunc: tableLegalParam,
    updateTableFunc: function () { refreshTableLegal(); },
    viewTfoot: true,
    autoLoad: true,
    viewFilter: true,
    buttonToUpdateId: 'btSubmitFilter',
    trClickFunk: function () { selectLegal(); },
    sort: 'a.ID',
    sortDir: 'DESC'
  });
});
function tableLegalParam() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  var getSelectZzag = $('#tableLiabilitiesZag').jungGridView('selectedrow');
  var kpk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kpk') : null;
  var krk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('krk') : null;
  var bud = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('bud') : null;
  var kvk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kvk') : null;
  var fon = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('fon') : null;
  var kfk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kfk') : null;
  var nr = (typeof (getSelectZzag) != 'undefined' && getSelectZzag != null) ? getSelectZzag.data('nr') : null;
  var viewOldYear = document.getElementById('viewOldYear') != null ? document.getElementById('viewOldYear').checked : false; 
  var param = {
    kpk: kpk,
    krk: krk,
    bud: bud,
    fon: fon,
    kvk: kvk,
    kfk: kfk,
    nr: nr,
    viewOldYear: viewOldYear
  };
  return param;
}

function selectLegal(elem) {
  //selectedLegal = $(elem);
  $('#bt_removeLegal').addClass('hover');
  $('#bt_editLegal').addClass('hover');
  $('#bt_payLegal').addClass('hover');
}
function refreshTableLegal() {
  //selectedLegal = null;
  $('#bt_removeLegal').removeClass('hover');
  $('#bt_editLegal').removeClass('hover');
  $('#bt_payLegal').removeClass('hover');
}

function addLegal() {
  var getSelectZzag = $('#tableLiabilitiesZag').jungGridView('selectedrow');
  if (getSelectZzag == null) {

    var newLegalRow = $('#newLegal tr').clone();
    newLegalRow.find('input[name="krk"]').val($('#krk-kod').val()).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    newLegalRow.find('input[name="kvk"]').val($('#kvk-kod').val()).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    newLegalRow.find('input[name="kpk"]').val($('#kvk-kod').val()).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    newLegalRow.find('input[name="fon"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    newLegalRow.find('input[name="bud"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    newLegalRow.find('input[name="kekv"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });


    //newLegalRow.find('input[name="krk"]').val($('#krk-kod').val());

    //newLegalRow.find('input[name="s"]').maskMoney({ allowZero: true, allowNegative: true, thousands: ' ' });

    newLegalRow.find('input[name^="s"]')
      .focus(function() { this.select(); })
      .change(function() { this.value = separateMoney(this.value); })
      .numberMask({ beforePoint: 10, pattern: /^(-)?([\d])*(\.|\,)?([0-9])*$/ });

    //newLegalRow.find('input[name="so"]').maskMoney({ allowZero: true, allowNegative: true, thousands: ' ' });


    newLegalRow.find('input[name="datd"]')/*.datepicker({
      changeMonth: true,
      changeYear: true,
      showButtonPanel: true,
      firstDay: 1,
      dateFormat: 'dd/mm/yy',
      onClose: function(selectedDate) {
        var $this = $(this);
        try {
          $this.removeClass('error').attr('title', '');
          var instance = $(this).data('datepicker');
          var date = $.datepicker.parseDate(
            instance.settings.dateFormat ||
              $.datepicker._defaults.dateFormat,
            selectedDate, instance.settings);
          //$this.datepicker("option", 'maxDate', date);
        } catch(e) {
          $this.addClass('error').attr('title', 'Некоректне значення.');
        }
      }
    })*/.mask('99/99/9999');

    $('#tableLegal tbody').prepend(newLegalRow);
  }
}
function editLegal() {
  var selectedLegal = $('#tableLegal').jungGridView('selectedrow');
  if (selectedLegal != null) { //якщо строка зобов"язання вибрана
    var ref = selectedLegal.data('ref');
    if (ref != '') { //якщо документ взятий на облік
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
              $.post('/barsroot/kaznaliabilities/legalpay/',
                    {
                      id: selectedLegal.data('id'),
                      delta: delta.replace('.', '')
                    },
                    function (data, textStatus) {
                      $('#main').loader('remove');
                      if (textStatus == 'success') {
                        if (data.status == 'ok') {
                          barsUiAlert('Зміни збережені.', 'Повідомлення');
                          $('#tableLegal').jungGridView('refresh');
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
      var newLegalRow = $('#newLegal tr').clone();
      
      var column = 0;
      var kekv = selectedLegal.find('td').eq(column = column + 2).html();
      var datd = selectedLegal.find('td').eq(++column).html();
      var nd = selectedLegal.find('td').eq(++column).html();
      var s = selectedLegal.find('td').eq(++column).html();
      var so = selectedLegal.find('td').eq(++column).html();
      var s0 = selectedLegal.find('td').eq(++column).html();
      var s1 = selectedLegal.find('td').eq(++column).html();
      var s2 = selectedLegal.find('td').eq(++column).html();
      var note = selectedLegal.find('td').eq(++column).html();
      var comm = selectedLegal.find('td').eq(++column).html();


      newLegalRow.data('id', selectedLegal.data('id'));
      newLegalRow.find('input[name="kekv"]').val(kekv);
      newLegalRow.find('input[name="datd"]').val(datd);
      newLegalRow.find('input[name="nd"]').val(nd);
      newLegalRow.find('input[name="s"]').val(s);
      newLegalRow.find('input[name="so"]').val(so);
      newLegalRow.find('input[name="s1"]').val(s0);
      newLegalRow.find('input[name="s1"]').val(s1);
      newLegalRow.find('input[name="s1"]').val(s2);      
      newLegalRow.find('input[name="note"]').val(note);
      newLegalRow.find('input[name="comm"]').val(comm);

      newLegalRow.find('input[name^="s"]')
        .focus(function () { this.select(); })
        .change(function () { this.value = separateMoney(this.value); })
        .numberMask({ beforePoint: 10, pattern: /^(-)?([\d])*(\.|\,)?([0-9])*$/ });
      //newLegalRow.find('input[name^="s"]').maskMoney({ allowZero: true, allowNegative: true, thousands: ' ' });

      newLegalRow.find('input[name="datd"]')/*.datepicker({
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

      newLegalRow.insertAfter(selectedLegal);
      selectedLegal.remove();
      selectedLegal = null;

    }
  }
}

function saveLegal(elem) {
  $('#tabsLiabGroup-1').loader();
  var thisTr = $(elem).parentsUntil('tr').parent();
  if (validNewLegal(thisTr)) {
    $.post('/barsroot/kaznaliabilities/legaladd/',
            {
              ID: thisTr.data('id'),
              idu: null,
              BUD: thisTr.find('input[name="bud"]').val(),
              KRK: thisTr.find('input[name="krk"]').val(),
              kpk: thisTr.data('kpk'),
              kfk: thisTr.data('kfk'),
              KVK: thisTr.data('kvk'),
              kekv: thisTr.find('input[name="kekv"]').val(),
              S: thisTr.find('input[name="s"]').val().replace(/\s+/g, ''),
              SO: thisTr.find('input[name="so"]').val().replace(/\s+/g, ''),
              NR: thisTr.find('input[name="nr"]').val(),
              ND: thisTr.find('input[name="nd"]').val(),
              mfok: thisTr.find('input[name="mfok"]').val(),
              nlsk: thisTr.find('input[name="nlsk"]').val(),
              okpok: thisTr.find('input[name="okpok"]').val(),
              nmk: thisTr.find('input[name="nmk"]').val(),
              DATD: thisTr.find('input[name="datd"]').val(),
              NOTE: thisTr.find('input[name="note"]').val(),
              COMM: thisTr.find('input[name="comm"]').val(),
              fon: thisTr.data('fon'),
              fn: null,
              tt: thisTr.find('input[name="tt"]').val()

            },
            function (data, textStatus) {
              $('#tabsLiabGroup-1').loader('remove');
              if (textStatus == 'success') {
                if (data.status == 'ok') {
                  barsUiAlert(data.message, 'Повідомлення');
                  $('#tableLegal').jungGridView('refresh');
                }
                if (data.status == 'error') {
                  barsUiAlert('При збереженні виникли помилки: ' + data.message, 'Помилка', 'error');
                }
              }
            }, 'json');
  }
  else { $('#tabsLiabGroup-1').loader('remove'); }
}
//валідація форми вводу юр. зобов"язання
function validNewLegal(elem) {
  var result = true;
  var fon = elem.find('input[name="fon"]');
  if (fon.val() == '') {
    fon.on('change', function () {
      if (fon.val() == '') fon.addClass('error');
      else fon.removeClass('error');
    }).addClass('error');
    result = false;
  }
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

function removeLegal() {
  var selectedLegal = $('#tableLegal').jungGridView('selectedrow');
  if (selectedLegal != null) {
    /*if (selectedLegal.data('ref')!='') {
      barsUiAlert('Заборонено видалення взятого на облік показника.','','error');
    } else {*/
      barsUiConfirm('Зобов`язання буде видалено', function() {
        $('#tabsLiabGroup-1').loader();
        $.post('/barsroot/kaznaliabilities/legalremove/',
          { id: selectedLegal.data('id') },
          function(data, textStatus) {
            $('#tabsLiabGroup-1').loader('remove');
            if (textStatus == 'success') {
              if (data.status == 'ok') {
                barsUiAlert(data.message, 'Повідомлення');
                $('#tableLegal').jungGridView('refresh');
              }
              if (data.status == 'error') {
                barsUiAlert('При видаленні виникли помилки: ' + data.message, 'Помилка', 'error');
              }
            }
          }, 'json');
      });
    }
  //}
}
function payLegal() {
  var check = $('#tableLegal').jungGridView('checked');
  if (check.length == 0) {
    barsUiAlert('Невідмічено жодного документу.');
  }
  else {
    $('#tabsLiabGroup-1').loader();
    $.post('/barsroot/kaznaliabilities/legalpay/',
        { id: check.arr },
        function (data, textStatus) {
          $('#tabsLiabGroup-1').loader('remove');
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              barsUiAlert(data.message, 'Повідомлення');
              $('#tableLegal').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
  }
}
function payAllLegal() {
  $('#tabsLiabGroup-1').loader();
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  var getSelectZzag = $('#tableLiabilitiesZag').jungGridView('selectedrow');
  var kpk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kpk') : null;
  var krk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('krk') : null;
  var bud = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('bud') : null;
  var kvk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kvk') : null;
  var fon = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('fon') : null;
  var nr = (typeof(getSelectZzag) != 'undefined' && getSelectZzag != null) ? getSelectZzag.data('nr') : null;
  $.post('/barsroot/kaznaliabilities/legalpay/',
      {
        krk: krk,
        kvk: kvk,
        kpk: kpk,
        bud: bud,
        fon: fon,
        nr: nr
      },
      function (data, textStatus) {
        $('#tabsLiabGroup-1').loader('remove');
        if (textStatus == 'success') {
          if (data.status == 'ok') {
            barsUiAlert(data.message, 'Повідомлення');
            $('#tableLegal').jungGridView('refresh');
          }
          if (data.status == 'error') {
            barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
          }
        }
      }, 'json');

}
function editSoLegal() {
  var selectedLegal = $('#tableLegal').jungGridView('selectedrow');
  if (selectedLegal != null) {
    var edit = $('<input name="grp" value="' + selectedLegal.find('td').eq(6).text() + '" type="text" />')
              .width('100px')
              .data('id', selectedLegal.data('id'))
              .focus(function () { this.select(); })
              .change(function () { this.value = separateMoney(this.value); })
              .numberMask({ beforePoint: 10, pattern: /^(-)?([\d])*(\.|\,)?([0-9])*$/ });;
    var btSave = $('<input type="image" src="/common/images/default/16/save.png" />').on('click', function () { saveDateLegal(this,'so'); });
    selectedLegal.find('td').eq(6).html('').append(btSave).append(edit);
  }
}
function editDateLegal() {
  var selectedLegal = $('#tableLegal').jungGridView('selectedrow');
  if (selectedLegal != null) {
    var edit = $('<input name="grp" value="' + selectedLegal.find('td').eq(3).text() + '" type="text" />')
              .width('100px')
              .data('id', selectedLegal.data('id'))
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
    var btSave = $('<input type="image" src="/common/images/default/16/save.png" />').on('click', function () { saveDateLegal(this,'date'); });
    selectedLegal.find('td').eq(3).html('').append(btSave).append(edit);
  }
}

function saveDateLegal(elem,type) {
  $('#tabsLiabGroup-1').loader();
  var $elem = $(elem);
  var inp = $elem.parent().find('input[type="text"]');
  if (inp.val() != '') {
    $.post('/barsroot/kaznaliabilities/legaledit/',
            {
              ID: inp.data('id'),
              datd: type == 'date' ? inp.val() : null,
              so: type == 'so' ? inp.val().replace(/\s+/g, '') : null
            },
            function (data, textStatus) {
              $('#tabsLiabGroup-1').loader('remove');
              if (textStatus == 'success') {
                if (data.status == 'ok') {
                  barsUiAlert(data.message, 'Повідомлення');
                  $('#tableLegal').jungGridView('refresh');
                }
                if (data.status == 'error') {
                  barsUiAlert('При збереженні виникли помилки: ' + data.message, 'Помилка', 'error');
                }
              }
            }, 'json');
  }
  else { $('#tabsLiabGroup-1').loader('remove'); }
}