<%@ Page Language="C#" AutoEventWireup="true" CodeFile="credit_defolt_bud.aspx.cs"
    Inherits="credit_defolt_bud" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="Bars" %>
<%@ Register Src="~/UserControls/LabelTooltip.ascx" TagName="LabelTooltip" TagPrefix="Lab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet" />
    <style type="text/css">
        .navigationButton
        {
            padding: 3px;
            border: 1px solid #29acf7;
            background: white;
        }
        .navigationButton:hover
        {
            background: #29acf7;
            color: white;
            cursor: pointer;
        }
        .sideBar
        {
            margin-top: 20px;
        }
        .navigation
        {
            padding-top: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
         <asp:Panel ID="Panel0" runat="server" BackColor="#EFF3FB" Width="950px" >
            <table width="100%">
                <tr>
                    <td style="border: thin solid #D8E1F5; width: 61%; text-align: center;">
                        <asp:Label ID="Lb1" runat="server" Font-Italic="True" ForeColor="#000099" ToolTip="Назва клієнта"></asp:Label>
                    </td>
                    <td style="border: thin solid #D8E1F5; width: 13%; text-align: center;">
                        <asp:Label ID="Lb2" runat="server" Font-Italic="True" ForeColor="#000099" ToolTip="ОКПО клієнта"></asp:Label>
                    </td>
                    <td style="border: thin solid #D8E1F5; width: 13%; text-align: center;">
                        <asp:Label ID="Lb3" runat="server" Font-Italic="True" ForeColor="#000099" ToolTip="Номер договру"></asp:Label>
                    </td>
                    <td style="border: thin solid #D8E1F5; width: 13%; text-align: center;">
                        <asp:Label ID="Lb4" runat="server" Font-Italic="True" ForeColor="#000099" ToolTip="Дата договору"></asp:Label>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    <asp:Panel ID="Panel1" runat="server" Width="950px">
        <asp:Wizard ID="Wizard1" runat="server" Width="100%" BackColor="#EFF3FB" BorderColor="#B5C7DE" 
            BorderWidth="1px" Font-Names="Verdana" CellPadding="10" 
            ActiveStepIndex="4" Font-Size="Small"
            StartNextButtonText="Наступна" StepNextButtonText="Наступна" StepPreviousButtonText="Попередня"
            CancelButtonText="Відмінити" FinishCompleteButtonText="Готово" FinishPreviousButtonText="Попередня"
            OnNextButtonClick="BtNext"  >
            <FinishNavigationTemplate>
                <asp:Button ID="FinishPreviousButton" runat="server" CausesValidation="False" CommandName="MovePrevious"
                    CssClass="navigationButton" Text="Попередня" />
                <asp:Button ID="FinishButton" runat="server" CommandName="MoveComplete" CssClass="navigationButton"
                    Text="Готово" Visible="false" />
            </FinishNavigationTemplate>
            <HeaderStyle VerticalAlign="Top" />
            <HeaderTemplate>
                <h3 style="color: #000080; font-style: italic; font-family: 'Times New Roman', Times, serif;
                    text-decoration: underline;">
                    <%= Wizard1.ActiveStep.Title %></h3>
            </HeaderTemplate>
            <SideBarTemplate>
                <asp:DataList ID="SideBarList" runat="server" Width="205px">
                    <ItemTemplate>
                        <asp:LinkButton ID="SideBarButton" runat="server" Enabled="false"></asp:LinkButton>
                    </ItemTemplate>
                    <SelectedItemStyle Font-Bold="True" />
                </asp:DataList>
            </SideBarTemplate>
            <StartNavigationTemplate>
                <asp:Button ID="Button1" runat="server" CommandName="MoveNext" CssClass="navigationButton"
                    Text="Наступна" Enabled="true" />
            </StartNavigationTemplate>
            <StepNavigationTemplate>
                <asp:Button ID="StepPreviousButton" runat="server" BorderStyle="Solid" CausesValidation="False"
                    CommandName="MovePrevious" CssClass="navigationButton" Text="Попередня" />
                <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" CssClass="navigationButton"
                    Text="Наступна" />
            </StepNavigationTemplate>
            <WizardSteps>
                <asp:WizardStep ID="WizardStep0" runat="server" Title=" Реквізити клієнт">
                    <asp:Panel ID="Pn_Wizar0" runat="server">
                        <asp:HiddenField ID="RNK_" runat="server" />
                        <asp:HiddenField ID="ND_" runat="server" />
                        <table>
                            <tr>
                                <td style="width: 155Px">
                                    <asp:Label ID="lb_nmk" runat="server" Text="Назва клієнта" Width="155px"></asp:Label>
                                </td>
                                <td colspan="3">
                                    <asp:TextBox ID="Tb_nmk" runat="server" ReadOnly="True" Enabled="False" Width="420px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Lb_okpo" runat="server" Text="Код ОКПО"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="Tb_okpo" runat="server" Enabled="False"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="Lb_date_open" runat="server" Text="Дата реєстрації Контрагента" Width="120px"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="TB_Date_open" runat="server" Enabled="False"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Lb_NumU" runat="server" Text="№ Угоди"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="Tb_NumU" runat="server" Enabled="False"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="Lb_DatU" runat="server" Text="Дата заключення угоди"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="Tb_DatU" runat="server" Enabled="False"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Lb_Zdat" runat="server" Text="Звітна дата"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="Dl_Zdat" runat="server" Width="115px" AutoPostBack="True" OnSelectedIndexChanged="Dl_Zdat_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="Lb_clas" runat="server" Text="Клас боржника"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="Dl_clas" runat="server" DataSource='<%# SQL_SELECT_dataset("select num from conductor where num <=5") %>'
                                        DataTextField="NUM" DataValueField="NUM" Width="100px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="Lb_vncr" runat="server" Text="Внутрішній кредитний рейтинг  "></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="tb_vncr" runat="server" DataSource='<%# SQL_SELECT_dataset("select code from CCK_RATING where ord < 41") %>'
                                        DataTextField="CODE" DataValueField="CODE" Width="100px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="Lb_inv" runat="server" Text="Пов’язаний із фінансуванням інвестиційних проектів контрагентів Банку "></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="Dl_inv" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "INV" +((char)39).ToString() + "and idf = 71 ") %>'
                                        DataTextField="NAME" DataValueField="VAL">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="Lb_ksr" runat="server" Text="Контрагент створений шляхом реорганізації"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="Dl_ksr" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "KSR" +((char)39).ToString() + "and idf = 71 ") %>'
                                        DataTextField="NAME" DataValueField="VAL" Width="100px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="Lb_kres" runat="server" Text="Кількість реструктуризацій по угоді"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="Tb_kres" runat="server" Width="100Px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStep2" runat="server" Title=" Ознаки високого кредитного ризику">
                    <asp:Panel ID="Pn_Wizar2" runat="server" Enabled="true">
                        <asp:GridView ID="GrWiz2" runat="server" AutoGenerateColumns="False" CssClass="barsGridView"
                            DataKeyNames="KOD,IDF,NAME,POB" BorderColor="#EFF3FB" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="NAME" HtmlEncode="False">
                                    <ItemStyle Wrap="True" HorizontalAlign="Left" Width="600px" Font-Italic="True" />
                                </asp:BoundField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:DropDownList ID="DropDownList1" AppendDataBoundItems="true" DataSource='<%# SQL_SELECT_dataset(""+Eval("L_SQL")+"")%>'
                                            DataTextField="NAME" DataValueField="VAL" Text='<%#Eval("S")%>' Enabled='<%# (Convert.ToString(Eval("POB")) == "1")?(false):(true) %>'
                                            Width="100px" runat="server" ToolTip='<%# Eval("DESCRIPT")%>' Visible="true">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Left" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="Im4" runat="server" Visible='<%# (Convert.ToString(Eval("DESCRIPT")).Length == 0)?(false):(true) %>'
                                            ToolTip='<%# Eval("DESCRIPT")%>' ImageUrl="/Common/Images/default/16/help2.png" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <br />
                        <h3 style="color: #000080; font-family: 'Times New Roman', Times, serif; font-style: italic;">
                            Додаткові показники коригування коофіциенту PD</h3>
                        <asp:GridView ID="GrWiz2_kl" runat="server" AutoGenerateColumns="False" CssClass="barsGridView"
                            DataKeyNames="KOD,IDF,NAME,POB" BorderColor="#EFF3FB" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="NAME" HtmlEncode="False">
                                    <ItemStyle Wrap="True" HorizontalAlign="Left" Width="600px" Font-Italic="True" />
                                </asp:BoundField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:DropDownList ID="DropDownList1" AppendDataBoundItems="true" DataSource='<%# SQL_SELECT_dataset(""+Eval("L_SQL")+"")%>'
                                            DataTextField="NAME" DataValueField="VAL" Text='<%#Eval("S")%>' Enabled='<%# (Convert.ToString(Eval("POB")) == "1")?(false):(true) %>'
                                            Width="100px" runat="server" ToolTip='<%# Eval("DESCRIPT")%>' Visible="true">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Left" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="Im4" runat="server" Visible='<%# (Convert.ToString(Eval("DESCRIPT")).Length == 0)?(false):(true) %>'
                                            ToolTip='<%# Eval("DESCRIPT")%>' ImageUrl="/Common/Images/default/16/help2.png" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStep3" runat="server" Title=" Безумовні ознаки визнання дефолту боржника">
                    <asp:Panel ID="Pn_Wizar3" runat="server">
                        <asp:GridView ID="GrWiz3" runat="server" AutoGenerateColumns="False" CssClass="barsGridView"
                            DataKeyNames="KOD,IDF,NAME,POB" BorderColor="#EFF3FB" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="NAME" HtmlEncode="False">
                                    <ItemStyle Wrap="False" HorizontalAlign="Left" Width="600px" Font-Italic="True" />
                                </asp:BoundField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:DropDownList ID="DropDownList1" AppendDataBoundItems="true" DataSource='<%# SQL_SELECT_dataset(""+Eval("L_SQL")+"")%>' AutoPostBack="true"
                                            DataTextField="NAME" DataValueField="VAL" Text='<%#Eval("S")%>' Enabled='<%# (Convert.ToString(Eval("POB")) == "1")?(false):(true) %>'
                                            Width="100px" runat="server" ToolTip='<%# Eval("DESCRIPT")%>' Visible="true" OnSelectedIndexChanged="GrWiz3_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Left" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="Im4" runat="server" Visible='<%# (Convert.ToString(Eval("DESCRIPT")).Length == 0)?(false):(true) %>'
                                            ToolTip='<%# Eval("DESCRIPT")%>' ImageUrl="/Common/Images/default/16/help2.png" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle Height="25px" />
                        </asp:GridView>
                    </asp:Panel>
                    <asp:Panel ID="Pn_Wizar3_2" runat="server" Visible="false">
                        <table>
                            <tr>
                                <td style="width: 570Px">
                                    <asp:Label ID="l_PD8_d" runat="server" Text="Дата проведення  останньої зміни активу на інший актив"></asp:Label>
                                </td>
                                <td>
                                    <Bars:TextBoxDate ID="tb_PD8_d" runat="server" IsRequired="true" style="text-align: right"
                                        Width="100px" MinValue="01/01/1900" MaxValue="01/01/2999"></Bars:TextBoxDate>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStep4" runat="server" Title=" Умовні ознаки визнання дефолту боржника">
                    <asp:Panel ID="Pn_Wizar4" runat="server">
                        <asp:GridView ID="GrWiz4" runat="server" AutoGenerateColumns="False" BorderColor="#EFF3FB"
                            CssClass="barsGridView" DataKeyNames="KOD,IDF,NAME,POB" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="NAME" HtmlEncode="False">
                                    <ItemStyle Font-Italic="True" HorizontalAlign="Left" Width="600px" Wrap="True" />
                                </asp:BoundField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="true" DataSource='<%# SQL_SELECT_dataset(""+Eval("L_SQL")+"")%>'
                                            DataTextField="NAME" DataValueField="VAL" Enabled='<%# (Convert.ToString(Eval("POB")) == "1")?(false):(true) %>'
                                            Text='<%#Eval("S")%>' ToolTip='<%# Eval("DESCRIPT")%>' Visible="true" Width="100px">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Left" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="Im4" runat="server" ImageUrl="/Common/Images/default/16/help2.png"
                                            ToolTip='<%# Eval("DESCRIPT")%>' Visible='<%# (Convert.ToString(Eval("DESCRIPT")).Length == 0)?(false):(true) %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                    <asp:Panel ID="Pn_Wizar4_2" runat="server" GroupingText="Судження банку...">
                        <table>
                            <tr>
                                <td style="width: 400Px">
                                    <asp:Label ID="Lb_VD0" runat="server" Text="Наявність судження Банку про відстутність  умовних ознак визнання дефолту боржника"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="Dd_VD0" runat="server" Width="100px" AutoPostBack="True" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "VD0" +((char)39).ToString() + "and idf = 74 ") %>'
                                        DataTextField="NAME" DataValueField="VAL" OnSelectedIndexChanged="Dd_VD0_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="Lb_VDN1" runat="server" Text="Рішення колегіального органу №" Visible="False"></asp:Label>
                                    <asp:TextBox ID="Tb_VDN1" runat="server" Width="100px" Visible="False"></asp:TextBox>
                                    <asp:Label ID="Lb_VDD1" runat="server" Text=" від " Visible="False"></asp:Label>
                                    <Bars:TextBoxDate ID="Tb_VDD1" runat="server" Visible="False"/>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStep5" runat="server" Title=" Ознаки припинення дефолту">
                    <asp:Panel ID="Pn_Wizar5" runat="server">
                        <asp:GridView ID="GrWiz5" runat="server" AutoGenerateColumns="False" CssClass="barsGridView"
                            DataKeyNames="KOD, IDF, NAME, POB" BorderColor="#EFF3FB" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="NAME" HeaderText="" HtmlEncode="False">
                                    <ItemStyle Wrap="true" HorizontalAlign="left" Width="600px" Font-Italic="True" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="" FooterStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="DropDownList1" AppendDataBoundItems="true" DataSource='<%# SQL_SELECT_dataset(""+Eval("L_SQL")+"")%>'
                                            DataTextField="NAME" DataValueField="VAL" Text='<%#Eval("S")%>' Enabled='<%# (Convert.ToString(Eval("POB")) == "1")?(false):(true) %>'
                                            Width="100px" runat="server" ToolTip='<%# Eval("DESCRIPT")%>' Visible="true">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Left" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="Im4" runat="server" Visible='<%# (Convert.ToString(Eval("DESCRIPT")).Length == 0)?(false):(true) %>'
                                            ToolTip='<%# Eval("DESCRIPT")%>' ImageUrl="/Common/Images/default/16/help2.png" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:Panel ID="p_events" runat="server"  Visible="false">
                        <table>
                            <tr>
                                <td style="width: 550Px">
                                    <asp:Label ID="lb_ZD4" runat="server" Text="  3 - З моменту усунення події/подій, на підставі якої/яких було визнано дефолт божника, минуло щонайменше 180 днів " Width="550"></asp:Label>
                                </td>
                                <td style="width: 100Px">
                                    <asp:DropDownList ID="dl_ZD4" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "ZD4" +((char)39).ToString() + "and idf = 75 ") %>'
                                        DataTextField="NAME" DataValueField="VAL" Enabled="false" Width="100px">
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 50Px">
                                <%-- <asp:Image ID="Im_ZD4" runat="server" Visible='<%# (Convert.ToString(Eval("DESCRIPT")).Length == 0)?(false):(true) %>'
                                            ToolTip='<%# Eval("DESCRIPT")%>' ImageUrl="/Common/Images/default/16/help2.png" />--%>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                        <asp:Panel ID="Pn_Wizar5_2" runat="server" Width="550Px" GroupingText="Судження Банку...">
                        <table>
                              <tr>
                                <td  style="width: 400Px">
                                <asp:Label ID="Lb_ZD3" runat="server" 
                                     Text="Банк має документально підтверджене обґрунтоване судження, що Контрагент, попри наявні фінансові труднощі, спроможний обслуговувати борг"></asp:Label>
                                </td>
                                <td>
                                 <asp:DropDownList ID="Dl_ZD3" runat="server" Width="100px"  
                                      DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "ZD3" +((char)39).ToString() + "and idf = 75 ") %>'
                                      Enabled="true" DataTextField="NAME" DataValueField="VAL">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                            <td colspan="2">
                                                <asp:Label ID="Lb_ZDN1" runat="server" Text="Рішення колегіального органу №" Visible="true"></asp:Label>
                                                <asp:TextBox ID="Tb_ZDN1" runat="server" Width="100Px" Visible="true"  AutoPostBack="true"
                                                    OnTextChanged="Tb_ZDN1_TextChanged"></asp:TextBox>
                                                <asp:Label ID="Lb_ZDD1" runat="server" Text=" від " Visible="true"></asp:Label>
                                                <Bars:TextBoxDate ID="Tb_ZDD1" runat="server"  Visible="true" />
                                            </td>
                           </tr>
                           <%-- <tr>
                                <td>
                                    <asp:Label ID="Lb_RK22" runat="server" Text="4 - Наявність судження банку про відсутність умовних ознак визнання дефолту боржника "></asp:Label>
                                </td>
                                <td>
                                    <asp:CheckBox ID="Cb_RK22" runat="server" AutoPostBack="true" OnCheckedChanged="Cb_RK22_CheckedChanged" />
                                </td>
                            </tr>--%>

                       </table>
                       </asp:Panel>
                    </asp:Panel>
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStep6" runat="server" Title=" Фактори коригування класу боржника "
                    StepType="Finish">
                    <asp:Panel ID="Pn_Wizar6" runat="server">
                        <table>
                            <tr>
                                <td style="width: 580Px">
                                    <asp:Label ID="Lb_RK0" runat="server" Text="Ознака високого кредитного ризику"></asp:Label>
                                </td>
                                <td style="width: 100Px">
                                    <asp:DropDownList ID="Dd_RK0" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "RK0" +((char)39).ToString() + "and idf = 76 ") %>'
                                        DataTextField="NAME" DataValueField="VAL" Width="100px" Enabled="false">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 580Px">
                                    <asp:Label ID="Lb_RK1" runat="server" Text="Безумовна ознака визнання дефолту боржника"></asp:Label>
                                </td>
                                <td style="width: 100Px">
                                    <asp:DropDownList ID="Dd_RK1" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "RK1" +((char)39).ToString() + "and idf = 76 ") %>'
                                        DataTextField="NAME" DataValueField="VAL" Width="100px" Enabled="false">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 580Px">
                                    <asp:Label ID="Lb_RK2" runat="server" Text="Умовна ознака визнання дефолту боржника"></asp:Label>
                                </td>
                                <td style="width: 100Px">
                                    <asp:DropDownList ID="Dd_RK2" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "RK2" +((char)39).ToString() + "and idf = 76 ") %>'
                                        DataTextField="NAME" DataValueField="VAL" Width="100px" Enabled="false">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 580Px">
                                    <asp:Label ID="Lb_RK3" runat="server" Text="Ознака припинення визнання дефолту боржника "></asp:Label>
                                </td>
                                <td style="width: 100Px">
                                    <asp:DropDownList ID="Dd_RK3" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "RK3" +((char)39).ToString() + "and idf = 76 ") %>' 
                                        DataTextField="NAME" DataValueField="VAL" Width="100px" Enabled="false">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 580Px">
                                    <asp:Label ID="Lb_RK4" runat="server" Text="Інформація про належність боржника до класу 5 "></asp:Label>
                                </td>
                                <td style="width: 100Px">
                                    <asp:DropDownList ID="Dd_RK4" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "RK4" +((char)39).ToString() + "and idf = 76 ") %>'
                                        DataTextField="NAME" DataValueField="VAL" Width="100px" Enabled="true">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <asp:Panel ID="Pn_clas" runat="server" Visible="false">
                            <h3 style="color: #000080; font-family: 'Times New Roman', Times, serif; font-style: italic;">
                                Скоригований клас та значення PD</h3>
                            <table>
                                <tr>
                                    <td style="width: 580Px">
                                        <asp:Label ID="Lb_cls" runat="server" Text="Зкорегований клас"></asp:Label>
                                    </td>
                                    <td style="width: 100Px">
                                        <asp:TextBox ID="Tb_cls" runat="server" Enabled="false" Width="100px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 580Px">
                                        <asp:Label ID="Lb_clsp" runat="server" Text="Зкорегований клас  з врахуванням кількості днів прострочки" Visible="false"></asp:Label>
                                    </td>
                                    <td style="width: 100Px">
                                        <asp:TextBox ID="Tb_clsb" runat="server" Enabled="false" Width="100px" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 580Px">
                                        <asp:Label ID="Lb_PD" runat="server" Text="Значення коофіцієнту PD"></asp:Label>
                                    </td>
                                    <td style="width: 100Px">
                                        <asp:TextBox ID="Tb_PD" runat="server" Enabled="false" Width="100px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <br />
                        <table>
                            <tr>
                                <td>
                                    <Bars:ImageTextButton ID="Bt_save" runat="server" ButtonStyle="ImageAndText" ImageUrl="/Common/Images/default/16/money_calc.png"
                                        Text="Розрахувати" ToolTip="Скорегувати клас та розрахувати показник PD " CssClass="navigationButton"
                                        Width="110Px" Height="35Px" OnClick="Bt_save_Click" />
                                </td>
                                <td>
                                    <Bars:ImageTextButton ID="BtI_Cardkl" runat="server" ButtonStyle="ImageAndText" ImageUrl="/Common/Images/CUSTPERS.gif"
                                        Text="Повернутись" OnClick="BtI_Cardkl_Click" ToolTip="Повернутись на карточку фінстану позичальника "
                                        CssClass="navigationButton" Width="110Px" Height="35Px" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </asp:WizardStep>
            </WizardSteps>
            <StepPreviousButtonStyle BorderStyle="Solid" />
            <NavigationButtonStyle CssClass="navigationButton" />
            <NavigationStyle CssClass="navigation" />
            <SideBarStyle VerticalAlign="Top" Width="200px" />
        </asp:Wizard>
    </asp:Panel>
    <div>
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
    </div>
    </form>
</body>
</html>
