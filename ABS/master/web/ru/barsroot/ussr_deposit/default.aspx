<%@ Page Language="C#" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="deposit_compensation_Default" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
		<title>Компенсаційні вклади</title>
		<script type="text/javascript" language="javascript" src="js/func.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
		<link href="css/dpt.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <form id="frmPayment" runat="server">
    <table class="MainTable">
    <tr>
        <td align="center">
            <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" 
                Text="Картка вкладника" meta:resourcekey="lbTitleResource2"></asp:Label></td>
    </tr>
    <tr>
        <td>
            <table class="InnerTable">
                <tr>
                    <td colspan="7" align="left">
                        <asp:Label ID="lbFIlter" runat="server" CssClass="InfoLabel" 
                            Text="Пошук клієнта" meta:resourcekey="lbFIlterResource1"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width:15%">
                        </td>
                    <td style="width:20%">
                        <asp:TextBox ID="SERIAL" runat="server" CssClass="InfoText95" meta:resourcekey="SERIALResource2" MaxLength="2" TabIndex="1" ToolTip="Серія документа" ></asp:TextBox></td>
                    <td style="width:25%">
                        <asp:TextBox ID="NUMBER" runat="server" CssClass="InfoText95" meta:resourcekey="NUMBERResource2" MaxLength="6" TabIndex="2" ToolTip="Номер документа" ></asp:TextBox></td>
                    <td style="width:15%" align="right">
                        <asp:Label ID="lbDptType" runat="server" CssClass="InfoText95"
                            Text="Вид документа" meta:resourcekey="lbDptTypeResource1"></asp:Label></td>
                    <td style="width:15%">
                        <asp:DropDownList ID="ddType" runat="server" CssClass="BaseDropDownList" TabIndex="2"
                            ToolTip="Вид документа" meta:resourcekey="ddTypeResource2">
                        </asp:DropDownList></td>
                    <td style="width:10%">                    
                        <cc1:imagetextbutton id="btSearch" runat="server" imageurl="\Common\Images\default\16\refresh.png"
                            text="Пошук" EnabledAfter="0" ToolTip="Пошук" meta:resourcekey="btSearchResource2" OnClick="btSearch_Click" TabIndex="5"></cc1:imagetextbutton>
                    </td>
                </tr>                
                <tr>
                    <td>
                        <asp:Label ID="lbNMK" runat="server" CssClass="InfoText95"
                            Text="ПІБ клієнта" meta:resourcekey="lbNMKResource1"></asp:Label></td>
                    <td colspan="5">
                        <asp:TextBox ID="sFIO" runat="server" CssClass="InfoText95" MaxLength="70"
                            TabIndex="3" meta:resourcekey="sFIOResource1"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbDBCODE" runat="server" CssClass="InfoText95"
                            Text="DBCODE" meta:resourcekey="lbDBCODEResource1"></asp:Label></td>
                    <td colspan="5">
                        <asp:TextBox ID="DBCODE" runat="server" CssClass="InfoText95" MaxLength="11" meta:resourcekey="sFIOResource1"
                            TabIndex="4"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="7">
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <asp:Label ID="lbError" runat="server" CssClass="InfoText95" ForeColor="Red"
                            Text="Вкладника не знайдено!" Visible="False" meta:resourcekey="lbErrorResource1"></asp:Label></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table id="tblClientInfo" runat="server" class="InnerTable">
                <tr>
                    <td>
                        <bars:barsgridview id="gridClients" runat="server" autogeneratecolumns="False" cssclass="BaseGrid"
                            datasourceid="dsClients" datemask="dd/MM/yyyy" meta:resourcekey="gridDepositsResource2" TabIndex="20" AllowPaging="True" AllowSorting="True" ShowPageSizeBox="True" OnRowCommand="gridClients_RowCommand" >
                            <Columns>
                                <asp:ButtonField CommandName="GET_DEPOSITS" DataTextField="CARD" DataTextFormatString="Депозити клієнта РНК={0}"
                                    Text="Button" meta:resourcekey="ButtonFieldResource2">
                                    <itemstyle horizontalalign="Center" />
                                </asp:ButtonField>
                                <asp:BoundField DataField="RNK" HeaderText="РНК" meta:resourcekey="BoundFieldResource11"
                                    SortExpression="RNK" HtmlEncode="False">
                                    <itemstyle horizontalalign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="NMK" HeaderText="ПІБ" meta:resourcekey="BoundFieldResource12"
                                    SortExpression="NMK">
                                    <itemstyle horizontalalign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="OKPO" HeaderText="Ід. код" meta:resourcekey="BoundFieldResource13"
                                    SortExpression="OKPO">
                                    <itemstyle horizontalalign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="SER" HeaderText="Серія" meta:resourcekey="BoundFieldResource14"
                                    SortExpression="SER">
                                    <itemstyle horizontalalign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="NUMDOC" HeaderText="Номер" meta:resourcekey="BoundFieldResource15"
                                    SortExpression="NUMDOC">
                                    <itemstyle horizontalalign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="DBCODE" HeaderText="DBCODE" 
                                    SortExpression="DBCODE" meta:resourcekey="BoundFieldResource21">
                                    <itemstyle horizontalalign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ORG" HeaderText="Виданий" meta:resourcekey="BoundFieldResource16"
                                    SortExpression="ORG">
                                    <itemstyle horizontalalign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ADR" HeaderText="Адреса" meta:resourcekey="BoundFieldResource17"
                                    SortExpression="ADR">
                                    <itemstyle horizontalalign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="BRANCH" HeaderText="Код відділення" meta:resourcekey="BoundFieldResource18"
                                    SortExpression="BRANCH">
                                    <itemstyle horizontalalign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="BRANCH_NAME" HeaderText="Відділення" meta:resourcekey="BoundFieldResource19"
                                    SortExpression="BRANCH_NAME">
                                    <itemstyle horizontalalign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="LIM" HeaderText="Ліміт" meta:resourcekey="BoundFieldResource20"
                                    SortExpression="to_number(replace(LIM, ' ', ','),'FM999G999G999G990D00')">
                                    <itemstyle horizontalalign="Right" wrap="False" />
                                </asp:BoundField>
                            </Columns>
                    </Bars:BarsGridView>
                        </td>
                </tr>
                <tr>
                    <td>
                        <bars:barssqldatasource id="dsClients" ProviderName="barsroot.core" runat="server">
                        </Bars:BarsSqlDataSource>
                        </td>
                </tr>
                <tr>
                    <td>
                        <table id="tblAllDeposits" class="InnerTable" runat="server" visible="false">
                            <tr>
                                <td>
                                    <asp:Label ID="lbClientsDeposits" runat="server" CssClass="InfoLabel" 
                                        Text="Депозити вибраного клієнта" meta:resourcekey="lbClientsDepositsResource1"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    <bars:barsgridview id="gridDeposits" runat="server" autogeneratecolumns="False" cssclass="BaseGrid"
                                        datasourceid="dsDeposits" datemask="dd/MM/yyyy" meta:resourcekey="gridDepositsResource2" OnRowDataBound="gridDeposits_RowDataBound" TabIndex="20" >
                                        <Columns>
