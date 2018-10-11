using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using Bars.Classes;
using System.IO;
using System.Web.UI.HtmlControls;
using System.Drawing;
using System.Data;
using BarsWeb.Infrastructure.Helpers;
using Bars.Oracle;
using System.Web.Services;

public partial class finmon_doc : Bars.BarsPage
{
    string Ref = null;
    string ID = null;
    decimal? otm;
    bool allreadyClick = false;
    bool allreadyWas = false;

    #region Consts

    const string FILTER_PARAMS_KEY = "FilterParams";
    const string SELECTEDROWS_KEY = "SELECTEDROWS";
    const string FINMIN_RELOAD_KEY = "FinminReload"; //нужно ли перечитывать данные из БД: 0/1
    const string FINMON_FILTER_APPLYED_KEY = "FinmonFilterApplyed";
    const string RULE_ID_KEY = "rule_id";
    const string PARAMS_REF_KEY = "ParamsRef"; //референс, по которому проставляются параметры ФМ
    const int refFieldidx = 2;
    const int statusFieldidx = 4;
    const int OMFieldidx = 15;
    const int VMFieldidx = 17;
    const string BULK_REFS_KEY = "FinmonBulkRefs";//список референсов для пакетной установке кодов ОМ/ВМ
    private const string CURRENT_PAGE = "currentPage";
    #endregion

    #region Properties

    #region Private

    private List<decimal> BULKSELECTEDROWS
    {
        get
        {
            if (Session[BULK_REFS_KEY] != null)
                return (List<decimal>)Session[BULK_REFS_KEY];
            else
                return new List<decimal>();
        }
        set
        {
            Session[BULK_REFS_KEY] = value;
        }
    }

    private string FilterParams
    {
        get
        {
            if (Session[FILTER_PARAMS_KEY] != null)
                return Session[FILTER_PARAMS_KEY].ToString();
            else
                return "";
        }
        set
        {
            Session[FILTER_PARAMS_KEY] = value;
        }
    }

    private string FinminReload
    {
        get
        {
            if (Session[FINMIN_RELOAD_KEY] != null)
                return Session[FINMIN_RELOAD_KEY].ToString();
            else
                return "";
        }
        set
        {
            Session[FINMIN_RELOAD_KEY] = value;
        }
    }

    public string FinmonFilterApplyed
    {
        get
        {
            if (Session[FINMON_FILTER_APPLYED_KEY] != null)
                return Session[FINMON_FILTER_APPLYED_KEY].ToString();
            else
                return "";
        }
        set
        {
            Session[FINMON_FILTER_APPLYED_KEY] = value;
        }
    }

    private List<int> SELECTEDROWS
    {
        get
        {
            if (Session[SELECTEDROWS_KEY] != null)
                return (List<int>)Session[SELECTEDROWS_KEY];
            else
                return new List<int>();
        }
        set
        {
            Session[SELECTEDROWS_KEY] = value;
        }
    }

    #endregion

    #region Public

    public string RULE_ID
    {
        get
        {
            if (Session[RULE_ID_KEY] != null)
                return Session[RULE_ID_KEY].ToString();
            else
                return "";
        }
        set
        {
            Session[RULE_ID_KEY] = value;
        }
    }


    #endregion

    #endregion

    /// <summary>
    /// Выполняет запрос, населяя основной грид формы
    /// </summary>
    private void FillData()
    {
        odsFmDocs.DataBind();

        ///Чистимо всі кастомні фільтри перед байндом гріда (байнд не викликається)--------------
        odsFmDocs.WhereStatement = null;
        //gvFmDocs.FilterState = new System.Collections.Generic.List<Bars.DataComponents.Filter>();
        gvFmDocs.FilterState.Clear();
        gvFmDocs.ApplyFilters();
        //---------------------------------------------------------------------------------------

        //gvFmDocs.DataBind();
        gvFmDocs.AllowPaging = true;
        gvFmDocs.DataBind();
        //var opcnt = GetOperCount();
        //if (Convert.ToDecimal(opcnt) == 100000)
        //{
        //    lblOperCount.Text = "Увага! Стоїть обмеження на відображення даних (до 100 тис. записів). Для пошуку використовуйте додаткові фільтри";
        //    lblOperCount.ForeColor = Color.Red;
        //    //return;
        //}
        //else
        //{
        //    lblOperCount.Text = "Всього документів: " + opcnt.ToString();
        //    lblOperCount.ForeColor = Color.Black;
        //}
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        ClientScript.GetPostBackEventReference(this, string.Empty);//This is important to make the "__doPostBack()" method, works properly

        if (allreadyClick)
        {
            allreadyClick = false;
        }

        switch (Request.Form["__EVENTTARGET"])
        {
            case "ibtClearFilterParams":
                {
                    ibtClearFilterParams_Click(this, new EventArgs());
                    break;
                }
        }

        string access = Request.QueryString["access"];
        if (!string.IsNullOrEmpty(access) && access == "assignee")
        {
            ibtExclude.Visible = true;
            ibtUnblock.Visible = true;
            ibtSend.Visible = true;
            ibtSetAside.Visible = true;
        }
        else
        {
            ibtExclude.Visible = false;
            ibtUnblock.Visible = false;
            ibtSend.Visible = false;
            ibtSetAside.Visible = false;
        }
        ibtSetParams.Visible = true; //разлочим пока для всех, потом надо будет закрыть в зависимости от АРМа

        if (!IsPostBack)
        {
            ViewState["ShowExportExcelButton"] = false;

            Session[PARAMS_REF_KEY] = "";

            FilterParams = string.Empty;

            var rnd = DateTime.Now;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "filterOpen('" + rnd + "');", true);

            string yestr;
            InitOraConnection();
            try
            {
                yestr = SQL_SELECT_list("select to_char(bars.DAT_NEXT_U(bars.web_utl.get_bankdate,-1),'dd/mm/yyyy') from dual");
            }
            finally
            {
                DisposeOraConnection();
            }

            lbDat.Text = "Період відбору документів з " + yestr.ToString().Substring(0, 10).Replace("/", ".") + " по " + yestr.ToString().Substring(0, 10).Replace("/", ".");

            if (null != Session["selectParam".ToString()])
            {
                string ppp = Session["selectParam"].ToString();

                Session["selectParam"] = "0";
            }
            Session["FinmonDat1"] = null;
            Session["FinmonDat2"] = null;
            Session["FinmonStatuses"] = "0";
            Session["FinmonBlockedDocs"] = "0";
            Session[CURRENT_PAGE] = null;

            FillData();
        }
        else
        {
            FillGrid();
            updateRowRendering();
        }

