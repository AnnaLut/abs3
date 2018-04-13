//var selectedGroup = null;
//var selectedSaldoA = null;
$(function () {
  /*$('#tableGroup tbody').on('click', 'tr:not(.infoRow)', function () {
    var $thisTr = $(this);
    //$thisTr.parent().find('tr.selected').removeClass('selected');
    //$thisTr.addClass('selected');
    //$('#bt_openDdl').addClass('hover');
    selectedGroup = $thisTr;
    submitWorkContent();
  });*/

  $('.tiptip a.button, .tiptip button').tipTip();
  //$('.dropdown').dropdown();

  $('#fdat')/*.datepicker({
            maxDate: -(Date.now - new Date($(this).val())),
            changeMonth: true,
            changeYear: true,
            yearRange: '-10:+10',
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
                submitWorkContent();
            }
        })*/.mask('99/99/9999');


  $('#ddl_kaz_r').change(function () {
    //document.location.href = '/barsroot/kaznacustacc/customer/?krk';
    //$('#sel_krk').submit();
    submitForm();
  });
  $('#inp_find_krk').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  $('#inp_find_edrpou').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
});

function clickOnGroup() {
  //var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  submitWorkContent();
}

function submitWorkContent() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  if (!$('#fdat').hasClass('error')) {
    $('#bt_partitionAcc').removeClass('hover');
    $('#bt_transportKekv').removeClass('hover');
    $('#bt_editAcc').removeClass('hover');
    $('#bt_closeAcc').removeClass('hover');
    $('#bt_restoreAcc').removeClass('hover');
    if (selectedGroup != null) {
      $('#main').loader();
      $('#workContent').load('/barsroot/kaznacustacc/accounts/',
          {
            fon: selectedGroup.data('fon'),
            krk: selectedGroup.data('krk'),
            kvk: selectedGroup.data('kvk'),
            kpk: selectedGroup.data('kpk'),
            kfk: selectedGroup.data('kfk'),
            bud: selectedGroup.data('bud'),
            fdat: $('#fdat').val(),
            viewClosed: $('#viewClosed').prop('checked'),
            ggg: selectedGroup.data('ggg')
          },
          function () {
            $('#main').loader('remove');
          });
    }
  }
}
//ф-я оновлення
function submitForm() {
  $('#main').loader();
  document.location.href = document.location.href;
  /*$('#workContent').load('/barsroot/kaznacustacc/accounts/',
          {
              krk: selectedGroup.data('krk'),
              viewClosed: $('#viewClosed').prop('checked'),
              selectedGroup: selectedGroup.data('ggg')
          },
          function () { $('#main').loader('remove'); $('#bt_openDdl').removeClass('hover'); }
      );*/
}
function findCust() {
  var krk = $('#inp_find_krk').val();
  var edrpou = $('#inp_find_edrpou').val();
  var name = $('#inp_find_name').val();
  if (krk != '' || edrpou != '' || name != '') {
    $('#main').loader();
    document.location.href = '/barsroot/kaznacustacc/index/?krk=' + krk + '&edrpou=' + edrpou + '&name=' + name;
    /*$('#custAcc').load('/barsroot/kaznacustacc/customer/',
        {
            krk: krk
        },
        function () { $('#main').loader('remove'); $('#bt_openDdl').removeClass('hover'); }
    );*/
  }
}
function showFindCustParam() {
  $('#find_cust_div').slideToggle();
}
//діалог відкриття рахунку
function addAccount() {
  $(document).on('keydown.showS', function (e) {
    if (e.ctrlKey && e.altKey && e.keyCode == 83) {
      var kvk = $('<input name="kvk" id="kvk" />');
      var kpk = $('<input name="kpk" id="kpk" />');
      $('#bud option[value="9900000000"]').prop('selected', 'selected');
      $('select#kvk').after(kvk).remove();
      $('select#kpk').after(kpk).remove();
      $(document).unbind('keydown.showS');
    }
  });
  $(document).on('keydown.showR', function (e) {
    if (e.ctrlKey && e.altKey && e.keyCode == 82) {
      $('#spanParamR').show();
      $(document).unbind('keydown.showR');
    }
  });  
  var $form = $('<div />');
  $form.attr('id', 'dialogAddAccounts');
  $form.load('/barsroot/kaznacustacc/addaccount/?krk=' + $('#inpCustAccKrk').val() + '&random=' + Math.random(),
    function () { $form.parent().loader('remove'); /*$form.loader('remove'); $('#addFilterDialog input[name="btSelFilter"]').click(function () { btSelFilterClick(); });*/ })
    .dialog({
      autoOpen: true,
      modal: true,
      resizable: false,
      position: 'center',
      title: 'Відкриття рахунку',
      width: '560',
      height: '460',
      close: function () {
        $form.dialog('close').remove();
        $(document).unbind('keydown.showR')
                   .unbind('keydown.showS');
      },
      buttons: [
        {
          text: 'відмінити',
          'class': 'ui-button-link',
          click:
            function () {
              $form.dialog('close').remove();
            }
        },
        {
          text: 'Відкрити',
          'id': 'bt_openNls',
          click: function () { openNls($form); }
        }
      ]
      /*buttons: [{ text: 'Відкрити', click: function () { /*btSelFilterClick(); * /} }],*/
      //open: function () { }
    }).parent().loader();
}

