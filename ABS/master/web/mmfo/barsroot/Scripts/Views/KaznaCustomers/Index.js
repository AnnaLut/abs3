//var selectedRow = null;
$(document).ready(function () {
  $('.tiptip a.button, .tiptip button').tipTip();

  $('#tableCustomers').jungGridView({
    updateTableUrl: '/barsroot/kaznacustomers/customerslist/',
    userUpdateParamFunc: tableParam,
    updateTableFunc: function () { refreshTableCust(); },
    viewTfoot: true,
    autoLoad: true,
    viewFilter: true,
    buttonToUpdateId: 'btSubmitFilter',
    sort: 'KRK',
    sortDir: 'ASC',
    trClickFunk: function () { selectRow(); }
  });

  $(document).on('keydown', function (e) {
    if (e.ctrlKey && e.altKey && e.keyCode == 71) {
      editGroup();
    }
  });

});

function selectRow(elem) {
  $('#bt_viewCustomer').addClass('hover');
  $('#bt_addMyCust').addClass('hover');
  $('#bt_planCustomer').addClass('hover');
  $('#bt_liabCustomer').addClass('hover');
  $('#bt_accCustomer').addClass('hover');
  $('#bt_custZvit').addClass('hover');
  $('#bt_networkCustomer').addClass('hover');
}
function refreshTableCust() {
  $('#bt_custZvit').removeClass('hover');
  $('#bt_viewCustomer').removeClass('hover');
  $('#bt_addMyCust').removeClass('hover');
  $('#bt_planCustomer').removeClass('hover');
  $('#bt_liabCustomer').removeClass('hover');
  $('#bt_accCustomer').removeClass('hover');
  $('#bt_networkCustomer').removeClass('hover');
}
function tableParam(type, pageNum) {
  var param = {
    viewMy: $('#CheckViewMy').prop('checked'),
    viewClosedCustomer: $('#CheckClContragent').prop('checked')
  };
  return param;
}
function delMyCust() {
  var selCust = $('#tableCustomers').jungGridView('selectedrow');
  if (selCust != null) {
    $('#main').loader();
    $.post('/barsroot/kaznacustomers/delmycust/',
        { krk: selCust.data('krk') },
        function (data, textStatus) {
          $('#main').loader('remove');
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              barsUiAlert(data.message, 'Повідомлення');
              $('#tableCustomers').jungGridView('refresh');;
            }
            if (data.status == 'error') {
              barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
  }
}
function addMyCust() {
  var selCust = $('#tableCustomers').jungGridView('selectedrow');
  if (selCust != null) {
    $('#main').loader();
    $.post('/barsroot/kaznacustomers/addmycust/',
        { krk: selCust.data('krk') },
        function (data, textStatus) {
          $('#main').loader('remove');
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              barsUiAlert(data.message, 'Повідомлення');
              $('#tableCustomers').jungGridView('refresh');
            }
            if (data.status == 'error') {
              barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
  }
}

function findMyCust() {
  $('#loadCust').html('');
  $('#inp_find_krk').val('');
  $('#inp_find_edrpou').val('');
  $('#findMyCust').dialog({
    autoOpen: true,
    modal: true,
    resizable: false,
    position: 'center',
    title: 'Пошук клієнта',
    width: '500', height: '400',
    close: function () { },
    open: function () { }
  });
}

function findCust() {
  $('#findMyCust').loader();
  $('#loadCust').load('/barsroot/kaznacustomers/findcust/',
      {
        krk: $('#inp_find_krk').val(),
        edrpou: $('#inp_find_edrpou').val(),
        nmk: $('#inp_find_nmk').val()
      },
      function () {
        $('#findMyCust').loader('remove');
      });
}

//ф-я оновлення 
function submitForm() {
  $('#main').loader();
  $('#custAcc').load('/barsroot/kaznacustacc/customer/',
          {
            krk: $('#ddl_kaz_r option:selected').val(),
            viewClosed: $('#viewClosed').prop('checked')
          },
          function () {  $('#main').loader('remove'); }
      );
}
function hrefAccCustomer() {
  var selCust = $('#tableCustomers').jungGridView('selectedrow');
  if (selCust != null) {
     $('#main').loader();
     document.location.href = '/barsroot/kaznacustacc/index/?krk=' + selCust.data('krk');
  }
}
function hrefTargetsCustomer() {
  var selCust = $('#tableCustomers').jungGridView('selectedrow');
  if (selCust != null) {
     $('#main').loader();
    document.location.href = '/barsroot/kaznaTargets/index/?krk=' + selCust.data('krk');
  }
}
function hrefLiabCustomer() {
  var selCust = $('#tableCustomers').jungGridView('selectedrow');
  if (selCust != null) {
     $('#main').loader();
    document.location.href = '/barsroot/kaznaLiabilities/index/?krk=' + selCust.data('krk');
  }
}
function hrefZvitCustomer() {
  var selCust = $('#tableCustomers').jungGridView('selectedrow');
  if (selCust != null) {
     $('#main').loader();
     document.location.href = '/barsroot/tools/zvit_krk.aspx?rnk=' + (parseInt(selCust.data('krk')) + 1000000);
  }
}
function hrefNetworkCustomer() {
  var selCust = $('#tableCustomers').jungGridView('selectedrow');
  if (selCust != null) {
     $('#main').loader();
     document.location.href = '/barsroot/kaznanetwork/index/?krk=' + selCust.data('krk') + '&type=network';
  }
}
function viewCustomer() {
  var selCust = $('#tableCustomers').jungGridView('selectedrow');
  if (selCust != null) {
    var $form = $('<div />', { 'id': 'dialogAddAccounts' });
    $form.load('/barsroot/kaznacustomers/customer/?krk=' + selCust.data('krk'),
               function () { $form.loader('remove'); })
                             .dialog({
                               autoOpen: true,
                               modal: true,
                               resizable: false,
                               position: 'center',
                               title: 'Картка клієнта',
                               width: '590', height: '550',
                               close: function () { $form.remove(); },
                               buttons: [{
                                             text: 'відмінити',
                                             'class': 'ui-button-link',
                                             click:
                                               function () {
                                                 $form.dialog('close').remove();
                                               }
                                           },
                                           {
                                             text: 'Зберегти',
                                             'id': 'bt_saveCust',
                                             click: function () { saveCustomer($form); }
                                           }]//,
                               //open: function () { }
                             }).loader();
  }
}

function saveCustomer(form) {
  form.parent().loader();
  $.post('/barsroot/kaznacustomers/customer/',
  {
    krk: form.find('input[name="krk"]').val(),
    edrpou: form.find('input[name="edrpou"]').val(),
    koatuu: form.find('input[name="koatuu"]').val(),
    nmkk: form.find('input[name="nmkk"]').val(),
    nmk: form.find('textarea[name="nmk"]').val(),
    dpi: form.find('input[name="dpi"]').val(),
    zip: form.find('input[name="zip"]').val(),
    adr: form.find('textarea[name="adr"]').val(),
    mtk: form.find('input[name="mtk"]').val(),
    tel1: form.find('input[name="tel1"]').val(),
    tel2: form.find('input[name="tel2"]').val(),
    fax: form.find('input[name="fax"]').val()
  },
  function (data, textStatus) {
    form.parent().loader('remove');
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
function editGroup() {
  var selCust = $('#tableCustomers').jungGridView('selectedrow');
  if (selCust != null) {
    var edit = $('<input name="grp" value="' + selCust.find('td').eq(3).text() + '" type="text" />')
              .width('50px')
              .data('krk', selCust.data('krk'))
              .numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    var btSave = $('<input type="image" src="/common/images/default/16/save.png" />').on('click', function () { saveGroup(this); });
    selCust.find('td').eq(3).html('').append(btSave).append(edit);
  }
}
function saveGroup(elem) {
  var $elem = $(elem);
  $.post('/barsroot/kaznacustomers/editgrp/',
        {
          krk: $elem.parent().find('input[name="grp"]').data('krk'),
          grp: $elem.parent().find('input[name="grp"]').val()
        },
        function (data, textStatus) {
           $('#main').loader('remove');
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              barsUiAlert(data.message, 'Повідомлення');
              $('#tableCustomers').jungGridView('refresh');;
            }
            if (data.status == 'error') {
              barsUiAlert('При виконанні операції виникли помилки: ' + data.message, 'Помилка', 'error');
            }
          }
        }, 'json');
}