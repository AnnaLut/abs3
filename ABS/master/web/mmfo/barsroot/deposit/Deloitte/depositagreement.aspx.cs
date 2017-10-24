﻿using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.Exception;
using Bars.Requests;
using BarsWeb.Core.Logger;

public partial class DepositAgreement2 : Bars.BarsPage
{

  
    private String _dpt_num;
    private Int64? _rnk;
    private Boolean? ActionsEnabled;
    private readonly IDbLogger _dbLogger;
    public DepositAgreement2()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
    }

    # region Публичные свойства
    public Decimal dpt_id
    {
        get
        {
            if (Request["dpt_id"] == null)
                Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");
            return Convert.ToDecimal(Request["dpt_id"]);
        }
    }
    /// <summary>
    /// 
    /// </summary>
    public String dpt_num
    {
        get
        {
            if (String.IsNullOrEmpty(_dpt_num))
            {
                OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                OracleCommand cmd = con.CreateCommand();
                try
                {
                    cmd.Parameters.Add("p_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

                    if (closed)
                        cmd.CommandText = "select d.dpt_id, d.dpt_num as nd from V_DPT_PORTFOLIO_ALL_CLOSED d where d.dpt_id = :p_dptid";
                    else
                        cmd.CommandText = "select d.deposit_id, d.nd from dpt_deposit d where d.deposit_id = :p_id";


                    OracleDataReader rdr = cmd.ExecuteReader();
                    if (rdr.Read())
                    {
                        _dpt_num = Convert.ToString(rdr["nd"]);
                    }
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }

            return _dpt_num;
        }
    }
    
    /// <summary>
    /// 
    /// </summary>
    public Int64 rnk
    {
        get
        {
            if (!_rnk.HasValue)
            {
                OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                OracleCommand cmd = con.CreateCommand();

                try
                {
                    if(closed)
                         cmd.CommandText = "select d.cust_id as rnk from V_DPT_PORTFOLIO_ALL_CLOSED d where d.dpt_id = :p_dptid";
                    else
                        cmd.CommandText = "select d.rnk from dpt_deposit d where d.deposit_id = :p_dptid";

                    cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

                    OracleDataReader rdr = cmd.ExecuteReader();

                    if (rdr.Read())
                    {
                        _rnk = Convert.ToInt64(rdr["rnk"]);
                    }
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }

            return _rnk.Value;
        }
    }

    /// <summary>
    /// 
    /// </summary>
    private String scheme
    {
        get
        {
            return Request["scheme"];
        }
    }
    public String other
    {
        get
        {
            return Request["other"];
        }
    }
    public Int64? rnk_tr
    {
        get
        {
            if (Request["rnk_tr"] == null)
                return null;
            else 
                return Convert.ToInt64(Request["rnk_tr"]);
        }
    }
    public Boolean closed
    {
        get
        {
            if (Request["closed"] != null)
                return true;
            else
                return false;
        }
    }
    # endregion

    # region События
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void Page_Load(object sender, System.EventArgs e)
    {
        //_dbLogger.Info(String.Format("Запрос inherit_irr_id = {0}", Request.QueryString["inherit_irr_id"]), "deposit");
        if (Deposit.InheritedDeal(Convert.ToString(dpt_id)) && Request.QueryString["inherit_irr_id"] == null)
            throw new DepositException("По депозитному договору є зареєстровані спадкоємці. Дана функція заблокована.");

        if (!IsPostBack)
        {
            _dbLogger.Info(String.Format("Пользователь зашел на страницу оформления доп. соглашений по договору №{0}", dpt_id), "deposit");

            // заголовок
            this.Title = Resources.Deposit.GlobalResources.hDepositAgreement;

            // предзаполненые параметры
            textDptNum.Text = dpt_num;

            //для закритих не відображати нові
            lbNewDopAgr.Visible = !closed;
            

            // инициализация источников данных
            InitDataSources();
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lvAA_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        ListView lvAA = (sender as ListView);
        switch (e.CommandName)
        {
            case "Create":
                Int32 TypeID = Convert.ToInt32(lvAA.DataKeys[(e.Item as ListViewDataItem).DataItemIndex]["TYPE_ID"]);
                String TypeName = Convert.ToString(lvAA.DataKeys[(e.Item as ListViewDataItem).DataItemIndex]["TYPE_NAME"]);

                OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                try
                {
                    if (!CkUnique(dpt_id, TypeID, con))
                    {
                        _dbLogger.Info("Зашли!");
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "CkUnique_Constraint", "alert('Обрана додаткова угода унікальна і вже була сформована! Необхідно спочатку відмінити існуючу додаткову угоду.'); ", true);
                    }
                    else
                    {
                        _dbLogger.Info(String.Format("Пользователь выбрал для формирования доп. соглашение тип={0} для депозитного договора №{1}", TypeID, dpt_id), "deposit");

                        if (TypeID == 4 && !CkCondition(dpt_id, TypeID, con))
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert_check_condition",
                                String.Format("alert('Заборонено формувати дану додаткову угоду для договору №{0}'); ", dpt_id), true);
                            return;
                        }
                        if (TypeID == 35 && !CkConditionIRREVOCABLE(dpt_id, TypeID, con))
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert_check_condition",
                                String.Format("alert('Заборонено формувати дану додаткову угоду для договору №{0}. Сформуйте запит на бек-офіс!'); ", dpt_id), true);
                            return;
                        }
                        if (TypeID == 25)
                        {
                            if (!CkAdditionCondition(dpt_id, TypeID, con))
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert_check_condition",
                                String.Format("alert('Заборонено формувати дану додаткову угоду для договору №{0}! Вклад не передбачає поповнення.'); ", dpt_id), true);
                                return;
                            }
                        }
                        

                        // &name={2}&other={3} // , HttpUtility.UrlEncode(TypeName), other
                        String Url = String.Format("/barsroot/deposit/deloitte/depositcommissionquest.aspx?dpt_id={0}&agr_id={1}", dpt_id, TypeID);
                        
                        if (rnk_tr.HasValue)
                            Url += String.Format("&rnk_tr={0}", rnk_tr);

                        if (scheme == "DELOITTE")
                            Url += String.Format("&scheme={0}", scheme);
                        if (Request.QueryString["inherit_irr_id"] != null)
                            Url += String.Format("&inherit_irr_id={0}", Convert.ToString(Request.QueryString["inherit_irr_id"]));

                        /// Обнуляємо дані про змінні сесії
                        Session["NO_COMISSION"] = String.Empty;
                        Session["REF"] = String.Empty;

                        Response.Redirect(Url);
                    }
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
                break;
        }
    }
    
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lvCA_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        Deposit dpt = new Deposit();
        Decimal AGR_UID = Convert.ToDecimal(lvCA.DataKeys[(e.Item as ListViewDataItem).DataItemIndex]["AGR_UID"]);
    Decimal AGR_TYPE = Convert.ToDecimal(lvCA.DataKeys[(e.Item as ListViewDataItem).DataItemIndex]["AGR_ID"]);


        switch (e.CommandName)
        {
            case "View":
                String AGR_ID = Convert.ToString(lvCA.DataKeys[(e.Item as ListViewDataItem).DataItemIndex]["AGR_ID"]);
                String ADDS = Convert.ToString(lvCA.DataKeys[(e.Item as ListViewDataItem).DataItemIndex]["ADDS"]);
                String TEMPLATE = Convert.ToString(lvCA.DataKeys[(e.Item as ListViewDataItem).DataItemIndex]["TEMPLATE"]);

                Session["DPTPRINT_DPTID"] = dpt_id;
                Session["DPTPRINT_AGRID"] = AGR_ID;
                Session["DPTPRINT_AGRNUM"] = ADDS;
                Session["DPTPRINT_TEMPLATE"] = TEMPLATE;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script_view_ca", "window.open(encodeURI('DepositPrint.aspx?code=' + Math.random()), '_blank', 'height=800, width=800, menubar=no, toolbar=no, location=no, titlebar=no'); ", true);
                break;
            case "Storno":
                if (AGR_TYPE == 8 || AGR_TYPE == 12 || AGR_TYPE == 34)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert_check_condition",
                                 String.Format("alert('Заборонено сторнувати дану додаткову угоду для договору №{0}! Створіть відповідну ДУ.'); ", dpt_id), true);
                    return;
                }
               /* if (AGR_TYPE == 17)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert_check_condition",
                                 String.Format("alert('Заборонено сторнувати дану додаткову угоду для договору №{0}!'); ", dpt_id), true);
                    return;
                }*/
                dpt.ReverseAgreement(AGR_UID);

                //видалення ДУ на регулярного платежу 
                OracleConnection connect = new OracleConnection();
                IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();
                OracleCommand cmd = connect.CreateCommand();

                try
                {
                    String agrId = Convert.ToString(lvCA.DataKeys[(e.Item as ListViewDataItem).DataItemIndex]["AGR_ID"]);
                    cmd.Parameters.Add("p_agr_id", OracleDbType.Decimal, Convert.ToDecimal(agrId), ParameterDirection.Input);
                    cmd.CommandText = "begin sto_all.del_regulartreaty(:p_agr_id);end;";
                    cmd.ExecuteNonQuery();
                }
                finally
                {
                    if (connect.State != ConnectionState.Closed)
                    { connect.Close(); connect.Dispose(); }
                }

                InitDataSources();
                lvCA.DataBind();
                break;
        }
    }
    # endregion

    # region Приватные методы
    /// <summary>
    /// 
    /// </summary>
    private void InitDataSources()
    {
        if (Request.QueryString["inherit_irr_id"] == null)
        {
        if (!closed)//по закритим договорам заборонено формувати ДУ
        {
            // доступные типы ДУ
            sdsAA1.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
            sdsAA1.SelectCommand = @"select dat.type_id, dat.type_name, dat.type_description
                                  from v_dpt_agreements_types dat
                                 where dat.dpt_id = :p_dpt_id
                                   and dat.used_ebp = decode(:p_scheme, 'DELOITTE', 1, dat.used_ebp)
                                 order by dat.type_id";
            sdsAA1.SelectParameters.Clear();
            sdsAA1.SelectParameters.Add("p_dpt_id", DbType.Decimal, Convert.ToString(dpt_id));
            sdsAA1.SelectParameters.Add("p_scheme", DbType.String, scheme);

            sdsAA2.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
            sdsAA2.SelectCommand = @"select dat.type_id, dat.type_name, dat.type_description
                                  from v_dpt_agreements_types dat
                                 where dat.dpt_id = :p_dpt_id
                                   and dat.used_ebp = 2 ";
            sdsAA2.SelectParameters.Clear();
            sdsAA2.SelectParameters.Add("p_dpt_id", DbType.Decimal, Convert.ToString(dpt_id));

            // Створення / Анулювання довіреності довіреною особою заборонено
            if (rnk_tr.HasValue)
                sdsAA2.SelectCommand += " and dat.type_id Not in (12, 13) ";

            sdsAA2.SelectCommand += " order by dat.type_id";

            sdsAA3.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
            sdsAA3.SelectCommand = @"select dat.type_id, dat.type_name, dat.type_description
                                  from v_dpt_agreements_types dat
                                 where dat.dpt_id = :p_dpt_id
                                   and dat.used_ebp = decode(:p_scheme, 'DELOITTE', 3, dat.used_ebp)
                                 order by dat.type_id";
            sdsAA3.SelectParameters.Clear();
            sdsAA3.SelectParameters.Add("p_dpt_id", DbType.Decimal, Convert.ToString(dpt_id));
            sdsAA3.SelectParameters.Add("p_scheme", DbType.String, scheme);
        }
        // текущие ДУ
        sdsCA.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sdsCA.SelectCommand = @"select v.agrmnt_num as adds,
                                       v.agrmnt_date as version,
                                       v.agrmnt_type as agr_id,
                                       v.agrmnt_typename as agr_name,
                                       v.template_id as template,
                                       v.trustee_id as rnk_tr,
                                       v.trustee_name as nmk,
                                       v.comments as comm,
                                       1 as txt, -- !!! доделать на просмотр документов ЕА
                                       v.agrmnt_id as agr_uid,
                                       v.fl_activity as status,
                                       V.DPT_ID AS dpt_id,
                                       EBP.GET_TEMPLATE(V.DPT_ID,V.agrmnt_type,1) AS template_id,
                                       (CASE
                                            WHEN V.agrmnt_type = 7 THEN 222
                                            WHEN V.agrmnt_type = 8 THEN 223
                                            WHEN V.agrmnt_type = 9 THEN 226
                                            WHEN V.agrmnt_type = 12 THEN 222
                                            WHEN V.agrmnt_type = 13 THEN 225
                                            WHEN V.agrmnt_type = 18 THEN 211
                                            WHEN V.agrmnt_type = 38 THEN 611
                                            WHEN V.agrmnt_type = 39 THEN 612
                                            WHEN V.agrmnt_type = 40 THEN 613
                                            ELSE case when v.wb = 'N' then 213 end
                                       END)  AS eastructID,
                                       V.OWNER_ID  as rnk 
                                  from v_dpt_agreements v, cc_docs c
                                 where v.dpt_id = :p_dpt_id
                                   and c.id(+) = v.template_id
                                   and c.nd(+) = v.dpt_id
                                   and c.adds(+) = v.agrmnt_num
                                 order by adds";
        sdsCA.SelectParameters.Clear();
        sdsCA.SelectParameters.Add("p_dpt_id", DbType.Decimal, Convert.ToString(dpt_id));
    }
        else
        { // доступно только ДУ 35 "Дод.договір на дострокове вилучення вкладу за невідкличними депозитами"
            sdsAA1.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
            sdsAA1.SelectCommand = @"select dat.type_id, dat.type_name, dat.type_description
                                  from v_dpt_agreements_types dat
                                 where dat.dpt_id = :p_dpt_id
                                   and dat.used_ebp = decode(:p_scheme, 'DELOITTE', 1, dat.used_ebp)
                                   and dat.type_id in (35, 36)
                                 order by dat.type_id";
            sdsAA1.SelectParameters.Clear();
            sdsAA1.SelectParameters.Add("p_dpt_id", DbType.Decimal, Convert.ToString(dpt_id));
            sdsAA1.SelectParameters.Add("p_scheme", DbType.String, scheme);
        }
    }

    /// <summary>
    /// Проверка возможности оформления
    /// </summary>
    private Boolean CkUnique(Decimal DptID, Int32 AgrTypeID, OracleConnection con)
    {
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandText = @"select f.only_one
                              from v_dpt_agreements v, dpt_vidd_flags f
                             where v.dpt_id = :p_dpt_id
                               and v.agrmnt_type = :p_agrmnt_type
                               and v.fl_activity = 1
                               and v.agrmnt_type = f.id
                               and f.only_one = 1";

        cmd.Parameters.Add("p_dpt_id", OracleDbType.Decimal, DptID, ParameterDirection.Input);
        cmd.Parameters.Add("p_agrmnt_type", OracleDbType.Int32, AgrTypeID, ParameterDirection.Input);

        Boolean res = true;
        using (OracleDataReader rdr = cmd.ExecuteReader())
        {
            res = (!rdr.Read() || Convert.ToInt32(rdr["only_one"]) != 1);
            rdr.Close();
        }

        return res;
    }
    
    /// <summary>
    /// Перевірка:
    /// 1) угода має заключатися мінімум за 5 банківсих днів до дати закінчення договору
    /// 2) вклад має належати продуктам «Депозитний ОБ» та «Строковий Пенсійний»
    /// </summary>
    private Boolean CkCondition(Decimal DptID, Int32 AgrTypeID, OracleConnection con)
    {
        Boolean res = true;
        _dbLogger.Debug(String.Format("Проверка взможности заключения доп. соглашения тип={0} по договору №{1}", AgrTypeID, DptID), "deposit");

        OracleCommand cmd = con.CreateCommand();
        cmd.CommandText = @"select dat_next_u(d.dat_end, -5) as dat
                              from dpt_deposit d
                             where d.deposit_id = :p_dpt_id
                               and d.vidd in (select v.vidd from dpt_vidd v where v.type_id in (2, 10))";
        cmd.Parameters.Add("p_dpt_id", OracleDbType.Decimal, DptID, ParameterDirection.Input);

        OracleDataReader rdr = cmd.ExecuteReader();
        try
        {
            if (!rdr.Read() || rdr["dat"] == DBNull.Value || (DateTime)rdr["dat"] < DateTime.Now.Date)
            {
                res = false;
                _dbLogger.Debug(String.Format("Вибрану дод.угоду по договору №{0} можна формувати", DptID), "deposit");
            }
        }
        finally
        {
            rdr.Close();
            rdr.Dispose();
        }

        return res;
    }
    /// <summary>
    /// Перевірка:
    /// 1) угода по ф.190 не формується для вкладів без поповнення
    /// </summary>
    private bool CkAdditionCondition(Decimal DptID, Int32 AgrTypeID, OracleConnection con)
    {
        Boolean res = true;
        _dbLogger.Debug(String.Format("Проверка взможности заключения доп. соглашения тип={0} по договору №{1}", AgrTypeID, DptID), "deposit");

        OracleCommand cmd = con.CreateCommand();
        cmd.CommandText = @"select nvl(disable_add, 0) 
                              from dpt_deposit d, dpt_vidd dv
                             where d.vidd = dv.vidd
                               and d.deposit_id = :dpt_id";
        cmd.Parameters.Add("p_dpt_id", OracleDbType.Decimal, DptID, ParameterDirection.Input);

        OracleDataReader rdr = cmd.ExecuteReader();
        try
        {
            Decimal mess;
            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                {
                    mess = rdr.GetOracleDecimal(0).Value;

                    if (mess == 0)
                    {
                        _dbLogger.Info("Вибрану додп.угоду по договору №" + dpt_id.ToString() + " можна формувати", "deposit");
                        return true;
                    }
                    {
                        _dbLogger.Info("Вибрану додп.угоду по договору №" + dpt_id.ToString() + " формувати не можна! Договір не передбачає поповнення.", "deposit");
                        return false;
                    }
                }
                return false;
            }
            else
            {
                _dbLogger.Info("Вибрану додп.угоду по договору №" + dpt_id.ToString() + " формувати не можна! Договір не передбачає поповнення.", "deposit");
                return false;
            }
        }
        finally
        {
            rdr.Close();
            rdr.Dispose();
        }
    }

    private Boolean CkConditionIRREVOCABLE(Decimal DptID, Int32 AgrTypeID, OracleConnection con)
    {
        Boolean res = false;
        _dbLogger.Debug(String.Format("Проверка вoзможности заключения доп. соглашения тип=35 по договору №{1}", AgrTypeID, DptID), "deposit");

        OracleCommand cmd = con.CreateCommand();
        cmd.CommandText = @"select dpt_irrevocable(:p_dpt_id) from dual";
        cmd.Parameters.Add("p_dpt_id", OracleDbType.Decimal, DptID, ParameterDirection.Input);

        OracleDataReader rdr = cmd.ExecuteReader();
        try
        {
            if (rdr.Read())
            {
                if (rdr.GetOracleDecimal(0).Value == 1)
                {
                    res = false;
                    _dbLogger.Debug(String.Format("Дод.угоду 35 по договору №{0} не можна формувати {1}", DptID, rdr.GetOracleDecimal(0).Value), "deposit");
                }
                else
                {   res = true; 
                    _dbLogger.Debug(String.Format("Дод.угоду 35 по договору №{0} можна формувати {1}", DptID, rdr.GetOracleDecimal(0).Value), "deposit"); 
                }
            }
        }
        finally
        {
            rdr.Close();
            rdr.Dispose();
        }

        return res;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    protected bool CommandEnabled()
    {
        if (ActionsEnabled.HasValue)
        {
            return ActionsEnabled.Value;
        }
        else
        {
            // якщо в користувача не повний рівень доступу і вклад відкривався по ЕБП
            if ((ClientAccessRights.Get_AccessLevel((rnk_tr.HasValue ? rnk_tr.Value : rnk)) == LevelState.Limited) &&
                (DepositRequest.HasActive((rnk_tr.HasValue ? rnk_tr.Value : rnk), dpt_id) == false) &&
                (Tools.get_EADocID(dpt_id) >= 0))
            {
                if (Request.QueryString["inherit_irr_id"] == null)
                {
                ActionsEnabled = false;
            }
                else { ActionsEnabled = true; }
            }
            else
            {
                ActionsEnabled = true;
            }

            return ActionsEnabled.Value;
        }
    }
    # endregion

    // Повернутися на картку договору
    protected void btnBack_Click(object sender, EventArgs e)
    {
        String url;
        if (Request.QueryString["inherit_irr_id"] != null)
        { url = "/barsroot/clientproducts/DptClientPortfolioContracts.aspx?cust_id=" + Request.QueryString["inherit_irr_id"]; }
        else
        {
            url = "DepositContractInfo.aspx?dpt_id=" + dpt_id.ToString() + "&scheme=DELOITTE";

            // Довірена особа
            if (rnk_tr.HasValue)
                url = url + "&rnk_tr=" + rnk_tr.ToString();
            //договір закрито
            if (closed)
                url = url + "&closed=" + closed.ToString();
        }
        Response.Redirect(url);
    }
}
