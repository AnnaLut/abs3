<%@ Page Language="C#" AutoEventWireup="true" CodeFile="importproc.aspx.cs" Inherits="sberutls_importproc" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/common/css/barsgridview.css" type="text/css" rel="Stylesheet" />

    <script type="text/javascript">
        function SelectAllRows(gv) {
            var ids = document.getElementById('<%=gv.ClientID%>' + '_selitems');
            var grid = document.getElementById('<%=gv.ClientID%>');
            if (grid) {
                var sel = document.getElementById('sel').checked;
                if (!sel) {
                    clearSelections(grid, 0);
                    return false;
                }
                clearSelections(grid, 1);
                ids.value = "";
                for (i = 1; i < grid.rows.length - 1; i++) {
                    var row = grid.rows[i];
                    if (row.className != 'filterRow' && row.className != 'pagerRow' && row.className != 'footerRow')
                        fillRow(row, '<%=gv.ClientID%>');
                }
            }
        }    
    </script>

</head>
<body style="font-size: 9pt">
    <!--
        <input id="Text1" type="text" /><input id="Button1" type="button" onclick="var ids = document.getElementById('selItems'); document.getElementById('Text1').value = ids.value;" value="button" />
    !-->
    <form id="form1" runat="server">
    <div>
        <h4>
            Обробка iмпортованих документiв</h4>
        <Bars:BarsSqlDataSourceEx ID="dsFilter" runat="server" ProviderName="barsroot.core" >
        </Bars:BarsSqlDataSourceEx>
        <div style="margin-bottom:7px;">
            <span id="statusRegion" runat="server" >Статус:<br />
            <asp:DropDownList ID="ddlFilter" runat="server" AutoPostBack="true" DataSourceID="dsFilter"
                DataMember="DefaultView" DataValueField="status" DataTextField="descript">
            </asp:DropDownList></span>
            <span>
                <input id="sel" type="checkbox" onclick="SelectAllRows('gv');" />Вибрати всi документи</span>
        </div>
        <asp:Button ID="btnVal" runat="server" Text="Перевiрити" OnClick="btnVal_Click" />
        <asp:Button ID="btnPay" runat="server" Text="Сплатити" OnClick="btnPay_Click" OnClientClick="if (!confirm('Всi вибранi рядки будуть сплаченi'))return false;" />
        <asp:Button ID="btnDel" runat="server" Text="Видалити" OnClick="btnDel_Click" OnClientClick="if (!confirm('Всi вибранi рядки будуть видаленi'))return false;" />
        <span style="border-right: dotted 1px gray; padding-right: 0px;">&nbsp;</span>
        <asp:Button ID="btnEdit" runat="server" Text="Перегляд/Редагування" OnClick="Button1_Click" />
        <asp:Label runat="server" ID="lblMsg" ForeColor="Red"></asp:Label>
        <asp:Label runat="server" ID="lblRes" ForeColor="#006666"></asp:Label>
        <div>
            &nbsp;</div>
        <Bars:BarsSqlDataSourceEx ID="ds" runat="server" 
            AllowPaging="False" FilterStatement="" PageButtonCount="10" PagerMode="NextPrevious"
            PageSize="10" PreliminaryStatement="" ProviderName="barsroot.core"
            SortExpression="" SystemChangeNumber="" WhereStatement="" OnSelecting="ds_Selecting">
        </Bars:BarsSqlDataSourceEx>
        <Bars:BarsGridViewEx ID="gv" AllowPaging="True" runat="server" CaptionType="Simple"
            DataSourceID="ds" CaptionText="" ClearFilterImageUrl="/common/images/default/16/filter_delete.png" 
            CssClass="barsGridView" DateMask="dd.MM.yyyy" ExcelImageUrl="/common/images/default/16/export_excel.png"
            FilterImageUrl="/common/images/default/16/filter.png" MetaFilterImageUrl="/common/images/default/16/filter.png"
            MetaTableName="" RefreshImageUrl="/common/images/default/16/refresh.png" AutoGenerateColumns="False"
            AllowSorting="True" DataKeyNames="impref,status" JavascriptSelectionType="MultiSelect"
            ShowFooter="True">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:TemplateField HeaderText="Статус" SortExpression="TXTSTATUS">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" ToolTip='<%# Bind("ERRMSG") %>' Text='<%# Bind("TXTSTATUS") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Left" />
                </asp:TemplateField>
                <asp:BoundField DataField="NLSA" HeaderText="Рахунок А" SortExpression="NLSA">
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="NAM_A" HeaderText="Назва платника" SortExpression="NAM_A">
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="ID_A" HeaderText="ЗКПО А" SortExpression="ID_A">
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="MFOB" HeaderText="МФО Б" SortExpression="MFOB">
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="NLSB" HeaderText="Рахунок Б" SortExpression="NLSB">
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="ID_B" HeaderText="ЗКПО Б" SortExpression="ID_B">
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="NAM_B" HeaderText="Назва отримувача" SortExpression="NAM_B">
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="S" HeaderText="Сума" DataFormatString="{0:n}" SortExpression="S">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
        <div runat="server" id="divDllinfo" style="font-size: 7pt;">
        </div>
    </div>
    <div style="margin-bottom: 5px; border-bottom: 1px solid #E0E0E0; padding-bottom: 5px;" />
    </form>
    <script type="text/javascript">
        window.onbeforeunload = function() {
            clearSelections(document.getElementById('<%=gv.ClientID%>'), 0);
        }

    </script>
</body>
</html>
