<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fin_form_pd_fo.aspx.cs" Inherits="credit_fin_nbu_fin_form_pd_fo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet" />
    <link href="/Common/css/default.css" type="text/css" rel="stylesheet" />
<%--    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>--%>
    <script language="javascript" type="text/javascript" src="/barsroot/credit/jscript/JScript.js"></script>
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
            border: 1px solid #29acf7;
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
    <script type="text/javascript" src="/barsroot/Scripts/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/jquery/jquery-ui.min.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/jquery/jquery.bars.ui.js"></script>

    <link href="/barsroot/Content/Themes/Kendo/kendo.common.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.common.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.dataviz.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.bootstrap.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.dataviz.bootstrap.min.css" rel="stylesheet" />
<link href="/barsroot/Content/images/PureFlat/pf-icons.css" rel="stylesheet" />
    <script src="/barsroot/Scripts/kendo/kendo.all.min.js"></script>
    <script src="/barsroot/Scripts/kendo/kendo.aspnetmvc.min.js"></script>
    <script src="/barsroot/Scripts/kendo/cultures/kendo.culture.uk.min.js"></script>
    <script src="/barsroot/Scripts/kendo/cultures/kendo.culture.uk-UA.min.js"></script>
    <script src="/barsroot/Scripts/kendo/messages/kendo.messages.uk-UA.min.js"></script>
	
    <script src="/barsroot/Scripts/Bars/bars.ui.js"></script>
    <script src="/barsroot/Scripts/Bars/bars.utils.js"></script>
    <script src="/barsroot/Scripts/Bars/bars.config.js"></script>
    <script language="javascript" type="text/javascript">
		var viewCustomerWinOptions = {
			width: 1111,
			height: 610
		}
		function EditClient() {
			var rnk = document.getElementById("RNK_").value;
            var oldUrl = window.location.href;
			var url = bars.config.urlContent('/clientregister/registration.aspx?readonly=0&kred=1&rnk='+rnk);
			bars.ui.dialog({
				actions:['Maximize', 'Close'],
				close: function () {
                    window.location.href = oldUrl;//.reload(true);
				},
				iframe: true,
				content: {
					url: url
				},
				width: viewCustomerWinOptions.width,
				height: viewCustomerWinOptions.height
			});	
		}
	</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:HiddenField ID="RNK_" runat="server" />
        <asp:HiddenField ID="ND_" runat="server" />
        <asp:HiddenField ID="OKPO_" runat="server" />
        <asp:HiddenField ID="DAT_" runat="server" />
        <asp:Label ID="Lv_title" runat="server" Text="Визначення значення PD боржника" CssClass="pageTitle"></asp:Label>
        <asp:Panel ID="Pn1" runat="server" Width="920px" ToolTip="Виконання дій" GroupingText="Виконання дій"
            CssClass="pageContainer">
            <table width="910px">
                <tr>
                    <td>
                        <asp:Label ID="Lb_rnk" runat="server" Text="РНК:"></asp:Label>
                        <asp:TextBox ID="Tb_rnk" runat="server" ReadOnly="true" Width="90Px" BackColor="#CCFFFF"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="Lb_okpo" runat="server" Text="ОКПО:"></asp:Label>
                        <asp:TextBox ID="Tb_okpo" runat="server" ReadOnly="true" Width="90Px" BackColor="#CCFFFF"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="Lb_ref" runat="server" Text="REF договору:"></asp:Label>
                        <asp:TextBox ID="Tb_ref" runat="server" ReadOnly="true" Width="90Px" BackColor="#CCFFFF"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="Lb_dat" runat="server" Text="Дата:"></asp:Label>
                        <asp:TextBox ID="Tb_dat" runat="server" ReadOnly="true" Width="90Px" BackColor="#CCFFFF"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="Pn2" runat="server" Width="905px" Style="margin-left: 20px; margin-right: 10px;
            margin-top: 10px">
            <table>
                <tr>
                    <td style="width: 190Px">
                        <asp:Label ID="Lb_clas" runat="server" Text="Скоригований клас боржника"></asp:Label>
                    </td>
                    <td style="width: 100Px; text-align: center;">
                        <asp:DropDownList ID="Dl_clas" runat="server" BackColor="#FFEBFF" Width="70px" DataTextField="num"
                            DataValueField="num" DataSource='<%# SQL_SELECT_dataset("select num from conductor where num <=5") %>'
                            OnSelectedIndexChanged="Dl_SelectedIndexChanged" AutoPostBack="true">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="width: 190Px">
                        <asp:Label ID="Lb_pd" runat="server" Text="Значення PD боржника"></asp:Label>
                    </td>
                    <td style="width: 100Px; text-align: center;">
                        <asp:TextBox ID="Tb_pd" runat="server" Width="65Px" ReadOnly="true"></asp:TextBox>
                    </td>
                    <td colspan="2" style="width: 580Px; text-align: center;">
                        <asp:Label ID="Lb_namedp" runat="server" Text="Додаткові показники для визначення PD"
                            CssClass="pageTitle"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 190Px">
                    </td>
                    <td style="width: 100Px">
                    </td>
                    <td style="width: 300Px; text-align: center;" bgcolor="#E4E4E4">
                        <asp:Label ID="LbN1" runat="server" Text="Назва" CssClass="tableTitle"></asp:Label>
                    </td>
                    <td style="width: 280Px; text-align: center;" bgcolor="#E4E4E4">
                        <asp:Label ID="LbN2" runat="server" Text="Відповідь" CssClass="tableTitle"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 190Px">
                    </td>
                    <td style="width: 100Px">
                    </td>
                    <td style="width: 300Px; text-align: left;">
                        <asp:Label ID="Lb_VNKR" runat="server" Text="Внутрішній кредитний рейтинг"></asp:Label>
                    </td>
                    <td style="width: 280Px; text-align: center;">
                        <asp:DropDownList ID="Dl_bkrr" runat="server" Width="190Px" BackColor="#FFEBFF" DataTextField="code"
                            DataValueField="code" DataSource='<%# SQL_SELECT_dataset("select code from CCK_RATING where ord < 41") %>'
                            OnSelectedIndexChanged="Dl_SelectedIndexChanged" AutoPostBack="true">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="width: 190Px">
                    </td>
                    <td style="width: 100Px">
                    </td>
                    <td style="width: 300Px; text-align: left;">
                        <asp:Label ID="Lb_kredhist" runat="server" Text="Кредитна історія"></asp:Label>
                    </td>
                    <td style="width: 280Px; text-align: center;">
                        <asp:DropDownList ID="DL_kredhist" runat="server" Width="190Px" BackColor="#FFEBFF"
                            DataTextField="name" DataValueField="val" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "IP1" +((char)39).ToString() + "and idf = 60 ") %>'
                            ToolTip="ПОЗИТИВНИЙ - прострочка погашення боргу протягом останніх 12 місяців не перевищує 7 днів 
