var docCreate = true;
$(function () {
  $('.tiptip a.button, .tiptip button').tipTip();
  $('#headTable input.kod[type="text"]').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
  $('#main').loader();
  onLoadKoshtoris();
  $('#main').loader('remove');

  /*$('#udk-name,#udk-kod,#bud-kod,#bud-name,#kvk-kod,#kvk-name,#kpk-kod,#kpk-name').autocomplete(
  {
    source: function (request, response) {
      var $this = this.element;
      var qFrom = $this.attr('data-from');
      var post = $.post('/barsroot/koshtoris/autocomplete/' + $this.attr('name') + '/',
          { q: request.term, qFrom: qFrom, krk_kod: $('#krk-kod').val() },
          function (data) {
            if (data.length == 0) {
              $this.parent().find('input').addClass('error').not($this).val('');
            }
            response(
                $.map(data, function (key, value) {
                  return {
                    label: key.ID + ' | ' + key.NAME,
                    value: qFrom == 'name' ? key.NAME : key.ID,
                    data: qFrom == 'name' ? key.ID : key.NAME,
                    data2: key.DATA
                  };

                }));
            post = null;
          });
    },
    minLength: 1,
    delay: 500,
    //select: function (response) { alert(response.label) }
    open: function (event, ui) {
      //alert(ui.lenght());
    },
    select: function (event, ui) {
      var $this = $(this);
      var toUpd = $this.data('from') == 'name' ? 'kod' : 'name';
      $this.removeClass('error').parent().find('.' + toUpd).removeClass('error').val(ui.item ? ui.item.data : "Ничего не выбрано!");
      if ($this.attr('name') == 'kvk') {
        $('#kpk-kod').val(ui.item.value);
      }
    },
    focus: function (event, ui) {
      if (event.keyCode) {
        var $this = $(this);
        var toUpd = $this.data('from') == 'name' ? 'kod' : 'name';
        $this.parent().find('.' + toUpd).val(ui.item ? ui.item.data : "Ничего не выбрано!");
        $this.parent().find('input').removeClass('error');
        if ($this.attr('name') == 'kvk') {
          $('#kpk-kod').val(ui.item.value);//.maskMoney({ symbol: '280', thousands: '', precision: '', decimal: '', defaultZero: false, allowZero: false });

        }
      }
    },
    close: function (event, ui) {
      //_this = $(this);
      //toUpd = _this.data('from') == 'name' ? 'kod' : 'name';
      //$(this).parent().find('.' + toUpd).val(ui.item ? ui.item.data : "Ничего не выбрано!");
    }
  });*/

 /* $('#krk-edrpou,#krk-kod,#krk-name').autocomplete(
  {
    source: function (request, response) {
      var $this = this.element;
      var qFrom = $this.data('from');
      var post = $.post('/barsroot/koshtoris/autocomplete/' + $this.attr('name') + '/',
          { q: request.term, qFrom: qFrom },
          function (data) {
            if (data.length == 0) {
              $this.parent().find('input').addClass('error').not($this).val('');
            }
            response($.map(data, function (key, value) {
              return {
                label: (qFrom == 'edrpou' ? key.EDRPOU : key.KRK) + ' | ' + key.NMK,
                value: qFrom == 'edrpou' ? key.EDRPOU : qFrom == 'krk' ? key.KRK : key.NMK,
                edrpou: key.EDRPOU,
                krk: key.KRK,
                nmk: key.NMK,
                udk: key.UDK,
                udkName: key.UDKNAME,
                kvk: key.KVK,
                //kvkName:key.KVKNAME,
                rrk: key.RRK
              };
            }));
            post = null;
          });
    },
    minLength: 1,
    delay: 500,
    //select: function (response) { alert(response.label) }
    select: function (event, ui) { updateForm(event, ui); },
    focus: function (event, ui) {
      if (event.keyCode) { updateForm(event, ui); }
    },
    close: function (event, ui) {
      //_this = $(this);
      //toUpd = _this.data('from') == 'name' ? 'kod' : 'name';
      //$(this).parent().find('.' + toUpd).val(ui.item ? ui.item.data : "Ничего не выбрано!");
    }
  });*/

  /*$('.table input[type="text"]')
      .change(function () {
        //$(this).removeClass('error');
      })
      .focus(function () {
        $(this).addClass('focus').bind('blur', function () { $(this).removeClass('focus'); });
      });*/
});
//не використовується
function updateForm(event, ui) {
  $('#krk-kod').val(ui.item ? ui.item.krk : '');
  $('#krk-name').val(ui.item ? ui.item.nmk : '');
  $('#udk-kod').val(ui.item ? ui.item.udk : '');
  $('#udk-name').val(ui.item ? ui.item.udkName : '');
  $('#kvk-kod').val('');
  $('#kvk-name').val('');
  $('#rrk-kod').val(ui.item ? ui.item.rrk : '');
  $('#krk-edrpou').val(ui.item ? ui.item.edrpou : '');
  validForm();
}
//не використовується
function validForm(tipe) {
  var result = true;
  var headInput = $('#headTable input[type="text"]');
  headInput.quickEach(function () {
    if (this.val() == '') {
      if (tipe == 'submit') this.addClass('error');
      result = false;
    }
    else {
      this.removeClass('error');
    }
  });
  if (!result && tipe == 'submit') {
    $('#coshtoris').html('<span class="error">Незаповнені обов\'язкові поля.</span>');
  }
  return result;
}

