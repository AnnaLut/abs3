<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dialogfulladr.aspx.cs" Inherits="Dialogs_DialogFullAdr" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Полный адрес клиента</title>
    <link href="/Common/CSS/AppCSS.css" rel="Stylesheet" type="text/css" />
    <link href="/barsroot/clientregister/DefaultStyleSheet.css" rel="Stylesheet" type="text/css" />
    <link rel="stylesheet" href="/Common/CSS/jquery/jquery.css " />
    <script language="javascript" type="text/javascript" src="/Common/jquery/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/Common/jquery/jquery-ui.js"></script>
    <script language="javascript" type="text/javascript">
        var CustomerAddress = new Object();

        $(function () {
            $("#accordion1").accordion({ autoHeight: false, icons: false });
            $("input[type=submit], button").button();

            InitObjects();
        });

        function addKeydown(id, adres) {
            $('#FGTWN' + id + ',#FGOBL' + id + ',#FGDST' + id).keydown(function (e) {
                if ($('#TeritoryCode' + id).val() != '' && parseInt($('#TeritoryCode' + id).val(),10) > 0) {
                    if (confirm('Увага!\n Поля "Область", "Район", "Населений пункт"\n заповненні автоматично шляхом вибору з довідника.\n Вразі внесення змін у вказані поля Ви покладаєте на себе\n особисту відповідальність за коректність їх заповнення.\n\n Ви впевнені що Вам це потрібно?')) {
                        adres.territory_id = null;
                        $('#TeritoryCode' + id).val('');
                        $('#TerCod' + id).val('');
                    }
                    else {
                        return false;
                    }
                }
            });
        }

        function addValueToHtml(id, adres) {
            $('#FGIDX' + id).val(adres.zip);
            $('#FGOBL' + id).val(adres.domain);
            $('#FGDST' + id).val(adres.region);
            $('#FGTWN' + id).val(adres.locality);
            $('#FGADR' + id).val(adres.address);
            $('#TeritoryCode' + id).val(adres.territory_id);
            $('#TerCod' + id).val(adres.territory_id);

            $('#LocalityType' + id + ' option[value="' + (adres.locality_type == null ? '99' : adres.locality_type) + '"]').attr("selected", "selected");
            $('#StreetType' + id + ' option[value="' + (adres.street_type == null ? '99' : adres.street_type) + '"]').attr("selected", "selected");
            $('#Street' + id).val(adres.street == '' ? adres.address : adres.street);
            $('#HomeType' + id + ' option[value="' + (adres.home_type == null ? '99' : adres.home_type) + '"]').attr("selected", "selected");
            $('#Home' + id).val(adres.home);
            $('#HomePartType' + id + ' option[value="' + (adres.homepart_type == null ? '99' : adres.homepart_type) + '"]').attr("selected", "selected");
            $('#HomePart' + id).val(adres.homepart);
            $('#RoomType' + id + ' option[value="' + (adres.room_type == null ? '99' : adres.room_type) + '"]').attr("selected", "selected");
            $('#Room' + id).val(adres.room);
            $('#Comment' + id).val(adres.Comment);
        }

        function InitObjects() {
            // адреса берем из параметров диалога
            CustomerAddress = window.dialogArguments;

            addKeydown(1, CustomerAddress.type1);
            addKeydown(2, CustomerAddress.type2);
            addKeydown(3, CustomerAddress.type3);

            // заполняем контролы
            if (/*CustomerAddress.type1.filled*/true) {
                addValueToHtml(1, CustomerAddress.type1);
            }

            if (/*CustomerAddress.type2.filled*/true) {
                addValueToHtml(2, CustomerAddress.type2);
            }

            if (/*CustomerAddress.type3.filled*/true) {
                addValueToHtml(3, CustomerAddress.type3);
            }
        }

        function isUsedAdders(id) {
            if ($('#FGIDX' + id).val() 
                ||$('#FGOBL' + id).val()
                ||$('#FGDST' + id).val()
                ||$('#FGTWN' + id).val()
                ||$('#TerCod' + id).val()
                ||$('#Street' + id).val()
                ||$('#Home' + id).val()
                ||$('#HomePart' + id).val()
                ||$('#Room' + id).val()
                ||$('#Comment' + id).val()) {
                return true;
            }
            return false;
        }


        function Validate() {
            if (!validateUrAdr() || !validateFactAdr() || !validatePostAdr()) {
                return false;
            }
            return true;
        }

        function validateUrAdr() {
            //перевірка чи вибрано код території
            if (!$('#TerCod1').val()) {
                alert('Не заповнено поле "Юр. адреса - код території"');
                return false;
            }
            // проверяем что заполнены поля "Населений пункт" и "Вулиця, будинок, кв." Юр. адреса заполнены
            if (!$('#FGTWN1').val()) {
                alert('Не заповнено поле "Юр. адреса - Населений пункт"');
                $('#FGTWN1').focus();
                return false;
            }
            else if (!$('#Street1').val()) {
                alert('Не заповнено поле "Юр. адреса - вул., просп., б-р"');
                $('#Street1').focus();
                return false;
            }
            else if (!$('#Home1').val()) {
                alert('Не заповнено поле "Юр. адреса - № буд., д/в"');
                $('#Home1').focus();
                return false;
            }
            if (!validLocality(1) || !validStreet(1) || !validHome(1) || !validHomePart(1) || !validRoom(1)) {
                return false;
            }
            return true;
        }
        function validateFactAdr() {
            if (isUsedAdders(2)) {
                if (!$('#TerCod2').val()) {
                    alert('Не заповнено поле "Фактична адреса - код території"');
                    return false;
                }
            }

            if (!validLocality(2) || !validStreet(2) || !validHome(2) || !validHomePart(2) || !validRoom(2)) {
                return false;
            }
            return true;
        }
        function validatePostAdr() {
            if (isUsedAdders(3)) {
                if (!$('#TerCod3').val()) {
                    alert('Не заповнено поле "Поштова адреса - код території"');
                    return false;
                }
            }
            if (!validLocality(3) || !validStreet(3) || !validHome(3) || !validHomePart(3) || !validRoom(3)) {
                return false;
            }
            return true;
        }


        function validLocality(id) {
            if ($('#LocalityType' + id + ' option:selected').val() != '99' && $('#FGTWN' + id).val() == '') {
                alert('Для ' + getNameAdres(id) + ' адреси вибрано тип але не заповнено поле "Населений пункт"');
                $('#FGTWN' + id).focus();
                return false;
            }
            return true;
        }
        function validStreet(id) {
            if ($('#StreetType' + id + ' option:selected').val() != '99' && $('#Street' + id).val() == '') {
                alert('Для ' + getNameAdres(id) + ' адреси вибрано тип але не заповнено поле "Вулиця"');
                $('#Street' + id).focus();
                return false;
            }
            return true;
        }
        function validHome(id) {
            if ($('#HomeType' + id + ' option:selected').val() != '99' && $('#Home' + id).val() == '') {
                alert('Для ' + getNameAdres(id) + ' адреси вибрано тип але не заповнено поле "Будинок"');
                $('#Home' + id).focus();
                return false;
            }
            return true;
        }
        function validHomePart(id) {
            if ($('#HomePartType' + id + ' option:selected').val() != '99' && $('#HomePart' + id).val() == '') {
                alert('Для ' + getNameAdres(id) + ' адреси вибрано тип але не заповнено поле "Корпус"');
                $('#HomePart' + id).focus();
                return false;
            }
            return true;
        }
        function validRoom(id) {
            if ($('#RoomType' + id + ' option:selected').val() != '99' && $('#Room' + id).val() == '') {
                alert('Для ' + getNameAdres(id) + ' адреси вибрано тип але не заповнено поле "Квартира"');
                $('#Room' + id).focus();
                return false;
            }
            return true;
        }

        function addValueToObj(id, adres) {
            if ($('#FGTWN' + id).val()/* && $('#FGADR'+id).val()*/) {
                adres.filled = true;
                adres.zip = $('#FGIDX' + id).val();
                adres.domain = $('#FGOBL' + id).val();
                adres.region = $('#FGDST' + id).val();
                adres.locality = $('#FGTWN' + id).val();
                adres.address = returnAdres(id); //$('#FGADR' + id).val();
                adres.territory_id = $('#TeritoryCode' + id).val();

                adres.locality_type = $('#LocalityType' + id + ' option:selected').val();
                adres.street_type = $('#StreetType' + id + ' option:selected').val();
                adres.street = $('#Street' + id).val();
                adres.home_type = $('#HomeType' + id + ' option:selected').val();
                adres.home = $('#Home' + id).val();
                adres.homepart_type = $('#HomePartType' + id + ' option:selected').val();
                adres.homepart = $('#HomePart' + id).val();
                adres.room_type = $('#RoomType' + id + ' option:selected').val();
                adres.room = $('#Room' + id).val();
                adres.Comment = $('#Comment' + id).val();
            }
            else {
                adres.filled = false;
                adres.zip = null;
                adres.domain = null;
                adres.region = null;
                adres.locality = null;
                adres.address = null;
                adres.territory_id = null;

                adres.locality_type = null;
                adres.street_type = null;
                adres.street = null;
                adres.home_type = null;
                adres.home = null;
                adres.homepart_type = null;
                adres.homepart = null;
                adres.room_type = null;
                adres.room = null;
                adres.Comment = null;
            }
        }

        function ReturnVal() {
            if (!Validate()) return false;

            addValueToObj(1, CustomerAddress.type1);
            addValueToObj(2, CustomerAddress.type2);
            addValueToObj(3, CustomerAddress.type3);

            var id = 1;
            var strReturn = $('#LocalityType' + id + ' option:selected').html() + ' ' + $('#FGTWN' + id).val();
            if (strReturn != ' ') strReturn += ', ';
            strReturn += returnAdres(id);
            window.returnValue = new Array(CustomerAddress, strReturn);
            window.close();
        }

        function Close() {
            window.returnValue = null;
            window.close();
        }

        function returnAdres(id) {
            var strRet = '';
            /*if ($('#LocalityType'+id+' option:selected').html()!='')
                strRet+=$('#LocalityType'+id+' option:selected').html();
            if ($('#FGTWN'+id).val()!='')
                strRet+= ' '+$('#FGTWN'+id).val();*/
            if ($('#StreetType' + id + ' option:selected').html() != '' || $('#Street' + id).val() != '') {
                //if (strRet!='') strRet+=', ';
                strRet += $('#StreetType' + id + ' option:selected').html();
                strRet += ' ' + $('#Street' + id).val();
            }
            if ($('#HomeType' + id + ' option:selected').html() != '' || $('#Home' + id).val() != '') {
                if (strRet != '') strRet += ', ';
                strRet += $('#HomeType' + id + ' option:selected').html();
                strRet += ' ' + $('#Home' + id).val();
            }
            if ($('#HomePartType' + id + ' option:selected').html() != '' || $('#HomePart' + id).val() != '') {
                if (strRet != '') strRet += ', ';
                strRet += $('#HomePartType' + id + ' option:selected').html();
                strRet += ' ' + $('#HomePart' + id).val();
            }
            if ($('#RoomType' + id + ' option:selected').html() != '' || $('#Room' + id).val() != '') {
                if (strRet != '') strRet += ', ';
                strRet += $('#RoomType' + id + ' option:selected').html();
                strRet += ' ' + $('#Room' + id).val();
            }
            return strRet;
        }

        function ShowAdrManual(typeId) {
            var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=TERRITORY&tail=""&role=WR_CUSTREG', 'dialogHeight:600px; dialogWidth:600px');
            if (result != null && result[0] != null) {
                $('#TeritoryCode' + typeId).val(result[0]);
                if (result[0] != null) $('#TerCod' + typeId).val(result[0]);
                if (result[1] != null) $('#FGTWN' + typeId).val(result[1]);
                if (result[3] != null) $('#FGOBL' + typeId).val(result[3]);
                if (result[4] != null) $('#FGDST' + typeId).val(result[4]);
            }
        }

        function getNameAdres(id) {
            var typeName = '';
            switch (id) {
                case 1: typeName = 'юридичної'; break;
                case 2: typeName = 'фактичної'; break;
                case 3: typeName = 'поштової'; break;
                default: break;
            }
            return typeName;
        }

        function fillAdress(type) {
            if (validateUrAdr()) {
                addValueToObj(1, CustomerAddress.type1);
                addValueToHtml(type, CustomerAddress.type1);
            }
        }
    </script>
    <style type="text/css">
        .address {
            text-align: left;
        }

            .address td.label {
                text-align: right;
                white-space: nowrap;
            }

        .edit {
            width: 300px;
        }

        .editMiddle {
            width: 240px;
        }

        .editSmall {
            width: 100px;
        }

        .ref {
            width: 20px;
        }

        .composite.part1 {
            width: 100px;
        }

        .composite.part2 {
            width: 30px;
        }

        .main_layout {
            width: 600px;
            height: 400px;
        }

        .accordion_layout {
            height: 300px;
            padding: 0 30px 0 30px;
        }

        .buttons_layout {
            margin: 10px 0 10px 10px;
            text-align: right;
        }

        div.required {
            display: inline;
            font-size: 12pt;
            width: 8px;
            color: red;
            height: 18px;
        }

        select.small {
            width: 60px;
        }

        #accordion {
            height: 500px;
            overflow: auto;
            width: 540px;
            border-bottom: 1px solid #dcdcdc;
        }

            #accordion h3 {
                padding: 3px 3px 3px 5px;
                margin-bottom: 0;
                margin-top: 0;
                font-size: 18px;
                background-color: #62bae7;
                border: 1px solid #2693e7;
                color: #ffffff;
            }

            #accordion .accordion-content {
                background-color: #f7f8f9;
                border: 1px solid #dcdcdc;
                margin-bottom: 0;
                padding-top: 5px;
                padding-bottom: 5px;
                width: 520px;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main_layout">
            <div style="margin: 10px 30px 10px 10px; text-align: right;">
                <input type="button" onclick="fillAdress(2);" title="Заповнити фактичну адресу на основі данних з юридичної" value="Заповнити факт. адр." />
                <input type="button" onclick="fillAdress(3);" title="Заповнити поштову адресу на основі данних з юридичної" value="Заповнити пошт. адр." />
            </div>
            <div class="accordion_layout">
                <div id="accordion">
                    <h3>Юридична</h3>
                    <div class="accordion-content">
                        <table class="address" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="label">Індекс:
                                </td>
                                <td>
                                    <input type="text" id="FGIDX1" class="edit composite part1" maxlength="20" tabindex="101" />
                                    <span>код тер.</span>
                                    <input type="text" id="TerCod1" class="edit composite part1" maxlength="20" tabindex="101" disabled="disabled" />
                                    <input type="button" id="ref1" class="ref composite part2" value="..." onclick="ShowAdrManual(1); " />
                                    <div class="required">*</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="label">Область:
                                </td>
                                <td>
                                    <input type="text" id="FGOBL1" class="edit" maxlength="30" tabindex="102" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">Район:
                                </td>
                                <td>
                                    <input type="text" id="FGDST1" class="edit" maxlength="30" tabindex="103" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">Населений пункт:
                                </td>
                                <td>
                                    <select id="LocalityType1" class="small" runat="server"></select>
                                    <input type="text" id="FGTWN1" class="editMiddle" maxlength="60" tabindex="104" />
                                    <div class="required">*</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="label">вул, просп., б-р:
                                </td>
                                <td>
                                    <select id="StreetType1" class="small" runat="server"></select>
                                    <input id="Street1" type="text" class="editMiddle" />
                                    <div class="required">*</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="label">№ буд., д/в:
                                </td>
                                <td>
                                    <select id="HomeType1" class="small" runat="server"></select>
                                    <input id="Home1" type="text" class="editSmall" maxlength="10" />
                                    <div class="required">*</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="label">№ корп., секц.:
                                </td>
                                <td>
                                    <select id="HomePartType1" class="small" runat="server"></select>
                                    <input id="HomePart1" type="text" class="editSmall" maxlength="10" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">№ кв., кімн., оф.:
                                </td>
                                <td>
                                    <select id="RoomType1" class="small" runat="server"></select>
                                    <input id="Room1" type="text" class="editSmall" maxlength="10" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">Примітка:
                                </td>
                                <td>
                                    <textarea class="edit" id="Comment1" runat="server" row="2">                                        
                                    </textarea>
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" id="TeritoryCode1" />
                    </div>
                    <h3>Фактична</h3>
                    <div class="accordion-content">
                        <table class="address" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="label">Індекс:
                                </td>
                                <td>
                                    <input type="text" id="FGIDX2" class="edit composite part1" maxlength="20" tabindex="201" />
                                    <span>код тер.</span>
                                    <input type="text" id="TerCod2" class="edit composite part1" maxlength="20" tabindex="101" disabled="disabled" />
                                    <input type="button" id="ref2" class="ref composite part2" value="..." onclick="ShowAdrManual(2); " />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">Область:
                                </td>
                                <td>
                                    <input type="text" id="FGOBL2" class="edit" maxlength="30" tabindex="202" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">Район:
                                </td>
                                <td>
                                    <input type="text" id="FGDST2" class="edit" maxlength="30" tabindex="203" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">Населений пункт:
                                </td>
                                <td>
                                    <select id="LocalityType2" class="small" runat="server"></select>
                                    <input type="text" id="FGTWN2" class="editMiddle" maxlength="60" tabindex="204" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">вул, просп, б-р:
                                </td>
                                <td>
                                    <select id="StreetType2" class="small" runat="server"></select>
                                    <input id="Street2" type="text" class="editMiddle" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">№ буд., д/в:
                                </td>
                                <td>
                                    <select id="HomeType2" class="small" runat="server"></select>
                                    <input id="Home2" type="text" class="editSmall" maxlength="10" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">№ корп., секц.:
                                </td>
                                <td>
                                    <select id="HomePartType2" class="small" runat="server"></select>
                                    <input id="HomePart2" type="text" class="editSmall" maxlength="10" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">№ кв., кімн., оф.:
                                </td>
                                <td>
                                    <select id="RoomType2" class="small" runat="server"></select>
                                    <input id="Room2" type="text" class="editSmall" maxlength="10" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">Примітка:
                                </td>
                                <td>
                                    <textarea class="edit" id="Comment2" runat="server" row="2">                                        
                                    </textarea>
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" id="TeritoryCode2" />
                    </div>
                    <h3>Поштова</h3>
                    <div class="accordion-content">
                        <table class="address" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="label">Індекс:
                                </td>
                                <td>
                                    <input type="text" id="FGIDX3" class="edit composite part1" maxlength="20" tabindex="301" />
                                    <span>код тер.</span>
                                    <input type="text" id="TerCod3" class="edit composite part1" maxlength="20" tabindex="101" disabled="disabled" />
                                    <input type="button" id="ref3" class="ref composite part2" value="..." onclick="ShowAdrManual(3); " />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">Область:
                                </td>
                                <td>
                                    <input type="text" id="FGOBL3" class="edit" maxlength="30" tabindex="302" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">Район:
                                </td>
                                <td>
                                    <input type="text" id="FGDST3" class="edit" maxlength="30" tabindex="303" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">Населений пункт:
                                </td>
                                <td>
                                    <select id="LocalityType3" class="small" runat="server"></select>
                                    <input type="text" id="FGTWN3" class="editMiddle" maxlength="60" tabindex="304" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">вул, просп, б-р:
                                </td>
                                <td>
                                    <select id="StreetType3" class="small" runat="server"></select>
                                    <input id="Street3" type="text" class="editMiddle" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">№ буд., д/в:
                                </td>
                                <td>
                                    <select id="HomeType3" class="small" runat="server"></select>
                                    <input id="Home3" type="text" class="editSmall" maxlength="10" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">№ корп., секц.:
                                </td>
                                <td>
                                    <select id="HomePartType3" class="small" runat="server"></select>
                                    <input id="HomePart3" type="text" class="editSmall" maxlength="10" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">№ кв., кімн., оф.:
                                </td>
                                <td>
                                    <select id="RoomType3" class="small" runat="server"></select>
                                    <input id="Room3" type="text" class="editSmall" maxlength="10" />
                                </td>
                            </tr>
                            <tr>
                                <td class="label">Примітка:
                                </td>
                                <td>
                                    <textarea class="edit" id="Comment3" runat="server" row="2">                                        
                                    </textarea>
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" id="TeritoryCode3" />
                    </div>
                </div>
                <div class="buttons_layout">
                    <input type="button" value="Зберегти" onclick="ReturnVal(); " />
                    <input type="button" value="Відмінити" onclick="Close(); " />
                </div>
            </div>

        </div>
    </form>
</body>
</html>
