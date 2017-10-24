<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DptProcessingAgreement.aspx.cs" Inherits="DptProcessingAgreement" %>

<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="/barsroot/Content/Themes/Kendo/app.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.common.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.dataviz.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.bootstrap.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.dataviz.bootstrap.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/Styles.css" rel="stylesheet" />

    <script type="text/javascript" src="/barsroot/Scripts/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/kendo/kendo.all.min.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.config.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.ui.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.extension.js"></script>

    <script>
        $(document).ready(function () {
            // $("#btnRefuse").on("click", function () {
            //     var len =  $("#tbComments").val().length();
            //     if (len == 0) {
            //         bars.ui.alert({ text: 'Коментар має містити причину відмови!' });
            //         return false;
            //     }
            //     if (len < 15) {
            //         bars.ui.alert({ text: 'Коментар недостатньої довжини!' });
            //         return false;
            //     }
            //     if (len >= 15) {
            //         if (!confirm('Відмовити в заключенні додаткової угоди?')) return false;
            //     }
            // });
        });
    </script>
</head>
<body>
    <form id="frmProcessingAgreement" runat="server">
    <div>
    <ajax:ToolkitScriptManager ID="SM" runat="server" EnablePageMethods="true">
    </ajax:ToolkitScriptManager>
    <table class="InnerTable" style="width:90%;">
        <tr>
            <td style="width:25%;"></td>
            <td style="width:25%;"></td>
            <td style="width:25%;"></td>
            <td style="width:25%;"></td>
        </tr>
        <tr>
            <td align="right" colspan="2">
                <asp:Label ID="lbAgrnmtNum" runat="server" Text="Додаткова угода № " CssClass="InfoLabel" />
            </td>
            <td align="left">
                <asp:TextBox ID="tbAgrnmtNum" TabIndex="1" ReadOnly="true" BackColor="Gainsboro" runat="server" 
                    style="text-align: center" ClientIDMode="Static" CssClass="InfoText" Width="99%" />
            </td>
            <td></td>
        </tr>
        <tr>
            <td align="right" colspan="2">
                <asp:Label ID="lbAgrnmtDate" runat="server" Text="Дата початку дії дод. угоди " CssClass="InfoLabel" />
            </td>
            <td align="left">
                <asp:TextBox ID="tbAgrnmtDate" TabIndex="2" ReadOnly="true" BackColor="Gainsboro" runat="server" 
                    style="text-align: center" ClientIDMode="Static" CssClass="InfoText" Width="100px" />
            </td>
            <td></td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:Panel ID="pnlAgrnmtDetails" runat="server" GroupingText="Реквізити ДУ">
                    <table class="InnerTable" style="width:100%;" cellpadding="3">
                        <tr>
                            <td align="right" style="width:30%;">
                                <asp:Label ID="kbAgrnmtType" runat="server" Text="Вид додаткової угоди: " CssClass="InfoLabel" />
                            </td>
                            <td align="center" style="width:10%;">
                                <asp:TextBox ID="tbAgrnmtTypeId" TabIndex="3" ReadOnly="true" BackColor="Gainsboro" runat="server" style="text-align: center" 
                                    ClientIDMode="Static" CssClass="InfoText" Width="99%" />
                            </td>
                            <td align="left" style="width:60%;">
                                <asp:TextBox ID="tbAgrnmtTypeName" TabIndex="4" ReadOnly="true" BackColor="Gainsboro" runat="server" style="text-align: left" 
                                    ClientIDMode="Static" CssClass="InfoText" Width="99%" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width:30%;">
                                <asp:Label ID="lbAgrnmtAmnt" runat="server" Text="Сума договору: " CssClass="InfoLabel" />
                            </td>
                            <td align="left" colspan="2">
                                <asp:TextBox ID="tbAgrnmtAmnt" TabIndex="5" ReadOnly="true" BackColor="Gainsboro" runat="server" style="text-align: right" 
                                     MaxLength="13" ClientIDMode="Static" CssClass="InfoText" Width="150px" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width:30%;">
                                <asp:Label ID="lbAgrnmtEndDate" runat="server" Text="Дата завершення: " CssClass="InfoLabel" />
                            </td>
                            <td align="left"colspan="2">
                                <asp:TextBox ID="tbAgrnmtEndDate" TabIndex="6" ReadOnly="true" BackColor="Gainsboro" runat="server" style="text-align: center" 
                                     MaxLength="10" ClientIDMode="Static" CssClass="InfoText" Width="150px" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width:30%;">
                                <asp:Label ID="lbAgrnmtRate" runat="server" Text="Відсоткова ставка: " CssClass="InfoLabel" />
                            </td>
                            <td align="left" colspan="2">
                                <asp:TextBox ID="tbAgrnmtRate" TabIndex="7" ReadOnly="true" BackColor="Gainsboro" runat="server" style="text-align: right" 
                                     MaxLength="6" ClientIDMode="Static" CssClass="InfoText" Width="150px" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width:30%;">
                                <asp:Label ID="lbFrequency" runat="server" Text="Виплата відсотків: " CssClass="InfoLabel" />
                            </td>
                            <td align="center" style="width:10%;">
                                <asp:TextBox ID="tbFrequencyId" TabIndex="8" ReadOnly="true" BackColor="Gainsboro" runat="server" style="text-align: center" 
                                     ClientIDMode="Static" CssClass="InfoText" Width="99%" />
                            </td>
                            <td align="left" style="width:60%;">
                                <asp:DropDownList ID="ddlFrequencies" TabIndex="9" runat="server" ClientIDMode="Static" CssClass="BaseDropDownList"
                                     Enabled="false" DataTextField="FREQ_NAME" DataValueField="FREQ_ID" Width="99%"  >
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width:30%;">
                                <asp:Label ID="lbPenalty" runat="server" Text="Штраф: " CssClass="InfoLabel" />
                            </td>
                            <td align="center" style="width:10%;">
                                <asp:TextBox ID="tbPenaltyId" TabIndex="10" ReadOnly="true" BackColor="Gainsboro" runat="server" style="text-align: center" 
                                     ClientIDMode="Static" CssClass="InfoText" Width="99%" />
                            </td>
                            <td align="left" style="width:60%;">
                                <asp:DropDownList ID="ddlPenalties" TabIndex="11" runat="server" ClientIDMode="Static" CssClass="BaseDropDownList"
                                     Enabled="false" DataTextField="STOP_NAME" DataValueField="STOP_ID" Width="99%" >
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <asp:Panel ID="pnlPayoutDetails" runat="server" GroupingText="Реквізити виплати">
                                    <table class="InnerTable" style="width:100%;">
                                        <tr>
                                            <td align="right" style="width:29%;">
                                                <asp:Label ID="lbBankDetails" runat="server" Text="Банк отримувача: " CssClass="InfoLabel" />
                                            </td>
                                            <td align="center" style="width:10%;">
                                                <asp:TextBox ID="tbBankCode" TabIndex="12" ReadOnly="true" BackColor="Gainsboro" runat="server" style="text-align: center" 
                                                    ToolTip="Код банку" ClientIDMode="Static" CssClass="InfoText" Width="99%" />
                                            </td>
                                            <td align="left" style="width:61%;">
                                                <asp:TextBox ID="tbBankName" TabIndex="13" BackColor="Gainsboro" runat="server" style="text-align: left" 
                                                    ClientIDMode="Static" CssClass="InfoText" Width="99%" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width:29%;">
                                                <asp:Label ID="lbRecipientAcnt" runat="server" Text="Рахунок отримувача: " CssClass="InfoLabel" />
                                            </td>
                                            <td align="left" colspan="2">
                                                <asp:TextBox ID="tbRecipientAcnt" TabIndex="14" MaxLength="14" BackColor="Gainsboro" runat="server" style="text-align: center" 
                                                    ToolTip="Номер рахунку" ClientIDMode="Static" CssClass="InfoText" Width="150px" />
                                                <%--TabIndex="15"--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width:29%;">
                                                <asp:Label ID="lbRecipientName" runat="server" Text="Назва отримувача: " CssClass="InfoLabel" />
                                            </td>
                                            <td align="left" colspan="2">
                                                <asp:TextBox ID="tbRecipientName" TabIndex="16" BackColor="Gainsboro" runat="server" style="text-align: left" 
                                                    ClientIDMode="Static" CssClass="InfoText" Width="99%" />
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
            <td colspan="4">
                <asp:Panel ID="pnlCreated" runat="server" GroupingText="Створена: ">
                    <table class="InnerTable" style="width:100%;" cellpadding="3">
                        <tr>
                            <td align="right" style="width:30%;">
                                <asp:TextBox ID="tbCreationDate" TabIndex="17" ReadOnly="true" BackColor="Gainsboro" runat="server" style="text-align: center" 
                                    ToolTip="Дата створення додаткової угоди" ClientIDMode="Static" CssClass="InfoText" Width="100px" />
                            </td>
                            <td align="center" style="width:10%;">
                                <asp:TextBox ID="tbCreationUserId" TabIndex="18" ReadOnly="true" BackColor="Gainsboro" runat="server" style="text-align: center" 
                                    ToolTip="Ідентифікатор користувача що створив додаткову угоду" ClientIDMode="Static" CssClass="InfoText" Width="99%" />
                            </td>
                            <td align="left" style="width:60%;">
                                <asp:TextBox ID="tbCreationUserName" TabIndex="19" ReadOnly="true" BackColor="Gainsboro" runat="server" style="text-align: left" 
                                    ToolTip="Назва користувача що створив додаткову угоду" ClientIDMode="Static" CssClass="InfoText" Width="99%" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:Panel ID="Panel1" runat="server" GroupingText="Оброблена: ">
                    <table class="InnerTable" style="width:100%;" cellpadding="3" >
                        <tr>
                            <td align="right" style="width:30%;">
                                <asp:TextBox ID="tbProcessingDate" TabIndex="20" ReadOnly="true" BackColor="Gainsboro" runat="server" style="text-align: center" 
                                    ToolTip="Дата обробки додаткової угоди" ClientIDMode="Static" CssClass="InfoText" Width="100px" />
                            </td>
                            <td align="center" style="width:10%;">
                                <asp:TextBox ID="tbProcessingUserId" TabIndex="21" ReadOnly="true" BackColor="Gainsboro" runat="server" style="text-align: center" 
                                    ToolTip="Ідентифікатор користувача що обробив додаткову угоду" ClientIDMode="Static" CssClass="InfoText" Width="99%" />
                            </td>
                            <td align="left" style="width:60%; ">
                                <asp:TextBox ID="tbProcessingUserName" TabIndex="22" ReadOnly="true" BackColor="Gainsboro" runat="server" style="text-align: left" 
                                    ToolTip="Назва користувача що обробив додаткову угоду" ClientIDMode="Static" CssClass="InfoText" Width="99%" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width:30%;">
                                <asp:Label ID="lbComments" Text="Коментар: &nbsp;" CssClass="InfoText" runat="server" />
                            </td>
                            <td colspan="2" nowrap="nowrap" valign="top">
                                <asp:TextBox ID="tbComments" TabIndex="23" runat="server" MaxLength="500" TextMode="MultiLine" Height="99%" Width="99%" />
                                <asp:RequiredFieldValidator ID="RequestCommentValidator" ControlToValidate="tbComments" Width="1%" runat="server"
                                    ValidationGroup="RefuseAgrnmt" ErrorMessage="Не вказна причина відмови!"  
                                    Text="*" EnableClientScript="true" SetFocusOnError="true" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
    <table style="width:90%;">
        <tr>
            <td align="center" style="width:33%">
                <asp:Button ID="btnConfirm" runat="server" Text="Погодити" TabIndex="24" CssClass="AcceptButton"
                        Width="200px" Height="30px" ForeColor="Green" Font-Bold="true"
                        CausesValidation="false" OnClick="btnConfirm_Click" />
            </td>
            <td align="center" style="width:34%">
                <asp:Button ID="btnRefuse" runat="server" Text="Відмовити" TabIndex="25"  CssClass="AcceptButton"
                        Width="200px" Height="30px" ForeColor="Red" Font-Bold="true"
                        ValidationGroup="RefuseAgrnmt" CausesValidation="true" OnClick="btnRefuse_Click" />
            </td>
            <td align="center" style="width:33%">
                <asp:Button ID="btnExit" runat="server" Text="Вихід" TabIndex="26" CssClass="AcceptButton"
                        Width="200px" Height="30px" ForeColor="Black" Font-Bold="true"
                        CausesValidation="false" OnClick="btnExit_Click" />
            </td>
        </tr>
        <tr>
            <td colspan="3">
              <span id="lbVers" style="color: gray; font-size:small;">1.1 від 20.06.2016</span>
              <asp:ValidationSummary ID="RefuseVldSummary" HeaderText="Незаповненні поля!" runat="server" EnableClientScript="true"
                    ValidationGroup="RefuseAgrnmt" ShowMessageBox="true" ShowSummary="false" />
            </td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