        if (FinmonFilterApplyed == "1")
        {
            gvFmDocs.Sort(string.Empty, SortDirection.Ascending);
            gvFmDocs.DataSourceID = string.Empty;
            gvFmDocs.DataBind();
        }
        else
        {
            gvFmDocs.DataSourceID = "odsFmDocs";
        }

        if (FinminReload == "1")
        {
            FillData();
            FinminReload = "0";
        }
    }


    public int[] GetChecked()
    {
        return SELECTEDROWS.ToArray();
    }


    private void SetSelectedRows()
    {
        if (!allreadyWas)
        {
            allreadyWas = true;

            List<int> temp = new List<int>();

            foreach (GridViewRow row in gvFmDocs.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox cb = (CheckBox)row.Cells[0].Controls[1];
                    if (cb.Checked)
                    {
                        temp.Add(row.RowIndex);
                    }
                }
            }
            SELECTEDROWS = temp;
        }
    }

    /// <summary>
    /// Конструирует (не выполняя) запрос, населяющий грид формы. 
    /// </summary>
    private void FillGrid()
    {
        gvFmDocs.PageIndex = 0;

        decimal? selectParam;
        string selectCommand = null;
        string dat1 = "01.01.1500";
        string dat2 = "01.01.1500";

        SetSelectedRows();

        if (null != Session["FinmonDat1"])
        {
            dat1 = Session["FinmonDat1"].ToString().Substring(0, 10).Replace("/", ".");
        }
        if (null != Session["FinmonDat2"])
        {
            dat2 = Session["FinmonDat2"].ToString().Substring(0, 10).Replace("/", ".");
        }
        selectParam = Convert.ToDecimal(Session["selectParam"]);

        odsFmDocs.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        odsFmDocs.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("");
        odsFmDocs.SelectParameters.Clear();
        odsFmDocs.WhereParameters.Clear();

        odsFmDocs.SortExpression = gvFmDocs.SortExpression;

        string status = "";
        if ("0" != Session["FinmonStatuses"].ToString())
        {
            int c = Session["FinmonStatuses"].ToString().Length;
            if (c > 1)
            {
                status = " Статус документів " + Session["FinmonStatuses"].ToString().Substring(0, c - 1).Replace("'", "");
            }
            else
            {
                status = "";
            }
            lbStatus.Text = status;
        }
        else
        {
            lbStatus.Text = "";
        }

        if (selectParam == 1)
        {
            if (dat1 != "01.01.1500")
            {

                tblDat.Visible = true;
                lbDat.Text = Session["FinmonSelectedStatus"].ToString();

            }
            selectCommand = @"select v_finmon_que_oper.id,
                                   v_finmon_que_oper.ref,
                                   v_finmon_que_oper.tt,
                                   v_finmon_que_oper.nd,
                                   to_char(v_finmon_que_oper.datd,'dd.mm.yyyy') datd,
                                   v_finmon_que_oper.nlsa,
                                   v_finmon_que_oper.s/100 s,
                                   v_finmon_que_oper.sq/100 sq,
                                   v_finmon_que_oper.lcv,
                                   v_finmon_que_oper.mfoa,
                                   v_finmon_que_oper.dk,
                                   v_finmon_que_oper.nlsb,
                                   v_finmon_que_oper.s2/100 s2,
                                   v_finmon_que_oper.sq2/100 sq2,
                                   v_finmon_que_oper.lcv2,
                                   v_finmon_que_oper.mfob,
                                   v_finmon_que_oper.sk,
                                   to_char(v_finmon_que_oper.vdat,'dd.mm.yyyy') vdat,
                                   v_finmon_que_oper.nazn,
                                   v_finmon_que_oper.status,
                                   decode(v_finmon_que_oper.otm,0,null,v_finmon_que_oper.otm) otm,
                                   v_finmon_que_oper.tobo,
                                   v_finmon_que_oper.opr_vid2,
                                   v_finmon_que_oper.opr_vid3,
                                   v_finmon_que_oper.fio,
                                   to_char(v_finmon_que_oper.in_date,'dd.mm.yyyy hh:mi:ss') in_date,
                                   v_finmon_que_oper.comments,
                                   t.rules,
                                   s.name status_name,
                                   v_finmon_que_oper.nmka,
                                   v_finmon_que_oper.nmkb,
                                   v_finmon_que_oper.sos,
                                   v_finmon_que_oper.fv2_agg,
                                   case when tt.ref is not null then 1 else 0 end on3720
                                 from v_finmon_que_oper  
                                 join tmp_fm_checkrules t on v_finmon_que_oper.ref = t.ref
                                 left join finmon_que_status s on v_finmon_que_oper.status = s.status
                                 left join t902 tt on tt.ref = v_finmon_que_oper.ref
                                 where t.id = bars.user_id()
                                 and ROWNUM <= 100000              
                                 ";
        }

        if (selectParam == 0)
        {
            if (dat1 != "01.01.1500")
            {

                tblDat.Visible = true;
                lbDat.Text = Session["FinmonSelectedStatus"].ToString();

            }
            selectCommand = @"select v_finmon_que_oper.id,
                                   v_finmon_que_oper.ref,
                                   v_finmon_que_oper.tt,
                                   v_finmon_que_oper.nd,
                                   to_char(v_finmon_que_oper.datd,'dd.mm.yyyy') datd,
                                   v_finmon_que_oper.nlsa,
                                   v_finmon_que_oper.s/100 s,
                                   v_finmon_que_oper.sq/100 sq,
                                   v_finmon_que_oper.lcv,
                                   v_finmon_que_oper.mfoa,
                                   v_finmon_que_oper.dk,
                                   v_finmon_que_oper.nlsb,
                                   v_finmon_que_oper.s2/100 s2,
                                   v_finmon_que_oper.sq2/100 sq2,
                                   v_finmon_que_oper.lcv2,
                                   v_finmon_que_oper.mfob,
                                   v_finmon_que_oper.sk,
                                   to_char(v_finmon_que_oper.vdat,'dd.mm.yyyy') vdat,
                                   v_finmon_que_oper.nazn,
                                   v_finmon_que_oper.status,
                                   decode(v_finmon_que_oper.otm,0,null,v_finmon_que_oper.otm) otm,
                                   v_finmon_que_oper.tobo,
                                   v_finmon_que_oper.opr_vid2,
                                   v_finmon_que_oper.opr_vid3,
                                   v_finmon_que_oper.fio,
                                   to_char(v_finmon_que_oper.in_date,'dd.mm.yyyy hh:mi:ss') in_date,
                                   v_finmon_que_oper.comments,
                                   null rules,
                                   s.name status_name,
                                   v_finmon_que_oper.nmka,
                                   v_finmon_que_oper.nmkb,
                                   v_finmon_que_oper.sos,
                                   v_finmon_que_oper.fv2_agg,
                                   case when tt.ref is not null then 1 else 0 end on3720
                          from v_finmon_que_oper 
                          left join finmon_que_status s on v_finmon_que_oper.status = s.status
                          left join t902 tt on tt.ref = v_finmon_que_oper.ref
                           where v_finmon_que_oper.vdat between to_date(decode('" + dat1 + "','01.01.1500',to_char(bars.DAT_NEXT_U(bars.web_utl.get_bankdate,-1),'dd.mm.yyyy'),'" + dat1 + "'),'dd.mm.yy') and to_date(decode('" + dat2 + "','01.01.1500',to_char(bars.DAT_NEXT_U(bars.web_utl.get_bankdate,-1),'dd.mm.yyyy'),'" + dat2 + "'),'dd.mm.yy') and ROWNUM <= 100000";
        }

        string p_status = Session["FinmonStatuses"].ToString();

        string p_block = Session["FinmonBlockedDocs"].ToString();
        // фильтр по заблокированным документам будет работать только отдельно от других статусов; TODO
        if ("0" != p_status)
        {
            int x = Session["FinmonStatuses"].ToString().Length;

            string statuses = Session["FinmonStatuses"].ToString().Remove(x - 1);

            selectCommand += " and ( v_finmon_que_oper.status in (" + statuses + ") " + (statuses.IndexOf("-") != -1 ? " or v_finmon_que_oper.status is null " : "") + " )";
        }

        if (p_block != "0")
        {
            selectCommand += " and to_number(v_finmon_que_oper.otm) != 0 ";
        }

        string filterValue = Request.QueryString["filter"];
        if (!string.IsNullOrEmpty(filterValue))
        {
            switch (filterValue)
            {
                case "subdivision":
                    selectCommand += " and exists (select 1 from v_fm_func_kontr where ref = v_finmon_que_oper.ref)";
                    Title.Text = "Відбір документів [ДОКУМЕНТИ ПІДРОЗДІЛУ]";
                    break;
                case "user":
                    selectCommand += " and exists (select 1 from v_fm_func_oper where ref = v_finmon_que_oper.ref)";
                    Title.Text = "Відбір документів [СВОЇ ДОКУМЕНТИ]";
                    break;
                case "input":
                    selectCommand += " and exists (SELECT R.REF FROM V_OPER_DEPARTMENT R WHERE R.REF=v_finmon_que_oper.REF and v_finmon_que_oper.TT='R01')";
                    Title.Text = "Відбір документів [ВХІДНІ ДОКУМЕНТИ]";
                    break;
                default:
                    break;
            }
        }
        else
        {
            Title.Text = "Відбір документів [ВСІ ДОКУМЕНТИ]";
        }

        if (!string.IsNullOrEmpty(FilterParams))
        {
            selectCommand += " and (" + FilterParams + ")";
        }

        HttpContext.Current.Session["SelectCommand"] = selectCommand;
        odsFmDocs.SelectCommand = selectCommand;
    }

    /// <summary>
    /// Раскраска грида в зависимости от состояния документа
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            int sos = int.Parse(DataBinder.Eval(e.Row.DataItem, "SOS").ToString());
            string nlsa = DataBinder.Eval(e.Row.DataItem, "NLSA").ToString();
            string nlsb = DataBinder.Eval(e.Row.DataItem, "NLSB").ToString();

            bool isOn3720 = Convert.ToInt16(DataBinder.Eval(e.Row.DataItem, "on3720")) == 1;

            foreach (TableCell cell_ in e.Row.Cells)
            {
                if (isOn3720)
                {
                    cell_.ForeColor = Color.Green;
                }
                else
                {
                    if (sos == -2)
                    {
                        cell_.ForeColor = Color.Brown;
                    }
                    if (sos == -1)  //сторнировано
                    {
                        cell_.ForeColor = Color.Red;
                    }
                    if (sos == 0)
                    {
                        cell_.ForeColor = Color.Blue;
                    }
                    if (sos == 1)
                    {
                        cell_.ForeColor = Color.Green;
                    }
                    if (sos == 3)
                    {
                        cell_.ForeColor = Color.DarkBlue;
                    }
                    if (sos == 5)  //оплачено
                    {
                        cell_.ForeColor = Color.Black;
                    }

                    if ((nlsa.StartsWith("3720") || nlsb.StartsWith("3720")) && sos != 5)
                    {
                        cell_.ForeColor = Color.Green;
                    }
                }
            }

            string cell = DataBinder.Eval(e.Row.DataItem, "REF").ToString();
            e.Row.Attributes.Add("ondblclick", "openDoc('" + cell + "')");
        }
    }
    /// <summary>
    /// Перечитать данные в датасорсе согласно установленным фильтрам (установка флага). После этого в постбэке будет перечитка и наполнение грида
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ibtRefreshData_Click(object sender, EventArgs e)
    {
        FinminReload = "1";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "RefreshData();", true);
    }

    /// <summary>
    /// Открыть карточку выбранного документа
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btOpen_Click(object sender, EventArgs e)
    {
        if (gvFmDocs.SelectedRows.Count != 0)
        {

            string Ref = Convert.ToString(gvFmDocs.DataKeys[gvFmDocs.SelectedRows[0]].Value);
            var md = "window.showModalDialog('/barsroot/documentview/default.aspx?ref=" + Ref + "','document','dialogwidth=800px,dialogheight=650px');";

            ScriptManager.RegisterStartupScript(this, this.GetType(), "document", md, true);

        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного рядка');", true);
        }
    }
    /// <summary>
    /// Вызов диалога сообщения (обычного, с умолчательными параметрами ФМ) об операциях. Передаются все отмеченные.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btSetStatus_Click(object sender, EventArgs e)
    {
        string p_ref = "";
        int p_count = 0;
        var ids = GetChecked();
        var r = gvFmDocs.GetSelectedIndices();

        foreach (int row in ids)
        {
            var s = gvFmDocs.DataKeys[row]["STATUS"].ToString();
            var d = gvFmDocs.DataKeys[row]["OTM"].ToString();

            if (String.IsNullOrEmpty(gvFmDocs.DataKeys[row]["STATUS"].ToString())
                && gvFmDocs.DataKeys[row]["OTM"].ToString().Length == 0)
            /*|| (gvFmDocs.DataKeys[row]["STATUS"].ToString() == "S" 
            || gvFmDocs.DataKeys[row]["STATUS"].ToString() == "B"))*/
            {
                p_count = p_count + 1;
                p_ref += gvFmDocs.DataKeys[row]["REF"].ToString() + "-";
            }
        }

        if (p_count > 0)
        {
            Session["statusOpen_par"] = p_count + ":" + p_ref;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "statusOpen();", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного рядка або всі відмічені документи мають статус ``Повідомлено``');", true);
        }
    }
    /// <summary>
    /// Разблокировка отмеченных документов
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btUnblock_Click(object sender, EventArgs e)
    {
        int counter = 0;
        var ids = GetChecked();

        if (ids.Length != 0)
        {
            foreach (int row in ids)
                Unblock(row, ref counter);
        }
        else if (gvFmDocs.SelectedRows.Count != 0)
            Unblock(gvFmDocs.SelectedRows[0], ref counter);
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного рядка');", true);
            return;
        }

        if (counter > 0)
        {
            FillGrid();
            FillData();
        }
    }

    protected void Unblock(int row, ref int counter)
    {
        if (Convert.ToString(gvFmDocs.DataKeys[row].Value) != null)
        {
            var record = gvFmDocs.DataKeys[row];

            otm = record["OTM"].ToString().Length > 0 ? Convert.ToDecimal(record["OTM"]) : 0;

            if (otm != 0)
            {
                InitOraConnection();
                try
                {
                    ClearParameters();
                    var pRef = Convert.ToDecimal(gvFmDocs.DataKeys[row]["REF"]);
                    SetParameters("p_ref", DB_TYPE.Decimal, pRef, DIRECTION.Input);
                    SQL_NONQUERY("begin p_fm_unblock(:p_ref,null); end;");
                }
                finally
                {
                    DisposeOraConnection();
                }
                counter++;
            }
        }
    }

    /// <summary>
    /// Вызов диалога параметров ФМ для выбраной строки
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btSetParams_Click(object sender, EventArgs e)
    {
        if (gvFmDocs.SelectedRows.Count != 0)
        {
            if (Convert.ToString(gvFmDocs.DataKeys[gvFmDocs.SelectedRows[0]].Value) != null)
            {

                Ref = gvFmDocs.DataKeys[gvFmDocs.SelectedRows[0]]["REF"].ToString();
                ID = gvFmDocs.DataKeys[gvFmDocs.SelectedRows[0]]["ID"].ToString();
                var rnd = DateTime.Now;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "paramsOpen('" + Ref + "','" + ID + "','" + rnd + "');", true);
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного рядка');", true);
        }
    }
    /// <summary>
    /// Вызов окна пакетного проставление кодов ОМ, ВМ для всех выбранных операций.
    /// Параметры передаются коллекцией из референсов в сессию.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btBulkSetParams_Click(object sender, EventArgs e)
    {
        if (GetChecked().Length == 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного рядка');", true);
            return;
        }
        BULKSELECTEDROWS.Clear();
        List<decimal> tmp = new List<decimal>();
        foreach (int row in GetChecked())
        {
            tmp.Add(Convert.ToDecimal(gvFmDocs.DataKeys[row]["REF"]));
        }
        BULKSELECTEDROWS = tmp;
        var rnd = DateTime.Now;
        ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "paramsBulkOpen('" + rnd + "');", true);
    }

    /// <summary>
    /// Устанавливает визуальный статус "Повідомлено" и параметры ОМ, ВМ документу по референсу из сессии. Нужно, чтобы отразить изменения в гриде после проставления параметров ФМ (docparams), но не делать запрос к БД.
    /// </summary>
    protected void updateRowRendering()
    {
        string[] reference = null;
        if (Session[PARAMS_REF_KEY] != null && Session[PARAMS_REF_KEY] != "")
            reference = (string[])Session[PARAMS_REF_KEY];
        if (reference != null && reference.Length != 0)
        {
            foreach (GridViewRow row in gvFmDocs.Rows)
            {
                if (row.Cells[refFieldidx].Text == reference[0])
                {
                    if (row.Cells[statusFieldidx].Text == "" || row.Cells[statusFieldidx].Text == "&nbsp;")
                    {
                        row.Cells[statusFieldidx].Text = "Повідомлено"; //меняем отображение статуса до следующего обновления датасорса
                    }
                    row.Cells[OMFieldidx].Text = reference[1];
                    row.Cells[VMFieldidx].Text = reference[2];
                    Session[PARAMS_REF_KEY] = null;
                    break;
                }
            }
        }
    }

    protected void tbRefTerorists_Click(object sender, EventArgs e)
    {
        if (gvFmDocs.SelectedRows.Count != 0)
        {
            if (Convert.ToString(gvFmDocs.DataKeys[gvFmDocs.SelectedRows[0]].Value) != null)
            {

                if (gvFmDocs.DataKeys[gvFmDocs.SelectedRows[0]]["OTM"].ToString().Length > 0)
                {
                    otm = Convert.ToDecimal(gvFmDocs.DataKeys[gvFmDocs.SelectedRows[0]]["OTM"]);
                }
                else
                {
                    otm = 0;
                }

                if (otm != 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "RefTeroristsOpen('" + otm + "');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "alert('Немає даних для відображення.');", true);
                }
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного рядка');", true);
        }
    }

    protected void btSend_Click(object sender, EventArgs e)
    {
        if (GetChecked().Length == 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного рядка');", true);
            return;
        }
        InitOraConnection();
        try
        {
            foreach (int row in GetChecked())
            {
                string st = gvFmDocs.DataKeys[row]["STATUS"].ToString();
                string otm = gvFmDocs.DataKeys[row]["STATUS"].ToString();

                if ((String.IsNullOrEmpty(st) && otm.Length > 0)
                    || (!String.IsNullOrEmpty(st) && st == "I")
                    || (!String.IsNullOrEmpty(st) && st == "S"))
                {
                    ClearParameters();
                    SetParameters("p_ref", DB_TYPE.Decimal, Convert.ToDecimal(gvFmDocs.DataKeys[row]["REF"]), DIRECTION.Input);
                    var status = gvFmDocs.DataKeys[row]["OTM"].ToString().Length > 0 ? "T" : "N";
                    SetParameters("p_status", DB_TYPE.Varchar2, status, DIRECTION.Input);
                    SetParameters("p_comm", DB_TYPE.Varchar2, "", DIRECTION.Input);
                    SQL_NONQUERY("begin p_fm_set_status(:p_ref,null,:p_status,:p_comm,null); end;");
                }
            }
        }
        finally
        {
            DisposeOraConnection();
            FillGrid();
            FillData();
        }
    }
    protected void btExclude_Click(object sender, EventArgs e)
    {
        if (GetChecked().Length == 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного рядка');", true);
            return;
        }
        InitOraConnection();
        try
        {
            foreach (int row in GetChecked())
            {
                if (String.IsNullOrEmpty(gvFmDocs.DataKeys[row]["STATUS"].ToString())
                    || (gvFmDocs.DataKeys[row]["STATUS"].ToString() == "I")
                    || (gvFmDocs.DataKeys[row]["STATUS"].ToString() == "S")
                    || (gvFmDocs.DataKeys[row]["STATUS"].ToString() == "N"))
                {
                    ClearParameters();
                    SetParameters("p_ref", DB_TYPE.Decimal, Convert.ToDecimal(gvFmDocs.DataKeys[row]["REF"]), DIRECTION.Input);
                    SetParameters("p_status", DB_TYPE.Varchar2, "B", DIRECTION.Input);
                    SetParameters("p_comm", DB_TYPE.Varchar2, "", DIRECTION.Input);
                    SQL_NONQUERY("begin p_fm_set_status(:p_ref,null,:p_status,:p_comm,null); end;");
                }
            }
        }
        finally
        {
            DisposeOraConnection();
            FillGrid();
            FillData();
        }

    }
    protected void btSetAside_Click(object sender, EventArgs e)
    {
        if (GetChecked().Length == 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного рядка');", true);
            return;
        }
        InitOraConnection();
        try
        {
            foreach (int row in GetChecked())
            {
                if (String.IsNullOrEmpty(gvFmDocs.DataKeys[row]["STATUS"].ToString())
                    || (gvFmDocs.DataKeys[row]["STATUS"].ToString() == "I")
                    || (gvFmDocs.DataKeys[row]["STATUS"].ToString() == "B")
                    || (gvFmDocs.DataKeys[row]["STATUS"].ToString() == "N"))
                {
                    ClearParameters();
                    SetParameters("p_ref", DB_TYPE.Decimal, Convert.ToDecimal(gvFmDocs.DataKeys[row]["REF"]), DIRECTION.Input);
                    SetParameters("p_status", DB_TYPE.Varchar2, "S", DIRECTION.Input);
                    SetParameters("p_comm", DB_TYPE.Varchar2, "", DIRECTION.Input);
                    SQL_NONQUERY("begin p_fm_set_status(:p_ref,null,:p_status,:p_comm,null); end;");
                }
            }
        }
        finally
        {
            DisposeOraConnection();
            FillGrid();
            FillData();

        }
    }

    [WebMethod]
    public static void SetFilterApplyed()
    {
        HttpContext.Current.Session[FINMON_FILTER_APPLYED_KEY] = "1";
    }

    [WebMethod]
    public static decimal OperCount()
    {
        string SelectCommand = HttpContext.Current.Session["SelectCommand"] as string;
        decimal opcnt = 0;
        if (!string.IsNullOrEmpty(SelectCommand))
        {
            int queOperIdIndex = SelectCommand.IndexOf("v_finmon_que_oper.id");
            int queOperIndex = SelectCommand.IndexOf("from v_finmon_que_oper");
            string filterSql = SelectCommand.Replace(SelectCommand.Substring(
                                                queOperIdIndex,
                                                queOperIndex - queOperIdIndex
                                            ), " count(*) ");


            OracleConnection _connect = null;
            try
            {
                var icon = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
                _connect = icon.GetUserConnection(HttpContext.Current);

                using (var cmd = _connect.CreateCommand())
                {
                    cmd.CommandText = filterSql;
                    using (var reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            object temp = reader.GetValue(0);
                            opcnt = Convert.ToDecimal(temp);
                        }
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                if (_connect != null)
                {
                    if (_connect.State != ConnectionState.Closed)
                    {
                        _connect.Close();
                    }
                    _connect.Dispose();
                    _connect = null;
                }
            }
        }

        return opcnt;
    }

    public string GetOperCount()
    {
        gvFmDocs.AllowPaging = false;
        gvFmDocs.DataBind();
        string count = gvFmDocs.Rows.Count.ToString();
        gvFmDocs.AllowPaging = true;
        gvFmDocs.DataBind();
        return count;
    }

    protected void ibtRulesFilter_Click(object sender, EventArgs e)
    {
        var rnd = DateTime.Now;
        ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "filterOpen('" + rnd + "');", true);
    }
    protected void ibStatusFilter_Click(object sender, EventArgs e)
    {
        var rnd = DateTime.Now;
        ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "filterStatusOpen('" + rnd + "');", true);
    }

    protected void ibChangeHistory_Click(object sender, EventArgs e)
    {
        if (gvFmDocs.SelectedRows.Count != 0)
        {
            if (Convert.ToString(gvFmDocs.DataKeys[gvFmDocs.SelectedRows[0]].Value) != null)
            {
                Ref = gvFmDocs.DataKeys[gvFmDocs.SelectedRows[0]]["REF"].ToString();
                ID = gvFmDocs.DataKeys[gvFmDocs.SelectedRows[0]]["ID"].ToString();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "changeHistoryOpen('" + Ref + "','" + ID + "');", true);
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного рядка');", true);
        }
    }

    protected void ibtGetFilters_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "openFilters('" + Ref + "','" + ID + "');", true);
    }

    protected void ibtExportAllPages_Click(object sender, EventArgs e)
    {
        //ibtExportAllPages.UseSubmitBehavior = false;
        //ibtExportAllPages.OnClientClick = "_spFormOnSubmitCalled = false; _spSuppressFormOnSubmitWrapper=true;";
        ExportToExcel();
    }

    private void PrepareControlForExport(Control control)
    {
        for (int i = 0; i < control.Controls.Count; i++)
        {
            Control control2 = control.Controls[i];
            if (control2 is LinkButton)
            {
                control.Controls.Remove(control2);
                control.Controls.AddAt(i, new LiteralControl((control2 as LinkButton).Text));
            }
            else if (control2 is ImageButton)
            {
                control.Controls.Remove(control2);
                control.Controls.AddAt(i, new LiteralControl((control2 as ImageButton).AlternateText));
            }
            else if (control2 is HyperLink)
            {
                control.Controls.Remove(control2);
                control.Controls.AddAt(i, new LiteralControl((control2 as HyperLink).Text));
            }
            else if (control2 is DropDownList)
            {
                control.Controls.Remove(control2);
                control.Controls.AddAt(i, new LiteralControl((control2 as DropDownList).SelectedItem.Text));
            }
            else if (control2 is CheckBox)
            {
                control.Controls.Remove(control2);
                control.Controls.AddAt(i, new LiteralControl((control2 as CheckBox).Checked ? "1" : "0"));
            }
            else if (control2 is HtmlInputCheckBox)
            {
                control.Controls.Remove(control2);
                control.Controls.AddAt(i, new LiteralControl((control2 as HtmlInputCheckBox).Checked ? "1" : "0"));
            }
            if (control2.HasControls())
            {
                this.PrepareControlForExport(control2);
            }
        }
    }


    public void ExportToExcel()
    {
        string fileXls = string.Empty;
        try
        {
            HttpContext.Current.Response.Clear();
            //HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "table.xls"));
            //HttpContext.Current.Response.ContentType = "application/ms-excel";
            //HttpContext.Current.Response.Write("<meta http-equiv=Content-Type content=\"text/html; charset=utf-8\">");

            DataTable dt = new DataTable();
            DataSourceSelectArguments args = new DataSourceSelectArguments();
            DataView dv = new DataView();
            dv = (DataView)odsFmDocs.Select(args);
            dt = dv.ToTable();

            //string[] BDHeaders = { "REF", "TT", "ND", "DATD", "NLSA", "S", "SQ", "LCV", "MFOA", "DK", "NLSB", "S2", "SQ2", "LCV2", "MFOB", "SK", "VDAT", "NAZN", "STATUS", "OTM", "TOBO", "OPR_VID2", "OPR_VID3", "FIO", "IN_DATE", "COMMENTS", "RULES", "STATUS_NAME", "NMKA", "NMKB", "SOS", "FV2_AGG" };

            //string [] Headers = { "Реф.","Статус","Оп.","Номер док.","Дата док.","Рахунок-А","МФО-А","Рахунок-Б","МФО-Б","Сума","Сума док. (екв.)","Вал.-А","Ознака ОМ","Дотатковы коди ОМ","Ознака БМ","СКП","Призначення","Д/К","Сума-Б","Сума-Б (екв.)","Вал.-Б","Дата вал.","Відділення","Повідомив","Дата реєстрації","Коментар", "№ особи в переліку осіб", "Клієнт-А","Клієнт-Б"};

            DataView view = new DataView(dt);
            DataTable ds = view.ToTable(true, "REF", "TT", "ND", "DATD", "NLSA", "S", "SQ", "LCV", "MFOA", "DK", "NLSB", "S2", "SQ2", "LCV2", "MFOB", "SK", "VDAT", "NAZN", "STATUS", "OTM", "TOBO", "OPR_VID2", "OPR_VID3", "FIO", "IN_DATE", "COMMENTS", "STATUS_NAME", "NMKA", "NMKB", "SOS", "FV2_AGG");

            for (int i = 2; i < gvFmDocs.Columns.Count; i++)
            {
                BoundField bf = (BoundField)gvFmDocs.Columns[i];
                for (int j = 0; j < ds.Columns.Count; j++)
                {
                    if (ds.Columns[j].ColumnName == bf.DataField)
                    {
                        ds.Columns[j].ColumnName = bf.HeaderText;
                        break;
                    }
                }
            }

            List<string> moneyWildcards = new List<string> { "оборот", "кредит", "дебет", "залишок", "сума", "S", "S2", "SQ", "SQ2" };

            List<int> moneyColumns = new List<int>();
            for (int i = 0, max = ds.Columns.Count; i < max; i++)
            {
                foreach (var mw in moneyWildcards)
                {
                    if (ds.Columns[i].Caption.ToLower().Contains(mw.ToLower()))
                    {
                        moneyColumns.Add(i + 1);
                    }
                }
            }

            var rep = new RegisterCountsDPARepository();
            var userInf = rep.GetPrintHeader();

            fileXls = Path.GetTempFileName() + ".xls";

            List<Dictionary<string, object>> res = new List<Dictionary<string, object>>();

            for (int i = 0; i < ds.Rows.Count; i++)
            {
                Dictionary<string, object> row = new Dictionary<string, object>();
                for (int j = 0; j < ds.Columns.Count; j++)
                {
                    string key = ds.Columns[j].Caption;
                    var value = ds.Rows[i][j];
                    row[key] = value;
                }
                res.Add(row);
            }

            List<string[]> fileContentHat = new List<string[]>();
            for (int i = 0; i < ds.Columns.Count; i++)
            {
                fileContentHat.Add(new string[] { ds.Columns[i].ColumnName, ds.Columns[i].Caption });
            }

            List<TableInfo> tableInfo = new List<TableInfo>();
            for (int i = 0; i < ds.Columns.Count; i++)
            {
                string colDataType = string.Empty;
                int excelRowNum = i + 1;
                if (moneyColumns.Contains(excelRowNum))
                {
                    colDataType = "Money";
                }
                else
                {
                    colDataType = ds.Columns[i].DataType.FullName;
                }

                tableInfo.Add(new TableInfo(ds.Columns[i].ColumnName, ds.Columns[i].MaxLength, colDataType, ds.Columns[i].AllowDBNull));
            }

            List<string> hat = new List<string>
                    {
                        "АТ 'ОЩАДБАНК'",
                        "Користувач:" + userInf.USER_NAME,
                        "Дата: " + userInf.DATE.ToString("dd'.'MM'.'yyyy") + " Час: " + userInf.DATE.Hour + ":" + userInf.DATE.Minute + ":" + userInf.DATE.Second
                    };

            var excel = new ExcelHelpers<List<Dictionary<string, object>>>(res, fileContentHat, tableInfo, null, hat);

            using (MemoryStream ms = excel.ExportToMemoryStream())
            {
                ms.Position = 0;
                File.WriteAllBytes(fileXls, ms.ToArray());
            }

            HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachnent;filename=" + fileXls);

            HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
            HttpContext.Current.Response.WriteFile(fileXls);
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.Close();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            try
            {
                File.Delete(fileXls);
            }
            catch (Exception)
            {
            }
        }
    }


    protected void ibtClearFilterParams_Click(object sender, EventArgs e)
    {
        if (!allreadyClick)
        {
            allreadyClick = true;
            ClearCustomFilter();
        }
    }
    /// <summary>
    /// Очистка пользовательских фильтров. Фильтры по статусам и правилам ФМ остаются
    /// </summary>
    private void ClearCustomFilter()
    {
        //Session["FinmonStatuses"] = "0";
        //Session["FinmonBlockedDocs"] = "0";

        odsFmDocs.WhereStatement = null;
        gvFmDocs.ShowFilter = false;
        gvFmDocs.FilterState.Clear();
        gvFmDocs.ApplyFilters();

        if (!string.IsNullOrEmpty(FilterParams))
        {
            FilterParams = string.Empty;
        }

        //if (FinminReload == "0")
        //{
        //    FinminReload = "1";
        //}

        gvFmDocs.PageIndex = 0;
    }

    protected void gvFmDocs_OnPreRender(object sender, EventArgs e)
    {
        int pageIndex;
        if (null != Session[CURRENT_PAGE] && int.TryParse(Session[CURRENT_PAGE].ToString(), out pageIndex))
        {
            gvFmDocs.PageIndex = pageIndex < gvFmDocs.PageCount ? pageIndex : gvFmDocs.PageIndex;
        }
    }

    protected void gvFmDocs_OnPageIndexChanged(object sender, EventArgs e)
    {
        Session[CURRENT_PAGE] = gvFmDocs.PageIndex;
    }
}