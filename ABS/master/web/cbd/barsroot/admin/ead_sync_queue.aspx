<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ead_sync_queue.aspx.cs" Inherits="admin_ead_sync_queue" MaintainScrollPositionOnPostback="true" %>

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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <ajx:ToolkitScriptManager ID="sm" runat="server" />

        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectSyncQueue" TypeName="Bars.EAD.VEadSyncQueue"
            SortParameterName="SortExpression" EnablePaging="true" MaximumRowsParameterName="maximumRows"
            StartRowIndexParameterName="startRowIndex" OnSelecting="ods_Selecting">
            <SelectParameters>
                <asp:Parameter Name="From" Direction="Input" Type="DateTime" />
                <asp:Parameter Name="To" Direction="Input" Type="DateTime" />
                <asp:Parameter Name="Status" Direction="Input" Type="Object" />
                <asp:Parameter Name="Type" Direction="Input" Type="Object" />
                <asp:Parameter Name="ObjID" Direction="Input" Type="Object" />
            </SelectParameters>
        </asp:ObjectDataSource>

        <table border="0">
            <tr>
                <td class="filter_cntr">
                    <asp:Panel ID="pnlFilter" runat="server" GroupingText="Фільтр">
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
                            <tr>
                                <td class="button_cntr" colspan="4">
                                    <asp:Button ID="btnFilter" runat="server" Text="Застосувати" CausesValidation="true" ValidationGroup="Filter" OnClick="btnFilter_Click" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td class="gv_cntr">
                    <bdc:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False"
                        DataSourceID="ods" DataKeyNames="SYNC_ID"
                        AllowSorting="True" AllowPaging="True" PageSize="20" ShowFooter="True"
                        ShowExportExcelButton="True" CaptionText="" ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png" CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png" CssClass="barsGridView" DateMask="dd.MM.yyyy" EnableModelValidation="True" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png" FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png" HoverRowCssClass="hoverRow" MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png" MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png" OnRowCommand="gv_RowCommand">
                        <NewRowStyle CssClass=""></NewRowStyle>
                        <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbSelect" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="SYNC_ID" HeaderText="№" SortExpression="SYNC_ID" />
                            <asp:BoundField DataField="CRT_DATE" HeaderText="Дата/час" SortExpression="CRT_DATE" DataFormatString="{0:dd.MM.yyyy HH:mm:ss}" />
                            <asp:BoundField DataField="TYPE_NAME" HeaderText="Тип" SortExpression="TYPE_NAME" />
                            <asp:BoundField DataField="OBJ_ID" HeaderText="Ід. об`єкту" SortExpression="OBJ_ID" />
                            <asp:TemplateField HeaderText="Статус" SortExpression="STATUS_NAME">
                                <ItemTemplate>
                                    <uc:LabelTooltip runat="server" ID="STATUS" Text='<%# Eval("STATUS_NAME") %>' ToolTip='<%# String.Format("{0} ({1})", Eval("STATUS_NAME"), Eval("STATUS_ID")) + ((String)Eval("STATUS_ID") == "ERROR" ? String.Format(" - {0} спроб(и) - Текст помилки: {1}", Eval("ERR_COUNT"), Eval("ERR_TEXT")) : "") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Текст помилки" SortExpression="ERR_TEXT">
                                <ItemTemplate>
                                    <uc:LabelTooltip runat="server" ID="ERR_TEXT" Text='<%# Eval("ERR_TEXT") %>' UseTextForTooltip="true" TextLength="40" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ERR_COUNT" HeaderText="ERR_COUNT" SortExpression="ERR_COUNT" />
                            <asp:BoundField DataField="MESSAGE_ID" HeaderText="№ повід." SortExpression="MESSAGE_ID" />
                            <asp:BoundField DataField="MESSAGE_DATE" HeaderText="Дата повід." SortExpression="MESSAGE_DATE" DataFormatString="{0:dd.MM.yyyy HH:mm:ss}" />
                            <asp:TemplateField HeaderText="Повід.">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbDLMessage" runat="server" Text="Завантажити" CommandName="DLMessage" CommandArgument='<%# Eval("SYNC_ID") %>'></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="RESPONCE_ID" HeaderText="№ відпов." SortExpression="RESPONCE_ID" />
                            <asp:BoundField DataField="RESPONCE_DATE" HeaderText="Дата відпов." SortExpression="RESPONCE_DATE" DataFormatString="{0:dd.MM.yyyy HH:mm:ss}" />
                            <asp:TemplateField HeaderText="Відпов.">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbDLResponce" runat="server" Text="Завантажити" CommandName="DLResponce" CommandArgument='<%# Eval("SYNC_ID") %>'></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
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
                                <td class="param_cntr">
                                    <table border="0">
                                        <tr>
                                            <td>
                                                <asp:RadioButtonList ID="rblObject2Apply" runat="server" OnSelectedIndexChanged="rblObject2Apply_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem Value="ALL" Text="Всіх" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Value="SELECTED" Text="Відмічених"></asp:ListItem>
                                                    <asp:ListItem Value="OLDER_THEN" Text="Старші за (тиж.)"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                            <td style="vertical-align: bottom">
                                                <asp:DropDownList ID="dlAgeWeeks" runat="server">
                                                    <asp:ListItem Value="1" Text="1" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Value="2" Text="2"></asp:ListItem>
                                                    <asp:ListItem Value="4" Text="4"></asp:ListItem>
                                                    <asp:ListItem Value="8" Text="8"></asp:ListItem>
                                                    <asp:ListItem Value="12" Text="12"></asp:ListItem>
                                                    <asp:ListItem Value="24" Text="24"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="param_cntr">
                                    <table border="0">
                                        <tr>
                                            <td>
                                                <asp:RadioButtonList ID="rblAction" runat="server">
                                                    <asp:ListItem Value="PROC" Text="Перезапустити" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Value="DEL" Text="Видалити"></asp:ListItem>
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
            <td class="button_cntr" colspan="2">
                                    <asp:Button ID="btnSyncDict" runat="server" Text="Виконати синхронізацію довідників" OnClientClick="ShowProgress(); " OnClick="btnSyncDict_Click" />
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
