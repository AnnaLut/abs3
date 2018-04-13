<%@ Page Language="c#" CodeFile="DptClientSearch.aspx.cs" AutoEventWireup="true" Inherits="DptClientSearch" EnableViewState="True" Debug="False" %>

<%@ Register Src="../UserControls/loading.ascx" TagName="loading" TagPrefix="uc1" %>
<%@ Register Src="~/credit/usercontrols/ByteImage.ascx" TagName="ByteImage" TagPrefix="bec" %>

<%@ Register Src="../UserControls/BPKIdentification.ascx" TagName="BPKIdentification" TagPrefix="bpk" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Депозитний модуль: Пошук клієнта</title>
    <base target="_self" />
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="C#" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/ck.js"></script>
    <script type="text/javascript" language="javascript">
        function AddListener4Enter() {
            AddListeners("textClientName,textClientCode,textClientDate,textClientSerial,textClientNumber", 'onkeydown', TreatEnterAsTab);
        }
    </script>
    <script type="text/javascript" language="javascript">
        CrossAddEventListener(window, 'onload', AddListener4Enter);
    </script>
</head>
<body onload="focusControl('textClientName');">
    <form id="Form1" method="post" runat="server">
        <asp:ScriptManager ID="ScriptManager" EnablePartialRendering="true" runat="server">
        </asp:ScriptManager>
        <table id="MainTable" class="MainTable">
            <tr>
                <td colspan="4" align="center">
                    <asp:Label ID="lbSearchClient" Text="Пошук клієнта" runat="server" CssClass="InfoHeader" />
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <table id="InfoTable" class="InnerTable">
                        <tr>
                            <td style="width: 20%">
                                <asp:Label ID="lbNMK" Text="ПІБ клієнта:" meta:resourcekey="lbNMK" CssClass="InfoText"
                                    runat="server" Height="16px" />
                            </td>
                            <td>
                                <asp:TextBox ID="textClientName" meta:resourcekey="textClientName2" CssClass="InfoText" runat="server"
                                    ToolTip="ПІБ клієнта" MaxLength="35" TabIndex="1" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbId" Text="ІПН клієнта:" meta:resourcekey="lbId" CssClass="InfoText" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="textClientCode" meta:resourcekey="textClientCode2" runat="server" CssClass="InfoText"
                                    ToolTip="Ідентифікаційний код клієнта" MaxLength="10" TabIndex="2" Width="30%" />
                                <asp:CustomValidator ID="validatorClientCode" runat="server" ControlToValidate="textClientCode"
                                    ClientValidationFunction="checkClientCode" ValidateEmptyText="True" Display="None" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbBirthDate" Text="Дата народження:" meta:resourcekey="lbBirthDate2" CssClass="InfoText" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="textClientDate" runat="server" CssClass="InfoDateSum"
                                    ToolTip="Дата народження клієнта" TabIndex="3" />
                                <ajax:MaskedEditExtender ID="meeClientDate" TargetControlID="textClientDate" runat="server"
                                    Mask="99/99/9999" MaskType="Date" Century="2000" CultureName="en-GB"
                                    UserDateFormat="DayMonthYear" InputDirection="LeftToRight" OnFocusCssClass="MaskedEditFocus" />
                                <asp:CompareValidator ID="DateValidator" runat="server"
                                    Type="Date" ControlToValidate="textClientDate" Operator="DataTypeCheck"
                                    ErrorMessage="Неправильний формат дати!" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbDocSerial" Text="Серія документу:" meta:resourcekey="lbDocSerial2" CssClass="InfoText" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="textClientSerial" meta:resourcekey="textClientSerial" runat="server" CssClass="InfoText" ToolTip="Серія ідентифікуючого документу"
                                    MaxLength="10" TabIndex="4"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbDocNumber" Text="Номер документу" meta:resourcekey="lbDocNumber2" CssClass="InfoText" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="textClientNumber" meta:resourcekey="textClientNumber" runat="server" CssClass="InfoText" MaxLength="20"
                                    ToolTip="Номер ідентифікуючого документу" TabIndex="5" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td align="center">
                    <bec:ByteImage ID="biClietFoto" runat="server" Visible="false" Height="135px" Width="105px"
                        ShowLabel="false" ShowView="true" />
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <input id="isPostBack" type="hidden" name="isPostBack" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="center" style="width: 25%">
                    <bpk:BPKIdentification ID="btSearchByBPK" runat="server" Text="Ідентифікація по БПК" TabIndex="6"
                        OnClientIdentified="btSearchByBPK_ClientIdentified" />
                </td>
                <td align="center" style="width: 25%">
                    <asp:Button ID="btSearch" Text="Пошук" meta:resourcekey="btSearch2" runat="server" CssClass="AcceptButton"
                        TabIndex="7" CausesValidation="true" />
                </td>
                <td align="center" style="width: 25%">
                    <asp:Button ID="btRegister" meta:resourcekey="btRegister" runat="server" Text="Реєструвати" CssClass="AcceptButton"
                        TabIndex="10" CausesValidation="false" />
                </td>
                <td align="center" style="width: 25%">
                    <asp:Button ID="btClientCard" meta:resourcekey="btSubmit" runat="server" Text="Картка Клієнта" CssClass="AcceptButton"
                        TabIndex="9" CausesValidation="false" Visible="false" />
                </td>
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <asp:Label ID="lbTitle" Text="Оберіть клієнта з списку знайдених" meta:resourcekey="lbTitle3" runat="server" CssClass="InfoText" />
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <asp:DropDownList ID="ddlSearchClient" runat="server" TabIndex="8" CssClass="BaseDropDownList"
                        DataSource="<%# fClients %>" DataValueField="RNK" OnSelectedIndexChanged="Index_Changed" AutoPostBack="true">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="4"></td>
            </tr>
        </table>
    </form>
    <script type="text/javascript" language="javascript">
        document.getElementById("textClientCode").attachEvent("onkeydown", doNum);
        document.getElementById("textClientNumber").attachEvent("onkeydown", doNum);
        document.getElementById("textClientName").attachEvent("onkeydown", doAlpha);
    </script>
</body>
</html>
