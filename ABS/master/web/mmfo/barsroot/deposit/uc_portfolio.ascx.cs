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
using WebChart;
using Oracle.DataAccess.Client;
using Bars.Oracle;
using System.Drawing;

public partial class uc_portfolio : BarsWebPart
{
    /// <summary>
    /// 
    /// </summary>
    public uc_portfolio()
    { 
      this.Title = "Current User";
      // this.TitleIconImageUrl = @"~\img\WhaleBoy.gif";
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        //{
        //    InitDate();
        //}
    }
    /// <summary>
    /// 
    /// </summary>
    private void InitGrid()
    {
        String prefix = String.Empty;
        String tail = String.Empty;
        String where = " where 1=1 and ";
        bool useKV = false;
        String xValue = String.Empty;

        if (rTobo.Checked)
        {
            where += " t1.tobo = t2.tobo and t2.tobo = t3.tobo and t3.tobo = t4.tobo and ";
            prefix += " t1.TOBO ";
            tail += " TOBO ";
            xValue = "TOBO";
        }
        else
        {
            prefix += " null TOBO ";
            tail += " null ";
        }

        if (prefix.Length > 0) prefix += ", ";
        if (tail.Length > 0) tail += ", ";

        if (rIsp.Checked)
        {
            where += " t1.isp = t2.isp and t2.isp = t3.isp and t3.isp = t4.isp and ";
            prefix += " t1.ISP ";
            tail += " isp ";
            xValue = "ISP";
        }
        else
        {
            prefix += " null ISP ";
            tail += " null ";
        }

        if (prefix.Length > 0) prefix += ", ";
        if (tail.Length > 0) tail += ", ";

        if (rVidd.Checked)
        {
            where += " t1.vidd = t2.vidd and t2.vidd = t3.vidd and t3.vidd = t4.vidd and ";
            prefix += " t1.VIDD ";
            tail += " vidd ";
            xValue = "VIDD";
        }
        else
        {
            prefix += " null VIDD ";
            tail += " null ";
        }

        if (prefix.Length > 0) prefix += ", ";
        if (tail.Length > 0) tail += ", ";

        if (rKV.Checked)
        {
            useKV = true;
            where += " t1.kv = t2.kv and t2.kv = t3.kv and t3.kv = t4.kv and ";
            prefix += " t1.KV ";
            tail += " kv ";
            xValue = "KV";
        }
        else
        {
            prefix += " null KV ";
            tail += " null ";
        }

        if (prefix.Length > 0) prefix += ", ";
        if (tail.Length > 0) tail += ", ";

        if (rNBS.Checked)
        {
            where += " t1.nbs = t2.nbs and t2.nbs = t3.nbs and t3.nbs = t4.nbs and ";
            prefix += " t1.NBS ";
            tail += " nbs ";
            xValue = "NBS";
        }
        else
        {
            prefix += " null NBS ";
            tail += " null ";
        }

        if (where.Length > 0) where = where.Substring(0, where.Length - 4);
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
            where fdat between to_date('" + dtStart.Date.ToString("dd/MM/yyyy")
            + @"','dd/MM/yyyy') and to_date('" + dtStart.Date.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy')
            group by " + tail + " ) t1, ";
        String from2 = @" to_char((sum(w_rate) / (decode (sum(ost_d), 0, 1, sum(ost_d)))),'999999999990.9999') RAT1,
            to_char(sum(ost_d)/100,'999999999990.99') DPTSAL1, 
            to_char(sum(ost_p)/100,'999999999990.99') PERSAL1
            from " + table + @"
            where fdat = (select min(fdat) from (select fdat from fdat where fdat <= to_date('" + dtStart.Date.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy') and rownum<3 order by fdat desc) )
            group by null," + tail + " ) t2, ";
        String from3 = @" sum(acc_before) ACC1
            from " + table + @"
            where fdat = (select max(fdat) from fdat where fdat <= to_date('" + dtStart.Date.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy')) 
            group by null," + tail + " ) t3, ";
        String from4 = @" sum(acc_before) ACC2,
            to_char((sum(w_rate) / (decode (sum(ost_d), 0, 1, sum(ost_d)))),'999999999990.9999') RAT2,
            to_char(sum(ost_d)/100,'999999999990.99') DPTSAL2,
            to_char(sum(ost_p)/100,'999999999990.99') PERSAL2
            from " + table + @"
            where fdat = (select min(fdat) from fdat where fdat > to_date('" + dtFinish.Date.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy'))
            group by null," + tail + ") t4 ";

        String sel1 = " DOSD, DOSP, KOSD, KOSP, ACCO, ACCC, ACC1, RAT1, DPTSAL1, PERSAL1, ACC2, RAT2,  DPTSAL2, PERSAL2 ";
        String commandText = "SELECT " + prefix + sel1 +
            " FROM " + from + prefix.Replace("t1.", "") + from1 +
                from + prefix.Replace("t1.", "") + from2 +
                from + prefix.Replace("t1.", "") + from3 +
                from + prefix.Replace("t1.", "") + from4 +
                where;

        OracleConnection connect = new OracleConnection();
        DataSet dsPort = new DataSet();
        OracleDataAdapter add = new OracleDataAdapter();

        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = commandText;
            add.SelectCommand = cmd;

            add.Fill(dsPort);
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        cPortfolio.BackColor = Color.White;

        Chart mChart;

        ControlCollection collect = new ControlCollection(tblPortfolio);
        collect.Add(ckDPTSAL1); collect.Add(ckDPTSAL2);
        collect.Add(ckDOSD); collect.Add(ckKOSD);
        collect.Add(ckPERSAL1); collect.Add(ckPERSAL2);
        collect.Add(ckDOSP); collect.Add(ckKOSP);
        collect.Add(ckRAT1); collect.Add(ckRAT2);
        collect.Add(ckACC1); collect.Add(ckACC2);
        collect.Add(ckACCO); collect.Add(ckACCC);

        foreach (Control ctrl in collect)
        {
            if (((CheckBox)ctrl).Checked)
            {
                mChart = GetChartType();
                mChart.Legend = ((CheckBox)ctrl).ID.Substring(2);
                mChart.DataLabels.Visible = true;
                mChart.Line.Color = Color.FromArgb(((CheckBox)ctrl).TabIndex * 5,
                    ((CheckBox)ctrl).TabIndex * 4, ((CheckBox)ctrl).TabIndex * 3);
                mChart.DataSource = dsPort.Tables[0].DefaultView;
                mChart.DataXValueField = xValue;
                mChart.DataYValueField = ((CheckBox)ctrl).ID.Substring(2);
                mChart.DataBind();

                cPortfolio.Charts.Add(mChart);
            }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    private Chart GetChartType()
    {
        Chart tChart = new LineChart();

        switch (listType.SelectedValue)
        {
            case "0": tChart = new LineChart(); break;
            case "1": tChart = new ColumnChart(); break;
            case "2": tChart = new SmoothLineChart(); break;
            case "3": tChart = new StackedColumnChart(); break;
            case "4": tChart = new AreaChart(); break;
            case "5": tChart = new ScatterChart(); break;
            case "6": tChart = new StackedAreaChart(); break;
            case "7": tChart = new PieChart(); break;
        }
        return tChart;
    }

    /// <summary>
    /// 
    /// </summary>
    private void InitDate()
    {
        OracleConnection connect = new OracleConnection();
        OracleDataAdapter add = new OracleDataAdapter();

        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "select min(fdat),max(fdat) from dpt_portfolio";
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                dtStart.Date    = rdr.GetOracleDate(0).Value;
                dtFinish.Date   = rdr.GetOracleDate(1).Value;
            }

            rdr.Close(); rdr.Dispose();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btRefresh_Click(object sender, EventArgs e)
    {
        InitGrid();
    }
}
