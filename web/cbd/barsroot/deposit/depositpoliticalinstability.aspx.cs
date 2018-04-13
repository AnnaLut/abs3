using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using System.Data;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Types;
using System.Globalization;

public partial class deposit_depositpoliticalinstability : Bars.BarsPage
{
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    /// <summary>
    /// 
    /// </summary>

    protected void btOldSearh_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(tbOldNum.Text))
        {


            string str = deOldStartDate.Date.ToString().Substring(0, 10).Replace("/", ".");
            lbError.Text = "";

            var dt = DateTime.ParseExact(str, "dd.MM.yyyy", CultureInfo.InvariantCulture);

            OracleDate dat_end = OracleDate.Null;
            OracleDate termination_date = OracleDate.Null;
            OracleString kv = String.Empty;
            OracleDecimal balance = 0;
            OracleDecimal penalty_sum = 0;
            OracleString fio = String.Empty;
            OracleDate birth_date = OracleDate.Null;
            OracleString inn = String.Empty;
            OracleString doc = String.Empty;
            OracleDecimal result_code = 0;
            OracleString result_text = String.Empty;

            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            OracleConnection oraCon = conn.GetUserConnection(HttpContext.Current);

            try
            {

                OracleCommand comm = oraCon.CreateCommand();
                comm.CommandType = System.Data.CommandType.Text;
                comm.CommandText = "begin  p_dpt_pi_find_terminated(:dep_num_ , :dep_date_, :dat_end_, :termination_date_, :kv_,:balance_,:penalty_sum_,:fio_,:birth_date_,:inn_,:doc_,:result_code_,:result_text_); end;";
                comm.BindByName = true;

                comm.Parameters.Add(new OracleParameter("dep_num_", OracleDbType.Decimal, tbOldNum.Text, ParameterDirection.Input));
                comm.Parameters.Add(new OracleParameter("dep_date_", OracleDbType.Date, dt, ParameterDirection.Input));
                comm.Parameters.Add(new OracleParameter("dat_end_", OracleDbType.Date, dat_end, ParameterDirection.Output));
                comm.Parameters.Add(new OracleParameter("termination_date_", OracleDbType.Date, termination_date, ParameterDirection.Output));
                comm.Parameters.Add(new OracleParameter("kv_", OracleDbType.Varchar2, 3, kv, ParameterDirection.Output));
                comm.Parameters.Add(new OracleParameter("balance_", OracleDbType.Decimal, balance, ParameterDirection.Output));
                comm.Parameters.Add(new OracleParameter("penalty_sum_", OracleDbType.Decimal, penalty_sum, ParameterDirection.Output));
                comm.Parameters.Add(new OracleParameter("fio_", OracleDbType.Varchar2, 250, fio, ParameterDirection.Output));
                comm.Parameters.Add(new OracleParameter("birth_date_", OracleDbType.Date, birth_date, ParameterDirection.Output));
                comm.Parameters.Add(new OracleParameter("inn_", OracleDbType.Varchar2, 250, inn, ParameterDirection.Output));
                comm.Parameters.Add(new OracleParameter("doc_", OracleDbType.Varchar2, 250, doc, ParameterDirection.Output));
                comm.Parameters.Add(new OracleParameter("result_code_", OracleDbType.Decimal, result_code, ParameterDirection.Output));
                comm.Parameters.Add(new OracleParameter("result_text_", OracleDbType.Varchar2, 250, result_text, ParameterDirection.Output));


                comm.ExecuteNonQuery();

                dat_end = (OracleDate)comm.Parameters["dat_end_"].Value;
                termination_date = (OracleDate)comm.Parameters["termination_date_"].Value;
                kv = (OracleString)comm.Parameters["kv_"].Value;
                balance = (OracleDecimal)comm.Parameters["balance_"].Value;
                penalty_sum = (OracleDecimal)comm.Parameters["penalty_sum_"].Value;
                fio = (OracleString)comm.Parameters["fio_"].Value;
                birth_date = (OracleDate)comm.Parameters["birth_date_"].Value;
                inn = (OracleString)comm.Parameters["inn_"].Value;
                doc = (OracleString)comm.Parameters["doc_"].Value;
                result_code = (OracleDecimal)comm.Parameters["result_code_"].Value;
                result_text = (OracleString)comm.Parameters["result_text_"].Value;

            }
            finally
            {
                oraCon.Close();
                oraCon.Dispose();
                oraCon = null;
            }

            deOldDateEnd.Date = dat_end.IsNull ? DateTime.Now : dat_end.Value;
            deTerminatedDate.Date = termination_date.IsNull ? DateTime.Now : termination_date.Value;
            tbKv.Text = kv.IsNull ? string.Empty : kv.Value;
            nbBalance.Value = balance.IsNull ? 0 : balance.Value;
            nePenalty.Value = penalty_sum.IsNull ? 0 : penalty_sum.Value;
            tbFio.Text = fio.IsNull ? string.Empty : fio.Value;
            deBirthDate.Date = birth_date.IsNull ? DateTime.Now : birth_date.Value;
            tbInn.Text = inn.IsNull ? string.Empty : inn.Value;
            tbDoc.Text = doc.IsNull ? string.Empty : doc.Value;

            tbOldDpnum.Text = tbOldNum.Text;
            deOldDepDate.Date = deOldStartDate.Date;


            decimal p_res_code = result_code.IsNull ? 0 : result_code.Value;
            string p_res_text = result_text.IsNull ? string.Empty : " " + result_text.Value.ToString() + " ";


            if (p_res_code > 0)
            {
                lbError.Text = p_res_text;

                pnlOldResults.Visible = false;


            }
            else
            {
                pnlOldResults.Visible = true;
                btNext.Visible = true;

            }

        }
        else
        {

            if (String.IsNullOrEmpty(tbOldNum.Text))
            {
                lbError.Text = "Не вказано номер договору";
            }

        }


    }
    protected void btNext_Click(object sender, EventArgs e)
    {
        pnlOldResults.Visible = false;
        btNext.Visible = false;

        tbOldNum.Visible = false;
        deOldStartDate.Visible = false;

        tbNewNum.Visible = true;
        deNewStartDate.Visible = true;

        btNewSearh.Visible = true;
        btOldSearh.Visible = false;

        lbTitle.Text = "Пошук нового договору";
        panelSerchOld.GroupingText = "Параметри пошуку нового договору";
    }

    protected void btNewSearh_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(tbNewNum.Text))
        {


            string nstr = deNewStartDate.Date.ToString().Substring(0, 10).Replace("/", ".");

            var ndt = DateTime.ParseExact(nstr, "dd.MM.yyyy", CultureInfo.InvariantCulture);

            lbError.Text = "";

            OracleDate ndat_end = OracleDate.Null;
            OracleDate ntermination_date = OracleDate.Null;
            OracleString nkv = String.Empty;
            OracleDecimal nsum = 0;
            OracleString nfio = String.Empty;
            OracleDate nbirth_date = OracleDate.Null;
            OracleString ninn = String.Empty;
            OracleString ndoc = String.Empty;
            OracleDecimal nresult_code = 0;
            OracleString nresult_text = String.Empty;



            IOraConnection nconn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            OracleConnection noraCon = nconn.GetUserConnection(HttpContext.Current);

            try
            {

                OracleCommand ncomm = noraCon.CreateCommand();
                ncomm.CommandType = System.Data.CommandType.Text;
                ncomm.CommandText = "begin  p_dpt_pi_find_new(:old_dpt_id_,:ndep_num_ , :ndep_date_, :ndat_end_, :nkv_,:nsum_,:nfio_,:nbirth_date_,:ninn_,:ndoc_,:nresult_code_,:nresult_text_); end;";
                ncomm.BindByName = true;

                ncomm.Parameters.Add(new OracleParameter("old_dpt_id_", OracleDbType.Decimal, tbOldNum.Text, ParameterDirection.Input));
                ncomm.Parameters.Add(new OracleParameter("ndep_num_", OracleDbType.Decimal, tbNewNum.Text, ParameterDirection.Input));
                ncomm.Parameters.Add(new OracleParameter("ndep_date_", OracleDbType.Date, ndt, ParameterDirection.Input));
                ncomm.Parameters.Add(new OracleParameter("ndat_end_", OracleDbType.Date, ndat_end, ParameterDirection.Output));
                ncomm.Parameters.Add(new OracleParameter("nkv_", OracleDbType.Varchar2, 3, nkv, ParameterDirection.Output));
                ncomm.Parameters.Add(new OracleParameter("nsum_", OracleDbType.Decimal, nsum, ParameterDirection.Output));
                ncomm.Parameters.Add(new OracleParameter("nfio_", OracleDbType.Varchar2, 250, nfio, ParameterDirection.Output));
                ncomm.Parameters.Add(new OracleParameter("nbirth_date_", OracleDbType.Date, nbirth_date, ParameterDirection.Output));
                ncomm.Parameters.Add(new OracleParameter("ninn_", OracleDbType.Varchar2, 250, ninn, ParameterDirection.Output));
                ncomm.Parameters.Add(new OracleParameter("ndoc_", OracleDbType.Varchar2, 250, ndoc, ParameterDirection.Output));
                ncomm.Parameters.Add(new OracleParameter("nresult_code_", OracleDbType.Decimal, nresult_code, ParameterDirection.Output));
                ncomm.Parameters.Add(new OracleParameter("nresult_text_", OracleDbType.Varchar2, 250, nresult_text, ParameterDirection.Output));


                ncomm.ExecuteNonQuery();


                ndat_end = (OracleDate)ncomm.Parameters["ndat_end_"].Value;
                nkv = (OracleString)ncomm.Parameters["nkv_"].Value;
                nsum = (OracleDecimal)ncomm.Parameters["nsum_"].Value;
                nfio = (OracleString)ncomm.Parameters["nfio_"].Value;
                nbirth_date = (OracleDate)ncomm.Parameters["nbirth_date_"].Value;
                ninn = (OracleString)ncomm.Parameters["ninn_"].Value;
                ndoc = (OracleString)ncomm.Parameters["ndoc_"].Value;
                nresult_code = (OracleDecimal)ncomm.Parameters["nresult_code_"].Value;
                nresult_text = (OracleString)ncomm.Parameters["nresult_text_"].Value;

            }
            finally
            {
                noraCon.Close();
                noraCon.Dispose();
                noraCon = null;
            }


            deNewEndDate.Date = ndat_end.IsNull ? DateTime.Now : ndat_end.Value;
            tbNewKv.Text = nkv.IsNull ? string.Empty : nkv.Value;
            neNewBalance.Value = nsum.IsNull ? 0 : nsum.Value;
            tbNewFio.Text = nfio.IsNull ? string.Empty : nfio.Value;
            deNewBirthDate.Date = nbirth_date.IsNull ? DateTime.Now : nbirth_date.Value;
            tbNewInn.Text = ninn.IsNull ? string.Empty : ninn.Value;
            tbNewDoc.Text = ndoc.IsNull ? string.Empty : ndoc.Value;

            decimal p_nres_code = nresult_code.IsNull ? 0 : nresult_code.Value;
            string p_nres_text = nresult_text.IsNull ? string.Empty : " " + nresult_text.Value.ToString() + " ";



            tbNewDPNum.Text = tbNewNum.Text;
            deNewDPStartDate.Date = deNewStartDate.Date;

            if (p_nres_code > 0)
            {
                lbError.Text = p_nres_text;
                pnlOldResults.Visible = false;
                panelNewResult.Visible = false;

            }
            else
            {
                pnlOldResults.Visible = true;
                panelNewResult.Visible = true;

                lbTitle.Text = "З`язка договорів";
                panelSerchOld.GroupingText = "Доступні дії";

                lbOldNum.Visible = true;
                tbNewNum.Visible = true;

                lbOldStartDate.Visible = true;
                deNewStartDate.Visible = true;

                btNewSearh.Visible = true;
                btNext.Visible = false;
                btBunch.Visible = true;

            }

        }
        else
        {

            if (String.IsNullOrEmpty(tbNewNum.Text))
            {
                lbError.Text = "Не вказано номер договору";
            }

        }


    }
    protected void btBunch_Click(object sender, EventArgs e)
    {
        IOraConnection nconn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
        OracleConnection noraCon = nconn.GetUserConnection(HttpContext.Current);

        try
        {

            OracleCommand ncomm = noraCon.CreateCommand();
            ncomm.CommandType = System.Data.CommandType.Text;
            ncomm.CommandText = "begin  p_dpt_pi_set(:old_dpt_id_,:new_dpt_id_); end;";
            ncomm.BindByName = true;

            ncomm.Parameters.Add(new OracleParameter("old_dpt_id_", OracleDbType.Decimal, tbOldNum.Text, ParameterDirection.Input));
            ncomm.Parameters.Add(new OracleParameter("new_dpt_id_", OracleDbType.Decimal, tbNewNum.Text, ParameterDirection.Input));


            ncomm.ExecuteNonQuery();

        }
        finally
        {
            noraCon.Close();
            noraCon.Dispose();
            noraCon = null;

            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "sdf1", "alert('З`язку договорів " + tbOldDpnum.Text + " та " + tbNewDPNum.Text + "  виконано. ');window.navigate('/barsroot/barsweb/dynform.aspx?form=frm_dep_broken_in_period_view');", true);

        }

    }
}