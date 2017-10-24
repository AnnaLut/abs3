var selectedGeneral = null;
$(function () {
  $('.tiptip a.button, .tiptip button').tipTip();
  $('#tableGeneral').jungGridView({
    updateTableUrl: '/barsroot/kaznaEstimate/generallist/',
    userUpdateParamFunc: tableFinancialParam,
    updateTableFunc: function () { refreshTableGeneral(); },
    viewTfoot: true,
    autoLoad: true,
    viewFilter: true,
    buttonToUpdateId: 'btSubmitGeneral',
    //trClickFunk: function () { /*showButton(); */ },
    sort: 'ID',
    sortDir: 'DESC'
  });
});
function tableFinancialParam() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  var kpk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kpk') : null;
  var krk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('krk') : null;
  var bud = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('bud') : null;
  var kvk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kvk') : null;
  var kfk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kfk') : null;
  var nr = typeof (selectedZag) != 'undefined' ? selectedZag.data('nr') : null;
  var param = {
    kpk: kpk,
    krk: krk,
    bud: bud,
    kfk: kfk,
    kvk: kvk,
    nr: nr
  };
  return param;
}
function selectGeneral(elem) {
  selectedGeneral = $(elem);
  $('#bt_removeGeneral').addClass('hover');
  $('#bt_visaGeneral').addClass('hover');
  $('#bt_editGeneral').addClass('hover');
  $('#bt_visaAllGeneral').addClass('hover');
}
function refreshTableGeneral() {
  selectedGeneral = null;
  $('#bt_removeGeneral').removeClass('hover');
  $('#bt_visaGeneral').removeClass('hover');
  $('#bt_editGeneral').removeClass('hover');
  $('#bt_visaAllGeneral').removeClass('hover');
}
function addGeneral() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  var newGeneralRow = $('#newGeneral tr').clone();
  var kpk = typeof (selectedGroup) != 'undefined' && selectedGroup != null ? selectedGroup.data('kpk') : '';
  var kfk = typeof (selectedGroup) != 'undefined' && selectedGroup != null ? selectedGroup.data('kfk') : '';
  newGeneralRow.find('input[name="krk"]').val($('#krk-kod').val()).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  newGeneralRow.find('input[name="kpol"]').val($('#krk-kod').val()).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });

  newGeneralRow.find('input[name="kvk"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  newGeneralRow.find('input[name="kpk"]').val(kpk).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  newGeneralRow.find('input[name="kfk"]').val(kfk).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  newGeneralRow.find('input[name^="s"]').maskMoney({ allowZero: true, allowNegative: true, thousands: ' ' });
  newGeneralRow.find('input[name="nlsk"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  newGeneralRow.find('input[name="mfok"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  newGeneralRow.find('input[name="okpok"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });

  newGeneralRow.find('input[name="datd"]')/*.datepicker({
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
  })*/.mask('99/99/9999');

  $('#tableGeneral tbody').prepend(newGeneralRow);
}
function saveGeneral(elem) {
  var thisTr = $(elem).parentsUntil('tr').parent();

  if (validNewGeneral(thisTr)) {
    $('#tabsEstimateGroup-2').loader();
    var post = $.post('/barsroot/kaznaEstimate/generalsave/',
        {
          ID_: thisTr.data('id'),
          BUD_: thisTr.data('bud'),
          RRK_: thisTr.data('rrk'),
          KVK_: thisTr.data('kvk'),
          KRK_: thisTr.find('input[name="krk"]').val(),
          KPOL_: thisTr.data('kpol'),
          UDK_: /*$('#udk-kod').val()*/null,
          KPK_: thisTr.data('kpk'),
          KFK_: thisTr.data('kfk'),
          KEKV_: thisTr.find('input[name="kekv"]').val(),
          SK_: thisTr.data('sk'),
          /*SUTVG_: thisTr.find('input[name="sutvg"]').val().replace(/\s+/g, ''),
          S101_: thisTr.find('input[name="s101"]').val().replace(/\s+/g, ''),
          S102_: thisTr.find('input[name="s102"]').val().replace(/\s+/g, ''),
          S103_: thisTr.find('input[name="s103"]').val().replace(/\s+/g, ''),
          S104_: thisTr.find('input[name="s104"]').val().replace(/\s+/g, ''),
          S201_: thisTr.find('input[name="s201"]').val().replace(/\s+/g, ''),
          S202_: thisTr.find('input[name="s202"]').val().replace(/\s+/g, ''),
          S203_: thisTr.find('input[name="s203"]').val().replace(/\s+/g, ''),
          SUTVI_: thisTr.find('input[name="sutvi"]').val().replace(/\s+/g, ''),*/
          SUTVR_: thisTr.find('input[name="sutvr"]').val().replace(/\s+/g, ''),
          SUTV1_: thisTr.find('input[name="sutv1"]').val().replace(/\s+/g, ''),
          SUTV2_: thisTr.find('input[name="sutv2"]').val().replace(/\s+/g, ''),
          SUTV3_: thisTr.find('input[name="sutv3"]').val().replace(/\s+/g, ''),
          SUTV4_: thisTr.find('input[name="sutv4"]').val().replace(/\s+/g, ''),
          SUTV5_: thisTr.find('input[name="sutv5"]').val().replace(/\s+/g, ''),
          SUTV6_: thisTr.find('input[name="sutv6"]').val().replace(/\s+/g, ''),
          SUTV7_: thisTr.find('input[name="sutv7"]').val().replace(/\s+/g, ''),
          SUTV8_: thisTr.find('input[name="sutv8"]').val().replace(/\s+/g, ''),
          SUTV9_: thisTr.find('input[name="sutv9"]').val().replace(/\s+/g, ''),
          SUTV10_: thisTr.find('input[name="sutv10"]').val().replace(/\s+/g, ''),
          SUTV11_: thisTr.find('input[name="sutv11"]').val().replace(/\s+/g, ''),
          SUTV12_: thisTr.find('input[name="sutv12"]').val().replace(/\s+/g, ''),
          NR_: thisTr.data('nr'),
          ND_: thisTr.find('input[name="nd"]').val(),
          DATD_: thisTr.data('nr'),
          TT_: thisTr.find('select[name="tt"] option:selected').val(),
          datd: $('#dateInput').val()
        },
        function (data, textStatus) {
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              $('#tableGeneral').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('Неможливо зберегти данні через помилку: ' + data.message, 'Помилка', 'error');
            }
            
          }
          $('#tabsEstimateGroup-2').loader('remove');
          post = null;
        }, 'json');
  }
  else {
    barsUiAlert('Незаповнені обов"язкові поля', '', 'error');
    $('#tabsEstimateGroup-2').loader('remove');
  }
}
//валідація форми вводу фін. зобов"язання
function validNewGeneral(elem) {
  var result = true;
  var krk = elem.find('input[name="krk"]');
  if (krk.val() == '') {
    krk.on('change', function () {
      if (krk.val() == '') krk.addClass('error');
      else krk.removeClass('error');
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
  var nd = elem.find('input[name="nd"]');
  if (nd.val() == '') {
    nd.on('change', function () {
      if (nd.val() == '') nd.addClass('error');
      else nd.removeClass('error');
    }).addClass('error');
    result = false;
  }

  if (!result) barsUiAlert('Незаповнені обов"язкові поля.', 'Помилка', 'error');
  return result;
}

function removeGeneral() {
  if (selectedGeneral != null) {
    barsUiConfirm('Показник буде видалено', function () {
      $('#tabsEstimateGroup-2').loader();
      $.post('/barsroot/kaznaEstimate/generalremove/',
        { id: selectedGeneral.data('id') },
        function (data, textStatus) {
          $('#tabsEstimateGroup-2').loader('remove');
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              barsUiAlert(data.message, 'Повідомлення');
              $('#tableGeneral').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('При видаленні виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
    });
  }
}

function visaGeneral() {
  var check = $('#tableGeneral').jungGridView('checked');
  if (check.length == 0) {
    barsUiAlert('Невідмічено жодного документу.');
  }
  else {
    $('#tabsEstimateGroup-2').loader();
    $.post('/barsroot/kaznaEstimate/generalvisa/',
        { id: check.arr },
        function (data, textStatus) {
          $('#tabsEstimateGroup-2').loader('remove');
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              barsUiAlert(data.message, 'Повідомлення');
              $('#tableGeneral').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
  }
}

function visaAllGeneral() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  
  $('#tabsEstimateGroup-2').loader();
  var kpk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kpk') : null;
  var krk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('krk') : null;
  var bud = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('bud') : null;
  var kvk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kvk') : null;
  var kfk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kfk') : null;
  var nr = typeof (selectedZag) != 'undefined' ? selectedZag.data('nr') : null;
  $.post('/barsroot/kaznaEstimate/generalvisa/',
      {
        krk: krk,
        kvk: kvk,
        kpk: kpk,
        bud: bud,
        kfk: kfk,
        sk: '11',
        nr: nr
      },
      function (data, textStatus) {
        $('#tabsEstimateGroup-2').loader('remove');
        if (textStatus == 'success') {
          if (data.status == 'ok') {
            barsUiAlert(data.message, 'Повідомлення');
            $('#tableGeneral').jungGridView('refresh');
          }
          if (data.status == 'error') {
            barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
          }
        }
      }, 'json');
}

function editGeneral() {
  if (selectedGeneral != null) {
    var ref = selectedGeneral.data('ref');
    if (ref != '') barsUiAlert('Заборонено редагування взятого на облік показника', 'Помилка', 'error');
    else {
      var column = 0;
      var newGeneralRow = $('#newGeneral tr').clone();
      var tt = selectedGeneral.find('td').eq(column = column + 2).html();
      var nd = selectedGeneral.find('td').eq(++column).html();

      var krk = selectedGeneral.find('td').eq(++column).html();
      var kpol = selectedGeneral.find('td').eq(++column).html();
      var kvk = selectedGeneral.find('td').eq(++column).html();      
      var kpk = selectedGeneral.find('td').eq(++column).html();
      var kfk = selectedGeneral.find('td').eq(++column).html();

      var kekv = selectedGeneral.find('td').eq(++column).html();
      var sutvr = selectedGeneral.find('td').eq(++column).html();
      var sutv1 = selectedGeneral.find('td').eq(++column).html();
      var sutv2 = selectedGeneral.find('td').eq(++column).html();
      var sutv3 = selectedGeneral.find('td').eq(++column).html();
      var sutv4 = selectedGeneral.find('td').eq(++column).html();
      var sutv5 = selectedGeneral.find('td').eq(++column).html();
      var sutv6 = selectedGeneral.find('td').eq(++column).html();
      var sutv7 = selectedGeneral.find('td').eq(++column).html();
      var sutv8 = selectedGeneral.find('td').eq(++column).html();
      var sutv9 = selectedGeneral.find('td').eq(++column).html();
      var sutv10 = selectedGeneral.find('td').eq(++column).html();
      var sutv11 = selectedGeneral.find('td').eq(++column).html();
      var sutv12 = selectedGeneral.find('td').eq(++column).html();
      var comm = selectedGeneral.find('td').eq(++column).html();

      newGeneralRow.data('id', selectedGeneral.data('id'));
      newGeneralRow.data('nr', selectedGeneral.data('nr'));

      newGeneralRow.data('bud', selectedGeneral.data('bud'));
      newGeneralRow.data('rrk', selectedGeneral.data('rrk'));
      newGeneralRow.data('kvk', selectedGeneral.data('kvk'));
      newGeneralRow.data('krk', selectedGeneral.data('krk'));
      newGeneralRow.data('kpk', selectedGeneral.data('kpk'));
      newGeneralRow.data('kfk', selectedGeneral.data('kfk'));
      newGeneralRow.data('kpol', selectedGeneral.data('kpol'));

      newGeneralRow.find('select[name="tt"]').find('option[value="' + tt + '"]').prop('selected', 'selected');
      newGeneralRow.find('input[name="nd"]').val(nd);
      newGeneralRow.find('input[name="krk"]').val(krk).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newGeneralRow.find('input[name="kpol"]').val(kpol);
      newGeneralRow.find('input[name="kvk"]').val(kvk);      
      newGeneralRow.find('input[name="kpk"]').val(kpk);
      newGeneralRow.find('input[name="kfk"]').val(kfk);
      newGeneralRow.find('input[name="kekv"]').val(kekv).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newGeneralRow.find('input[name="sutvr"]').val(sutvr);
      newGeneralRow.find('input[name="sutv1"]').val(sutv1);
      newGeneralRow.find('input[name="sutv2"]').val(sutv2);
      newGeneralRow.find('input[name="sutv3"]').val(sutv3);
      newGeneralRow.find('input[name="sutv4"]').val(sutv4);
      newGeneralRow.find('input[name="sutv5"]').val(sutv5);
      newGeneralRow.find('input[name="sutv6"]').val(sutv6);
      newGeneralRow.find('input[name="sutv7"]').val(sutv7);
      newGeneralRow.find('input[name="sutv8"]').val(sutv8);
      newGeneralRow.find('input[name="sutv9"]').val(sutv9);
      newGeneralRow.find('input[name="sutv10"]').val(sutv10);
      newGeneralRow.find('input[name="sutv11"]').val(sutv11);
      newGeneralRow.find('input[name="sutv12"]').val(sutv12);
      newGeneralRow.find('input[name="comm"]').val(comm);

      newGeneralRow.find('input[name^="s"]').maskMoney({ allowZero: true, allowNegative: true, thousands: ' ' });

      newGeneralRow.insertAfter(selectedGeneral);
      selectedGeneral.remove();
      selectedGeneral = null;
    }
  }
}
function fullFormGeneral() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  if (typeof (selectedGroup) != 'undefined' && selectedGroup != null) {
    var krk = selectedGroup.data('krk');
    var kvk = selectedGroup.data('kvk');
    var kpk = selectedGroup.data('kpk');
    var bud = selectedGroup.data('bud');
    var kfk = selectedGroup.data('kfk');
    var fon = selectedGroup.data('fon');
    var srk = selectedGroup.data('srk');
    var sk = '11';
    var docType = '4';

    document.location.href = '/barsroot/koshtoris/document/?krk=' + krk + '&kvk=' + kvk + '&kpk=' + kpk + '&bud=' + bud + '&kfk=' + kfk + '&fon=' + fon + '&srk=' + srk + '&sk=' + sk + '&doctype=' + docType;
  }
}