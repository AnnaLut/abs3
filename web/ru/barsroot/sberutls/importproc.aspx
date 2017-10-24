<%@ Page Language="C#" AutoEventWireup="true" CodeFile="importproc.aspx.cs" Inherits="sberutls_importproc" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<script type="text/javascript" src="js/nJsonFunc.js"></script>
<script type="text/javascript" src="../Scripts/jquery/jquery.min.js"></script>

<link href="../Content/Themes/Kendo/kendo.common-material.min.css" rel="stylesheet" />
<link href="../Content/Themes/Kendo/kendo.material.min.css" rel="stylesheet" />
<link href="../Content/Themes/Kendo/kendo.material.mobile.min.css" rel="stylesheet" />
<script type="text/javascript" src="../Scripts/kendo/kendo.all.min.js"></script>
<script type="text/javascript" src="../Scripts/kendo/cultures/kendo.culture.uk-UA.min.js"></script>

<script type="text/javascript" src="js/importprocCtrl.js"></script>

<head runat="server">
    <title></title>
    <link href="/common/css/barsgridview.css" type="text/css" rel="Stylesheet" />
    <style type="text/css">
        .k-i-calendar {
            width: 20px;
            height: 20px;
            margin: 0 3px;
        }
 
        .k-picker-wrap .k-input {
            height: 1.4em;
            line-height: 1.4em;
            padding-left:20px;
            padding-top:7px;
        }
 
        .k-picker-wrap .k-select {
            min-height: 1.29em;
            line-height: 1.29em;
            padding-top: 2px;
        }
    </style>
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
         <table>
            <tr>
            <td style="width: 50%;">
            <h4>
                Обробка iмпортованих документiв</h4>
       
                <Bars:BarsSqlDataSourceEx ID="dsFilter" runat="server" ProviderName="barsroot.core" >
                </Bars:BarsSqlDataSourceEx>
                <div style="margin-bottom:7px;    margin-top: 40px;">
                    <span id="statusRegion" runat="server" >Статус:<br />
                    <asp:DropDownList ID="ddlFilter" runat="server" AutoPostBack="true" DataSourceID="dsFilter"
                        DataMember="DefaultView" DataValueField="status" DataTextField="descript">
                    </asp:DropDownList></span>
                    <span>
                        <input id="sel" type="checkbox" onclick="SelectAllRows('gv');" />Вибрати всi документи
                    </span>   
                </div>

        
                <asp:Button ID="btnVal" runat="server" Text="Перевiрити" OnClick="btnVal_Click" />
                <asp:Button ID="btnPay" runat="server" Text="Сплатити" OnClick="btnPay_Click" OnClientClick="if (!confirm('Всi вибранi рядки будуть сплаченi'))return false;" />
                <asp:Button ID="btnDel" runat="server" Text="Видалити" OnClick="btnDel_Click" OnClientClick="if (!confirm('Всi вибранi рядки будуть видаленi'))return false;" />
                <span style="border-right: dotted 1px gray; padding-right: 0px;">&nbsp;</span>
                <asp:Button ID="btnEdit" runat="server" Text="Перегляд/Редагування" OnClick="Button1_Click" />
                <br>
                <asp:Label runat="server" ID="lblMsg" ForeColor="Red"></asp:Label>
                <br>
                <asp:Label runat="server" ID="lblRes" ForeColor="#006666"></asp:Label>
                <div>
                    &nbsp;</div>
            </td>
            <td style="width: 50%;padding-top: 0px;margin-top:-20px;  font-family: 'Lucida Grande', Geneva, Arial, Tahoma, Verdana, Helvetica, sans-serif;">
                <b style="margin-left: 180px;">Дата імпорту</b>
                <div style="margin-left: 75px;margin-top:4px">
                    <input type="text" name="dStart" style=""/>          
                   
                    <input type="text" name="dEnd"/> 
                </div>
                <div style="margin-left: 82px;margin-top:8px">
                    <input type="button" name="FilterByDate" <%--style="margin-left: 76px;"--%> value="Фільтрувати" style="width:142px;"/>
                   
                    <input type="button" style=" width:142px;"  name="clearDateFilter" value="Очистити фільтр"/>
                </div>
            </td>
            </tr>
        </table>

        <div style="display:none;float:left;">
                <asp:Literal runat="server" id="V_IMPORT" EnableViewState="false" />
                <asp:Literal runat="server" id="V_CHECK" EnableViewState="false" />
                <asp:Literal runat="server" id="V_PAYED" EnableViewState="false" />
                <asp:Literal runat="server" id="V_DELETED" EnableViewState="false" />
                <asp:Literal runat="server" id="V_ERRREQ" EnableViewState="false" />

                <asp:Literal runat="server" id="SUM_IMPORT" EnableViewState="false" />
                <asp:Literal runat="server" id="SUM_CHECK" EnableViewState="false" />
                <asp:Literal runat="server" id="SUM_PAYED" EnableViewState="false" />
                <asp:Literal runat="server" id="SUM_DELETED" EnableViewState="false" />
                <asp:Literal runat="server" id="SUM_ERRREQ" EnableViewState="false" />
            </div>
             <table style="width:100%;padding-right: 40%;overflow:auto;font-family: 'Lucida Grande', Geneva, Arial, Tahoma, Verdana, Helvetica, sans-serif;">
              <tr>
                <td width="140px" style="border-bottom: 2px solid #bdcff7;border-top:2px solid #bdcff7;"><b>Виділено</b></td>
                <td width="40px" style="border-bottom: 2px solid #bdcff7;border-right: 2px solid #bdcff7;border-top:2px solid #bdcff7;"><b name="selNum">0</b></td>
                <td width="80px" style="border-bottom: 2px solid #bdcff7;border-top:2px solid #bdcff7;" >Імпортовані</td>
                <td width="40px" style="border-bottom: 2px solid #bdcff7;border-right: 2px solid #bdcff7;border-top:2px solid #bdcff7;"><%=V_IMPORT.Text%></td>
                <td width="90px" style="border-bottom: solid 2px #bdcff7;border-top:2px solid #bdcff7;">З помилковими рекв.</td>
                <td width="40px" style="border-bottom: 2px solid #bdcff7;border-right: 2px solid #bdcff7;border-top:2px solid #bdcff7;"><%=V_ERRREQ.Text%></td> 
                <td></td>   
              </tr>
              <tr>
                <td width="140px" style=""><b>Сума Виділеного</b></td>
                <td width="80px" style="border-right: 2px solid #bdcff7;"><b name="selSum">0.00</b></td>
                <td width="80px" >Сума</td>
                <td width="120px" style="border-right: 2px solid #bdcff7;"><%=SUM_IMPORT.Text%></td>
                <td width="90px">Сума</td>
                <td width="120px" style="border-right: 2px solid #bdcff7;"><%=SUM_ERRREQ.Text%></td>
              </tr>
            </table>
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
                <asp:BoundField DataField="DAT" HeaderText="Дата імпорту"  DataFormatString="{0:dd.MM.yyyy}" SortExpression="DATP">
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
