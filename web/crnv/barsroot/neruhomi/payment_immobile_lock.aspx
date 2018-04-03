﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="payment_immobile_lock.aspx.cs" Inherits="payment" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Виплата нерухомих вкладів</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
</head>
<body>
    <form id="formOperationList" runat="server">
        <div class="pageTitle">
            <asp:Label ID="lbTitle" runat="server" Text="Виплата нерухомих вкладів" />
        </div>
        <asp:Panel runat="server" ID="pnInfo" GroupingText="Пошук вкладу:" Style="margin-left: 10px; margin-right: 10px">
            <table>
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lbFio" runat="server" Text="ПІБ:"></asp:Label>
                        </td>
                        <td id="tdFio" runat="server">
                            <bars:BarsTextBox ID="flFio" runat="server" Width="280"> </bars:BarsTextBox>
                        </td>
                        <td>
                            <asp:Label ID="lbSer" runat="server" Text="Серія документу:"></asp:Label>
                        </td>
                        <td>
                            <bars:BarsTextBox ID="tbSer" runat="server" Width="150"> </bars:BarsTextBox>
                        </td>
                        
                        <td>
                            <asp:Label ID="lbNum" runat="server" Text="Номер документу:"></asp:Label>
                        </td>
                        <td>
                            <bars:BarsTextBox ID="tbNum" runat="server" Width="150"> </bars:BarsTextBox>
                        </td>
                        </tr>
                        <tr>
                        <td>
                            <asp:Label ID="lbIDCODE" runat="server" Text="Ідентифікаційний код:"></asp:Label>
                        </td>
                        <td>
                            <bars:BarsTextBox ID="flIDCODE" runat="server" Width="280">
                            </bars:BarsTextBox>
                        </td>
                        <td>
                            <asp:Label ID="lbNSC" runat="server" Text="Рахунок:"></asp:Label>
                        </td>
                        <td>
                            <bars:BarsTextBox ID="flNSC" runat="server" Width="150">
                            </bars:BarsTextBox>
                        </td>
                        <td>
                            <asp:Label ID="lbDPTID" runat="server" Text="Референс договора в АБС:"></asp:Label>
                        </td>
                        <td>
                            <bars:BarsTextBox ID="tbDPTID" runat="server" Width="150">
                            </bars:BarsTextBox>
                        </td>
                    </tr>
                </table>
                </tr>
            <tr>
                <asp:Panel runat="server" ID="pnRb" GroupingText="Джерело завантаження:" Style="margin-left: 10px; margin-right: 10px; display: block; float:left;" Width="200Px">
                    <table>
                        <tr>
                            <td>
                                <asp:RadioButton runat="server" ID="rbAll" Checked="true" OnCheckedChanged="btRefresh_Click" AutoPostBack="true" GroupName="GR" />
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lbAll" Text="Всі"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RadioButton runat="server" ID="rbASVO" Checked="false" OnCheckedChanged="btRefresh_Click" AutoPostBack="true" GroupName="GR" />
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lbASVO" Text="АСВО"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RadioButton runat="server" ID="rbDPT" Checked="false" OnCheckedChanged="btRefresh_Click" AutoPostBack="true" GroupName="GR" />
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lbDPT" Text="БАРС"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RadioButton runat="server" ID="rbOTHERS" Checked="false" OnCheckedChanged="btRefresh_Click" AutoPostBack="true" GroupName="GR" />
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lbOTHERS" Text="Інші"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                  <asp:Panel runat="server" ID="pnStatus" GroupingText="Статус:" Style="margin-left: 10px; margin-right: 10px; display: block; float:left;" Width="450Px">
                    <table>
                        <tr>
                            <td>
                                <asp:RadioButton runat="server" ID="rbNSender" AutoPostBack="true" OnCheckedChanged="btRefresh_Click" GroupName="GR3"  Checked="true" />
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lbNSender" Text="Не оброблені"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RadioButton runat="server" ID="rbWaits" AutoPostBack="true" OnCheckedChanged="btRefresh_Click" GroupName="GR3"/>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lbWaits" Text="Очікує на обробку"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RadioButton runat="server" ID="rbSender" AutoPostBack="true" OnCheckedChanged="btRefresh_Click" GroupName="GR3"/>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lbSender" Text="Оброблені"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RadioButton runat="server" ID="rbPartPay" AutoPostBack="true" OnCheckedChanged="btRefresh_Click" GroupName="GR3"/>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lbPartPay" Text="Частково виплачені"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RadioButton runat="server" ID="rbErr" AutoPostBack="true" OnCheckedChanged="btRefresh_Click" GroupName="GR3"/>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lbErr" Text="Оброблені з помилками"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RadioButton runat="server" ID="rbSeizure" AutoPostBack="true" OnCheckedChanged="btRefresh_Click" GroupName="GR3"/>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lbSeizure" Text="Арешти"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </tr>
           </table>
        </asp:Panel>
          <br />
                    <table>
                        <tr>
                            <td></td>
                            <td></td>
                            <td style="text-align: right; width: 100%;">
                                <asp:Button ID="bt_refresh" runat="server" TabIndex="3" ToolTip="Знайти по заданим параметрам" OnClick="btRefresh_Click"
                                    Text="Пошук" />
                            </td>
                        </tr>
                    </table>
        <br />
        <hr style="margin-left: 10px; margin-right: 10px" />
        <script type="text/javascript">
            function open_window(key) {
                var myWindow = window.showModalDialog("/barsroot/neruhomi/alien_immobile.aspx?key=" + key, "", "dialogHeight:625px;dialogWidth:600px;center:yes;edge:sunken;scroll:no;help:no;status:no;");
                if (myWindow == true) {
                    document.getElementById('bt_refresh').click();
                    /*document.location.href = document.location.href;*/
                }
            }

               function open_seizure_immobile(key) {
                   var myWindow = window.showModalDialog("/barsroot/neruhomi/seizure_immobile.aspx?key=" + key, "", "dialogHeight:525px;dialogWidth:600px;center:yes;edge:sunken;scroll:no;help:no;status:no;");
                   if (myWindow == true) {
                       document.getElementById('bt_refresh').click();
                       /*document.location.href = document.location.href;*/
                   }
               }

              
        </script>
        <BarsEx:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
        <BarsEx:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="True" AllowSorting="True"
            DataSourceID="dsMain" CssClass="barsGridView" DataKeyNames="Key" ShowPageSizeBox="true"
            AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="None"
            PagerSettings-PageButtonCount="10" PageIndex="0"
            PageSize="20">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle ForeColor="Black"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Image runat="server" Visible='<%#String.Format("{0}", Eval("fl"))=="8"||String.Format("{0}", Eval("fl"))=="10"||String.Format("{0}", Eval("fl"))=="9"||String.Format("{0}", Eval("fl"))=="-4"||(String.Format("{0}", Eval("fl"))=="11" && Convert.ToDecimal(String.Format("{0}", Eval("ost")))==0)?(false):(true) %>' src="/Common/Images/default/16/reference_open.png" title="Редагувати"  onclick='<%# "location.href=(\"/barsroot/neruhomi/payment_immobile_edit.aspx?key=" + Eval("KEY") + "\");return false;" %>'/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Image runat="server" src="/Common/Images/default/16/money_calc.png"  Visible='<%#String.Format("{0}", Eval("fl"))=="8"||String.Format("{0}", Eval("fl"))=="10"||String.Format("{0}", Eval("fl"))=="-3"||String.Format("{0}", Eval("fl"))=="9"||String.Format("{0}", Eval("fl"))=="-4"||(String.Format("{0}", Eval("fl"))=="11" && Convert.ToDecimal(String.Format("{0}", Eval("ost")))==0) ?(false):(true) %>' title="Виплатити вклад"  onclick='<%#"open_window(" + Eval("KEY") + ")" %>'/>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Image runat="server" src="/Common/Images/default/16/form_green.png"  Visible='<%#String.Format("{0}", Eval("fl"))=="-5"||String.Format("{0}", Eval("fl"))=="13"||String.Format("{0}", Eval("fl"))=="8"||String.Format("{0}", Eval("fl"))=="10"||String.Format("{0}", Eval("fl"))=="-3"||String.Format("{0}", Eval("fl"))=="9"||String.Format("{0}", Eval("fl"))=="-4"||(String.Format("{0}", Eval("fl"))=="11" && Convert.ToDecimal(String.Format("{0}", Eval("ost")))==0) ?(false):(true) %>' title="Накласти арешт"  onclick='<%#"open_seizure_immobile(" + Eval("KEY") + ")" %>'/>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="ПІБ">
                    <ItemTemplate>
                        <asp:Label ID="lbClient" runat="server" Text='<%# String.Format("{0}", Eval("FIO")) %>' ToolTip='<%# String.Format("ПІБ: {0}; Дата нар.: {1}; Місце нар.: {2}; Стать: {3}", Eval("FIO"), Eval("BIRTHDAT", "{0:d}"), Eval("BIRTHPL"), Eval("SEX")) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
               
                <asp:BoundField DataField="IDCODE" HeaderText="РНОКПП" />

                 <asp:TemplateField HeaderText="Документ">
                    <ItemTemplate>
                        <asp:Label ID="lbDoctype" runat="server" Text='<%# String.Format("{0} ", Eval("DOCTYPE")) %>' ToolTip='<%#String.Format("Документ: {0}; Серія,номер: {1}{2}; Ким видано: {3}; Коли видано: {4}",Eval("DOCTYPE"), Eval("PASP_S"),Eval("PASP_N"),Eval("PASP_W"),Eval("PASP_D", "{0:d}")) %>'>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

               

                  <asp:TemplateField HeaderText="Адреса">
                    <ItemTemplate>
                        <asp:Label ID="lbAdr"  runat="server" Text='<%# String.Format("{0} ", Eval("ADDRESS")) %>' ToolTip='<%#String.Format("Поштовий індекс: {0}; Область: {1}; Район: {2}; Місто: {3}; Адреса: {4}; Дом.тел.: {5}; Роб.тел.: {6}; Код країни: {7}",Eval("POSTIDX"), Eval("REGION"),Eval("DISTRICT"),Eval("CITY"),Eval("ADDRESS"),Eval("PHONE_H"),Eval("PHONE_J"),Eval("LANDCOD")) %>'>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="BRANCH" HeaderText="Відділення" />
                <asp:BoundField DataField="SOURCE" HeaderText="Джерело завантаження" />
                <asp:BoundField DataField="REGDATE" HeaderText="Дата реєстрації" />
                <asp:BoundField DataField="DEPCODE" HeaderText="Код вида вкладу" />
                <asp:BoundField DataField="DEPVIDNAME" HeaderText="Назва виду вкладу" />
                <asp:BoundField DataField="ACC_CARD" HeaderText="Код картотеки" />
                <asp:BoundField DataField="DEPNAME" HeaderText="Назва вкладу" />
                <asp:BoundField DataField="NLS" HeaderText="Рахунок" />
                <asp:BoundField DataField="KV" HeaderText="Валюта" />
                <asp:BoundField DataField="ID" HeaderText="Ідентифікатор АСВО" />
                <asp:BoundField DataField="DATO" HeaderText="Дата відкриття" />
                <asp:BoundField DataField="OST" HeaderText="Залишок" />
                <asp:BoundField DataField="SUM" HeaderText="Сума" Visible="false"/>
                <asp:BoundField DataField="DATN" HeaderText="Дата по яку нарах.%%" />
                <asp:BoundField DataField="MARK" HeaderText="Символ картотеки" />
                <asp:BoundField DataField="KOD_OTD" HeaderText="Відділення в АСВО" />
                <asp:BoundField DataField="ND" HeaderText="Номер договора в АБС"/>
                <asp:BoundField DataField="DPTID" HeaderText="Референс договора в АБС"/>
                <asp:TemplateField HeaderText="Референс вхідний">
                    <ItemTemplate>
                        <asp:HyperLink ID="hlRef" runat="server" Target="_blank"> 
                            <asp:Label ID="lbRef" runat="server" Text='<%#String.Format("{0}",Eval("REF")) %>'></asp:Label>
                        </asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="STATUS" HeaderText="Статус"/>
                <asp:BoundField DataField="COMMENTS" HeaderText="Коментар"/>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Label ID="lbERR" ToolTip="Текст помилки" runat="server" Text='<%#String.Format("{0}",Eval("ERRMSG")) %>' Visible='<%#Convert.ToDecimal(String.Format("{0}",Eval("FL")))<0?(true):(false) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </BarsEx:BarsGridViewEx>
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
    </form>
</body>
</html>
