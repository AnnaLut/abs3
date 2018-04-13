﻿<%@ Page Title="Параметри" Language="C#" AutoEventWireup="true"
    CodeFile="attrs.aspx.cs" Inherits="ins_attrs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="~/credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString"
    TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="Bars" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title title="Сканкопії"></title>
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
                        <bars:BarsObjectDataSource ID="ods" runat="server" SelectMethod="SelectAttrs" TypeName="Bars.Ins.VInsAttrs">
                        </bars:BarsObjectDataSource>
                        <bars:BarsObjectDataSource ID="ods_attr_types" runat="server" SelectMethod="SelectAttrTypes"
                            TypeName="Bars.Ins.InsAttrTypes">
                        </bars:BarsObjectDataSource>
                        <asp:ListView ID="lv" runat="server" DataKeyNames="ATTR_ID" DataSourceID="ods" OnItemInserting="lv_ItemInserting"
                            OnItemUpdating="lv_ItemUpdating" OnItemDeleting="lv_ItemDeleting">
                            <LayoutTemplate>
                                <table class="tbl_style1" width="650px">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>
                                                <asp:Label ID="ATTR_ID" runat="server" Text="Ід." />
                                            </th>
                                            <th>
                                                <asp:Label ID="NAME" runat="server" Text="Найменування" />
                                            </th>
                                            <th>
                                                <asp:Label ID="TYPE_ID" runat="server" Text="Тип" />
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
                                            <td colspan="2"></td>
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
                                                <asp:Label ID="ATTR_ID" runat="server" Text="Ід." />
                                            </th>
                                            <th>
                                                <asp:Label ID="NAME" runat="server" Text="Найменування" />
                                            </th>
                                            <th>
                                                <asp:Label ID="TYPE_ID" runat="server" Text="Тип" />
                                            </th>
                                        </tr>
                                    </thead>
                                    <tfoot id="tblPSFoot" runat="server">
                                        <tr>
                                            <td class="command">
                                                <asp:ImageButton ID="ibAddNew" runat="server" CausesValidation="False" OnClick="ibAddNew_Click"
                                                    ImageUrl="/common/images/default/16/new.png" ToolTip="Додати" />
                                            </td>
                                            <td colspan="2"></td>
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
                                        <asp:Label ID="ATTR_ID" runat="server" Text='<%# Eval("ATTR_ID") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="NAME" runat="server" Text='<%# Eval("NAME") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="TYPE_NAME" runat="server" Text='<%# String.IsNullOrEmpty(Convert.ToString(Eval("TYPE_NAME"))) ? "" : String.Format("{0} - {1}", Eval("TYPE_ID"), Eval("TYPE_NAME")) %>' />
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <tr id="tr" runat="server" class="edit">
                                    <td class="command">
                                        <asp:ImageButton ID="ibUpdate" runat="server" CausesValidation="True" ValidationGroup="Update"
                                            CommandName="Update" ImageUrl="/common/images/default/16/save.png" ToolTip="Зберегти"
                                            TabIndex="105" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                            ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" TabIndex="106" />
                                    </td>
                                    <td>
                                        <asp:Label ID="ATTR_ID" runat="server" Text='<%# Eval("ATTR_ID") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <bars:TextBoxString ID="NAME" runat="server" Value='<%# Bind("NAME") %>' IsRequired="true"
                                            TabIndex="101" ValidationGroup="Update" />
                                    </td>
                                    <td>
                                        <bars:DDLList ID="TYPE_ID" runat="server" DataSourceID="ods_attr_types" DataTextField="NAME"
                                            DataValueField="ID" SelectedValue='<%# Bind("TYPE_ID") %>' IsRequired="false" ValidationGroup="Update" 
                                            EmptyItemText="Всі">
                                        </bars:DDLList>
                                    </td>
                                </tr>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <tr id="tr" runat="server" class="new">
                                    <td class="command">
                                        <asp:ImageButton ID="ibInsert" runat="server" CausesValidation="True" ValidationGroup="Insert"
                                            CommandName="Insert" ImageUrl="/common/images/default/16/save.png" Text="Додати"
                                            TabIndex="206" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" OnClick="ibCancel_Click"
                                            ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" TabIndex="207" />
                                    </td>
                                    <td>
                                        <bars:TextBoxString ID="ATTR_ID" runat="server" Value='<%# Bind("ATTR_ID") %>' IsRequired="true"
                                            TabIndex="201" ValidationGroup="Fees" />
                                    </td>
                                    <td>
                                        <bars:TextBoxString ID="NAME" runat="server" Value='<%# Bind("NAME") %>' IsRequired="true"
                                            TabIndex="202" ValidationGroup="Insert" />
                                    </td>
                                    <td>
                                        <bars:DDLList ID="TYPE_ID" runat="server" DataSourceID="ods_attr_types" DataTextField="NAME"
                                            DataValueField="ID" SelectedValue='<%# Bind("ID") %>' IsRequired="false" ValidationGroup="Insert"
                                            EmptyItemText="Всі">
                                        </bars:DDLList>
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
