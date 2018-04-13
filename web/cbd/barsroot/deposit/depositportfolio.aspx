<%@ Page Language="C#" AutoEventWireup="true" CodeFile="depositportfolio.aspx.cs" Inherits="deposit_depositportfolio" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register assembly="Bars.Web.Controls.2" namespace="UnityBars.WebControls" tagprefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Register src="../UserControls/DateEdit.ascx" tagname="DateEdit" tagprefix="uc1" %>
<%@ Register src="../UserControls/loading.ascx" tagname="loading" tagprefix="uc2" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Депозитний модуль: Портфель</title>
    <link href="../UserControls/style/jscal2.css" type="text/css" rel="stylesheet" /> 
	<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
	<link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet"/>		
	<script type="text/javascript" language="javascript" src="js/js.js"></script>
    <script type="text/javascript" language="javascript" src="js/ck.js"></script>
</head>
<body>
    <form id="form1" runat="server">
		<asp:ScriptManager ID="ScriptManager" EnablePartialRendering="true" runat="server">
        </asp:ScriptManager>        
            <table class="MainTable">
                <tr>
                    <td align="center">
                        <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" Text="Портфель вкладов населения" meta:resourcekey="lbTitleResource1"></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        <table class="InnerTable">
                            <tr>
                                <td style="width:15%">
                                    <asp:Label ID="lbStartDate" runat="server" CssClass="InfoText" Text="Початок періоду" meta:resourcekey="lbStartDateResource1"></asp:Label></td>
                                <td style="width:35%">
                                    <uc1:DateEdit ID="StartDate" runat="server" Required="True" />
                                </td>
                                <td style="width: 15%">
                                    <asp:Label ID="lbEndDate" runat="server" CssClass="InfoText" Text="Кінець періоду" meta:resourcekey="lbEndDateResource1"></asp:Label>
                                </td>
                                <td style="width:35%">
                                    <uc1:DateEdit ID="EndDate" runat="server" Required="True" ControlToCompare="EndDate" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">                            
                                    <asp:ValidationSummary ID="l_summary" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btRefresh" runat="server" TabIndex="1" ToolTip="Оновити інформацію" Text="Оновити"
                                        Width="250" OnClientClick="if (GetFilter())" />
                                </td>
                                <td>
                                    <cc1:ImageTextButton ID="btPayOffResource" runat="server" ButtonStyle="Text" ImageUrl="\Common\Images\default\16\reference_open.png"
                                        TabIndex="3" ToolTip="Ресурс по термінам погашення" EnabledAfter="0" Width="250"
                                        OnClientClick="location.replace('depositpayoffresource.aspx'); return;" 
                                        Text="Ресурс по термінам погашення" CausesValidation="False" />
                                </td>
                                <td></td>
                                <td></td>
                            </tr>
                        </table>
                    </td>
                </tr>        
                <tr>
                    <td>
                        <table class="InnerTable">
                            <tr>
                                <td colspan="2" align="center">
                                    <asp:Label ID="lbFIlter" runat="server" CssClass="InfoLabel" meta:resourcekey="lbFIlter"
                                        Text="Критерии формирования"></asp:Label></td>                    
                            </tr>
                            <tr>
                                <td style="width:50%" rowspan="6">
                                    <table id="FILTER" class="InnerTable" style="width:100%" runat="server">
                                        <tr>
                                            <td align="center" style="width:5%">
                                                <asp:Label ID="lbMark" runat="server" CssClass="InfoText"
                                                    Text="*" meta:resourcekey="lbMarkResource1" Font-Bold="True"></asp:Label></td>
                                            <td style="width:25%">
                                                <asp:Label ID="lbOrder" runat="server" CssClass="InfoText"
                                                    Text="Порядок" meta:resourcekey="lbOrderResource1" Font-Bold="True"></asp:Label></td>
                                            <td style="width:100%">
                                                <asp:Label ID="lbCriteria" runat="server" CssClass="InfoText"
                                                    Text="Разрез" meta:resourcekey="lbCriteriaResource1" Font-Bold="True"></asp:Label></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 50%">
                                </td>
                                <td style="width: 10%">
                                </td>
                                <td style="width: 40%">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="uPanel" UpdateMode="Conditional" runat="server">
                        <ContentTemplate>
                            <Bars:BarsGridViewEx ID="gridPortfolio" style='width:100%' runat="server" DataSourceID="dsPortfolio"
                                AutoGenerateColumns="False" CssClass="barsGridView" AllowPaging="True" 
                                AllowSorting="True" ShowPageSizeBox="true" EnableViewState="true" >
                                <Columns>
                                    <asp:BoundField DataField="DPTSAL1" HeaderText="Сумма вкладов на начало" meta:resourcekey="BoundFieldResource6"
                                        SortExpression="DPTSAL1" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false" />
                                    <asp:BoundField DataField="RAT1" HeaderText="Средне- взвешенная % ставка на начало" meta:resourcekey="BoundFieldResource7"
                                        SortExpression="RAT1" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false" />
                                    <asp:BoundField DataField="DOSD" HeaderText="Сумма ДТ оборотов по вкладам" meta:resourcekey="BoundFieldResource8"
                                        SortExpression="DOSD" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false" />
                                    <asp:BoundField DataField="KOSD" HeaderText="Сумма КТ оборотов по вкладам" meta:resourcekey="BoundFieldResource9"
                                         SortExpression="KOSD" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false" />
                                    <asp:BoundField DataField="DPTSAL2" HeaderText="Сумма вкладов на конец" meta:resourcekey="BoundFieldResource10"
                                        SortExpression="DPTSAL2" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false"/>
                                    <asp:BoundField DataField="RAT2" HeaderText="Средне- взвешенная % ставка на конец" meta:resourcekey="BoundFieldResource11"
                                        SortExpression="RAT2" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false"/>
                                    <asp:BoundField DataField="PERSAL1" HeaderText="Сумма % на начало" meta:resourcekey="BoundFieldResource12"
                                        SortExpression="PERSAL1" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false"/>
                                    <asp:BoundField DataField="DOSP" HeaderText="Сумма ДТ оборотов по %" meta:resourcekey="BoundFieldResource13"
                                        SortExpression="DOSP" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false"/>
                                    <asp:BoundField DataField="KOSP" HeaderText="Сумма КТ оборотов по %" meta:resourcekey="BoundFieldResource14"
                                        SortExpression="KOSP" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false"/>
                                    <asp:BoundField DataField="PERSAL2" HeaderText="Сумма % на конец" meta:resourcekey="BoundFieldResource15"
                                        SortExpression="PERSAL2" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false"/>
                                    <asp:BoundField DataField="ACC1" HeaderText="К-во счетов на начало" meta:resourcekey="BoundFieldResource16"
                                        SortExpression="ACC1" ItemStyle-HorizontalAlign="Center" ItemStyle-Wrap="false"/>
                                    <asp:BoundField DataField="ACCO" HeaderText="Открыто счетов" meta:resourcekey="BoundFieldResource17" 
                                        SortExpression="ACCO" ItemStyle-HorizontalAlign="Center" ItemStyle-Wrap="false"/>
                                    <asp:BoundField DataField="ACCC" HeaderText="Закрито рахунків" meta:resourcekey="BoundFieldResource18" 
                                        SortExpression="ACCC" ItemStyle-HorizontalAlign="Center" ItemStyle-Wrap="false"/>
                                    <asp:BoundField DataField="ACC2" HeaderText="К-ть рахунків на кінець" meta:resourcekey="BoundFieldResource19" 
                                        SortExpression="ACC2" ItemStyle-HorizontalAlign="Center" ItemStyle-Wrap="false"/>
                                </Columns>
                            </Bars:BarsGridViewEx>
                            <asp:UpdateProgress ID="updateProgressBars" runat="server" 
                                AssociatedUpdatePanelID="uPanel">
                                    <ProgressTemplate>                        
                                        <uc2:loading ID="sync_loading" runat="server" />
                                        </ProgressTemplate>
                            </asp:UpdateProgress>                            
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Bars:BarsSqlDataSourceEx AllowPaging="true" ID="dsPortfolio" runat="server" ProviderName="barsroot.core">
                        </Bars:BarsSqlDataSourceEx>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:CustomValidator ID="cvRange" runat="server" Display="None" 
                            ErrorMessage="Дата начала периода больше даты завершения"
                            ClientValidationFunction="rangeValidate">
                        </asp:CustomValidator>
                        <input type="hidden" runat="server" id="CLIENT_FILTER" />
                        <input type="hidden" runat="server" id="FILTER_POS" />
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
            </table>
            <script type="text/javascript">
                window.attachEvent("onload", InitFilter);
                function rangeValidate(source, args) {
                    args.IsValid = (fnDateParse(window['<%= StartDate.DateInput.ClientID %>'].GetValue()) <= fnDateParse(window['<%= EndDate.DateInput.ClientID %>'].GetValue()));
                }         
            </script>
    </form>
</body>
</html>
