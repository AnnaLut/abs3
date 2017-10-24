//var selectedFunding = null;
$(function () {
  $('.tiptip a.button, .tiptip button').tipTip();
  $('#tableFunding').jungGridView({
    updateTableUrl: '/barsroot/kaznafunding/fundinglist/',
    userUpdateParamFunc: tableFundingParam,
    updateTableFunc: function () { refrachTableFunding(); },
    viewTfoot: true,
    autoLoad: true,
    viewFilter: true,    
    buttonToUpdateId: 'btSubmitFunding',
    trClickFunk: function () { selectFunding(); },
    sort: 'ID',
    sortDir: 'DESC'
  });
});
function tableFundingParam() {
  var selectedZag = $('#tableFundingZag').jungGridView('selectedrow');
  var param = {
    nr: selectedZag.data('nr')
  };
  return param;
}

function selectFunding(elem) {
  //selectedFunding = $(elem);
  $('#bt_removeFunding').addClass('hover');
  $('#bt_visaFunding').addClass('hover');
  $('#bt_editFunding').addClass('hover');
}
function refrachTableFunding() {
  //selectedFunding = null;
  $('#bt_removeFunding').removeClass('hover');
  $('#bt_visaFunding').removeClass('hover');
  $('#bt_editFunding').removeClass('hover');
}


/*function removeYear() {
    if (selectedYear != null) {
        $('#tabsAllocationGroup-1').loader();
        $.post('/barsroot/kaznaallocation/yearremove/',
            { id: selectedYear.data('id') },
            function (data, textStatus) {
                $('#tabsAllocationGroup-1').loader('remove');
                if (textStatus == 'success') {
                    if (data.status == 'ok') {
                        barsUiAlert(data.message, 'Повідомлення');
                        $('#btSubmitYear').click();
                    }
                    if (data.status == 'error') {
                        barsUiAlert('При видаленні виникли помилки: ' + data.message, 'Помилка', 'error');
                    }
                }
            }, 'json');
    }
}*/
function visaFunding() {
  var check = $('#tableFunding').jungGridView('checked');
  if (check.length == 0) {
    barsUiAlert('Невідмічено жодного документу.');
  }
  else {
    $('#main').loader();
    $.post('/barsroot/kaznafunding/fundingvisa/',
        { id: check.arr /*selectedFunding.data('id')*/ },
        function (data, textStatus) {
          $('#main').loader('remove');
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              barsUiAlert(data.message, 'Повідомлення');
              $('#tableFunding').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
  }
}
function removeFunding() {
  var selectedFunding = $('#tableFunding').jungGridView('selectedrow');
  if (selectedFunding != null) {
    barsUiConfirm('Показник буде видалено', function () {
      $('#main').loader();
      $.post('/barsroot/kaznafunding/fundingremove/',
        { id: selectedFunding.data('id') },
        function (data, textStatus) {
          $('#main').loader('remove');
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              barsUiAlert(data.message, 'Повідомлення');
              $('#tableFunding').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
    });
  }
}
function editFunding() {
  var selectedFunding = $('#tableFunding').jungGridView('selectedrow');
  if (selectedFunding != null) {
    var ref = selectedFunding.data('ref');
    if (ref != '') barsUiAlert('Заборонено редагування взятого на облік показника', 'Помилка', 'error');
    else {
      var newFundingRow = $('#newFunding tr').clone();
      var tt = selectedFunding.find('td').eq(2).html();
      var datd = selectedFunding.find('td').eq(3).html();
      var nd = selectedFunding.find('td').eq(4).html();
      var krk = selectedFunding.find('td').eq(5).html();
      var kpol = selectedFunding.find('td').eq(6).html();
      var kvk = selectedFunding.find('td').eq(7).html();
      var kpk = selectedFunding.find('td').eq(8).html();
      var kfk = selectedFunding.find('td').eq(9).html();      
      var fon = selectedFunding.find('td').eq(10).html();
      var bud = selectedFunding.find('td').eq(11).html();
      var kekv = selectedFunding.find('td').eq(12).html();
      var s = selectedFunding.find('td').eq(13).html();
      var s1 = selectedFunding.find('td').eq(14).html();
      var s2 = selectedFunding.find('td').eq(15).html();
      var note = selectedFunding.find('td').eq(16).html();
      var comm = selectedFunding.find('td').eq(17).html();

      newFundingRow.data('id', selectedFunding.data('id'));

      newFundingRow.find('input[name="tt"]').val(tt);
      newFundingRow.find('input[name="datd"]').val(datd);
      newFundingRow.find('input[name="nd"]').val(nd);
      newFundingRow.find('input[name="krk"]').val(krk).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newFundingRow.find('input[name="kpol"]').val(kpol).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newFundingRow.find('input[name="kvk"]').val(kvk).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newFundingRow.find('input[name="kpk"]').val(kpk).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newFundingRow.find('input[name="kfk"]').val(kfk).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newFundingRow.find('input[name="fon"]').val(fon).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newFundingRow.find('input[name="bud"]').val(bud).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newFundingRow.find('input[name="kekv"]').val(kekv).numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
      newFundingRow.find('input[name="s"]').val(s);
      newFundingRow.find('input[name="s1"]').val(s1);
      newFundingRow.find('input[name="s2"]').val(s2);
      newFundingRow.find('input[name="note"]').val(note);
      newFundingRow.find('input[name="comm"]').val(comm);

      newFundingRow.find('input[name^="s"]').maskMoney({ allowZero: true, allowNegative: true, thousands: ' ' });

      newFundingRow.find('input[name="datd"]')/*.datepicker({
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

      newFundingRow.insertAfter(selectedFunding);
      selectedFunding.remove();
      selectedFunding = null;
    }
  }
}
function saveFunding(elem) {
  $('#main').loader();
  var thisTr = $(elem).parentsUntil('tr').parent();
  if (validNewFunding(thisTr)) {
    $.post('/barsroot/kaznaFunding/fundingadd/',
            {
              ID: thisTr.data('id'),
              TT: thisTr.find('input[name="tt"]').val(),
              DATD: thisTr.find('input[name="datd"]').val(),
              ND: thisTr.find('input[name="nd"]').val(),
              KRK: thisTr.find('input[name="krk"]').val(),
              KPOL: thisTr.find('input[name="kpol"]').val(),
              KVK: thisTr.find('input[name="kvk"]').val(),
              KPK: thisTr.find('input[name="kpk"]').val(),
              FON: thisTr.find('input[name="fon"]').val(),
              BUD: thisTr.find('input[name="bud"]').val(),
              KEKV: thisTr.find('input[name="kekv"]').val(),
              //S: thisTr.find('input[name="s"]').val().replace(/\s+/g, ''),
              S1: thisTr.find('input[name="s1"]').val().replace(/\s+/g, ''),
              S2: thisTr.find('input[name="s2"]').val().replace(/\s+/g, ''),
              NOTE: thisTr.find('input[name="note"]').val(),
              COMM: thisTr.find('input[name="comm"]').val()

            },
            function (data, textStatus) {
              $('#main').loader('remove');
              if (textStatus == 'success') {
                if (data.status == 'ok') {
                  barsUiAlert(data.message, 'Повідомлення');
                  $('#tableFunding').jungGridView('refresh');
                }
                if (data.status == 'error') {
                  barsUiAlert('При збереженні виникли помилки: ' + data.message, 'Помилка', 'error');
                }
              }
            }, 'json');
  }
  else { $('#tabsLiabGroup-1').loader('remove'); }
}
function validNewFunding(elem) {
  var result = true;
  return result;
}