function openNls(elem) {
  var param = elem.find('form');
  $('#addAcc').loader();
  var krk = param.find('#krk').val();
  var kpk = param.find('#kpk').val();
  var kfk = param.find('#kfk option:selected').val();
  var kvk = param.find('#kvk').val();
  var fond = param.find('#fond option:selected').val();
  var bud = param.find('#bud option:selected').val();
  var balAcc = param.find('#balAcc option:selected').val();
  var ktk = (balAcc == '3522' && parseInt(fond) > 1 && bud == '9900000000') ? $('#ktk option:selected').val() : null;
  var r = param.find('#paramR').val();

  var kekd1 = false;
  var kekd2 = false;
  var kekd3 = false;
  var kekd4 = false;

  if (balAcc == '3522' && parseInt(fond) == 2 && bud == '9900000000') {
    var kekd1 = $('#kekd21').prop('checked');
    var kekd2 = $('#kekd22').prop('checked');
    var kekd3 = $('#kekd23').prop('checked');
    var kekd4 = $('#kekd24').prop('checked');
  }
  if (balAcc == '3522' && parseInt(fond) == 3 && bud == '9900000000') {
    var kekd1 = $('#kekd31').prop('checked');
    var kekd2 = $('#kekd32').prop('checked');
    var kekd3 = $('#kekd33').prop('checked');
  }
  if (balAcc == '3522' && parseInt(fond) == 6 && bud == '9900000000') {
    var kekd1 = $('#kekd61').prop('checked');
  }

  $.post('/barsroot/kaznacustacc/addaccount/',
    {
      krk: krk,
      kpk: bud == '9900000000' ? kpk : '0',
      kfk: bud == '9900000000' ? '0' : kfk,
      fond: fond,
      bud: bud,
      balAcc: balAcc,
      ktk: ktk,
      kvk: kvk,
      kekd1: kekd1,
      kekd2: kekd2,
      kekd3: kekd3,
      kekd4: kekd4,
      r:r
    },
    function (data, textStatus) {
      $('#addAcc').loader('remove');
      if (textStatus == 'success') {
        if (data.status == 'ok') {
          barsUiAlert(data.message, 'Повідомлення');
          //submitForm();
        }
        if (data.status == 'error') {
          barsUiAlert('При відкритті рахунка виникли помилки: ' + data.message, 'Помилка', 'error');
        }
      }
    }, 'json');
}

