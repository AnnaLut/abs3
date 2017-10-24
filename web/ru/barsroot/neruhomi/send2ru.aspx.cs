using System;
using Bars.Classes;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;



public partial class send2ru : Bars.BarsPage
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
                                             STATUS, 
                                             ERRMSG, 
                                             FL      
                                           from V_ASVO_IMMOBILE_SEND2RU ";
        if (String.IsNullOrEmpty(flFio.Text) && String.IsNullOrEmpty(flIDCODE.Text) && String.IsNullOrEmpty(flNSC.Text))
        {
            SelectCommand += "where 1=0 ";
        }
        else
        {
            SelectCommand += "where 1=1 and fl not in(-6, 14)";
        }

        if (!String.IsNullOrEmpty(flFio.Text))
        {
            SelectCommand += " and upper(fio) like upper('" + flFio.Text + "%') ";
        }

        if (!String.IsNullOrEmpty(flIDCODE.Text))
        {
            SelectCommand += " and idcode like '%" + flIDCODE.Text + "%' ";
        }

        if (!String.IsNullOrEmpty(flNSC.Text))
        {
            SelectCommand += " and nls like '%" + flNSC.Text + "%' ";
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

    
    //Розкраска грида
    protected void gvMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
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


    protected void bt_send2ru(object sender, EventArgs e)
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
                SQL_NONQUERY("begin pay_immobile.before_send2ru(:key); end;");

            }


        }
        finally
        {
            DisposeOraConnection();

        }
        FillData();
    }
}
