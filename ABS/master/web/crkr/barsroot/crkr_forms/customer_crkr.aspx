<%@ Page Language="C#" AutoEventWireup="true" CodeFile="customer_crkr.aspx.cs" Inherits="customer_crkr_customer_crkr" %>

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
    <title>Клієнти ЦРКР</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
</head>
<body>
    <form id="formOperationList" runat="server">
        <div class="pageTitle">
            <asp:Label ID="lbTitle" runat="server" Text="Портфель актуалізованих вкладників ЦРКР" />
        </div>
        <asp:Panel runat="server" ID="pnInfo" GroupingText="Пошук клієнта:" Style="margin-left: 10px; margin-right: 10px">
            <table>
                <tr>
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lbFio" runat="server" Text="ПІБ:"></asp:Label>
                        </td>
                        <td id="tdFio" runat="server">
                            <bars:BarsTextBox ID="flFio" runat="server" Width="280">
                            </bars:BarsTextBox>
                        </td>
                        <td>
                            <asp:Label ID="lbIDCODE" runat="server" Text="Ідентифікаційний код:"></asp:Label>
                        </td>
                        <td>
                            <bars:BarsTextBox ID="flIDCODE" runat="server" Width="100">
                            </bars:BarsTextBox>
                        </td>
                        
                        <td>
                            <asp:Label ID="lbRnk" runat="server" Text="РНК:"></asp:Label>
                        </td>
                        <td>
                            <bars:BarsTextBox ID="tbRnk" runat="server" Width="100">
                            </bars:BarsTextBox>
                        </td>
                        <td>
                            <asp:Label ID="lbSerial" runat="server" Text="Серія:"></asp:Label>
                        </td>
                        <td>
                            <bars:BarsTextBox ID="tbSerial" runat="server" Width="50">
                            </bars:BarsTextBox>
                        </td>
                        <td>
                            <asp:Label ID="lbNumber" runat="server" Text="Номер:"></asp:Label>
                        </td>
                        <td>
                            <bars:BarsTextBox ID="tbNumber" runat="server" Width="50">
                            </bars:BarsTextBox>
                        </td>

                    </tr>
                </table>
           
           </table>
        </asp:Panel>
          <br />
                    <table>
                        <tr>
                            <%--<td runat="server" id="tdEdit">
                    <asp:ImageButton ID="btEdit" runat="server" ImageUrl="/Common/Images/default/16/edit.png"
                        TabIndex="1" ToolTip="Картка вкладу" OnClick="btEdit_Click" />
                </td>--%>
                            <%--<td runat="server" id="tdRefresh">
                    <asp:ImageButton ID="btRefresh" runat="server"  ImageUrl="/Common/Images/default/16/refresh.png"
                        TabIndex="2" ToolTip="Перечитати" OnClick="btRefresh_Click" />
                </td>--%>
                             <td style="text-align: right; width: 100%;">
                                <asp:Button ID="bt_refresh" runat="server" TabIndex="3" style="float: left" ToolTip="Знайти по заданим параметрам" OnClick="btRefresh_Click"
                                    Text="Пошук" />
                            </td>
                            <td></td>
                            <td style="text-align: right; width: 100%;">
                                <asp:Button ID="NewClient" runat="server" TabIndex="2" ToolTip="Створення нового клієнта" OnClick="btNewClient_Click"
                                    Text="Новий клієнт" /> 
                            </td>
                           
                        </tr>
                    </table>
          
        <br />
        <hr style="margin-left: 10px; margin-right: 10px" />
        <BarsEx:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
        <BarsEx:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="True" AllowSorting="True"
            DataSourceID="dsMain" CssClass="barsGridView" DataKeyNames="RNK" ShowPageSizeBox="true"
            AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="None"
            OnRowDataBound="gvMain_RowDataBound"
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
                <asp:TemplateField HeaderText="РНК">
                    <ItemTemplate>
                        <asp:HyperLink runat="server" Text='<%#Eval("RNK") %>' ID="btRNK" NavigateUrl='<%#"~/Crkr/ClientProfile/Index?rnk="+Eval("RNK") + "&control=" + Request["control"] + "&burial=" + Request["burial"] + "&herid=" + Request["herid"]%>'></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="ПІБ">
                    <ItemTemplate>
                        <asp:Label ID="lbClient" runat="server" Text='<%# String.Format("{0}", Eval("NAME")) %>' ToolTip='<%# String.Format("ПІБ: {0}; Дата нар.: {1};  Стать: {2}", Eval("NAME"), Eval("BIRTH_DATE", "{0:d}"), Eval("SEX")) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
               
                <asp:BoundField DataField="INN" HeaderText="РНОКПП" />

                 <asp:TemplateField HeaderText="Документ">
                    <ItemTemplate>
                        <asp:Label ID="lbDoctype" runat="server" Text='<%# String.Format("{0} ", Eval("DOC_TYPE")) %>' ToolTip='<%#String.Format("Документ: {0}; Серія,номер: {1}{2}",Eval("DOC_TYPE"), Eval("SER"),Eval("NUMDOC")) %>'>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="SEX" HeaderText="Стать" />
                <asp:BoundField DataField="BIRTH_DATE" HeaderText="Дата народження" />
                <asp:BoundField DataField="REZID" HeaderText="Резидент" />
                <asp:BoundField DataField="SER" HeaderText="Серія" />

                <asp:BoundField DataField="NUMDOC" HeaderText="Номер документу" />
                <asp:BoundField DataField="DATE_OF_ISSUE" HeaderText="Дата видачі" />
                <asp:BoundField DataField="TEL" HeaderText="Телефон" />
                <asp:BoundField DataField="TEL_MOB" HeaderText="Мобільний телефон" />
                <asp:TemplateField HeaderText="Представник">
                  <ItemTemplate>
                        <asp:Label ID="lbSecondary" runat="server" Text='<%# String.Format("{0} ", Eval("SECONDARY").ToString() .Equals( "0") ? "" : "X") %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="BRANCH" HeaderText="Відділення" />
                <asp:BoundField DataField="DATE_REGISTRY" HeaderText="Дата реєстрації" />

                <asp:BoundField DataField="ZIP" HeaderText="Індекс" />
                <asp:BoundField DataField="DOMAIN" HeaderText="Область" />
                <asp:BoundField DataField="REGION" HeaderText="Район" />
                <asp:BoundField DataField="LOCALITY" HeaderText="Населений пункт"/>
                <asp:BoundField DataField="ADDRESS" HeaderText="Адреса"/>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </BarsEx:BarsGridViewEx>
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
    </form>
</body>
</html>
