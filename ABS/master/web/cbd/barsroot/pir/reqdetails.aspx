<%@ Page Language="C#" AutoEventWireup="true" CodeFile="reqdetails.aspx.cs" Inherits="pcur_reqdetails_aspx" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Детальна інформація про заявку</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    
    <link href="../Content/Themes/ModernUI/css/jquery-ui.css" type="text/css" rel="Stylesheet"/>
    
    
    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/jquery") %>
        <%: Scripts.Render("~/bundles/jquery-ui") %>
        <%: Scripts.Render("~/bundles/jquery-bars-ui") %>
        <script src="../documentsview/Script.js" type="text/javascript"></script>
    </asp:PlaceHolder>
</head>
<body bgcolor="#f0f0f0">
    <script type="text/javascript">
        function successPayAlert(text) {
            barsUiAlert(text, 'Повідомлення');
        }
        function errorMessage(text) {
            barsUiError(text);
        }
    </script>
    <form id="formReqDetails" runat="server" style="vertical-align: central">

        <asp:Panel ID="pnButtons" runat="server" GroupingText="Доступні дії:" Style="margin-left: 10px; margin-right: 10px">
            <bars:ImageTextButton ID="btBack" runat="server" ImageUrl="/common/images/default/16/arrow_left.png" Text="Назад" OnClick="btBack_Click" />
            <br />
            <bars:ImageTextButton ID="btnCreateAccs" runat="server" ImageUrl="/common/images/default/16/win_max_all.png" Text="1. Відкрити рахунки" Enabled="True" OnClick="btCreateAccounts_Click"/>
            <bars:ImageTextButton ID="btnTransferBalance" runat="server" ImageUrl="/common/images/default/16/gear_run.png" Text="2. Перерахувати залишки на транзитні разунки" Enabled="False" OnClick="btTransferBalance_Click" />
            <bars:ImageTextButton ID="btnCalcDept" runat="server" ImageUrl="/common/images/default/16/money_calc.png" Text="3. Розрахувати заборгованість" Enabled="False" OnClick="btCalcDedt_Click" />
            <bars:ImageTextButton ID="btConvertDebt" runat="server" ImageUrl="/common/images/default/16/edit.png" Text="4. Конвертувати заборгованість" Enabled="False" OnClick="btConvertDebt_Click" />
            <bars:ImageTextButton ID="btnRepayDebt" runat="server" ImageUrl="/common/images/default/16/win_edit.gif" Text="5. Погашення заборгованості" Enabled="False" OnClick="btRepayDebt_Click" />
            <bars:ImageTextButton ID="btnPayMoney" runat="server" ImageUrl="/common/images/default/16/gear_ok.png" Text="6. Виплата залишків на картовий рахунок" Enabled="False"  OnClick="btnPayMoney_Click"/>
        </asp:Panel>
        
        <asp:Panel ID="pnReqInfo" runat="server" GroupingText="Інформація про заявку:" Style="margin-left: 10px; margin-right: 10px">
            <asp:Label ID="lblReqNumberCatpion" runat="server" Text="Заява №"></asp:Label>
            <asp:Label ID="lblReqNumber" runat="server" Font-Bold="True"></asp:Label>

            <asp:Label ID="lblReqDateCreateCaption" runat="server" Text="Створена "></asp:Label>
            <asp:Label ID="lblReqDateCreate" runat="server" Font-Bold="True"></asp:Label>           
            
            <br />
            <asp:Label ID="lblReqMFOCaption" runat="server" Text="МФО:"></asp:Label>
            <asp:Label ID="lblReqMFO" runat="server" Font-Bold="True"></asp:Label>, 
            <asp:Label ID="lblFilialName" runat="server" Font-Bold="True"></asp:Label>, 
            <asp:Label ID="lblBranch" runat="server" Font-Bold="True"></asp:Label> 
            <br />
            <asp:Label ID="lblReqStateCaprion" runat="server" Text="Статус заявки: "></asp:Label>
            <asp:Label ID="lblReqState" runat="server" Font-Bold="True"></asp:Label> 
			<br/>
            <asp:Label ID="lblCreatorNameCaption" runat="server" Text="Користувач, що створив заявку: "></asp:Label>
            <asp:Label ID="lblCreatorName" runat="server" Font-Bold="True"></asp:Label> 
        </asp:Panel>
        
        <asp:Panel ID="pnClientInfo" runat="server" GroupingText="Інформація про заявника:" Style="margin-left: 10px; margin-right: 10px">
            <table>
                <tr>
                    <th colspan="2">
                        <asp:Label runat="server" Text="Кримське РУ"></asp:Label>
                    </th>
                    <th colspan="2">
                        <asp:Label ID="lblOurRu" runat="server" ></asp:Label>
                    </th>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbRnk" runat="server" Text="РНК клієнта:" ></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbRnkVal" runat="server" Font-Bold="True" Width="250px" ></asp:Label>
                        
                    </td>
                    <td>
                        <asp:Label ID="lbRnkEx" runat="server" Text="РНК клієнта" AssociatedControlID="lbRnkExVal"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbRnkExVal" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbFio" runat="server" Text="ПІБ клієнта:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbFioVal" runat="server" Font-Bold="True" ></asp:Label>
                        
                    </td>                    
                    <td>
                        <asp:Label ID="lblFieExtCaption" runat="server" Text="ПІБ клієнта:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblFieExt" runat="server" Font-Bold="True" ></asp:Label>
                        
                    </td>                    
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbBirth" runat="server" Text="Дата народження клієнта:" AssociatedControlID="lbBirthVal"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbBirthVal" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="Дата народження клієнта:" AssociatedControlID="lbBirthVal"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbBirthExt" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPassport" runat="server" Text="Документ:"></asp:Label>
                    </td>                    
                    <td>
                        <asp:Label ID="lblDocumentVal" runat="server" Font-Bold="True"></asp:Label>
                    </td>                    
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="Документ:"></asp:Label>
                    </td>                    
                    <td>
                        <asp:Label ID="lblDocumentValExt" runat="server" Font-Bold="True"></asp:Label>
                    </td>                    
                </tr>
                 <tr>
                    <td>
                        <asp:Label ID="lbInn" runat="server" Text="ІНН клієнта:"></asp:Label>
                    </td>                    
                    <td>
                        <asp:Label ID="lbInnVal" runat="server" Font-Bold="True"></asp:Label>
                    </td>                    
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="ІНН клієнта:"></asp:Label>
                    </td>                    
                    <td>
                        <asp:Label ID="lbInnValExt" runat="server" Font-Bold="True"></asp:Label>
                    </td>                    
                </tr>
            </table>
        </asp:Panel>

        <br />
        <div id="dvGridTitle" runat="server">
            <asp:Label ID="lbGvTitle" runat="server" Text="Продукти клієнта" Font-Size="Medium" Style="margin-left: 10px; margin-right: 10px"></asp:Label>
        </div>
        <BarsEX:BarsSqlDataSourceEx runat="server" ID="dsDeals" ProviderName="barsroot.core"></BarsEX:BarsSqlDataSourceEx>
        
        <BarsEX:BarsGridViewEx ID="gvDeals" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateCheckBoxColumn="false"
            DataSourceID="dsDeals" 
            CssClass="barsGridView" DateMask="dd/MM/yyyy"
            AutoGenerateColumns="false" 
            CaptionType="Cool"
            ShowPageSizeBox="true" EnableViewState="true" 
            AutoSelectFirstRow="false"
            HoverRowCssClass="headerRow"
           
            RefreshImageUrl="/common/images/default/16/refresh.png"
            ExcelImageUrl="/common/images/default/16/export_excel.png"
            FilterImageUrl="/common/images/default/16/filter.png">
            <AlternatingRowStyle CssClass="alternateRow" />
            <Columns>
                <asp:BoundField DataField="DEAL_TYPE_NAME" HeaderText="Тип договору" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="DEAL_ID" HeaderText="ID договору" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="COMM" HeaderText="Опис" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                <asp:BoundField DataField="SDATE" HeaderText="Дата дог." ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                <asp:BoundField DataField="SUMM" HeaderText="Сума дог." ItemStyle-HorizontalAlign="Right" DataFormatString="{0:###,###,###,###,###,##0.00}"></asp:BoundField>
                <asp:BoundField DataField="KV" HeaderText="Валюта" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                <asp:BoundField DataField="SUMMPROC" HeaderText="Сума % (орієнтовно)" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:###,###,###,###,###,##0.00}"></asp:BoundField>
                <asp:BoundField DataField="APPROVED_C" HeaderText="Підтверджено" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                <asp:BoundField DataField="OST" HeaderText="Поточний залишок" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:###,###,###,###,###,##0.00}"></asp:BoundField>
                <asp:TemplateField HeaderText="REF документу">
                    <ItemTemplate>
                        <asp:HyperLink ID="refDeal" runat="server" onclick='<%# "OpenDoc(" + Eval("REF") + ", " + (char)39 + "_blank" + (char)39 +")" %>' title="Відкрити картку документа" style="cursor:pointer;"><%#Eval("REF") %></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="dummy" HeaderText="Дата документу" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="DOCSTATE" HeaderText="Статус оплати" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                <asp:BoundField DataField="PMT_MSG" HeaderText="Помилки" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                <asp:TemplateField HeaderText="REF документу по %">
                    <ItemTemplate>
                        <asp:HyperLink ID="refDealPercents" runat="server" onclick='<%# "OpenDoc(" + Eval("REFPROC") + ", " + (char)39 + "_blank" + (char)39 +")" %>' title="Відкрити картку документа" style="cursor:pointer;"><%#Eval("REFPROC") %></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>                
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
        
        <br />
        <div id="dvTransAccsTitle" runat="server">
            <asp:Label ID="lblTransAccsTitle" runat="server" Text="Транзитні рахунки" Font-Size="Medium" Style="margin-left: 10px; margin-right: 10px"></asp:Label>
        </div>   
        <BarsEX:BarsSqlDataSourceEx runat="server" ID="dsTransAccs" ProviderName="barsroot.core"></BarsEX:BarsSqlDataSourceEx>     
        <BarsEX:BarsGridViewEx ID="gvTransAccs" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateCheckBoxColumn="false"
            DataSourceID="dsTransAccs" 
            CssClass="barsGridView" DateMask="dd/MM/yyyy"
            AutoGenerateColumns="false" 
            CaptionType="Cool"
            ShowPageSizeBox="true" 
            EnableViewState="true" 
            AutoSelectFirstRow="false"
            HoverRowCssClass="headerRow"
           
            RefreshImageUrl="/common/images/default/16/refresh.png"
            ExcelImageUrl="/common/images/default/16/export_excel.png"
            FilterImageUrl="/common/images/default/16/filter.png">
            <AlternatingRowStyle CssClass="alternateRow" />
            <Columns>
                <asp:BoundField DataField="ACC" HeaderText="Номер рахунку" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="NLS" HeaderText="Номер транзитного рахунку" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="KV" HeaderText="Код валюти" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="OST" HeaderText="Залишок на рахунку" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:###,###,###,###,###,##0.00}"></asp:BoundField>
                <asp:BoundField DataField="DAOS" HeaderText="Дата відкриття рахунку" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                <asp:BoundField DataField="DAZS" HeaderText="Дата заккриття рахунку" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
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
        
        <br />
        <div id="dvCreds" runat="server">
            <asp:Label ID="lblCredsTitle" runat="server" Text="Заборгованість" Font-Size="Medium" Style="margin-left: 10px; margin-right: 10px"></asp:Label>
        </div>   
        <BarsEX:BarsSqlDataSourceEx runat="server" ID="dsCreds" ProviderName="barsroot.core"></BarsEX:BarsSqlDataSourceEx>     
        <BarsEX:BarsGridViewEx ID="gvCreds" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateCheckBoxColumn="false"
            DataSourceID="dsCreds" 
            CssClass="barsGridView" DateMask="dd/MM/yyyy"
            AutoGenerateColumns="false" 
            CaptionType="Cool"
            ShowPageSizeBox="true" 
            EnableViewState="true" 
            AutoSelectFirstRow="false"
            HoverRowCssClass="headerRow"
           
            RefreshImageUrl="/common/images/default/16/refresh.png"
            ExcelImageUrl="/common/images/default/16/export_excel.png"
            FilterImageUrl="/common/images/default/16/filter.png">
            <AlternatingRowStyle CssClass="alternateRow" />
            <Columns>
                <asp:BoundField DataField="CREDIT_TYPE" HeaderText="Тип кредиту" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="ND" HeaderText="Номер договору" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="SUMM" HeaderText="Сума до виплати" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:###,###,###,###,###,##0.00}"></asp:BoundField>
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
        
        <br />
        <div id="dvBPK" runat="server">
            <asp:Label ID="lblBPKTitle" runat="server" Text="Параметри БПК" Font-Size="Medium" Style="margin-left: 10px; margin-right: 10px"></asp:Label>
        </div>   
        <BarsEX:BarsSqlDataSourceEx runat="server" ID="dsBpk" ProviderName="barsroot.core"></BarsEX:BarsSqlDataSourceEx>     
        <BarsEX:BarsGridViewEx ID="gvBpk" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateCheckBoxColumn="false"
            DataSourceID="dsBpk" 
            CssClass="barsGridView" DateMask="dd/MM/yyyy"
            AutoGenerateColumns="false" 
            CaptionType="Cool"
            ShowPageSizeBox="true" 
            EnableViewState="true" 
            AutoSelectFirstRow="false"
            HoverRowCssClass="headerRow"
           
            RefreshImageUrl="/common/images/default/16/refresh.png"
            ExcelImageUrl="/common/images/default/16/export_excel.png"
            FilterImageUrl="/common/images/default/16/filter.png">
            <AlternatingRowStyle CssClass="alternateRow" />
            <Columns>
                <asp:BoundField DataField="KF" HeaderText="МФО" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="RNK_EXT" HeaderText="РНК" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="NLS2625" HeaderText="Номер особ. рахунку 2625" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="KV" HeaderText="Код валюти" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:TemplateField HeaderText="REF документу">
                    <ItemTemplate>
                        <asp:HyperLink ID="refBpk" runat="server" onclick='<%# "OpenDoc(" + Eval("REF") + ", " + (char)39 + "_blank" + (char)39 +")" %>' title="Відкрити картку документа" style="cursor:pointer;"><%#Eval("REF") %></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>                
                <asp:BoundField DataField="PMT_MSG" HeaderText="Помилки" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                <asp:BoundField DataField="BRANCH" HeaderText="Відділ" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
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
    </form>
</body>
</html>
