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
            $("#accordion").accordion({ heightStyle: "fill", icons : false });
            $("input[type=submit], button").button();

            InitObjects();
        });

        function InitObjects() {
            // адреса берем из параметров диалога
            CustomerAddress = window.dialogArguments;

            // заполняем контролы
            if (CustomerAddress.type1.filled) {
                $('#FGIDX1').val(CustomerAddress.type1.zip);
                $('#FGOBL1').val(CustomerAddress.type1.domain);
                $('#FGDST1').val(CustomerAddress.type1.region);
                $('#FGTWN1').val(CustomerAddress.type1.locality);
                $('#FGADR1').val(CustomerAddress.type1.address);
                $('#TeritoryCode1').val(CustomerAddress.type1.territory_id);
            }

            if (CustomerAddress.type2.filled) {
                $('#FGIDX2').val(CustomerAddress.type2.zip);
                $('#FGOBL2').val(CustomerAddress.type2.domain);
                $('#FGDST2').val(CustomerAddress.type2.region);
                $('#FGTWN2').val(CustomerAddress.type2.locality);
                $('#FGADR2').val(CustomerAddress.type2.address);
                $('#TeritoryCode2').val(CustomerAddress.type2.territory_id);
            }

            if (CustomerAddress.type3.filled) {
                $('#FGIDX3').val(CustomerAddress.type3.zip);
                $('#FGOBL3').val(CustomerAddress.type3.domain);
                $('#FGDST3').val(CustomerAddress.type3.region);
                $('#FGTWN3').val(CustomerAddress.type3.locality);
                $('#FGADR3').val(CustomerAddress.type3.address);
                $('#TeritoryCode3').val(CustomerAddress.type3.territory_id);
            }
        }

        function Validate() {
            // проверяем что заполнены поля "Населений пункт" и "Вулиця, будинок, кв." Юр. адреса заполнены
            if (!$('#FGTWN1').val()) {
                alert('Не заповнено поле "Юр. адреса - Населений пункт"');
                $('#FGTWN1').focus();
                return false;
            }
            else if (!$('#FGADR1').val()) {
                alert('Не заповнено поле "Юр. адреса - Вулиця, будинок, кв."');
                $('#FGADR1').focus();
                return false;
            }

            return true;
        }

        function ReturnVal() {
            if (!Validate()) return false;

            if ($('#FGTWN1').val() && $('#FGADR1').val()) {
                CustomerAddress.type1.filled = true;
                CustomerAddress.type1.zip = $('#FGIDX1').val();
                CustomerAddress.type1.domain = $('#FGOBL1').val();
                CustomerAddress.type1.region = $('#FGDST1').val();
                CustomerAddress.type1.locality = $('#FGTWN1').val();
                CustomerAddress.type1.address = $('#FGADR1').val();
                CustomerAddress.type1.territory_id = $('#TeritoryCode1').val();
            }
            else {
                CustomerAddress.type1.filled = false;
                CustomerAddress.type1.zip = null;
                CustomerAddress.type1.domain = null;
                CustomerAddress.type1.region = null;
                CustomerAddress.type1.locality = null;
                CustomerAddress.type1.address = null;
                CustomerAddress.type1.territory_id = null;
            }

            if ($('#FGTWN2').val() && $('#FGADR2').val()) {
                CustomerAddress.type2.filled = true;
                CustomerAddress.type2.zip = $('#FGIDX2').val();
                CustomerAddress.type2.domain = $('#FGOBL2').val();
                CustomerAddress.type2.region = $('#FGDST2').val();
                CustomerAddress.type2.locality = $('#FGTWN2').val();
                CustomerAddress.type2.address = $('#FGADR2').val();
                CustomerAddress.type2.territory_id = $('#TeritoryCode2').val();
            }
            else {
                CustomerAddress.type2.filled = false;
                CustomerAddress.type2.zip = null;
                CustomerAddress.type2.domain = null;
                CustomerAddress.type2.region = null;
                CustomerAddress.type2.locality = null;
                CustomerAddress.type2.address = null;
                CustomerAddress.type2.territory_id = null;
            }

            if ($('#FGTWN3').val() && $('#FGADR3').val()) {
                CustomerAddress.type3.filled = true;
                CustomerAddress.type3.zip = $('#FGIDX3').val();
                CustomerAddress.type3.domain = $('#FGOBL3').val();
                CustomerAddress.type3.region = $('#FGDST3').val();
                CustomerAddress.type3.locality = $('#FGTWN3').val();
                CustomerAddress.type3.address = $('#FGADR3').val();
                CustomerAddress.type3.territory_id = $('#TeritoryCode3').val();
            }
            else {
                CustomerAddress.type3.filled = false;
                CustomerAddress.type3.zip = null;
                CustomerAddress.type3.domain = null;
                CustomerAddress.type3.region = null;
                CustomerAddress.type3.locality = null;
                CustomerAddress.type3.address = null;
                CustomerAddress.type3.territory_id = null;
            }

            window.returnValue = CustomerAddress;
            window.close();
        }

        function Close() {
            window.returnValue = null;
            window.close();
        }

        function ShowAdrManual(type_id) {
            var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=TERRITORY&tail=""&role=WR_CUSTREG', 'dialogHeight:600px; dialogWidth:600px');
            if (result != null && result[0] != null) {
                $('#TeritoryCode' + type_id).val(result[0]);
                if (result[1] != null) $('#FGTWN' + type_id).val(result[1]);
                if (result[3] != null) $('#FGOBL' + type_id).val(result[3]);
                if (result[4] != null) $('#FGDST' + type_id).val(result[4]);
            }
        }
    </script>
    <style type="text/css">
        .address
        {
            text-align: left;
        }
        .address td.label
        {
            text-align: right;
            white-space: nowrap;
        }
        
        .edit
        {
            width: 300px;
        }
        .ref
        {
            width: 20px;
        }
        
        .composite
        {
        }
        .composite.part1
        {
            width: 250px;
        }
        .composite.part2
        {
            width: 47px;
        }
        
        .main_layout
        {
            width: 600px;
            height: 400px;
        }
        .accordion_layout
        {
            height: 275px;
            padding: 30px;
        }
        .buttons_layout
        {
            text-align: center;
        }
        
        div.required
        {
            display: inline;
            font-size: 12pt;
            width: 8px;
            color: red;
            height: 18px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="main_layout">
        <div class="accordion_layout">
            <div id="accordion">
                <h3>
                    Юридична</h3>
                <div>
                    <table class="address" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="label">
                                Індекс:
                            </td>
                            <td>
                                <input type="text" id="FGIDX1" class="edit composite part1" maxlength="20" tabindex="101" />
                                <input type="button" id="ref1" class="ref composite part2" value="..." onclick="ShowAdrManual(1); " />
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                Область:
                            </td>
                            <td>
                                <input type="text" id="FGOBL1" class="edit" maxlength="30" tabindex="102" />
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                Район:
                            </td>
                            <td>
                                <input type="text" id="FGDST1" class="edit" maxlength="30" tabindex="103" />
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                Населений пункт:
                            </td>
                            <td>
                                <input type="text" id="FGTWN1" class="edit" maxlength="60" tabindex="104" />
                                <div class="required">
                                    *</div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                Вулиця, будинок, кв.:
                            </td>
                            <td>
                                <input type="text" id="FGADR1" class="edit" maxlength="100" tabindex="105" />
                                <div class="required">
                                    *</div>
                            </td>
                        </tr>
                    </table>
                    <input type="hidden" id="TeritoryCode1" />
                </div>
                <h3>
                    Фактична</h3>
                <div>
                    <table class="address" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="label">
                                Індекс:
                            </td>
                            <td>
                                <input type="text" id="FGIDX2" class="edit composite part1" maxlength="20" tabindex="201" />
                                <input type="button" id="ref2" class="ref composite part2" value="..." onclick="ShowAdrManual(2); " />
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                Область:
                            </td>
                            <td>
                                <input type="text" id="FGOBL2" class="edit" maxlength="30" tabindex="202" />
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                Район:
                            </td>
                            <td>
                                <input type="text" id="FGDST2" class="edit" maxlength="30" tabindex="203" />
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                Населений пункт:
                            </td>
                            <td>
                                <input type="text" id="FGTWN2" class="edit" maxlength="60" tabindex="204" />
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                Вулиця, будинок, кв.:
                            </td>
                            <td>
                                <input type="text" id="FGADR2" class="edit" maxlength="100" tabindex="205" />
                            </td>
                        </tr>
                    </table>
                    <input type="hidden" id="TeritoryCode2" />
                </div>
                <h3>
                    Почтова</h3>
                <div>
                    <table class="address" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="label">
                                Індекс:
                            </td>
                            <td>
                                <input type="text" id="FGIDX3" class="edit composite part1" maxlength="20" tabindex="301" />
                                <input type="button" id="ref3" class="ref composite part2" value="..." onclick="ShowAdrManual(3); " />
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                Область:
                            </td>
                            <td>
                                <input type="text" id="FGOBL3" class="edit" maxlength="30" tabindex="302" />
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                Район:
                            </td>
                            <td>
                                <input type="text" id="FGDST3" class="edit" maxlength="30" tabindex="303" />
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                Населений пункт:
                            </td>
                            <td>
                                <input type="text" id="FGTWN3" class="edit" maxlength="60" tabindex="304" />
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                Вулиця, будинок, кв.:
                            </td>
                            <td>
                                <input type="text" id="FGADR3" class="edit" maxlength="100" tabindex="305" />
                            </td>
                        </tr>
                    </table>
                    <input type="hidden" id="TeritoryCode3" />
                </div>
            </div>
        </div>
        <div class="buttons_layout">
            <input type="button" value="Зберегти" onclick="ReturnVal(); " />
            <input type="button" value="Відміна" onclick="Close(); " />
        </div>
    </div>
    </form>
</body>
</html>
