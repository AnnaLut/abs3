using System;
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


public partial class neruhomi_neruhomi : Bars.BarsPage
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
                                             OST/100 OST, --Остаток на вкладе в  
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
                                             FL      
                                           from v_asvo_immobile ";
        if (String.IsNullOrEmpty(flFio.Text) && String.IsNullOrEmpty(flIDCODE.Text) && String.IsNullOrEmpty(flNSC.Text))
        {
            SelectCommand += "where 1=0 ";
        }
        else
        {
            SelectCommand += "where 1=1 ";
        }

        if (!String.IsNullOrEmpty(flFio.Text))
        {
            SelectCommand += " and upper(fio) like upper('%" + flFio.Text + "%') ";
        }

        if (!String.IsNullOrEmpty(flIDCODE.Text))
        {
            SelectCommand += " and idcode like '%" + flIDCODE.Text + "%' ";
        }

        if (!String.IsNullOrEmpty(flNSC.Text))
        {
            SelectCommand += " and nls like '%" + flNSC.Text + "%' ";
        }

        if (!String.IsNullOrEmpty(tbDPTID.Text))
        {
            SelectCommand += " and dptid like '%" + tbDPTID.Text + "%' ";
        }

        if (rbAll.Checked)
        {
            SelectCommand += " and source like '%' ";
        }

        if (rbASVO.Checked)
        {
            SelectCommand += " and upper(source) like '%АСВО%' ";
        }
        if (rbDPT.Checked)
        {
            SelectCommand += " and upper(source) like '%BARS%' ";
        }
        if (rbOTHERS.Checked)
        {
            SelectCommand += " and upper(source) not  like '%BARS%' and upper(source) not like '%АСВО%' ";
        }

        if (rbSum1.Checked)
        {
            SelectCommand += @" and (
                                         (
                                             (upper(source)  like '%АСВО%' and  attr not like '%h%' and  attr not like '%Q%' and ost <get_scale_immobile(nvl(kv,980))
)
                                          or (upper(source)  like '%АСВО%' and  attr not like '%Q%' and  attr not like '%h%' and ost <get_scale_immobile(nvl(kv,980))
)
                                         )
                                       or
                                         (
                                          upper(source) not like '%АСВО%' and ost <get_scale_immobile(nvl(kv,980))
                                         )
                                    )
                 ";
        }

        if (rbSum2.Checked)
        {
            			
                SelectCommand += @"and (
                                         (
                                          (upper(source) like '%АСВО%' and  attr like '%h%') or (upper(source) like '%АСВО%' and attr like '%Q%')
                                         )
                                       or
                                         (
                                             (upper(source)  like '%АСВО%' and  attr not like '%h%' and attr not like '%Q%'  and ost >= get_scale_immobile(nvl(kv, 980)))
                                          or (upper(source)  like '%АСВО%' and attr not like '%Q%'  and  attr not like '%h%' and ost >= get_scale_immobile(nvl(kv, 980)))
                                         )
                                       or
                                         (
                                          upper(source) not like '%АСВО%' and ost >= get_scale_immobile(nvl(kv, 980))
                                         )
                                      ) ";

        }

        if (rbNSender.Checked)
        {
            SelectCommand += " and fl=0 ";
            if (rbSum1.Checked)
            {
                bt_pay_to_6.Enabled = true;
                bt_pay_to_rnv.Enabled = false;
            }
            if (rbSum2.Checked)
            {
                bt_pay_to_6.Enabled = false;
                bt_pay_to_rnv.Enabled = true;
            }
        }
        if (rbSender.Checked)
        {
            SelectCommand += " and fl>0 ";
            bt_pay_to_6.Enabled = false;
            bt_pay_to_rnv.Enabled = false;
        }
        if (rbErr.Checked)
        {
            SelectCommand += " and fl<0 ";
            bt_pay_to_6.Enabled = false;
            bt_pay_to_rnv.Enabled = false;
        }

        dsMain.SelectCommand = SelectCommand;

        gvMain.AutoGenerateCheckBoxColumn = true;
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

    //Кнопка HELP
    // protected void btHelp(object sender, ImageClickEventArgs e)
    // {
    //     Window_open("/barsroot/over/over_help.htm");
    // }


    //Редагування картки вклада
    protected void btEdit_Click(object sender, ImageClickEventArgs e)
    {
        string key = Convert.ToString(gvMain.SelectedDataKey.Values[0]);
        ShowError("KEY:" + key);
        //  Response.Redirect("/barsroot/neruhomi/edit_neruhomi.aspx?key=" + key);
    }

    //Розкраска грида
    protected void gvMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //    DateTimeFormatInfo dateFormat = new DateTimeFormatInfo();
        //    dateFormat.ShortDatePattern = "dd.MM.yyyy";

        //    try
        //    {
        //        InitOraConnection();
        //        if (e.Row.RowType == DataControlRowType.DataRow)
        //        {
        //            object o1 = ((DataRowView)e.Row.DataItem).Row["SD_2600"];
        //            object o2 = ((DataRowView)e.Row.DataItem).Row["Lim_2600"];
        //            object o3 = SQL_SELECT_scalar(@"select to_char(sysdate,'dd.mm.yyyy') from dual");
        //            object o4 = ((DataRowView)e.Row.DataItem).Row["datd2"];

        //            decimal sd_2600 = o1 == DBNull.Value || o1 == null ? 0 : Convert.ToDecimal(o1);
        //            decimal lim_2600 =  o2 == DBNull.Value || o2 == null ? 0 : Convert.ToDecimal(o2);
        //            DateTime sysdate =  Convert.ToDateTime(o3, dateFormat);
        //            DateTime datd2 =  o4 == DBNull.Value || o4 == null ? DateTime.Now : Convert.ToDateTime(o4, dateFormat);

        //                    if (sd_2600 != lim_2600)
        //            {
        //                e.Row.Cells[13].BackColor = System.Drawing.Color.Plum;
        //            }
        //            if (sysdate == datd2)
        //            {
        //                e.Row.Cells[6].BackColor = System.Drawing.Color.LightGreen;
        //            }
        //            if (datd2 < sysdate)
        //            {
        //                e.Row.Cells[6].BackColor = System.Drawing.Color.Tomato;
        //            }
        //            if (datd2 <= sysdate.AddDays(7) && sysdate != datd2 && datd2>sysdate)
        //            {
        //                e.Row.Cells[6].BackColor = System.Drawing.Color.Aquamarine;
        //            }
        //        }

        //    }
        //    finally
        //    {
        //        DisposeOraConnection();
        //    }

    }

    protected void cbAll_CheckedChanged(object sender, EventArgs e)
    {
        Boolean chkd = (sender as CheckBox).Checked;

        foreach (GridViewRow row in gvMain.Rows)
        {
            CheckBox cb = row.FindControl("cb") as CheckBox;
            cb.Checked = chkd;
        }
    }


    protected void bt_pay_to_6_Click(object sender, EventArgs e)
    {
        InitOraConnection();
        try
        {
            foreach (int row in gvMain.GetSelectedIndices())
            {
                Decimal key = Convert.ToDecimal(gvMain.DataKeys[row]["Key"]);


                ClearParameters();
                SetParameters("key", DB_TYPE.Int64, key, DIRECTION.Input);
                //Закриваем овер.
                SQL_NONQUERY("begin neruhomi.before_pay_to_6(:key); end;");

            }


        }
        finally
        {
            DisposeOraConnection();

        }
        FillData();
    }
    protected void bt_pay_to_rnv_Click(object sender, EventArgs e)
    {
        InitOraConnection();
        try
        {
            foreach (int row in gvMain.GetSelectedIndices())
            {
                Decimal key = Convert.ToDecimal(gvMain.DataKeys[row]["Key"]);


                ClearParameters();
                SetParameters("key", DB_TYPE.Int64, key, DIRECTION.Input);
                //Закриваем овер.
                SQL_NONQUERY("begin neruhomi.before_pay_to_crnv(:key); end;");

            }


        }
        finally
        {
            DisposeOraConnection();

        }
        FillData();
    }
}