/*function convertDisabledInputValue(elem) {
  return elem.prop('disabled') ? 0 : elem.val().replace(/\s+/g, '');
}*/
function convertDisabledInputValue(elem) {
  return elem.val().replace(/\s+/g, '');
}

function saveDoc() {
  var nd = $('#nd').val();
  if (nd != '') {
    $('#main').loader();
    
    var skOzn = $('#sk option:selected').data('ozn');
    var tr = $('#inputDoc tbody tr[data-disabled="false"]');//.not(':last');
    var updRos = new Object();
    var counter = 0;
    var tableDiect = $('#headTable');

    var sk = $('#sk option:selected').val();
    var tt = $('#tts option:selected').val();
    var datd = $('#dateInput').val();

    var nr = $('#inputDoc').data('nr');
    
    $('#tts').attr('disabled', 'disabled');
    $('#sk').attr('disabled', 'disabled');
    $('#dateInput').attr('disabled', 'disabled');
    $('#dateInitiation').attr('disabled', 'disabled');
    $('#nd').attr('disabled', 'disabled').removeClass('error');    

    tr.quickEach(function() {
      var $this = this;
      //var s2 = $this.find('input[name="s2"]').val().replace('.', '').replace(',', '');
      //if (/*s2 != '0' && s2 != '' && s2 != '000' && s2 != '0.00' && s2 != '0,00'*/ true) {

      updRos['updRos[' + counter + '].ID_'] = $this.data('kosid');
      updRos['updRos[' + counter + '].BUD_'] = tableDiect.data("bud");

      updRos['updRos[' + counter + '].RRK_'] = tableDiect.data("rrk");
      updRos['updRos[' + counter + '].KVK_'] = tableDiect.data("kvk");
      updRos['updRos[' + counter + '].KRK_'] = tableDiect.data("krk");
      updRos['updRos[' + counter + '].KPOL_'] = tableDiect.data("krk");
      updRos['updRos[' + counter + '].UDK_'] = tableDiect.data("udk");
      updRos['updRos[' + counter + '].KPK_'] = tableDiect.data("kpk");
      updRos['updRos[' + counter + '].KFK_'] = tableDiect.data("kfk");
      updRos['updRos[' + counter + '].KEKV_'] = $this.data('kekv');
      updRos['updRos[' + counter + '].SK_'] = sk;
      if (skOzn == 0) {
        updRos['updRos[' + counter + '].SUTVG_'] = $this.find('input[name="SUTVG"]').val(); //skOzn == 0 ? convertDisabledInputValue($this.find('input[name="SUTVG"]')) : 0;
        updRos['updRos[' + counter + '].S100_'] = $this.find('input[name="S100"]').val();  //skOzn == 0 ? convertDisabledInputValue($this.find('input[name="S100"]')) : 0;
        updRos['updRos[' + counter + '].S101_'] = $this.find('input[name="S101"]').val();  //skOzn == 0 ? convertDisabledInputValue($this.find('input[name="S101"]')) : 0;
        updRos['updRos[' + counter + '].S102_'] = $this.find('input[name="S102"]').val();  //kOzn == 0 ? convertDisabledInputValue($this.find('input[name="S102"]')) : 0;
        updRos['updRos[' + counter + '].S103_'] = $this.find('input[name="S103"]').val();  //sOzn == 0 ? convertDisabledInputValue($this.find('input[name="S103"]')) : 0;
        updRos['updRos[' + counter + '].S104_'] = $this.find('input[name="S104"]').val();  //skzn == 0 ? convertDisabledInputValue($this.find('input[name="S104"]')) : 0;
        updRos['updRos[' + counter + '].S200_'] = $this.find('input[name="S200"]').val();  //skOn == 0 ? convertDisabledInputValue($this.find('input[name="S200"]')) : 0;
        updRos['updRos[' + counter + '].S201_'] = $this.find('input[name="S201"]').val();  //skOz == 0 ? convertDisabledInputValue($this.find('input[name="S201"]')) : 0;
        updRos['updRos[' + counter + '].S202_'] = $this.find('input[name="S202"]').val();  //skOzn== 0 ? convertDisabledInputValue($this.find('input[name="S202"]')) : 0;
        updRos['updRos[' + counter + '].S203_'] = $this.find('input[name="S203"]').val();  //skOzn = 0 ? convertDisabledInputValue($this.find('input[name="S203"]')) : 0;
        updRos['updRos[' + counter + '].SUTVX_'] = $this.find('input[name="SUTVX"]').val();  //skOzn = 0 ? convertDisabledInputValue($this.find('input[name="SUTVX"]')) : 0;
        updRos['updRos[' + counter + '].SUTVI_'] = $this.find('input[name="SUTVI"]').val(); //skOzn = 0 ? convertDisabledInputValue($this.find('input[name="SUTVI"]')) : 0;
        updRos['updRos[' + counter + '].SUTV1_'] = 0;
        updRos['updRos[' + counter + '].SUTV2_'] = 0;
        updRos['updRos[' + counter + '].SUTV3_'] = 0;
        updRos['updRos[' + counter + '].SUTV4_'] = 0;
        updRos['updRos[' + counter + '].SUTV5_'] = 0;
        updRos['updRos[' + counter + '].SUTV6_'] = 0;
        updRos['updRos[' + counter + '].SUTV7_'] = 0;
        updRos['updRos[' + counter + '].SUTV8_'] = 0;
        updRos['updRos[' + counter + '].SUTV9_'] = 0;
        updRos['updRos[' + counter + '].SUTV10_'] = 0;
        updRos['updRos[' + counter + '].SUTV11_'] = 0;
        updRos['updRos[' + counter + '].SUTV12_'] = 0;
      } else if (skOzn == 1) {
        updRos['updRos[' + counter + '].SUTVG_'] = 0;
        updRos['updRos[' + counter + '].S100_'] = 0;
        updRos['updRos[' + counter + '].S101_'] = 0;
        updRos['updRos[' + counter + '].S102_'] = 0;
        updRos['updRos[' + counter + '].S103_'] = 0;
        updRos['updRos[' + counter + '].S104_'] = 0;
        updRos['updRos[' + counter + '].S200_'] = 0;
        updRos['updRos[' + counter + '].S201_'] = 0;
        updRos['updRos[' + counter + '].S202_'] = 0;
        updRos['updRos[' + counter + '].S203_'] = 0;
        updRos['updRos[' + counter + '].SUTVX_'] = 0;
        updRos['updRos[' + counter + '].SUTVI_'] = 0;
        updRos['updRos[' + counter + '].SUTV1_'] = $this.find('input[name="SUTV1"]').val();   //skOzn == 1 ? convertDisabledInputValue($this.find('input[name="SUTV1"]')) : 0;
        updRos['updRos[' + counter + '].SUTV2_'] = $this.find('input[name="SUTV2"]').val();  //skOzn == 1 ? convertDisabledInputValue($this.find('input[name="SUTV2"]')) : 0;
        updRos['updRos[' + counter + '].SUTV3_'] = $this.find('input[name="SUTV3"]').val();  //skOzn == 1 ? convertDisabledInputValue($this.find('input[name="SUTV3"]')) : 0;
        updRos['updRos[' + counter + '].SUTV4_'] = $this.find('input[name="SUTV4"]').val();  //skOzn == 1 ? convertDisabledInputValue($this.find('input[name="SUTV4"]')) : 0;
        updRos['updRos[' + counter + '].SUTV5_'] = $this.find('input[name="SUTV5"]').val();  //skOzn == 1 ? convertDisabledInputValue($this.find('input[name="SUTV5"]')) : 0;
        updRos['updRos[' + counter + '].SUTV6_'] = $this.find('input[name="SUTV6"]').val();  //skOzn == 1 ? convertDisabledInputValue($this.find('input[name="SUTV6"]')) : 0;
        updRos['updRos[' + counter + '].SUTV7_'] = $this.find('input[name="SUTV7"]').val();  //skOzn == 1 ? convertDisabledInputValue($this.find('input[name="SUTV7"]')) : 0;
        updRos['updRos[' + counter + '].SUTV8_'] = $this.find('input[name="SUTV8"]').val();  //skOzn == 1 ? convertDisabledInputValue($this.find('input[name="SUTV8"]')) : 0;
        updRos['updRos[' + counter + '].SUTV9_'] = $this.find('input[name="SUTV9"]').val();  //skOzn == 1 ? convertDisabledInputValue($this.find('input[name="SUTV9"]')) : 0;
        updRos['updRos[' + counter + '].SUTV10_'] = $this.find('input[name="SUTV10"]').val();   //skOzn == 1 ? convertDisabledInputValue($this.find('input[name="SUTV10"]')) : 0;
        updRos['updRos[' + counter + '].SUTV11_'] = $this.find('input[name="SUTV11"]').val();  //skOzn == 1 ? convertDisabledInputValue($this.find('input[name="SUTV11"]')) : 0;
        updRos['updRos[' + counter + '].SUTV12_'] = $this.find('input[name="SUTV12"]').val(); //skOzn == 1 ? convertDisabledInputValue($this.find('input[name="SUTV12"]')) : 0;
      }
      updRos['updRos[' + counter + '].NR_'] = nr;
      updRos['updRos[' + counter + '].ND_'] = nd;
      updRos['updRos[' + counter + '].DATD_'] = datd;
      updRos['updRos[' + counter + '].TT_'] = tt;

      /*datd: $('#dateInput').val()*/
      counter++;
      //}
    });
    //alert('2');
    var post = $.post('/barsroot/koshtoris/savekoshtoris/',
      $.extend(updRos, {
        sk: sk,
        tt: tt,
        datd: datd,
        nd: nd,
        nr: nr
      }),
      function(data, textStatus) {
        if (textStatus == 'success') {
          var resData = data.data;          
          $('#inputDoc').data('nr', data.nr);
          //alert(data.nr);

          if (data.status == 'ok') {
            /*tr.quickEach(function () {
              var $this = this;
              $.each(resData, function() {
                if (this.KEKV == $this.data('kekv')) {
                  $this.data('kosid', this.ID);
                }
              });
            });
            //$.each(resData, function () {
              //tr.find('[data-kekv="'++'"]');
            //});*/
            barsUiAlert(data.message);
            //thisTR.attr('data-KOSID', data.message);
            //table.data('NR', data.nr);
          }
          if (data.status == 'error') {
            /*tr.quickEach(function () {
              var $this = this;
              $.each(resData, function() {
                if (this.KEKV == $this.data('kekv')) {
                  $this.data('kosid', this.ID);
                }
              });
            });*/
            var protocol = '';

            //tr.quickEach(function () {
              //var $this = this;
              $.each(resData, function () {
                //if (this.KEKV == $this.data('kekv')) {
                  if (this.STATUS == 'ok') {
                    //$this.data('kosid', this.ID);
                  } else {
                    //$this.addClass('error').attr('title', this.MESSAGE);
                    protocol += '<b>KEKV ' + this.KEKV + ': </b> ' + this.MESSAGE + '<br/>';
                  }
                //}
              //});
            });

            barsUiAlert( data.message, 'Помилка', 'error',function() {
              var dialog = $('<div />', {'style':'font-size:12px;'});
              dialog.html(protocol)
              .dialog({
                autoOpen: true,
                modal: true,
                resizable: false,
                position: 'center',
                title: 'Протокол помилок!!!',
                width: '500',
                height: '400',
                close: function () {
                  dialog.dialog('close').remove();
                },
                buttons: [
                  {
                    text: 'Закрити',
                    click: function () { dialog.dialog('close').remove(); }
                  }
                ]
              });
            });
            


            //$elem.val('0.00');
            //recountParent(elem);
            //recountResultRow(elem);
          }
        }
        $('#main').loader('remove');
        post = null;
      }, 'json');
    /*if (docCreate) {
      $('#main').loader();
      setTimeout(function () {
        $('#main').loader('remove');
        barsUiAlert('Показники успішно збережені.');
      }, 2000);
    }*/
  } else {
    barsUiAlert('Незаповнено поле "Номер документа"', '', 'error');
    $('#nd').addClass('error');
  }
}
function updateKoshtoris(elem) {
  var skOzn = $('#sk option:selected').data('ozn');
  var $elem = $(elem);
  var thisTR = $elem.parentsUntil('tr').parent();
  var table = $elem.parentsUntil('table').parent();
  var nd = $('#nd').val();
  var tableDiect = $('#headTable');

  if (nd != "") {
    var post = $.post('/barsroot/koshtoris/savekoshtoris/',
        {
          ID_: thisTR.data('kosid'),
          BUD_: tableDiect.data("bud"),  //$('#bud-kod').val(),
          RRK_: tableDiect.data("rrk"),  //$('#rrk-kod').val(),
          KVK_: tableDiect.data("kvk"),  //$('#kvk-kod').val(),
          KRK_: tableDiect.data("krk"),  //$('#krk-kod').val(),
          KPOL_:tableDiect.data("krk"),  //$('#krk-kod').val(),
          UDK_: tableDiect.data("udk"),  //$('#udk-kod').val(),
          KPK_: tableDiect.data("kpk"),  //$('#kpk-kod').val(),
          KFK_: tableDiect.data("kfk"),  //""
          KEKV_: thisTR.data('kekv'),
          SK_: $('#sk option:selected').val(),
          SUTVG_: skOzn == 0 ? thisTR.find('input[name="SUTVG"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          S100_: skOzn == 0 ? thisTR.find('input[name="S100"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,          
          S101_: skOzn == 0 ? thisTR.find('input[name="S101"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          S102_: skOzn == 0 ? thisTR.find('input[name="S102"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          S103_: skOzn == 0 ? thisTR.find('input[name="S103"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          S104_: skOzn == 0 ? thisTR.find('input[name="S104"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          S200_: skOzn == 0 ? thisTR.find('input[name="S200"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,          
          S201_: skOzn == 0 ? thisTR.find('input[name="S201"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          S202_: skOzn == 0 ? thisTR.find('input[name="S202"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          S203_: skOzn == 0 ? thisTR.find('input[name="S203"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          SUTVX_: skOzn == 0 ? thisTR.find('input[name="SUTVX"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,          
          SUTVI_: skOzn == 0 ? thisTR.find('input[name="SUTVI"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,      
          SUTV1_: skOzn == 1 ? thisTR.find('input[name="SUTV1"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          SUTV2_: skOzn == 1 ? thisTR.find('input[name="SUTV2"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          SUTV3_: skOzn == 1 ? thisTR.find('input[name="SUTV3"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          SUTV4_: skOzn == 1 ? thisTR.find('input[name="SUTV4"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          SUTV5_: skOzn == 1 ? thisTR.find('input[name="SUTV5"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          SUTV6_: skOzn == 1 ? thisTR.find('input[name="SUTV6"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          SUTV7_: skOzn == 1 ? thisTR.find('input[name="SUTV7"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          SUTV8_: skOzn == 1 ? thisTR.find('input[name="SUTV8"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          SUTV9_: skOzn == 1 ? thisTR.find('input[name="SUTV9"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          SUTV10_: skOzn == 1 ? thisTR.find('input[name="SUTV10"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          SUTV11_: skOzn == 1 ? thisTR.find('input[name="SUTV11"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          SUTV12_: skOzn == 1 ? thisTR.find('input[name="SUTV12"]').val().replace(/\s+/g, '')/*.replace('.', '')*/ : 0,
          NR_: table.data('nr'),
          ND_: $('#nd').val(),
          DATD_: $('#dateInput').val(),
          TT_: $('#tts option:selected').val(),
          datd: $('#dateInput').val()
        },
        function (data, textStatus) {
          if (textStatus == 'success') {
            if (data.status == 'ok') {
              thisTR.data('kosid', data.message);
              table.data('nr', data.nr);
            }
            if (data.status == 'error') {
              barsUiAlert('Неможливо зберегти данні через помилку: ' + data.message, 'Помилка', 'error');
              $elem.val('0.00');
              recountParent(elem);
              recountResultRow(elem);
            }
          }
          post = null;
        }, 'json');
  }
  else {
    barsUiAlert('Незаповнено поле "Номер документа"', '', 'error');
    $elem.val('0.00');
    recountParent(elem);
    recountResultRow(elem);
  }
}

//перераховуємо значення для батьківського елемента в стовбчику
function recountParent(elem) {

  var $elem = $(elem);
  var thisTr = $elem.parentsUntil('tr').parent();
  var tBody = $elem.parentsUntil('tbody').parent();
  var thisColspan = thisTr.find('td:first').attr('colspan');
  thisColspan = thisColspan == undefined ? 0 : (parseInt(thisColspan, 10) - 1);

  var parentId = thisTr.data('kekvp');
  var curIndex = $elem.parent().index();

  var parentTr = tBody.find('tr[data-kekv="' + parentId + '"]');// $('#inputDoc tbody tr[data-KEKV="' + parentId + '"]');

  var parentColspan = parentTr.find('td:first').attr('colspan');
  parentColspan = parentColspan == undefined ? 0 : (parseInt(parentColspan, 10) - 1);
  var allChild = tBody.find('tr[data-kekvp="' + parentId + '"]').not('tr[data-kekv=""]');// $('#inputDoc tbody tr[data-KEKVP="' + parentId + '"]').not('tr[data-KEKV=""]');
  var sumChild = 0;
  allChild.quickEach(function (index, e) {
    var val = this.find('td').eq((curIndex + thisColspan)).find('input').val().replace(/\s+/g, '').replace('.', '');
    if (val == "") {
      val = 0;
    }
    sumChild += parseInt(val, 10);
  });

  if (thisTr.data('kekv') != '') {
    parentTr.find('td').eq(curIndex - parentColspan).find('input').val(separateMoney((sumChild / 100)));
    recountParent(parentTr.find('td').eq(curIndex - parentColspan).find('input').get(0));

  }
}

//перераховуємо загальну суму рядка
function recountResultRow(elem) {
  var $elem = $(elem);
  var parentId = $elem.parent().data('parentcolumnid');
  if (parentId != '') {
    var curTr = $elem.parentsUntil('tr').parent();//поточний рядок
    var parentTd = curTr.find('td[data-columnid="' + parentId + '"]');
    var allChild = curTr.find('td[data-parentcolumnid="' + parentId + '"]');
    var sumChild = 0;
    if (allChild.length != 0) {
      allChild.quickEach(function () {
        var val = this.find('input').val().replace(/\s+/g, '').replace('.', '');
        if (val == "") {
          val = 0;
        }
        sumChild += parseInt(val, 10);
      });
      parentTd.find('input').val(separateMoney((sumChild / 100)));
      recountResultRow(parentTd.find('input').get(0));
      recountParent(parentTd.find('input').get(0));
    }
  }
}

function createNewDoc() {
  $('#main').loader();
  $('#mainDocument').load('/barsroot/koshtoris/document/?partial=true', function () { $('#main').loader('remove'); });
}

function goCustAcc() {
  $('#main').loader();
  //$('#mainDocument').load('/barsroot/kaznacustacc/index/?partial=true', function () { $('#main').loader('remove'); });
  document.location.href = '/barsroot/kaznacustacc/index/?krk=' + $('#krk-kod').val();
}
function hrefRegistry() {
  $('#main').loader();
  document.location.href = '/barsroot/koshtoris/registry/?krk=' + $('#krk-kod').val();
}
function onLoadKoshtoris() {
    $('#inputDoc input')
        .focus(function() {
            this.select();
            var $this = $(this);
            $this.addClass('focus').one('blur', function () { $this.removeClass('focus'); });
        })
        .change(function () {
            this.value = separateMoney(this.value);
            if (bars.test.hasIE < 7) { } else {
                recountParent(this);
                recountResultRow(this);
            }

      })
      .numberMask({ beforePoint: 10, pattern: /^(-)?([\d])*(\.|\,)?([0-9])*$/ });
  //.maskMoney({ allowZero: true, allowNegative: true, thousands: ' ' });
  // $('#inputDoc input').maskMoney({ allowZero: true, allowNegative: true, thousands: ' ' });


  /*$('#inputDoc input').not('[disabled="disabled"]').on('change', function () {
    recountParent(this);
    recountResultRow(this);
    //updateKoshtoris(this);
  }).maskMoney({ allowZero: true, allowNegative: true, thousands: ' ' });*/

  /*$('.table input[type="text"]').focus(function () {
    var $this = $(this);
    $this.addClass('focus').one('blur', function () { $(this).removeClass('focus'); });
  });*/

  if (bars.test.hasIE < 7) {}else{
    var widthTd0 = 0;

    var table = $('#inputDoc');
    var tablePosition = table.offset();
    var tableTheadCont = table.find('thead tr td');
    var thead = $('<table/>').attr({ 'class': table.attr('class'), 'cellpadding': '0', 'cellspacing': '0' })
      .css({ 'width': table.width() + 'px', 'border': '0' })
      .append(table.find('thead').clone());
    thead.find('thead tr td').quickEach(function() {
      this.css('width', tableTheadCont.eq(this.index()).width() + 'px');
      if (this.index() == 0) {
        widthTd0 = tableTheadCont.eq(this.index()).width();
      }
    });
    thead.css({ 'position': 'fixed', 'top': '0', 'display': 'none' })
      .insertAfter($('#inputDoc'));

    var firstTd = table.clone();
    firstTd.find('tr').quickEach(function() {
      //this.find('td:not(:first)').remove();
      this.find('td:not(:eq(1))').remove();
    });
    firstTd.find('tr:last').remove();

    var firstColumn = $('<table/>').attr({ 'class': table.attr('class'), 'cellpadding': '0', 'cellspacing': '0' })
      .css({ 'background-color': '#fff', 'width': '30px' })
      .append(firstTd.find('tr')).append('<tr><td>всього</td></tr>');
    firstColumn.css({ 'position': 'fixed', 'top': '0', 'display': 'none' })
      .insertAfter($('#inputDoc'));

    $(window).scroll(function() {
      if ($(window).scrollTop() > tablePosition.top) {
        thead.show();
        thead.css({ left: (tablePosition.left - $(window).scrollLeft()), top: -5 });
      } else {
        thead.hide();
      }
      if ($(window).scrollLeft() > tablePosition.left + parseInt(widthTd0)) {
        firstColumn.css({ top: (tablePosition.top - 5) - $(document).scrollTop(), left: 0 });

        firstColumn.show();
      } else {
        firstColumn.hide();
      }
    });
  }
}
