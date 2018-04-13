<%@ Page Language="c#" CodeFile="SearchResults.aspx.cs" AutoEventWireup="true" Inherits="SearchResults" EnableViewState="True" Debug="False" %>

<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<%@ Register Src="../UserControls/loading.ascx" TagName="loading" TagPrefix="uc1" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Депозитний модуль: Пошук клієнта</title>
    <base target="_self" />
    <meta content="C#" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/ck.js"></script>
    <link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript">
        function AddListener4Enter() {
            AddListeners("textClientName,textClientCode,textClientDate,textClientNumber,textClientSerial,listSearchClient",
		    'onkeydown', TreatEnterAsTab);
        }
    </script>
    <script type="text/javascript" language="javascript">
        CrossAddEventListener(window, 'onload', AddListener4Enter);
    </script>
</head>
<body onload="CheckNFill();focusControl('textClientName');">
    <form id="Form1" method="post" runat="server">
        <ajax:ToolkitScriptManager ID="SM" runat="server" EnablePageMethods="true">
        </ajax:ToolkitScriptManager>
        <table id="MainTable" class="MainTable">
            <tr>
                <td>
                    <table id="InfoTable" class="InnerTable">
                        <tr>
                            <td width="30%">
                                <asp:Label CssClass="InfoText" ID="lbNMK" meta:resourcekey="lbNMK" runat="server">ФИО</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="textClientName" meta:resourcekey="textClientName2" CssClass="InfoText" runat="server" ToolTip="Имя клиента" MaxLength="35"
                                    TabIndex="1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbId" meta:resourcekey="lbId" CssClass="InfoText" runat="server">Идентификационный код</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="textClientCode" meta:resourcekey="textClientCode2" runat="server" CssClass="InfoText" ToolTip="Идентификационный код"
                                    MaxLength="10" TabIndex="2"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbBirthDate" meta:resourcekey="lbBirthDate2" CssClass="InfoText" runat="server">Дата рождения</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="textClientDate" runat="server" CssClass="InfoDate"
                                    ToolTip="Дата народження клієнта" TabIndex="3" />
                                <ajax:MaskedEditExtender ID="meeClientDate" runat="server"
                                    TargetControlID="textClientDate"
                                    Mask="99/99/9999"
                                    MaskType="Date"
                                    Century="2000"
                                    CultureName="en-GB"
                                    UserDateFormat="DayMonthYear"
                                    InputDirection="LeftToRight"
                                    OnFocusCssClass="MaskedEditFocus">
                                </ajax:MaskedEditExtender>
                                <asp:CompareValidator ID="DateValidator" runat="server"
                                    Type="Date"
                                    ControlToValidate="textClientDate"
                                    Operator="DataTypeCheck"
                                    ErrorMessage="Неправильний формат дати!" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbDocSerial" Text="Серия документа" meta:resourcekey="lbDocSerial2" CssClass="InfoText" runat="server">
                                </asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="textClientSerial" meta:resourcekey="textClientSerial" runat="server" CssClass="InfoText" ToolTip="Серия документа"
                                    MaxLength="10" TabIndex="4"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbDocNumber" meta:resourcekey="lbDocNumber2" CssClass="InfoText" runat="server">Номер документа</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="textClientNumber" meta:resourcekey="textClientNumber" runat="server" CssClass="InfoText" ToolTip="Номер документа"
                                    MaxLength="20" TabIndex="5"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="isPostBack" type="hidden" name="isPostBack" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Button ID="btSearch" meta:resourcekey="btSearch2" runat="server" Text="Поиск" TabIndex="6" CssClass="AcceptButton"></asp:Button>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lbTitle" meta:resourcekey="lbTitle3" runat="server" CssClass="InfoText">Выберите соответствующую запись из найденных</asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:DropDownList ID="listSearchClient" runat="server" CssClass="BaseDropDownList"
                        DataSource="<%# fClients %>" DataValueField="RNK" TabIndex="7">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <input runat="server" id="btSubmit" meta:resourcekey="btSubmit" onclick="SearchResultsExit()" type="button" value="Выбрать" tabindex="8"
                        class="AcceptButton" />
                </td>
            </tr>
        </table>
        <!-- #include virtual="/barsroot/deposit/Inc/DepositCk.inc"-->
        <!-- #include virtual="/barsroot/deposit/Inc/DepositJs.inc"-->
    </form>
    <script type="text/javascript" language="javascript">
        document.getElementById("textClientCode").attachEvent("onkeydown", doNum);
        document.getElementById("textClientNumber").attachEvent("onkeydown", doNum);
        document.getElementById("textClientName").attachEvent("onkeydown", doAlpha);
    </script>
</body>
</html>