<asp:BoundField HtmlEncode="False" DataField="DPT_ID" SortExpression="DPT_ID" HeaderText="*" meta:resourceKey="BoundFieldResource10">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="SDPTID" HeaderText="Сист. № депозиту" meta:resourcekey="BoundFieldResource22"></asp:BoundField>
<asp:BoundField DataField="DPT_NUM" SortExpression="DPT_NUM" HeaderText="№ депозиту" meta:resourceKey="BoundFieldResource1">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="TYPE_NAME" HeaderText="Вид" meta:resourceKey="BoundFieldResource4">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
</asp:BoundField>
<asp:BoundField HtmlEncode="False" DataField="NLS" HeaderText="Рахунок" meta:resourceKey="BoundFieldResource2">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
</asp:BoundField>
<asp:BoundField HtmlEncode="False" DataField="NLS_CORRECT" SortExpression="NLS_CORRECT" HeaderText="*" meta:resourcekey="BoundFieldResource23"></asp:BoundField>
<asp:BoundField DataField="KV" HeaderText="Валюта" meta:resourceKey="BoundFieldResource5">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="INIT" SortExpression="INIT" HeaderText="Початковий залишок" meta:resourceKey="BoundFieldResource8">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="OSTC" HeaderText="Поточний залишок" meta:resourceKey="BoundFieldResource3">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="PAID" SortExpression="PAID" HeaderText="Виплачено" meta:resourceKey="BoundFieldResource9">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="TOBO" HeaderText="Код відділення" meta:resourceKey="BoundFieldResource6">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="TOBO_NAME" HeaderText="Назва відділення" meta:resourceKey="BoundFieldResource7">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
</asp:BoundField>
</Columns>
                                    </bars:barsgridview>
                                </td>
                            </tr>                            
                        </table>
                    </td>
                </tr>
            </table>
            <bars:barssqldatasource id="dsDeposits" ProviderName="barsroot.core" runat="server"></bars:barssqldatasource>
        </td>
    </tr>
    <tr>
        <td>
            <table id="tblDeposit" runat="server" style="visibility:hidden" class="InnerTable">
                <tr>
                    <td>
                        <asp:Label ID="lbDPTPARAM" runat="server" CssClass="InfoLabel" 
                            Text="Параметри вибраного вкладу" meta:resourcekey="lbDPTPARAMResource1"></asp:Label></td>
                </tr>    
                <tr>
                    <td>
                        <table class="InnerTable">
                            <tr>
                                <td style="width:20%">
                                    <asp:Label ID="lbDPTDATE" runat="server" CssClass="InfoText95" 
                                        Text="Початок" meta:resourcekey="lbDPTDATEResource1"></asp:Label></td>
                                <td style="width:20%">
                                    <cc1:DateEdit ID="DATBEGIN" runat="server" Date="" MaxDate="2099-12-31"  MinDate="" meta:resourcekey="DATBEGINResource2" Text="01/01/0001 00:00:00" ReadOnly="True" TabIndex="22"></cc1:DateEdit></td>
                                <td style="width:20%">
                                    <asp:Label ID="lbDPTEND" runat="server" CssClass="InfoText95" 
                                        Text="Завершення" meta:resourcekey="lbDPTENDResource1"></asp:Label></td>
                                <td style="width:10%">
                                    <cc1:DateEdit ID="DATEND" runat="server" Date="" MaxDate="2099-12-31" MinDate="" meta:resourcekey="DATENDResource2" Text="01/01/0001 00:00:00" ReadOnly="True" TabIndex="23"></cc1:DateEdit></td>
                                <td style="width:20%">
                                    </td>
                                <td style="width:10%">
                                    <cc1:imagetextbutton id="btShowDocs" runat="server" imageurl="\Common\Images\default\16\open.png"
                                        text="Документи" EnabledAfter="0" TabIndex="26" OnClientClick="ShowDocs(); return;" meta:resourcekey="btShowDocsResource1" ToolTip="Документи" AutoSize="False" CssClass="AcceptButton"></cc1:imagetextbutton>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbBLKD_title" runat="server" CssClass="InfoText95"
                                        Text="Код блокування дебет" meta:resourcekey="lbBLKD_titleResource1"></asp:Label></td>
                                <td>
                                    <asp:Label ID="lbBLKD" runat="server" CssClass="InfoText95" ForeColor="Red" meta:resourcekey="lbBLKDResource1"></asp:Label></td>
                                <td>
                                    <asp:Label ID="lbBLKK_title" runat="server" CssClass="InfoText95"
                                        Text="Код блокування кредит" meta:resourcekey="lbBLKK_titleResource1"></asp:Label>
                                    </td>
                                <td>
                                    <asp:Label ID="lbBLKK" runat="server" CssClass="InfoText95" ForeColor="Red" meta:resourcekey="lbBLKKResource1"></asp:Label></td>
                                <td>
                                    </td>
                                <td>
                                    <cc1:ImageTextButton ID="btHistory" runat="server" AutoSize="False" CssClass="AcceptButton"
                                        ImageUrl="\Common\Images\default\16\reference_open.png" OnClientClick="ShowHistory(); return;" Text="Історія" EnabledAfter="0" meta:resourcekey="btHistoryResource1" ToolTip="Історія" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="visibility:hidden">
                        <asp:Label ID="lbToPAY" runat="server" CssClass="InfoLabel" 
                            Text="До сплати з вкладу" meta:resourcekey="lbToPAYResource1"></asp:Label></td>
                </tr>
                <tr>
                    <td style="height: 86px">
                        <table class="InnerTable" runat="server" id="tbl_payoff" style="visibility:hidden">
                            <tr>
                                <td>
                                    <cc1:ImageTextButton ID="btPay" runat="server" ImageUrl="\Common\Images\default\16\ok.png"
                                        Text="Виплата" EnabledAfter="0" ToolTip="Оплатити" meta:resourcekey="btPayResource2" TabIndex="1000" OnClientClick="if (!ckCtrls()) return;" OnClick="btPay_Click" />
                                </td>
                            </tr>                            
                        </table>
                        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
                            <Scripts>
                                <asp:ScriptReference Path="js/js.js" />
                            </Scripts>
                        </asp:ScriptManager>                        
                        <input type="hidden" id="RNK" runat="server" />
                        <input type="hidden" id="err_n" runat="server" />
                        <input type="hidden" id="NOWCKMFO" runat="server" />
                        <input type="hidden" id="SUM_TOVALIDATE" runat="server" />
                        <input type="hidden" id="DPT_ID" runat="server" />
                    </td>
                </tr>
            </table>    
        </td>
    </tr>
    </table>
        <script language="javascript" type="text/javascript">
            if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
            focusControl('SERIAL');
            document.getElementById('SERIAL').attachEvent("onkeypress",ckSerial);
            document.getElementById('NUMBER').attachEvent("onkeypress",pressSearch);
            document.getElementById('NUMBER').attachEvent("onkeydown",doNum);
            document.getElementById('sFIO').attachEvent("onkeypress",pressSearch);
            document.getElementById('DBCODE').attachEvent("onkeypress",pressSearch);
            document.getElementById('ddType').attachEvent("onkeypress",pressSearch);
        </script>    
    </form>
</body>
</html>
