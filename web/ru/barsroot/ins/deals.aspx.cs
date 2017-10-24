using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Drawing;
using Bars.Ins;
using Bars.Classes;

public partial class ins_deals : System.Web.UI.Page
{
    # region Приватные свойства
    private Filter _FilterObj;
    # endregion

    # region Публичные свойства
    public String FilterID
    {
        get
        {
            if (Request.Params.Get("fid") == null) throw new Bars.Exception.BarsException("Не задано обов`язковий параметр fid");
            return Request.Params.Get("fid").ToUpper();
        }
    }
    public Filter FilterObj
    {
        get
        {
            if (_FilterObj == null)
                _FilterObj = new Filter(FilterID);

            return _FilterObj;
        }
    }
    public AccessTypes AccessType
    {
        get
        {
            if (Request.Params.Get("type") == null) throw new Bars.Exception.BarsException("Не задано обов`язковий параметр Url type");

            switch (Request.Params.Get("type").ToUpper())
            {
                case "USER":
                    return AccessTypes.User;
                case "MGR":
                    return AccessTypes.Manager;
                case "CONTR":
                    return AccessTypes.Controller;
                case "HEAD":
                    return AccessTypes.Head;
                default:
                    return AccessTypes.User;
            }
        }
    }
    # endregion

    # region Событи
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            InitControls();

        InitDataSource();
    }
    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Decimal DEAL_ID = (Decimal)gv.DataKeys[e.Row.DataItemIndex]["DEAL_ID"];
            VInsDealsRecord rec = (new VInsDeals()).SelectDeal(DEAL_ID);
            
            HyperLink hlDealTasks = e.Row.FindControl("hlDealTasks") as HyperLink;
            hlDealTasks.ToolTip = String.Format("{0}-{1}", rec.TASK_TYPE_NAME, rec.TASK_STATUS_NAME);
            
            switch (rec.TASK_TYPE_ID)
            {
                case "PAY":
                    hlDealTasks.NavigateUrl = String.Format("/barsroot/ins/pmts_schedule.aspx?deal_id={0}", rec.DEAL_ID);
                    switch (rec.TASK_STATUS_ID)
                    {
                        case "WAITING":
                            hlDealTasks.ImageUrl = "/Common/Images/default/24/currency_dollar_yellow.png";
                            break;
                        case "NOTDONE":
                            hlDealTasks.ImageUrl = "/Common/Images/default/24/currency_dollar_red.png";
                            break;
                        default:
                            hlDealTasks.ImageUrl = String.Empty;
                            break;
                    }
                    break;
                case "RENEW":
                    hlDealTasks.NavigateUrl = String.Format("/barsroot/ins/new.aspx?oldid={0}&comm={1}&custtype={2}", rec.DEAL_ID, String.Empty, rec.CUSTID);
                    switch (rec.TASK_STATUS_ID)
                    {
                        case "WAITING":
                            hlDealTasks.ImageUrl = "/Common/Images/default/24/recycle_yellow.png";
                            break;
                        case "NOTDONE":
                            hlDealTasks.ImageUrl = "/Common/Images/default/24/recycle_red.png";
                            break;
                        default:
                            hlDealTasks.ImageUrl = String.Empty;
                            break;
                    }
                    break;
                default:
                    hlDealTasks.NavigateUrl = String.Empty;
                    break;
            }
        }
    }
    protected void bApply_Click(object sender, EventArgs e)
    {
        gv.DataBind();
    }
    # endregion

    # region Приватные методы
    private void InitControls()
    {
        // даты
        DATE_FROM.Value = DateTime.Now.Date.AddMonths(-3);
        DATE_TO.Value = DateTime.Now.Date.AddDays(1);

        // грид
        foreach (String ColName in FilterObj.Cols2Hide)
            FilterObj.HideCol(gv, ColName);
    }
    private void InitDataSource()
    {
        sds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sds.SelectParameters.Clear();

        sds.SelectCommand = "select * from v_ins_deals d where d.crt_date >= :p_date_from and d.crt_date <= :p_date_to ";

        // даты
        sds.SelectParameters.Add("p_date_from", System.Data.DbType.DateTime, Convert.ToString(DATE_FROM.Value));
        sds.SelectParameters.Add("p_date_to", System.Data.DbType.DateTime, Convert.ToString(DATE_TO.Value));
        
        // статус
        String Statuses = String.Empty;
        foreach (ListItem li in STATUS.Items)
            if (li.Selected)
                Statuses += (!String.IsNullOrEmpty(Statuses) ? "," : "") + "'" + li.Value + "'";
        if (!String.IsNullOrEmpty(Statuses))
            sds.SelectCommand += "and d.status_id in (" + Statuses + ") ";

        // РНК стразователя
        if (INS_RNK.Value.HasValue)
        {
            sds.SelectCommand += "and d.ins_rnk = :p_ins_rnk ";
            sds.SelectParameters.Add("p_ins_rnk", System.Data.DbType.Decimal, Convert.ToString(INS_RNK.Value));
        }

        // ФИО стразователя
        if (!String.IsNullOrEmpty(INS_FIO.Value))
        {
            sds.SelectCommand += "and upper(d.ins_fio) like upper('%' || :p_ins_fio || '%') ";
            sds.SelectParameters.Add("p_ins_fio", System.Data.DbType.String, Convert.ToString(INS_FIO.Value));
        }

        // номер КД
        if (Request.Params.Get("nd") == null)
        {
            if (ND.Value.HasValue)
            {
                sds.SelectCommand += "and d.nd = :p_nd ";
                sds.SelectParameters.Add("p_nd", System.Data.DbType.Decimal, Convert.ToString(ND.Value));
            }
        }
        else
        {
            var tst = Request.Params.Get("nd").ToString();
            sds.SelectCommand += "and d.nd = :p_nd ";
            sds.SelectParameters.Add("p_nd", System.Data.DbType.Decimal, Request.Params.Get("nd").ToString());
        }

        // параметры фильтра
        sds.SelectCommand += "and (" + FilterObj.Stmt + ")";
        foreach (FilterParam fp in FilterObj.Params)
            sds.SelectParameters.Add(fp.ID, fp.Type, GetUrlParam(fp.UrlID));
    }
    private String GetUrlParam(String UrlID)
    {
        if (Request.Params.Get(UrlID.ToLower()) == null) throw new Bars.Exception.BarsException(String.Format("Не задано обов`язковий параметр {0}", UrlID).ToLower());
        return Request.Params.Get(UrlID.ToLower());
    }
    # endregion
}