var selectedSpecial = null;
$(function () {
  $('.tiptip a.button, .tiptip button').tipTip();
  $('#tableSpecial').jungGridView({
    updateTableUrl: '/barsroot/kaznaEstimate/speciallist/',
    userUpdateParamFunc: tableDocumentsParam,
    updateTableFunc: function () { refreshTableSpecial(); },
    viewTfoot: true,
    autoLoad: true,
    viewFilter: true,
    buttonToUpdateId: 'btSubmitSpecial',
    //trClickFunk: function () { /*showButton(); */ },
    sort: 'ID',
    sortDir: 'DESC'
  });
});
function tableDocumentsParam() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  var kpk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null ) ? selectedGroup.data('kpk') : null;
  var krk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null )? selectedGroup.data('krk') : null;
  var bud = (typeof (selectedGroup) != 'undefined' && selectedGroup != null )? selectedGroup.data('bud') : null;
  var kvk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null )? selectedGroup.data('kvk') : null;
  var kfk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null )? selectedGroup.data('kfk') : null;  
  var nr = typeof (selectedZag) != 'undefined' ? selectedZag.data('nr') : null;
  var param = {
    krk: krk,
    kpk: kpk,
    bud: bud,
    kfk: kfk,
    kvk: kvk,
    nr: nr
  };
  return param;
}
function selectSpecial(elem) {
  selectedSpecial = $(elem);
  $('#bt_removeSpecial').addClass('hover');
  $('#bt_editSpecial').addClass('hover');
  $('#bt_visaSpecial').addClass('hover');
  $('#bt_visaAllSpecial').addClass('hover');
}
function refreshTableSpecial() {
  selectedSpecial = null;
  $('#bt_removeSpecial').removeClass('hover');
  $('#bt_editSpecial').removeClass('hover');
  $('#bt_visaSpecial').removeClass('hover');
  $('#bt_visaAllSpecial').removeClass('hover');
}
function addSpecial() {
  var newSpecialRow = $('#newSpecial tr').clone();
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  //var kvk = typeof (selectedGroup) != 'undefined' ? selectedGroup.data('kvk') : '';
  var kpk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null )? selectedGroup.data('kpk') : '';
  var kfk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null )? selectedGroup.data('kfk') : '';
  newSpecialRow.find('input[name="krk"]').val($('#krk-kod').val()).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  newSpecialRow.find('input[name="kpol"]').val($('#krk-kod').val()).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  //newSpecialRow.find('input[name="kvk"]').val(kvk).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  newSpecialRow.find('input[name="kpk"]').val(kpk).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  newSpecialRow.find('input[name="kfk"]').val(kfk).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  newSpecialRow.find('input[name="kekv"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  newSpecialRow.find('input[name^="s"]').maskMoney({ allowZero: true, allowNegative: true, thousands: ' ' });


  newSpecialRow.find('input[name="datd"]')/*.datepicker({
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

  $('#tableSpecial tbody').prepend(newSpecialRow);
}
function saveSpecial(elem) {
  var thisTr = $(elem).parentsUntil('tr').parent();

  if (validNewSpecial(thisTr)) {
    $('#tabsEstimateGroup-3').loader();
    var post = $.post('/barsroot/kaznaEstimate/specialsave/',
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
          DATD_: $('#dateInput').val(),
          TT_: thisTr.find('select[name="tt"] option:selected').val(),
          datd: $('#dateInput').val()
        },
        function (data, textStatus) {
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              $('#tableSpecial').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('Неможливо зберегти данні через помилку: ' + data.message, 'Помилка', 'error');
            }
          }
          $('#tabsEstimateGroup-3').loader('remove');
          post = null;
        }, 'json');
  }
  else {
    barsUiAlert('Незаповнені обов"язкові поля', '', 'error');
    $('#tabsAllocationGroup-3').loader('remove');
  }

}
function validNewSpecial(elem) {
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

  if (!result) barsUiAlert('Незаповнені обов"язкові поля.', 'Помилка', 'error')
  return result;
}
function removeSpecial() {
  if (selectedSpecial != null) {
    barsUiConfirm('Показник буде видалено', function () {
      $('#tabsEstimateGroup-3').loader();
      $.post('/barsroot/kaznaEstimate/specialremove/',
        { id: selectedSpecial.data('id') },
        function (data, textStatus) {
          $('#tabsEstimateGroup-3').loader('remove');
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              barsUiAlert(data.message, 'Повідомлення');
              $('#tableSpecial').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('При видаленні виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
    });
  }
}

function visaSpecial() {
  var check = $('#tableSpecial').jungGridView('checked');
  if (check.length == 0) {
    barsUiAlert('Невідмічено жодного документу.');
  }
  else {
    $('#tabsAllocationGroup-3').loader();
    $.post('/barsroot/kaznaEstimate/specialvisa/',
        { id: check.arr },
        function (data, textStatus) {
          $('#tabsEstimateGroup-3').loader('remove');
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              barsUiAlert(data.message, 'Повідомлення');
              $('#tableSpecial').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
  }
}

function visaAllSpecial() {
  $('#tabsEstimateGroup-3').loader();
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  var kpk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kpk') : null;
  var krk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('krk') : null;
  var bud = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('bud') : null;
  var kvk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kvk') : null;
  var kfk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kfk') : null;
  var nr = typeof (selectedZag) != 'undefined' ? selectedZag.data('nr') : null;
  var post = $.post('/barsroot/kaznaEstimate/specialvisa/',
      {
        krk: krk,
        kvk: kvk,
        kpk: kpk,
        bud: bud,
        kfk:kfk,
        sk: '12',
        nr: nr
      },
      function (data, textStatus) {
        $('#tabsEstimateGroup-3').loader('remove');
        if (textStatus == 'success') {
          if (data.status == 'ok') {
            barsUiAlert(data.message, 'Повідомлення');
            $('#tableSpecial').jungGridView('refresh');
          }
          if (data.status == 'error') {
            barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
          }
        }
        post = null;
      }, 'json');

}

function editSpecial() {
  if (selectedSpecial != null) {
    var ref = selectedSpecial.data('ref');
    if (ref != '') barsUiAlert('Заборонено редагування взятого на облік показника', 'Помилка', 'error');
    else {
      var column = 0;
      var newSpecialRow = $('#newSpecial tr').clone();
      var tt = selectedSpecial.find('td').eq(column = column + 2).html();
      var nd = selectedSpecial.find('td').eq(++column).html();

      var krk = selectedSpecial.find('td').eq(++column).html();
      var kpol = selectedSpecial.find('td').eq(++column).html();
      var kvk = selectedSpecial.find('td').eq(++column).html();
      var kpk = selectedSpecial.find('td').eq(++column).html();
      var kfk = selectedSpecial.find('td').eq(++column).html();

      var kekv = selectedSpecial.find('td').eq(++column).html();
      var sutvr = selectedSpecial.find('td').eq(++column).html();
      var sutv1 = selectedSpecial.find('td').eq(++column).html();
      var sutv2 = selectedSpecial.find('td').eq(++column).html();
      var sutv3 = selectedSpecial.find('td').eq(++column).html();
      var sutv4 = selectedSpecial.find('td').eq(++column).html();
      var sutv5 = selectedSpecial.find('td').eq(++column).html();
      var sutv6 = selectedSpecial.find('td').eq(++column).html();
      var sutv7 = selectedSpecial.find('td').eq(++column).html();
      var sutv8 = selectedSpecial.find('td').eq(++column).html();
      var sutv9 = selectedSpecial.find('td').eq(++column).html();
      var sutv10 = selectedSpecial.find('td').eq(++column).html();
      var sutv11 = selectedSpecial.find('td').eq(++column).html();
      var sutv12 = selectedSpecial.find('td').eq(++column).html();
      var comm = selectedSpecial.find('td').eq(++column).html();

      newSpecialRow.data('id', selectedSpecial.data('id'));
      newSpecialRow.data('nr', selectedSpecial.data('nr'));

      newSpecialRow.data('bud', selectedSpecial.data('bud'));
      newSpecialRow.data('rrk', selectedSpecial.data('rrk'));
      newSpecialRow.data('kvk', selectedSpecial.data('kvk'));
      newSpecialRow.data('krk', selectedSpecial.data('krk'));
      newSpecialRow.data('kpk', selectedSpecial.data('kpk'));
      newSpecialRow.data('kfk', selectedSpecial.data('kfk'));
      newSpecialRow.data('kpol', selectedSpecial.data('kpol'));

      newSpecialRow.find('select[name="tt"]').find('option[value="' + tt + '"]').prop('selected', 'selected');
      newSpecialRow.find('input[name="nd"]').val(nd);
      newSpecialRow.find('input[name="krk"]').val(krk).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newSpecialRow.find('input[name="kpol"]').val(kpol);
      newSpecialRow.find('input[name="kvk"]').val(kvk);      
      newSpecialRow.find('input[name="kpk"]').val(kpk);
      newSpecialRow.find('input[name="kfk"]').val(kfk);
      newSpecialRow.find('input[name="kekv"]').val(kekv).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newSpecialRow.find('input[name="sutvr"]').val(sutvr);
      newSpecialRow.find('input[name="sutv1"]').val(sutv1);
      newSpecialRow.find('input[name="sutv2"]').val(sutv2);
      newSpecialRow.find('input[name="sutv3"]').val(sutv3);
      newSpecialRow.find('input[name="sutv4"]').val(sutv4);
      newSpecialRow.find('input[name="sutv5"]').val(sutv5);
      newSpecialRow.find('input[name="sutv6"]').val(sutv6);
      newSpecialRow.find('input[name="sutv7"]').val(sutv7);
      newSpecialRow.find('input[name="sutv8"]').val(sutv8);
      newSpecialRow.find('input[name="sutv9"]').val(sutv9);
      newSpecialRow.find('input[name="sutv10"]').val(sutv10);
      newSpecialRow.find('input[name="sutv11"]').val(sutv11);
      newSpecialRow.find('input[name="sutv12"]').val(sutv12);
      newSpecialRow.find('input[name="comm"]').val(comm);

      newSpecialRow.find('input[name^="s"]').maskMoney({ allowZero: true, allowNegative: true, thousands: ' ' });

      newSpecialRow.insertAfter(selectedSpecial);
      selectedSpecial.remove();
      selectedSpecial = null;
    }
  }
}
function fullFormSpecial() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  if (typeof (selectedGroup) != 'undefined' && selectedGroup != null) {
    var krk = selectedGroup.data('krk');
    var kvk = selectedGroup.data('kvk');
    var kpk = selectedGroup.data('kpk');
    var bud = selectedGroup.data('bud');
    var kfk = selectedGroup.data('kfk');
    var fon = selectedGroup.data('fon');
    var srk = selectedGroup.data('srk');
    var sk = '12';
    var docType = '4';

    document.location.href = '/barsroot/koshtoris/document/?krk=' + krk + '&kvk=' + kvk + '&kpk=' + kpk + '&bud=' + bud + '&kfk=' + kfk + '&fon=' + fon + '&srk=' + srk + '&sk=' + sk + '&doctype=' + docType;
  }
}