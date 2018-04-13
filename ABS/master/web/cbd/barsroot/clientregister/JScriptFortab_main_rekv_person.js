var dispFullFIO = false;
$(document).ready(function() {
  //якщо створюється карточка ФО не спд
  if (parent.obj_Parameters['CUSTTYPE'] == 'person' && getParamFromUrl('spd', document.location.href) !=1) {
    $('#bt_FullDopRekv').css({ 'display': 'inline' });
    ViewComponent();
    EdFIOKeyPres();
    SelDopRec();
  }
});

function SelDopRec() {
    var fioLn = parent.obj_Parameters['DopRekv_SN_LN'];
    var fioFn = parent.obj_Parameters['DopRekv_SN_FN'];
    var fioMn = parent.obj_Parameters['DopRekv_SN_MN'];
    var fio_4N = parent.obj_Parameters['DopRekv_SN_4N'];
    getEl('ed_FIO_LN').value = fioLn ;
    getEl('ed_FIO_FN').value = fioFn;
    getEl('ed_FIO_MN').value = fioMn;

    getEl('ed_FIO_LN_NR').value = fioLn ;
    getEl('ed_FIO_FN_NR').value = fioFn;
    getEl('ed_FIO_MN_NR').value = fioMn;
    getEl('ed_FIO_4N_NR').value = fio_4N;
}
//встановити обробники зміни стану елемента
function EdFIOKeyPres() {
  /*$('#ed_FIO_LN,#ed_FIO_FN,#ed_FIO_MN,#ed_FIO_LN_NR')
    .change(function () {
      EditNMKtext();
      $(this).removeClass('err');
    }).on('keypress', function (e) {
      if (e.ctrlKey && e.keyCode == 118) {//ctrl+v
        EditNMKtext();
        $(this).removeClass('err');
      }
    });*/

    $('#ed_FIO_LN').change(function () { EditNMKtext();$(this).removeClass('err');});
    $('#ed_FIO_FN').change(function () { EditNMKtext();$(this).removeClass('err');});
    $('#ed_FIO_MN').change(function () { EditNMKtext();$(this).removeClass('err');});

    $('#ed_FIO_LN_NR').change(function () { EditNMKtext();$(this).removeClass('err');});
    $('#ed_FIO_FN_NR').change(function () { EditNMKtext();});
    $('#ed_FIO_MN_NR').change(function () { EditNMKtext();});
    $('#ed_FIO_4N_NR').change(function () { EditNMKtext();});

  $('#bt_FullDopRekv').click(function() {
    dispFullFIO = !dispFullFIO;
    ShowInputFIO();
  });

  $('#ddl_CODCAGENT').change(function() { SwitchInputFIO(); });
}
//сховати/показати поля ФІО
function ShowInputFIO() {
    if (dispFullFIO) {
        var tmpSel = $get('ddl_CODCAGENT').item($get('ddl_CODCAGENT').selectedIndex).value.substr(0, 1);
        if (tmpSel == '1') {
            $('#trPersonFIO').css({ 'display': 'block' });
            $('#trPersonFIONR').css({ 'display': 'none' });
        } else {
            $('#trPersonFIO').css({ 'display': 'none' });
            $('#trPersonFIONR').css({ 'display': 'block' });
        }
    } else {
        $('#trPersonFIONR').css({ 'display': 'none' });
        $('#trPersonFIO').css({ 'display': 'none' });
    }
}