//діалог закриття рахунку

function dialogCloseAccount() {
  //var nls = $('#accSaldoA tbody tr.selected');
  //if (nls.length > 0 && nls.data('dazs') == '') {
  if (typeof (selectedSaldoA) != 'undefined' && selectedSaldoA != null && selectedSaldoA.data('dazs') == '') {
    //alert(selectedSaldoA);
    //var dialog = $('#dialogCloseAcc');
    barsUiConfirm('Ви впевнені, що хочете закрити рахунок № ' + selectedSaldoA.data('nls'), function() { closeNls(selectedSaldoA.data('nls')); });
    /*
    $('#dialogCloseAcc').find('#dialogCloseAccNls').html(selectedSaldoA.data('nls'));
    $('#dialogCloseAcc').dialog({
      autoOpen: true,
      modal: true,
      resizable: false,
      position: 'center',
      title: '',
      width: '400',
      height: '150',
      close: function () { /*$(this).html(''); * /
        $('#dialogCloseAccNls').html('');
      }
      /*buttons: [{ text: 'Відкрити', click: function () { /*btSelFilterClick(); * /} }],* /
      //open: function () { }
    });*/
  }
}

function editAcc() {
  if (typeof (selectedSaldoA) != 'undefined' && selectedSaldoA != null) {
    var $form = $('<div />', { id: 'dialogEditAcc' });
    //$form.attr('id', 'dialogEditAcc');
    $form.load('/barsroot/kaznacustacc/account/?acc=' + selectedSaldoA.data('acc') + '&rnd=' + Math.random(),
      function () { $form.parent().loader('remove'); })
      .dialog({
        autoOpen: true,
        modal: true,
        resizable: false,
        position: 'center',
        title: 'Редагування рахунку',
        width: '560',
        height: '460',
        close: function () { /*submitWorkContent();*/
          $form.remove();
        },
        buttons: [
          {
            text: 'відмінити',
            'class': 'ui-button-link',
            click: function () {
              $form.dialog('close').remove();
            }
          },
          { text: 'Зберегти', click: function () { saveNls($form); } }
        ],
        open: function () {
        }
      }).parent().loader();
  }
}

function saveNls(elem) {
  elem.parent().loader();
  //$('#dialogEditAcc').loader();
  $.post('/barsroot/kaznacustacc/account/',
    {
      acc: elem.find('input[name=acc]').val(),
      nls: elem.find('input[name=nls]').val(),
      blkk: elem.find('select[name=blkk]').val(),
      blkd: elem.find('select[name=blkd]').val(),
      pap: elem.find('select[name=pap]').val()
    },
    function (data, textStatus) {
      elem.parent().loader('remove');
      //$('#dialogEditAcc').loader('remove');
      if (textStatus == 'success') {
        if (data.status == 'ok') {
          barsUiAlert(data.message, 'Повідомлення');
          submitWorkContent();
        }
        if (data.status == 'error') {
          barsUiAlert(data.message, 'Помилка', 'error');
        }

      }
    }, 'json');
}

function closeNls(nls) {
  $('#main').loader();
  $('#dialogCloseAcc').dialog('close');
  $.post('/barsroot/kaznacustacc/closeaccount/',
    {
      nls: nls
    },
    function (data, textStatus) {
      $('#main').loader('remove');
      if (textStatus == 'success') {
        if (data.status == 'ok') {
          barsUiAlert(data.message, 'Повідомлення');
          submitWorkContent();
        }
        if (data.status == 'error') {
          barsUiAlert(data.message, 'Помилка', 'error');
        }

      }
    }, 'json');
}

