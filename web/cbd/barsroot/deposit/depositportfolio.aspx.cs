using System;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using Bars.Exception;
using Bars.Oracle;
using Oracle.DataAccess.Client;

public partial class deposit_depositportfolio : System.Web.UI.Page
{
    /// <summary>
    /// 
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            InitControls();
        else
            InitGrid();
    }
    /// <summary>
    /// 
    /// </summary>
    private void InitControls()
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            OracleCommand cmd = connect.CreateCommand();
            //cmd.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            //cmd.ExecuteNonQuery();

            cmd.CommandText = "select min(fdat) from  dpt_portfolio";
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                {
                    StartDate.DateInput.SelectedDate = rdr.GetOracleDate(0).Value;
                    StartDate.DateInput.MinDate = (DateTime)StartDate.DateInput.SelectedDate;
                    EndDate.DateInput.MinDate = StartDate.DateInput.MinDate;
                }
                else
                    throw new DepositException("У депозитний портфелі для WEB відсутні данні!");
            }

            cmd.CommandText = "select max(fdat) from dpt_portfolio";
            rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                {
                    EndDate.DateInput.SelectedDate = rdr.GetOracleDate(0).Value;
                    StartDate.DateInput.SelectedDate = EndDate.DateInput.SelectedDate;
                    StartDate.DateInput.MaxDate = (DateTime)EndDate.DateInput.SelectedDate;
                    EndDate.DateInput.MaxDate = StartDate.DateInput.MaxDate;
                }
            }

            if (!rdr.IsClosed)
            {
                rdr.Close();
                rdr.Dispose();
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        StartDate.DateInput.ToolTip = "Портфель доступен за период с " + StartDate.DateInput.MinDate.ToShortDateString() + " до " + StartDate.DateInput.MaxDate.ToShortDateString();
        StartDate.validationMessage = "Необходимо заполнить начало периода";
        EndDate.DateInput.ToolTip = StartDate.DateInput.ToolTip;
        EndDate.validationMessage = "Необходимо заполнить конец периода";
        StartDate.rExtender.Enabled = false;
        EndDate.rExtender.Enabled = false;
    }
    /// <summary>
    /// 
    /// </summary>
    private void InitGrid()
    {
        dsPortfolio.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        //dsPortfolio.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
        dsPortfolio.SelectCommand = GetSelectString();
        gridPortfolio.DataBind();
    }
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    private String GetSelectString()
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
                    case "BRANCH_ORD": tobo = Convert.ToInt16(val); break;
                    case "ISP_ORD": isp = Convert.ToInt16(val); break;
                    case "VIDD_ORD": vidd = Convert.ToInt16(val); break;
                    case "CUR_CODE_ORD": kv = Convert.ToInt16(val); break;
                    case "NBS_ORD": nbs = Convert.ToInt16(val); break;
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

        BoundField tobo_col = new BoundField();
        tobo_col.HeaderText= "Отдел.";
        tobo_col.DataField = "BRANCH";
        tobo_col.SortExpression = "BRANCH";
        tobo_col.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        tobo_col.ItemStyle.Wrap = false;

        BoundField isp_col = new BoundField();
        isp_col.HeaderText = "Исп.";
        isp_col.DataField = "ISP";
        isp_col.SortExpression = "ISP";
        isp_col.ItemStyle.HorizontalAlign = HorizontalAlign.Left;
        isp_col.ItemStyle.Wrap = false;

        BoundField vidd_col = new BoundField();
        vidd_col.HeaderText = "Вид вклада";
        vidd_col.DataField = "VIDD";
        vidd_col.SortExpression = "VIDD";
        vidd_col.ItemStyle.HorizontalAlign = HorizontalAlign.Left;
        vidd_col.ItemStyle.Wrap = false;

        BoundField cur_code_col = new BoundField();
        cur_code_col.HeaderText = "Вал.";
        cur_code_col.DataField = "CUR_CODE";
        cur_code_col.SortExpression = "CUR_CODE";
        cur_code_col.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        cur_code_col.ItemStyle.Wrap = false;

        BoundField nbs_col = new BoundField();
        nbs_col.HeaderText = "Бал.рах.";
        nbs_col.DataField = "NBS";
        nbs_col.SortExpression = "NBS";
        nbs_col.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        nbs_col.ItemStyle.Wrap = false;

        IList<String> first_columns = new String[5] { "BRANCH", "ISP", "VIDD", "CUR_CODE", "NBS" };

        if (first_columns.Contains((gridPortfolio.Columns[0] as BoundField).DataField))
            gridPortfolio.Columns.RemoveAt(0);
        if (first_columns.Contains((gridPortfolio.Columns[0] as BoundField).DataField))
            gridPortfolio.Columns.RemoveAt(0);
        if (first_columns.Contains((gridPortfolio.Columns[0] as BoundField).DataField))
            gridPortfolio.Columns.RemoveAt(0);
        if (first_columns.Contains((gridPortfolio.Columns[0] as BoundField).DataField))
            gridPortfolio.Columns.RemoveAt(0);
        if (first_columns.Contains((gridPortfolio.Columns[0] as BoundField).DataField))
            gridPortfolio.Columns.RemoveAt(0);

        if (s1 != String.Empty)
        {
            switch (s1)
            {
                case "BRANCH": gridPortfolio.Columns.Insert(0, tobo_col); break;
                case "ISP": gridPortfolio.Columns.Insert(0, isp_col); break;
                case "VIDD": gridPortfolio.Columns.Insert(0, vidd_col); break;
                case "CUR_CODE": gridPortfolio.Columns.Insert(0, cur_code_col); break;
                case "NBS": gridPortfolio.Columns.Insert(0, nbs_col); break;
            }
        }
        if (s2 != String.Empty)
        {
            switch (s2)
            {
                case "BRANCH": gridPortfolio.Columns.Insert(1, tobo_col); break;
                case "ISP": gridPortfolio.Columns.Insert(1, isp_col); break;
                case "VIDD": gridPortfolio.Columns.Insert(1, vidd_col); break;
                case "CUR_CODE": gridPortfolio.Columns.Insert(1, cur_code_col); break;
                case "NBS": gridPortfolio.Columns.Insert(1, nbs_col); break;
            }
        }
        if (s3 != String.Empty)
        {
            switch (s3)
            {
                case "BRANCH": gridPortfolio.Columns.Insert(2, tobo_col); break;
                case "ISP": gridPortfolio.Columns.Insert(2, isp_col); break;
                case "VIDD": gridPortfolio.Columns.Insert(2, vidd_col); break;
                case "CUR_CODE": gridPortfolio.Columns.Insert(2, cur_code_col); break;
                case "NBS": gridPortfolio.Columns.Insert(2, nbs_col); break;
            }
        }
        if (s4 != String.Empty)
        {
            switch (s4)
            {
                case "BRANCH": gridPortfolio.Columns.Insert(3, tobo_col); break;
                case "ISP": gridPortfolio.Columns.Insert(3, isp_col); break;
                case "VIDD": gridPortfolio.Columns.Insert(3, vidd_col); break;
                case "CUR_CODE": gridPortfolio.Columns.Insert(3, cur_code_col); break;
                case "NBS": gridPortfolio.Columns.Insert(3, nbs_col); break;
            }
        }
        if (s5 != String.Empty)
        {
            switch (s5)
            {
                case "BRANCH": gridPortfolio.Columns.Insert(4, tobo_col); break;
                case "ISP": gridPortfolio.Columns.Insert(4, isp_col); break;
                case "VIDD": gridPortfolio.Columns.Insert(4, vidd_col); break;
                case "CUR_CODE": gridPortfolio.Columns.Insert(4, cur_code_col); break;
                case "NBS": gridPortfolio.Columns.Insert(4, nbs_col); break;
            }
        }

        String prefix = String.Empty;
        String tail = String.Empty;
        String where = " where 1=1 and ";
        bool useKV = false;
        if (tobo > 0)
        {
            where += " t1.branch = t2.branch and t2.branch = t3.branch and t3.branch = t4.branch and ";
            prefix += " t1.branch ";
            tail += " branch ";
        }
        else
        {
            prefix += " null BRANCH ";
            tail += " null ";
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
        }

        if (prefix.Length > 0) prefix += ", ";
        if (tail.Length > 0) tail += ", ";

        if (kv > 0)
        {
            useKV = true;
            where += " t1.cur_code = t2.cur_code and t2.cur_code = t3.cur_code and t3.cur_code = t4.cur_code and ";
            prefix += " t1.CUR_CODE ";
            tail += " cur_code ";
        }
        else
        {
            prefix += " null CUR_CODE ";
            tail += " null ";
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
        }

        if (where.Length > 0) where = where.Substring(0, where.Length - 4);
        if (prefix.Length > 0) prefix += ", ";

        String table = " dpt_portfolio ";
        if (!useKV) table = " dpt_portfolio_nc ";

        String from = "( select ";
        String start_date = "to_date('" + StartDate.DateInput.SelectedDate.Value.ToString("dd/MM/yyyy") + "','dd/mm/yyyy')";
        String end_date = "to_date('" + EndDate.DateInput.SelectedDate.Value.ToString("dd/MM/yyyy") + "','dd/mm/yyyy')";
        
        String from1 = @" to_char(sum(dos_d_),'FM999G999G999G990D009') DOSD,
            to_char(sum(dos_p_),'FM999G999G999G990D009') DOSP, 
            to_char(sum(kos_d_),'FM999G999G999G990D009') KOSD, 
            to_char(sum(kos_p_),'FM999G999G999G990D009') KOSP,
            sum(acc_open) ACCO, sum(acc_closed) ACCC 
            from " + table + @" 
            where fdat between " + start_date + " and " + end_date + @" 
            group by " + tail + " ) t1, ";

        String from2 = String.Empty;
        if (useKV)
            from2 = @" to_char(sum(ost_d_n),'FM999G999G999G990D009') DPTSAL1, 
            sum(ost_d_n*denom) DPTSAL1_, 
            to_char(sum(ost_p_n),'FM999G999G999G990D009') PERSAL1,
            sum(ost_p_n) PERSAL1_
            from " + table + @"            
            where fdat = 
            (select min(fdat) from (select fdat from (select fdat, rownum p_rownum from (select fdat from fdat where fdat >= " + start_date + @" order by fdat asc) ) where p_rownum < 3))
            group by null," + tail + " ) t2, ";
        else
            from2 = @" to_char(sum(gl.p_icurval(kv, (ost_d_n*denom), fdat)/100),'FM999G999G999G990D009') DPTSAL1, 
            sum(gl.p_icurval(kv, (ost_d_n*denom), fdat)) DPTSAL1_, 
            to_char(sum(gl.p_icurval(kv, (ost_p_n*denom), fdat)/100),'FM999G999G999G990D009') PERSAL1,
            sum(gl.P_ICURVAL(kv, (ost_p_n*denom), fdat)) PERSAL1_
            from " + table + @"            
            where fdat = 
            (select min(fdat) from (select fdat from (select fdat, rownum p_rownum from (select fdat from fdat where fdat >= " + start_date + @" order by fdat asc) ) where p_rownum < 3))
            group by null," + tail + " ) t2, ";

        String from3 = String.Empty;
        if (useKV)
            from3 = @" sum(w_rate) RAT1,
            sum(acc_before) ACC1
            from " + table + @"
            where fdat = 
            (select min(fdat) from (select fdat from (select fdat, rownum p_rownum from (select fdat from fdat where fdat >= " + start_date + @" order by fdat asc) ) where p_rownum < 3))
            group by null," + tail + " ) t3, ";
        else
            from3 = @" sum(gl.P_ICURVAL(kv,w_rate,fdat)) RAT1,
            sum(acc_before) ACC1
            from " + table + @"
            where fdat = 
            (select min(fdat) from (select fdat from (select fdat, rownum p_rownum from (select fdat from fdat where fdat >= " + start_date + @" order by fdat asc) ) where p_rownum < 3))
            group by null," + tail + " ) t3, ";

        String from4 = String.Empty;
        if (useKV)
         from4 = @" sum(w_rate) RAT2,
            to_char(sum(ost_d_),'FM999G999G999G990D009') DPTSAL2,
            sum(ost_d) DPTSAL2_,
            to_char(sum(ost_p_),'FM999G999G999G990D009') PERSAL2
            from " + table + @"
            where fdat = 
            (select max(fdat) from (select fdat from (select fdat, rownum p_rownum from (select fdat from fdat where fdat <= " + end_date + @" order by fdat desc) ) where p_rownum < 3))
            group by null," + tail + ") t4 ";
        else
            from4 = @" sum(gl.P_ICURVAL(kv,w_rate,fdat)) RAT2,
            to_char(sum(ost_d_),'FM999G999G999G990D009') DPTSAL2,
            sum(ost_d) DPTSAL2_,
            to_char(sum(ost_p_),'FM999G999G999G990D009') PERSAL2
            from " + table + @"
            where fdat = 
            (select max(fdat) from (select fdat from (select fdat, rownum p_rownum from (select fdat from fdat where fdat <= " + end_date + @" order by fdat desc) ) where p_rownum < 3))
            group by null," + tail + ") t4 ";

        String sel1 = @" DOSD, DOSP, KOSD, KOSP, ACCO, ACCC, ACC1, 
            to_char(RAT1/decode (DPTSAL1_, 0, 1, DPTSAL1_),'FM999G999G999G990D0000') RAT1,
            to_char(RAT2/decode (DPTSAL2_, 0, 1, DPTSAL2_),'FM999G999G999G990D0000') RAT2,
            DPTSAL1, PERSAL1, 
            ACC1+ACCO-ACCC ACC2, DPTSAL2, PERSAL2 ";

 
        String commandText = "SELECT " + prefix + sel1 +
            " FROM " + from + prefix.Replace("t1.", "") + from1 +
                from + prefix.Replace("t1.", "") + from2 +
                from + prefix.Replace("t1.", "") + from3 +
                from + prefix.Replace("t1.", "") + from4 +
                where + sort;

        return commandText;
    }
}