//переключити поля ФІО
function SwitchInputFIO() {
    if (dispFullFIO) {
        var tmpSel = $get('ddl_CODCAGENT').item($get('ddl_CODCAGENT').selectedIndex).value.substr(0, 1);
        if (tmpSel == '1') {
            $('#trPersonFIO').css({ 'display': 'block' });
            $('#trPersonFIONR').css({ 'display': 'none' });
            getEl('ed_FIO_LN').value = getEl('ed_FIO_LN_NR').value;
            getEl('ed_FIO_FN').value = getEl('ed_FIO_FN_NR').value;
            getEl('ed_FIO_MN').value = getEl('ed_FIO_MN_NR').value;
        } else {
            $('#trPersonFIO').css({ 'display': 'none' });
            $('#trPersonFIONR').css({ 'display': 'block' });

            getEl('ed_FIO_LN_NR').value = getEl('ed_FIO_LN').value;
            getEl('ed_FIO_FN_NR').value = getEl('ed_FIO_FN').value;
            getEl('ed_FIO_MN_NR').value = getEl('ed_FIO_MN').value;
        }
    } else {
        $('#trPersonFIONR').css({ 'display': 'none' });
        $('#trPersonFIO').css({ 'display': 'none' });
    }
}
//змінити параметри відображення компонентів
function ViewComponent() {
    $('#ed_NMK').attr('disabled' , 'disabled');
}
//змінити текст в ed_NMK
function EditNMKtext() {
    var ln ; var fn; var mn; var fourn = '';var fnNmk = '';var mnNmk = '';var fournNmk = '';
    var tmpSel = $get('ddl_CODCAGENT').item($get('ddl_CODCAGENT').selectedIndex).value.substr(0, 1);
    if (tmpSel == '1') {
        ln = getEl('ed_FIO_LN').value;
        fn = getEl('ed_FIO_FN').value;
        mn = getEl('ed_FIO_MN').value;
        $('#ed_NMK').val(ln.toUpperCase() + ' ' + fn.toUpperCase() + ' ' + mn.toUpperCase() );
    } else {
        ln = getEl('ed_FIO_LN_NR').value;
        fn = getEl('ed_FIO_FN_NR').value;
        mn = getEl('ed_FIO_MN_NR').value;
        fourn = getEl('ed_FIO_4N_NR').value;
        if (fn!='') fnNmk=' '+fn ;
        if (mn!='') mnNmk=' '+mn;
        if (fourn!='') fournNmk =' '+fourn;
        $('#ed_NMK').val(ln.toUpperCase() + fnNmk.toUpperCase() + mnNmk.toUpperCase() + fournNmk.toUpperCase() );
    }
    $('#ed_NMK').removeClass('err');
    $('#ed_NMKK').removeClass('err');
    $('#ed_NMKV').removeClass('err');

    $('#ed_NMKV').val('');
    $('#ed_NMKK').val('');
    CopyNMK();

    UpdeteDopReqv(ln, fn, mn, fourn);
}
//перевірка правильності заповнення FIO
function ValidFIOreqv() {
    var ln = getEl('ed_FIO_LN').value;
    var fn = getEl('ed_FIO_FN').value;
    var mn = getEl('ed_FIO_MN').value;
    var lnNr = getEl('ed_FIO_LN_NR').value;

    var tmpSel = $get('ddl_CODCAGENT').item($get('ddl_CODCAGENT').selectedIndex).value.substr(0, 1);
    if (tmpSel == '1') {
        if (ln == '') $('#ed_FIO_LN').addClass('err');
        if (fn == '') $('#ed_FIO_FN').addClass('err');
        if (mn == '') $('#ed_FIO_MN').addClass('err');
    } else {
        if (lnNr == '') $('#ed_FIO_LN_NR').addClass('err');
    }
}
//оновити доп. реквізити
function UpdeteDopReqv(ln, fn, mn, fourn) {
    parent.custAttrList['SN_LN'] = { Tag: 'SN_LN', Value: ln, Isp: '0' };
    parent.custAttrList['SN_FN'] = { Tag: 'SN_FN', Value: fn, Isp: '0' };
    parent.custAttrList['SN_MN'] = { Tag: 'SN_MN', Value: mn, Isp: '0' };
    parent.custAttrList['SN_4N'] = { Tag: 'SN_4N', Value: fourn, Isp: '0' };
    //-----------убрать--------
    /*var dopRecSnLn = parent.frames['Tab5'].getEl('gvMain_ctl07_edEdVal');
    var dopRecSnFn = parent.frames['Tab5'].getEl('gvMain_ctl05_edEdVal');
    var dopRecSnMn = parent.frames['Tab5'].getEl('gvMain_ctl06_edEdVal');

    $(dopRecSnLn).attr('disabled', 'disabled').val(ln);
    $(dopRecSnFn).attr('disabled', 'disabled').val(fn);
    $(dopRecSnMn).attr('disabled', 'disabled').val(mn);*/
    //--------------------------
}
