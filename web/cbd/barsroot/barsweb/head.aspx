<%@ Page Language="c#" Inherits="bars.web.head" SmartNavigation="False" EnableViewState="True"
    CodeFile="head.aspx.cs" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Титульная часть</title>
    <script language="javascript" src="/Common/Script/Localization.js" type="text/jscript"></script>
    <script language="JavaScript" src="head.js" type="text/jscript"></script>
    <link href="head.css" type="text/css" rel="stylesheet" />
</head>
<body class="headBody">
    <form id="HeaderForm" method="post" runat="server">
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td>
                <div>
                    <img alt="www.unity-bars.com.ua" id="imgCompanyLogo" runat="server" src="images/companylogo.jpg"
                        onclick="window.open('http://www.unity-bars.com.ua');" />
                </div>
            </td>
            <td valign="middle" width="100%">
                <table cellspacing="0" cellpadding="0" border="0" width="100%">
                    <tr>
                        <td style="width: 20px">
                        </td>
                        <td valign="middle" align="left">
                            <div style="white-space: nowrap">
                                <asp:Label ID="ed_Tobo" CssClass="headTextbox" Width="100%" runat="server" />
                                <img id="imgTobo" alt="Изменить отделение" style="border-right: black 1px solid;
                                    border-top: black 1px solid; border-bottom: black 1px solid" onclick="ChangeTobo()"
                                    src="/Common/Images/cmbDown.gif" width="16" align="middle" runat="server" visible="false" />
                            </div>
                        </td>
                        <td align="center" class="headTextbox" rowspan="2" style="font-size: 12pt;" runat="server" id="tdProductTitle">
                            Автоматизоване робоче місце спеціаліста<br/>фронт-офісу ВАТ "Ощадбанк"
                        </td>
                        <td align="right" nowrap="nowrap" width="30%">
                            <div id="P1" meta:resourcekey="lbBankDate" runat="server" class="headTitle" nowrap="nowrap">
                            </div>
                            <asp:TextBox ID="textBankDate" Width="80px" meta:resourcekey="textBankDate" runat="server"
                                CssClass="headTextbox" Style="text-align: center" Font-Bold="true" ReadOnly="True"
                                ToolTip="Банковская дата"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 20px">
                        </td>
                        <td style="white-space: nowrap">
                            <asp:Label ID="textLogin" CssClass="headTextBox" meta:resourcekey="textLogin" runat="server"
                                EnableViewState="False" ToolTip="Имя пользователя" Width="90%"></asp:Label>
                        </td>
                        <td align="right">
                            <div style="font-family: Arial; color: #1C4B75; font-size: 8pt; margin-right: 10px;"
                                nowrap="nowrap">
                                &nbsp;Сервер:&nbsp;<%=Server.MachineName%>(<%=Request.ServerVariables["LOCAL_ADDR"]%>),
                                DB:&nbsp;<%=Bars.Configuration.ConfigurationSettings.AppSettings["DBConnect.DataSource"]%>
                            </div>
                        </td>
                    </tr>
                </table>
                <table id="T" cellspacing="0" cellpadding="0" border="0" width="100%">
                    <tr>
                        <td style="width: 20px">
                        </td>
                        <td style="white-space: nowrap; text-align: left">
                            <a href="#" style="font-family: Arial; font-size: 8pt;" onclick="parent.frames.main.location.replace('/barsroot/barsweb/welcome.aspx');"
                                title="Перейти на дошку об`яв">Дошка об`яв</a>
                        </td>
                        <td runat="server" style="white-space: nowrap; text-align: center" id="tdUserBranches"
                            visible="false">
                            <asp:Label ID="lbUserBranches" CssClass="headTitle" runat="server" Text="Поточне відділення:"> </asp:Label>
                            <asp:DropDownList ID="ddUserBranches" runat="server" AutoPostBack="true" DataTextField="NAME"
                                DataValueField="BRANCH" OnSelectedIndexChanged="ddUserBranches_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                        <td valign="top" align="right" width="10%" nowrap="nowrap">
                            <asp:PlaceHolder ID="ToolBar" runat="server" EnableViewState="False"></asp:PlaceHolder>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <asp:LinkButton meta:resourcekey="lnExitSystem" ID="lnExitSystem" runat="server"
                    Font-Names="Verdana" Font-Size="8pt" Text="Вийти" OnClick="lnExitSystem_Click"
                    OnClientClick="return confirm('Ви дійсно хочете вийти?');" />
                <img title="Возврат на уровень назад" style="cursor: hand; margin-top: 5px;" onclick="goBack()"
                    src="/Common/Images/goBack.gif" width="32" id="imgBack" runat="server">
            </td>
        </tr>
        <tr>
            <td colspan="4" class="mainGradient">
                <div>
                    <img id="imgHSMenu" title="Спрятать меню приложений" style="cursor: hand; margin-left: 10px;"
                        onclick="toggleFrame()" src="images/hide_menu.gif"></div>
            </td>
        </tr>
    </table>
    </form>
    <div style="display: none">
        <input id="forimgHSLogo" meta:resourcekey="forimgHSLogo" runat="server" type="hidden"
            value="Спрятать логотип" />
        <input id="forimgHSMenu" meta:resourcekey="forimgHSMenu" runat="server" type="hidden"
            value="Спрятать меню приложений" />
        <input id="forlnkBack" meta:resourcekey="forlnkBack" runat="server" type="hidden"
            value="Возврат на уровень назад" />
        <input id="forimgBack" meta:resourcekey="forimgBack" runat="server" type="hidden"
            value="Возврат на уровень назад" />
        <input id="fored_Tobo" meta:resourcekey="fored_Tobo" runat="server" type="hidden"
            value="Отделение" />
        <input id="Mes1" meta:resourcekey="Mes1" runat="server" type="hidden" value="Банковская дата изменена!" />
        <input id="Mes2" meta:resourcekey="Mes2" runat="server" type="hidden" value="Старая дата:" />
        <input id="Mes3" meta:resourcekey="Mes3" runat="server" type="hidden" value="Новая дата:" />
        <input id="Mes4" meta:resourcekey="Mes4" runat="server" type="hidden" value="Спрятать меню приложений" />
        <input id="Mes5" meta:resourcekey="Mes5" runat="server" type="hidden" value="Показать меню приложений" />
        <input id="Mes6" meta:resourcekey="Mes6" runat="server" type="hidden" value="Спрятать логотип" />
        <input id="Mes7" meta:resourcekey="Mes7" runat="server" type="hidden" value="Показать логотип" />
        <input id="Mes8" meta:resourcekey="Mes8" runat="server" type="hidden" value="Произошло изменение остатка счетов:" />
        <input id="Mes9" meta:resourcekey="Mes9" runat="server" type="hidden" value="Счет" />
        <input id="Mes10" meta:resourcekey="Mes10" runat="server" type="hidden" value="Присутствуют незавизированные документы на контроле." />
        <input id="Mes11" meta:resourcekey="Mes11" runat="server" type="hidden" value="Присутствуют неподписанные проводки для экспорта. Подписать?" />
        <input id="Mes12" meta:resourcekey="Mes12" runat="server" type="hidden" value="Текущая банковская дата недоступна." />
        <input id="EDocsActive" runat="server" type="hidden" />
        <input id="EDocsTimeOut" runat="server" type="hidden" />
        <input id="hCustomAuthentication" runat="server" type="hidden" />
        <input id="hCookieName" runat="server" type="hidden" />
        <div class="webservice" id="webService">
        </div>
        <div id="global_obj">
        </div>
    </div>
</body>
</html>
