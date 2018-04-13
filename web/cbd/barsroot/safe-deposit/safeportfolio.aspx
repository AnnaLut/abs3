<%@ Page Language="C#" AutoEventWireup="true" CodeFile="safeportfolio.aspx.cs" Inherits="safe_deposit_Default" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Депозитні сейфи: Портфель</title>
    <script type="text/javascript" src="js/JScript.js"></script>
	<script type="text/javascript" language="javascript" src="/Common/WebEdit/RadInput.js"></script>        
    <link type="text/css" rel="stylesheet" href="style/style.css" />
	<link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <form id="portfolio" runat="server">
    <table class="MainTable">
        <tr>
            <td align="center">
                <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" 
                    meta:resourcekey="lbTitle">Депозитні сейфи: Портфель</asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable">
                    <tr>
                        <td colspan="5">
                            <table id="buttonTable" class="InnerTable">
                                <tr>
                                    <td style="width:1%">
                                        <cc1:imagetextbutton id="btSearch" runat="server" ButtonStyle="Image" ImageUrl="/Common\Images\default\16\refresh.png" OnClick="btSearch_Click" ToolTip="Обновить" TabIndex="1" EnabledAfter="0" meta:resourcekey="btSearchResource1"></cc1:imagetextbutton>
                                    </td>
                                    <td style="width:1%">
                                        <cc1:Separator ID="Separator4" runat="server" BorderWidth="1px" meta:resourcekey="Separator4Resource1" />
                                    </td>
                                    <td style="width:1%">
                                        <cc1:imagetextbutton id="btNew" runat="server" ButtonStyle="Image" ImageUrl="/Common\Images\default\16\new.png" ToolTip="Создать новый сейф" TabIndex="2" OnClientClick="return CreateSafe()" EnabledAfter="0" meta:resourcekey="btNewResource1"></cc1:imagetextbutton>
                                        </td>
                                    <td style="width:1%">
                                        <cc1:ImageTextButton ID="btDelete" runat="server" ButtonStyle="Image" ImageUrl="/Common\Images\default\16\cancel.png" OnClick="btDelete_Click" OnClientClick="if (InvalidSafe()) return;" TabIndex="3" ToolTip="Закрыть сейф" EnabledAfter="0" meta:resourcekey="btDeleteResource1" />
                                    </td>
                                    <td style="width:1%">
                                        <cc1:Separator ID="Separator1" runat="server" BorderWidth="1px" meta:resourcekey="Separator1Resource1" />
                                    </td>
                                    <td style="width:1%">
                                        <cc1:imagetextbutton id="btOpen" runat="server" ButtonStyle="Image" ImageUrl="/Common\Images\default\16\open.png" OnClientClick="return OpenSafe()" ToolTip="Открыть карточку сейфа" TabIndex="4" EnabledAfter="0" meta:resourcekey="btOpenResource1"></cc1:imagetextbutton>
                                    </td>
                                    <td style="width:1%">
                                        <cc1:Separator ID="Separator2" runat="server" BorderWidth="1px" meta:resourcekey="Separator2Resource1" />
                                    </td>
                                    <td style="width:1%">
                                        <cc1:ImageTextButton ID="btPay" runat="server" ButtonStyle="Image" ImageUrl="/Common\Images\default\16\ok.png" OnClientClick="if (ckClient()) return;" ToolTip="Оплатить" TabIndex="5" EnabledAfter="0" meta:resourcekey="btPayResource1" />
                                    </td>
                                    <td style="width:1%">
                                        <cc1:Separator ID="Separator3" runat="server" BorderWidth="1px" meta:resourcekey="Separator3Resource1" />
                                    </td>
                                    <td style="width:1%">
                                        <cc1:ImageTextButton ID="btPrint" runat="server" ButtonStyle="Image" ImageUrl="/Common\Images\default\16\visa.png"
                                            OnClientClick="PrintDialog(); return;" TabIndex="6" ToolTip="Печать" EnabledAfter="0" meta:resourcekey="btPrintResource1" />
                                    </td>
                                    <td style="width:1%">
                                        <cc1:ImageTextButton ID="btDocs" runat="server" ButtonStyle="Image" ImageUrl="/Common\Images\default\16\open_blue.png"
                                            OnClientClick="if (getDealId()) return;" ToolTip="Документы по договору" TabIndex="7" EnabledAfter="0" meta:resourcekey="btDocsResource1" />
                                    </td>
                                    <td style="width:1%">
                                        <cc1:ImageTextButton ID="bindDoc" runat="server" ButtonStyle="Image" ImageUrl="/Common\Images\default\16\lock_open.png"
                                            OnClientClick="if (getDealtoBindDoc()) return;" ToolTip="Привязать / Отвязать документы" TabIndex="8" EnabledAfter="0" meta:resourcekey="bindDocResource1" />
                                    </td>
                                    <td style="width: 1%">
                                        <cc1:ImageTextButton ID="btVisit" runat="server" ButtonStyle="Image" ImageUrl="/Common\Images\default\16\reference_open.png"
                                            OnClientClick="if (Visit()) return true;" TabIndex="9" ToolTip="Посещение хранилища" EnabledAfter="0" meta:resourcekey="ImageTextButton1Resource1" />
                                    </td>
                                    <td style="width:1%">
                                        <cc1:ImageTextButton ID="btArchive" runat="server" ButtonStyle="Image" ImageUrl="/Common\Images\default\16\calendar.png"
                                            OnClientClick="ShowArchive();return;" ToolTip="Архив" TabIndex="10" EnabledAfter="0" meta:resourcekey="btArchiveResource1" />
                                    </td>
                                    <td style="width:100%"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 15%">
                            <asp:Label style="text-align:center" ID="lbRef" runat="server" CssClass="InfoText" 
                                meta:resourcekey="lbRef" Text="Реф.  договору"></asp:Label>
                        </td>
                        <td style="width: 15%">
                            <asp:Label ID="lbNum" runat="server" CssClass="InfoText" meta:resourcekey="lbNum"
                                Style="text-align: center">№ договору</asp:Label>
                        </td>
                        <td style="width: 20%">
                            <asp:Label ID="lbdat_begin" runat="server" CssClass="InfoText" meta:resourcekey="lbdat_begin"
                                Style="text-align: center">Початок договору</asp:Label></td>
                        <td style="width: 20%">
                            <asp:Label ID="lbdat_end" runat="server" CssClass="InfoText" meta:resourcekey="lbdat_end"
                                Style="text-align: center">Завершення договору</asp:Label></td>
                        <td style="width: 30%">
                            <asp:Label ID="lbNLS" runat="server" CssClass="InfoText" meta:resourcekey="lbNLS"
                                Style="text-align: center">Рахунок</asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="REF" runat="server" CssClass="InfoText95" TabIndex="20" meta:resourcekey="REFResource1"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="NUM" runat="server" CssClass="InfoText95" TabIndex="21" meta:resourcekey="NUMResource1"></asp:TextBox></td>
                        <td>
                            <cc1:DateEdit ID="DAT_BEGIN" runat="server" MinDate="" TabIndex="22" Date="" MaxDate="2099-12-31" meta:resourcekey="DAT_BEGINResource1">01/01/0001 00:00:00</cc1:DateEdit></td>
                        <td>
                            <cc1:DateEdit ID="DAT_END" runat="server" MinDate="" TabIndex="23" Date="" MaxDate="2099-12-31" meta:resourcekey="DAT_ENDResource1">01/01/0001 00:00:00</cc1:DateEdit></td>
                        <td>
                            <asp:TextBox ID="NLS" runat="server" CssClass="InfoText95" TabIndex="28" meta:resourcekey="NLSResource1"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbSafeNum" runat="server" CssClass="InfoText" meta:resourcekey="lbSafeNum"
                                Style="text-align: center" Text="№ сейфа"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbSafeType" runat="server" CssClass="InfoText" meta:resourcekey="lbSafeType"
                                Style="text-align: center">Вид сейфа</asp:Label></td>
                        <td colspan="2">
                            <asp:Label ID="lbNmk" runat="server" CssClass="InfoText" meta:resourcekey="lbNmk"
                                Style="text-align: center">Ким зайнятий</asp:Label></td>
                        <td>
                            <asp:Label ID="lbTrustee" runat="server" CssClass="InfoText" meta:resourcekey="lbTrustee"
                                Style="text-align: center">Довірена особа</asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="SAFENUM" runat="server" CssClass="InfoText95" TabIndex="25" meta:resourcekey="SAFENUMResource1"></asp:TextBox></td>
                        <td>
                            <asp:DropDownList ID="listSafeType" runat="server" CssClass="BaseDropDownList" TabIndex="26" meta:resourcekey="listSafeTypeResource1">
                            </asp:DropDownList></td>
                        <td colspan="2">
                            <asp:TextBox ID="PERSON" runat="server" CssClass="InfoText95" TabIndex="24" meta:resourcekey="PERSONResource1"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="TRUSTEE" runat="server" CssClass="InfoText95" TabIndex="29" meta:resourcekey="TRUSTEEResource1"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <Bars:BarsGridViewEx ID="gridSafeDeposit" style='width:100%; cursor:hand' runat="server" 
                                DataSourceID="dsSafeDeposit"
                                AutoGenerateColumns="False" CssClass="barsGridView" AllowPaging="True" 
                                AllowSorting="True" ShowPageSizeBox="true" EnableViewState="true" 
                                onrowdatabound="gridSafeDeposit_RowDataBound" >
                                <Columns>
                                    <asp:BoundField DataField="SNUM" SortExpression="SNUM" HeaderText="№ сейфа"></asp:BoundField>
                                    <asp:BoundField DataField="TYPE" SortExpression="TYPE" HeaderText="Вид сейфа"></asp:BoundField>
                                    <asp:BoundField DataField="KEYUSED" SortExpression="KEYUSED" HeaderText="Виданий ключ"></asp:BoundField>
                                    <asp:BoundField DataField="A_OSTC" SortExpression="A_OSTC" HeaderText="Застава (факт.)"></asp:BoundField>
                                    <asp:BoundField DataField="FACT_PAY" HeaderText="Орендна плата" SortExpression="FACT_PAY" />
                                    <asp:BoundField DataField="ND" SortExpression="ND" HeaderText="Реф. дог."></asp:BoundField>
                                    <asp:BoundField DataField="NUM" SortExpression="NUM" HeaderText="№ дог."></asp:BoundField>
                                    <asp:BoundField DataField="NMK" SortExpression="NMK" HeaderText="ПІБ"></asp:BoundField>
                                    <asp:BoundField DataField="DAT_BEGIN" SortExpression="DAT_BEGIN" HeaderText="Дата початку"></asp:BoundField>
                                    <asp:BoundField DataField="DAT_END" SortExpression="DAT_END" HeaderText="Дата завершення"></asp:BoundField>
                                    <asp:BoundField DataField="NLS" SortExpression="NLS" HeaderText="Рахунок 2909"></asp:BoundField>
                                    <asp:BoundField DataField="NLS3600" HeaderText="Рахунок 3600" SortExpression="NLS3600" />
                                    <asp:BoundField DataField="DOV_FIO" SortExpression="DOV_FIO" HeaderText="Дов. особа"></asp:BoundField>
                                    <asp:BoundField DataField="N_SK" SortExpression="N_SK" HeaderText="№ сейфа (сист.)"></asp:BoundField>
                                    <asp:BoundField DataField="CUSTTYPE" SortExpression="CUSTTYPE" HeaderText="ЮО-2, ФО-3"></asp:BoundField>
                                    <asp:BoundField DataField="SOS" SortExpression="SOS" HeaderText="*"></asp:BoundField>
                                </Columns>
                                <FooterStyle CssClass="footerRow" />
                                <HeaderStyle CssClass="headerRow" />
                                <EditRowStyle CssClass="editRow" />
                                <PagerStyle CssClass="pagerRow" />
                                <SelectedRowStyle CssClass="selectedRow" />
                                <AlternatingRowStyle CssClass="alternateRow" />
                                <RowStyle CssClass="normalRow" />
                            </Bars:BarsGridViewEx>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <bars:barssqldatasourceex ProviderName="barsroot.core" id="dsSafeDeposit" runat="server"></bars:barssqldatasourceex>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <input type="hidden" runat="server" id="SAFE_ID" /><input type="hidden" runat="server" id="DPT_ID" />
                            <input type="hidden" runat="server" id="BANKDATE" /><input type="hidden" runat="server" id="FIO" />
                            <input type="hidden" runat="server" id="hSAFENUM" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable">
                    <tr>
                        <td style="width:5%" align="center">
                                        <asp:Label ID="lbColor1" runat="server" BackColor="Green" Width="10px" 
                                            meta:resourcekey="lbColor1Resource1" Height="10px"></asp:Label></td>
                        <td style="width:20%">
                                        <asp:Label ID="lbUsed" runat="server" Text="Зайняті" CssClass="InfoText" meta:resourcekey="lbUsedResource1"></asp:Label></td>
                        <td align="center" style="width:5%">
                                        <asp:Label ID="Label1" runat="server" BackColor="DarkGreen" meta:resourcekey="lbColor2Resource1"
                                            Width="10px" Height="10px"></asp:Label></td>
                        <td style="width:20%">
                                        <asp:Label ID="lbProlong" runat="server" CssClass="InfoText"
                                            Text="Пролонгація"></asp:Label></td>
                        <td align="center" style="width:5%">
                                        <asp:Label ID="lbColor2" runat="server" BackColor="#DDC537" Width="10px" meta:resourcekey="lbColor2Resource1" Height="10px"></asp:Label></td>
                        <td style="width:20%">
                                        <asp:Label ID="lbLeft" runat="server" CssClass="InfoText" Text="Зал. 7 днів" meta:resourcekey="lbLeftResource1"></asp:Label></td>
                        <td align="center" style="width:5%">
                                        <asp:Label ID="Label2" runat="server" BackColor="Red" Width="10px" meta:resourcekey="Label2Resource1" Height="10px"></asp:Label></td>
                        <td style="width:20%">
                                        <asp:Label ID="Label4" runat="server" CssClass="InfoText" Text="Прострочені" meta:resourcekey="Label4Resource1"></asp:Label></td>
                    </tr>
                </table>
                                        </td>
        </tr>
        <tr>
            <td>
                &nbsp;<table class="InnerTable">
                    <tr>
                        <td style="width:10%">
                                        <asp:Label ID="lbOcupied" runat="server" CssClass="InfoText" Text="Використовується" meta:resourcekey="lbOcupiedResource1"></asp:Label></td>
                        <td style="width:10%">
                                        <asp:TextBox ID="USED" runat="server" CssClass="InfoText" ReadOnly="True" meta:resourcekey="USEDResource1"></asp:TextBox></td>
                        <td style="width:5%"></td>
                        <td style="width:10%">
                                        <asp:Label ID="lbHot" runat="server" CssClass="InfoText" Text="Гарячі" meta:resourcekey="lbHotResource1"></asp:Label></td>
                        <td style="width:10%">
                                        <asp:TextBox ID="HOT" runat="server" CssClass="InfoText" ReadOnly="True" meta:resourcekey="HOTResource1"></asp:TextBox></td>
                        <td style="width:55%"></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
    <script type="text/javascript">
       var oldonload = window.onload;
       window.onload = function() 
       {
           if (oldonload)   oldonload();
           focusControl('btSearch');
       }       
    </script>
</body>
</html>
