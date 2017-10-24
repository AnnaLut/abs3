<%@ Page Language="C#" AutoEventWireup="true" CodeFile="edit_msg.aspx.cs" Inherits="swi_edit_msg" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Редагування повідомлення</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
    <base target="_self" />

    <script>
        function clickButton(e)
        {
            var element = event.target || event.srcElement;
            if (event.keyCode == 13 && (element && element.tagName.toLowerCase() == "textarea"))
            {
                element.value += '\n';
                if(element.rows <= 6){
                    element.rows += 1;
                }                
            }
            return true;
        }
    </script>

</head>
<body>
    <form id="frm_edit_msg" runat="server" onkeypress="javascript:return clickButton(event);">
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
        <div>
        </div>
        <table>
            <tr>
                <td>
                    <asp:Label ID="lbRef" runat="server" Text="Референс повідомлення"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lbRefVal" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lbSenderName" Text="Відправник"></asp:Label>
                </td>
                <td>
                    <asp:Label runat="server" ID="lbSender"></asp:Label>
                </td>
            </tr>
            <tr>
                 <td>
                    <asp:Label runat="server" ID="lbRecivName" Text="Отримувач"></asp:Label>
                </td>
                <td>
                    <asp:Label runat="server" ID="lbReciv"></asp:Label>
                </td>
            </tr>
        </table>
        <hr />
        <table>
            <tr>
                <td>
                    <asp:Button runat="server" ID="btSave" Text="Зберегти" OnClick="btSave_Click" />
                </td>
                <td>
                    <asp:Button runat="server" ID="btClose" Text="Закрити" OnClick="btClose_Click" />
                </td>
            </tr>
        </table>
        <hr />
        <table>
            <tr>
                <td>
                    <BarsEx:BarsSqlDataSourceEx ID="sdsOPT" runat="server" SelectCommand="select OPT from sw_opt" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
                    <BarsEx:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
                    <BarsEx:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="True" AllowSorting="True"
                        DataSourceID="dsMain" CssClass="barsGridView" ShowPageSizeBox="true" DataKeyNames="NUM, SWREF, EDITVAL"
                        AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="None"
                        PagerSettings-PageIndex="0"
                        PageSize="100">
                        <SelectedRowStyle CssClass="selectedRow" />
                        <Columns>
                            <asp:BoundField DataField="num" HeaderText="#" />
                            <asp:BoundField DataField="seq" HeaderText="Блок" />
                            <asp:BoundField DataField="subseq" HeaderText="Підблок" />
                            <asp:BoundField DataField="tag" HeaderText="Поле" />
                            <asp:TemplateField HeaderText="Опція">
                                <ItemTemplate>
                                    <bec:TextBoxRefer ID="refOPT" runat="server" TAB_NAME="SW_OPT"
                                        KEY_FIELD="OPT" SEMANTIC_FIELD="OPT" IsRequired="false" Value='<%#Eval("OPT") %>' Width="40Px" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Значення" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <bec:TextBoxString OnDataBinding="tbValue_DataBinding"
                                        ID="tbValue"
                                        runat="server"
                                        IsRequired="false"
                                        RequiredErrorText="Заповніть поле"
                                        TextMode="MultiLine"
                                        Width="450"
                                        Enabled="true"
                                        ToolTip="Значення"
                                        Value='<%#String.Format("{0}",Eval("VALUE")) %>'
                                         />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </BarsEx:BarsGridViewEx>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
