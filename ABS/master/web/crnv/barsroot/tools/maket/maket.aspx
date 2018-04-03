<%@ Page Language="C#" AutoEventWireup="true" CodeFile="maket.aspx.cs" Inherits="tools_maket_maket" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Виконання операцій по макетах</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <%--<link href="/barsroot/docinput/Styles.css" type="text/css" rel="stylesheet" />--%>
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
        <script type="text/javascript">
        function selectAccounts(nl) {
            var charCode = 123;
            var VK_F12 = 123;
            var e_n = 1;
            if ("NLSB" == nl) e_n = 2;
            if (VK_F12 == charCode) {
                var mfo, kv, nls;
                var dk = 1;
                var type = "";

                if (e_n == 1) {
                    mfo = document.getElementById("OURMFO__").value;
                    kv = 980;
                    nls = document.getElementById("tb_NLSA").value;
                    type = (1 != dk) ? (1) : (0);
                }
                else {
                    mfo = document.getElementById("tb_MFO").value;
                    kv = 980;
                    nls = document.getElementById("tb_NLSB").value;
                    type = (0 != dk) ? (1) : (0);
                }
                var tt = document.getElementById("TT__").value; ;
                if (document.getElementById("TT__").value.length > 1) {
                    if (mfo != document.getElementById("OURMFO__").value) type = -1;
                    var result = window.showModalDialog("dialog.aspx?type=metatab_base&role=wr_doc_input&dk=" + type + "&nls=" + nls + "&mfo=" + mfo + "&kv=" + kv + "&tt=" + tt,
			window,
			"dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
                    if (result != null) {
                        if (e_n == 1) {
                            document.getElementById("tb_NLSA").value = result[0];
                        }
                        else {
                            if (-1 != type) { document.getElementById("tb_NLSB").value = result[0]; } else { document.getElementById("tb_NLSB").value = result[1]; document.getElementById("tb_MFO").value = result[0]; } if ("" == document.getElementById("tb_NAM_B").value) document.getElementById("tb_NAM_B").value = result[2];
                            document.getElementById("tb_OKPOB").value = result[3];
                            document.getElementById("tb_NAM_B").value = result[2];
                        }
                    }

                }
            }
        }
    </script>
    <%--<script type="text/javascript" src="/Common/Script/BarsIe.js"></script>
    <script type="text/javascript">
        window.onload = function () {
            webService.useService("/barsroot/docinput/DocService.asmx?wsdl", "Doc");
        }

        function PrintDocs() {
            var refs = document.getElementById("hRefList").value.split(';');
            for (var i = 0; i < refs.length - 1; i++) {
                webService.Doc.callService(onPrint, "GetFileForPrint", refs[i]);
            }
        }

        function onPrint(result) {
            if (!getError(result)) return;
            var filename = result.value;
            barsie$print(filename);
        }
        //Обработка ошибок от веб-сервиса
        function getError(result, modal) {
            if (result.error) {
                if (window.dialogArguments || parent.frames.length == 0 || modal) {
                    window.showModalDialog("dialog.aspx?type=err", "", "dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
                }
                else
                    location.replace("dialog.aspx?type=err");
                return false;
            }
            return true;
        }
    </script>
    <style type="text/css">
        .style1
        {
            color: #CC3300;
        }
        .webservice
        {
            behavior: url(/Common/WebService/js/WebService.htc);
        }
    </style>--%>
    <style type="text/css">
        .style1
        {
            color: #CC3300;
        }
        #img1
        {
            height: 15px;
            width: 13px;
        }
    </style>
</head>
<body bgcolor="#f0f0f0">
    <form id="form1" runat="server">
    <div class="pageTitle">
        <asp:Label ID="lbTitle" runat="server" Text="Виконання макетів документів"></asp:Label>
    </div>
    <asp:Panel ID="pnGRP"  runat="server" Visible="true" >
        <br />
        <table>
            <tr>
                <td nowrap="nowrap">
                    <asp:Label ID="lbTts" runat="server" Text="Група макетів:"></asp:Label>
                </td>
                <td>
                    <cc1:Separator ID="Separator5" runat="server" BorderWidth="1px" />
                </td>
                <td>
                    <asp:HyperLink ID="test" runat="server" ImageUrl="/common/Images/default/16/options.png"
                        ToolTip="Налаштування груп макетів" NavigateUrl="/barsroot/barsweb/references/refbook.aspx?tabname=MAKW_GRP&mode=RW&force="></asp:HyperLink>
                </td>
                <td>
                    <cc1:Separator ID="Separator6" runat="server" BorderWidth="1px" meta:resourcekey="Separator2Resource1" />
                </td>
                <td nowrap="nowrap">
                    <asp:DropDownList ID="ddGRP" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddTts_SelectedIndexChanged"
                        Width="400px" ToolTip="Вибір групи макетів">
                    </asp:DropDownList>
                </td>
                <td>
                    &nbsp;<asp:Button ID="btRefresh" runat="server" OnClick="btRefresh_Click" Text="Перечитати"
                        CausesValidation="false" Width="100px" />
                </td>
                <td>
                    &nbsp;<asp:Button ID="btPay" runat="server" OnClick="btPay_Click" Text="Виконати проводки"
                        CausesValidation="true" Visible="false" />
                </td>
                <td width="10%">
                    <img runat="server" id="imgPrintAll" onclick="PrintDocs()" alt="Роздрукувати оплачені ордера"
                        src="/common/images/print.gif" visible="false" />
                </td>
                <td width="100%">
                    <asp:CheckBox ID="cb_sump" runat="server" Text="Фіксовані суми" AutoPostBack="true"
                        OnCheckedChanged="cb_sump_CheckedChanged" Visible="false" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnResult" runat="server" Visible="false" GroupingText="Результат"
        Style="margin-left: 0px;">
        <asp:Label ID="lbInfo" runat="server" Text=""></asp:Label>
    </asp:Panel>
    <asp:Panel ID="pn_nazn" runat="server" Visible="false">
        <table>
            <tr>
                <td>
                    <cc1:Separator ID="Separator2" runat="server" BorderWidth="1px" />
                </td>
                <td>
                    <asp:ImageButton ID="bt_insert" runat="server" ButtonStyle="Image" ImageUrl="/common/Images/default/16/new.png"
                        CausesValidation="false" ToolTip="Додати новий макет документу" OnClick="Clik_bt_insert" />
                </td>
                <td>
                    <cc1:Separator ID="Separator1" runat="server" BorderWidth="1px" />
                </td>
                <td>
                    <asp:ImageButton ID="bt_edit" runat="server" ButtonStyle="Image" ImageUrl="/common/Images/default/16/edit.png"
                        CausesValidation="false" ToolTip="Редагувати макет документу" OnClick="Clik_bt_edit" />
                </td>
                <td>
                    <cc1:Separator ID="Separator3" runat="server" BorderWidth="1px" />
                </td>
                <td>
                    <asp:ImageButton ID="bt_del" runat="server" ButtonStyle="Image" ImageUrl="/common/Images/default/16/delete.png"
                        ToolTip="Видалити макет документу" OnClick="Clik_bt_del" OnClientClick="if (!confirm('Видалити макет документу?')) return false;"
                        CausesValidation="false" />
                </td>
                <td>
                    <cc1:Separator ID="Separator4" runat="server" BorderWidth="1px" />
                </td>
                <td>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="dop_nazn" runat="server" Width="400Px" Visible="true" ToolTip="Доповнення до призначення платежу"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:CheckBox ID="cb_nazn" runat="server" Text="Доп. призначення платежу" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnDataMaket" runat="server" Visible="true">
        <Bars:BarsGridViewEx AllowPaging="false" ID="DataMaket" runat="server" CssClass="barsGridView"
            CaptionType="Simple" Visible="true" AutoGenerateColumns="False" OnRowDataBound="DataDepository_RowDataBound"
            ShowCaption="False" DataKeyNames="GRP, ID" AllowSorting="True">
            <Columns>
                <asp:BoundField DataField="TT" HeaderText="Код&lt;BR&gt; операції" HtmlEncode="False">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="NLSA" HeaderText="Рахунок&lt;BR&gt; А" HtmlEncode="False">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="MFOB" HeaderText="МФО&lt;BR&gt; Б" HtmlEncode="False">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="NLSB" HeaderText="Рахунок&lt;BR&gt; Б" HtmlEncode="False">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="OKPOB" HeaderText="ОКПО&lt;BR&gt; Б" HtmlEncode="False">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="NAM_B" HeaderText="Назва отримувача&lt;BR&gt; " HtmlEncode="False">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Сума&lt;BR&gt; документа">
                    <ItemTemplate>
                        <asp:TextBox onkeydown="return doKeyDown(window.event)" onkeypress="return doKeyPress(window.event)"
                            Width="60" ID="tbCount" TabIndex="1" runat="server" Text='<%# Bind("SUMP", "{0:F2}") %>' MaxLength="12"
                            Style="text-align: right" />
                        <asp:RegularExpressionValidator runat="server" ID="tbCount_valid" Display="Dynamic"
                            ControlToValidate="tbCount" ValidationExpression=">(^(\ |\-)(0|([1-9][0-9]*))([\.\,][0-9]{0,2})?$)|(^(0{0,1}|([1-9][0-9]*))([\.\,][0-9]{0,2})?$)"
                            SetFocusOnError="true" BackColor="Yellow" ToolTip="Не вірний формат суми">Помилка</asp:RegularExpressionValidator>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Призначення&lt;BR&gt; платежу">
                    <ItemStyle />
                    <ItemTemplate>
                        <div style="width: 300px; white-space: normal">
                            <asp:TextBox ID="tbNazn" runat="server" Width="295" Text='<%# Bind("NAZN") %>' TextMode="SingleLine"></asp:TextBox></div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Реф.">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:TemplateField>
                <asp:BoundField DataField="BRANCH" HeaderText="Бранч&lt;BR&gt;  для фін.рез. " HtmlEncode="False">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="ORD" HeaderText="Порядок&lt;BR&gt; сортування" HtmlEncode="False">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="ID" HeaderText="ID" HtmlEncode="False">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
        </Bars:BarsGridViewEx>
        <br />
    </asp:Panel>
    <asp:Panel ID="Pn_maket" runat="server" Width="800Px" BackColor="#ECF0F9" Visible="false"
        BorderStyle="Double" Style="margin-left: 50px;">
        <table width="800Px">
            <tr>
                <td style="width: 30%">
                    <asp:Label ID="Lb_TT" runat="server" Text="Код операції"></asp:Label>
                    &nbsp;<span class="style1">*</span>
                </td>
                <td style="width: 30%" nowrap="nowrap">
                    <asp:DropDownList ID="dl_TT" runat="server" Width="300Px" TabIndex="1" OnSelectedIndexChanged="Select_dl_tt"
                        AutoPostBack="True">
                    </asp:DropDownList>
                </td>
                <td style="width: 100%">
                    <asp:TextBox ID="p_id" runat="server" Visible="false"></asp:TextBox>
                    <asp:TextBox ID="p_grp" runat="server" Visible="false"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 30%">
                    <asp:Label ID="Lb_NLSA" runat="server" Text="Рахунок А"></asp:Label>&nbsp;<span class="style1">*</span>
                </td>
                <td style="width: 30%">
                    <asp:TextBox ID="tb_NLSA" runat="server" Width="150Px" MaxLength="14" OnTextChanged="tb_NLSA_Changed"
                        AutoPostBack="true" TabIndex="2" Rows="3">
                    </asp:TextBox>
                    <asp:Button ID="btNLSARefer" runat="server" Text="..." ToolTip="Пошук рахунка А"
                        OnClientClick="selectAccounts('NLSA')" Height="22px" Width="22px" />
                </td>
                <td>
                    <asp:Label ID="LB_NMS" runat="server" Visible="true" Style="color: #009900"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 30%">
                    <asp:Label ID="Lb_MFO" runat="server" Text="МФО Б"></asp:Label>&nbsp;<span class="style1">*</span>
                </td>
                <td style="width: 30%">
                    <asp:TextBox ID="tb_MFO" runat="server" Width="100Px" MaxLength="6" OnTextChanged="tb_MFOB_Changed"
                        AutoPostBack="true" TabIndex="3" Rows="3"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="LB_MFOB" runat="server" Visible="true" Style="color: #009900"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 30%">
                    <asp:Label ID="Lb_NLSB" runat="server" Text="Рахунок Б"></asp:Label>&nbsp;<span class="style1">*</span>
                </td>
                <td style="width: 30%">
                    <asp:TextBox ID="tb_NLSB" runat="server" Width="150Px" MaxLength="14" OnTextChanged="tb_NLSB_Changed"
                        AutoPostBack="true" TabIndex="4" Rows="3">
                    </asp:TextBox>
                    <asp:Button ID="Button1" runat="server" Text="..." ToolTip="Пошук рахунка Б" OnClientClick="selectAccounts('NLSB')"
                        Height="22px" Width="22px" />
                </td>
                <td>
                    <asp:Label ID="LB_NMSB" runat="server" Visible="true" Style="color: #009900"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 30%">
                    <asp:Label ID="Lb_OKPOB" runat="server" Text="ОКПО Б"></asp:Label>&nbsp;<span class="style1">*</span>
                </td>
                <td style="width: 30%">
                    <asp:TextBox ID="tb_OKPOB" runat="server" Width="120Px" MaxLength="10" TabIndex="5"
                        Rows="3">
                    </asp:TextBox>
                </td>
                <td>
                    <asp:RegularExpressionValidator runat="server" ID="tb_OKPOB_valid" Display="Dynamic"
                        ControlToValidate="tb_OKPOB" ValidationExpression=">(^(\ |\-)(0|([0-9][0-9]{7,10}))?$)|(^(0{0,1}|([0-9][0-9]{7,10}))?$)"
                        SetFocusOnError="true" ToolTip="Не вірний формат ОКПО">Помилка!!! - Не вірний формат ОКПО</asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 30%">
                    <asp:Label ID="Lb_NAM_B" runat="server" Text="Назва отримувача"></asp:Label>&nbsp;<span
                        class="style1">*</span>
                </td>
                <td style="width: 30%">
                    <asp:TextBox ID="tb_NAM_B" runat="server" Width="300Px" MaxLength="38" TabIndex="6"
                        Rows="3">
                    </asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 30%">
                    <asp:Label ID="Lb_sump" runat="server" Text="Фіксована сума"></asp:Label>&nbsp;<span
                        class="style1"></span>
                </td>
                <td style="width: 30%">
                    <asp:TextBox ID="tb_sump" runat="server" Width="120Px" MaxLength="10" TabIndex="7"
                        Style="text-align: right">
                    </asp:TextBox>
                </td>
                <td>
                    <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" Display="Dynamic"
                        ControlToValidate="tb_sump" ValidationExpression=">(^(\ |\-)(0|([1-9][0-9]*))([\.\,][0-9]{0,2})?$)|(^(0{0,1}|([1-9][0-9]*))([\.\,][0-9]{0,2})?$)"
                        SetFocusOnError="true" BackColor="Yellow" ToolTip="Не вірний формат суми">Помилка</asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 30%">
                    <asp:Label ID="Lb_nazn" runat="server" Text="Призначення платежу"></asp:Label>&nbsp;<span
                        class="style1">*</span>
                </td>
                <td style="width: 30%">
                    <asp:TextBox ID="tb_NAZN" runat="server" Width="300Px" MaxLength="159" TabIndex="8"
                        Height="50px" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 30%">
                    <asp:Label ID="Lb_BRANCH" runat="server" Text="Бранч для фін.рез."></asp:Label>
                </td>
                <td style="width: 30%">
                    <asp:DropDownList ID="dl_BRANCH" runat="server" Width="300Px" TabIndex="9">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 30%">
                    <asp:Label ID="Lb_VOB" runat="server" Text="Вид квитанції"></asp:Label>&nbsp;<span
                        class="style1">*</span>
                </td>
                <td style="width: 30%">
                    <asp:DropDownList ID="dl_VOB" runat="server" Width="300Px" TabIndex="10">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 30%">
                    <asp:Label ID="lb_ord" runat="server" Text="Порядок сортування"></asp:Label>&nbsp;
                </td>
                <td style="width: 30%">
                    <asp:TextBox ID="tb_ord" runat="server" Width="150Px" onkeydown="return doKeyDown(window.event)"
                        onkeypress="return doKeyPress(window.event)" MaxLength="14" OnTextChanged="tb_NLSB_Changed"
                        AutoPostBack="true" TabIndex="11">
                    </asp:TextBox>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox ID="cb_operw" runat="server" Text="Допреквізити операції" OnCheckedChanged="Checked_cb_operw"
                        AutoPostBack="true" />
                </td>
            </tr>
        </table>
        <asp:Panel ID="pn_rules" runat="server" Width="400Px" Style="margin-left: 100px;">
            <br />
            <Bars:BarsGridViewEx AllowPaging="false" ID="GridRules" runat="server" CssClass="barsGridView"
                CaptionType="Simple" Visible="true" AutoGenerateColumns="False" ShowCaption="False"
                DataKeyNames="TAG, ID, opt">
                <Columns>
                    <asp:BoundField DataField="NAME" HeaderText="Додатковий&lt;BR&gt; реквізит" HtmlEncode="False">
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Значення&lt;BR&gt; допреквізиту">
                        <ItemStyle />
                        <ItemTemplate>
                            <asp:TextBox ID="tbName" runat="server" Width="200" Text='<%# Bind("VALUE") %>'> </asp:TextBox><asp:RequiredFieldValidator
                                SetFocusOnError="true" ID="valid_operw" runat="server" ControlToValidate="tbName"
                                Display="Dynamic" Enabled='<%# (Convert.ToString(Eval("opt"))=="M")?(true):(false) %>'>*</asp:RequiredFieldValidator></ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </Bars:BarsGridViewEx>
        </asp:Panel>
        <br />
        <table width="600Px">
            <tr>
                <td style="text-align: center">
                    <asp:Button ID="bt_Ok" runat="server" Text="Зберегти" OnClick="bt_Ok_Click" TabIndex="9" />
                </td>
                <td style="text-align: center">
                    <asp:Button ID="bt_Cancel" runat="server" Text="Відмінити" OnClick="bt_Cancel_Click"
                        CausesValidation="false" />
                </td>
            </tr>
        </table>
        <br />
        <br />
    </asp:Panel>
    <asp:HiddenField ID="ID_" runat="server" />
    <asp:HiddenField ID="GRP_" runat="server" />
    <asp:HiddenField ID="TT__" runat="server" />
    <asp:HiddenField ID="OURMFO__" runat="server" />
    <asp:HiddenField ID="hRefList" runat="server" />
    <%--<div class="webservice" id="webService" showprogress="true">
    </div>--%>
    </form>
</body>
</html>