ДОБРА - прострочка погашення боргу протягом останніх 12 місяців становить від 8 до 30 днів
ЗАДОВІЛЬНА - прострочка погашення боргу протягом останніх 12 місяців становить від 31 до 60 днів
НЕГАТИВНА - прострочка погашення боргу протягом останніх 12 місяців перевищує 60" OnSelectedIndexChanged="Dl_SelectedIndexChanged"
                            AutoPostBack="true">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="width: 190Px">
                    </td>
                    <td style="width: 100Px">
                    </td>
                    <td style="width: 300Px; text-align: left;">
                        <asp:Label ID="Lb_zkd" runat="server" Text="Забезпечення є забезпеченням за декількома кредитними операціями"></asp:Label>
                    </td>
                    <td style="width: 280Px; text-align: center;">
                        <asp:CheckBox ID="Cb_zkd" runat="server" Checked="false" OnCheckedChanged="Cb_zkd_CheckedChanged"
                            AutoPostBack="True" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 190Px">
                        <asp:Label ID="Lb_kkpz" runat="server" Text="Коофіцієнт покриття основної суми боргу забезпеченням"></asp:Label>
                    </td>
                    <td style="width: 100Px">
                        <asp:TextBox ID="tb_kpz" runat="server" Enabled="false"></asp:TextBox>
                    </td>
                    <td style="width: 300Px; text-align: left;">
                        <asp:Label ID="Lb_kpz" runat="server" Text="Зважений коефіцієнт покриття боргу забезпеченням"></asp:Label>
                    </td>
                    <td style="width: 280Px; text-align: center;">
                        <asp:DropDownList ID="DL_kpz" runat="server" Width="190Px" BackColor="#FFEBFF" DataTextField="name"
                            DataValueField="val" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "IP2" +((char)39).ToString() + "and idf = 60 ") %>'
                            ToolTip="ВИСОКИЙ - покриття основної суми боргу забезпеченням, що відповідає вимогам НБУ, становить  ≥ 1,3
