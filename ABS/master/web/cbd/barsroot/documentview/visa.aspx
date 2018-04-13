<%@ Page Language="C#" AutoEventWireup="true" CodeFile="visa.aspx.cs" Inherits="Visa" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Виза</title>
	<link href="CSS/AppCSS.css" type="text/css" rel="stylesheet" />
    <script src="/Common/Script/Sign.js?v.1.1" language="javascript" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        /*
         * сокращенный вызов document.getElementById(elem)
         * elem - имя элемента документа
         */
        function gE(elem) { return document.getElementById(elem); }        
        
        // Проверка внутреней подписи 
        function CheckIntSign(lev) 
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
                // берем буффера для проверки из грида
                var grd = gE('grdData');
                var rowsCount = grd.rows.length;
                var curRowIdx = lev + 1;
	            var curRow = grd.rows[curRowIdx];
        		    
	            /*
	             0 колонка выделения
	             1 MARK
	             2 CHECKGROUP
	             3 USERNAME
	             4 DAT
	             5 SIGN_FLAG
	             6 BUFINT
	             7 BUFEXT
                */		    
        		    
                var params1 = new Array();
                // проверякм только внеш подпись
                var fSign = curRow.cells[5].innerText;        
                if(fSign != '1' && fSign != '3')
                {
                    alert("<asp:Localize runat=server text='<%$ Resources: documentview.GlobalResource, labPodpisOtsutstvuet %>' />");
                    return;
                }
                else fSign = '1';
                
                params1['SIGN_FLAG'] = fSign;
        	
                // инициализация системных параметров
                signDoc.initSystemParams(params1);
        			
                var params2 = new Array();
                params2['BUFFER_INT'] = curRow.cells[6].innerText;
        	
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

        // Проверка внешней подписи
        function CheckExtSign() 
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
                // если подпись СЭП не включена, то выходим
                if(gE('EXTSIGNBUFF').value == '0')
                {
                    alert("<asp:Localize runat=server text='<%$ Resources: documentview.GlobalResource, labPodpisOtsutstvuet %>' />");
                    return;
                }

                var params1 = new Array();
                // проверякм только внеш подпись
                params1['SIGN_FLAG'] = '2';
        	
                // инициализация системных параметров
                signDoc.initSystemParams(params1);
        			
                var params2 = new Array();
                
                params2['BUFFER'] = gE('EXTSIGNBUFF').value;
        	
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
<body bottommargin="0" rightmargin="0">
    <form id="form1" runat="server">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr style="padding-bottom: 20px">
                <td id="Td1" runat="server" meta:resourcekey="lableProverkaPodpisiSEP">Проверка подписи СЭП : </td>
                <td style="width: 100%"><img id="Img1" meta:resourcekey="lableProverkaVnechneiPodpisi" alt="Ext Sign Check" title="Проверка внешней подписи" height="20" width="20" src="/Common/Images/CheckSign.gif" onclick="CheckExtSign()" style="cursor: hand" runat="server" /></td>
            </tr>
            <tr>
                <td colspan="2">                    
                    <asp:GridView ID="grdData" runat="server" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="INTSIGN" HeaderText="Внутр." HtmlEncode="False" >
                                <ItemStyle Width="50px" />
                                <HeaderStyle Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="MARK" HeaderText="Отметка" meta:resourcekey="BoundFieldResource1" />
                            <asp:BoundField DataField="CHECKGROUP" HeaderText="Група" meta:resourcekey="BoundFieldResource2" />
                            <asp:BoundField DataField="USERNAME" HeaderText="Пользователь" meta:resourcekey="BoundFieldResource3" />
                            <asp:BoundField DataField="DAT" DataFormatString="{0:dd.MM.yyyy HH:mm:ss}" HeaderText="Дата"
                                HtmlEncode="False" meta:resourcekey="BoundFieldResource4" />
                            <asp:BoundField DataField="SIGN_FLAG">
                                <ItemStyle CssClass="GridViewHiddenCol" />
                                <HeaderStyle CssClass="GridViewHiddenCol" />
                            </asp:BoundField>
                            <asp:BoundField DataField="BUFINT">
                                <ItemStyle CssClass="GridViewHiddenCol" />
                                <HeaderStyle CssClass="GridViewHiddenCol" />
                            </asp:BoundField>
                        </Columns>
                        <RowStyle HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="WhiteSmoke" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
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
</body></html>
