﻿using System;
using System.Collections.Generic;
using Bars.Classes;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Web.UI.HtmlControls;
using Oracle.DataAccess.Client;
using System.Globalization;
using Oracle.DataAccess.Types;
using System.Threading;
using System.Web.Security;
using Bars.UserControls;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;


public partial class adm_seizure : Bars.BarsPage
{
    protected OracleConnection con;
    private void FillData()
    {
        dsMain.DataBind();
        gvMain.DataBind();
    }

    //Населення грида
    protected void Page_Load(object sender, EventArgs e)
    {

        dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        String SelectCommand = @"select
                                             KEY, 
                                             FIO,     --ФИО 
                                             IDCODE, --Идентификационный код 
                                             DECODE(DOCTYPE, 1,'Паспорт',2,'Свідоцтво про нарродження',3,'Військовий квиток',0,'Інше') DOCTYPE, --Документ 
                                             PASP_S,  --Серия паспорта (документа) 
                                             PASP_N,  --Номер паспорта (документа) 
                                             PASP_W,  --Кем выдан паспорт (документ) 
                                             PASP_D,  --Дата выдачи паспорта (документа) 
                                             BRANCH, --BRANCH BARS 
                                             BIRTHDAT,--Дата рождения 
                                             BIRTHPL, --Место рождения 
                                             DECODE(SEX, 1, 'чол.',2,'жін.', '--') SEX, 
                                             POSTIDX, --Почтовый индекс 
                                             REGION,  --Область 
                                             DISTRICT,--Район 
                                             CITY,    --Город 
                                             nvl(ADDRESS,'--') ADDRESS,--Адрес (улица, дом, квартира) 
                                             PHONE_H,--Домашний телефон  
                                             PHONE_J,--Рабочий телефон 
                                             LANDCOD,--Код страны (гражданство) 
                                             REGDATE,--Дата регистрации вкладчика 
                                             DEPCODE,--Код вида неподвижного вклада -- внутрисистемный 70/71/72 
                                             DEPVIDNAME, --Наименование вида неподвижного вклада -- Поточний/Терміновий/Дитячий 
                                             ACC_CARD, --Символьный код картотеки 
                                             DEPNAME,--Наименование вида неподвижного вклада 
                                             NLS, --Лицевой счет 
                                             KV,
                                             ID,  --Идентификатор записи АСВО 
                                             DATO,--Дата открытия основного вклада 
                                             (OST-f_part_sum_immobile(key))/100 OST, --Остаток на вкладе в  
                                             SUM, --Сумма в коп., которую нужно выплатить. Будет использоваться для наследников. 
                                             DATN,-- Дата, по!!! которую начислены проценты 
                                             MARK,--Учетный символ картотеки 
                                             KOD_OTD, --Номер подразделения Ощадбанка в ACBO 
                                             SOURCE, 
                                             REF, 
                                             ND, 
                                             DPTID,
                                             REFOUT,
                                             REFPAY, 
                                             STATUS, 
                                             ERRMSG, 
                                             FL, 
                                             COMMENTS      
                                           from v_asvo_immobile_pay ";
        if (String.IsNullOrEmpty(flFio.Text) && String.IsNullOrEmpty(flIDCODE.Text) && String.IsNullOrEmpty(flNSC.Text) && String.IsNullOrEmpty(tbSer.Text) && String.IsNullOrEmpty(tbNum.Text) && String.IsNullOrEmpty(tbDPTID.Text))
        {
            SelectCommand += "where 1=0 ";
        }
        else
        {
            SelectCommand += "where 1=1 and key in(select key from part_pay_immobile where status=2) ";
        }

        
      

        dsMain.SelectCommand = SelectCommand;

      //  gvMain.AutoGenerateCheckBoxColumn = true;
    }

    //Перечитати дани
    protected void btRefresh_Click(object sender, EventArgs e)
    {
        dsMain.DataBind();
        gvMain.DataBind();
    }

    // Для коректного відображення алертiв
    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText + "');", true);
    }

    //Для открытия в новом окне
    private void Window_open(String URL)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "open", " window.open('" + URL + "');", true);
    }

}
