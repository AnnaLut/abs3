<%@ Page Title="Картка СД {0}" Language="C#" MasterPageFile="~/ins/ins_master.master"
    AutoEventWireup="true" CodeFile="deal_card.aspx.cs" Inherits="ins_deal_card"
    Trace="false" MaintainScrollPositionOnPostback="true" %>
<%@ MasterType VirtualPath="~/ins/ins_master.master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString"
    TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer"
    TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxScanner.ascx" TagName="TextBoxScanner"
    TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/BarsReminder.ascx" TagName="BarsReminder"
    TagPrefix="Bars" %>
<%@ Register Src="/barsroot/UserControls/LabelTooltip.ascx" TagName="LabelTooltip"
    TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .action_button td {
            width: 75px;
            text-align: center;
            cursor: hand;
        }

        .action_text td {
            width: 75px;
            text-align: center;
            vertical-align: top;
        }

    </style>
    <script language="javascript" type="text/javascript">
        function ShowAddAgr(p_deal_id, hAddAgrID, ErrorUrl) {
            // если заполнено то выходим
            if ($get(hAddAgrID).value) return;

            var result = window.showModalDialog('/barsroot/ins/addagr.aspx?deal_id=' + p_deal_id + '&rnd=' + Math.random(), window, 'dialogHeight:200px; dialogWidth:400px; resizable:yes');
            if (result != null) {
                $get(hAddAgrID).value = result;
            }
            else {
                alert('Не вказано параметри дод. угоди!');
                location.href = ErrorUrl;
            }
        }
        function ShowComment(hCommID, IsRequired) {
            var result = window.showModalDialog('/barsroot/ins/comment.aspx?req=' + (IsRequired ? '1' : '0') + '&rnd=' + Math.random(), window, 'dialogHeight:200px; dialogWidth:400px; resizable:yes');

            if (result != null && result.comm != '') {
                $get(hCommID).value = result.comm;
                return true;
            }
            else if (!IsRequired) {
                return true;
            }
            else {
                alert('Не вказано коментар!');
                return false;
            }
        }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph" runat="Server">
    <bars:BarsObjectDataSource ID="odsCurrencies" runat="server" SelectMethod="SelectCurrencies"
        TypeName="Bars.Ins.VInsCurrencies">
    </bars:BarsObjectDataSource>
    <bars:BarsObjectDataSource ID="odsFrequencies" runat="server" SelectMethod="SelectFrequencies"
        TypeName="Bars.Ins.VInsFrequencies">
    </bars:BarsObjectDataSource>
    <bars:BarsObjectDataSource ID="odsUserPartnerTypes" runat="server" SelectMethod="SelectPartnerTypes"
        TypeName="Bars.Ins.VInsUserPartnerTypes">
    </bars:BarsObjectDataSource>
    <bars:BarsObjectDataSource ID="odsPartners" runat="server" SelectMethod="SelectPartners"
        TypeName="Bars.Ins.VInsPartners">
    </bars:BarsObjectDataSource>
    <div style="width: 100%; text-align: center">
        <div style="text-align: left">
            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                <tr>
                    <td>
                        <asp:Panel ID="pnlActions" runat="server" GroupingText="Дії">
                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                <tr class="action_button">
                                    <td id="tdPayBtn" runat="server">
                                        <asp:ImageButton ID="ibPay" runat="server" ToolTip="Внесення чергового платежу" OnClick="ibPay_Click" />
                                    </td>
                                    <td id="tdRenewBtn" runat="server">
                                        <asp:ImageButton ID="ibRenew" runat="server" ToolTip="Перезаключення договору" OnClick="ibRenew_Click" />
                                    </td>
                                    <td id="tdEditBtn" runat="server">
                                        <asp:ImageButton ID="ibEdit" runat="server" ToolTip="Редагувати" ImageUrl="/common/images/default/48/edit.png"
                                            OnClick="ibEdit_Click" />
                                    </td>
                                    <td id="tdAddAgrBtn" runat="server">
                                        <asp:ImageButton ID="ibAddAgr" runat="server" ToolTip="Додаткова угода" ImageUrl="/common/images/default/48/plug.png"
                                            OnClick="ibAddAgr_Click" />
                                    </td>
                                    <td id="tdAccidentBtn" runat="server">
                                        <asp:ImageButton ID="ibAccident" runat="server" ToolTip="Страховий випадок" ImageUrl="/common/images/default/48/warning.png"
                                            OnClick="ibAccident_Click" />
                                    </td>
                                    <td id="tdSend2VisaBtn" runat="server">
                                        <asp:ImageButton ID="ibSend2Visa" runat="server" ToolTip="Передати на візу" ImageUrl="/common/images/default/48/arrow_right_blue.png"
                                            OnClick="ibSend2Visa_Click" />
                                    </td>
                                    <td id="tdSendBack2MgrBtn" runat="server">
                                        <asp:ImageButton ID="ibSendBack2Mgr" runat="server" ToolTip="Повернути на доопрацювання"
                                            ImageUrl="/common/images/default/48/undo.png" OnClick="ibSendBack2Mgr_Click" />
                                    </td>
                                    <td id="tdVisaBtn" runat="server">
                                        <asp:ImageButton ID="ibVisa" runat="server" ToolTip="Візувати" ImageUrl="/common/images/default/48/check.png"
                                            OnClick="ibVisa_Click" />
                                    </td>
                                    <td id="tdStornoBtn" runat="server">
                                        <asp:ImageButton ID="ibStorno" runat="server" ToolTip="Сторнувати" ImageUrl="/common/images/default/48/error.png"
                                            OnClick="ibStorno_Click" OnClientClick='$("#dialog_form_comm").dialog("open"); ' />
                                    </td>
                                    <td id="tdOffBtn" runat="server">
                                        <asp:ImageButton ID="ibOff" runat="server" ToolTip="Закрити" ImageUrl="/common/images/default/48/stop.png"
                                            OnClick="ibOff_Click" />
                                    </td>
                                </tr>
                                <tr class="action_text">
                                    <td id="tdPayTxt" runat="server">
                                        <asp:Label ID="lbPay" runat="server" Text="Внесення чергового платежу" />
                                    </td>
                                    <td id="tdRenewTxt" runat="server">
                                        <asp:Label ID="lbRenew" runat="server" Text="Перезак-лючення договору" />
                                    </td>
                                    <td id="tdEditTxt" runat="server">
                                        <asp:Label ID="lbEdit" runat="server" Text="Редагувати" />
                                    </td>
                                    <td id="tdAddAgrTxt" runat="server">
                                        <asp:Label ID="lbAddAgr" runat="server" Text="Додаткова угода" />
                                    </td>
                                    <td id="tdAccidentTxt" runat="server">
                                        <asp:Label ID="lbAccident" runat="server" Text="Випадок" />
                                    </td>
                                    <td id="tdSend2VisaTxt" runat="server">
                                        <asp:Label ID="lbSend2Visa" runat="server" Text="Передати на візу" />
                                    </td>
                                    <td id="tdSendBack2MgrTxt" runat="server">
                                        <asp:Label ID="lbSendBack2Mgr" runat="server" Text="Повернути на доопра-цювання" />
                                    </td>
                                    <td id="tdVisaTxt" runat="server">
                                        <asp:Label ID="lbVisa" runat="server" Text="Візувати" />
                                    </td>
                                    <td id="tdStornoTxt" runat="server">
                                        <asp:Label ID="lbStorno" runat="server" Text="Сторнувати" />
                                    </td>
                                    <td id="tdOffTxt" runat="server">
                                        <asp:Label ID="lbOff" runat="server" Text="Закрити" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlBase" runat="server" GroupingText="Базові параметри">
                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                <tr>
                                    <td>
                                        <asp:Label ID="IDTitle" runat="server" Text="Системний №: " />
                                    </td>
                                    <td>
                                        <bars:LabelTooltip ID="ID" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="BRANCHTitle" runat="server" Text="Відділення: " />
                                    </td>
                                    <td>
                                        <bars:LabelTooltip ID="BRANCH" runat="server" />
                                        <bars:TextBoxRefer ID="BRANCH_EDIT" runat="server" TAB_NAME="BRANCH" KEY_FIELD="BRANCH"
                                            SEMANTIC_FIELD="NAME" WHERE_CLAUSE="where date_closed is null" ORDERBY_CLAUSE="order by branch" IsRequired="true" Visible="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="STAFF_IDTitle" runat="server" Text="Відп. виконавець: " />
                                    </td>
                                    <td>
                                        <bars:LabelTooltip ID="STAFF_ID" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CRT_DATETitle" runat="server" Text="Дата створення: " />
                                    </td>
                                    <td>
                                        <bars:LabelTooltip ID="CRT_DATE" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="STATUSTitle" runat="server" Text="Статус: " />
                                    </td>
                                    <td>
                                        <asp:HyperLink ID="STATUS" runat="server" ToolTip="Перегляд історії статусів" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="STATUS_COMMTitle" runat="server" Text="Коментар до статуса: " />
                                    </td>
                                    <td>
                                        <bars:LabelTooltip ID="STATUS_COMM" runat="server" TextLength="30" UseTextForTooltip="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="RENEWTitle" runat="server" Text="№ нового договору: " />
                                    </td>
                                    <td>
                                        <asp:HyperLink ID="RENEW" runat="server" ToolTip="Перейти до картки договору" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlKey" runat="server" GroupingText="Ключові параметри">
                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                <tr>
                                    <td>
                                        <asp:Label ID="DEAL_IDTitle" runat="server" Text="Ідентифікатор: " />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbDEAL_ID" runat="server" TabIndex="100" Enabled="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="PARTNER_IDTitle" runat="server" Text="СК: " />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="PARTNER_ID" runat="server" Width="400" TabIndex="101" Enabled="false" />
                                        <bars:DDLList ID="PARTNER_ID_EDIT" runat="server" DataSourceID="odsPartners" DataValueField="PARTNER_ID"
                                             DataTextField="NAME" IsRequired="true" ValidationGroup="Main" TabIndex="302" Visible="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="TYPE_IDTitle" runat="server" Text="Тип договору: " />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TYPE_ID" runat="server" Width="400" TabIndex="102" Enabled="false" />
                                        <bars:DDLList ID="TYPE_ID_EDIT" runat="server" DataSourceID="odsUserPartnerTypes" DataValueField="TYPE_ID"
                                             DataTextField="TYPE_NAME" IsRequired="true" ValidationGroup="Main" TabIndex="302" Visible="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Panel ID="pnlInsParams" runat="server" GroupingText="Страхувальник">
                                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="INS_RNKTitle" runat="server" Text="РНК: " />
                                                    </td>
                                                    <td>
                                                        <bars:TextBoxRefer ID="INS_RNK" runat="server" TAB_NAME="CUSTOMER" KEY_FIELD="RNK"
                                                            SEMANTIC_FIELD="NMK" SHOW_FIELDS="OKPO" WHERE_CLAUSE="WHERE DATE_OFF IS NULL"
                                                            IsRequired="true" ValidationGroup="Main" Width="200" OnValueChanged="INS_RNK_ValueChanged"
                                                            TabIndex="103" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="INS_FIOTitle" runat="server" Text="ПІБ: " />
                                                    </td>
                                                    <td>
                                                        <asp:HyperLink ID="INS_FIO" runat="server" Width="400" ToolTip="Перейти до картки контрагента" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="INS_DOCTitle" runat="server" Text="Документ: " />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="INS_DOC" runat="server" Enabled="false" Width="400" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="INS_INNTitle" runat="server" Text="ІПН: " />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="INS_INN" runat="server" Enabled="false" Width="200" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Panel ID="pnlDealParams" runat="server" GroupingText="Договір страхування">
                                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="SERTitle" runat="server" Text="Серія:" Visible="false" />
                                                    </td>
                                                    <td>
                                                        <bars:TextBoxString ID="SER" runat="server" TabIndex="104" Visible="false" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="NUMTitle" runat="server" Text="Номер:" />
                                                    </td>
                                                    <td>
                                                        <bars:TextBoxString ID="NUM" runat="server" IsRequired="true" ValidationGroup="Main"
                                                            TabIndex="105" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="SDATETitle" runat="server" Text="Дата початку дії:" />
                                                    </td>
                                                    <td>
                                                        <bars:TextBoxDate ID="SDATE" runat="server" IsRequired="true" ValidationGroup="Main"
                                                            TabIndex="106" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="EDATETitle" runat="server" Text="Дата закінчення дії:" />
                                                    </td>
                                                    <td>
                                                        <bars:TextBoxDate ID="EDATE" runat="server" IsRequired="true" ValidationGroup="Main"
                                                            TabIndex="107" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlObject" runat="server" GroupingText="Об`єкт страхування">
                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                <tr id="ObjectRowCL" runat="server">
                                    <td>
                                        <asp:Panel ID="pnlCL" runat="server" GroupingText="Застрахована особа">
                                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="CL_RNKTitle" runat="server" Text="РНК: " />
                                                    </td>
                                                    <td>
                                                        <bars:TextBoxRefer ID="CL_RNK" runat="server" TAB_NAME="CUSTOMER" KEY_FIELD="RNK"
                                                            SEMANTIC_FIELD="NMK" SHOW_FIELDS="OKPO" WHERE_CLAUSE="WHERE DATE_OFF IS NULL"
                                                            IsRequired="true" ValidationGroup="Main" Width="200" OnValueChanged="CL_RNK_ValueChanged"
                                                            TabIndex="202" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="CL_FIOTitle" runat="server" Text="ПІБ: " />
                                                    </td>
                                                    <td>
                                                        <asp:HyperLink ID="CL_FIO" runat="server" Width="400" ToolTip="Перейти до картки контрагента" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="CL_DOCTitle" runat="server" Text="Документ: " />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="CL_DOC" runat="server" Enabled="false" Width="400" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="CL_INNTitle" runat="server" Text="ІПН: " />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="CL_INN" runat="server" Enabled="false" Width="200" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr id="ObjectRowGRT" runat="server">
                                    <td>
                                        <asp:Panel ID="pnlGRT" runat="server" GroupingText="Договір забезпечення">
                                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="GRT_IDTitle" runat="server" Text="Ідентифікатор: " />
                                                    </td>
                                                    <td>
                                                        <bars:TextBoxRefer ID="GRT_ID" runat="server" TAB_NAME="V_INS_GRT_DEALS" KEY_FIELD="DEAL_ID"
                                                            SEMANTIC_FIELD="DEAL_NUM" SHOW_FIELDS="TYPE_NAME,DEAL_DATE,DEAL_RNK,FIO" IsRequired="true"
                                                            ValidationGroup="Main" Width="200" OnValueChanged="GRT_ID_ValueChanged" TabIndex="204" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="GRT_TYPETitle" runat="server" Text="Тип: " />
                                                    </td>
                                                    <td>
                                                        <asp:HyperLink ID="GRT_TYPE" runat="server" Width="400" ToolTip="Перейти до картки договору забезпечення" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="GRT_DEAL_NUMTitle" runat="server" Text="Номер: " />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="GRT_DEAL_NUM" runat="server" Enabled="false" Width="200" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="GRT_DEAL_DATETitle" runat="server" Text="Дата: " />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="GRT_DEAL_DATE" runat="server" Enabled="false" Width="200" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="GRT_GRT_NAMETitle" runat="server" Text="Опис: " />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="GRT_GRT_NAME" runat="server" Enabled="false" Width="400" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnlNd" runat="server" GroupingText="Кредитний договір">
                                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="NDTitle" runat="server" Text="Ідентифікатор: " />
                                                    </td>
                                                    <td>
                                                        <bars:TextBoxRefer ID="ND" runat="server" TAB_NAME="V_INS_CC_DEALS" KEY_FIELD="ND"
                                                            SEMANTIC_FIELD="NUM" SHOW_FIELDS="SDATE" IsRequired="true" ValidationGroup="Main"
                                                            Width="200" OnValueChanged="ND_ValueChanged" TabIndex="205" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="ND_NUMTitle" runat="server" Text="Номер: " />
                                                    </td>
                                                    <td>
                                                        <asp:HyperLink ID="ND_NUM" runat="server" Width="400" ToolTip="Перейти до картки кредитного договору" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="ND_SDATETitle" runat="server" Text="Дата початку дії: " />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="ND_SDATE" runat="server" Enabled="false" Width="200" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlFinance" runat="server" GroupingText="Фінансові параметри">
                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                <tr>
                                    <td colspan="2">
                                        <asp:Panel ID="pnlSUM" runat="server" GroupingText="Страхова сума">
                                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="SUMTitle" runat="server" Text="Сума: " />
                                                    </td>
                                                    <td>
                                                        <bars:TextBoxDecimal ID="SUM" runat="server" IsRequired="true" ValidationGroup="Main"
                                                            TabIndex="301" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="SUM_KVTitle" runat="server" Text="Валюта: " />
                                                    </td>
                                                    <td>
                                                        <bars:DDLList ID="SUM_KV" runat="server" DataSourceID="odsCurrencies" DataValueField="KV"
                                                            DataTextField="DESCR" Width="200" IsRequired="true" ValidationGroup="Main" TabIndex="302" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Panel ID="pnlEvents" runat="server" GroupingText="Події">
                                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="PAY_FREQTitle" runat="server" Text="Періодичність сплати стрх. платежів: " />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="PAY_FREQ" runat="server" Width="200" TabIndex="304" Enabled="false" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="RENEW_NEEDTitle" runat="server" Text="Чи необхідно перезаключати після закінчення?: " />
                                                    </td>
                                                    <td>
                                                        <bars:RBLFlag ID="RENEW_NEED" runat="server" IsRequired="true" DefaultValue="true"
                                                            ValidationGroup="Main" TabIndex="306" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="RENEW_NEWIDTitle" runat="server" Text="Номер нового договору: " />
                                                    </td>
                                                    <td>
                                                        <asp:HyperLink ID="hlRENEW_NEWID" runat="server" Target="_self" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Panel ID="pnlRate" runat="server" GroupingText="Страхова премія">
                                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                                <tr id="trINSU_TARIFF" runat="server">
                                                    <td>
                                                        <asp:Label ID="INSU_TARIFFTitle" runat="server" Text="Тариф (%):" TabIndex="303" />
                                                    </td>
                                                    <td>
                                                        <bars:TextBoxDecimal ID="INSU_TARIFF" runat="server" IsRequired="true" ValidationGroup="Main"
                                                            TabIndex="308" />
                                                    </td>
                                                </tr>
                                                <tr id="trINSU_SUM" runat="server">
                                                    <td>
                                                        <asp:Label ID="INSU_SUMTitle" runat="server" Text="Фіксована сума:" TabIndex="305" />
                                                    </td>
                                                    <td>
                                                        <bars:TextBoxDecimal ID="INSU_SUM" runat="server" IsRequired="true" ValidationGroup="Main"
                                                            TabIndex="309" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="TOTAL_INSU_SUMTitle" runat="server" Text="Загальная сума стрх. премії:" />
                                                    </td>
                                                    <td>
                                                        <bars:TextBoxDecimal ID="TOTAL_INSU_SUM" runat="server" Enabled="False" TabIndex="310" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlPaymentsSchedule" runat="server" GroupingText="Платіжний графік">
                            <bars:BarsObjectDataSource ID="odsPaymentsSchedule" runat="server" SelectMethod="SelectPaymentsSchedule"
                                TypeName="Bars.Ins.VInsPaymentsSchedule"
                                DataObjectTypeName="Bars.Ins.VInsPaymentsScheduleRecord">
                                <selectparameters>
                                    <asp:QueryStringParameter DefaultValue="-1" Name="DEAL_ID" Type="Decimal" QueryStringField="deal_id" />
                                </selectparameters>
                            </bars:BarsObjectDataSource>
                            <asp:ListView ID="lvPaymentsSchedule" runat="server" DataKeyNames="ID,DEAL_ID" DataSourceID="odsPaymentsSchedule"
                                OnItemDataBound="lvPaymentsSchedule_ItemDataBound" OnItemInserting="lvPaymentsSchedule_ItemInserting"
                                OnItemUpdating="lvPaymentsSchedule_ItemUpdating" OnItemCreated="lvPaymentsSchedule_ItemCreated"
                                OnItemDeleting="lvPaymentsSchedule_ItemDeleting">
                                <LayoutTemplate>
                                    <table class="tbl_style1" width="500px">
                                        <thead>
                                            <tr>
                                                <th></th>
                                                <th>
                                                    <asp:Label ID="PLAN_DATE" runat="server" Text="План-Дата" />
                                                </th>
                                                <th>
                                                    <asp:Label ID="FACT_DATE" runat="server" Text="Факт-Дата" />
                                                </th>
                                                <th>
                                                    <asp:Label ID="PLAN_SUM" runat="server" Text="План-Сума" />
                                                </th>
                                                <th>
                                                    <asp:Label ID="FACT_SUM" runat="server" Text="Факт-Сума" />
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr runat="server" id="itemPlaceholder">
                                            </tr>
                                        </tbody>
                                        <tfoot id="tblPSFoot" runat="server">
                                            <tr>
                                                <td class="command">
                                                    <asp:ImageButton ID="ibAddNew" runat="server" CausesValidation="False" OnClick="ibAddNew_Click"
                                                        ImageUrl="/common/images/default/16/new.png" ToolTip="Додати" />
                                                </td>
                                                <td colspan="4"></td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <tr id="tr" runat="server">
                                        <td class="command">
                                            <bars:LabelTooltip ID="lbPayed" runat="server" Text="Вик." ToolTip='<%# String.Format("№ док.: {0}; коментар: {1}", Eval("PMT_NUM"), Eval("PMT_COMM")) %>'
                                                Visible='<%# ((Decimal)Eval("PAYED") == 0 ? false : true) %>'>
                                            </bars:LabelTooltip>
                                            <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                                ImageUrl="/common/images/default/16/open.png" ToolTip="Редагувати" Visible='<%# ((Decimal)Eval("PAYED") == 1 ? false : true) %>' />
                                            <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                                ImageUrl="/common/images/default/16/delete.png" ToolTip="Видалити" Visible='<%# ((Decimal)Eval("PAYED") == 1 ? false : true) %>' />
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="PLAN_DATE" runat="server" Text='<%# Eval("PLAN_DATE", "{0:d}") %>'></asp:Label>
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="FACT_DATE" runat="server" Text='<%# Eval("FACT_DATE", "{0:d}") %>'></asp:Label>
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="PLAN_SUM" runat="server" Text='<%# Eval("PLAN_SUM", "{0:F2}") %>'></asp:Label>
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="FACT_SUM" runat="server" Text='<%# Eval("FACT_SUM", "{0:F2}") %>'></asp:Label>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <tr id="tr" runat="server" class="edit">
                                        <td class="command">
                                            <asp:ImageButton ID="ibUpdate" runat="server" CausesValidation="True" ValidationGroup="Update"
                                                CommandName="Update" ImageUrl="/common/images/default/16/save.png" ToolTip="Зберегти" />
                                            <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" />
                                        </td>
                                        <td align="right">
                                            <bars:TextBoxDate ID="PLAN_DATE" runat="server" Value='<%# Bind("PLAN_DATE") %>'
                                                IsRequired="true" ValidationGroup="Update" Width="100px" />
                                        </td>
                                        <td></td>
                                        <td align="right">
                                            <bars:TextBoxDecimal ID="PLAN_SUM" runat="server" Value='<%# Bind("PLAN_SUM") %>'
                                                IsRequired="true" ValidationGroup="Update" Width="100px" />
                                        </td>
                                    </tr>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <tr id="tr2" runat="server" class="new">
                                        <td class="command">
                                            <asp:ImageButton ID="ibInsert" runat="server" CausesValidation="True" ValidationGroup="Insert"
                                                CommandName="Insert" ImageUrl="/common/images/default/16/save.png" Text="Додати" />
                                            <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" OnClick="ibCancel_Click"
                                                ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" />
                                        </td>
                                        <td align="right">
                                            <bars:TextBoxDate ID="PLAN_DATE" runat="server" Value='<%# Bind("PLAN_DATE") %>'
                                                IsRequired="true" ValidationGroup="Insert" Width="100px"/>
                                        </td>
                                        <td></td>
                                        <td align="right">
                                            <bars:TextBoxDecimal ID="PLAN_SUM" runat="server" Value='<%# Bind("PLAN_SUM") %>'
                                                IsRequired="true" ValidationGroup="Insert" Width="100px" />
                                        </td>
                                    </tr>
                                </InsertItemTemplate>
                            </asp:ListView>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlAddAgreements" runat="server" GroupingText="Додаткові угоди">
                            <bars:BarsObjectDataSource ID="odsAddAgreements" runat="server" SelectMethod="SelectAddAgreements"
                                TypeName="Bars.Ins.VInsAddAgreements" DataObjectTypeName="Bars.Ins.VInsAddAgreementsRecord">
                                <selectparameters>
                                    <asp:QueryStringParameter DefaultValue="-1" Name="DEAL_ID" Type="Decimal" QueryStringField="deal_id" />
                                </selectparameters>
                            </bars:BarsObjectDataSource>
                            <asp:ListView ID="lvAddAgreements" runat="server" DataKeyNames="ID,DEAL_ID" DataSourceID="odsAddAgreements">
                                <LayoutTemplate>
                                    <table class="tbl_style1" width="500px">
                                        <thead>
                                            <tr>
                                                <th>
                                                    <asp:Label ID="SDATE" runat="server" Text="Дата" />
                                                </th>
                                                <th>
                                                    <asp:Label ID="SERNUM" runat="server" Text="Серія, №" />
                                                </th>
                                                <th>
                                                    <asp:Label ID="COMM" runat="server" Text="Зміни" />
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr runat="server" id="itemPlaceholder">
                                            </tr>
                                        </tbody>
                                    </table>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <tr id="tr" runat="server">
                                        <td align="center">
                                            <asp:Label ID="SDATE" runat="server" Text='<%# Eval("SDATE", "{0:d}") %>'></asp:Label>
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="SERNUM" runat="server" Text='<%# String.Format("{0}{1}", Eval("SER"), Eval("NUM")) %>'></asp:Label>
                                        </td>
                                        <td align="left">
                                            <bars:LabelTooltip ID="COMM" runat="server" Text='<%# Eval("COMM") %>' UseTextForTooltip="true"
                                                TextLength="50">
                                            </bars:LabelTooltip>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <EmptyDataTemplate>
                                    <asp:Label ID="lEmptyData" runat="server" Text="Не має"></asp:Label>
                                </EmptyDataTemplate>
                            </asp:ListView>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlAccidents" runat="server" GroupingText="Страхові випадки">
                            <bars:BarsObjectDataSource ID="odsAccidents" runat="server" SelectMethod="SelectAccidents"
                                TypeName="Bars.Ins.VInsAccidents" DataObjectTypeName="Bars.Ins.VInsAccidentsRecord">
                                <selectparameters>
                                    <asp:QueryStringParameter DefaultValue="-1" Name="DEAL_ID" Type="Decimal" QueryStringField="deal_id" />
                                </selectparameters>
                            </bars:BarsObjectDataSource>
                            <asp:ListView ID="lvAccidents" runat="server" DataKeyNames="ID,DEAL_ID" DataSourceID="odsAccidents">
                                <LayoutTemplate>
                                    <table class="tbl_style1" width="500px">
                                        <thead>
                                            <tr>
                                                <th>
                                                    <asp:Label ID="ACDT_DATE" runat="server" Text="Дата" />
                                                </th>
                                                <th>
                                                    <asp:Label ID="COMM" runat="server" Text="Коментар" />
                                                </th>
                                                <th>
                                                    <asp:Label ID="REFUND_SUM" runat="server" Text="Сума відш." />
                                                </th>
                                                <th>
                                                    <asp:Label ID="REFUND_DATE" runat="server" Text="Дата відш." />
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr runat="server" id="itemPlaceholder">
                                            </tr>
                                        </tbody>
                                    </table>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <tr id="tr" runat="server">
                                        <td align="center">
                                            <asp:Label ID="ACDT_DATE" runat="server" Text='<%# Eval("ACDT_DATE", "{0:d}") %>'></asp:Label>
                                        </td>
                                        <td align="left">
                                            <bars:LabelTooltip ID="FACT_DATE" runat="server" Text='<%# Eval("COMM") %>' UseTextForTooltip="true"
                                                TextLength="50">
                                            </bars:LabelTooltip>
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="REFUND_SUM" runat="server" Text='<%# Eval("REFUND_SUM", "{0:F2}") %>'></asp:Label>
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="REFUND_DATE" runat="server" Text='<%# Eval("REFUND_DATE", "{0:d}") %>'></asp:Label>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <EmptyDataTemplate>
                                    <asp:Label ID="lEmptyData" runat="server" Text="Не має"></asp:Label>
                                </EmptyDataTemplate>
                            </asp:ListView>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlAttrs" runat="server" GroupingText="Додаткові реквізити">
                            <bars:BarsObjectDataSource ID="odsPartnerTypeAttrs" runat="server" SelectMethod="SelectPartnerTypeAttrs"
                                TypeName="Bars.Ins.VInsPartnerTypeAttrs" OnSelecting="odsPartnerTypeAttrs_Selecting">
                                <selectparameters>
                                    <asp:Parameter DefaultValue="-1" Name="PARTNER_ID" Type="Decimal" />
                                    <asp:Parameter DefaultValue="-1" Name="TYPE_ID" Type="Decimal" />
                                </selectparameters>
                            </bars:BarsObjectDataSource>
                            <asp:ListView ID="lvPartnerTypeAttrs" runat="server" DataKeyNames="ATTR_ID,ATTR_TYPE_ID"
                                DataSourceID="odsPartnerTypeAttrs" OnItemDataBound="lvPartnerTypeAttrs_ItemDataBound">
                                <LayoutTemplate>
                                    <table border="0" cellpadding="3" cellspacing="0" class="data_table" runat="server"
                                        id="tbl">
                                        <tr runat="server" id="itemPlaceholder">
                                        </tr>
                                    </table>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <tr id="tr" runat="server">
                                        <td>
                                            <asp:Label ID="ATTR_NAME" runat="server" Text='<%# Eval("ATTR_NAME") + ": " %>' />
                                        </td>
                                        <td>
                                            <asp:HiddenField ID="ATTR_TYPE_ID" runat="server" Value='<%# Eval("ATTR_TYPE_ID") %>' />
                                            <bars:TextBoxString ID="ATTR_ID_S" runat="server" IsRequired='<%# (Decimal?)Eval("IS_REQUIRED") == 1 ? true : false %>'
                                                ValidationGroup="Attrs" Visible='<%# (String)Eval("ATTR_TYPE_ID") == "S" ? true : false %>' />
                                            <bars:TextBoxDecimal ID="ATTR_ID_N" runat="server" IsRequired='<%# (Decimal?)Eval("IS_REQUIRED") == 1 ? true : false %>'
                                                ValidationGroup="Attrs" Visible='<%# (String)Eval("ATTR_TYPE_ID") == "N" ? true : false %>' />
                                            <bars:TextBoxDate ID="ATTR_ID_D" runat="server" IsRequired='<%# (Decimal?)Eval("IS_REQUIRED") == 1 ? true : false %>'
                                                ValidationGroup="Attrs" Visible='<%# (String)Eval("ATTR_TYPE_ID") == "D" ? true : false %>' />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <EmptyDataTemplate>
                                    <asp:Label ID="lEmptyData" runat="server" Text="Не має"></asp:Label>
                                </EmptyDataTemplate>
                            </asp:ListView>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlScans" runat="server" GroupingText="Сканкопії">
                            <bars:BarsObjectDataSource ID="odsPartnerTypeScans" runat="server" SelectMethod="SelectPartnerTypeScans"
                                TypeName="Bars.Ins.VInsPartnerTypeScans" OnSelecting="odsPartnerTypeScans_Selecting">
                                <selectparameters>
                                    <asp:Parameter DefaultValue="-1" Name="PARTNER_ID" Type="Decimal" />
                                    <asp:Parameter DefaultValue="-1" Name="TYPE_ID" Type="Decimal" />
                                </selectparameters>
                            </bars:BarsObjectDataSource>
                            <asp:ListView ID="lvPartnerTypeScans" runat="server" DataKeyNames="SCAN_ID" DataSourceID="odsPartnerTypeScans"
                                OnItemDataBound="lvPartnerTypeScans_ItemDataBound">
                                <LayoutTemplate>
                                    <table border="0" cellpadding="3" cellspacing="0" class="data_table" runat="server"
                                        id="tbl">
                                        <tr runat="server" id="itemPlaceholder">
                                        </tr>
                                    </table>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <tr id="tr" runat="server">
                                        <td>
                                            <asp:Label ID="SCAN_NAME" runat="server" Text='<%# Eval("SCAN_NAME") + ": " %>' />
                                        </td>
                                        <td>
                                            <bars:TextBoxScanner ID="SCAN_ID" runat="server" IsRequired='<%# (Decimal?)Eval("IS_REQUIRED") == 1 ? true : false %>'
                                                ValidationGroup="Scans" />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <EmptyDataTemplate>
                                    <asp:Label ID="lEmptyData" runat="server" Text="Не має"></asp:Label>
                                </EmptyDataTemplate>
                            </asp:ListView>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlTemplates" runat="server" GroupingText="Друк шаблонів">
                            <bars:BarsObjectDataSource ID="odsPartnerTypeTemplates" runat="server" SelectMethod="SelectPartnerTypeTemplates"
                                TypeName="Bars.Ins.VInsPartnerTypeTemplates" OnSelecting="odsPartnerTypeTemplates_Selecting">
                                <selectparameters>
                                    <asp:Parameter DefaultValue="-1" Name="PARTNER_ID" Type="Decimal" />
                                    <asp:Parameter DefaultValue="-1" Name="TYPE_ID" Type="Decimal" />
                                </selectparameters>
                            </bars:BarsObjectDataSource>
                            <asp:ListView ID="lvPartnerTypeTemplates" runat="server" DataKeyNames="TEMPLATE_ID"
                                DataSourceID="odsPartnerTypeTemplates" OnItemCommand="lvPartnerTypeTemplates_ItemCommand">
                                <LayoutTemplate>
                                    <table border="0" cellpadding="3" cellspacing="0" class="data_table" runat="server"
                                        id="tbl">
                                        <tr runat="server" id="itemPlaceholder">
                                        </tr>
                                    </table>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <tr id="tr" runat="server">
                                        <td>
                                            <asp:Label ID="TEMPLATE_NAME" runat="server" Text='<%# Eval("TEMPLATE_NAME") + ": " %>' />
                                        </td>
                                        <td>
                                            <asp:ImageButton ID="ibPrint" runat="server" ToolTip="Друк" CausesValidation="False"
                                                ImageUrl="/Common/Images/default/16/print.png" CommandName="Print" CommandArgument='<%# (String)Eval("TEMPLATE_ID") + ";" + (String)Eval("PRT_FORMAT") %>' />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <EmptyDataTemplate>
                                    <asp:Label ID="lEmptyData" runat="server" Text="Не має"></asp:Label>
                                </EmptyDataTemplate>
                            </asp:ListView>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Button ID="btSave" runat="server" Text="Зберегти" OnClick="btSave_Click" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="hiddenFields">
        <asp:HiddenField ID="hAddAgr" runat="server" />
        <asp:HiddenField ID="hComm" runat="server" />
    </div>
</asp:Content>
