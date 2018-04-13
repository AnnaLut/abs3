<%@ Page Language="C#" AutoEventWireup="true" CodeFile="depository.aspx.cs" Inherits="docinput_depository" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Операції зі сховищем</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>

    <script type="text/javascript" src="/Common/Script/BarsIe.js"></script>

    <script type="text/javascript">
        window.onload = function(){
            webService.useService("DocService.asmx?wsdl","Doc");
        }
        function ShowPersonList()
        {
            var tt = document.all.ddTts.options[document.all.ddTts.selectedIndex].value;
            var need = ",VS5,VS6,VS9,VSM,VSN,";
            if(need.indexOf(tt)>0)
            {
                var result = window.showModalDialog("dialog.aspx?type=metatab&tail=''&role=wr_metatab&tabname=person_989","",
						        "dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
                if(result){						        
                    document.all.hRnk.value = result[0];
                    document.all.tbPerson.value = result[1];
                }
            }
        }
        function ShowPodotch(type)						        
        {
            var result = window.showModalDialog("dialog.aspx?type=metatab&tail=''&role=wr_metatab&tabname=podotch","",
						        "dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
            if(result){						        
                if(type == 1)
                {
                    document.all.tbPersonGive.value = result[1];
                }
                else if(type == 2)
                {
                    document.all.tbPersonReceive.value = result[1];
                }
            }
        }
        function PrintDocs()
        {
           var refs = document.getElementById("hRefList").value.split(';');
           for(var i=0; i< refs.length-1; i++)
           {
               webService.Doc.callService(onPrint,"GetFileForPrint",refs[i]);
           }
        }
        function onPrint(result)
        {
          if(!getError(result)) return;
          var filename = result.value;
          barsie$print(filename);
        }
        //Обработка ошибок от веб-сервиса
        function getError(result,modal)
        {
          if(result.error){
           if(window.dialogArguments || parent.frames.length == 0 || modal){
               window.showModalDialog("dialog.aspx?type=err","","dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
           } 
           else
             location.replace("dialog.aspx?type=err");
           return false;
         }
         return true;
        }
    </script>

</head>
<body bgcolor="#f0f0f0">
    <form id="formDepository" runat="server">
    <div class="pageTitle">
        <asp:Label ID="lbTitle" runat="server" Text="Операції зі сховищем"></asp:Label>
    </div>
    <asp:Panel ID="pnlRepResults" runat="server" GroupingText="Параметри" Style="margin-left: 10px;">
        <table>
            <tr>
                <td nowrap="nowrap">
                    <asp:Label ID="lbTts" runat="server" Text="Тип операції сховища:"></asp:Label>
                </td>
                <td nowrap="nowrap">
                    <asp:DropDownList ID="ddTts" runat="server" Width="400px" AutoPostBack="True" DataTextField="NAME"
                        DataValueField="TT" OnSelectedIndexChanged="ddTts_SelectedIndexChanged">
                    </asp:DropDownList>
                    &nbsp;<asp:Button ID="btRefresh" runat="server" OnClick="btRefresh_Click" Text="Перечитати"
                        Width="100px" />
                    &nbsp;<asp:Button ID="btPay" runat="server" OnClick="btPay_Click" Text="Виконати проводки" />
                </td>
                <td width="100%">
                    <img runat="server" id="imgPrintAll" onclick="PrintDocs()" alt="Роздрукувати оплачені ордера"
                        src="/common/images/print.gif" visible="false" />
                </td>
            </tr>
            <tr>
                <td nowrap="nowrap">
                    <asp:Label ID="lbFilter" runat="server" Text="Фільтр цінностей:"></asp:Label>
                </td>
                <td nowrap="nowrap">
                    <asp:DropDownList ID="ddNbs" runat="server" Width="200px">
                        <asp:ListItem Value="981">Iнші цінності і документи</asp:ListItem>
                        <asp:ListItem Value="9820">Бланки цінних паперів</asp:ListItem>
                        <asp:ListItem Value="9821">Бланки суворого обліку</asp:ListItem>
                        <asp:ListItem Value="">Всі</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Label ID="lbPerson" runat="server" Text="Підзвітна особа:"></asp:Label>
                    <asp:TextBox ID="tbPerson" runat="server" Width="380px" BackColor="Silver" ForeColor="#000066"></asp:TextBox>
                </td>
                <td width="100%" nowrap="nowrap">
                </td>
            </tr>
            <tr id="trBranch" runat="server" visible="false">
                <td nowrap="nowrap">
                    <asp:Label ID="lbBranch" runat="server" Text="Відділення-кореспондент:"></asp:Label>
                </td>
                <td nowrap="nowrap" colspan="2">
                    <asp:TextBox ID="tbBranch" runat="server" Width="160px" ReadOnly="true" BackColor="Silver"
                        ForeColor="#000066"></asp:TextBox>
                    <asp:DropDownList ID="ddBranches" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddBranches_SelectedIndexChanged" />
                </td>
            </tr>
            <tr id="trPerson1" runat="server" visible="false">
                <td nowrap="nowrap">
                    <asp:Label ID="lbPersonGive" runat="server" Text="ФО, що здає цінності:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbPersonGive" runat="server" ForeColor="#000066" Width="400px"></asp:TextBox>
                    <asp:Image ID="imgChoosePerson1" runat="server" ImageUrl="/Common/Images/CUSTCLSD.gif"
                        ToolTip="Вибрати особу, яка здає цінності" />
                </td>
                <td>
                </td>
            </tr>
            <tr id="trPerson2" runat="server" visible="false">
                <td nowrap="nowrap">
                    <asp:Label ID="lbPersonReceive" runat="server" Text="ФО, що приймає цінності:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbPersonReceive" runat="server" ForeColor="#000066" Width="400px"></asp:TextBox>
                    <asp:Image ID="imgChoosePerson2" runat="server" ImageUrl="/Common/Images/CUSTCLSD.gif"
                        ToolTip="Вибрати особу, яка приймає цінності" />
                </td>
                <td>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnResult" runat="server" Visible="false" GroupingText="Результат"
        Style="margin-left: 10px;">
        <asp:Label ID="lbInfo" runat="server" Text=""></asp:Label>
    </asp:Panel>
    <asp:Panel ID="pnDataDepository" runat="server" Visible="false">
        <Bars:BarsGridViewEx AllowPaging="false" ID="DataDepository" runat="server" CssClass="barsGridView"
            CaptionType="Simple" Visible="true" AutoGenerateColumns="False" OnRowDataBound="DataDepository_RowDataBound">
            <Columns>
                <asp:BoundField DataField="OB22" HeaderText="Код&lt;BR&gt; цінності" HtmlEncode="False">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="NAME" HeaderText="Назва&lt;BR&gt; цінності" HtmlEncode="False">
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Кількість&lt;BR&gt; шт.">
                    <ItemTemplate>
                        <asp:TextBox onkeydown="return doKeyDown(window.event)" onkeypress="return doKeyPress(window.event)"
                            Width="60" ID="tbCount" runat="server" Text="0" Style="text-align: right" /></ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="NLSD" HeaderText="Рахунок ДЕБЕТ" HtmlEncode="False">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="OSTD" HeaderText="План.зал. ДЕБЕТ" HtmlEncode="False">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="NLSK" HeaderText="Рахунок КРЕДИТ" HtmlEncode="False">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="OSTK" HeaderText="План.зал. КРЕДИТ" HtmlEncode="False">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Призначення&lt;BR&gt; платежу">
                    <ItemStyle />
                    <ItemTemplate>
                        <asp:TextBox ID="tbNazn" runat="server" Width="400" Text='<%# Bind("NAZN") %>'></asp:TextBox></ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Реф.">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:TemplateField>
            </Columns>
        </Bars:BarsGridViewEx>
    </asp:Panel>
    <asp:HiddenField ID="hRnk" runat="server" />
    <asp:HiddenField ID="hRefList" runat="server" />

    <script type="text/javascript">
        document.all.tbPerson.readOnly = true;
    </script>

    <div class="webservice" id="webService" showprogress="true">
    </div>
    </form>
</body>
</html>
