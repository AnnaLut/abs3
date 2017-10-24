//var selectedYear = null;
$(function () {
  $('.tiptip a.button, .tiptip button').tipTip();
  $('#tableYear').jungGridView({
    updateTableUrl: '/barsroot/kaznaallocation/yearlist/',
    userUpdateParamFunc: tableYearParam,
    updateTableFunc: function () { refreshTableYear(); },
    viewTfoot: true,
    autoLoad: true,
    viewFilter: true,
    buttonToUpdateId: 'btSubmitYear',
    trClickFunk: function () { selectYear();},
    sort: 'a.ID',
    sortDir: 'DESC'
  });
});
function tableYearParam() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  var selectedZag = $('#tableAllocationZag').jungGridView('selectedrow');
  var kpk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kpk') : null;
  var krk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('krk') : null;
  var bud = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('bud') : null;
  var kvk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kvk') : null;
  var kfk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kfk') : null;
  var nr = (typeof (selectedZag) != 'undefined' && selectedZag !=null) ? selectedZag.data('nr') : null;
  var param = {
    kpk: kpk,
    krk: krk,
    bud: bud,
    kfk: kfk,
    kvk:kvk,
    nr: nr
  };
  return param;
}
function selectYear(elem) {
  //selectedYear = $(elem);
  $('#bt_removeYear').addClass('hover');
  $('#bt_visaYear').addClass('hover');
  $('#bt_editYear').addClass('hover');
  $('#bt_visaAllYear').addClass('hover');
}
function refreshTableYear() {
  //selectedYear = null;
  $('#bt_removeYear').removeClass('hover');
  $('#bt_visaYear').removeClass('hover');
  $('#bt_editYear').removeClass('hover');
  $('#bt_visaAllYear').removeClass('hover');
}

