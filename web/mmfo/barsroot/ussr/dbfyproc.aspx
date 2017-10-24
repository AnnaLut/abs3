<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dbfyproc.aspx.cs" Inherits="ussr_dbfyproc" EnableViewState="true" %>
<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars"  %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Обробка файлів "Y"</title>
    <link href="/common/css/barsgridview.css" rel="stylesheet" type="text/css" />
</head>
<body style="font-size:8pt" onload="loadHandler">
    <form id="form1" runat="server">
    <div>
        <div class="tableTitle" runat="server" id="lblTitle">Обробка файлiв "Y"</div>
        
        <table>
            <tr>
                <td colspan="3">
                    <table width="100%">
                        <tr>
                            <td>
                            <asp:Panel ID="pnlPodr" runat="server" GroupingText="Пiдроздiл" >
                                <table width="100%">
                                    <tr>
                                        <td width="10%"> 
                                            <asp:RadioButton ID="rbRu" Text="РУ" runat="server" Checked="False" GroupName="podr"
                                                AutoPostBack="true" OnCheckedChanged="rbRu_Checked"/>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddRU" runat="server" DataTextField="NAME"  DataSourceID="dsRu" 
                                            DataValueField="RU" Width="100%" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddRU_SelectedIndexChanged"></asp:DropDownList>
                                        </td>
                                     
                                     <tr>
                                        <td width="10%">
                                            <asp:RadioButton ID="rbBranch" Text="ТВБВ" runat="server" GroupName="podr" AutoPostBack="True"  />
                                        </td>                
                                        <td> <!--
                                            <asp:DropDownList ID="ddBranch" runat="server" DataTextField="name" 
                                            DataValueField="branch" Width="100%" AutoPostBack="True" 
                                            OnSelectedIndexChanged="ddBranch_SelectedIndexChanged" ></asp:DropDownList>
                                            -->
                                            <div nowrap="nowrap">
                                                <asp:TextBox id="edtBranch" style="width:95%"  runat="server" Enabled="false" />
                                                <asp:LinkButton Font-Bold="true" Font-Size="15pt" id="branchSelect" runat="server" Text = "..." 
                                                   OnClientClick=" var res = window.showModalDialog('dialog.aspx?type=metatab&tabname=BRANCH&tail=\'\'&role=WR_CUSTREG', 'dialogHeight:600px; dialogWidth:800px'); if (null!=res) edtBranch.value=res[0]; return false;"
                                                 />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="right">
                                            <asp:CheckBox ID="chBranchAll" Text="В т.ч. підлеглі" runat="server" />
                                        </td>
                                    </tr>             
                                </table>
                            </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                           <td nowrap="nowrap">
                                <asp:Panel ID="pnlLoaded" runat="server" GroupingText="Завантажено починаючи з:" >
                                    <cc1:DateEdit runat="server"  ID="deLoaded" 
                                        Date="" MaxDate="2099-12-31"  
                                        MinDate="" Text="01/01/2008 00:00:00" 
                                        >
                                    </cc1:DateEdit>    
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>    
                </td>                        
            </tr>
            <tr>
                <td nowrap="nowrap">
                    <asp:Panel ID="pnlGarbage" runat="server" GroupingText="Смiття" >
                        <asp:RadioButton ID="rbGarAll" Text="Всi" runat="server" GroupName="garbage" Checked="True"  />
                        <asp:RadioButton ID="rbGarClean" Text="Чистi" runat="server" GroupName="garbage"  />
                        <asp:RadioButton ID="rbGarGarbage" Text="Сміття" runat="server" GroupName="garbage"  />
                    </asp:Panel>
                </td>
                <td nowrap="nowrap">
                    <asp:Panel ID="pnlAnalis" runat="server" GroupingText="Аналiз" >
                        <asp:RadioButton ID="rbAnalisAll" Text="Всi" runat="server" GroupName="analis" Checked="True"  />
                        <asp:RadioButton ID="rbAnalisOk" Text="Проаналiзованi" runat="server" GroupName="analis"  />
                        <asp:RadioButton ID="rbAnalisNone" Text="НЕпроаналiзованi" runat="server" GroupName="analis"  />
                    </asp:Panel>
                </td>
                <td nowrap="nowrap">
                    <asp:Panel ID="pnlKorr" runat="server" GroupingText="Коригуючий файл" >
                        <asp:RadioButton ID="rbKorrAll" Text="Всi" runat="server" GroupName="korr" Checked="True"  />
                        <asp:RadioButton ID="rbKorrOk" Text="Зформовано" runat="server" GroupName="korr"  />
                        <asp:RadioButton ID="rbKorrNone" Text="НЕзформовано" runat="server" GroupName="korr"  />
                    </asp:Panel>                
                </td>                
            </tr>
            <tr>
                <td nowrap="nowrap">
                    <asp:Panel ID="pnlCorrected" runat="server" GroupingText="Вирівняні залишки" >
                        <asp:RadioButton ID="rbCorrectedAll" Text="Всi" runat="server" GroupName="corrected" Checked="True"  />
                        <asp:RadioButton ID="rbCorrectedOk" Text="Вирівняні залишки" runat="server" GroupName="corrected"  />
                        <asp:RadioButton ID="rbCorrectedNone" Text="НЕвирівняні залишки" runat="server" GroupName="corrected"  />
                    </asp:Panel>   
                </td>                
                <td nowrap="nowrap">
                   <asp:Panel ID="pnlAck" runat="server" GroupingText="Квитанцiї" >
                        <asp:RadioButton ID="rbAckAll" Text="Всі" runat="server" GroupName="ack" Checked="True"  />
                        <asp:RadioButton ID="rbAckOk" Text="Зформовано" runat="server" GroupName="ack"  />
                        <asp:RadioButton ID="rbAckNone" Text="НЕзформовано" runat="server" GroupName="ack"  />
                    </asp:Panel>  
                </td>                
                <td nowrap="nowrap">
                    <asp:Panel ID="pnlPidtv" runat="server" GroupingText="Підтвердження" >
                        <asp:RadioButton ID="rbPidtvAll" Text="Всi" runat="server" GroupName="pidtv" Checked="True"  />
                        <asp:RadioButton ID="rbPidtvOk" Text="Є" runat="server" GroupName="pidtv"  />
                        <asp:RadioButton ID="rbPidtvNone" Text="Немає" runat="server" GroupName="pidtv"  />
                    </asp:Panel>                 
                </td>                     
            </tr>
            <tr>
                <td nowrap="nowrap">
                    <asp:Panel ID="pnlRozr" runat="server" GroupingText="Розрахунки" >
                        <asp:RadioButton ID="rbRozrAll" Text="Всi" runat="server" GroupName="rozr" Checked="True"  />
                        <asp:RadioButton ID="rbRozrOk" Text="Проведені" runat="server" GroupName="rozr"  />
                        <asp:RadioButton ID="rbRozrNone" Text="НЕпроведені" runat="server" GroupName="rozr"  />
                    </asp:Panel>                   
                </td>                 
                <td nowrap="nowrap" >
                    <asp:Panel ID="pnlPostAnal" runat="server" GroupingText="Повторний аналіз" >
                        <asp:RadioButton ID="rbPostAlnalAll" Text="Всi" runat="server" GroupName="panal" Checked="True"  />
                        <asp:RadioButton ID="rbPostAnalOk" Text="Проведений" runat="server" GroupName="panal"  />
                        <asp:RadioButton ID="rbPostAnalNone" Text="НЕпроведений" runat="server" GroupName="panal"  />
                    </asp:Panel>
                </td>                 
                <td nowrap="nowrap">
                    <asp:Panel ID="pnlFile" runat="server" GroupingText="Файл" >
                        <asp:RadioButton ID="rbFileAll" Text="Всi" runat="server" GroupName="file" Checked="True"  />
                        <asp:RadioButton ID="rbFileOne" Text="Вказаний" runat="server" GroupName="file"  />
                        <asp:TextBox runat="server" ID="edtFileName"></asp:TextBox>
                    </asp:Panel>
                </td>               

            </tr>
        </table>
        
        <Bars:BarsSqlDataSource 
                ID="dsBranch" ProviderName="barsroot.core" PreliminaryStatement="begin bars_role_auth.set_role('WR_USSR_TECH'); end;"
                runat="server" 
                SelectCommand="select * from branch order by branch">
        </Bars:BarsSqlDataSource>
        
            <asp:SqlDataSource 
                ID="dsRU" runat="server"  ProviderName="barsroot.core" 
                SelectCommand="select * from banks_ru order by name" OnSelecting="dsRU_Selecting" >
            </asp:SqlDataSource>
            <br />
        <table style="margin-top: 5px">
            <tr>
                <td style="border-right: dotted 1px gray; ">
                    <asp:Button ID="btnReload" runat="server" Text="Перечитати" OnClick="btnReload_Click" />
                </td>   
                <td>
                    <asp:Button ID="btnSavePidtv" runat="server" Text="Підтвердити виділені" OnClick="btnSavePidtv_Click" OnClientClick="if (!confirm('Підтвердити виділені файли?')) return false;"/>
                </td>   
                <td>
                    <asp:Button ID="btnSetGarbage" runat="server" Text="Помітити як сміття" OnClick="btnSetGarbage_Click" OnClientClick="if (!confirm('Помітити як сміття вибрані файли?')) return false;"/>
                </td>                   
                <td style="border-right: dotted 1px gray; ">
                    <asp:Button ID="btnBlk" runat="server" Text="Зняти блокування" OnClick="btnBlk_Click"   OnClientClick="if (!confirm('Підтвердіть зняття блокування 97 з виділених файлів')) return false;"/>
                </td>                                   
                <td>
                    <asp:Button ID="btnAnalis" runat="server" Text="Проаналізувати" 
                    OnClick="btnAnalis_Click" 
                    OnClientClick="if (!confirm('Розпочати аналіз файлів?')) return false;" />
                </td>
                <td>
                    <asp:Button ID="btnKorr" runat="server" Text="Зформувати кориг. файл" 
                    OnClick="btnKorr_Click" 
                    OnClientClick="if (!confirm('Зформувати коригуючий файл?')) return false;" />
                </td>
                <td>
                    <asp:Button ID="btnRest" runat="server" Text="Вирівняти залишки" 
                    OnClick="btnRest_Click" 
                    OnClientClick="if (!confirm('Вирівняти залишки?')) return false;" />
                </td>
                <td>
                    <asp:Button ID="btnPostAnalis" runat="server" 
                    Text="Повторний аналіз" OnClick="btnPostAnalis_Click" 
                    OnClientClick="if (!confirm('Почати повторний аналіз?')) return false;" />
                </td>
                <td>
                    <asp:Button ID="btnCalc" runat="server" Text="Розрахунок" 
                    OnClick="btnCalc_Click" 
                    OnClientClick="if (!confirm('Виконати розрахунок?')) return false;" />
                </td>                                
            </tr>
        </table>        
        <Bars:BarsSqlDataSource ID="ds" runat="server" ProviderName="barsroot.core" 
            SelectCommand="select null from dual" OnSelecting="ds_Selecting" OnSelected="ds_Selected"
            PreliminaryStatement="begin bars_role_auth.set_role('WR_USSR_TECH'); end;">
        </Bars:BarsSqlDataSource>   
        <br />
        <div style="margin-bottom: 3px;">
            <asp:ImageButton ID="hypExcel" runat="server"  style="padding-right: 10px"
                ImageUrl="/common/images/default/16/export_excel.png" 
                AlternateText="Експорт до Excel" CommandName="ExportExcel" OnCommand="hypExcel_Command" >
            </asp:ImageButton>
            <asp:Label ID="lblCntTitle" runat="server" Text="Загальна кількість відібраних файлів: "></asp:Label><asp:Label ID="lblCnt" runat="server" ForeColor="green" Font-Size="9pt" Text="0"></asp:Label>
            <!--
            <a href="#" onclick="window.open('branchfilesy.aspx','dialogWidth: 400px; dialogHeight: 300px; center: yes');">
                (перегляд статистики по відділенням)
            </a>
            -->
            <a href="#" onclick="window.open('branchfilesy.aspx','popup', 'width=400,height=400');">
                (відділення, по яких немає файлів для обробки)
            </a>
        </div>
        <Bars:BarsGridView ID="gv" runat="server" CssClass="barsGridView" 
         DataSourceID="ds"
         AutoGenerateColumns="False" 
         AllowSorting="True" 
         AllowPaging="True"
         ShowPageSizeBox="True" 
         DataKeyNames="id,file_name"  
         OnRowDataBound="gv_RowDataBound" MergePagerCells="True" OnRowCommand="gv_RowCommand" >
            <FooterStyle CssClass="footerRow" />
            <HeaderStyle CssClass="headerRow" />
            <EditRowStyle CssClass="editRow" />
            <PagerStyle CssClass="pagerRow" />
            <AlternatingRowStyle CssClass="alternateRow" />
            <RowStyle CssClass="normalRow" /> 
            <Columns>
                <asp:ButtonField CommandName="View" Text="Перегляд" />
                <asp:TemplateField SortExpression="GARBAGE"  HeaderText="Сміття" >
                    <itemtemplate>
                        <asp:CheckBox runat="server" 
                            Checked = '<%# ((Convert.ToString(Eval("GARBAGE"))=="Y") ? true : false) %>' 
                            Enabled = '<%# ((Convert.ToString(Eval("GARBAGE"))=="Y") ? false : (gv.PageIndex == 0 ? true : false)) %>' 
                            id="chkGarb" EnableViewState="true"
                            >
                         </asp:CheckBox>
					</itemtemplate>
                    <itemstyle horizontalalign="Center" />
                </asp:TemplateField>                
                <asp:BoundField DataField="BRANCH" SortExpression="BRANCH"  HeaderText="Код підр." />
                <asp:BoundField DataField="FILE_NAME" SortExpression="FILE_NAME" HeaderText="Файл" />
                <asp:TemplateField SortExpression="APPROVED"  HeaderText="Підтвер дження" >
                    <itemtemplate>
                        <asp:CheckBox runat="server" 
                            Checked = '<%# ((Convert.ToString(Eval("APPROVED"))=="Y") ? true : false) %>' 
                            Enabled = '<%# ((Convert.ToString(Eval("APPROVED"))=="Y" || mode!="2") ? false : (gv.PageIndex == 0 ? true : false)) %>' 
                            id="chk" EnableViewState="true"
                            >
                         </asp:CheckBox>
                         <%#  "<div style=\"font-size:6pt;\">" + Eval("APPROVED_TIME") + "</div>"%>
					</itemtemplate>
                    <itemstyle horizontalalign="Center" />
                </asp:TemplateField>                
                <asp:TemplateField SortExpression="GARBAGE"  HeaderText="Зняти блокування" >
                    <itemtemplate>
                        <asp:CheckBox runat="server" 
                            Enabled = '<%# ((Convert.ToString(Eval("GARBAGE"))=="Y" && Convert.ToString(Eval("blk97_removed"))==String.Empty ) ? (gv.PageIndex == 0 ? true : false) : false) %>' 
                            id="chkBlk" EnableViewState="true"
                            >
                         </asp:CheckBox>
					</itemtemplate>
                    <itemstyle horizontalalign="Center" />
                </asp:TemplateField>  
                                
                <asp:BoundField DataField="FILE_DATE" SortExpression="FILE_DATE" HeaderText="Дата файлу" />
                <asp:BoundField DataField="LOADED" SortExpression="LOADED" HeaderText="Завантажено" />
                <asp:BoundField DataField="TOTAL_ROWS" SortExpression="TOTAL_ROWS" HeaderText="Рядків"  >
                    <itemstyle horizontalalign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="TOTAL_SUM" SortExpression="TOTAL_SUM" HeaderText="Сума" >
                    <itemstyle horizontalalign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="FILE_VERSION" SortExpression="FILE_VERSION" HeaderText="Версія" >
                    <itemstyle horizontalalign="Right" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Аналіз" SortExpression="ANALYZED">
                    <itemtemplate>
                        <asp:Label runat="server" Text='<%# "<b style=\"color:"+(Eval("ANALYZED").ToString()=="Y"?"green":  ( Eval("ANALYZED").ToString()=="P"?"#808000":"red")  )+";\">" + (Eval("ANALYZED").ToString()==String.Empty?"N":Eval("ANALYZED").ToString()) + " </b> <div style=\"font-size:6pt;\">" +  Eval("ANALYZED_TIME") +"</div>"  %>' id="Label1"></asp:Label>
					</itemtemplate>
                    <itemstyle horizontalalign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="ANALYZE_ERR_MSG" SortExpression="ANALYZE_ERR_MSG" HeaderText="Помилки при аналізі" />
                <asp:TemplateField HeaderText="Квитанція" SortExpression="ACK">
                    <itemtemplate>
                        <asp:Label runat="server" Text='<%# "<b style=\"color:"+(Eval("ACK").ToString()=="Y"?"green":  ( Eval("ACK").ToString()=="P"?"#808000":"red")  )+";\">" + (Eval("ACK").ToString()==String.Empty?"N":Eval("ACK").ToString()) + " </b> <div style=\"font-size:6pt;\">" +  Eval("FILE_Z_TIME") +"</div>"  %>' id="Label5"></asp:Label>
					</itemtemplate>
                    <itemstyle horizontalalign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Сформовано корегуючий файл" SortExpression="FIX_FILE_CREATED">
                    <itemtemplate>
                        <asp:Label runat="server" Text='<%# "<b style=\"color:"+(Eval("FIX_FILE_CREATED").ToString()=="Y"?"green":  ( Eval("FIX_FILE_CREATED").ToString()=="P"?"#808000":"red")  )+";\">" + (Eval("FIX_FILE_CREATED").ToString()==String.Empty?"N":Eval("FIX_FILE_CREATED").ToString()) + " </b> <div style=\"font-size:6pt;\">" +  Eval("FIX_FILE_CREATED_TIME") +"</div>"  %>' id="Label2"></asp:Label>
					</itemtemplate>
                    <itemstyle horizontalalign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="FFC_ERR_MSG" SortExpression="FFC_ERR_MSG" HeaderText="Помилки при формуванні кор. файлу" />
                <asp:TemplateField HeaderText="Вирівняні залишки" SortExpression="CORRECTED">
                    <itemtemplate>
                        <asp:Label runat="server" Text='<%# "<b style=\"color:"+(Eval("CORRECTED").ToString()=="Y"?"green":  ( Eval("CORRECTED").ToString()=="P"?"#808000":"red")  )+";\">" + (Eval("CORRECTED").ToString()==String.Empty?"N":Eval("CORRECTED").ToString()) + " </b> <div style=\"font-size:6pt;\">" +  Eval("CORRECTED_TIME") +"</div>"  %>' id="Label3"></asp:Label>
					</itemtemplate>
                    <itemstyle horizontalalign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="CORR_ERR_MSG" SortExpression="CORR_ERR_MSG" HeaderText="Помилки при вирівнюванні залишків" />
                <asp:TemplateField HeaderText="Повторний аналіз" SortExpression="POST_ANALYZED">
                    <itemtemplate>
                        <asp:Label runat="server" Text='<%# "<b style=\"color:"+(Eval("POST_ANALYZED").ToString()=="Y"?"green":  ( Eval("POST_ANALYZED").ToString()=="P"?"#808000":"red")  )+";\">" + (Eval("POST_ANALYZED").ToString()==String.Empty?"N":Eval("POST_ANALYZED").ToString()) + " </b> <div style=\"font-size:6pt;\">" +  Eval("POST_ANALYZED_TIME") +"</div>"  %>' id="Label4"></asp:Label>
					</itemtemplate>
                    <itemstyle horizontalalign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="POST_ERR_MSG" SortExpression="POST_ERR_MSG" HeaderText="Помилки при повторному аналізі" />
                <asp:TemplateField HeaderText="Проведені розрахунки" SortExpression="PROCESSED">
                    <itemtemplate>
                        <asp:Label runat="server" Text='<%# "<b style=\"color:"+(Eval("PROCESSED").ToString()=="Y"?"green":  ( Eval("PROCESSED").ToString()=="P"?"#808000":"red")  )+";\">" + (Eval("PROCESSED").ToString()==String.Empty?"N":Eval("PROCESSED").ToString()) + " </b> <div style=\"font-size:6pt;\">" +  Eval("PROCESSED_TIME") +"</div>"  %>' id="Label6"></asp:Label>
					</itemtemplate>
                    <itemstyle horizontalalign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="PROCESSED_ERR_MSG" SortExpression="PROCESSED_ERR_MSG" HeaderText="Помилки при розрахунках" />
            </Columns>
        </Bars:BarsGridView>
        <asp:HiddenField ID="hfSelected" runat="server" />
    </div>
    </form>
</body>
</html>
