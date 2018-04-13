using System;
using System.Globalization;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class paysep_setperiod : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        CultureInfo cinfo = System.Threading.Thread.CurrentThread.CurrentUICulture;
        meeFinish.CultureName = cinfo.Name;
        meeStart.CultureName = cinfo.Name;
        cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
        cinfo.DateTimeFormat.DateSeparator = ".";
        System.Threading.Thread.CurrentThread.CurrentCulture = System.Threading.Thread.CurrentThread.CurrentUICulture;
        if (!IsPostBack)
        {
            InitOraConnection();
            try
            {
                SetRole("SEP_RATES_ROLE");
                ArrayList reader = SQL_reader("select to_char(start_date,'dd.MM.yyyy'),to_char(finish_date,'dd.MM.yyyy'),id from sep_rates_calendar where closed is null order by id");
                if(reader.Count > 0)
                {
                    DateTime start = Convert.ToDateTime(reader[0], cinfo);
                    DateTime finish = Convert.ToDateTime(reader[1], cinfo);

                    tbStartDate.Text = start.ToShortDateString();
                    tbFinishDate.Text = finish.ToShortDateString();
                    lbStatus.Text = "Установлен существующий незакрытый период.";

                    Session["PaySep.periodId"] = Convert.ToString(reader[2]);
                    Session["PaySep.periodStart"] = tbStartDate.Text;
                    Session["PaySep.periodFinish"] = tbFinishDate.Text;
                }
                else
                {
                    Session["PaySep.periodId"] = null;
                    reader = SQL_reader("select to_char(bars_sep_rates.get_next_start_date,'dd.MM.yyyy'), to_char(bars_sep_rates.get_next_finish_date(bars_sep_rates.get_next_start_date),'dd.MM.yyyy') from dual");
                    tbStartDate.Text = Convert.ToDateTime(reader[0], cinfo).ToShortDateString();
                    tbFinishDate.Text = Convert.ToDateTime(reader[1], cinfo).ToShortDateString();
                    lbStatus.Text = "Укажите значение нового периода.";
                }
            }
            finally
            {
                DisposeOraConnection();
            }
        }
    }
    protected void btNext_Click(object sender, EventArgs e)
    {
        InitOraConnection();
        try
        {
            CultureInfo cinfo = System.Threading.Thread.CurrentThread.CurrentUICulture;
            cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
            cinfo.DateTimeFormat.DateSeparator = ".";

            DateTime start = Convert.ToDateTime(tbStartDate.Text, cinfo);
            DateTime finish = Convert.ToDateTime(tbFinishDate.Text, cinfo);

            SetRole("BASIC_INFO");
            SetParameters("p_date", DB_TYPE.Date, start, DIRECTION.Input);
            int res = Convert.ToInt32(SQL_SELECT_scalar("select count(*) from fdat where fdat = :p_date"));
            if(res == 0)
            {
                lbStatus.Text = "Начальной даты нет в справочнике банковских дат.";
                lbStatus.ForeColor = System.Drawing.Color.Red;
                tbStartDate.Focus();
                return;
            }
            ClearParameters();
            SetParameters("p_date", DB_TYPE.Date, finish, DIRECTION.Input);
            res = Convert.ToInt32(SQL_SELECT_scalar("select count(*) from fdat where fdat = :p_date"));
            if (res == 0)
            {
                lbStatus.Text = "Конечной даты нет в справочнике банковских дат.";
                lbStatus.ForeColor = System.Drawing.Color.Red;
                tbFinishDate.Focus();
                return;
            }
            lbStatus.ForeColor = System.Drawing.Color.Green;
            lbStatus.Text = "";

            if ((string)Session["PaySep.periodStart"] != tbStartDate.Text || (string)Session["PaySep.periodFinish"] != tbFinishDate.Text)
            {
                ClearParameters();
                SetRole("SEP_RATES_ROLE");
                SetParameters("p_start_date", DB_TYPE.Date, start, DIRECTION.Input);
                SetParameters("p_finish_date", DB_TYPE.Date, finish, DIRECTION.Input);
                if (Session["PaySep.periodId"] != null)
                    SetParameters("p_id", DB_TYPE.Decimal, Convert.ToString(Session["PaySep.periodId"]), DIRECTION.Input);
                else
                    SetParameters("p_id", DB_TYPE.Decimal, null, DIRECTION.Output);

                SQL_PROCEDURE("bars_sep_rates.create_period");

                Session["PaySep.periodId"] = Convert.ToString(GetParameter("p_id"));
                Session["PaySep.periodStart"] = tbStartDate.Text;
                Session["PaySep.periodFinish"] = tbFinishDate.Text;
            }
            Response.Redirect("default.aspx");
        }
        finally
        {
            DisposeOraConnection();
        }
    }
}