function restoreAccount() {
  var nls = $('#accSaldoA tbody tr.selected');
  if (nls.length > 0 && nls.data('dazs') != '') {
    $('#main').loader();
    $.post('/barsroot/kaznacustacc/restoreaccount/',
      {
        nls: nls.data('nls')
      },
      function (data, textStatus) {
        $('#main').loader('remove');
        if (textStatus == 'success') {
          if (data.status == 'ok') {
            barsUiAlert(data.message, 'Повідомлення');
            submitWorkContent();
          }
          if (data.status == 'error') {
            barsUiAlert(data.message, 'Помилка', 'error');
          }
        }
      }, 'json');
  }
}

function hrefKoshtoris(elem, sk) {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  if (selectedGroup != null) {
    $('#main').loader();
    document.location.href = '/barsroot/koshtoris/document/?krk=' + selectedGroup.data('krk') + '&kpk=' + selectedGroup.data('kpk') + '&sk=' + sk;
  }
}

function hrefRegistry(TypeDoc) {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  if (selectedGroup != null) {
    $('#main').loader();
    document.location.href = '/barsroot/koshtoris/registry/?krk=' + selectedGroup.data('krk') + '&TypeDoc=' + TypeDoc + '&statusDoc=1&selectedGroup=' + selectedGroup.data('ggg') + "&kpk=" + selectedGroup.data('kpk');
  }
}
function loadExternal(elem) {
  var $elem = $(elem);
  //alert($elem.attr('href'));
  var dialog = $('<div/>');
  $('#main').loader();

  dialog.load($elem.attr('href'),
      {},
      function () {
        dialog.fullDialog();
        $('#main').loader('remove');
      });
}
function loadHistoryExternalS() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  var nls = $('#accSaldoA tbody tr.selected');
  var kekv = $('#accSaldoS tbody tr.selected');
  if (selectedGroup != null && nls.length != 0) {

    document.location.href = '/barsroot/kaznacustacc/historysaldos/?krk=' + selectedGroup.data('krk') + '&acc=' + nls.data('acc') + '&kekv=' + kekv.data('kekv');
  }
}
function hrefHistoryExternalA() {
  var nls = $('#accSaldoA tbody tr.selected');
  if (nls.length != 0) {
    $('#main').loader();
    document.location.href = '/barsroot/customerlist/showhistory.aspx?acc=' + nls.data('acc') + '&type=1';
  }
}
function printKardPva() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  if (selectedGroup != null) {
    $('#main').loader();
    document.location.href = '/barsroot/koshtoris/registry/?krk=' + selectedGroup.data('krk') + '&TypeDoc=' + TypeDoc + '&statusDoc=1&selectedGroup=' + selectedGroup.data('ggg') + "&kpk=" + selectedGroup.data('kpk');
  }
}
function loadPartition() {
  var selectedGroup = $('#tableGroup').jungGridView('selectedrow');
  var bud = selectedGroup != null ? selectedGroup.data('bud') : '';
  var kvk = selectedGroup != null ? selectedGroup.data('kvk') : '';
  var krk = selectedGroup != null ? selectedGroup.data('krk') : '';
  var kpk = selectedGroup != null ? selectedGroup.data('kpk') : '';
  var kfk = selectedGroup != null ? selectedGroup.data('kfk') : '';
  var srk = selectedGroup != null ? selectedGroup.data('srk') : '';
  var fon = selectedGroup != null ? selectedGroup.data('fon') : '';
  var nls = (typeof (selectedSaldoA) != 'undefined' && selectedSaldoA != null) ? selectedSaldoA.data('nls') : null;
  var acc = (typeof (selectedSaldoA) != 'undefined' && selectedSaldoA != null) ? selectedSaldoA.data('acc') : null;  

  if (nls == null) {
    barsUiAlert('Виберіть рахунок');
    return;
  }
  var bals = new String(nls).substring(0, 4);
  if (bals != 9071 && bals != 9072 && bals != 9073 && bals != 9074 && bals != 3532 && bals != 3531 && bals != 3146 && bals != 3142 && bals != 3152) {
    barsUiAlert('Вибрано недопустимий рахунок.');
    return;
  }
  var dialog = $('<div/>');
  $('#main').loader();
  
  dialog.load('/barsroot/kaznafunding/partition/',
  {
    partial: 'true',
    bud: bud,
    kvk: kvk,
    krk: krk,
    kpk: kpk,
    kfk: kfk,
    srk: srk,
    fon: fon,
    nls: nls,
    acc: acc
  },
  function () {
    dialog.fullDialog();
    $('#main').loader('remove');
  });
  
  /*var dialog = $('<div/>');
  $('#main').loader();
  dialog.load('/barsroot/documents/document/?id=' + ref + "&partial=true",
    function () {
      dialog.fullDialog();
      $('#main').loader('remove');
    });*/

}
//Дііалог перенесення між КЕКВ
function transportKekv() {
  if (typeof(selectedSaldoA) != 'undefined' && selectedSaldoA != null && selectedSaldoA.data('dazs') == '') {
    var dialog = $('#transportKekv').clone();
    dialog.find('#nls').val(selectedSaldoA.data('nls'));
    dialog.find('#s')
       .focus(function () { this.select(); })
       .change(function () { this.value = separateMoney(this.value); })
       .numberMask({ beforePoint: 10, pattern: /^(-)?([\d])*(\.|\,)?([0-9])*$/ });
    dialog.dialog({
      autoOpen: true,
      modal: true,
      resizable: false,
      position: 'center',
      title: 'Перенесення між КЕКВ',
      width: '500',
      height: '360',
      close: function() {dialog.remove();},
      buttons: [
        {
          text: 'відмінити',
          'class': 'ui-button-link',
          click: function () {
            dialog.dialog('close');
          }
        },
        { text: 'Зберегти', click: function () { saveTransportKekv(dialog); } }
      ]
    });
  }
}
function saveTransportKekv(dialog) {
  if (validTransportKekv(dialog)) {
    var nls = dialog.find('#nls').val();
    var kekv1 = dialog.find('#kekv1').val();
    var kekv2 = dialog.find('#kekv2').val();
    var s = dialog.find('#s').val().replace(/\s+/g, '');
    var nazn = dialog.find('#nazn').val();
    dialog.parent().loader();
    // ReSharper disable once AssignedValueIsNeverUsed
    var post = $.post('/barsroot/kaznacustacc/transportkekv/',
      {
        nls: nls,
        kekv1: kekv1,
        kekv2: kekv2,
        s: s,
        nazn: nazn
      },
      function(data, textStatus) {
        $('#addAcc').loader('remove');
        if (textStatus == 'success') {
          if (data.status == 'ok') {
            barsUiAlert(data.message, 'Повідомлення');
            dialog.dialog('close');
          }
          if (data.status == 'error') {
            barsUiAlert('При збереженні виникли помилки: ' + data.message, 'Помилка', 'error');
            dialog.parent().loader('remove');
          }
        }

        post = null;
      }, 'json');
  } else {
      barsUiAlert('Перевірте коректність заповнення даних.', 'Помилка', 'error');    
  }
}

function validTransportKekv(dialog) {
  var result = true;
  var nls = dialog.find('#nls');
  var kekv1 = dialog.find('#kekv1');
  var kekv2 = dialog.find('#kekv2');
  var s = dialog.find('#s');
  var nazn = dialog.find('#nazn');
  if (nls.val() == '') {
    nls.addClass('error').on('change',function () { $(this).removeClass('error'); });
    result = false;
  }
  if (kekv1.val() == '') {
    kekv1.addClass('error').on('change',function () { $(this).removeClass('error'); });    
    result = false;
  }
  if (kekv2.val() == '') {
    kekv2.addClass('error').on('change',function () { $(this).removeClass('error'); });      
    result = false;
  }
  if (s.val() == '' || s.val() == '0.00') {
    s.addClass('error').on('change',function () { $(this).removeClass('error'); });       
  }
  return result;
}