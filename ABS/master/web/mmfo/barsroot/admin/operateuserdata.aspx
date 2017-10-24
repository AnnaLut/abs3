<%@ Page Language="C#" AutoEventWireup="true" CodeFile="operateuserdata.aspx.cs" Inherits="admin_operateuserdata" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Администрирование пользователей</title>
    <link href="/Common/CSS/AppCSS.css" rel="Stylesheet" type="text/css" />
    <style type="text/css">
        .tabContainer table
        {
            border: solid 1px Gray;                        
        }
        .tdBlockHeader
        {
            padding-bottom: 5px; 
            text-align: center; 
            background-color: #f0f0f0;
        }    
    </style>
    <script language="javascript" type="text/javascript">
        function trim(a)
        {
	        if(a == null) return null;
	        return a.toString().replace(/^\s*|\s*$/g,'');
        }
        function gE(sId)
        {
            return document.getElementById(sId);
        }
        function isEmpty(edit)
        {
	        return (edit == null || edit.value == null || trim(edit.value).length == 0)
        }
        function isEmptyCheck(edit, msg_text)
        {
	        if(isEmpty(edit))
	        {
		        alert(msg_text);	
		        edit.focus();
		        return false;
	        }
	        else return true;
        }        
        function Validate()
        {
            if(!isEmptyCheck(gE('edFIO'), "<asp:Localize runat=server text='<%$ Resources: admin.Global, labZapolniteFIOPolzovatelia %>' />")) return false;
            else if(!isEmptyCheck(gE('edLogin'), "<asp:Localize runat=server text='<%$ Resources: admin.Global, labZapolniteLoginPolzovatelia %>' />")) return false;
            else if( trim(gE('edPassword').value) != trim(gE('edPasswordConfirm').value) )
            {
                gE('edPassword').value = '';                
                gE('edPasswordConfirm').value = '';
                
                alert("<asp:Localize runat=server text='<%$ Resources: admin.Global, labOwibkaPodtvergdeniaParolia %>' />");
                gE('edPassword').focus();
                
                return false;
            }
            else if( trim(gE('edPassword').value).length < 6 )
            {
                alert("<asp:Localize runat=server text='<%$ Resources: admin.Global, labDlinaParoliaNeMenee6Sivolov %>' />");
                gE('edPassword').focus();
                
                return false;
            }
            else if(gE('ddlUserType').value == '-1')
            {
                alert("<asp:Localize runat=server text='<%$ Resources: admin.Global, labZapolniteTipPolzovatelia %>' />");
                gE('ddlUserType').focus();
                
                return false;
            }
            else if(gE('ddlDep').value == '-1')
            {
                alert("<asp:Localize runat=server text='<%$ Resources: admin.Global, labZapolnitePodrazdelenie %>' />");
                gE('ddlDep').focus();
                
                return false;
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="title" colspan="2" runat="server" meta:resourcekey="tdTitle">Резвизиты пользователя</td>
                </tr>
                <tr>
                    <td colspan="2">
                        <table border="0" cellpadding="0" cellspacing="10" class="tabContainer">
                            <tr>
                                <td align="center">
                                    <table border="0" cellpadding="2" cellspacing="0" style="text-align: left; width: 475px">
                                        <tr>
                                            <td colspan="2" class="tdBlockHeader" runat="server" meta:resourcekey="tdTitleBlock1">Реквизиты пользователя</td>
                                        </tr>
                                        <tr>
                                            <td style="width: 150px" runat="server" meta:resourcekey="tdFIO">ФИО</td>
                                            <td><asp:TextBox ID="edFIO" runat="server" Width="300px" TabIndex="1"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td runat="server" meta:resourcekey="tdLogin">Логин</td>
                                            <td><asp:TextBox ID="edLogin" runat="server" TabIndex="2"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td runat="server" meta:resourcekey="tdTabN">Табельный номер</td>
                                            <td><asp:TextBox ID="edTabN" runat="server" TabIndex="3" MaxLength="10"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td runat="server" meta:resourcekey="tdPassword">Пароль</td>
                                            <td><asp:TextBox ID="edPassword" runat="server" TextMode="Password" TabIndex="4"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td style="padding-bottom: 10px" runat="server" meta:resourcekey="tdPasswordConfirm">Подтверждение пароля</td>
                                            <td style="padding-bottom: 10px"><asp:TextBox ID="edPasswordConfirm" runat="server" TextMode="Password" TabIndex="5"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <table border="0" cellpadding="2" cellspacing="0" style="text-align: left; width: 475px">
                                        <tr>
                                            <td class="tdBlockHeader" runat="server" meta:resourcekey="tdTitleBlock2">Другие характеристики</td>
                                        </tr>
                                        <tr>
                                            <td runat="server" meta:resourcekey="tdUserType">Тип пользователя</td>
                                        </tr>
                                        <tr>
                                            <td><asp:DropDownList ID="ddlUserType" runat="server" Width="350px" TabIndex="6"></asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td runat="server" meta:resourcekey="tdDep">Подразделение</td>
                                        </tr>
                                        <tr>
                                            <td style="padding-bottom: 10px"><asp:DropDownList ID="ddlDep" runat="server" Width="350px" TabIndex="7"></asp:DropDownList></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <table border="0" cellpadding="2" cellspacing="0" style="text-align: left; width: 475px">
                                        <tr>
                                            <td colspan="3" class="tdBlockHeader" runat="server" meta:resourcekey="tdTitleBlock3">Доступ к АРМам</td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" runat="server" meta:resourcekey="tdGrantedARMs">Выданные АРМы</td>
                                        </tr>
                                        <tr>
                                            <td colspan="3"><asp:ListBox ID="lbxGrantedARMs" runat="server" Width="465px" DataValueField="value" DataTextField="text" TabIndex="8"></asp:ListBox></td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" runat="server" meta:resourcekey="tdAvailableARMs">Доступные АРМы</td>
                                        </tr>
                                        <tr>
                                            <td style="padding-bottom: 10px"><asp:DropDownList ID="ddlAvailableARMs" runat="server" Width="400px" DataValueField="value" DataTextField="text" TabIndex="9"></asp:DropDownList></td>
                                            <td style="padding-bottom: 10px"><asp:ImageButton id="imgARMAdd" runat="server" ToolTip="Добавить АРМ" AlternateText="Добавить" ImageUrl="/Common/Images/default/16/new.png" Width="16px" OnClick="imgARMAdd_Click" TabIndex="10" meta:resourcekey="imgARMAddResource1"></asp:ImageButton></td>
                                            <td style="padding-bottom: 10px"><asp:ImageButton id="imgARMDelete" runat="server" ToolTip="Удалить АРМ" AlternateText="Удалить" ImageUrl="/Common/Images/default/16/cancel.png" Width="16px" OnClick="imgARMDelete_Click" TabIndex="11" meta:resourcekey="imgARMDeleteResource1"></asp:ImageButton></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <table border="0" cellpadding="2" cellspacing="0" style="text-align: left; width: 475px">
                                        <tr>
                                            <td colspan="3" class="tdBlockHeader" runat="server" meta:resourcekey="tdTitleBlock4">Список файлов</td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" runat="server" meta:resourcekey="tdGrantedFiles">Выданные файлы</td>
                                        </tr>
                                        <tr>
                                            <td colspan="3"><asp:ListBox ID="lbxGrantedFiles" runat="server" Width="400px" DataValueField="value" DataTextField="text" TabIndex="12"></asp:ListBox></td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" runat="server" meta:resourcekey="tdAvailableFiles">Доступные файлы</td>
                                        </tr>
                                        <tr>
                                            <td style="padding-bottom: 10px"><asp:DropDownList ID="ddlAvailableFiles" runat="server" Width="350px" DataValueField="value" DataTextField="text" TabIndex="13"></asp:DropDownList></td>
                                            <td style="padding-bottom: 10px"><asp:ImageButton id="imgFileAdd" runat="server" ToolTip="Добавить файл" AlternateText="Добавить" ImageUrl="/Common/Images/default/16/new.png" Width="16px" OnClick="imgFileAdd_Click" TabIndex="14" meta:resourcekey="imgFileAddResource1"></asp:ImageButton></td>
                                            <td style="padding-bottom: 10px"><asp:ImageButton id="imgFileDelete" runat="server" ToolTip="Удалить файл" AlternateText="Удалить" ImageUrl="/Common/Images/default/16/cancel.png" Width="16px" OnClick="imgFileDelete_Click" TabIndex="15" meta:resourcekey="imgFileDeleteResource1"></asp:ImageButton></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <table border="0" cellpadding="2" cellspacing="0" style="text-align: left; width: 475px">
                                        <tr>
                                            <td colspan="3" class="tdBlockHeader" runat="server" meta:resourcekey="tdTitleBlock5">Список документов</td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" runat="server" meta:resourcekey="tdGrantedDocs">Выданные документы</td>
                                        </tr>
                                        <tr>
                                            <td colspan="3"><asp:ListBox ID="lbxGrantedDocs" runat="server" Width="465px" DataValueField="value" DataTextField="text" TabIndex="16"></asp:ListBox></td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" runat="server" meta:resourcekey="tdAvailableDocs">Доступные документы</td>
                                        </tr>
                                        <tr>
                                            <td style="padding-bottom: 10px"><asp:DropDownList ID="ddlAvailableDocs" runat="server" Width="400px" DataValueField="value" DataTextField="text" TabIndex="17"></asp:DropDownList></td>
                                            <td style="padding-bottom: 10px"><asp:ImageButton id="imgDocAdd" runat="server" ToolTip="Добавить документ" AlternateText="Добавить" ImageUrl="/Common/Images/default/16/new.png" Width="16px" OnClick="imgDocAdd_Click" TabIndex="18" meta:resourcekey="imgDocAddResource1"></asp:ImageButton></td>
                                            <td style="padding-bottom: 10px"><asp:ImageButton id="imgDocDelete" runat="server" ToolTip="Удалить документ" AlternateText="Удалить" ImageUrl="/Common/Images/default/16/cancel.png" Width="16px" OnClick="imgDocDelete_Click" TabIndex="19" meta:resourcekey="imgDocDeleteResource1"></asp:ImageButton></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="padding-top: 10px">
                    <td align="right">
                        <asp:Button ID="btSave" runat="server" Text="Сохранить" OnClick="btSave_Click" OnClientClick="return Validate()" TabIndex="20" meta:resourcekey="btSaveResource1" />
                    </td>
                    <td align="left">
                        <asp:Button ID="btCancel" runat="server" Text="Отмена" TabIndex="21" OnClick="btCancel_Click" meta:resourcekey="btCancelResource1" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
