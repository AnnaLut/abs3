<%@ Page Title="Тарифи" Language="C#"
    AutoEventWireup="true" CodeFile="tariffs.aspx.cs" Inherits="ins_tariffs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="../credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString"
    TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="Bars" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title title="Обмеження на тарифи"></title>
    <base target="_self" />
    <link href="/barsroot/ins/ins.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <ajx:ToolkitScriptManager ID="sm" runat="server">
            <Scripts>
                <asp:ScriptReference Path="/barsroot/credit/JScript/JScript.js?v1" />
            </Scripts>
        </ajx:ToolkitScriptManager>
        <div class="content_container" style="width: 100%; text-align: center">
            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                <tr>
                    <td>
                        <bars:BarsObjectDataSource ID="ods" runat="server" SelectMethod="SelectTariffs" TypeName="Bars.Ins.VInsTariffs">
                        </bars:BarsObjectDataSource>
                        <asp:ListView ID="lv" runat="server" DataKeyNames="TARIFF_ID" DataSourceID="ods"
                            OnItemInserting="lv_ItemInserting" OnItemUpdating="lv_ItemUpdating" OnItemDeleting="lv_ItemDeleting">
                            <LayoutTemplate>
                                <table class="tbl_style1" width="650px">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>
                                                <asp:Label ID="TARIFF_ID" runat="server" Text="Ід." />
                                            </th>
                                            <th>
                                                <asp:Label ID="NAME" runat="server" Text="Найменування" />
                                            </th>
                                            <th>
                                                <asp:Label ID="MIN_VALUE" runat="server" Text="Мін. значення" />
                                            </th>
                                            <th>
                                                <asp:Label ID="MIN_PERC" runat="server" Text="Мін. %" />
                                            </th>
                                            <th>
                                                <asp:Label ID="MAX_VALUE" runat="server" Text="Макс. значення" />
                                            </th>
                                            <th>
                                                <asp:Label ID="MAX_PERC" runat="server" Text="Макс. %" />
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr runat="server" id="itemPlaceholder">
                                        </tr>
                                    </tbody>
                                    <tfoot id="tblPSFoot" runat="server">
                                        <tr>
                                            <td class="command">
                                                <asp:ImageButton ID="ibAddNew" runat="server" CausesValidation="False" OnClick="ibAddNew_Click"
                                                    ImageUrl="/common/images/default/16/new.png" ToolTip="Додати" />
                                            </td>
                                            <td colspan="6"></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </LayoutTemplate>
                            <EmptyDataTemplate>
                                <table class="tbl_style1" width="650px">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>
                                                <asp:Label ID="TARIFF_ID" runat="server" Text="Ід." />
                                            </th>
                                            <th>
                                                <asp:Label ID="NAME" runat="server" Text="Найменування" />
                                            </th>
                                            <th>
                                                <asp:Label ID="MIN_VALUE" runat="server" Text="Мін. значення" />
                                            </th>
                                            <th>
                                                <asp:Label ID="MIN_PERC" runat="server" Text="Мін. %" />
                                            </th>
                                            <th>
                                                <asp:Label ID="MAX_VALUE" runat="server" Text="Макс. значення" />
                                            </th>
                                            <th>
                                                <asp:Label ID="MAX_PERC" runat="server" Text="Макс. %" />
                                            </th>
                                        </tr>
                                    </thead>
                                    <tfoot id="tblPSFoot" runat="server">
                                        <tr>
                                            <td class="command">
                                                <asp:ImageButton ID="ibAddNew" runat="server" CausesValidation="False" OnClick="ibAddNew_Click"
                                                    ImageUrl="/common/images/default/16/new.png" ToolTip="Додати" />
                                            </td>
                                            <td colspan="6"></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <tr id="tr" runat="server">
                                    <td class="command">
                                        <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                            ImageUrl="/common/images/default/16/edit.png" ToolTip="Редагувати" />
                                        <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                            ImageUrl="/common/images/default/16/delete.png" ToolTip="Видалити" />
                                    </td>
                                    <td>
                                        <asp:Label ID="TARIFF_ID" runat="server" Text='<%# Eval("TARIFF_ID") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="NAME" runat="server" Text='<%# Eval("NAME") %>'></asp:Label>
                                    </td>
                                    <td align="right">
                                        <asp:Label ID="MIN_VALUE" runat="server" Text='<%# Eval("MIN_VALUE", "{0:### ### ### ### ##0.00}") %>'></asp:Label>
                                    </td>
                                    <td align="right">
                                        <asp:Label ID="MIN_PERC" runat="server" Text='<%# Eval("MIN_PERC") == null ? "" : String.Format("{0:#0.##%}", Convert.ToDecimal(Eval("MIN_PERC")) / 100) %>'></asp:Label>
                                    </td>
                                    <td align="right">
                                        <asp:Label ID="MAX_VALUE" runat="server" Text='<%# Eval("MAX_VALUE", "{0:### ### ### ### ##0.00}") %>'></asp:Label>
                                    </td>
                                    <td align="right">
                                        <asp:Label ID="MAX_PERC" runat="server" Text='<%# Eval("MAX_PERC") == null ? "" : String.Format("{0:#0.##%}", Convert.ToDecimal(Eval("MAX_PERC")) / 100) %>'></asp:Label>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <tr id="tr" runat="server" class="edit">
                                    <td class="command">
                                        <asp:ImageButton ID="ibUpdate" runat="server" CausesValidation="True" ValidationGroup="Tariffs"
                                            CommandName="Update" ImageUrl="/common/images/default/16/save.png" ToolTip="Зберегти"
                                            TabIndex="106" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                            ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" TabIndex="107" />
                                    </td>
                                    <td>
                                        <asp:Label ID="TARIFF_ID" runat="server" Text='<%# Eval("TARIFF_ID") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <bars:TextBoxString ID="NAME" runat="server" Value='<%# Bind("NAME") %>' IsRequired="true"
                                            TabIndex="101" ValidationGroup="Tariffs" />
                                    </td>
                                    <td align="right">
                                        <bars:TextBoxDecimal ID="MIN_VALUE" runat="server" Value='<%# Bind("MIN_VALUE") %>'
                                            TabIndex="102" ValidationGroup="Tariffs" Width="75px" />
                                    </td>
                                    <td align="right">
                                        <bars:TextBoxDecimal ID="MIN_PERC" runat="server" Value='<%# Bind("MIN_PERC") %>'
                                            TabIndex="103" ValidationGroup="Tariffs" Width="75px" />
                                    </td>
                                    <td align="right">
                                        <bars:TextBoxDecimal ID="MAX_VALUE" runat="server" Value='<%# Bind("MAX_VALUE") %>'
                                            TabIndex="104" ValidationGroup="Tariffs" Width="75px" />
                                    </td>
                                    <td align="right">
                                        <bars:TextBoxDecimal ID="MAX_PERC" runat="server" Value='<%# Bind("MAX_PERC") %>'
                                            TabIndex="105" ValidationGroup="Tariffs" Width="75px" />
                                    </td>
                                </tr>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <tr id="tr" runat="server" class="new">
                                    <td class="command">
                                        <asp:ImageButton ID="ibInsert" runat="server" CausesValidation="True" ValidationGroup="Tariffs"
                                            CommandName="Insert" ImageUrl="/common/images/default/16/save.png" Text="Додати"
                                            TabIndex="207" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" OnClick="ibCancel_Click"
                                            ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" TabIndex="208" />
                                    </td>
                                    <td>
                                        <bars:TextBoxString ID="TARIFF_ID" runat="server" Value='<%# Bind("TARIFF_ID") %>' IsRequired="true"
                                            TabIndex="201" ValidationGroup="Tariffs" />
                                    </td>
                                    <td>
                                        <bars:TextBoxString ID="NAME" runat="server" Value='<%# Bind("NAME") %>' IsRequired="true"
                                            TabIndex="202" ValidationGroup="Tariffs" />
                                    </td>
                                    <td align="right">
                                        <bars:TextBoxDecimal ID="MIN_VALUE" runat="server" Value='<%# Bind("MIN_VALUE") %>'
                                            TabIndex="203" ValidationGroup="Tariffs" Width="75px" />
                                    </td>
                                    <td align="right">
                                        <bars:TextBoxDecimal ID="MIN_PERC" runat="server" Value='<%# Bind("MIN_PERC") %>'
                                            TabIndex="204" ValidationGroup="Tariffs" Width="75px" />
                                    </td>
                                    <td align="right">
                                        <bars:TextBoxDecimal ID="MAX_VALUE" runat="server" Value='<%# Bind("MAX_VALUE") %>'
                                            TabIndex="205" ValidationGroup="Tariffs" Width="75px" />
                                    </td>
                                    <td align="right">
                                        <bars:TextBoxDecimal ID="MAX_PERC" runat="server" Value='<%# Bind("MAX_PERC") %>'
                                            TabIndex="206" ValidationGroup="Tariffs" Width="75px" />
                                    </td>
                                </tr>
                            </InsertItemTemplate>
                        </asp:ListView>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:LinkButton ID="lbClose" runat="server" Text="Закрити" OnClientClick="window.returnValue = true; window.close(); return false; " CausesValidation="false"
                            TabIndex="1000"></asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>


