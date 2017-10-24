<%@ Page Language="C#" AutoEventWireup="true" CodeFile="crkr_params.aspx.cs" Inherits="crkr_params" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Src="../credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer" TagPrefix="Bars" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <script src="../documentsview/Script.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Scripts/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery/jquery-ui.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery/jquery.bars.ui.js"></script>
    <script src="../documentsview/Script.js" type="text/javascript"></script>

    <%--    <script type="text/javascript">
       
    </script>--%>
</head>
<body bgcolor="#f0f0f0">
    <form id="formCrkrParams" runat="server" style="vertical-align: central">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:Panel ID="pnFilterType" runat="server" GroupingText="Налаштування:" Style="margin-left: 10px; margin-right: 10px">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lbParTypes" runat="server" Text="Вид"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlParTypes" runat="server" Width="250px" AutoPostBack="true" OnSelectedIndexChanged="ddlParTypes_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td>
                        <asp:Panel ID="pnParamsFilter" runat="server" GroupingText="Параметри пошуку:" Style="margin-left: 10px; margin-right: 10px">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbParams" runat="server" Text="Найменування"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlParams" runat="server" Width="380px"></asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbOnDate" runat="server" Text="На дату"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="deOnDate" runat="server" ReadOnly="True"></asp:TextBox>
                                        <bars:ImageTextButton ID="ShowCalendar" runat="server" ImageUrl="/common/images/default/16/calendar.png" OnClick="ShowCalendar_Click" Visible="true" ToolTip="Выбрать дату"/>
                                        <bars:ImageTextButton ID="ClearDate" runat="server" ImageUrl="/common/images/default/16/cancel_blue.png" OnClick="ClearDate_Click" Visible="true" ToolTip="Удалить дату"/>
                                        <asp:Calendar ID="Calendar1" runat="server" OnSelectionChanged="DateChange" style="position: absolute; background:white;"></asp:Calendar>
                                        <asp:Label ID="lbIsEnable" runat="server" Text="   Статус"></asp:Label>
                                        <asp:DropDownList ID="ddlIsEnable" runat="server" Width="100px">
                                            <asp:ListItem Text="" Value="" />
                                            <asp:ListItem Text="Діє" Value="1" />
                                            <asp:ListItem Text="Не діє" Value="0" />
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2">
                                        <bars:ImageTextButton ID="btFind" runat="server" ImageUrl="/common/images/default/16/find.png" Text="Пошук" OnClick='btFind_Click' Width="100px" Visible="true" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                    <td>
                        <asp:Panel ID="pnButtons" runat="server" GroupingText="" Style="margin-left: 10px; margin-right: 10px">
                            <table>
                                <tr>
                                    <td>
                                        <bars:ImageTextButton ID="tbAdd" runat="server" ImageUrl="/common/images/default/16/new.png" Text="Додати" ToolTip="Додати значення ліміту" Width="150px" OnClick="tbAdd_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <bars:ImageTextButton ID="btEdit" runat="server" ImageUrl="/common/images/default/16/edit.png" Text="Редагувати" ToolTip="Редагувати значення вибраного ліміту" Width="150px" OnClick="btEdit_Click" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
            <br />
            <BarsEX:BarsObjectDataSource ID="odsParams" runat="server" SelectMethod="SelectByParamType" SortParameterName="SortExpression"
                TypeName="Bars.CRKR.VCompenParamsData" DataObjectTypeName="Bars.CRKR.VCompenParamsData"
                OnSelecting="odsParams_Selecting">
                <SelectParameters>
                    <asp:Parameter DefaultValue="" Name="TYPE" Type="Decimal" />
                    <asp:Parameter DefaultValue="" Name="PAR" Type="String" />
                    <asp:Parameter DefaultValue="" Name="DAT" Type="String" />
                    <asp:Parameter DefaultValue="" Name="STATUS" Type="Decimal" />
                </SelectParameters>
            </BarsEX:BarsObjectDataSource>
            <div id="dvGridTitle" runat="server">
                <asp:Label ID="lbGvTitle" runat="server" Text="Ліміти" Font-Size="Medium" Style="margin-left: 10px; margin-right: 10px"></asp:Label>
            </div>
            <BarsEX:BarsGridViewEx ID="gvParams" runat="server" PagerSettings-PageButtonCount="100" DataSourceID="odsParams"
                PageSize="20" AllowPaging="True" AllowSorting="True" 
                CssClass="barsGridView" DateMask="dd/MM/yyyy" DataKeyNames="ID,IS_ENABLE"
                JavascriptSelectionType="SingleRow" AutoGenerateColumns="false" CaptionType="Cool"
                ShowPageSizeBox="false" EnableViewState="true" OnRowDataBound="gvParams_RowDataBound"
                AutoSelectFirstRow="false"
                HoverRowCssClass="headerRow"
                RefreshImageUrl="/common/images/default/16/refresh.png"
                ExcelImageUrl="/common/images/default/16/export_excel.png"
                FilterImageUrl="/common/images/default/16/filter.png">
                <AlternatingRowStyle CssClass="alternateRow" />
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="№ п/п" ItemStyle-HorizontalAlign="Right" SortExpression="ID"></asp:BoundField>
                    <asp:BoundField DataField="DISCRIPTION" HeaderText="Назва ліміту" ItemStyle-HorizontalAlign="Left" SortExpression="DISCRIPTION"></asp:BoundField>
                    <asp:BoundField DataField="VAL" HeaderText="Значення" ItemStyle-HorizontalAlign="Right" SortExpression="VAL"></asp:BoundField>
                    <asp:TemplateField HeaderText="Статус" SortExpression="IS_ENABLE" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lbEbanle" runat="server" Text='<%# String.Format("{0}", (Eval("IS_ENABLE").ToString() == "0" ? "Не діє" : "Діє")) %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ENABLE_DATES" HeaderText="Період дії" ItemStyle-HorizontalAlign="Center" SortExpression="DATE_FROM"></asp:BoundField>
                </Columns>
                <FooterStyle CssClass="footerRow" />
                <HeaderStyle CssClass="headerRow" />
                <EditRowStyle CssClass="editRow" />
                <PagerStyle CssClass="pagerRow" />
                <SelectedRowStyle CssClass="selectedRow" />
                <AlternatingRowStyle CssClass="alternateRow" />
                <PagerSettings Mode="Numeric"></PagerSettings>
                <RowStyle CssClass="normalRow" />
                <NewRowStyle CssClass="newRow" />
            </BarsEX:BarsGridViewEx>
        </asp:Panel>
    </form>
</body>
</html>