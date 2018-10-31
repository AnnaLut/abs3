<%@ Page Language="C#" AutoEventWireup="true" CodeFile="credit_defolt.aspx.cs" Inherits="credit_defolt" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="Bars" %>
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
    <asp:Panel ID="Panel0" runat="server" BackColor="#EFF3FB" Width="950px">
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
            ActiveStepIndex="5" Font-Size="Small"
            StartNextButtonText="Наступна" StepNextButtonText="Наступна" StepPreviousButtonText="Попередня"
            CancelButtonText="Відмінити" FinishCompleteButtonText="Готово" FinishPreviousButtonText="Попередня"
            OnNextButtonClick="BtNext" OnPreviousButtonClick="BtPrevious">
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
                                    <asp:Label ID="Lb_dat" runat="server" Text="Звітний період Ф1(Ф2)"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="TB_Dat" runat="server" Enabled="False"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="Lb_Zdat" runat="server" Text="Звітна дата"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="Dl_Zdat" runat="server" Width="115px" AutoPostBack="True" OnSelectedIndexChanged="Dl_Zdat_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Lb_tzvd" runat="server" Text="Період звітності"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="Dl_tzvd" runat="server" Width="149px" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "TZVT" +((char)39).ToString() + "and idf = 6 ") %>'
                                        DataTextField="NAME" DataValueField="VAL">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="Lb_val" runat="server" Text="Код валюти угоди"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="Dl_val" runat="server" Width="150px" DataSource='<%# SQL_SELECT_dataset("select kv, name from tabval where kv in (980, 840, 978, 643) order by grp ") %>'
                                        DataTextField="NAME" DataValueField="KV">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <asp:Label ID="Lb_vncr" runat="server" Text="Внутрішній кредитний рейтинг  "></asp:Label>
                                    <asp:DropDownList ID="tb_vncr" runat="server" Width="90px" DataSource='<%# SQL_SELECT_dataset(@"select code as id, code as name from CCK_RATING where code not in ("+ ((char)39).ToString() + "Д" +((char)39).ToString() + ")" ) %>'
                                        DataTextField="NAME" DataValueField="ID" Enabled="true"></asp:DropDownList>
                                    <Bars:Separator ID="Sp2" runat="server" Visible="False" BorderWidth="1px" />
                                    <Bars:ImageTextButton ID="Ib_save_vncrr" runat="server" ButtonStyle="Image" ImageUrl="/Common/Images/default/16/document_edit.png"
                                        OnClick="Bt_Clic_set_Vnkr" ToolTip="Зберегти ВКР" CausesValidation="False"
                                        EnabledAfter="0" />
                                    <bars:ImageTextButton ID="Ib_vncrr" runat="server" ButtonStyle="Image" ImageUrl="/Common/Images/default/16/document_edit.png"
                                        OnClick="BtI_Clic_Vnkr" ToolTip="Перейти на розрахунок ВНКР позичальника " CausesValidation="False"
                                        EnabledAfter="0" />
                                </td>
                            
                        </table>
                        <table>
                            <tr>
                                <td colspan="2" style="text-align: center">
                                    <asp:Label ID="Lb_Res" runat="server" Text="Реструктуризація повязана з наявністю фінансових трудностей"
                                        Style="color: #0066FF"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 565Px">
                                    <asp:Label ID="Lb_Kres" runat="server" Text="Кількість реструктуризацій"></asp:Label>
                                    <asp:RangeValidator runat="server" ID="valid_Kres" ControlToValidate="Tb_kres" MinimumValue="0"
                                        MaximumValue="99999999" Type="Integer" ErrorMessage="Не вірно вказано" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RangeValidator>
                                </td>
                                <td style="width: 100Px">
                                    <asp:TextBox ID="Tb_kres" runat="server" Width="100px" AutoPostBack="True" OnTextChanged="Tb_kres_TextChanged"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Lb_dpres" runat="server" Text="Дата проведення реструктуризації" Visible="False"></asp:Label>
                                </td>
                                <td>
                                    <Bars:TextBoxDate ID="tb_dpres" runat="server" IsRequired="true" Width="100px" Visible="False"
                                        MinValue="01/01/1900" MaxValue="01/01/2999"></Bars:TextBoxDate>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Lb_klres" runat="server" Text="Клас на дату реструктуризації" Visible="False"></asp:Label>
                                    <asp:RangeValidator runat="server" ID="Valid_klres" ControlToValidate="Tb_Klres"
                                        MinimumValue="1" MaximumValue="10" Type="Integer" ErrorMessage="Значение класу може приймати значення від 1 до 10"
                                        Display="Dynamic" SetFocusOnError="True"></asp:RangeValidator>
                                </td>
                                <td>
                                    <asp:TextBox ID="Tb_Klres" runat="server" Width="100px" Visible="False"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Lb_kdpres" runat="server" Text="Кількість днів прострочки на дату реструктуризації"
                                        Visible="False"></asp:Label>
                                    <asp:RangeValidator runat="server" ID="Valid_kdres" ControlToValidate="Tb_kdpres"
                                        MinimumValue="0" MaximumValue="99999999" Type="Integer" ErrorMessage="Не вірно вказано"
                                        Display="Dynamic" SetFocusOnError="True"></asp:RangeValidator>
                                </td>
                                <td>
                                    <asp:TextBox ID="Tb_kdpres" runat="server" Width="100px" Visible="False"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStep1" runat="server" Title=" Належність до груп та їх вплив на контрагента">
                    <asp:Panel ID="Panel2" runat="server" Enabled="true">
                        <table>
                            <tr>
                                <td style="width: 355Px">
                                    <asp:Label ID="Lb_NgrK" runat="server" Text="Належність до групи під спільним контролем"
                                        Width="355px" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="Dl_NgrK" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "NGRK" +((char)39).ToString() + "and idf = 51 ") %>'
                                        Enabled="False" DataTextField="NAME" DataValueField="VAL" Width="100px" AutoPostBack="True"
                                        OnSelectedIndexChanged="Selected_Dl_Ngrk">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <asp:Panel ID="Pn_kons" runat="server" GroupingText="Група під спільним контролем та її вплив"
                            Font-Italic="True" ForeColor="#000099">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="Lb_NumGrp" runat="server" Text="Код групи" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Tb_NumGrp" runat="server" Visible="False" Enabled="False"></asp:TextBox>
                                        <Bars:Separator ID="s1" runat="server" BorderWidth="1px" />
                                        <Bars:ImageTextButton ID="Bt_grp" runat="server" ButtonStyle="Image" ImageUrl="/Common/Images/default/16/document_edit.png"
                                            OnClick="BtI_Clic_Grp" ToolTip="Перейти на розрахунок класу групи під спільним контролем "
                                            CausesValidation="False" EnabledAfter="0" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Lb_Gr_Klas" runat="server" Text="Клас групи" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Tb_Gr_Klas" runat="server" Visible="False" Enabled="False" AutoPostBack="True"></asp:TextBox>
                                        <asp:RangeValidator runat="server" ID="Valid_Tb_Gr_Klas" ControlToValidate="Tb_Gr_Klas"
                                            MinimumValue="1" MaximumValue="10" Type="Integer" ErrorMessage="Не проведено розрахунок класу групи"
                                            Display="Dynamic" SetFocusOnError="True"></asp:RangeValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Lb_NKZV" runat="server" Text="Наявність консолідованої звітності"
                                            Width="255px"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="Dd_NKZV" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "NKZV" +((char)39).ToString() + "and idf = 51 ") %>'
                                            AutoPostBack="True" OnSelectedIndexChanged="Selected_Dl_Nkzv" DataTextField="NAME"
                                            DataValueField="VAL" Width="100px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                            <asp:Panel ID="Pn_K0" runat="server" GroupingText="Відсутність консолідованої звітності">
                                <table>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Label ID="Lb_rko0n" runat="server" Text="Рішення колегіального органу №"></asp:Label>
                                            <asp:TextBox ID="Tb_rko0n" runat="server" Width="100px"></asp:TextBox>
                                            <asp:Label ID="Lb_rko0d" runat="server" Text=" від "></asp:Label>
                                            <Bars:TextBoxDate ID="Tb_rko0d" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Lb_GK2" runat="server" Text="Наявність стуттевого впливу  участі Контрагента у групі під спільни контрорлем"
                                                Width="255px"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="Dl_GK2" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "GK20" +((char)39).ToString() + "and idf = 51 ") %>'
                                                DataTextField="NAME" DataValueField="VAL" Width="100px">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel ID="Pn_K1" runat="server" GroupingText="Клас контрагента нижчий за клас групи під спільним контролем">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Lb_GK1_1" runat="server" Text="Наявність судження банку" Width="255px"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="Dl_GK1_1" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "GK11" +((char)39).ToString() + "and idf = 51 ") %>'
                                                DataTextField="NAME" DataValueField="VAL" Width="100px" AutoPostBack="True" OnSelectedIndexChanged="Dl_GK1_1SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                                <asp:Panel ID="Pn_K1_1" runat="server" Font-Italic="False" ForeColor="#000066">
                                    <table>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="Lb_rko1n" runat="server" Text="Рішення колегіального органу №"></asp:Label>
                                                <asp:TextBox ID="Tb_rko1n" runat="server" Width="100px"></asp:TextBox>
                                                <asp:Label ID="Lb_rko1d" runat="server" Text=" від "></asp:Label>
                                                <Bars:TextBoxDate ID="Tb_rko1d" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Lb_GK3" runat="server" Text="Звіт аудитора про консолідовану фінансову звітність групи містить немодифіковану думку/модифіковану думку із застереженнями"
                                                    Width="555px"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="Dl_GK3" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "GK3" +((char)39).ToString() + "and idf = 51 ") %>'
                                                    DataTextField="NAME" DataValueField="VAL" Width="100px" AutoPostBack="True" OnSelectedIndexChanged="Dl_GK_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Lb_GK4" runat="server" Text="Висновок аудиторського звіти не містить застереженьщодо периметра консолідованої звітності групи"
                                                    Width="555px"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="Dl_GK4" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "GK4" +((char)39).ToString() + "and idf = 51 ") %>'
                                                    DataTextField="NAME" DataValueField="VAL" Width="100px" AutoPostBack="True" OnSelectedIndexChanged="Dl_GK_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Lb_GK5" runat="server" Text="Борг Контрагента в повній сумі забезпечено безумовною та безвідкличною гарантією/фінансовою порукою материнської компанії/контролера та учасника групи юридичних осіб під спільним контролем"
                                                    Width="555px"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="Dl_GK5" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "GK5" +((char)39).ToString() + "and idf = 51 ") %>'
                                                    DataTextField="NAME" DataValueField="VAL" Width="100px" AutoPostBack="True" OnSelectedIndexChanged="Dl_GK_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                    <table>
                                        <tr>
                                            <td align="right" style="width: 380Px">
                                                <asp:Label ID="Lb_clas_plus" runat="server" Text="Клас підняти на " Font-Bold="True"
                                                    Font-Overline="False" Font-Strikeout="False" Font-Underline="True"></asp:Label>
                                            </td>
                                            <td style="width: 380Px">
                                                <asp:TextBox ID="Tb_clas_plus" runat="server" Width="25px" Style="text-align: center"></asp:TextBox>
                                                <asp:RangeValidator runat="server" ID="RangeValidator_clas_plus" ControlToValidate="Tb_clas_plus"
                                                    MinimumValue="0" MaximumValue="0" Type="Integer" ErrorMessage="Допустиме значення від 0 до 0"
                                                    Display="Dynamic" SetFocusOnError="True"></asp:RangeValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </asp:Panel>
                            <asp:Panel ID="Pn_K2" runat="server" GroupingText="Клас контрагента вищий за клас групи під спільним контролем">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Lb_GK1_2" runat="server" Text="Наявність судження банку" Width="255px"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="Dl_GK1_2" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "GK12" +((char)39).ToString() + "and idf = 51 ") %>'
                                                DataTextField="NAME" DataValueField="VAL" Width="100px" AutoPostBack="True" OnSelectedIndexChanged="Dl_GK1_2SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                                <asp:Panel ID="Pn_K2_1" runat="server">
                                    <table>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="Lb_rko2n" runat="server" Text="Рішення колегіального органу №"></asp:Label>
                                                <asp:TextBox ID="Tb_rko2n" runat="server" Width="100px"></asp:TextBox>
                                                <asp:Label ID="Lb_rko2d" runat="server" Text=" від "></asp:Label>
                                                <Bars:TextBoxDate ID="Tb_rko2d" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Lb_GK2_2" runat="server" Text="Наявність стуттевого впливу  участі Контрагента у групі під спільни контрорлем"
                                                    Width="255px"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="Dl_GK2_2" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "GK22" +((char)39).ToString() + "and idf = 51 ") %>'
                                                    DataTextField="NAME" DataValueField="VAL" Width="100px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </asp:Panel>
                        </asp:Panel>
                        <table>
                            <tr>
                                <td style="width: 355Px">
                                    <asp:Label ID="Lb_povkont" runat="server" Text="Належність до групи пов`язаних контрагентів"
                                        Width="355px" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="Dl_NgrP" runat="server" DataTextField="NAME" DataValueField="VAL"
                                        Width="100px" AutoPostBack="True" OnSelectedIndexChanged="Selected_Dl_Ngrp" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "NGRP" +((char)39).ToString() + "and idf = 51 ") %>'>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <asp:Panel ID="Pn_povk" runat="server" GroupingText="Група пов`язаних контрагентів та її вплив"
                            Font-Italic="True" ForeColor="#000299">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="Lb_GP1" runat="server" Text="1. Позичальник входить до групи під спільним контролем та надана консолідована фінансова звітність"
                                            Width="655px"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="Dl_GP1" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "GP1" +((char)39).ToString() + "and idf = 51 ") %>'
                                            DataTextField="NAME" DataValueField="VAL" Width="60px" AutoPostBack="True" OnSelectedIndexChanged="Dl_GP_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Lb_GP2" runat="server" Text="2. Контрагент належить до ОСББ/ЖБК" Width="655px"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="Dl_GP2" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "GP2" +((char)39).ToString() + "and idf = 51 ") %>'
                                            DataTextField="NAME" DataValueField="VAL" Width="60px" AutoPostBack="True" OnSelectedIndexChanged="Dl_GP_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Lb_GP3" runat="server" Text="3. Забезпечення за кредитною операцією Позичальнника є грошові кошти (у т.ч. грошове покриття) та/або майнові права на грошові кошти, що розміщені на депозитному рахунку  в установі банку, коофіциент покритт я заборгованості за основною сумою становить не менше 1,0"
                                            Width="655px"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="Dl_GP3" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "GP3" +((char)39).ToString() + "and idf = 51 ") %>'
                                            DataTextField="NAME" DataValueField="VAL" Width="60px" AutoPostBack="True" OnSelectedIndexChanged="Dl_GP_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Lb_GP4" runat="server" Text="4. Контрагент є Ключовим учасником группи пов`язаних контрагентів"
                                            Width="655px"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="Dl_GP4" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "GP4" +((char)39).ToString() + "and idf = 51 ") %>'
                                            DataTextField="NAME" DataValueField="VAL" Width="60px" AutoPostBack="True" OnSelectedIndexChanged="Dl_GP_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Lb_GP5" runat="server" Text="5. Відсутня можливість здійснити аналіз впливу"
                                            Width="655px" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="Dl_GP5" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "GP5" +((char)39).ToString() + "and idf = 51 ") %>'
                                            DataTextField="NAME" DataValueField="VAL" Width="60px" AutoPostBack="True" OnSelectedIndexChanged="Dl_GP_SelectedIndexChanged"
                                            Visible="False">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                            <asp:Panel ID="Pn_GP" runat="server" Font-Italic="True" ForeColor="#000299" Visible="False">
                                <asp:GridView ID="GridView_GP" runat="server" AutoGenerateColumns="False" CssClass="barsGridView"
                                    DataKeyNames="KOD,IDF,NAME,POB,ORD" BorderColor="#EFF3FB" ShowHeader="False">
                                    <Columns>
                                        <asp:BoundField DataField="NAME" HtmlEncode="False">
                                            <ItemStyle Wrap="True" HorizontalAlign="Left" Width="655px" Font-Italic="True" />
                                        </asp:BoundField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:DropDownList ID="DropDownList1" AppendDataBoundItems="true" DataSource='<%# SQL_SELECT_dataset(""+Eval("L_SQL")+"")%>'
                                                    DataTextField="NAME" DataValueField="VAL" Text='<%#Eval("S")%>' Enabled='<%# (Convert.ToString(Eval("POB")) == "1")?(false):(true) %>'
                                                    Width="60px" runat="server" ToolTip='<%# Eval("DESCRIPT")%>' Visible="true">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterStyle HorizontalAlign="Left" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </asp:Panel>
                    </asp:Panel>
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStep2" runat="server" Title=" Ознаки кредитного ризику">
                    <asp:Panel ID="Pn_Wizar2" runat="server" Enabled="true">
                        <table>
                            <tr>
                                <td style="width: 580Px">
                                    <asp:Label ID="Lb_Kzdv" runat="server" Text="Чиста кредитна заборгованість до чистої виручки від реалізації"></asp:Label>
                                </td>
                                <td style="width: 100Px">
                                    <asp:TextBox ID="Tb_Kzdv" runat="server" Width="100px" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 580Px">
                                    <asp:Label ID="Lb_Kzde" runat="server" Text="Чиста кредитна заборгованість до значення EBITDA"></asp:Label>
                                </td>
                                <td style="width: 100Px">
                                    <asp:TextBox ID="Tb_Kzde" runat="server" Width="100px" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 580Px">
                                    <asp:Label ID="Lb_SRKA" runat="server" Text="Сформований банком резерв під зменшення корисності наданого Контрагенту фінансового активу , %"></asp:Label>
                                </td>
                                <td style="width: 100Px">
                                    <asp:TextBox ID="Tb_SRKA" runat="server" Width="100px" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
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
                    </asp:Panel>
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStep3" runat="server" Title=" Подія дефолту настала">
                    <asp:Panel ID="Pn_Wizar3" runat="server">
                        <asp:GridView ID="GrWiz3" runat="server" AutoGenerateColumns="False" CssClass="barsGridView"
                            DataKeyNames="KOD,IDF,NAME,POB" BorderColor="#EFF3FB" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="NAME" HtmlEncode="False">
                                    <ItemStyle Wrap="False" HorizontalAlign="Left" Width="600px" Font-Italic="True" />
                                </asp:BoundField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:DropDownList ID="DropDownList1" AutoPostBack="true" AppendDataBoundItems="true"
                                            DataSource='<%# SQL_SELECT_dataset(""+Eval("L_SQL")+"")%>' DataTextField="NAME"
                                            DataValueField="VAL" Text='<%#Eval("S")%>' Enabled='<%# (Convert.ToString(Eval("POB")) == "1")?(false):(true) %>'
                                            Width="100px" runat="server" ToolTip='<%# Eval("DESCRIPT")%>' Visible="true"
                                            OnSelectedIndexChanged="GrWiz3_SelectedIndexChanged">
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
                    <asp:Panel ID="Pn_Wizar3_2" runat="server" Visible="False">
                        <table>
                            <tr>
                                <td style="width: 570Px">
                                    <asp:Label ID="l_PD8_d" runat="server" Text="Дата проведення  останньої зміни активу на інший актив"></asp:Label>
                                </td>
                                <td>
                                    <Bars:TextBoxDate ID="tb_PD8_d" runat="server" IsRequired="true" Width="100px" MinValue="01/01/1900"
                                        MaxValue="01/01/2999"></Bars:TextBoxDate>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStep4" runat="server" Title=" Ознаки визнання дефолту">
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
                                    <asp:DropDownList ID="Dd_VD0" runat="server" Width="100px" AutoPostBack="True" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "VD0" +((char)39).ToString() + "and idf = 56 ") %>'
                                        DataTextField="NAME" DataValueField="VAL" OnSelectedIndexChanged="Dd_VD0_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="Lb_VDN1" runat="server" Text="Рішення колегіального органу №" Visible="False"></asp:Label>
                                    <asp:TextBox ID="Tb_VDN1" runat="server" Width="100px" Visible="False"></asp:TextBox>
                                    <asp:Label ID="Lb_VDD1" runat="server" Text=" від " Visible="False"></asp:Label>
                                    <Bars:TextBoxDate ID="Tb_VDD1" runat="server" Visible="False" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStep5" runat="server" Title=" Ознаки припинення дефолту">
                    <asp:Panel ID="w5_p1" runat="server" GroupingText="Фінансова реструктуризація">
                        <table>
                            <tr>
                                <td style="width: 300Px">
                                    <asp:Label ID="Lb_zd6" runat="server" Text="Відбулась фінансова реструктуризація"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="Dd_zd6" runat="server" Width="100px" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "ZD6" +((char)39).ToString() + "and idf = 55 ") %>'
                                        DataTextField="NAME" DataValueField="VAL" AutoPostBack="True" OnSelectedIndexChanged="Dd_zd6_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Lb_dzd6" runat="server" Text=" Дата фінансової реструктуризації "></asp:Label>
                                </td>
                                <td>
                                    <Bars:TextBoxDate ID="Tb_dzd6" runat="server" Width="100" />
                                </td>
                            </tr>
                            <tr>
                            <td>
                             <asp:Label ID="Lb_zd8" runat="server" Text="Запроваджено процедуру фінансової реструктуризації"></asp:Label>
                            </td>
                            <td>
                             <asp:DropDownList ID="Dd_zd8" runat="server" Width="100px" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "ZD8" +((char)39).ToString() + "and idf = 55 ") %>'
                                        DataTextField="NAME" DataValueField="VAL" AutoPostBack="True" OnSelectedIndexChanged="Dd_zd6_SelectedIndexChanged">
                                    </asp:DropDownList>
                            </td>
                            <td><asp:Image ID="Im_zd8" runat="server" ImageUrl="/Common/Images/default/16/help2.png"
                                            ToolTip="1 - учасниками якої є банки - резиденти України *