function addYear() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  if (selectedGroup != null) {
    var kvk = (typeof(selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kvk') : '';
    var kpk = (typeof(selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kpk') : '';
    var kfk = (typeof(selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kfk') : '';
    var newYearRow = $('#newYear tr').clone();
    newYearRow.find('input[name="krk"]').val($('#krk-kod').val()).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    newYearRow.find('input[name="kpol"]').val($('#krk-kod').val()).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    newYearRow.find('input[name="kvk"]').val(kvk).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    newYearRow.find('input[name="kpk"]').val(kpk).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    newYearRow.find('input[name="kfk"]').val(kfk).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    newYearRow.find('input[name="fon"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    newYearRow.find('input[name="bud"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    newYearRow.find('input[name="kekv"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });

    newYearRow.find('input[name^="s"]').maskMoney({ allowZero: true, allowNegative: true, thousands: ' ' });

    newYearRow.find('input[name="datd"]').mask('99/99/9999');

    $('#tableYear tbody').prepend(newYearRow);
  }
}
function saveYear(elem) {

  var thisTr = $(elem).parentsUntil('tr').parent();

  /*var skOzn = $('#sk option:selected').data('ozn');
  var $elem = $(elem);
  var table = $elem.parentsUntil('table').parent();
  var nd = $('#nd').val();*/

  if (validNewYear(thisTr)) {
    $('#tabsAllocationGroup-1').loader();
    $.post('/barsroot/kaznaallocation/yearsave/',
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
          SUTVG_: thisTr.find('input[name="sutvg"]').val().replace(/\s+/g, ''),
          S100_: thisTr.find('input[name="s100"]').val().replace(/\s+/g, ''),          
          S101_: thisTr.find('input[name="s101"]').val().replace(/\s+/g, ''),
          S102_: thisTr.find('input[name="s102"]').val().replace(/\s+/g, ''),
          S103_: thisTr.find('input[name="s103"]').val().replace(/\s+/g, ''),
          S104_: thisTr.find('input[name="s104"]').val().replace(/\s+/g, ''),
          S200_: thisTr.find('input[name="s200"]').val().replace(/\s+/g, ''),          
          S201_: thisTr.find('input[name="s201"]').val().replace(/\s+/g, ''),
          S202_: thisTr.find('input[name="s202"]').val().replace(/\s+/g, ''),
          S203_: thisTr.find('input[name="s203"]').val().replace(/\s+/g, ''),
          SUTVX_: thisTr.find('input[name="sutvx"]').val().replace(/\s+/g, ''),           
          SUTVI_: thisTr.find('input[name="sutvi"]').val().replace(/\s+/g, ''),         
          /*SUTV1_: thisTr.find('input[name="SUTV1"]').val().replace(/\s+/g, ''),
          SUTV2_: thisTr.find('input[name="SUTV2"]').val().replace(/\s+/g, ''),
          SUTV3_: thisTr.find('input[name="SUTV3"]').val().replace(/\s+/g, ''),
          SUTV4_: thisTr.find('input[name="SUTV4"]').val().replace(/\s+/g, ''),
          SUTV5_: thisTr.find('input[name="SUTV5"]').val().replace(/\s+/g, ''),
          SUTV6_: thisTr.find('input[name="SUTV6"]').val().replace(/\s+/g, ''),
          SUTV7_: thisTr.find('input[name="SUTV7"]').val().replace(/\s+/g, ''),
          SUTV8_: thisTr.find('input[name="SUTV8"]').val().replace(/\s+/g, ''),
          SUTV9_: thisTr.find('input[name="SUTV9"]').val().replace(/\s+/g, ''),
          SUTV10_: thisTr.find('input[name="SUTV10"]').val().replace(/\s+/g, ''),
          SUTV11_: thisTr.find('input[name="SUTV11"]').val().replace(/\s+/g, ''),
          SUTV12_: thisTr.find('input[name="SUTV12"]').val().replace(/\s+/g, ''),*/
          NR_: thisTr.data('nr'),
          ND_: thisTr.find('input[name="nd"]').val(),
          DATD_: $('#dateInput').val(),
          TT_: thisTr.find('select[name="tt"] option:selected').val(),
          datd: $('#dateInput').val()
        },
        function (data, textStatus) {
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              $('#tableYear').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('Неможливо зберегти данні через помилку: ' + data.message, 'Помилка', 'error');
            }
          }
          $('#tabsAllocationGroup-1').loader('remove');
        }, 'json');
  }
  else {
    barsUiAlert('Незаповнені обов"язкові поля', '', 'error');
    $('#tabsAllocationGroup-1').loader('remove');
  }
}
/*
function saveLegal(elem) {
    $('#tabsLiabGroup-1').loader();
    var thisTr = $(elem).parentsUntil('tr').parent();
    if (validNewLegal(thisTr)) {
        $.post('/barsroot/kaznaliabilities/legaladd/',
                {
                    ID: null,
                    idu: null,
                    BUD: thisTr.find('input[name="bud"]').val(),
                    KRK: thisTr.find('input[name="krk"]').val(),
                    kpk: thisTr.data('kpk'),
                    kfk: thisTr.data('kfk'),
                    KVK: thisTr.data('kvk'),
                    kekv: thisTr.find('input[name="kekv"]').val(),
                    S: thisTr.find('input[name="s"]').val(),
                    SO: thisTr.find('input[name="so"]').val(),
                    NR: thisTr.find('input[name="nr"]').val(),
                    ND: thisTr.find('input[name="nd"]').val(),
                    mfok: thisTr.find('input[name="mfok"]').val(),
                    nlsk: thisTr.find('input[name="nlsk"]').val(),
                    okpok: thisTr.find('input[name="okpok"]').val(),
                    nmk: thisTr.find('input[name="nmk"]').val(),
                    DATD: thisTr.find('input[name="datd"]').val(),
                    COMM: thisTr.find('input[name="comm"]').val(),
                    fon: thisTr.find('input[name="fon"]').val(),
                    fn: null,
                    tt: thisTr.find('input[name="tt"]').val()

                },
                function (data, textStatus) {
                    $('#tabsLiabGroup-1').loader('remove');
                    if (textStatus == 'success') {
                        if (data.status == 'ok') {
                            barsUiAlert(data.message, 'Повідомлення');
                            $('#btSubmitFilter').click();
                        }
                        if (data.status == 'error') {
                            barsUiAlert('При збереженні виникли помилки: ' + data.message, 'Помилка', 'error');
                        }
                    }
                }, 'json');
    }
    else { $('#tabsLiabGroup-1').loader('remove'); }
}*/
//валідація форми вводу юр. зобов"язання
function validNewYear(elem) {
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

function removeYear() {
  var selectedYear = $('#tableYear').jungGridView('selectedrow');
  if (selectedYear != null) {
    barsUiConfirm('Показник буде видалено.', function () {
      $('#tabsAllocationGroup-1').loader();
      $.post('/barsroot/kaznaallocation/yearremove/',
          { id: selectedYear.data('id') },
          function (data, textStatus) {
            $('#tabsAllocationGroup-1').loader('remove');
            if (textStatus == 'success') {
              if (data.status == 'ok') {
                barsUiAlert(data.message, 'Повідомлення');
                $('#tableYear').jungGridView('refresh');
              }
              if (data.status == 'error') {
                barsUiAlert('При видаленні виникли помилки: ' + data.message, 'Помилка', 'error');
              }
            }
          }, 'json');
    });
  }
}
function visaYear() {
  var check = $('#tableYear').jungGridView('checked');
  if (check.length == 0) {
    barsUiAlert('Невідмічено жодного документу.');
  }
  else {
    $('#tabsAllocationGroup-1').loader();
    $.post('/barsroot/kaznaallocation/yearvisa/',
        { id: check.arr },
        function (data, textStatus) {
          $('#tabsAllocationGroup-1').loader('remove');
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              barsUiAlert(data.message, 'Повідомлення');
              $('#tableYear').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
  }
}
function visaAllYear() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  var selectedZag = $('#tableAllocationZag').jungGridView('selectedrow');
  $('#tabsAllocationGroup-1').loader();
  var kpk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kpk') : null;
  var krk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('krk') : null;
  var bud = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('bud') : null;
  var kvk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kvk') : null;
  var kfk = (typeof (selectedGroup) != 'undefined' && selectedGroup != null) ? selectedGroup.data('kfk') : null;
  var nr = (typeof (selectedZag) != 'undefined' && selectedZag != null) ? selectedZag.data('nr') : null;
  $.post('/barsroot/kaznaallocation/yearvisa/',
      {
        krk: krk,
        kvk: kvk,
        kpk: kpk,
        kfk: kfk,
        bud: bud,
        sk: '10',
        nr: nr
      },
      function (data, textStatus) {
        $('#tabsAllocationGroup-1').loader('remove');
        if (textStatus == 'success') {
          if (data.status == 'ok') {
            barsUiAlert(data.message, 'Повідомлення');
            $('#tableYear').jungGridView('refresh');
          }
          if (data.status == 'error') {
            barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
          }
        }
      }, 'json');

}

function editYear() {
  var selectedYear = $('#tableYear').jungGridView('selectedrow');
  if (selectedYear != null) {
    var ref = selectedYear.data('ref');
    if (ref != '') barsUiAlert('Заборонено редагування взятого на облік показника', 'Помилка', 'error');
    else {
      var column = 0;
      var newYearRow = $('#newYear tr').clone();
      var tt = selectedYear.find('td').eq(column=column + 2).html();
      var nd = selectedYear.find('td').eq(++column).html();
      var krk = selectedYear.find('td').eq(++column).html();
      var kpol = selectedYear.find('td').eq(++column).html();
      var kvk = selectedYear.find('td').eq(++column).html();      
      var kpk = selectedYear.find('td').eq(++column).html();
      var kfk = selectedYear.find('td').eq(++column).html();
      var kekv = selectedYear.find('td').eq(++column).html();
      var sutvg = selectedYear.find('td').eq(++column).html();
      var sutvs = selectedYear.find('td').eq(++column).html();
      var s100 = selectedYear.find('td').eq(++column).html();
      var s101 = selectedYear.find('td').eq(++column).html();
      var s102 = selectedYear.find('td').eq(++column).html();
      var s103 = selectedYear.find('td').eq(++column).html();
      var s104 = selectedYear.find('td').eq(++column).html();
      var s200 = selectedYear.find('td').eq(++column).html();
      var s201 = selectedYear.find('td').eq(++column).html();
      var s202 = selectedYear.find('td').eq(++column).html();
      var s203 = selectedYear.find('td').eq(++column).html();
      var sutvx = selectedYear.find('td').eq(++column).html();
      var sutvi = selectedYear.find('td').eq(++column).html();
      var sutvsg = selectedYear.find('td').eq(++column).html();
      var comm = selectedYear.find('td').eq(++column).html();

      newYearRow.data('id', selectedYear.data('id'));
      newYearRow.data('nr', selectedYear.data('nr'));

      newYearRow.data('bud', selectedYear.data('bud'));
      newYearRow.data('rrk', selectedYear.data('rrk'));
      newYearRow.data('kvk', selectedYear.data('kvk'));
      newYearRow.data('krk', selectedYear.data('krk'));
      newYearRow.data('kpk', selectedYear.data('kpk'));
      newYearRow.data('kfk', selectedYear.data('kfk'));
      newYearRow.data('kpol', selectedYear.data('kpol'));

      newYearRow.find('select[name="tt"]').find('option[value="' + tt + '"]').prop('selected', 'selected');
      newYearRow.find('input[name="nd"]').val(nd);
      newYearRow.find('input[name="krk"]').val(krk).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newYearRow.find('input[name="kpol"]').val(kpol).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newYearRow.find('input[name="kvk"]').val(kvk);      
      newYearRow.find('input[name="kpk"]').val(kpk);
      newYearRow.find('input[name="kfk"]').val(kfk);
      newYearRow.find('input[name="kekv"]').val(kekv).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newYearRow.find('input[name="sutvg"]').val(sutvg);
      newYearRow.find('input[name="sutvs"]').val(sutvs);
      newYearRow.find('input[name="s100"]').val(s100);      
      newYearRow.find('input[name="s101"]').val(s101);
      newYearRow.find('input[name="s102"]').val(s102);
      newYearRow.find('input[name="s103"]').val(s103);
      newYearRow.find('input[name="s104"]').val(s104);
      newYearRow.find('input[name="s200"]').val(s200);      
      newYearRow.find('input[name="s201"]').val(s201);
      newYearRow.find('input[name="s202"]').val(s202);
      newYearRow.find('input[name="s203"]').val(s203);
      newYearRow.find('input[name="sutvx"]').val(sutvx);      
      newYearRow.find('input[name="sutvi"]').val(sutvi);
      newYearRow.find('input[name="sutvsg"]').val(sutvsg);
      newYearRow.find('input[name="comm"]').val(comm);
      newYearRow.find('input[name^="s"]').maskMoney({ allowZero: true, allowNegative: true, thousands: ' ' });

      newYearRow.insertAfter(selectedYear);
      selectedYear.remove();
      selectedYear = null;
    }
  }
}
function fullFormYear() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  if (typeof (selectedGroup) != 'undefined' && selectedGroup != null) {
    $('#main').loader();
    var krk = selectedGroup.data('krk');
    var kvk = selectedGroup.data('kvk');
    var kpk = selectedGroup.data('kpk');
    var bud = selectedGroup.data('bud');
    var kfk = selectedGroup.data('kfk');
    var fon = selectedGroup.data('fon');
    var srk = selectedGroup.data('srk');
    var sk = '10';
    var docType = '1';

    document.location.href = '/barsroot/koshtoris/document/?krk=' + krk + '&kvk=' + kvk + '&kpk=' + kpk + '&bud=' + bud + '&kfk=' + kfk + '&fon=' + fon + '&srk=' + srk + '&sk=' + sk + '&doctype=' + docType;
  }
}