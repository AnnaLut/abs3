<%@ Page Language="c#" CodeFile="SearchResults.aspx.cs" AutoEventWireup="true" Inherits="SearchResults" EnableViewState="True" Debug="False" %>

<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<%@ Register Src="~/UserControls/loading.ascx" TagName="loading" TagPrefix="uc1" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Депозитний модуль: Пошук клієнта</title>
    <base target="_self" />
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="C#" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js?v1.5"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/ck.js?v1.2"></script>
    <link href="style/dpt.css" type="text/css" rel="stylesheet" />
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
        <ajax:ToolkitScriptManager ID="SM" runat="server" EnablePageMethods="true" EnablePartialRendering="true" >
        </ajax:ToolkitScriptManager>
        <asp:UpdatePanel ID="uPanel" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
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
                                        <ajax:maskededitextender id="meeClientDate" runat="server"
                                            targetcontrolid="textClientDate"
                                            mask="99/99/9999"
                                            masktype="Date"
                                            century="2000"
                                            culturename="en-GB"
                                            userdateformat="DayMonthYear"
                                            inputdirection="LeftToRight"
                                            onfocuscssclass="MaskedEditFocus" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbDocSerial" meta:resourcekey="lbDocSerial2" CssClass="InfoText" runat="server">Серия документа</asp:Label>
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
                            <asp:Button ID="btSearch" meta:resourcekey="btSearch2" runat="server" Text="Поиск" TabIndex="6" 
                                ValidationGroup="FIND" CausesValidation="true" CssClass="AcceptButton"></asp:Button>
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
                                DataSource="<%# fClients %>" DataValueField="RNK" TabIndex="7" Width="600px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <input runat="server" id="btSubmit" meta:resourcekey="btSubmit" onclick="SearchResultsExit()" type="button" value="Выбрать" tabindex="8"
                                class="AcceptButton" causesvalidation="false" />
                        </td>
                    </tr>
                </table>
                <asp:UpdateProgress ID="updateProgressBars" runat="server" AssociatedUpdatePanelID="uPanel">
                    <ProgressTemplate>
                        <uc1:loading ID="sync_loading" runat="server" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </ContentTemplate>
        </asp:UpdatePanel>
        <!-- #include virtual="Inc/DepositCk.inc"-->
        <!-- #include virtual="Inc/DepositJs.inc"-->
    </form>
    <script type="text/javascript" language="javascript">
        document.getElementById("textClientCode").attachEvent("onkeydown", doNum);
        document.getElementById("textClientNumber").attachEvent("onkeydown", doNum);
        document.getElementById("textClientName").attachEvent("onkeydown", doAlpha);
    </script>
</body>
</html>
