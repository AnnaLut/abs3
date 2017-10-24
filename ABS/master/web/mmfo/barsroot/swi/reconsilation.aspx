<%@ Page Language="C#" AutoEventWireup="true" CodeFile="reconsilation.aspx.cs" Inherits="swi_reconsilation" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>NOSTRO Reconsilation</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
</head>
<body>
    <form id="frm_reconsilation" runat="server">
    <div class="pageTitle">
            <asp:Label ID="lbTitle" runat="server" Text="NOSTRO Reconciliation"/>
        </div>
        <asp:Panel runat="server" ID="pnMT950" GroupingText="ВИПИСКИ" Style="margin-left: 10px; margin-right: 10px">
            <table>
                <tr>
                    <td style="align-content:center">
                        <asp:ImageButton runat="server" ToolTip="Встановити відмітку ОБРОБЛЕНА" ID="btChangeStatus" ImageUrl="~/swi/images/check.png" OnClick="STMT_PROCESSED_Changed" OnClientClick ="return confirm('Встановити статус оброблено?');"/>
                        <asp:ImageButton runat="server" ToolTip="Процедура автоматической привязки исходных  сообщений  к строкам выписки, которые имеют признак наличия исходного сообщения.  Поиск исходного сообщения,  соответствующего строке  выписки  выполняется  по   референсу   сообщения (подполе 8 или подполе 7 выписки), дате валютирования  и сумме транзакции" ID="btAutoLink" ImageUrl="~/swi/images/gear_run.png" OnClick="btAutoLink_Click" OnClientClick ="return confirm('Виконати автопривязку повідомлень?');"/>
                        <asp:RadioButton runat="server" ID="rbAll" GroupName="MT950" AutoPostBack="true" Text="Всі" Checked="true" OnCheckedChanged="btRefresh_gvMain"/>
                        <asp:RadioButton runat="server" ID="rbAccessed" GroupName="MT950" AutoPostBack="true" Text="Оброблені" OnCheckedChanged="btRefresh_gvMain"/>
                        <asp:RadioButton runat="server" ID="rbNoAccessed" GroupName="MT950" AutoPostBack="true" Text="Не оброблені" OnCheckedChanged="btRefresh_gvMain"/>
                    </td>
                </tr>
                <tr>
                <td>
         <BarsEx:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
                <BarsEx:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="True" AllowSorting="True" DataKeyNames="STMT_REF"
                    DataSourceID="dsMain" CssClass="barsGridView" ShowPageSizeBox="true"
                    AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="ServerSelect" OnDataBound="gvMain_DataBound"
                    OnRowDataBound="gvMain_RowDataBound"
                    PagerSettings-PageIndex="0" OnRowClicked="gvMain_RowClicked"
                    PageSize="10">
                    <SelectedRowStyle CssClass="selectedRow" />
                      <Columns>
                        <asp:BoundField DataField="STMT_REF" HeaderText="Реф. виписки" />
                        <asp:BoundField DataField="SENDER_BIC" HeaderText="Відправник виписки" />
                        <asp:BoundField DataField="STMT_TRN" HeaderText="SWIFT реф. виписки" />   
                        <asp:BoundField DataField="STMT_PAGE" HeaderText="№ сторінки виписки" />           
                        <asp:BoundField DataField="LORO_ACCNUM" HeaderText="Рахунок виписки(LORO)" />     
                        <asp:BoundField DataField="STMT_CURRCODE" HeaderText="Код валюти виписки" />     
                        <asp:BoundField DataField="STMT_CURRENCY" HeaderText="Валюти виписки" />     
                        <asp:BoundField DataField="STMT_BEG_DATE" HeaderText="Поч. дата виписки" />     
                        <asp:BoundField DataField="STMT_END_DATE" HeaderText="Кінц. дата виписки" />  
                        <asp:BoundField DataField="STMT_REST_IN" HeaderText="Вхідний залишок по виписці" /> 
                        <asp:BoundField DataField="STMT_DEBIT_TURN" HeaderText="Дт. оборот по виписці" />  
                        <asp:BoundField DataField="STMT_CREDIT_TURN" HeaderText="Кт. оборот по виписці" />        
                        <asp:BoundField DataField="STMT_REST_OUT" HeaderText="Вих. залишок по виписці" />        
                        <asp:BoundField DataField="STMT_DETAIL_COUNT" HeaderText="К-сть рядків в виписці" />  
                        <asp:BoundField DataField="STMT_NPROC_COUNT" HeaderText="К-сть необробл. рядків в виписці" /> 
                        <asp:BoundField DataField="NOSTRO_ACCCODE" HeaderText="Ід рахунку в АБС" Visible="true" />  
                        <asp:BoundField DataField="NOSTRO_ACCNUM" HeaderText="Номер рахунку в АБС" />     
                        <asp:BoundField DataField="NOSTRO_ACCNAME" HeaderText="Назва" />
                          <asp:TemplateField HeaderText="Стан виписки" ItemStyle-HorizontalAlign="Center">
                              <ItemTemplate>
                                  <asp:CheckBox runat="server" ID="STMT_PROCESSED" Checked='<%# Convert.ToInt32(Eval("STMT_PROCESSED")) == 1 ? true : false %>' Enabled="false"/>
                              </ItemTemplate>
                          </asp:TemplateField>
                        <asp:BoundField DataField="NOSTRO_REST_IN" HeaderText="Вх.зал. на рах. в АБС" />   
                        <asp:BoundField DataField="NOSTRO_REST_OUT" HeaderText="Вих.зал. на рах. в АБС" />   
                        <asp:BoundField DataField="NOSTRO_TRN_COUNT" HeaderText="К-сть операцій по рах. в АБС" />                                           
                    </Columns>
                </BarsEx:BarsGridViewEx>
                    </td>
                    </tr>
            </table>
        </asp:Panel>
        <asp:Panel runat="server" ID="pnDetail" GroupingText="ДЕТАЛІ">
