<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bpk_deal.aspx.cs" Inherits="credit_bpk_deal"
    Theme="default" %>

<%@ Register Src="usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<%@ Register Src="usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="usercontrols/loading.ascx" TagName="loading" TagPrefix="bec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Договір на відкриття картки</title>
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />

    <script language="javascript" type="text/javascript" src="jscript/JScript.js"></script>

    <script language="javascript" type="text/javascript">
        // параметры диалогового окна
        var dialogFeatures = 'dialogHeight: 800px; dialogWidth: 800px; center: yes; resizable: yes; status: no';

        function ShowCustomerRefer(CustType, rnkCtrlID, okpoCtrlID, fioCtrlID)
        {
            var rnd = Math.random();
            
            var tail = ''; 
            if (CustType != 0) tail = 'CustType=' + CustType;
            
            var result = window.showModalDialog('dialog.aspx?type=metatab&tail=\'' + tail + '\'&role=WR_CREDIT&tabname=CUSTOMER&field=(RNK)&rnd=' + rnd, window, dialogFeatures);
            
            if (result == null) return false;
            else 
            {
                var rnkCtrl = document.getElementById(rnkCtrlID);
                var okpoCtrl = document.getElementById(okpoCtrlID);
                var fioCtrl = document.getElementById(fioCtrlID);
                
                rnkCtrl.value = result[0];
                okpoCtrl.value = result[2];
                fioCtrl.value = result[1];

                return true;
            }
        }
    </script>

    <style type="text/css">
        .group_title
        {
            text-align: center;
            font-weight: bold;
            font-style: italic;
        }
        .parameter_title
        {
            text-align: right;
            padding-right: 5px;
        }
        .parameter_value
        {
            text-align: left;
        }
        .button_send_container
        {
            text-align: right;
            padding-top: 5px;
        }
        .checkbox_activate
        {
            border-bottom: solid 1px gray;
        }
        .checkbox_activate_container
        {
            padding-bottom: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
    </asp:ScriptManager>
    <div class="pageTitle">
        <asp:Label ID="lbPageTitle" runat="server" Text="Договір на відкриття картки"></asp:Label>
    </div>
    <div style="text-align: center; padding: 10px 0px 10px 10px">
        <table border="0" cellpadding="3" cellspacing="0" style="text-align: left">
            <tr>
                <td>
                    <asp:UpdatePanel ID="upClient" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:Panel ID="attrClient" runat="server" GroupingText="Клієнт">
                                <table border="0" cellpadding="3" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:Label ID="RNKTitle" runat="server" Text="Код Контрагенту : "></asp:Label>
                                        </td>
                                        <td>
                                            <bec:TextBoxNumb ID="RNK" runat="server" MaxLength="20" IsRequired="true" OnValueChanged="RNK_ValueChanged" />
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
                            </asp:Panel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="attrCard" runat="server" GroupingText="Картка">
                        <table border="0" cellpadding="3" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:Label ID="OB22Title" runat="server" Text="ОБ22 : "></asp:Label>
                                </td>
                                <td>
                                    <bec:DDLList ID="OB22" runat="server" IsRequired="true">
                                    </bec:DDLList>
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
                                <td colspan="2">
                                    <asp:Panel ID="pnlCreditLine" runat="server" GroupingText="Кредитна лінія">
                                        <asp:RadioButtonList ID="CreditLine" runat="server">
                                            <asp:ListItem Selected="True" Value="0">Ні</asp:ListItem>
                                            <asp:ListItem Value="2">Короткостроковий кредит</asp:ListItem>
                                            <asp:ListItem Value="3">Довгостроковий кредит</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Panel ID="pnlDeposit" runat="server" GroupingText="Депозит">
                                        <asp:RadioButtonList ID="Deposit" runat="server">
                                            <asp:ListItem Selected="True" Value="0">Ні</asp:ListItem>
                                            <asp:ListItem Value="1">Так</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td class="button_send_container">
                    <asp:UpdatePanel ID="upSend" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:Button ID="btSend" runat="server" Text="Відкрити" OnClientClick="if (!confirm('Відкрити картку?')) return false;"
                                OnClick="btSend_Click" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <asp:UpdateProgress ID="uppClient" runat="server" AssociatedUpdatePanelID="upClient">
        <ProgressTemplate>
            <bec:loading ID="ldngClient" runat="server" />
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdateProgress ID="uppSend" runat="server" AssociatedUpdatePanelID="upSend">
        <ProgressTemplate>
            <bec:loading ID="ldngSend" runat="server" />
        </ProgressTemplate>
    </asp:UpdateProgress>
    </form>
</body>
</html>
