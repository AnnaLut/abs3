<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cash_settlement_services.aspx.cs" MaintainScrollPositionOnPostback="true" Inherits ="cash_settlement_services" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="bdc" %>
<%@ Register Src="/barsroot/UserControls/LabelTooltip.ascx" TagPrefix="uc" TagName="LabelTooltip" %>
<%@ Register Src="/barsroot/credit/usercontrols/TextBoxDate.ascx" TagPrefix="uc" TagName="TextBoxDate" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Черга повідомлень для синхронізаціх з ЕА</title>
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript">
        function ShowProgress() {
            var top = document.body.offsetHeight / 2 - 15;
            var left = document.body.offsetWidth / 2 - 50;

            var sImg = '<div style="position: absolute; top:' + top + '; background:white; left:' + left + '; width:101; height:33;" ></div>';
            oImg = document.createElement(sImg);
            oImg.innerHTML = '<img src=/Common/Images/process.gif>';

            document.body.insertAdjacentElement("beforeEnd", oImg);
        }
        function HideProgress() {
            document.body.removeChild(parent.oImg);
        }
    </script>
    <style type="text/css">
        .filter_cntr {
            padding-left: 9px;
            padding-right: 9px;
        }

        .gv_cntr {
        }

        actions_cntr {
            padding-left: 9px;
            padding-right: 9px;
        }

        .tbl {
        }

            .tbl .header {
                text-align: center;
                font-weight: bold;
            }

            .tbl .param_cntr {
                vertical-align: top;
                padding-left: 5px;
                padding-right: 5px;
            }

            .tbl .button_cntr {
                padding-top: 10px;
                text-align: right;
            }
        .auto-style1 {
            height: 75px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <ajx:ToolkitScriptManager ID="sm" runat="server" />

        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectSyncQueue" TypeName="Bars.SCS.VSmsAccSend"
            SortParameterName="SortExpression" EnablePaging="true" MaximumRowsParameterName="maximumRows"
            StartRowIndexParameterName="startRowIndex" OnSelecting="ods_Selecting">
           
        </asp:ObjectDataSource>

        <table border="0">
            <tr>
                <td class="filter_cntr">
                    <asp:Panel ID="pnlFilter" runat="server" GroupingText="Фільтр" Visible ="false">
                        <table border="0" class="tbl">
                            <tr>
                                <td class="header">
                                    <asp:Label ID="DatesTitle" runat="server" Text="Дата"></asp:Label>
                                </td>
                                <td class="header">
                                    <asp:Label ID="StatusTitle" runat="server" Text="Статус"></asp:Label>
                                </td>
                                <td class="header">
                                    <asp:Label ID="TypeTitle" runat="server" Text="Тип"></asp:Label>
                                </td>
                                <td class="header">
                                    <asp:Label ID="ObjIDTitle" runat="server" Text="Ід. об`єкту"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="param_cntr">
                                    <table border="0">
                                        <tr>
                                            <td>З:</td>
                                            <td>
                                                <uc:TextBoxDate runat="server" ID="tbFrom" IsRequired="true" ValidationGroup="Filter" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>По:</td>
                                            <td>
                                                <uc:TextBoxDate runat="server" ID="tbTo" IsRequired="true" ValidationGroup="Filter" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="param_cntr">
                                    <asp:ListBox ID="lbStatus" runat="server" Rows="4" SelectionMode="Multiple">
                                        <asp:ListItem Value="ERROR" Text="Помилка" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="OUTDATED" Text="Вичерпано час актуальності" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="NEW" Text="Нове"></asp:ListItem>
                                        <asp:ListItem Value="PROC" Text="Обробка"></asp:ListItem>
                                        <asp:ListItem Value="MSG_SEND" Text="Повідомлення відправлено"></asp:ListItem>
                                        <asp:ListItem Value="RSP_RECEIVED" Text="Відповідь отримано"></asp:ListItem>
                                        <asp:ListItem Value="RSP_PARSED" Text="Відповідь оброблено"></asp:ListItem>
                                        <asp:ListItem Value="DONE" Text="Виконано"></asp:ListItem>
                                    </asp:ListBox>
                                </td>
                                <td class="param_cntr">
                                    <asp:ListBox ID="lbType" runat="server" Rows="4" SelectionMode="Multiple">
                                        <asp:ListItem Value="DOC" Text="Надрукований документ" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="CLIENT" Text="Клієнт" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="UCLIENT" Text="Клієнт Юр.особа" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="ACC" Text="Рахунок Юр.особи" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="AGR" Text="Угода" Selected="True"></asp:ListItem>
										<asp:ListItem Value="UAGR" Text="Угода Юр.особи" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="ACT" Text="Актуалізація ідент. документів" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="DICT" Text="Довідник" Selected="True"></asp:ListItem>
                                    </asp:ListBox>
                                </td>
                                <td class="param_cntr">
                                    <asp:TextBox ID="tbObjID" runat="server" TextMode="MultiLine" Rows="4" ToolTip="Вказуються коди через ; без пробілів"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td class="gv_cntr">
                    <bdc:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False"
                        DataSourceID="ods" DataKeyNames="ACC"
                        AllowSorting="True" AllowPaging="True" PageSize="20" ShowFooter="True"
                        ShowExportExcelButton="True" CaptionText="" ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png" CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png" CssClass="barsGridView" DateMask="dd.MM.yyyy" EnableModelValidation="True" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png" FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png" HoverRowCssClass="hoverRow" MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png" MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png">
                        <NewRowStyle CssClass=""></NewRowStyle>
                        <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbSelect" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="NMK" HeaderText="Найменування клієнта" SortExpression="NMK" />
                            <asp:BoundField DataField="NLS" HeaderText="Номер рахунку" SortExpression="NLS"  />
                            <asp:BoundField DataField="PHONE" HeaderText="Номер телефону" SortExpression="PHONE" />
                            <asp:BoundField DataField="CNT" HeaderText="К-ть неоплачених СМС" SortExpression="CNT" />
                            <asp:BoundField DataField="ACC" HeaderText="Номер рахунку(АСС)" SortExpression="ACC" Visible ="false" />
                            <asp:BoundField DataField="ACC_CLEARANCE" HeaderText="Номер рахунку(АСС_CLEARANCE)" SortExpression="ACC_CLEARANCE" Visible ="false" />
                            <asp:BoundField DataField="NLS_CLEARANCE" HeaderText="Номер рахунку заборгованості" SortExpression="NLS_CLEARANCE" />
                            <asp:BoundField DataField="F_OST" HeaderText="  Залишок на рахунку 3570" SortExpression="F_OST" />
                            <asp:BoundField DataField="ACC_CLEARANCE_EXP" HeaderText="Номер рахунку прострочки(АСС_CLEARANCE_EXP)" SortExpression="ACC_CLEARANCE_EXP" Visible ="false" />
                            <asp:BoundField DataField="NLS_CLEARANCE_EXP" HeaderText="Номер рахунку простроченої заборгованості" SortExpression="NLS_CLEARANCE_EXP" />
                            <asp:BoundField DataField="F_OST_EXP" HeaderText="  Залишок на рахунку 3579" SortExpression="F_OST_EXP" />
                            <asp:BoundField DataField="OKPO" HeaderText="  ЄДРПОУ клієнта" SortExpression="OKPO" />
                            <asp:BoundField DataField="RNK" HeaderText="  РНК" SortExpression="RNK" />
                            <asp:BoundField DataField="KV" HeaderText="  Валюта" SortExpression="KV" />
                            <asp:BoundField DataField="NLS_PAY" HeaderText=" Рахунок списання" SortExpression="NLS_PAY" />
                        </Columns>
                        <EditRowStyle CssClass="editRow"></EditRowStyle>
                        <FooterStyle CssClass="footerRow"></FooterStyle>
                        <HeaderStyle CssClass="headerRow"></HeaderStyle>
                        <PagerStyle CssClass="pagerRow"></PagerStyle>
                        <RowStyle CssClass="normalRow"></RowStyle>
                        <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                    </bdc:BarsGridViewEx>
                </td>
            </tr>
            <tr>
                <td class="actions_cntr">
                    <asp:Panel ID="pnlActions" runat="server" GroupingText="Дії">
                        <table border="0" class="tbl">
                            <tr>
                                <td class="header">
                                    <asp:Label ID="lbObject2Apply" runat="server" Text="Застосувати до"></asp:Label>
                                </td>
                                <td class="header">
                                    <asp:Label ID="lbActionType" runat="server" Text="Дія"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="param_cntr" style="height: 89px">
                                    <table border="0">
                                        <tr>
                                            <td>
                                                <asp:RadioButtonList ID="rblObject2Apply" runat="server" AutoPostBack="true" Height="71px">
                                                    <asp:ListItem Value="ALL" Text="Всіх" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Value="SELECTED" Text="Відмічених"></asp:ListItem>
                                                   
                                                </asp:RadioButtonList>
                                            </td>
                                            <td style="vertical-align: bottom">
                                                &nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="param_cntr" style="height: 89px">
                                    <table border="0">
                                        <tr>
                                            <td class="auto-style1">
                                                <asp:RadioButtonList ID="rblAction" runat="server" Height="71px">
                                                    <asp:ListItem Value="CHARGE" Text="Нарахувати заборгованість 3570=>6110" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Value="PAY" Text="Оплатити заборгованість 2600=>3570"></asp:ListItem>
                                                    <asp:ListItem Value="TRANSFER" Text="Перенос на прострочку 3570=>3579"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="button_cntr" colspan="2">
                                    <asp:Button ID="btnApply" runat="server" Text="Виконати" OnClientClick="ShowProgress(); " OnClick="btnApply_Click" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
