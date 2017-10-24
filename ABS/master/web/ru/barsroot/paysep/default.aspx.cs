using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class paysep_Default : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if( Session["PaySep.periodId"] == null)
        {
            Response.Write("<script>alert('Не задан интервал расчета')</script>");
            Response.Redirect("setperiod.aspx");
            return;
        }
        if(!IsPostBack)
        {
            tbStartDate.Text = Session["PaySep.periodStart"].ToString();
            tbFinishDate.Text = Session["PaySep.periodFinish"].ToString();
            FillData();
        }
    }

    private void FillData()
    {
        InitOraConnection();
        try
        {
            SetRole("SEP_RATES_ROLE");
            SetParameters("id", DB_TYPE.Decimal, Convert.ToString(Session["PaySep.periodId"]), DIRECTION.Input);
            tbTotalSum.Text = Convert.ToString(SQL_SELECT_scalar("select round(sum(s.sum_total)/100,2) from sep_rates_totals s, v_banks_mod3 b where b.mfo=s.mfo and id=:id"));

            DataSet ds = SQL_SELECT_dataset("select b.mfo MFO, b.sab SAB, b.nb NB, s.sum_total/100 SUM_TOTAL, '<a title=''Карточка документа'' href=# onclick=\"window.showModalDialog(''/barsroot/documentview/default.aspx?ref='||s.ref||''',this,''dialogWidth:900px;dialogHeight:700px;'');\">'||s.ref||'</a>' REF, '<a title=''Карточка документа'' href=# onclick=\"window.showModalDialog(''/barsroot/documentview/default.aspx?ref='||s.ref2||''',this,''dialogWidth:900px;dialogHeight:700px;'');\">'||s.ref2||'</a>' REF2  from sep_rates_totals s, v_banks_mod3 b where b.mfo=s.mfo and id=:id order by b.sort_code");
            Grid.DataSource = ds;
            Grid.DataBind();
            if (ds.Tables[0].Rows.Count == 0)
            {
                lbStatus.Text = "Нет данных, возпользуйтесь кнопкой \"Рассчитать\"";
                btPay.Enabled = false;
                gridDiv.Visible = false;
            }
            else
            {
                btPay.Enabled = true;
                gridDiv.Visible = true;
                lbStatus.Text = "Данные рассчитаны.";
            }
        }
        finally
        {
            DisposeOraConnection();
        }
    }
    protected void btCalculate_Click(object sender, EventArgs e)
    {
        InitOraConnection();
        try
        {
            SetRole("SEP_RATES_ROLE");
            SetParameters("p_id", DB_TYPE.Decimal, Convert.ToString(Session["PaySep.periodId"]), DIRECTION.Input);
            SQL_PROCEDURE("bars_sep_rates.fill_period_totals");
        }
        finally
        {
            DisposeOraConnection();
        }
        FillData();
    }
    protected void btPay_Click(object sender, EventArgs e)
    {
        InitOraConnection();
        try
        {
            SetRole("SEP_RATES_ROLE");
            SetParameters("p_id", DB_TYPE.Decimal, Convert.ToString(Session["PaySep.periodId"]), DIRECTION.Input);
            SQL_PROCEDURE("bars_sep_rates.create_payments_by_period");
        }
        finally
        {
            DisposeOraConnection();
        }
        FillData();
        btPay.Enabled = false;
        btCalculate.Enabled = false;
        lbStatus.Text = "Документы оплачены.";
        Session["PaySep.periodId"] = null;
    }
}