ДОБРИЙ  - покриття основної суми боргу забезпеченням, що відповідає вимогам НБУ, становить  Більше рівно  1,0
НИЗЬКИЙ - покриття основної суми боргу забезпеченням, що відповідає вимогам НБУ, становить більше 1,0, або забезпечення відсутнє"
                            OnSelectedIndexChanged="Dl_SelectedIndexChanged" AutoPostBack="true">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="Pn_dop601" runat="server" Width="905px" Style="margin-left: 20px;
            margin-right: 10px; margin-top: 10px">
            <table>
                  <colgroup> <col style="width: 330px"/> <col style="width: 550px"/> </colgroup>
                  <tr><td></td><td><asp:Label ID="Lb_nampan" runat="server" Text="Додаткові показники" CssClass ="pageTitle" ></asp:Label><asp:HiddenField ID="h_lbr_type" runat="server"/> </td></tr>
              </table>

            <asp:Panel ID="Panel_epl" runat="server" Width="920px" ToolTip="Місце роботи ( organization)" GroupingText="Місце роботи"
            CssClass="pageContainer">
              <table>
                  <colgroup> <col style="width: 190px"/> <col style="width: 140px"/> <col style="width: 300px"/> <col style="width: 250px"/> </colgroup>
                <tr>
                      <td><asp:Label ID="Lb_typeW" runat="server" Text="Тип роботодавця"></asp:Label></td><td><asp:DropDownList ID="dl_typeW" runat="server" Enabled="false"></asp:DropDownList></td>
                      <td style="text-align:right;">
                          <asp:Label ID="Lb_EDRPO" runat="server" Text="Код ЕДРПОУ роботодавця"></asp:Label></td><td><asp:TextBox ID="tb_EDRPO" runat="server" Enabled="false"></asp:TextBox></td>
                </tr>
                  <tr><td><asp:Label ID="Lb_NAMEW" runat="server" Text="Найменування роботодавця"></asp:Label></td><td colspan="3"><asp:TextBox ID="tb_NAMEW" runat="server" style="width: 710px" Enabled="false"></asp:TextBox></td></tr>
              </table>
            </asp:Panel>

            <table>
                  <colgroup> <col style="width: 190px"/> <col style="width: 140px"/> <col style="width: 300px"/> <col style="width: 250px; text-align: center;"/> </colgroup>
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td></td> <td></td> <td><asp:Label ID="Lb_Education" runat="server" Text="Освіта"></asp:Label></td> 
                    <td>
                        <asp:DropDownList ID="dl_Education" runat="server" CssClass="BaseDropDownList" Enabled="false"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td> 
						<button Class="navigationButton" type="button" style="margin-left: 25px" title="Редагувати картку клієнта" OnClick="return EditClient();">Редагувати</button> 
					</td> <td></td> 
					<td> <asp:Label ID="Lb_real6month" runat="server" Text="Підтверджений дохід боржника"></asp:Label></td>
                    <td>
                        <bec:TextBoxDecimal runat="server" ID="tb_real6month" Width="190Px"  MinValue="0" Enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td></td> <td></td> <td><asp:Label ID="Lb_noreal6month" runat="server" Text="Непідтверджений дохід боржника"></asp:Label></td>
                    <td>
                        <bec:TextBoxDecimal runat="server" ID="tb_noreal6month" Width="190Px"  MinValue="0"  Enabled="false"  />
                    </td>
                </tr>
                <tr>
                    <td></td> <td></td> <td><asp:Label ID="Lb_status" runat="server" Text="Сімейний стан боржника"></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="dl_status" runat="server"  Width="190px" Enabled="false"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td></td> <td></td> <td><asp:Label ID="Lb_members" runat="server" Text="Кількість осіб, що перебувають на утриманні Боржника"></asp:Label></td>
                    <td>
                        <bec:TextBoxNumb runat="server" ID="tb_members" Enabled="false" Width="190Px"/>
                    </td>
                </tr>
                <tr>
                    <td></td> <td></td> <td><asp:Label ID="Lb_real6income" runat="server" Text="Середній підтверджений  дохід особи, що надала фінансову поруку (гарантію)"></asp:Label></td>
                    <td>
                        <bec:TextBoxDecimal runat="server" ID="tb_real6income" IsRequired="false" RequiredErrorText="Необхідно заповнити середній підтверджений дохід особи" Enabled="true" Width="190Px" MinValue="0"  />
                    </td>
                </tr>
                <tr>
                    <td></td> <td></td> <td><asp:Label ID="Lb_noreal6income" runat="server" Text="Регулярний непідтверджений дохід особи, що надала фінансову поруку (гарантію)"></asp:Label></td>
                    <td>
                       <bec:TextBoxDecimal runat="server" ID="tb_noreal6income" IsRequired="false" Width="190Px" MinValue="0"  />
                     
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="Pn3" runat="server" Width="905px" Style="margin-left: 20px; margin-right: 10px;
            margin-top: 30px">
            <table>
                <tr>
                    <td style="width: 190Px"></td>
                    <td style="width: 100Px"></td>
                    <td style="width: 300Px; text-align: left;"></td>

                    <td style="width: 280Px; text-align: center;">
                        <asp:Button ID="Bt_save" runat="server" Text="Зберегти" Width="110Px" Height="35Px"
                            CssClass="navigationButton" OnClick="Bt_save_Click" />
                        <asp:Button ID="Bt_tofolders" runat="server" Text="Повернутись" ToolTip="Повернутись на попередню сторінку" 
                            Width="110Px" Height="35Px" CssClass="navigationButton" OnClick="Bt_tofolders_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
    </asp:ScriptManager>
    </form>
</body>
</html>
