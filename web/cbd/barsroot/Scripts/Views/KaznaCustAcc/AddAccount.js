var formOpenNlsReady = new Object();
formOpenNlsReady.loadKvk = true;
formOpenNlsReady.loadKpk = true;
formOpenNlsReady.loadKfk = true;
formOpenNlsReady.loadNls = true;

function isReadyFormOpenNls() {
  var result = true;
  if (!formOpenNlsReady.loadKvk)
    result = false;
  if (!formOpenNlsReady.loadKpk)
    result = false;
  if (!formOpenNlsReady.loadKfk)
    result = false;
  if (!formOpenNlsReady.loadNls)
    result = false;
  return result;
}

function disableOpenBt() {
  if (isReadyFormOpenNls()) {
    $('#bt_openNls').removeProp('disabled');
  } else {
    $('#bt_openNls').prop('disabled', 'disabled');
  }
}

$(function () {
  $('#paramR').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  $('#balAcc, #fond, #bud').on('change', function () { showKtk(); });
  $('#fond').on('change', function () { /*hideNls();*/
    loadNls();
  });
  $('#bud').on('change', function () { loadKvk(); });
  $('#kvk').on('change', function () {
    var bud = $('#bud option:selected').val();
    if (bud == '9900000000') {
      loadKpk();
    } else {
      loadKfk();      
    }
  });
});
/*function onLoadAcc() {
      var ddlAcc = $('#balAcc')
      ddlAcc.data('even', ddlAcc.find('option[data-event="0"]').clone());
      ddlAcc.data('noteven', ddlAcc.find('option[data-event="1"]').clone());
  }*/

function loadKvk() {
  formOpenNlsReady.loadKvk = false;
  disableOpenBt();
  var bud = $('#bud option:selected').val();
  if (bud != '9900000000') {
    $('#tr-kfk').show();
    $('#tr-kpk').hide();
  } else {
    $('#tr-kpk').show();
    $('#tr-kfk').hide();
  }

  $('#kvk').load('/barsroot/kaznacustacc/kvk/',
    {
      //krk: '@@Model.KRK',
      krk: document.addAccParam.krk.value,
      bud: bud
    },
    function () {
      formOpenNlsReady.loadKvk = true;
      disableOpenBt();
      if (isReadyFormOpenNls()) {
        $('#bt_openNls').removeProp('disabled');
      }
      loadKpk();
      loadKfk();
      loadNls();
    });
}

function loadKpk() {
  formOpenNlsReady.loadKpk = false;
  disableOpenBt();
  $('#kpk').load('/barsroot/kaznacustacc/kpk/',
    {
      //krk: '@@Model.KRK',
      krk: document.addAccParam.krk.value,
      kvk: $('#kvk option:selected').val()
    },
    function () {
      formOpenNlsReady.loadKpk = true;
      disableOpenBt();
    });
}
function loadKfk() {
  formOpenNlsReady.loadKfk = false;
  disableOpenBt();
  $('#kfk').load('/barsroot/kaznacustacc/kfk/',
    {
      krk: document.addAccParam.krk.value,
      kvk: $('#kvk option:selected').val()
    },
    function () {
      formOpenNlsReady.loadKfk = true;
      disableOpenBt();
    });
}

function loadNls() {
  formOpenNlsReady.loadNls = false;
  disableOpenBt();
  $('#balAcc').load('/barsroot/kaznacustacc/bals/',
    {
      //krk: '@@Model.KRK',
      krk: document.addAccParam.krk.value,
      bud: $('#bud option:selected').val(),
      fon: $('#fond option:selected').val()
    },
      function () {
        formOpenNlsReady.loadNls = true;
        disableOpenBt();
        $('#bt_openNls').removeProp('disabled');
        showKtk();
      });
}
function hideNls() {
  var ddl = $('#fond');
  var fond = $('#fond option:selected').val();
  if (fond == '0') {
    $('#balAcc').html($('#balAccNotEvent').html());
    //$('#balAcc option[data-event="1"]').removeProp('disabled');
    //$('#balAcc option[data-event="0"]').remove();
  }
  else {
    $('#balAcc').html($('#balAccEvent').html());
    //$('#balAcc option[data-event="0"]').show();
    //$('#balAcc option[data-event="1"]').hide();
  }
}

function showKtk() {
  var balAcc = $('#balAcc option:selected').val();
  var fond = parseInt($('#fond option:selected').val());
  var bud = $('#bud option:selected').val();
  if (balAcc == '3522' && fond > 1 && bud == '9900000000') {
    $('#ktk,#ktk-lable,#kekd-lable').show();
    if (fond == 2) {
      $('#kekdForFond-2').show();
      $('#kekdForFond-3').hide().find('input[type="checkbox"]').removeProp('checked');
      $('#kekdForFond-6').hide().find('input[type="checkbox"]').removeProp('checked');
    }
    else if (fond == 3) {
      $('#kekdForFond-3').show();
      $('#kekdForFond-2').hide().find('input[type="checkbox"]').removeProp('checked');
      $('#kekdForFond-6').hide().find('input[type="checkbox"]').removeProp('checked');
    }
    else if (fond == 6 || fond == 9 ) {
      $('#kekdForFond-6').show();
      $('#kekdForFond-2').hide().find('input[type="checkbox"]').removeProp('checked');
      $('#kekdForFond-3').hide().find('input[type="checkbox"]').removeProp('checked');
    }
  }
  else {
    $('#ktk,#ktk-lable,#kekd-lable').hide();
    //$('#kekd-1,#kekd-2,#kekd-3,#kekd-4').removeProp('checked');
    $('#kekdForFond-2').hide().find('input[type="checkbox"]').removeProp('checked');
    $('#kekdForFond-3').hide().find('input[type="checkbox"]').removeProp('checked');
    $('#kekdForFond-6').hide().find('input[type="checkbox"]').removeProp('checked');
    //$('#label-kekd-1,#label-kekd-2,#label-kekd-3,#label-kekd-4').hide();
  }
  var kvk = $('#kvk,#kpk,#kfk,#fond');
  if (balAcc.substring(0, 2) == '37') {
    var nullOption = $('<option />').val('0');
    kvk.prepend(nullOption.clone())
             .prop('disabled', 'disabled')
             .find('option:first')
             .prop('selected', 'selected');
  }
  else {
    kvk.removeProp('disabled').find('option[value="0"]').remove(':empty');
  }
}