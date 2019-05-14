<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cck_zay.aspx.cs" Inherits="credit_cck_zay"
    Theme="default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register Src="usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<%@ Register Src="usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="usercontrols/loading.ascx" TagName="loading" TagPrefix="bec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Розміщення заявки на кредит</title>
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="jscript/JScript.js"></script>

    <script language="javascript" type="text/javascript">
        // параметры диалогового окна
        var dialogFeatures = 'dialogHeight: 800px; dialogWidth: 800px; center: yes; resizable: yes; status: no';

        function ShowCustomerRefer(CustType, rnkCtrlID, okpoCtrlID, fioCtrlID) {
            var rnd = Math.random();

            var tail = '';
            if (CustType == 3) tail = 'date_off is null and CustType=' + CustType + ' and sed != 91';
            else if (CustType == 0) tail = 'date_off is null and CustType != ' + CustType;
            else tail = 'date_off is null and CustType=' + CustType;

            var result = window.showModalDialog('dialog.aspx?type=metatab&tail=\'' + tail + '\'&role=WR_CREDIT&tabname=CUSTOMER&field=(RNK)&rnd=' + rnd, window, dialogFeatures);

            if (result == null) return false;
            else {
                var rnkCtrl = document.getElementById(rnkCtrlID);
                var okpoCtrl = document.getElementById(okpoCtrlID);
                var fioCtrl = document.getElementById(fioCtrlID);

                rnkCtrl.value = result[0];
                okpoCtrl.value = result[2];
                fioCtrl.value = result[1];

                //перевірка на інсайдера
                texboxchange("RNK");


                return true;
            }
        }


        function texboxchange(sender) {
            __doPostBack("RNK", "OnValueChanged");
        }


        function ShowBanksRefer(nbankCtrlID, nbankNameCtrlID) {
            var rnd = Math.random();

            var result = window.showModalDialog('dialog.aspx?type=metatab&tail=\'\'&role=WR_CREDIT&tabname=BANKS&field=MFO&rnd=' + rnd, window, dialogFeatures);

            if (result == null) return false;
            else {
                var nbankCtrl = document.getElementById(nbankCtrlID);
                var nbankNameCtrl = document.getElementById(nbankNameCtrlID);

                nbankCtrl.value = result[0];
                nbankNameCtrl.value = result[1];

                return true;
            }
        }
        function ShowDepositRefer(dptCtrlID, rnkCtrlID, okpoCtrlID, fioCtrlID, sumCtrlID) {
            var rnd = Math.random();

            var tail = '';
            var okpoCtrl1 = document.getElementById(okpoCtrlID);
            var dptCtrl1 = document.getElementById(dptCtrlID);
            var l_null = '';

            if (dptCtrl1.value == l_null & okpoCtrl1.value != l_null) tail = 'cust_idcode=to_char(' + okpoCtrl1.value + ')';
            else if (dptCtrl1.value == l_null & okpoCtrl1.value == l_null) tail = '';
            else tail = 'dpt_id=' + dptCtrl1.value;

            var result = window.showModalDialog('dialog.aspx?type=metatab&tail=\'' + tail + '\'&role=WR_CREDIT&tabname=V_DPT_PORTFOLIO_ACTIVE&rnd=' + rnd, window, dialogFeatures);

            if (result == null) return false;
            else {
                var dptCtrl = document.getElementById(dptCtrlID);
                var rnkCtrl = document.getElementById(rnkCtrlID);
                var okpoCtrl = document.getElementById(okpoCtrlID);
                var fioCtrl = document.getElementById(fioCtrlID);
                var sumCtrl = document.getElementById(sumCtrlID);

                dptCtrl.value = result[0];
                rnkCtrl.value = result[2];
                okpoCtrl.value = result[3];
                fioCtrl.value = result[1];
                sumCtrl.value = result[4] / 100;

                return true;
            }
        }

        function fnClickOK(sender, e) {

            $find("mpe").hide();
            __doPostBack(sender, e);
        }

    </script>

    <style type="text/css">
        /*желтый блок*/ .ErrorBlock {
            padding: 10px;
            text-align: center;
            width: 99%;
        }
            /*заголовок желтого блока*/ .ErrorBlock .ContentBody {
                background: url(/barsroot/credit/manager/master_src/err_body_t.gif) repeat-x !important;
                border-right: 1px solid #FFD092 !important;
                border-left: 1px solid #FFD092 !important;
                padding: 10px 0px 5px 0px;
                color: Red;
                font-weight: bold;
            }
            /*нижняя граница желтого блока*/ .ErrorBlock .BottomBody {
                background: url(/barsroot/credit/manager/master_src/err_body_b.gif) repeat-x !important;
                height: 8px !important;
                border-right: 1px solid #FFD092 !important;
                border-left: 1px solid #FFD092 !important;
            }

        .group_title {
            text-align: center;
            font-weight: bold;
            font-style: italic;
        }

        .parameter_title {
            text-align: right;
            padding-right: 5px;
        }

        .parameter_value {
            text-align: left;
        }

        .button_send_container {
            text-align: right;
            padding-top: 5px;
        }

        .checkbox_activate {
            border-bottom: solid 1px gray;
        }

        .checkbox_activate_container {
            padding-bottom: 10px;
        }


        /*Modal confirmation*/
        .modalBackground     {
                    background-color: Black;
                    filter: alpha(opacity=60);
                    opacity: 0.6;
               
        }

            .modalPopup     {
                    background-color: #FFFFFF;
                    border-width: 3px;
                    border-style: solid;
                    border-color: black;
                    padding-top: 10px;
                    padding-left: 10px;
                    width: 400px;
                    height: 140px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm" runat="server" EnablePartialRendering="true" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
        <div class="pageTitle">
            <asp:LinkButton ID="toplink" runat="server"></asp:LinkButton>
            <asp:Label ID="lbPageTitle" runat="server" Text="Розміщення заявки на кредит"></asp:Label>
        </div>
        <div style="text-align: left; padding: 10px 0px 10px 10px">
            <table border="0" cellpadding="3" cellspacing="0" style="text-align: left">
                <tr>
                    <td>
                        <asp:LinkButton ID="lnkHide" runat="server"></asp:LinkButton>
                        <cc1:ModalPopupExtender ID="mpe"
                            runat="server"
                            PopupControlID="pnlPopup"
                            TargetControlID="lnkHide"
                            CancelControlID="btnYes"
                            BackgroundCssClass="modalBackground">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="pnlPopup"
                            runat="server"
                            align="center"
                            CssClass="modalPopup"
                            Style="display: none">
                            <div style="text-align: center">
                                УВАГА! 
                            </div>
                            <div style="text-align: center">
                                По клієнту потрібно заповнити анкету пов’язаної з банком особи (інсайдера). Анкета заповнена?
                            </div>
                            <div style="text-align: center; margin: 5px 5px 5px 5px">
                                <asp:Button ID="btnNo" runat="server" Text="Ні" Width="60px" OnClick="btnNo_Click" />
                                <asp:Button ID="btnYes" runat="server" Text="Так" Width="60px" />
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="attrClient" runat="server" GroupingText="Клієнт">
                            <asp:UpdatePanel ID="upClient" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="RNKTitle" runat="server" Text="Код Контрагенту : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="RNK" runat="server" MaxLength="20" IsRequired="true" onchange="texboxchange(this)" OnValueChanged="RNK_ValueChanged" />
                                                <asp:Button ID="btCustomerReferRNK" runat="server" Text="..." ToolTip="Вибір контрагента із довідника" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="OKPOTitle" runat="server" Text="ЗКПО : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="OKPO" runat="server" Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="FIOTitle" runat="server" Text="ПІБ : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="FIO" runat="server" Enabled="false" Width="400" />
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="attrMain" runat="server" GroupingText="Основні реквізити">
                            <asp:UpdatePanel ID="InfoPanel" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                            <table border="0" cellpadding="3" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:Label ID="CC_IDTitle" runat="server" Text="№ Договору : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:TextBoxString ID="CC_ID" runat="server" MaxLength="20" IsRequired="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="KVTitle" runat="server" Text="Валюта : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:DDLList ID="KV" runat="server" IsRequired="true">
                                        </bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="SDOGTitle" runat="server" Text="Сума по договору : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="SDOG" runat="server" IsRequired="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="FPROCTitle" runat="server" Text="% ставка : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="FPROC" runat="server" MaxValue="300" IsRequired="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblINT_R" runat="server" Text="% ставка (Ринкова) : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="INTRT" runat="server" MaxValue="100" IsRequired="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="cbFPROC2" runat="server" Checked="false" Text="Застосувати ставку №2"
                                            OnCheckedChanged="cbFPROC2_CheckedChanged" AutoPostBack="true"/>
                                    </td>
                                    <td>

                                    </td>
                                </tr>
                                <tr>
                                    <td>   </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="FPROC2Title" runat="server" Text="% ставка №2 : "></asp:Label>
                                                </td>
                                                <td>
                                                    <bec:TextBoxDecimal ID="FPROC2" runat="server" MaxValue="100" Enabled="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="FPROC2_DATETitle" runat="server" Text="Дата вступу в дію % ставки №2 : "></asp:Label> 
                                                </td>
                                                <td>
                                                    <bec:TextBoxDate ID="FPROC2_DATE" runat="server" Enabled="false"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="cbFPROC3" runat="server" Checked="false" Text="Застосувати ставку №3"
                                            AutoPostBack="true"  OnCheckedChanged="cbFPROC3_CheckedChanged"  Visible="false" />
                                    </td>
                                    <td>

                                    </td>
                                </tr>
                                <tr>
                                    <td>   </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="FPROC3Title" runat="server" Text="% ставка №3 : " Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <bec:TextBoxDecimal ID="FPROC3" runat="server" MaxValue="100" Enabled="false" Visible="False" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="FPROC3_DATETitle" runat="server" Text="Дата вступу в дію % ставки №3 : " Visible="False"></asp:Label> 
                                                </td>
                                                <td>
                                                    <bec:TextBoxDate ID="FPROC3_DATE" runat="server" Enabled="false" Visible="False"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="BASEYTitle" runat="server" Text="Базовий рік : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:DDLList ID="BASEY" runat="server" IsRequired="true">
                                        </bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="SDATETitle" runat="server" Text="Дата початку дії : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:TextBoxDate ID="SDATE" runat="server" IsRequired="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="WDATETitle" runat="server" Text="Дата закінчення : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:TextBoxDate ID="WDATE" runat="server" IsRequired="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="GPKTitle" runat="server" Text="Графік погашення (1,2,3) : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:DDLList ID="GPK" runat="server" IsRequired="true">
                                        </bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="NFINTitle" runat="server" Text="Фін. стан : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:DDLList ID="NFIN" runat="server" IsRequired="true">
                                        </bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="NFREQTitle" runat="server" Text="Період погашення тіла КД : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:DDLList ID="NFREQ" runat="server" IsRequired="true">
                                        </bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="DFDENTitle" runat="server" Text="День погашення : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:TextBoxNumb ID="DFDEN" runat="server" IsRequired="true" MinValue="1" MaxValue="31" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" Text="BUS_MOD : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:DDLList ID="DDL_BUS_MOD" runat="server" IsRequired="true"  OnValueChanged="Bus_Mod_Changed" ></bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label3" runat="server" Text="SPPI : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:DDLList ID="DDL_SPPI" runat="server" IsRequired="true" OnValueChanged="SPPI_Changed" ></bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label4" runat="server" Text="IFRS : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:TextBoxString ID="IFRS" runat="server" MaxLength="20" IsRequired="true" Enabled="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label5" runat="server" Text="POCI : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:DDLList ID="DDL_POCI" runat="server" IsRequired="false" Enabled="false" OnValueChanged="Poci_Changed"></bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label6" runat="server" Text="Ціль : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:DDLList ID="DDL_AIM" runat="server" IsRequired="true" OnValueChanged="AIM_Changed"></bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="PRODTitle" runat="server" Text="Продукт (ОВ22) : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:DDLList ID="DDL_PROD" runat="server" IsRequired="true"></bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="creditOrderTitle" runat="server" Text="№ кредитної заявки в системі «Кредитна Фабрика» : "></asp:Label>
                                    </td>
                                    <td>
                                        <bec:TextBoxString ID="creditOrder" runat="server" IsRequired="true" MaxLength="32" />
                                    </td>
                                </tr>
                            </table>
                                      </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlMonthlyCommission" runat="server" GroupingText="Щомісячні комісії">
                            <asp:UpdatePanel ID="upMonthlyCommission" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="METRTitle" runat="server" Text="Метод нарахування щомісячної комісії : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:DDLList ID="METR" runat="server" OnValueChanged="METR_ValueChanged">
                                                </bec:DDLList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="METR_RTitle" runat="server" Text="% ставка комісії : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDecimal ID="METR_R" runat="server" IsRequired="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="METR_9Title" runat="server" Text="% ставка комісії за невикористаний ліміт : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDecimal ID="METR_9" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="attrSDI" runat="server" GroupingText="Одноразова комісія">
                            <asp:UpdatePanel ID="upSDI" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="sumSDITitle" runat="server" Text="Сума : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDecimal ID="sumSDI" runat="server" OnValueChanged="sumSDI_ValueChanged" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="prSDITitle" runat="server" Text="Процентна ставка : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDecimal ID="prSDI" runat="server" OnValueChanged="prSDI_ValueChanged" />
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel  ID="Panel_SumComObsl" runat="server" GroupingText="Комісія за обслуговування кредиту (сплачується перед видачею кредиту)" CssClass="cck_zay_panel">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label1" runat="server" Text="Сума : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDecimal ID="SumComObsl" runat="server"  />
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="upPayInstuctions" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel ID="attrPayInstuctions" runat="server" GroupingText="Платіжні інструкції">
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td colspan="2" class="checkbox_activate_container">
                                                <asp:CheckBox ID="cbINS" runat="server" Checked="false" Text="Наявність партнеру"
                                                    CssClass="checkbox_activate" OnCheckedChanged="cbINS_CheckedChanged" AutoPostBack="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NBANKTitle" runat="server" Text="МФО : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="NBANK" runat="server" MaxValue="999999" OnValueChanged="NBANK_ValueChanged" />
                                                <asp:Button ID="btBanksReferNBANK" runat="server" Text="..." ToolTip="Вибір МФО із довідника" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NBANK_NAMETitle" runat="server" Text="Назва банку : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="NBANK_NAME" runat="server" Enabled="false" Width="400" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NLS_MFOTitle" runat="server" Text="Рахунок : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="NLS_MFO" runat="server" IsRequired="true" MaxLength="34" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NLS_NAMETitle" runat="server" Text="Найменування рахунку : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="NLS_NAME" runat="server" IsRequired="true" MaxLength="34" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NLS_OKPOTitle" runat="server" Text="Код ОКПО : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="NLS_OKPO" runat="server" IsRequired="true" MaxLength="10" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="upPayInstuctions2" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel ID="attrPayInstuctions2" runat="server" GroupingText="Платіжні інструкції 2">
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td colspan="2" class="checkbox_activate_container">
                                                <asp:CheckBox ID="cbINS2" runat="server" Checked="false" Text="Наявність партнеру 2"
                                                    CssClass="checkbox_activate" OnCheckedChanged="cbINS2_CheckedChanged" AutoPostBack="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NBANKTitle2" runat="server" Text="МФО : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="NBANK2" runat="server" MaxValue="999999" OnValueChanged="NBANK_ValueChanged" />
                                                <asp:Button ID="btBanksReferNBANK2" runat="server" Text="..." ToolTip="Вибір МФО із довідника" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NBANK_NAMETitle2" runat="server" Text="Назва банку : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="NBANK_NAME2" runat="server" Enabled="false" Width="400" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NLS_MFOTitle2" runat="server" Text="Рахунок : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="NLS_MFO2" runat="server" IsRequired="true" MaxLength="34" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NLS_NAMETitle2" runat="server" Text="Найменування рахунку : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="NLS_NAME2" runat="server" IsRequired="true" MaxLength="34" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NLS_OKPOTitle2" runat="server" Text="Код ОКПО : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="NLS_OKPO2" runat="server" IsRequired="true" MaxLength="10" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="upPayInstuctions3" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel ID="attrPayInstuctions3" runat="server" GroupingText="Платіжні інструкції 3">
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td colspan="2" class="checkbox_activate_container">
                                                <asp:CheckBox ID="cbINS3" runat="server" Checked="false" Text="Наявність партнеру 3"
                                                    CssClass="checkbox_activate" OnCheckedChanged="cbINS3_CheckedChanged" AutoPostBack="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NBANKTitle3" runat="server" Text="МФО : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="NBANK3" runat="server" MaxValue="999999" OnValueChanged="NBANK_ValueChanged" />
                                                <asp:Button ID="btBanksReferNBANK3" runat="server" Text="..." ToolTip="Вибір МФО із довідника" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NBANK_NAMETitle3" runat="server" Text="Назва банку : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="NBANK_NAME3" runat="server" Enabled="false" Width="400" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NLS_MFOTitle3" runat="server" Text="Рахунок : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="NLS_MFO3" runat="server" IsRequired="true" MaxLength="34" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NLS_NAMETitle3" runat="server" Text="Найменування рахунку : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="NLS_NAME3" runat="server" IsRequired="true" MaxLength="34" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NLS_OKPOTitle3" runat="server" Text="Код ОКПО : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="NLS_OKPO3" runat="server" IsRequired="true" MaxLength="10" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="upPayInstuctions4" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel ID="attrPayInstuctions4" runat="server" GroupingText="Платіжні інструкції 4">
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td colspan="2" class="checkbox_activate_container">
                                                <asp:CheckBox ID="cbINS4" runat="server" Checked="false" Text="Наявність партнеру 4"
                                                    CssClass="checkbox_activate" OnCheckedChanged="cbINS4_CheckedChanged" AutoPostBack="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NBANKTitle4" runat="server" Text="МФО : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="NBANK4" runat="server" MaxValue="999999" OnValueChanged="NBANK_ValueChanged" />
                                                <asp:Button ID="btBanksReferNBANK4" runat="server" Text="..." ToolTip="Вибір МФО із довідника" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NBANK_NAMETitle4" runat="server" Text="Назва банку : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="NBANK_NAME4" runat="server" Enabled="false" Width="400" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NLS_MFOTitle4" runat="server" Text="Рахунок : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="NLS_MFO4" runat="server" IsRequired="true" MaxLength="34" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NLS_NAMETitle4" runat="server" Text="Найменування рахунку : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="NLS_NAME4" runat="server" IsRequired="true" MaxLength="34" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NLS_OKPOTitle4" runat="server" Text="Код ОКПО : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="NLS_OKPO4" runat="server" IsRequired="true" MaxLength="10" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="upPayInstuctions5" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel ID="attrPayInstuctions5" runat="server" GroupingText="Платіжні інструкції 5">
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td colspan="2" class="checkbox_activate_container">
                                                <asp:CheckBox ID="cbINS5" runat="server" Checked="false" Text="Наявність партнеру 5"
                                                    CssClass="checkbox_activate" OnCheckedChanged="cbINS5_CheckedChanged" AutoPostBack="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NBANKTitle5" runat="server" Text="МФО : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="NBANK5" runat="server" MaxValue="999999" OnValueChanged="NBANK_ValueChanged" />
                                                <asp:Button ID="btBanksReferNBANK5" runat="server" Text="..." ToolTip="Вибір МФО із довідника" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NBANK_NAMETitle5" runat="server" Text="Назва банку : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="NBANK_NAME5" runat="server" Enabled="false" Width="400" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NLS_MFOTitle5" runat="server" Text="Рахунок : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="NLS_MFO5" runat="server" IsRequired="true" MaxLength="34" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NLS_NAMETitle5" runat="server" Text="Найменування рахунку : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="NLS_NAME5" runat="server" IsRequired="true" MaxLength="34" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="NLS_OKPOTitle5" runat="server" Text="Код ОКПО : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="NLS_OKPO5" runat="server" IsRequired="true" MaxLength="10" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="upAttrPawn" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel ID="attrPawn" runat="server" GroupingText="Застава">
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td colspan="2" class="checkbox_activate_container">
                                                <asp:CheckBox ID="cbPAWN" runat="server" Checked="false" Text="Наявність застави"
                                                    CssClass="checkbox_activate" OnCheckedChanged="cbPAWN_CheckedChanged" AutoPostBack="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbDPT_ID" runat="server" Text="Депозит : " Visible="false"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="DPT_ID" runat="server" MaxLength="20" IsRequired="true" Enabled="false"
                                                    Visible="false" />
                                                <asp:Button ID="btDepositReferDPT_ID" Enabled="false" runat="server" Text="..."
                                                    ToolTip="Вибір контрагента із довідника" Visible="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN_RNKTitle" runat="server" Text="Код Контрагенту : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="PAWN_RNK" runat="server" MaxLength="20" IsRequired="true" Enabled="false"
                                                    OnValueChanged="RNK_ValueChanged" />
                                                <asp:Button ID="btCustomerReferPAWN_RNK" Enabled="false" runat="server" Text="..."
                                                    ToolTip="Вибір контрагента із довідника" />
                                                <bec:TextBoxNumb ID="PAWN_DPTRNK" runat="server" MaxLength="20" Enabled="false" Visible="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN_OKPOTitle" runat="server" Text="ЗКПО : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWN_OKPO" runat="server" Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN_FIOTitle" runat="server" Text="ПІБ : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWN_FIO" runat="server" Enabled="false" Width="400" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNTitle" runat="server" Text="Тип : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:DDLList ID="PAWN" runat="server" IsRequired="true" Enabled="false">
                                                </bec:DDLList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN_STitle" runat="server" Text="Сума : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDecimal ID="PAWN_S" runat="server" IsRequired="true" Enabled="false" />
                                                <bec:TextBoxDecimal ID="PAWN_DPTS" runat="server" Enabled="false" Visible="false" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="upAttrPawn2" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel ID="attrPawn2" runat="server" GroupingText="Застава 2">
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td colspan="2" class="checkbox_activate_container">
                                                <asp:CheckBox ID="cbPAWN2" runat="server" Checked="false" Text="Наявність застави 2"
                                                    CssClass="checkbox_activate" OnCheckedChanged="cbPAWN2_CheckedChanged" AutoPostBack="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN2_RNKTitle" runat="server" Text="Код Контрагенту : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="PAWN2_RNK" runat="server" MaxLength="20" IsRequired="true" Enabled="false"
                                                    OnValueChanged="RNK_ValueChanged" />
                                                <asp:Button ID="btCustomerReferPAWN2_RNK" Enabled="false" runat="server" Text="..."
                                                    ToolTip="Вибір контрагента із довідника" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN2_OKPOTitle" runat="server" Text="ЗКПО : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWN2_OKPO" runat="server" Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN2_FIOTitle" runat="server" Text="ПІБ : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWN2_FIO" runat="server" Enabled="false" Width="400" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN2Title" runat="server" Text="Тип : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:DDLList ID="PAWN2" runat="server" IsRequired="true" Enabled="false">
                                                </bec:DDLList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN2_STitle" runat="server" Text="Сума : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDecimal ID="PAWN2_S" runat="server" IsRequired="true" Enabled="false" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="upAttrPawn3" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel ID="attrPawn3" runat="server" GroupingText="Застава 3">
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td colspan="2" class="checkbox_activate_container">
                                                <asp:CheckBox ID="cbPAWN3" runat="server" Checked="false" Text="Наявність застави 3"
                                                    CssClass="checkbox_activate" OnCheckedChanged="cbPAWN3_CheckedChanged" AutoPostBack="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN3_RNKTitle" runat="server" Text="Код Контрагенту : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="PAWN3_RNK" runat="server" MaxLength="20" IsRequired="true" Enabled="false"
                                                    OnValueChanged="RNK_ValueChanged" />
                                                <asp:Button ID="btCustomerReferPAWN3_RNK" Enabled="false" runat="server" Text="..."
                                                    ToolTip="Вибір контрагента із довідника" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN3_OKPOTitle" runat="server" Text="ЗКПО : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWN3_OKPO" runat="server" Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN3_FIOTitle" runat="server" Text="ПІБ : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWN3_FIO" runat="server" Enabled="false" Width="400" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN3Title" runat="server" Text="Тип : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:DDLList ID="PAWN3" runat="server" IsRequired="true" Enabled="false">
                                                </bec:DDLList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN3_STitle" runat="server" Text="Сума : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDecimal ID="PAWN3_S" runat="server" IsRequired="true" Enabled="false" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="upAttrPawn4" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel ID="attrPawn4" runat="server" GroupingText="Застава 4">
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td colspan="2" class="checkbox_activate_container">
                                                <asp:CheckBox ID="cbPAWN4" runat="server" Checked="false" Text="Наявність застави 4"
                                                    CssClass="checkbox_activate" OnCheckedChanged="cbPAWN4_CheckedChanged" AutoPostBack="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN4_RNKTitle" runat="server" Text="Код Контрагенту : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="PAWN4_RNK" runat="server" MaxLength="20" IsRequired="true" Enabled="false"
                                                    OnValueChanged="RNK_ValueChanged" />
                                                <asp:Button ID="btCustomerReferPAWN4_RNK" Enabled="false" runat="server" Text="..."
                                                    ToolTip="Вибір контрагента із довідника" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN4_OKPOTitle" runat="server" Text="ЗКПО : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWN4_OKPO" runat="server" Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN4_FIOTitle" runat="server" Text="ПІБ : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWN4_FIO" runat="server" Enabled="false" Width="400" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN4Title" runat="server" Text="Тип : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:DDLList ID="PAWN4" runat="server" IsRequired="true" Enabled="false">
                                                </bec:DDLList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN4_STitle" runat="server" Text="Сума : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDecimal ID="PAWN4_S" runat="server" IsRequired="true" Enabled="false" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="upAttrPawn5" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel ID="attrPawn5" runat="server" GroupingText="Застава 5">
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td colspan="2" class="checkbox_activate_container">
                                                <asp:CheckBox ID="cbPAWN5" runat="server" Checked="false" Text="Наявність застави 5"
                                                    CssClass="checkbox_activate" OnCheckedChanged="cbPAWN5_CheckedChanged" AutoPostBack="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN5_RNKTitle" runat="server" Text="Код Контрагенту : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="PAWN5_RNK" runat="server" MaxLength="20" IsRequired="true" Enabled="false"
                                                    OnValueChanged="RNK_ValueChanged" />
                                                <asp:Button ID="btCustomerReferPAWN5_RNK" Enabled="false" runat="server" Text="..."
                                                    ToolTip="Вибір контрагента із довідника" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN5_OKPOTitle" runat="server" Text="ЗКПО : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWN5_OKPO" runat="server" Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN5_FIOTitle" runat="server" Text="ПІБ : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWN5_FIO" runat="server" Enabled="false" Width="400" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN5Title" runat="server" Text="Тип : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:DDLList ID="PAWN5" runat="server" IsRequired="true" Enabled="false">
                                                </bec:DDLList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWN5_STitle" runat="server" Text="Сума : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDecimal ID="PAWN5_S" runat="server" IsRequired="true" Enabled="false" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="upAttrPawnP" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel ID="attrPawnP" runat="server" GroupingText="Порука">
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td colspan="2" class="checkbox_activate_container">
                                                <asp:CheckBox ID="cbPAWNP" runat="server" Checked="false" Text="Наявність поруки"
                                                    CssClass="checkbox_activate" OnCheckedChanged="cbPAWNP_CheckedChanged" AutoPostBack="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP_RNKTitle" runat="server" Text="Код Контрагенту : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="PAWNP_RNK" runat="server" MaxLength="20" IsRequired="true" Enabled="false"
                                                    OnValueChanged="RNK_ValueChanged" />
                                                <asp:Button ID="btCustomerReferPAWNP_RNK" Enabled="false" runat="server" Text="..."
                                                    ToolTip="Вибір контрагента із довідника" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP_OKPOTitle" runat="server" Text="ЗКПО : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWNP_OKPO" runat="server" Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP_FIOTitle" runat="server" Text="ПІБ : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWNP_FIO" runat="server" Enabled="false" Width="400" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNPTitle" runat="server" Text="Тип : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:DDLList ID="PAWNP" runat="server" IsRequired="true" Enabled="false">
                                                </bec:DDLList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP_STitle" runat="server" Text="Сума : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDecimal ID="PAWNP_S" runat="server" IsRequired="true" Enabled="false" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="upAttrPawnP2" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel ID="attrPawnP2" runat="server" GroupingText="Порука 2">
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td colspan="2" class="checkbox_activate_container">
                                                <asp:CheckBox ID="cbPAWNP2" runat="server" Checked="false" Text="Наявність поруки 2"
                                                    CssClass="checkbox_activate" OnCheckedChanged="cbPAWNP2_CheckedChanged" AutoPostBack="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP2_RNKTitle" runat="server" Text="Код Контрагенту : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="PAWNP2_RNK" runat="server" MaxLength="20" IsRequired="true"
                                                    Enabled="false" OnValueChanged="RNK_ValueChanged" />
                                                <asp:Button ID="btCustomerReferPAWNP2_RNK" Enabled="false" runat="server" Text="..."
                                                    ToolTip="Вибір контрагента із довідника" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP2_OKPOTitle" runat="server" Text="ЗКПО : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWNP2_OKPO" runat="server" Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP2_FIOTitle" runat="server" Text="ПІБ : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWNP2_FIO" runat="server" Enabled="false" Width="400" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP2Title" runat="server" Text="Тип : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:DDLList ID="PAWNP2" runat="server" IsRequired="true" Enabled="false">
                                                </bec:DDLList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP2_STitle" runat="server" Text="Сума : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDecimal ID="PAWNP2_S" runat="server" IsRequired="true" Enabled="false" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="upAttrPawnP3" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel ID="attrPawnP3" runat="server" GroupingText="Порука 3">
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td colspan="2" class="checkbox_activate_container">
                                                <asp:CheckBox ID="cbPAWNP3" runat="server" Checked="false" Text="Наявність поруки 3"
                                                    CssClass="checkbox_activate" OnCheckedChanged="cbPAWNP3_CheckedChanged" AutoPostBack="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP3_RNKTitle" runat="server" Text="Код Контрагенту : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="PAWNP3_RNK" runat="server" MaxLength="20" IsRequired="true"
                                                    Enabled="false" OnValueChanged="RNK_ValueChanged" />
                                                <asp:Button ID="btCustomerReferPAWNP3_RNK" Enabled="false" runat="server" Text="..."
                                                    ToolTip="Вибір контрагента із довідника" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP3_OKPOTitle" runat="server" Text="ЗКПО : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWNP3_OKPO" runat="server" Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP3_FIOTitle" runat="server" Text="ПІБ : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWNP3_FIO" runat="server" Enabled="false" Width="400" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP3Title" runat="server" Text="Тип : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:DDLList ID="PAWNP3" runat="server" IsRequired="true" Enabled="false">
                                                </bec:DDLList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP3_STitle" runat="server" Text="Сума : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDecimal ID="PAWNP3_S" runat="server" IsRequired="true" Enabled="false" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="upAttrPawnP4" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel ID="attrPawnP4" runat="server" GroupingText="Порука 4">
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td colspan="2" class="checkbox_activate_container">
                                                <asp:CheckBox ID="cbPAWNP4" runat="server" Checked="false" Text="Наявність поруки 4"
                                                    CssClass="checkbox_activate" OnCheckedChanged="cbPAWNP4_CheckedChanged" AutoPostBack="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP4_RNKTitle" runat="server" Text="Код Контрагенту : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="PAWNP4_RNK" runat="server" MaxLength="20" IsRequired="true"
                                                    Enabled="false" OnValueChanged="RNK_ValueChanged" />
                                                <asp:Button ID="btCustomerReferPAWNP4_RNK" Enabled="false" runat="server" Text="..."
                                                    ToolTip="Вибір контрагента із довідника" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP4_OKPOTitle" runat="server" Text="ЗКПО : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWNP4_OKPO" runat="server" Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP4_FIOTitle" runat="server" Text="ПІБ : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWNP4_FIO" runat="server" Enabled="false" Width="400" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP4Title" runat="server" Text="Тип : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:DDLList ID="PAWNP4" runat="server" IsRequired="true" Enabled="false">
                                                </bec:DDLList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP4_STitle" runat="server" Text="Сума : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDecimal ID="PAWNP4_S" runat="server" IsRequired="true" Enabled="false" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="upAttrPawnP5" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel ID="attrPawnP5" runat="server" GroupingText="Порука 5">
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td colspan="2" class="checkbox_activate_container">
                                                <asp:CheckBox ID="cbPAWNP5" runat="server" Checked="false" Text="Наявність поруки 5"
                                                    CssClass="checkbox_activate" OnCheckedChanged="cbPAWNP5_CheckedChanged" AutoPostBack="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP5_RNKTitle" runat="server" Text="Код Контрагенту : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="PAWNP5_RNK" runat="server" MaxLength="20" IsRequired="true"
                                                    Enabled="false" OnValueChanged="RNK_ValueChanged" />
                                                <asp:Button ID="btCustomerReferPAWNP5_RNK" Enabled="false" runat="server" Text="..."
                                                    ToolTip="Вибір контрагента із довідника" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP5_OKPOTitle" runat="server" Text="ЗКПО : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWNP5_OKPO" runat="server" Enabled="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP5_FIOTitle" runat="server" Text="ПІБ : "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="PAWNP5_FIO" runat="server" Enabled="false" Width="400" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP5Title" runat="server" Text="Тип : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:DDLList ID="PAWNP5" runat="server" IsRequired="true" Enabled="false">
                                                </bec:DDLList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PAWNP5_STitle" runat="server" Text="Сума : "></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDecimal ID="PAWNP5_S" runat="server" IsRequired="true" Enabled="false" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td class="button_send_container">
                        <asp:UpdatePanel ID="upSend" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Button ID="btSend" runat="server" Text="Передати" OnClientClick="if (!confirm('Передати заявку?')) return false;"
                                    OnClick="btSend_Click" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
        </div>

        <asp:UpdateProgress ID="uppSend" runat="server" AssociatedUpdatePanelID="upSend">
            <ProgressTemplate>
                <bec:loading ID="ldngSend" runat="server" />
            </ProgressTemplate>
        </asp:UpdateProgress>
    </form>
</body>
</html>