2 - учасниками якої є банки - резиденти України, банки-нерезиденти, іноземні державні експортні кредитні агенції, міжнародні фінансові організації, утримувачі єврооблігацій* 
 * за умови, що строк дії забезпечення не менше ніж строк фінансової реструктуризації боржника та банк зберігає право звернути стягнення на таке забезпечення як протягом проведення процедури такої реструктуризації, так і після її завершення" /></td>
                            </tr>
                            <tr>
                                <td style="width: 300Px">
                                    <asp:Label ID="Lb_zd7" runat="server" Text="Зняти дефолт?"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="Dd_zd7" runat="server" Width="100px" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "ZD7" +((char)39).ToString() + "and idf = 55 ") %>'
                                        DataTextField="NAME" DataValueField="VAL" AutoPostBack="True" OnSelectedIndexChanged="Dd_zd7_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="Lb_nzd7" runat="server" Text="Рішення колегіального органу №"></asp:Label>
                                    <asp:TextBox ID="Tb_nzd7" runat="server" Width="100px" AutoPostBack="True"></asp:TextBox>
                                    <asp:Label ID="Lb_dzd7" runat="server" Text=" від "></asp:Label>
                                    <Bars:TextBoxDate ID="tb_dzd7" runat="server" />
                                    <asp:RangeValidator runat="server" ID="RV_nzd7" ControlToValidate="Tb_nzd7" MinimumValue="0"
                                        MaximumValue="99999999" Type="Integer" ErrorMessage="Не вірно вказано" Display="Dynamic"
                                        SetFocusOnError="True"></asp:RangeValidator>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="w5_p2" runat="server">
                        <asp:Panel ID="Pn_Wizar5" runat="server">
                            <asp:GridView ID="GrWiz5" runat="server" AutoGenerateColumns="False" CssClass="barsGridView"
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
                        <asp:Panel ID="p_events" runat="server" Visible="false">
                            <table>
                                <tr>
                                    <td style="width: 550Px">
                                        <asp:Label ID="lb_ZD4" runat="server" Text="  3 - З моменту усунення події/подій, на підставі якої/яких було визнано дефолт боржника, минуло щонайменше 180 днів "
                                            Width="550px"></asp:Label>
                                    </td>
                                    <td style="width: 100Px">
                                        <asp:DropDownList ID="dl_ZD4" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "ZD4" +((char)39).ToString() + "and idf = 55 ") %>'
                                            DataTextField="NAME" DataValueField="VAL" Enabled="false" Width="100px" 
                                            OnSelectedIndexChanged="dl_ZD4_SelectedIndexChanged" AutoPostBack="true" >
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 50Px">
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="Pn_Wizar5_2" runat="server" GroupingText="Судження банку..." Visible="False">
                            <table>
                                <tr>
                                    <td style="width: 400Px">
                                        <asp:Label ID="Lb_ZD3" runat="server" Text="Банк має документально підтверджене обґрунтоване судження, що Контрагент, попри наявні фінансові труднощі, спроможний обслуговувати борг"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="Dl_ZD3" runat="server" Width="100px" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "ZD3" +((char)39).ToString() + "and idf = 55 ") %>'
                                            DataTextField="NAME" DataValueField="VAL">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Label ID="Lb_ZDN1" runat="server" Text="Рішення колегіального органу №"></asp:Label>
                                        <asp:TextBox ID="Tb_ZDN1" runat="server" Width="100px" AutoPostBack="True" OnTextChanged="Tb_ZDN1_TextChanged"></asp:TextBox>
                                        <asp:Label ID="Lb_ZDD1" runat="server" Text=" від "></asp:Label>
                                        <Bars:TextBoxDate ID="Tb_ZDD1" runat="server" OnValueChanged="Tb_ZDN1_TextChanged" />
                                        <asp:RangeValidator runat="server" ID="RangeValidator_Tb_ZDN1" ControlToValidate="Tb_ZDN1"
                                            MinimumValue="0" MaximumValue="99999999" Type="Integer" ErrorMessage="Не вірно вказано"
                                            Display="Dynamic" SetFocusOnError="True"></asp:RangeValidator>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </asp:Panel>
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStep6" runat="server" Title="Додаткові показники коригування коофіциенту PD">
                    <asp:Panel runat="server" ID="Pn_Wizard6">
                        <asp:GridView ID="GrWiz6" runat="server" AutoGenerateColumns="False" CssClass="barsGridView"
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
                <asp:WizardStep ID="WizardStep7" runat="server" Title=" Розрахунок " StepType="Finish">
                    <asp:Panel ID="Pn_Wizar7" runat="server">
                        <table>
                            <tr>
                                <td style="width: 580Px">
                                    <asp:Label ID="Lb_RK1" runat="server" Text="Подія дефолту настала"></asp:Label>
                                </td>
                                <td style="width: 100Px">
                                    <asp:DropDownList ID="Dd_RK1" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "RK1" +((char)39).ToString() + "and idf = 56 ") %>'
                                        DataTextField="NAME" DataValueField="VAL" Width="100px" Enabled="false">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 580Px">
                                    <asp:Label ID="Lb_RK2" runat="server" Text="Наявність ознак для визнання події дефолту"></asp:Label>
                                </td>
                                <td style="width: 100Px">
                                    <asp:DropDownList ID="Dd_RK2" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "RK2" +((char)39).ToString() + "and idf = 56 ") %>'
                                        DataTextField="NAME" DataValueField="VAL" Width="100px" Enabled="false">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 580Px">
                                    <asp:Label ID="Lb_RK3" runat="server" Text="Припинення визнання дефолту "></asp:Label>
                                </td>
                                <td style="width: 100Px">
                                    <asp:DropDownList ID="Dd_RK3" runat="server" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "RK3" +((char)39).ToString() + "and idf = 56 ") %>'
                                        DataTextField="NAME" DataValueField="VAL" Width="100px" Enabled="false">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <Bars:ImageTextButton ID="Bt_save" runat="server" ImageUrl="/Common/Images/default/16/money_calc.png"
                                        Text="Розрахувати" ToolTip="Скорегувати клас та розрахувати показник PD " CssClass="navigationButton"
                                        OnClick="Bt_save_Click" EnabledAfter="0" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="clas_run" runat="server" Visible="false">
                        <table>
                            <tr>
                                <td style="width: 580Px">
                                    <asp:Label ID="Lb_clas" runat="server" Text="Клас визначений з інтегрального показника "></asp:Label>
                                </td>
                                <td style="width: 100Px">
                                    <asp:TextBox ID="Tb_clas" runat="server" Enabled="false" Width="100px" Style="text-align: right"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 580Px">
                                    <asp:Label ID="Lb_cls1" runat="server" Text="Клас скоригований з впливом групи під спільним контрорлем "></asp:Label>
                                </td>
                                <td style="width: 100Px">
                                    <asp:TextBox ID="Tb_cls1" runat="server" Enabled="false" Width="100px" Style="text-align: right"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 580Px">
                                    <asp:Label ID="Lb_cls2" runat="server" Text="Клас скоригований з впливом групи пов`язаних контрагентів"></asp:Label>
                                </td>
                                <td style="width: 100Px">
                                    <asp:TextBox ID="Tb_cls2" runat="server" Enabled="false" Width="100px" Style="text-align: right"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 580Px">
                                    <asp:Label ID="Lb_cls" runat="server" Text="Зкорегований клас"></asp:Label>
                                </td>
                                <td style="width: 100Px">
                                    <asp:TextBox ID="Tb_cls" runat="server" Enabled="false" Width="100px" Style="text-align: right"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 580Px">
                                    <asp:Label ID="Lb_clsp" runat="server" Text="Зкорегований клас  з врахуванням кількості днів прострочки"></asp:Label>
                                </td>
                                <td style="width: 100Px">
                                    <asp:TextBox ID="Tb_clsb" runat="server" Enabled="false" Width="100px" Style="text-align: right"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 580Px">
                                    <asp:Label ID="Lb_PD" runat="server" Text="Значення коофіцієнту PD"></asp:Label>
                                </td>
                                <td style="width: 100Px">
                                    <asp:TextBox ID="Tb_PD" runat="server" Enabled="false" Width="100px" Style="text-align: right"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="Pn_buton" runat="server">
                        <table>
                            <tr>
                                <td>
                                    <Bars:ImageTextButton ID="BtI_Cardkl" runat="server" ButtonStyle="Image" ImageUrl="/Common/Images/CUSTPERS.gif"
                                        Text="" OnClick="BtI_Cardkl_Click" ToolTip="Повернутись на карточку фінстану позичальника "
                                        Width="30px" Height="30px" />
                                </td>
                                <td>
                                    <Bars:ImageTextButton ID="BtI_Print" runat="server" ButtonStyle="Image" ImageUrl="/Common/Images/default/24/printer.png"
                                        Text="" OnClick="BtI_Clic_Print" ToolTip="Сформувати висновок " Width="30px"
                                        Visible="false" Height="30px" />
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
