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
using Bars.Oracle;
using Oracle.DataAccess.Client;
using System.Globalization;

public partial class deposit_depositportfolio : System.Web.UI.Page
{
    /// <summary>
    /// 
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            InitDate();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private void InitDate()
    {
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");	
		cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
		cinfo.DateTimeFormat.DateSeparator = "/";

        StartDate.Date = Convert.ToDateTime(BankType.GetBankDate(),cinfo);
        EndDate.Date = Convert.ToDateTime(BankType.GetBankDate(), cinfo);
    }
    /// <summary>
    /// 
    /// </summary>
    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        if (sourceControl.GetType().Name == "BarsGridView" || (eventArgument != null && eventArgument.Length > 4 && eventArgument.Substring(0, eventArgument.IndexOf("$")) == "Bars"))
        { InitGrid(); }

        base.RaisePostBackEvent(sourceControl, eventArgument);
    }
    /// <summary>
    /// 
    /// </summary>
    private void InitGrid()
    {
        String sort = String.Empty;
        String s1 = String.Empty; String s2 = String.Empty; String s3 = String.Empty; String s4 = String.Empty; String s5 = String.Empty;
        Int16 nbs = 0; Int16 vidd = 0; Int16 kv = 0; Int16 tobo = 0; Int16 isp = 0;
        if (!String.IsNullOrEmpty(CLIENT_FILTER.Value))
        {
            String[] arr = CLIENT_FILTER.Value.Split(';');
            foreach (String item in arr)
            {
                int breakpos = item.IndexOf("=");
                String tag = item.Substring(0, breakpos);
                String val = item.Substring(breakpos + 1);

                switch (tag)
                {
                    case "TOBO_ORD": tobo = Convert.ToInt16(val); break;
                    case "ISP_ORD": isp = Convert.ToInt16(val); break;
                    case "VIDD_ORD": vidd = Convert.ToInt16(val); break;
                    case "KV_ORD": kv = Convert.ToInt16(val); break;
                    case "BAL_ORD": nbs = Convert.ToInt16(val); break;
                }

                switch (val)
                {
                    case "1": s1 = tag.Substring(0, tag.Length - 4); break;
                    case "2": s2 = tag.Substring(0, tag.Length - 4); break;
                    case "3": s3 = tag.Substring(0, tag.Length - 4); break;
                    case "4": s4 = tag.Substring(0, tag.Length - 4); break;
                    case "5": s5 = tag.Substring(0, tag.Length - 4); break;
                }
            }
        }

        if (s1 != String.Empty || s2 != String.Empty || s3 != String.Empty || s4 != String.Empty || s5 != String.Empty)
            sort = " order by " + 
                (s1 == String.Empty ? "null" : s1) + ", " +
                (s2 == String.Empty ? "null" : s2) + ", " +
                (s3 == String.Empty ? "null" : s3) + ", " +
                (s4 == String.Empty ? "null" : s4) + ", " +
                (s5 == String.Empty ? "null" : s5); 

        //CLIENT_FILTER.Value = String.Empty;

        dsPortfolio.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsPortfolio.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
        //dsPortfolio.PreliminaryStatement = "begin " +
        //    "execute immediate 'set role DPT_ROLE';" +
        //    "execute immediate 'ALTER SESSION SET sql_trace = TRUE'; "+
        //    "execute immediate 'ALTER SESSION SET timed_statistics = TRUE'; "+
        //    "execute immediate 'ALTER SESSION SET EVENTS ''10046 trace name context forever, level 12'''; "+
        //    "execute immediate 'ALTER SESSION SET EVENTS ''10032 trace name context forever, level 10''';              "+
        //"end; ";
        //dsPortfolio.PreliminaryStatement = "begin " +
        //       "execute immediate 'set role DPT_ROLE';" +
        //       "execute immediate 'ALTER SESSION SET EVENTS ''10046 trace name context forever, level 4'''; " +
        //   "end; ";

        String prefix = String.Empty;
        String tail = String.Empty; 
        String where = " where 1=1 and ";
        bool useKV = false;
        if (tobo > 0)
        {
            where += " t1.tobo = t2.tobo and t2.tobo = t3.tobo and t3.tobo = t4.tobo and ";
            prefix += " t1.TOBO ";
            tail += " TOBO ";            
        }
        else
        {
            prefix += " null TOBO ";
            tail += " null ";
            gridPortfolio.Columns[0].Visible = false;
        }

        if (prefix.Length > 0) prefix += ", ";
        if (tail.Length > 0) tail += ", ";

        if (isp > 0)
        {

            where += " t1.isp = t2.isp and t2.isp = t3.isp and t3.isp = t4.isp and ";
            prefix += " t1.ISP ";
            tail += " isp ";
        }
        else
        {
            prefix += " null ISP ";
            tail += " null ";
            gridPortfolio.Columns[1].Visible = false;
        }

        if (prefix.Length > 0) prefix += ", ";
        if (tail.Length > 0) tail += ", ";

        if (vidd > 0)
        {
            where += " t1.vidd = t2.vidd and t2.vidd = t3.vidd and t3.vidd = t4.vidd and ";
            prefix += " t1.VIDD ";
            tail += " vidd ";
        }
        else
        {
            prefix += " null VIDD ";
            tail += " null ";
            gridPortfolio.Columns[2].Visible = false;
        }

        if (prefix.Length > 0) prefix += ", ";
        if (tail.Length > 0) tail += ", ";

        if (kv > 0)
        {
            useKV = true;
            where += " t1.kv = t2.kv and t2.kv = t3.kv and t3.kv = t4.kv and ";
            prefix += " t1.KV ";
            tail += " kv ";
        }
        else
        {
            prefix += " null KV ";
            tail += " null ";
            gridPortfolio.Columns[3].Visible = false;
        }

        if (prefix.Length > 0) prefix += ", ";
        if (tail.Length > 0) tail += ", ";

        if (nbs > 0)
        {
            where += " t1.nbs = t2.nbs and t2.nbs = t3.nbs and t3.nbs = t4.nbs and ";
            prefix += " t1.NBS ";
            tail += " nbs ";
        }
        else
        {
            prefix += " null NBS ";
            tail += " null ";
            gridPortfolio.Columns[4].Visible = false;
        }

        if (where.Length > 0) where = where.Substring(0,where.Length - 4);
        if (prefix.Length > 0) prefix += ", ";

        String table = " dpt_portfolio ";
        if (!useKV) table = " dpt_portfolio_nc ";
            
        String from = "( select ";
        String from1 = @" to_char(sum(dos_d)/100,'999999999990.99') DOSD,
            to_char(sum(dos_p)/100,'999999999990.99') DOSP, 
            to_char(sum(kos_d)/100,'999999999990.99') KOSD, 
            to_char(sum(kos_p)/100,'999999999990.99') KOSP,
            sum(acc_open) ACCO, sum(acc_closed) ACCC
            from " + table + @" 
            where fdat between to_date('" + StartDate.Date.ToString("dd/MM/yyyy") 
            + @"','dd/MM/yyyy') and to_date('" + EndDate.Date.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy')
            group by " + tail + " ) t1, ";
        String from2 = @" to_char((sum(w_rate) / (decode (sum(ost_d), 0, 1, sum(ost_d)))),'999999999990.9999') RAT1,
            to_char(sum(ost_d)/100,'999999999990.99') DPTSAL1, 
            to_char(sum(ost_p)/100,'999999999990.99') PERSAL1
            from " + table + @"
            where fdat = (select min(fdat) from (select fdat from fdat where fdat <= to_date('" + StartDate.Date.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy') and rownum<3 order by fdat desc) )
            group by null," + tail + " ) t2, ";
        String from3 = @" sum(acc_before) ACC1
            from " + table + @"
            where fdat = (select max(fdat) from fdat where fdat <= to_date('" + StartDate.Date.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy')) 
            group by null," + tail + " ) t3, ";
        String from4 = @" sum(acc_before) ACC2,
            to_char((sum(w_rate) / (decode (sum(ost_d), 0, 1, sum(ost_d)))),'999999999990.9999') RAT2,
            to_char(sum(ost_d)/100,'999999999990.99') DPTSAL2,
            to_char(sum(ost_p)/100,'999999999990.99') PERSAL2
            from " + table + @"
            where fdat = (select min(fdat) from fdat where fdat > to_date('" + EndDate.Date.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy'))
            group by null," + tail + ") t4 ";

        String sel1 = " DOSD, DOSP, KOSD, KOSP, ACCO, ACCC, ACC1, RAT1, DPTSAL1, PERSAL1, ACC2, RAT2,  DPTSAL2, PERSAL2 ";
        String commandText = "SELECT " + prefix + sel1 +
            " FROM " + from + prefix.Replace("t1.", "") + from1 +
                from + prefix.Replace("t1.", "") + from2 +
                from + prefix.Replace("t1.", "") + from3 +
                from + prefix.Replace("t1.", "") + from4 +
                where;// +sort;

        //OracleConnection connect = new OracleConnection();
        //try
        //{
        //    // Открываем соединение с БД
        //    IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
        //    connect = conn.GetUserConnection();
        //    

        //    // Устанавливаем роль
        //    OracleCommand cmdSetRole = connect.CreateCommand();
        //    cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
        //    cmdSetRole.ExecuteNonQuery();

        //    OracleCommand cmd = connect.CreateCommand();
        //    cmd.CommandText = commandText;

        //    cmd.Parameters.Clear();
        //    cmd.Parameters.Add("DAT1", OracleDbType.Date, StartDate.Date, ParameterDirection.Input);
        //    cmd.Parameters.Add("DAT2", OracleDbType.Date, EndDate.Date, ParameterDirection.Input);
        //    cmd.Parameters.Add("DAT1", OracleDbType.Date, StartDate.Date, ParameterDirection.Input);
        //    cmd.Parameters.Add("DAT1", OracleDbType.Date, StartDate.Date, ParameterDirection.Input);
        //    cmd.Parameters.Add("DAT2", OracleDbType.Date, EndDate.Date, ParameterDirection.Input);

        //    OracleDataReader rdr = cmd.ExecuteReader();

        //    int i = 0;
        //    while (rdr.Read())
        //    { i++; }

        //    rdr.Close();
        //}
        //finally
        //{
        //    if (connect.State != ConnectionState.Closed)
        //    { connect.Close(); connect.Dispose(); }
        //}
        dsPortfolio.SelectCommand = commandText;
        //ChartControl1.Charts.Add();
        //dsPortfolio.SelectParameters.Clear();
        //dsPortfolio.SelectParameters.Add("DAT1", TypeCode.String, StartDate.Date.ToString("dd/MM/yyyy"));
        //dsPortfolio.SelectParameters.Add("DAT2", TypeCode.String, EndDate.Date.ToString("dd/MM/yyyy"));
        //dsPortfolio.SelectParameters.Add("DAT1", TypeCode.String, StartDate.Date.ToString("dd/MM/yyyy"));
        //dsPortfolio.SelectParameters.Add("DAT1", TypeCode.String, StartDate.Date.ToString("dd/MM/yyyy"));
        //dsPortfolio.SelectParameters.Add("DAT2", TypeCode.String, EndDate.Date.ToString("dd/MM/yyyy"));
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btRefresh_Click(object sender, EventArgs e)
    {
        InitGrid();
    }
}
