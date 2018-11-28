using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Data;
using barsroot.core;

using Bars.Classes;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Globalization;
using System.Threading;

public partial class tools_sto_calendar : Bars.BarsPage //System.Web.UI.Page
{
    String l_idd;
    protected void Page_Load(object sender, EventArgs e)
    {
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";

        if (Request["IDD"] != null)
        {
            l_idd = Convert.ToString(Request["IDD"]);
          
        }

        if (!IsPostBack)
        {
            string userName = Context.User.Identity.Name;
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);
            DateTime bDate = userMap.bank_date;
            bd.Text = Convert.ToString(bDate, cinfo).Substring(0, 10);            
            try
            {
                InitOraConnection();
                Drlist.DataSource = SQL_SELECT_dataset("select to_char(sysdate,'YYYY')-3+num as val  from conductor where num < 10").Tables[0];
                Drlist.DataTextField = "val";
                Drlist.DataValueField = "val";
                Drlist.DataBind();
            }
            finally
            {
                DisposeOraConnection();
            }
            Drlist.SelectedValue = Convert.ToString(bDate.Year);
            Drlist_SelectedIndexChanged(sender, e);
            load_details();
        }
    }

    private void load_details()
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("START1"), con);

        try
        {
            cmd.ExecuteNonQuery();
            cmd.Parameters.Add("l_idd", OracleDbType.Decimal, l_idd, ParameterDirection.Input);
            cmd.CommandText = @"select c.nmk, d.nlsa, D.POLU, d.nlsb, D.FSUM,D.NAZN, d.idd, d.DAT1 
                                  from sto_det d,
                                       STO_LST l, customer c
                                 Where D.IDS = L.IDS
                                   and l.rnk = c.rnk
                                   and idd = :l_idd";
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                Lb_Nls_a.Text = Convert.ToString(rdr["nlsa"]);
                Lb_Nls_b.Text = Convert.ToString(rdr["nlsb"]);
                Lb_nam_a.Text = Convert.ToString(rdr["nmk"]);
                Lb_nam_b.Text = Convert.ToString(rdr["polu"]);
                //Lb_Summ.Value = Convert.ToString(rdr["fsum"]);
                Lb_nazn.Value = Convert.ToString(rdr["nazn"]);
                DATE_FROM.Value = rdr.GetDateTime(7);

                decimal sumValue = 0m;
                string stringSum = Convert.ToString(rdr["fsum"]);
                bool isSummDigit = Decimal.TryParse(stringSum, out sumValue);
                if (!isSummDigit)
                {

                    FormulaCheckbox.Checked = true;
                    Lb_Summ_String.Visible = true;
                    Lb_Summ_String.Value = stringSum;
                }
                else
                {
                    Lb_Summ_Numb.Visible = true;
                    //Lb_Summ_Numb.Value = (sumValue / 100).ToString("0.00");
                    Lb_Summ_Numb.Value = sumValue / 100;
                }
            }

            cmd.ExecuteNonQuery();

        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }


    /// <summary>
    /// Населення дат в календарі
    /// </summary>
    private void fill_data()
    {
        try
        {
            InitOraConnection();

            Calendar1.SelectedDates.Clear();
            Calendar2.SelectedDates.Clear();
            Calendar3.SelectedDates.Clear();
            Calendar4.SelectedDates.Clear();
            Calendar5.SelectedDates.Clear();
            Calendar6.SelectedDates.Clear();
            Calendar7.SelectedDates.Clear();
            Calendar8.SelectedDates.Clear();
            Calendar9.SelectedDates.Clear();
            Calendar10.SelectedDates.Clear();
            Calendar11.SelectedDates.Clear();
            Calendar12.SelectedDates.Clear();

            //SQL_Reader_Exec("SELECT fdat FROM  v_open_bankdates"); //v_open_bankdates
            SQL_Reader_Exec("SELECT dat FROM  sto_dat where idd = " + l_idd); //v_open_bankdates
            while (SQL_Reader_Read())
            {
                ArrayList row = SQL_Reader_GetValues();

                if (row.Count > 0)
                {
                    DateTime fDate = Convert.ToDateTime(row[0]);
                    //if (fDate < bDate)
                    //    continue;

                    Calendar1.SelectedDates.Add(fDate);
                    Calendar2.SelectedDates.Add(fDate);
                    Calendar3.SelectedDates.Add(fDate);
                    Calendar4.SelectedDates.Add(fDate);
                    Calendar5.SelectedDates.Add(fDate);
                    Calendar6.SelectedDates.Add(fDate);
                    Calendar7.SelectedDates.Add(fDate);
                    Calendar8.SelectedDates.Add(fDate);
                    Calendar9.SelectedDates.Add(fDate);
                    Calendar10.SelectedDates.Add(fDate);
                    Calendar11.SelectedDates.Add(fDate);
                    Calendar12.SelectedDates.Add(fDate);
                }
            }
            SQL_Reader_Close();
        }
        finally
        {
            DisposeOraConnection();
        }

    }

    /// <summary>
    /// Збереження змін дати
    /// </summary>
    /// <param name="dat_"></param>
    private void get_fdat(DateTime dat_)
    {
        //  DAT_.Text = Convert.ToString(dat_);
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            //if (tbFDat.Text.Length == 0) return;

            //DateTime dat = Convert.ToDateTime(tbFDat.Text, cinfo);

            InitOraConnection();
            {
                ClearParameters();
                SetParameters("DAT", DB_TYPE.Date, dat_, DIRECTION.Input);
                SetParameters("ldd", DB_TYPE.Decimal, Convert.ToString(l_idd), DIRECTION.Input);

                SQL_NONQUERY(" declare " +
                                "dat_ date   := :DAT;   " +
                                "l_idd number := :ldd;   " +
                                "begin  " +
                                "insert into  sto_dat(idd, dat) values (l_idd, dat_);" +
                                "exception  when others then" +
                                " if (sqlcode = -00001) then delete from sto_dat where dat = dat_ and idd = l_idd; else raise; end if;  " +
                                "end;");
            }
        }
        finally
        {
            DisposeOraConnection();
        }
        fill_data();
        //  DAT_.Text = "";
    }

    /// <summary>
    /// Призначення місяців в календарі
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Drlist_SelectedIndexChanged(object sender, EventArgs e)
    {
        DateTime bDate = Convert.ToDateTime("01/01/" + Drlist.SelectedValue);

        Calendar1.VisibleDate = bDate.AddMonths(0);
        Calendar2.VisibleDate = bDate.AddMonths(1);
        Calendar3.VisibleDate = bDate.AddMonths(2);
        Calendar4.VisibleDate = bDate.AddMonths(3);
        Calendar5.VisibleDate = bDate.AddMonths(4);
        Calendar6.VisibleDate = bDate.AddMonths(5);
        Calendar7.VisibleDate = bDate.AddMonths(6);
        Calendar8.VisibleDate = bDate.AddMonths(7);
        Calendar9.VisibleDate = bDate.AddMonths(8);
        Calendar10.VisibleDate = bDate.AddMonths(9);
        Calendar11.VisibleDate = bDate.AddMonths(10);
        Calendar12.VisibleDate = bDate.AddMonths(11);

        fill_data();
    }

    protected void Calendar_DayRender(object sender, DayRenderEventArgs e)
    {
        // Розукрасили  Суботи та неділі сірим кольором
        if (e.Day.Date.DayOfWeek.ToString("d") == "6" || e.Day.Date.DayOfWeek.ToString("d") == "0")
            e.Cell.BackColor = System.Drawing.Color.LightGray;

        // помітка відмічених днів
        if (e.Day.IsSelected == true) e.Cell.BackColor = System.Drawing.Color.Red;


        //режим чтения
        if (Request["mode"] == "RW") { e.Day.IsSelectable = true; }
        else { e.Day.IsSelectable = false; }

    }
    protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
    {
        // Субота і Неділя Червоним
        //if (e.Day.Date.DayOfWeek.ToString("d") == "6" || e.Day.Date.DayOfWeek.ToString("d") == "0")
        //{
        //    e.Cell.BackColor = System.Drawing.Color.LightGray;
        //    //    e.Cell.ForeColor = System.Drawing.Color.Yellow;
        //}

        Calendar_DayRender(sender, e);
        if (Calendar1.TodaysDate > e.Day.Date || Calendar1.VisibleDate > e.Day.Date || e.Day.Date >= Calendar1.VisibleDate.AddMonths(1))
            e.Day.IsSelectable = false;

        if (Calendar1.VisibleDate > e.Day.Date || e.Day.Date >= Calendar1.VisibleDate.AddMonths(1))
        {
            e.Cell.BackColor = System.Drawing.Color.White;
            e.Cell.Text = null;
        }
    }
    protected void Calendar2_DayRender(object sender, DayRenderEventArgs e)
    {
        //if (e.Day.Date.DayOfWeek.ToString("d") == "6" || e.Day.Date.DayOfWeek.ToString("d") == "0")
        //    e.Cell.BackColor = System.Drawing.Color.LightGray;
        Calendar_DayRender(sender, e);
        if (Calendar2.TodaysDate > e.Day.Date || Calendar2.VisibleDate > e.Day.Date || e.Day.Date >= Calendar2.VisibleDate.AddMonths(1))
            e.Day.IsSelectable = false;

        if (Calendar2.VisibleDate > e.Day.Date || e.Day.Date >= Calendar2.VisibleDate.AddMonths(1))
        {
            e.Cell.BackColor = System.Drawing.Color.White;
            e.Cell.Text = null;
        }
    }
    protected void Calendar3_DayRender(object sender, DayRenderEventArgs e)
    {
        //if (e.Day.Date.DayOfWeek.ToString("d") == "6" || e.Day.Date.DayOfWeek.ToString("d") == "0")
        //    e.Cell.BackColor = System.Drawing.Color.LightGray;
        Calendar_DayRender(sender, e);
        if (Calendar3.TodaysDate > e.Day.Date || Calendar3.VisibleDate > e.Day.Date || e.Day.Date >= Calendar3.VisibleDate.AddMonths(1))
            e.Day.IsSelectable = false;

        if (Calendar3.VisibleDate > e.Day.Date || e.Day.Date >= Calendar3.VisibleDate.AddMonths(1))
        {
            e.Cell.BackColor = System.Drawing.Color.White;
            e.Cell.Text = null;
        }

    }
    protected void Calendar4_DayRender(object sender, DayRenderEventArgs e)
    {
        //if (e.Day.Date.DayOfWeek.ToString("d") == "6" || e.Day.Date.DayOfWeek.ToString("d") == "0")
        //    e.Cell.BackColor = System.Drawing.Color.LightGray;
        Calendar_DayRender(sender, e);
        if (Calendar4.TodaysDate > e.Day.Date || Calendar4.VisibleDate > e.Day.Date || e.Day.Date >= Calendar4.VisibleDate.AddMonths(1))
            e.Day.IsSelectable = false;

        if (Calendar4.VisibleDate > e.Day.Date || e.Day.Date >= Calendar4.VisibleDate.AddMonths(1))
        {
            e.Cell.BackColor = System.Drawing.Color.White;
            e.Cell.Text = null;
        }

    }
    protected void Calendar5_DayRender(object sender, DayRenderEventArgs e)
    {
        //if (e.Day.Date.DayOfWeek.ToString("d") == "6" || e.Day.Date.DayOfWeek.ToString("d") == "0")
        //    e.Cell.BackColor = System.Drawing.Color.LightGray;
        Calendar_DayRender(sender, e);
        if (Calendar5.TodaysDate > e.Day.Date || Calendar5.VisibleDate > e.Day.Date || e.Day.Date >= Calendar5.VisibleDate.AddMonths(1))
            e.Day.IsSelectable = false;

        if (Calendar5.VisibleDate > e.Day.Date || e.Day.Date >= Calendar5.VisibleDate.AddMonths(1))
        {
            e.Cell.BackColor = System.Drawing.Color.White;
            e.Cell.Text = null;
        }

    }
    protected void Calendar6_DayRender(object sender, DayRenderEventArgs e)
    {
        // if (e.Day.Date.DayOfWeek.ToString("d") == "6" || e.Day.Date.DayOfWeek.ToString("d") == "0")
        //    e.Cell.BackColor = System.Drawing.Color.LightGray;
        Calendar_DayRender(sender, e);

        if (Calendar6.TodaysDate > e.Day.Date || Calendar6.VisibleDate > e.Day.Date || e.Day.Date >= Calendar6.VisibleDate.AddMonths(1))
            e.Day.IsSelectable = false;

        if (Calendar6.VisibleDate > e.Day.Date || e.Day.Date >= Calendar6.VisibleDate.AddMonths(1))
        {
            e.Cell.BackColor = System.Drawing.Color.White;
            e.Cell.Text = null;
        }
    }
    protected void Calendar7_DayRender(object sender, DayRenderEventArgs e)
    {
        //    // Розукрасили  Суботи та неділі сірим кольором
        //    if (e.Day.Date.DayOfWeek.ToString("d") == "6" || e.Day.Date.DayOfWeek.ToString("d") == "0" )
        //        e.Cell.BackColor = System.Drawing.Color.LightGray;


        //    // помітка відмічених днів
        //    if ( e.Day.IsSelected == true) e.Cell.BackColor = System.Drawing.Color.Red;

        Calendar_DayRender(sender, e);

        // Доступні для редагування  більше ситемної дати та вмежа місяця
        if (Calendar7.TodaysDate > e.Day.Date || Calendar7.VisibleDate > e.Day.Date || e.Day.Date >= Calendar7.VisibleDate.AddMonths(1))
            e.Day.IsSelectable = false;

        // Поза місецем, непоказуєм
        if (Calendar7.VisibleDate > e.Day.Date || e.Day.Date >= Calendar7.VisibleDate.AddMonths(1))
        {
            e.Cell.BackColor = System.Drawing.Color.White;
            e.Cell.Text = null;
        }

    }
    protected void Calendar8_DayRender(object sender, DayRenderEventArgs e)
    {
        //    if (e.Day.Date.DayOfWeek.ToString("d") == "6" || e.Day.Date.DayOfWeek.ToString("d") == "0")
        //        e.Cell.BackColor = System.Drawing.Color.LightGray;
        Calendar_DayRender(sender, e);
        if (Calendar8.TodaysDate > e.Day.Date || Calendar8.VisibleDate > e.Day.Date || e.Day.Date >= Calendar8.VisibleDate.AddMonths(1))
            e.Day.IsSelectable = false;

        if (Calendar8.VisibleDate > e.Day.Date || e.Day.Date >= Calendar8.VisibleDate.AddMonths(1))
        {
            e.Cell.BackColor = System.Drawing.Color.White;
            e.Cell.Text = null;
        }
    }
    protected void Calendar9_DayRender(object sender, DayRenderEventArgs e)
    {
        //if (e.Day.Date.DayOfWeek.ToString("d") == "6" || e.Day.Date.DayOfWeek.ToString("d") == "0")
        //    e.Cell.BackColor = System.Drawing.Color.LightGray;
        Calendar_DayRender(sender, e);
        if (Calendar9.TodaysDate > e.Day.Date || Calendar9.VisibleDate > e.Day.Date || e.Day.Date >= Calendar9.VisibleDate.AddMonths(1))
            e.Day.IsSelectable = false;

        if (Calendar9.VisibleDate > e.Day.Date || e.Day.Date >= Calendar9.VisibleDate.AddMonths(1))
        {
            e.Cell.BackColor = System.Drawing.Color.White;
            e.Cell.Text = null;
        }
    }
    protected void Calendar10_DayRender(object sender, DayRenderEventArgs e)
    {
        //if (e.Day.Date.DayOfWeek.ToString("d") == "6" || e.Day.Date.DayOfWeek.ToString("d") == "0")
        //    e.Cell.BackColor = System.Drawing.Color.LightGray;
        Calendar_DayRender(sender, e);
        if (Calendar10.TodaysDate > e.Day.Date || Calendar10.VisibleDate > e.Day.Date || e.Day.Date >= Calendar10.VisibleDate.AddMonths(1))
            e.Day.IsSelectable = false;

        if (Calendar10.VisibleDate > e.Day.Date || e.Day.Date >= Calendar10.VisibleDate.AddMonths(1))
        {
            e.Cell.BackColor = System.Drawing.Color.White;
            e.Cell.Text = null;
        }
    }
    protected void Calendar11_DayRender(object sender, DayRenderEventArgs e)
    {
        //if (e.Day.Date.DayOfWeek.ToString("d") == "6" || e.Day.Date.DayOfWeek.ToString("d") == "0")
        //    e.Cell.BackColor = System.Drawing.Color.LightGray;
        Calendar_DayRender(sender, e);
        if (Calendar11.TodaysDate > e.Day.Date || Calendar11.VisibleDate > e.Day.Date || e.Day.Date >= Calendar11.VisibleDate.AddMonths(1))
            e.Day.IsSelectable = false;

        if (Calendar11.VisibleDate > e.Day.Date || e.Day.Date >= Calendar11.VisibleDate.AddMonths(1))
        {
            e.Cell.BackColor = System.Drawing.Color.White;
            e.Cell.Text = null;
        }
    }
    protected void Calendar12_DayRender(object sender, DayRenderEventArgs e)
    {
        //if (e.Day.Date.DayOfWeek.ToString("d") == "6" || e.Day.Date.DayOfWeek.ToString("d") == "0")
        //    e.Cell.BackColor = System.Drawing.Color.LightGray;
        Calendar_DayRender(sender, e);
        if (Calendar12.TodaysDate > e.Day.Date || Calendar12.VisibleDate > e.Day.Date || e.Day.Date >= Calendar12.VisibleDate.AddMonths(1))
            e.Day.IsSelectable = false;

        if (Calendar12.VisibleDate > e.Day.Date || e.Day.Date >= Calendar12.VisibleDate.AddMonths(1))
        {
            e.Cell.BackColor = System.Drawing.Color.White;
            e.Cell.Text = null;
        }
    }

    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        get_fdat(Calendar1.SelectedDate);
    }
    protected void Calendar2_SelectionChanged(object sender, EventArgs e)
    {
        get_fdat(Calendar2.SelectedDate);
    }
    protected void Calendar3_SelectionChanged(object sender, EventArgs e)
    {
        get_fdat(Calendar3.SelectedDate);
    }
    protected void Calendar4_SelectionChanged(object sender, EventArgs e)
    {
        get_fdat(Calendar4.SelectedDate);
    }
    protected void Calendar5_SelectionChanged(object sender, EventArgs e)
    {
        get_fdat(Calendar5.SelectedDate);
    }
    protected void Calendar6_SelectionChanged(object sender, EventArgs e)
    {
        get_fdat(Calendar6.SelectedDate);
    }
    protected void Calendar7_SelectionChanged(object sender, EventArgs e)
    {
        get_fdat(Calendar7.SelectedDate);
    }
    protected void Calendar8_SelectionChanged(object sender, EventArgs e)
    {
        get_fdat(Calendar8.SelectedDate);
    }
    protected void Calendar9_SelectionChanged(object sender, EventArgs e)
    {
        get_fdat(Calendar9.SelectedDate);
    }
    protected void Calendar10_SelectionChanged(object sender, EventArgs e)
    {
        get_fdat(Calendar10.SelectedDate);
    }
    protected void Calendar11_SelectionChanged(object sender, EventArgs e)
    {
        get_fdat(Calendar11.SelectedDate);
    }
    protected void Calendar12_SelectionChanged(object sender, EventArgs e)
    {
        get_fdat(Calendar12.SelectedDate);
    }

    protected void Save_date_nazn_Click(object sender, EventArgs e)
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("START1"), con);

        try
        {
            cmd.CommandText = @"select d.ids, d.ord, d.tt, d.vob, d.dk, d.nlsa, d.kva, d.nlsb, d.kvb, d.mfob, d.polu, d.fsum, d.okpo, d.dat2, d.freq, d.dat0, d.wend, d.dr, d.branch
                                  from sto_det d,
                                       STO_LST l, customer c
                                 Where D.IDS = L.IDS
                                   and l.rnk = c.rnk
                                   and idd = :l_idd";
            cmd.Parameters.Add("l_idd", OracleDbType.Decimal, l_idd, ParameterDirection.Input);
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                var data = new
                {
                    ids = reader.GetDecimal(0),
                    ord = reader.GetDecimal(1),
                    tt = reader.GetString(2),
                    vob = reader.GetDecimal(3),
                    dk = reader.GetDecimal(4),
                    nlsa = reader.GetString(5),
                    kva = reader.GetDecimal(6),
                    nlsb = reader.GetString(7),
                    kvb = reader.GetDecimal(8),
                    mfob = reader.GetString(9),
                    polu = reader.GetString(10),
                    fsum = String.IsNullOrEmpty(reader.GetValue(11).ToString()) ? "" : reader.GetString(11),
                    okpo = reader.GetString(12),
                    dat2 = reader.GetDateTime(13), ///??
                    freq = reader.GetDecimal(14),
                    dat0 = String.IsNullOrEmpty(reader.GetValue(15).ToString()) ? (DateTime?)null : reader.GetDateTime(15), ///??
                    wend = reader.GetDecimal(16), ///??
                    dr = String.IsNullOrEmpty(reader.GetValue(17).ToString()) ? "" : reader.GetString(17),
                    branch = String.IsNullOrEmpty(reader.GetValue(18).ToString()) ? "" : reader.GetString(18)
                };

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();

                cmd.CommandText = @"bars.sto_all.add_det";
                cmd.Parameters.Add("IDS", OracleDbType.Decimal, data.ids, ParameterDirection.Input);
                cmd.Parameters.Add("ord", OracleDbType.Decimal, data.ord, ParameterDirection.Input);
                cmd.Parameters.Add("tt", OracleDbType.Varchar2, 3, data.tt, ParameterDirection.Input);
                cmd.Parameters.Add("vob", OracleDbType.Decimal, data.vob, ParameterDirection.Input);
                cmd.Parameters.Add("dk", OracleDbType.Decimal, data.dk, ParameterDirection.Input);
                cmd.Parameters.Add("nlsa", OracleDbType.Varchar2, 15, data.nlsa, ParameterDirection.Input);
                cmd.Parameters.Add("kva", OracleDbType.Decimal, data.kva, ParameterDirection.Input);
                cmd.Parameters.Add("nlsb", OracleDbType.Varchar2, 15, data.nlsb, ParameterDirection.Input);
                cmd.Parameters.Add("kvb", OracleDbType.Decimal, data.kvb, ParameterDirection.Input);
                cmd.Parameters.Add("mfob", OracleDbType.Varchar2, 12, data.mfob, ParameterDirection.Input);
                cmd.Parameters.Add("polu", OracleDbType.Varchar2, 38, data.polu, ParameterDirection.Input);
                cmd.Parameters.Add("nazn", OracleDbType.Varchar2, 160, Lb_nazn.Value, ParameterDirection.Input);

                string sumValue = (FormulaCheckbox.Checked) ? Lb_Summ_String.Value : (Lb_Summ_Numb.Value.Value * 100).ToString();
                cmd.Parameters.Add("fsum", OracleDbType.Varchar2, sumValue, ParameterDirection.Input);
                cmd.Parameters.Add("okpo", OracleDbType.Varchar2, 10, data.okpo, ParameterDirection.Input);
                cmd.Parameters.Add("DAT1", OracleDbType.Date, DATE_FROM.Value, ParameterDirection.Input);
                cmd.Parameters.Add("DAT2", OracleDbType.Date, data.dat2, ParameterDirection.Input);
                cmd.Parameters.Add("FREQ", OracleDbType.Decimal, data.freq, ParameterDirection.Input);
                cmd.Parameters.Add("DAT0", OracleDbType.Date, data.dat0, ParameterDirection.Input);
                cmd.Parameters.Add("WEND", OracleDbType.Decimal, data.wend, ParameterDirection.Input);
                cmd.Parameters.Add("DR", OracleDbType.Varchar2, 9, data.dr, ParameterDirection.Input);
                cmd.Parameters.Add("branch", OracleDbType.Varchar2, 30, data.branch, ParameterDirection.Input);
                cmd.Parameters.Add("idd", OracleDbType.Decimal, l_idd, ParameterDirection.Input);

                cmd.ExecuteNonQuery();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "alert('Зміни успішно збереженні');", true);
            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    protected void Check_Clicked(object sender, EventArgs e)
    {
        Lb_Summ_String.Value = "";
        Lb_Summ_Numb.Value = null;
        if (FormulaCheckbox.Checked)
        {
            Lb_Summ_String.Visible = true;
            Lb_Summ_Numb.Visible = false;
        }
        else
        {
            Lb_Summ_Numb.Visible = true;
            Lb_Summ_String.Visible = false;
        }
    }

    //protected void Summ_KeyPress(object sender, EventArgs e)
    //{
    //    if (!FormulaCheckbox.Checked)
    //    {
    //        const char Delete = (char)8;
    //        e.Handled = !Char.IsDigit(e.KeyChar) && e.KeyChar != Delete;
    //    }
    //}
}