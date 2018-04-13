<%@ Page Title="Комісії" Language="C#" AutoEventWireup="true"
    CodeFile="fees.aspx.cs" Inherits="ins_fees" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="~/credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString"
    TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="Bars" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title title="Комісії"></title>
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
                        <bars:BarsObjectDataSource ID="ods" runat="server" SelectMethod="SelectFees" TypeName="Bars.Ins.VInsFees">
                        </bars:BarsObjectDataSource>
                        <asp:ListView ID="lv" runat="server" DataKeyNames="FEE_ID" DataSourceID="ods" OnItemInserting="lv_ItemInserting"
                            OnItemUpdating="lv_ItemUpdating" OnItemDeleting="lv_ItemDeleting">
                            <LayoutTemplate>
                                <table class="tbl_style1" width="650px">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>
                                                <asp:Label ID="FEE_ID" runat="server" Text="Ід." />
                                            </th>
                                            <th>
                                                <asp:Label ID="NAME" runat="server" Text="Найменування" />
                                            </th>
                                            <th>
                                                <asp:Label ID="MIN_VALUE" runat="server" Text="Мін. значення" />
                                            </th>
                                            <th>
                                                <asp:Label ID="PERC_VALUE" runat="server" Text="% значення" />
                                            </th>
                                            <th>
                                                <asp:Label ID="MAX_VALUE" runat="server" Text="Макс. значення" />
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
                                            <td colspan="5"></td>
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
                                                <asp:Label ID="FEE_ID" runat="server" Text="Ід." />
                                            </th>
                                            <th>
                                                <asp:Label ID="NAME" runat="server" Text="Найменування" />
                                            </th>
                                            <th>
                                                <asp:Label ID="MIN_VALUE" runat="server" Text="Мін. значення" />
                                            </th>
                                            <th>
                                                <asp:Label ID="PERC_VALUE" runat="server" Text="% значення" />
                                            </th>
                                            <th>
                                                <asp:Label ID="MAX_VALUE" runat="server" Text="Макс. значення" />
                                            </th>
                                        </tr>
                                    </thead>
                                    <tfoot id="tblPSFoot" runat="server">
                                        <tr>
                                            <td class="command">
                                                <asp:ImageButton ID="ibAddNew" runat="server" CausesValidation="False" OnClick="ibAddNew_Click"
                                                    ImageUrl="/common/images/default/16/new.png" ToolTip="Додати" />
                                            </td>
                                            <td colspan="5"></td>
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
                                        <asp:Label ID="FEE_ID" runat="server" Text='<%# Eval("FEE_ID") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="NAME" runat="server" Text='<%# Eval("NAME") %>'></asp:Label>
                                    </td>
                                    <td align="right">
                                        <asp:Label ID="MIN_VALUE" runat="server" Text='<%# Eval("MIN_VALUE", "{0:### ### ### ### ##0.00}") %>'></asp:Label>
                                    </td>
                                    <td align="right">
                                        <asp:Label ID="PERC_VALUE" runat="server" Text='<%# Eval("PERC_VALUE") == null ? "" : String.Format("{0:#0.##%}", Convert.ToDecimal(Eval("PERC_VALUE")) / 100) %>'></asp:Label>
                                    </td>
                                    <td align="right">
                                        <asp:Label ID="MAX_VALUE" runat="server" Text='<%# Eval("MAX_VALUE", "{0:### ### ### ### ##0.00}") %>'></asp:Label>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <tr id="tr" runat="server" class="edit">
                                    <td class="command">
                                        <asp:ImageButton ID="ibUpdate" runat="server" CausesValidation="True" ValidationGroup="Fees"
                                            CommandName="Update" ImageUrl="/common/images/default/16/save.png" ToolTip="Зберегти"
                                            TabIndex="105" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                            ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" TabIndex="106" />
                                    </td>
                                    <td>
                                        <asp:Label ID="FEE_ID" runat="server" Text='<%# Eval("FEE_ID") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <bars:TextBoxString ID="NAME" runat="server" Value='<%# Bind("NAME") %>' IsRequired="true"
                                            TabIndex="101" ValidationGroup="Fees" />
                                    </td>
                                    <td align="right">
                                        <bars:TextBoxDecimal ID="MIN_VALUE" runat="server" Value='<%# Bind("MIN_VALUE") %>'
                                            TabIndex="102" ValidationGroup="Fees" Width="75px" />
                                    </td>
                                    <td align="right">
                                        <bars:TextBoxDecimal ID="PERC_VALUE" runat="server" Value='<%# Bind("PERC_VALUE") %>'
                                            TabIndex="103" ValidationGroup="Fees" Width="75px" />
                                    </td>
                                    <td align="right">
                                        <bars:TextBoxDecimal ID="MAX_VALUE" runat="server" Value='<%# Bind("MAX_VALUE") %>'
                                            TabIndex="104" ValidationGroup="Fees" Width="75px" />
                                    </td>
                                </tr>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <tr id="tr" runat="server" class="new">
                                    <td class="command">
                                        <asp:ImageButton ID="ibInsert" runat="server" CausesValidation="True" ValidationGroup="Fees"
                                            CommandName="Insert" ImageUrl="/common/images/default/16/save.png" Text="Додати"
                                            TabIndex="206" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" OnClick="ibCancel_Click"
                                            ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" TabIndex="207" />
                                    </td>
                                    <td>
                                        <bars:TextBoxString ID="FEE_ID" runat="server" Value='<%# Bind("FEE_ID") %>' IsRequired="true"
                                            TabIndex="201" ValidationGroup="Fees" />
                                    </td>
                                    <td>
                                        <bars:TextBoxString ID="NAME" runat="server" Value='<%# Bind("NAME") %>' IsRequired="true"
                                            TabIndex="202" ValidationGroup="Fees" />
                                    </td>
                                    <td align="right">
                                        <bars:TextBoxDecimal ID="MIN_VALUE" runat="server" Value='<%# Bind("MIN_VALUE") %>'
                                            TabIndex="203" ValidationGroup="Fees" Width="75px" />
                                    </td>
                                    <td align="right">
                                        <bars:TextBoxDecimal ID="PERC_VALUE" runat="server" Value='<%# Bind("PERC_VALUE") %>'
                                            TabIndex="204" ValidationGroup="Fees" Width="75px" />
                                    </td>
                                    <td align="right">
                                        <bars:TextBoxDecimal ID="MAX_VALUE" runat="server" Value='<%# Bind("MAX_VALUE") %>'
                                            TabIndex="205" ValidationGroup="Fees" Width="75px" />
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
