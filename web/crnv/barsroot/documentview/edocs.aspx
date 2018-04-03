<%@ Page Language="C#" AutoEventWireup="true" CodeFile="edocs.aspx.cs" Inherits="EDocs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Экспортируемые проводки</title>
	<link href="CSS/AppCSS.css" type="text/css" rel="stylesheet" />
    <script src="/Common/Script/Sign.js" language="javascript" type="text/javascript"></script>
	<script language=javascript type="text/javascript">
        /*
         * сокращенный вызов document.getElementById(elem)
         * elem - имя элемента документа
         */
        function gE(elem) { return document.getElementById(elem); }        
        
        // достает из грида нужный буффер
        function fnGetBuffer(nDocId)
        {
            var grd = gE('grdData');
            var rowsCount = grd.rows.length;
            var curRowIdx = 1;
            var sBuff = null;
            
            while (curRowIdx < rowsCount && sBuff == null)
            {
                var curRow = grd.rows[curRowIdx];
                if(curRow.cells[1].innerText == nDocId)
                    sBuff = curRow.cells[23].innerText
                else
                    curRowIdx += 1;                    
            }
            
            return sBuff;
        }

        // Проверка внешней подписи
        function CheckSign(nDocId) 
        {
            var params = new Array();
            params['INTSIGN'] = gE('INTSIGN').value;
            params['VISASIGN'] = gE('VISASIGN').value;
            params['SEPNUM'] = gE('SEPNUM').value;
            params['SIGNTYPE'] = gE('SIGNTYPE').value;
            params['SIGNLNG'] = gE('SIGNLNG').value;
            params['DOCKEY'] = gE('DOCKEY').value;
            params['REGNCODE'] = gE('REGNCODE').value;
            params['BDATE'] = gE('BDATE').value;
        	
            // конструктор класса подписи
            var signDoc = new obj_Sign();
        	
            if( signDoc.initObject(params) )
            {
	            var buff = fnGetBuffer(nDocId);

                // если подпись СЭП не включена, то выходим
                if(buff == null)
                {
                    alert("<asp:Localize runat=server text='<%$ Resources: documentview.GlobalResource, labPodpisOtsutstvuet %>' />");
                    return;
                }

                var params1 = new Array();
                // проверякм только внеш подпись
                params1['FLI'] = '1';
                params1['SIGN_FLAG'] = '2';
        	
                // инициализация системных параметров
                signDoc.initSystemParams(params1);
        			
                var params2 = new Array();
                
                params2['BUFFER'] = buff;
        	
                // инициализация параметров документа
                signDoc.initDocParams(params2);
        	    
                // -- проверка ЭЦП --
                var verify_res = signDoc.VerifySignature();
                
                if(verify_res)
                    // если все ОК, то говорим
                    alert("<asp:Localize runat=server text='<%$ Resources: documentview.GlobalResource, labPodpisVerna %>' />");
                else
                    // если ошибки, то выводим их в диалог
                    signDoc.showErrorsDialog();
            }        
        }
	</script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:GridView ID="grdData" runat="server" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="IMG" HeaderText="Поспись" HtmlEncode="False" >
                    <ItemStyle Width="50px" />
                    <HeaderStyle Width="50px" />
                </asp:BoundField>
                <asp:BoundField DataField="DOCID" HeaderText="Ид.Док" />
                <asp:BoundField DataField="TT" HeaderText="Опер." />
                <asp:BoundField DataField="SIGN_TIME" HeaderText="Время подписи" DataFormatString="{0:dd.MM.yyyy HH:mm:ss}" HtmlEncode="False" />
                <asp:BoundField DataField="MFOA" HeaderText="Банк А" />
                <asp:BoundField DataField="NLSA" HeaderText="Счет А" />
                <asp:BoundField DataField="MFOB" HeaderText="Банк Б" />
                <asp:BoundField DataField="NLSB" HeaderText="Счет Б" />
                <asp:BoundField DataField="DK" HeaderText="Д/К" />
                <asp:BoundField DataField="Sdiv" HeaderText="Сумма" DataFormatString="{0:### ### ### ##0.00##}" HtmlEncode="False" />
                <asp:BoundField DataField="VOB" HeaderText="Вид док." />
                <asp:BoundField DataField="ND" HeaderText="№ Платежа" />
                <asp:BoundField DataField="KV" HeaderText="Вал." />
                <asp:BoundField DataField="DATD" HeaderText="Дата док." DataFormatString="{0:dd.MM.yyyy HH:mm:ss}" HtmlEncode="False" />
                <asp:BoundField DataField="DATP" HeaderText="Дата поступления" DataFormatString="{0:dd.MM.yyyy HH:mm:ss}" HtmlEncode="False" />
                <asp:BoundField DataField="NAM_A" HeaderText="Наименование А" />
                <asp:BoundField DataField="NAM_B" HeaderText="Наименование Б" />
                <asp:BoundField DataField="NAZN" HeaderText="Назначение" />
                <asp:BoundField DataField="D_REC" HeaderText="Доп. рекв." />
                <asp:BoundField DataField="ID_A" HeaderText="Идент А" />
                <asp:BoundField DataField="ID_B" HeaderText="Идент Б" />
                <asp:BoundField DataField="REF_A" HeaderText="Ид. в САБ" />
                <asp:BoundField DataField="ID_O" HeaderText="Ид. опер-та" />
                <asp:BoundField DataField="BUFF" ConvertEmptyStringToNull="False" HtmlEncode="False">
                    <ItemStyle CssClass="GridViewHiddenCol" />
                    <HeaderStyle CssClass="GridViewHiddenCol" />
                </asp:BoundField>
            </Columns>
            <RowStyle HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="WhiteSmoke" />
        </asp:GridView>
        <!-- 
            Скрытые поля
        -->
        <table style="visibility: hidden; width: 1px">
            <tr>
                <td><input id="SEPNUM"      value=" " type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="SIGNTYPE"    value=" " type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="SIGNLNG"     value=" " type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="DOCKEY"      value=" " type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="BDATE"       value=" " type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="INTSIGN"     value=" " type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="REGNCODE"    value=" " type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="VISASIGN"    value=" " type="hidden" runat="server" style="width: 1px" /></td>
                <td><input id="EXTSIGNBUFF" value=" " type="hidden" runat="server" style="width: 1px" /></td>
            </tr>
        </table>
    </form>
</body>
</html>
