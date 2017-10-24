<%@ Page Language="C#" AutoEventWireup="true" CodeFile="docinput_editPropsVal.aspx.cs" Inherits="docinput_editPropsVal" MaintainScrollPositionOnPostBack = "true" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Редагування додаткових реквізитів</title>
    <link href="/Common/CSS/BarsGridView.css" rel="Stylesheet" type="text/css" />
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
	<meta http-equiv="X-UA-Compatible" content="IE=7">
    <base target="_self">
    <script type="text/javascript">
        function showRelWindow(tag) {
            var boxID = document.getElementById("hEditBoxId").value;
            var box = document.getElementById(boxID);
            var reqname = tag;
            var reqvalue = box;
            var result = window.showModalDialog("dialog.aspx?type=metatab_req&role=wr_doc_input&reqname=" + escape(reqname) + "&reqvalue=" + reqvalue,
            window,
            "dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
            if (result != null)
                box.value = result[0];
        }
    </script>
</head>
<body>
    <form id="formEditprops" runat="server" target="">
        <div class="pageTitle">
            <asp:Label ID="lbTitle" runat="server" Text="Редагування додаткових реквізитів"></asp:Label>
        </div>
        <table style="width: 99%">
            <tr>
                <td style="width: 60%;">
                    <div>
                        <asp:Panel runat="server" ID="pnProps" GroupingText="Реквізити документу">
                            <bars:BarsSqlDataSourceEx ID="sdsProps" runat="server" ProviderName="barsroot.core" OldValuesParameterFormatString="old_{0}">
                            </bars:BarsSqlDataSourceEx>

                            <bars:BarsGridViewEx ID="gvProps" runat="server" DataSourceID="sdsProps" AllowSorting="True"
                                DataKeyNames="REF,TAG" CssClass="barsGridView" AutoGenerateColumns="False" OnRowUpdating="gvProps_RowUpdating"
                                OnRowDataBound="gvProps_RowDataBound">
                                <columns>
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:ImageButton runat="server" ID="imgUpdate" Width="16px" ToolTip="Зберегти зміни"
                            CommandName="Update" CommandArgument='<%# Eval("TAG") %>' ImageUrl="/Common/Images/default/16/save.png">
                        </asp:ImageButton>
                        <asp:ImageButton runat="server" ID="imgCancel" Width="16px" ToolTip="Відмінити редагування"
                            CommandName="Cancel" CommandArgument='<%# Eval("TAG") %>' ImageUrl="/Common/Images/default/16/cancel.png">
                        </asp:ImageButton>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:ImageButton runat="server" ID="imgEdit" Width="16px" ToolTip="Редагувати реквізит" 
                            CommandName="Edit" CommandArgument='<%# Eval("TAG") %>' ImageUrl="/Common/Images/default/16/open_blue.png">
                        </asp:ImageButton>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                </asp:TemplateField>
                <asp:BoundField DataField="NAME" SortExpression="NAME" HeaderText="Реквізит" ReadOnly="true">
                </asp:BoundField>
                <asp:TemplateField SortExpression="VALUE" HeaderText="Значення">
                    <EditItemTemplate>
                        <asp:TextBox runat="server" ID="tbVALUE" Text='<%# Bind("VALUE") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lbVALUE" Text='<%# Eval("VALUE") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:LinkButton Text="Довідник" runat="server" ID="lbShowRel" OnClientClick='<%# "showRelWindow(\"" + Eval("TAG") + "\");return false;" %>'
                            Visible='<%# Convert.ToBoolean(Eval("REL")) %>'></asp:LinkButton>
                    </EditItemTemplate>
                </asp:TemplateField>
            </columns>
                            </bars:BarsGridViewEx>

                        </asp:Panel>
                    </div>
                </td>
                <td></td>
            </tr>
        </table>
        <asp:HiddenField runat="server" ID="hEditBoxId" />
    </form>
</body>
</html>