<table>
          <tr>
            <td style="vertical-align:top"> 
               <asp:ImageButton runat="server" ID="btSwtView" ToolTip="Перегляд SWIFT повідомлення або документу" ImageUrl="~/swi/images/form_blue.png" OnClick="btSwtView_Click"/> 
               <asp:ImageButton runat="server" ID="btRun" ToolTip="Обробити повідомлення" ImageUrl="~/swi/images/gear_ok.png" OnClick="btRun_Click"/> 
               <asp:ImageButton runat="server" ID="btUnlinkDoc" ToolTip="Відвязати документ" ImageUrl="~/swi/images/arrow_right.png" OnClick="btUnlinkDoc_Click" OnClientClick ="return confirm('Ви впевнені?');"/>    
               <asp:ImageButton runat="server" ID="btLinkSwt" ToolTip="Привязати повідомлення" ImageUrl="~/swi/images/copy.png" OnClick="btLinkSwt_Click" OnClientClick ="return confirm('Ви впевнені?');"/>
                <asp:ImageButton runat="server" ID="btUnlink" ToolTip="Відвязати повідомлення" ImageUrl="~/swi/images/delete.png" OnClick="btUnlink_Click" OnClientClick ="return confirm('Ви впевнені?');"/>    
            <BarsEx:BarsSqlDataSourceEx ID="dsMainDetail" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
                <BarsEx:BarsGridViewEx ID="gvMainDetail" runat="server" AllowPaging="True" AllowSorting="True" DataKeyNames="NUMROW"
                    DataSourceID="dsMainDetail" CssClass="barsGridView" ShowPageSizeBox="true"
                    AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="ServerSelect"
                    OnRowDataBound="gvMainDetail_RowDataBound" OnRowClicked="gvMainDetail_RowClicked" OnDataBound="gvMainDetail_DataBound"
                    PagerSettings-PageIndex="0"
                    PageSize="10">
                    <SelectedRowStyle CssClass="selectedRow" />
                      <Columns>
                          <asp:BoundField DataField="NUMROW" HeaderText="№ п/п" />
                          <asp:BoundField DataField="VDATE" HeaderText="Дата валютування" />
                          <asp:BoundField DataField="DEBIT_SUM" HeaderText="Дебет" />
                          <asp:BoundField DataField="CREDIT_SUM" HeaderText="Кредит" />
                          <asp:BoundField DataField="PROCESSED" HeaderText="Признак обробки" />
                          <asp:BoundField DataField="SWTT" HeaderText="Тип транзакції" />
                          <asp:BoundField DataField="SRC_SWREF" HeaderText="Референс вихідного повідомлення" />
                          <asp:BoundField DataField="THEIR_REF" HeaderText="Референс транзакції" />
                          <asp:BoundField DataField="MT" HeaderText="Тип повідомлення" />
                          <asp:BoundField DataField="DETAIL" HeaderText="Деталі" />

                     </Columns>
                </BarsEx:BarsGridViewEx>
            </td>
            <td style="vertical-align:top">
                <asp:ImageButton runat="server" ID="btViewDOc" ToolTip="Перегляд документу" ImageUrl="~/swi/images/document.png" OnClick="btViewDOc_Click"/> 
                <asp:ImageButton runat="server" ID="btLinkDoc" ToolTip="Заквитувати документ" ImageUrl="~/swi/images/arrow_left.png" OnClick="btLinkDoc_Click"/> 
                <BarsEx:BarsSqlDataSourceEx ID="dsMainDoc" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
                <BarsEx:BarsGridViewEx ID="gvMainDoc" runat="server" AllowPaging="True" AllowSorting="True" DataKeyNames="REF"
                    DataSourceID="dsMainDoc" CssClass="barsGridView" ShowPageSizeBox="true"
                    AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="SingleRow"
                    OnRowDataBound="gvMainDoc_RowDataBound"
                    PagerSettings-PageIndex="0"
                    PageSize="10">
                    <SelectedRowStyle CssClass="selectedRow" />
                      <Columns>
                          <asp:BoundField DataField="FDAT" HeaderText="Дата валютування документу в АБС" />
                          <asp:BoundField DataField="REF" HeaderText="Референс документу" />
                          <asp:BoundField DataField="DETAIL" HeaderText="Деталі документу" />
                          <asp:BoundField DataField="TT" HeaderText="Код операції" />
                          <asp:BoundField DataField="S" HeaderText="Сума операції" />
                        </Columns>
                </BarsEx:BarsGridViewEx>
            </td> 
         <tr>
    </table>
        </asp:Panel>
    </form>
</body>
</html>
