<%@ Page Language="C#" AutoEventWireup="true" CodeFile="history.aspx.cs" Inherits="ussr_deposit_history" meta:resourcekey="PageResource1"%>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
        <base target="_self" />
		<title>Компенсаційні вклади</title>
		<script type="text/javascript" language="javascript" src="js/func.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
		<script type="text/javascript" language="javascript" src="js/sign.js"></script>
		<script type="text/javascript" language="javascript" src="/Common/Script/Sign.js"></script>
		<link href="css/dpt.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript" language="javascript">
			document.onkeydown = function(){if(event.keyCode==27) window.close();}
		</script>    
    <table class="MainTable"> 
        <tr>
            <td>
                <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" meta:resourcekey="lbTitleResource2"
                    Text="Історія первинних даних по вкладу №%s"></asp:Label></td>
        </tr>
        <tr>
            <td>
                <cc1:imagetextbutton id="btRefresh" runat="server" imageurl="\Common\Images\default\16\refresh.png"
                    text="Перечитати" EnabledAfter="0" meta:resourcekey="btRefreshResource1" ToolTip="Перечитати" OnClick="btRefresh_Click"></cc1:imagetextbutton>
            </td>
        </tr>
        <tr>
            <td>
                <bars:barsgridview id="gridHist" runat="server" allowpaging="True" allowsorting="True"
                    cssclass="BaseGrid" datasourceid="dsHist" datemask="dd/MM/yyyy" showpagesizebox="True" meta:resourcekey="gridHistResource1" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="FILE_NAME" HeaderText="Імя файла (FILE_NAME)" 
                            SortExpression="FILE_NAME" meta:resourcekey="BoundFieldResource55">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="LOADED" HeaderText="Дата та час завант. файла (LOADED)" 
                            SortExpression="LOADED" meta:resourcekey="BoundFieldResource56">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DONE" HeaderText="Код стану файла (DONE)"
                            SortExpression="DONE" meta:resourcekey="BoundFieldResource57">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NAME" HeaderText="Прізвище вкладника (NAME)"
                            SortExpression="NAME" meta:resourcekey="BoundFieldResource58" />
                        <asp:BoundField DataField="F_NAME" HeaderText="Ім'я вкладника (F_NAME)" 
                            SortExpression="F_NAME" meta:resourcekey="BoundFieldResource59">
                            <itemstyle horizontalalign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="L_NAME" HeaderText="По-батькові вкладника (L_NAME)" 
                            SortExpression="L_NAME" meta:resourcekey="BoundFieldResource60">
                            <itemstyle horizontalalign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ICOD" HeaderText="Ідент. код (ICOD)"
                            SortExpression="ICOD" meta:resourcekey="BoundFieldResource61">
                            <itemstyle horizontalalign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="S_PASPORT" HeaderText="Серія паспорту (S_PASPORT)"
                            SortExpression="S_PASPORT" meta:resourcekey="BoundFieldResource62">
                            <itemstyle horizontalalign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="N_PASPORT" HeaderText="Номер паспорту (N_PASPORT)"
                            SortExpression="N_PASPORT" meta:resourcekey="BoundFieldResource63">
                            <itemstyle horizontalalign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="W_PASPORT" HeaderText="Де і ким видано паспорт (W_PASPORT)" 
                            SortExpression="W_PASPORT" meta:resourcekey="BoundFieldResource64">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="POST_INDEX" HeaderText="Індекс (POST_INDEX)" 
                            SortExpression="POST_INDEX" meta:resourcekey="BoundFieldResource65">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="RG_ADRES" HeaderText="Область (RG_ADRES)" 
                            SortExpression="RG_ADRES" meta:resourcekey="BoundFieldResource66">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="A_ADRES" HeaderText="Район (A_ADRES)"
                            SortExpression="A_ADRES" meta:resourcekey="BoundFieldResource67">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="C_ADRES" HeaderText="Нас. пункт (C_ADRES)"
                            SortExpression="C_ADRES" meta:resourcekey="BoundFieldResource68">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="S_ADRES" HeaderText="Вулиця (S_ADRES)"
                            SortExpression="S_ADRES" meta:resourcekey="BoundFieldResource69">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="B_ADRES" HeaderText="Будинок (B_ADRES)"
                            SortExpression="B_ADRES" meta:resourcekey="BoundFieldResource70">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="B_ADRES_L" HeaderText="Буква буд. (B_ADRES_L)"
                            SortExpression="B_ADRES_L" meta:resourcekey="BoundFieldResource71">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="R_ADRES" HeaderText="№ кварт. (R_ADRES)"
                            SortExpression="R_ADRES" meta:resourcekey="BoundFieldResource72">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="R_ADRES_L" HeaderText="Буква кварт. (R_ADRES_L)"
                            SortExpression="R_ADRES_L" meta:resourcekey="BoundFieldResource73">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DATA_B" HeaderText="Дата народж. (DATA_B)"
                            SortExpression="DATA_B" meta:resourcekey="BoundFieldResource74">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="REGION" HeaderText="№ рег. (REGION)"
                            SortExpression="REGION" meta:resourcekey="BoundFieldResource75">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="OTDEL" HeaderText="№ відд. (OTDEL)"
                            SortExpression="OTDEL" meta:resourcekey="BoundFieldResource76">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FILIAL" HeaderText="№ філії (FILIAL)"
                            SortExpression="FILIAL" meta:resourcekey="BoundFieldResource77">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="VKLAD" HeaderText="Найм. виду вкладу (VKLAD)"
                            SortExpression="VKLAD" meta:resourcekey="BoundFieldResource78">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="VAL" HeaderText="Код вал. (VAL)"
                            SortExpression="VAL" meta:resourcekey="BoundFieldResource79">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="N_ANALIT" HeaderText="№ аналіт. рахунку (N_ANALIT)"  
                            SortExpression="N_ANALIT" meta:resourcekey="BoundFieldResource80">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NSC" HeaderText="№ особ. рах. клієнта (NSC)" 
                            SortExpression="NSC" meta:resourcekey="BoundFieldResource81">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DATO" HeaderText="Дата відкр. рахунку або дата депоз. договору (DATO)"
                            SortExpression="DATO" meta:resourcekey="BoundFieldResource82">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NOM_DOG" HeaderText="№ депоз. дог. (NOM_DOG)"
                            SortExpression="NOM_DOG" meta:resourcekey="BoundFieldResource83">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ATTR" HeaderText="Стан опер. по рах. (ATTR)"
                            SortExpression="ATTR" meta:resourcekey="BoundFieldResource84">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="OST" HeaderText="Сума зал. на рах. (OST)"
                            SortExpression="to_number(replace(OST, ' ', ','),'FM999G999G999G990D00')" meta:resourcekey="BoundFieldResource85">
                            <itemstyle horizontalalign="Right" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PROC" HeaderText="%% ставка по вкладу (PROC)"
                            SortExpression="PROC" meta:resourcekey="BoundFieldResource86">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SUM_PROC" HeaderText="Сума нарах. %% (SUM_PROC)"
                            SortExpression="to_number(replace(SUM_PROC, ' ', ','),'FM999G999G999G990D00')" meta:resourcekey="BoundFieldResource87">
                            <itemstyle horizontalalign="Right" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="OST_PROC" HeaderText="Сума зал. з нарах. %% (OST_PROC)"
                            SortExpression="to_number(replace(OST_PROC, ' ', ','),'FM999G999G999G990D00')" meta:resourcekey="BoundFieldResource88">
                            <itemstyle horizontalalign="Right" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SUM" HeaderText="Розрах. сума до сплати (SUM)"
                            SortExpression="to_number(replace(SUM, ' ', ','),'FM999G999G999G990D00')" meta:resourcekey="BoundFieldResource89">
                            <itemstyle horizontalalign="Right" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DBCODE" HeaderText="Внутр. ідент. код в БД (DBCODE)"
                            SortExpression="DBCODE" meta:resourcekey="BoundFieldResource90">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DATA_ID" HeaderText="Дата пров. ідент. вкладника (DATA_ID)"
                            SortExpression="DATA_ID" meta:resourcekey="BoundFieldResource91">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TOTAL_ROL" HeaderText="Оборот поточної операції рахунку (TOTAL_ROL)"
                            SortExpression="to_number(replace(TOTAL_ROL, ' ', ','),'FM999G999G999G990D00')" meta:resourcekey="BoundFieldResource92">
                            <itemstyle horizontalalign="Right" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NSC2" HeaderText="Номер рахунку для перерах. компенс. виплат (NSC2)"
                            SortExpression="NSC2" meta:resourcekey="BoundFieldResource93">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SUM2" HeaderText="Сума виплати (SUM2)"
                            SortExpression="to_number(replace(SUM2, ' ', ','),'FM999G999G999G990D00') " meta:resourcekey="BoundFieldResource94">
                            <itemstyle horizontalalign="Right" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="VERS" HeaderText="№ версії (VERS)"
                            SortExpression="VERS" meta:resourcekey="BoundFieldResource95">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DATM" HeaderText="Дата форм. (DATM)"
                            SortExpression="DATM" meta:resourcekey="BoundFieldResource96">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TIMEM" HeaderText="Час форм. (TIMEM)"
                            SortExpression="TIMEM" meta:resourcekey="BoundFieldResource97">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BDAT" HeaderText="Початок періода (BDAT)"
                            SortExpression="BDAT" meta:resourcekey="BoundFieldResource98">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="EDAT" HeaderText="Заверш. періода (EDAT)"
                            SortExpression="EDAT" meta:resourcekey="BoundFieldResource99">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DATL" HeaderText="Дата операції (DATL)"
                            SortExpression="DATL" meta:resourcekey="BoundFieldResource100">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DBCODEOLD" HeaderText="Попер. внутр. ідент. код в БД (DBCODEOLD)"
                            SortExpression="DBCODEOLD" meta:resourcekey="BoundFieldResource101">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CUST_DATE" HeaderText="Дата реєстр. / оновл. рекв. вкладника (CUST_DATE)"
                            SortExpression="CUST_DATE" meta:resourcekey="BoundFieldResource102">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CUST_OPER" HeaderText="I - реєстр. вкладн., U - оновл. рекв. вкладн. (CUST_OPER)"
                            SortExpression="CUST_OPER" meta:resourcekey="BoundFieldResource103">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                    </Columns>
                </bars:barsgridview>
            </td>
        </tr>
        <tr>
            <td>
                <bars:barssqldatasource ProviderName="barsroot.core" id="dsHist" runat="server"></bars:barssqldatasource>
            </td>
        </tr>        
        <tr>
            <td>
                <asp:Label ID="lbErrTitle" runat="server" CssClass="InfoHeader"
                    Text="Історія первинних даних з помилками по вкладу №%s" meta:resourcekey="lbErrTitleResource1"></asp:Label></td>
        </tr>
        <tr>
            <td>
                <bars:barsgridview id="gridHistInc" runat="server" allowpaging="True" allowsorting="True"
                    cssclass="BaseGrid" datasourceid="dsHistInc" datemask="dd/MM/yyyy" showpagesizebox="True" meta:resourcekey="gridHistResource1" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="FILE_NAME" HeaderText="Імя файла (FILE_NAME)" 
                            SortExpression="FILE_NAME" meta:resourcekey="BoundFieldResource55">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="LOADED" HeaderText="Дата та час завант. файла (LOADED)" 
                            SortExpression="LOADED" meta:resourcekey="BoundFieldResource56">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DONE" HeaderText="Код стану файла (DONE)"
                            SortExpression="DONE" meta:resourcekey="BoundFieldResource57">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NAME" HeaderText="Прізвище вкладника (NAME)"
                            SortExpression="NAME" meta:resourcekey="BoundFieldResource58" />
                        <asp:BoundField DataField="F_NAME" HeaderText="Ім'я вкладника (F_NAME)" 
                            SortExpression="F_NAME" meta:resourcekey="BoundFieldResource59">
                            <itemstyle horizontalalign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="L_NAME" HeaderText="По-батькові вкладника (L_NAME)" 
                            SortExpression="L_NAME" meta:resourcekey="BoundFieldResource60">
                            <itemstyle horizontalalign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ICOD" HeaderText="Ідент. код (ICOD)"
                            SortExpression="ICOD" meta:resourcekey="BoundFieldResource61">
                            <itemstyle horizontalalign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="S_PASPORT" HeaderText="Серія паспорту (S_PASPORT)"
                            SortExpression="S_PASPORT" meta:resourcekey="BoundFieldResource62">
                            <itemstyle horizontalalign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="N_PASPORT" HeaderText="Номер паспорту (N_PASPORT)"
                            SortExpression="N_PASPORT" meta:resourcekey="BoundFieldResource63">
                            <itemstyle horizontalalign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="W_PASPORT" HeaderText="Де і ким видано паспорт (W_PASPORT)" 
                            SortExpression="W_PASPORT" meta:resourcekey="BoundFieldResource64">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="POST_INDEX" HeaderText="Індекс (POST_INDEX)" 
                            SortExpression="POST_INDEX" meta:resourcekey="BoundFieldResource65">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="RG_ADRES" HeaderText="Область (RG_ADRES)" 
                            SortExpression="RG_ADRES" meta:resourcekey="BoundFieldResource66">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="A_ADRES" HeaderText="Район (A_ADRES)"
                            SortExpression="A_ADRES" meta:resourcekey="BoundFieldResource67">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="C_ADRES" HeaderText="Нас. пункт (C_ADRES)"
                            SortExpression="C_ADRES" meta:resourcekey="BoundFieldResource68">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="S_ADRES" HeaderText="Вулиця (S_ADRES)"
                            SortExpression="S_ADRES" meta:resourcekey="BoundFieldResource69">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="B_ADRES" HeaderText="Будинок (B_ADRES)"
                            SortExpression="B_ADRES" meta:resourcekey="BoundFieldResource70">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="B_ADRES_L" HeaderText="Буква буд. (B_ADRES_L)"
                            SortExpression="B_ADRES_L" meta:resourcekey="BoundFieldResource71">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="R_ADRES" HeaderText="№ кварт. (R_ADRES)"
                            SortExpression="R_ADRES" meta:resourcekey="BoundFieldResource72">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="R_ADRES_L" HeaderText="Буква кварт. (R_ADRES_L)"
                            SortExpression="R_ADRES_L" meta:resourcekey="BoundFieldResource73">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DATA_B" HeaderText="Дата народж. (DATA_B)"
                            SortExpression="DATA_B" meta:resourcekey="BoundFieldResource74">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="REGION" HeaderText="№ рег. (REGION)"
                            SortExpression="REGION" meta:resourcekey="BoundFieldResource75">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="OTDEL" HeaderText="№ відд. (OTDEL)"
                            SortExpression="OTDEL" meta:resourcekey="BoundFieldResource76">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FILIAL" HeaderText="№ філії (FILIAL)"
                            SortExpression="FILIAL" meta:resourcekey="BoundFieldResource77">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="VKLAD" HeaderText="Найм. виду вкладу (VKLAD)"
                            SortExpression="VKLAD" meta:resourcekey="BoundFieldResource78">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="VAL" HeaderText="Код вал. (VAL)"
                            SortExpression="VAL" meta:resourcekey="BoundFieldResource79">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="N_ANALIT" HeaderText="№ аналіт. рахунку (N_ANALIT)"  
                            SortExpression="N_ANALIT" meta:resourcekey="BoundFieldResource80">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NSC" HeaderText="№ особ. рах. клієнта (NSC)" 
                            SortExpression="NSC" meta:resourcekey="BoundFieldResource81">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DATO" HeaderText="Дата відкр. рахунку або дата депоз. договору (DATO)"
                            SortExpression="DATO" meta:resourcekey="BoundFieldResource82">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NOM_DOG" HeaderText="№ депоз. дог. (NOM_DOG)"
                            SortExpression="NOM_DOG" meta:resourcekey="BoundFieldResource83">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ATTR" HeaderText="Стан опер. по рах. (ATTR)"
                            SortExpression="ATTR" meta:resourcekey="BoundFieldResource84">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="OST" HeaderText="Сума зал. на рах. (OST)"
                            SortExpression="to_number(replace(OST, ' ', ','),'FM999G999G999G990D00')" meta:resourcekey="BoundFieldResource85">
                            <itemstyle horizontalalign="Right" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PROC" HeaderText="%% ставка по вкладу (PROC)"
                            SortExpression="PROC" meta:resourcekey="BoundFieldResource86">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SUM_PROC" HeaderText="Сума нарах. %% (SUM_PROC)"
                            SortExpression="to_number(replace(SUM_PROC, ' ', ','),'FM999G999G999G990D00')" meta:resourcekey="BoundFieldResource87">
                            <itemstyle horizontalalign="Right" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="OST_PROC" HeaderText="Сума зал. з нарах. %% (OST_PROC)"
                            SortExpression="to_number(replace(OST_PROC, ' ', ','),'FM999G999G999G990D00')" meta:resourcekey="BoundFieldResource88">
                            <itemstyle horizontalalign="Right" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SUM" HeaderText="Розрах. сума до сплати (SUM)"
                            SortExpression="to_number(replace(SUM, ' ', ','),'FM999G999G999G990D00')" meta:resourcekey="BoundFieldResource89">
                            <itemstyle horizontalalign="Right" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DBCODE" HeaderText="Внутр. ідент. код в БД (DBCODE)"
                            SortExpression="DBCODE" meta:resourcekey="BoundFieldResource90">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DATA_ID" HeaderText="Дата пров. ідент. вкладника (DATA_ID)"
                            SortExpression="DATA_ID" meta:resourcekey="BoundFieldResource91">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TOTAL_ROL" HeaderText="Оборот поточної операції рахунку (TOTAL_ROL)"
                            SortExpression="to_number(replace(TOTAL_ROL, ' ', ','),'FM999G999G999G990D00')" meta:resourcekey="BoundFieldResource92">
                            <itemstyle horizontalalign="Right" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="VERS" HeaderText="№ версії (VERS)"
                            SortExpression="VERS" meta:resourcekey="BoundFieldResource95">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DATM" HeaderText="Дата форм. (DATM)"
                            SortExpression="DATM" meta:resourcekey="BoundFieldResource96">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TIMEM" HeaderText="Час форм. (TIMEM)"
                            SortExpression="TIMEM" meta:resourcekey="BoundFieldResource97">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BDAT" HeaderText="Початок періода (BDAT)"
                            SortExpression="BDAT" meta:resourcekey="BoundFieldResource98">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="EDAT" HeaderText="Заверш. періода (EDAT)"
                            SortExpression="EDAT" meta:resourcekey="BoundFieldResource99">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DATL" HeaderText="Дата операції (DATL)"
                            SortExpression="DATL" meta:resourcekey="BoundFieldResource100">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DBCODEOLD" HeaderText="Попер. внутр. ідент. код в БД (DBCODEOLD)"
                            SortExpression="DBCODEOLD" meta:resourcekey="BoundFieldResource101">
                            <itemstyle horizontalalign="Center" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="REC_MSG" HeaderText="Помилка сервера (REC_MSG)"
                            SortExpression="REC_MSG" meta:resourcekey="BoundFieldResource107">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="REC_MSG_ORA" HeaderText="Помилка бази даних (REC_MSG_ORA)"
                            SortExpression="REC_MSG_ORA" meta:resourcekey="BoundFieldResource108">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="REC_ERROR_BACKTRACE" HeaderText="Зворотній стек помилки (REC_ERROR_BACKTRACE)"
                            SortExpression="REC_ERROR_BACKTRACE" meta:resourcekey="BoundFieldResource109">
                            <itemstyle horizontalalign="Left" wrap="False" />
                        </asp:BoundField>
                    </Columns>
                </Bars:BarsGridView>
            </td>
        </tr>
        <tr>
            <td>
                <bars:barssqldatasource id="dsHistInc" ProviderName="barsroot.core" runat="server">
                </Bars:BarsSqlDataSource>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
