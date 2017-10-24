﻿<%@ Page Language="c#" CodeFile="filter.aspx.cs" AutoEventWireup="false" Inherits="Bars.WebServices.Filter" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Фильтр</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="C#" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="Style.css" type="text/css" rel="stylesheet">
    <script type="text/javascript" language="jscript" src="Script.js?v1.3"></script>
    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
    <base target="_self" />
</head>
<body onkeydown="KeyDown()" bgcolor="#f0f0f0" scroll="yes">
    <form id="Form1" method="post" runat="server">
        <table cellspacing="1" cellpadding="1" width="605" border="0">
            <tr>
                <td>
                    <input class="btinset" runat="server" id="btSysFilter" meta:resourcekey="btSysFilter" onclick="Switch(1)" type="button" value="Системный">
                    <input class="btoutset" runat="server" id="btUserFilter" meta:resourcekey="btUserFilter" onclick="Switch(2)" type="button" value="Пользовательский">
                    <input class="btoutset" runat="server" id="btCustomFilter" meta:resourcekey="btCustomFilter" onclick="Switch(3)" type="button" value="Новый">
                </td>
            </tr>
            <tr>
                <td>
                    <div class="frame" id="pSys">
                        <div style="overflow: auto; height: 320px">
                            <asp:DataGrid ID="dgSys" runat="server" AutoGenerateColumns="False" Width="100%" CellPadding="2"
                                BackColor="White" BorderWidth="1px" BorderStyle="None" BorderColor="Black">
                                <SelectedItemStyle Font-Bold="True" ForeColor="#CCFF99" BackColor="#009999"></SelectedItemStyle>
                                <ItemStyle Font-Size="8pt" Font-Names="Microsoft Sans Serif" Font-Bold="True" ForeColor="Black"
                                    BackColor="White"></ItemStyle>
                                <HeaderStyle Font-Size="8pt" Font-Names="Verdana" Font-Bold="True" HorizontalAlign="Center" ForeColor="White"
                                    BackColor="DimGray"></HeaderStyle>
                                <FooterStyle Font-Names="Verdana" ForeColor="#003399" BackColor="#99CCCC"></FooterStyle>
                                <Columns>
                                    <asp:BoundColumn DataField="ID" HeaderText="Код фильтра">
                                        <HeaderStyle Width="90px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="Name" HeaderText="Наименование"></asp:BoundColumn>
                                </Columns>
                                <PagerStyle HorizontalAlign="Left" ForeColor="#003399" BackColor="#99CCCC" Mode="NumericPages"></PagerStyle>
                            </asp:DataGrid>
                        </div>
                    </div>
                    <div class="frame" id="pUser">
                        <div>
                            <img runat="server" meta:resourcekey="im1" class="outset" alt="Удалить фильтр" onclick="DelUserFilter()" height="16" src="/Common/Images/delete.gif">
                            <img runat="server" meta:resourcekey="im2" class="outset" alt="Посмотреть значение фильтра" onclick="ShowUserFilter()" height="16"
                                src="/Common/Images/Edit.gif">
                        </div>
                        <div style="overflow: auto; height: 294px">
                            <asp:DataGrid ID="dgUser" runat="server" AutoGenerateColumns="False" Width="100%" CellPadding="2"
                                BackColor="White" BorderWidth="1px" BorderStyle="None" BorderColor="Black">
                                <SelectedItemStyle Font-Bold="True" ForeColor="#CCFF99" BackColor="#009999"></SelectedItemStyle>
                                <ItemStyle Font-Size="8pt" Font-Names="Microsoft Sans Serif" Font-Bold="True" ForeColor="Black"
                                    BackColor="White"></ItemStyle>
                                <HeaderStyle Font-Size="8pt" Font-Names="Verdana" Font-Bold="True" HorizontalAlign="Center" ForeColor="White"
                                    BackColor="DimGray"></HeaderStyle>
                                <FooterStyle Font-Names="Verdana" ForeColor="#003399" BackColor="#99CCCC"></FooterStyle>
                                <Columns>
                                    <asp:TemplateColumn>
                                        <ItemTemplate>
                                            <input type="checkbox" />
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:BoundColumn DataField="ID" HeaderText="Код фильтра">
                                        <HeaderStyle Width="90px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="Name" HeaderText="Наименование"></asp:BoundColumn>
                                    <asp:BoundColumn Visible="False" DataField="WHERE_CLAUSE"></asp:BoundColumn>
                                </Columns>
                                <PagerStyle HorizontalAlign="Left" ForeColor="#003399" BackColor="#99CCCC" Mode="NumericPages"></PagerStyle>
                            </asp:DataGrid>
                        </div>
                    </div>
                    <div class="frame" id="pCustom">
                        <img runat="server" meta:resourcekey="im8" class="outset" onclick="AddRowPos()" height="16" src="/Common/Images/arrow_up.gif" alt="Вставить строку фильтра">
                        <img runat="server" meta:resourcekey="im3" class="outset" onclick="AddRow()" height="16" src="/Common/Images/INSERT.gif" alt="Добавить строку фильтра">
                        <img runat="server" meta:resourcekey="im4" class="outset" onclick="DelRow()" height="16" src="/Common/Images/grid_delete.gif" alt="Удалить строку фильтра">
                        <img runat="server" meta:resourcekey="im5" class="outset" onclick="DelAllRow()" height="16"
                            src="/Common/Images/delete.gif" alt="Удалить все строки фильтра">
                        &nbsp;&nbsp;<img runat="server" meta:resourcekey="im6" class="outset" onclick="CheckFilter()"
                            height="16" src="/Common/Images/CHEKIN.gif" alt="Проверить синтаксис сформированого фильтра">
                        <img runat="server" meta:resourcekey="im7" class="outset" onclick="SaveFilter()"
                            height="16" src="/Common/Images/SAVE.gif" width="16" alt="Сохранить сформированый фильтр в БД">
                        &nbsp;&nbsp;&nbsp;<asp:ImageButton ID="btnRefresh" runat="server"
                            Height="18px" ImageUrl="/Common/Images/REFRESH.gif" Width="18px" BorderStyle="Outset" BorderWidth="3px" OnClick="btnRefresh_Click" ToolTip="Оновити" />
                        <select id="op" onblur="Set(this)" style="font-weight: bold; visibility: hidden; position: absolute">
                            <option value="1">И</option>
                            <option value="2">ИЛИ</option>
                            <option value="3">(</option>
                            <option value="4">)</option>
                            <option value="5">&nbsp;</option>
                        </select>
                        <select id="attr" onblur="Set(this)" style="font-weight: bold; visibility: hidden; position: absolute"
                            runat="server">
                        </select>
                        <select id="sign" onblur="Set(this)" style="font-weight: bold; visibility: hidden; position: absolute">
                            <option value="1">=</option>
                            <option value="2">&lt;</option>
                            <option value="3">&lt;=</option>
                            <option value="4">&gt;</option>
                            <option value="5">&gt;=</option>
                            <option value="6">&lt;&gt;</option>
                            <option value="7">похож</option>
                            <option value="8">не похож</option>
                            <option value="9">пустой</option>
                            <option value="10">не пустой</option>
                            <option value="11">один из</option>
                            <option value="12">ни один из</option>
                            <option value="13" selected></option>
                        </select>
                        <input id="val" onblur="Set(this)" style="font-weight: bold; visibility: hidden; position: absolute"
                            type="text">
                        <table id="dgCust" style="font-size: 8pt; border-left-color: black; border-bottom-color: black; width: 100%; border-top-color: black; font-family: Verdana; border-collapse: collapse; background-color: white; border-right-color: black"
                            bordercolor="black" cellspacing="0" cellpadding="3" border="1">
                            <tr style="font-weight: bold; font-size: 8pt; color: white; font-family: Verdana; background-color: gray"
                                align="center">
                                <td meta:resourcekey="td1" runat="server" width="10">И\ИЛИ</td>
                                <td meta:resourcekey="td2" runat="server" width="250">Атрибут</td>
                                <td meta:resourcekey="td3" runat="server" width="150">Оператор</td>
                                <td meta:resourcekey="td4" runat="server" width="200">Значение</td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td valign="bottom" align="right" height="380">
                    <input class="bt" runat="server" id="btOk" meta:resourcekey="btOk" style="color: green" onclick="Apply()" type="button" value="Применить">&nbsp;
						<input class="bt" runat="server" id="bt" meta:resourcekey="bt" style="color: red" onclick="Cancel()" type="button" value="Отменить">
                </td>
            </tr>
        </table>
        <input id="sysIs" type="hidden" runat="server"><input id="usrIs" type="hidden" runat="server"><input id="TID" type="hidden" runat="server">
        <div class="webservice" id="webService" showprogress="true"></div>
        <input type="hidden" runat="server" id="Mes1" meta:resourcekey="Mes1" value="Пропущена ЗАКРЫВАЮЩАЯ скобка" />
        <input type="hidden" runat="server" id="Mes2" meta:resourcekey="Mes2" value="Пропущена ОТКРЫВАЮЩАЯ скобка" />
        <input type="hidden" runat="server" id="Mes3" meta:resourcekey="Mes3" value="Недопустимое выражение после оператора сравнения" />
        <input type="hidden" runat="server" id="Mes4" meta:resourcekey="Mes4" value="Недопустимое выражение после оператора" />
        <input type="hidden" runat="server" id="Mes5" meta:resourcekey="Mes5" value="Недопустимое выражение после логического оператора" />
        <input type="hidden" runat="server" id="Mes6" meta:resourcekey="Mes6" value="Недопустимое начало логического выражения фильтра" />
        <input type="hidden" runat="server" id="Mes7" meta:resourcekey="Mes7" value="Недопустимое выражение после открывающей скобки" />
        <input type="hidden" runat="server" id="Mes8" meta:resourcekey="Mes8" value="Недопустимое выражение после закрывающей скобки" />
        <input type="hidden" runat="server" id="Mes9" meta:resourcekey="Mes9" value="Недопустимое выражение после атрибута или значения" />
        <input type="hidden" runat="server" id="Mes10" meta:resourcekey="Mes10" value="Сохранить текущий фильтр с именем" />
        <input type="hidden" runat="server" id="Mes11" meta:resourcekey="Mes11" value="Изменения успешно сохранены!" />
        <input type="hidden" runat="server" id="Title" meta:resourcekey="Title" value="Изменения успешно сохранены!" />
        <input type="hidden" runat="server" id="OpAND" meta:resourcekey="OpAND" value="И" />
        <input type="hidden" runat="server" id="OpOR" meta:resourcekey="OpOR" value="ИЛИ" />
        <input type="hidden" runat="server" id="Sign1" meta:resourcekey="Sign1" value="похож" />
        <input type="hidden" runat="server" id="Sign2" meta:resourcekey="Sign2" value="не похож" />
        <input type="hidden" runat="server" id="Sign3" meta:resourcekey="Sign3" value="пустой" />
        <input type="hidden" runat="server" id="Sign4" meta:resourcekey="Sign4" value="не пустой" />
        <input type="hidden" runat="server" id="Sign5" meta:resourcekey="Sign5" value="один из" />
        <input type="hidden" runat="server" id="Sign6" meta:resourcekey="Sign6" value="ни один из" />
        <script language="javascript">
            window.document.title = window.document.all.Title.value;
        </script>
    </form>
</body>
</html>
