<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>

<%@ Page Language="c#" Inherits="BarsWeb.DocumentsView._default" EnableViewState="False"
    EnableViewStateMac="False" CodeFile="default.aspx.cs" Culture="UK-ua" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Просмотр документов</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="C#" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="defaultCSS.css" type="text/css" rel="stylesheet">
    <script language="javascript">
        function Link2DocList(evt, lnk) {
            var redir_href = document.getElementById(lnk).href
				+ "&dateb=" + document.getElementById("dateBegin_t").value
                + "&datef=" + document.getElementById("dateFinish_t").value;
            window.location.replace(redir_href);
        }
    </script>
</head>
<body bottommargin="0" leftmargin="0" topmargin="3" rightmargin="0">
    <form id="Form1" method="post" runat="server">
    <table id="tb_border" height="100%" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td height="50">
            </td>
            <td height="50">
                <div id="lb_headerUser" meta:resourcekey="lb_headerUser" style="display: inline;
                    font-weight: bold; font-size: 10pt; width: 100%; font-family: Arial" align="center"
                    runat="server">
                    Документы пользователя</div>
                <div id="lb_headerBranch" meta:resourcekey="lb_headerBranch" style="display: inline;
                    font-weight: bold; font-size: 10pt; width: 100%; font-family: Arial" align="center"
                    runat="server">
                    Документы отделения</div>
                <div id="lb_headerSaldo" meta:resourcekey="lb_headerSaldo" style="display: inline;
                    font-weight: bold; font-size: 10pt; width: 100%; font-family: Arial" align="center"
                    runat="server">
                    Документы по доступным счетам</div>
            </td>
            <td height="50">
            </td>
        </tr>
        <tr>
            <td style="height: 377px">
            </td>
            <td style="padding-top: 50px; height: 377px" valign="top" align="center">
                <table cellspacing="0" cellpadding="0" width="100" border="0">
                    <tr>
                        <td>
                            <asp:Panel ID="pnInfo" runat="server" Width="220px" Height="162px" BorderStyle="Ridge">
                                <table id="Table1" height="100%" cellspacing="1" cellpadding="1" width="100%" border="0">
                                    <tr>
                                        <td style="height: 46px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="mainCellStyle" style="height: 54px" align="center">
                                            <span runat="server" meta:resourcekey="dvSp">Введенные за</span>&nbsp;
                                            <div class="mainTextStyle" id="lb_docdate" style="display: inline; font-weight: bold;
                                                color: green" runat="server">
                                                date
                                            </div>
                                            &nbsp; <span style="color: red">*</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="mainCellStyle" valign="middle" align="center">
                                            <table id="tabledat" cellspacing="0" cellpadding="0" align="center" border="0">
                                                <tr>
                                                    <td class="minorCellStyle" nowrap runat="server" >
                                                        з &nbsp;
                                                    </td>
                                                    <td class="minorCellStyle" width="1">
                                                        <igtxt:WebDateTimeEdit ID="dateBegin" TabIndex="3" runat="server" EditModeFormat="dd.MM.yyyy"
                                                            DisplayModeFormat="dd.MM.yyyy" Fields="2005-1-1-0-0-0-0" HorizontalAlign="Center"
                                                            HideEnterKey="True" EnableViewState="False">
                                                        </igtxt:WebDateTimeEdit>
                                                    </td>
                                                    <td class="minorCellStyle">
                                                        <asp:ImageButton ID="imgShowCalendar" meta:resourcekey="imgShowCalendar" runat="server"
                                                            ImageUrl="/Common/Images/cmbDown.gif" ToolTip="Выбрать дату из календаря" onclick="imgShowCalendar_Click" 
                                                            ></asp:ImageButton>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="minorCellStyle" nowrap runat="server" >
                                                        по &nbsp;
                                                    </td>
                                                    <td class="minorCellStyle" width="1">
                                                        <igtxt:WebDateTimeEdit ID="dateFinish" TabIndex="4" runat="server" EditModeFormat="dd.MM.yyyy"
                                                            DisplayModeFormat="dd.MM.yyyy" Fields="2005-1-1-0-0-0-0" HorizontalAlign="Center"
                                                            HideEnterKey="True" EnableViewState="False">
                                                        </igtxt:WebDateTimeEdit>
                                                    </td>
                                                    <td class="minorCellStyle">
                                                        <asp:ImageButton ID="imgShowCalendar2" meta:resourcekey="imgShowCalendar" runat="server"
                                                            ImageUrl="/Common/Images/cmbDown.gif" ToolTip="Выбрать дату из календаря" 
                                                            onclick="imgShowCalendar2_Click"></asp:ImageButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                        <td>
                            <asp:Panel ID="pnAllDocs" runat="server" Width="180px" Height="162px" BorderStyle="Ridge">
                                <table id="Table2" height="100%" cellspacing="1" cellpadding="1" width="100%" border="0">
                                    <tr>
                                        <td style="height: 46px" align="center">
                                            <asp:Label ID="lbAllDocs" meta:resourcekey="lbAllDocs" runat="server" Font-Names="Verdana"
                                                Font-Size="10pt" ForeColor="Maroon">Все документы</asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="mainCellStyle" style="height: 54px" align="center">
                                            <a id="lnk_showAll" meta:resourcekey="lnk_showAll" tabindex="1" href="#" runat="server">
                                                Показать</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="mainCellStyle" align="center">
                                            <div id="div_showAllalldat" meta:resourcekey="div_showAllalldat" runat="server" style="cursor: hand;
                                                color: blue; text-decoration: underline" onclick="Link2DocList(event,'lnk_showAllalldat');"
                                                tabindex="4">
                                                Показать</div>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                        <td>
                            <asp:Panel ID="pnRecDocs" runat="server" Width="180px" Height="162px" BorderStyle="Ridge">
                                <table id="Table3" height="100%" cellspacing="1" cellpadding="1" width="100%" border="0">
                                    <tr>
                                        <td style="height: 46px" nowrap align="center">
                                            <asp:Label ID="lbRecDocs" meta:resourcekey="lbRecDocs" runat="server" Font-Names="Verdana"
                                                Font-Size="10pt" ForeColor="Green">Полученные документы</asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="mainCellStyle" align="center">
                                            <a id="lnk_showAllRes" meta:resourcekey="lnk_showAll" tabindex="2" href="#" runat="server">
                                                Показать</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="mainCellStyle" align="center">
                                            <div id="div_showAllResalldat" meta:resourcekey="div_showAllalldat" runat="server"
                                                style="cursor: hand; color: blue; text-decoration: underline" onclick="Link2DocList(event, 'lnk_showAllResalldat');"
                                                tabindex="5">
                                                Показать</div>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
                <table id="auxinfo" cellspacing="0" cellpadding="0" align="center" border="0">
                    <tr>
                        <td runat="server" meta:resourcekey="dvUseDate" style="font-size: 10pt; color: red;
                            font-family: Arial" valign="middle" align="left" height="50">
                            * - используется системная дата ввода сервера
                        </td>
                    </tr>
                </table>
                <asp:Calendar ID="Calendar" runat="server" Width="220px" Height="200px" Font-Names="Verdana"
                    Font-Size="8pt" ForeColor="#663399" BorderWidth="1px" BackColor="#FFFFCC" DayNameFormat="FirstLetter"
                    BorderColor="#FFCC66" ShowGridLines="True" OnSelectionChanged="Calendar_SelectionChanged">
                    <TodayDayStyle ForeColor="White" BackColor="#FFCC66"></TodayDayStyle>
                    <SelectorStyle BackColor="#FFCC66"></SelectorStyle>
                    <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC"></NextPrevStyle>
                    <DayHeaderStyle Height="1px" BackColor="#FFCC66"></DayHeaderStyle>
                    <SelectedDayStyle Font-Bold="True" BackColor="#CCCCFF"></SelectedDayStyle>
                    <TitleStyle Font-Size="9pt" Font-Bold="True" ForeColor="#FFFFCC" BackColor="#990000">
                    </TitleStyle>
                    <OtherMonthDayStyle ForeColor="#CC9966"></OtherMonthDayStyle>
                </asp:Calendar>
            </td>
            <td style="height: 377px">
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td style="padding-top: 50px" valign="top">
                <p>
                    &nbsp;</p>
                <p>
                    <a id="lnk_showAllalldat" meta:resourcekey="lnk_showAllalldat" style="visibility: hidden"
                        href="#" runat="server">Показать все документы начиная с даты</a><br>
                    <a id="lnk_showAllResalldat" meta:resourcekey="lnk_showAllResalldat" style="visibility: hidden"
                        href="#" runat="server">Показать все полученные документы начиная с даты</a>
                </p>
            </td>
            <td>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
