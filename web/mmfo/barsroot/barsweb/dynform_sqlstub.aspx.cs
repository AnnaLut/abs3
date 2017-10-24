using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Data;
using System.Globalization;


public partial class barsweb_dynform_sqlstub : Bars.BarsPage
{
    public enum StubTypes { kazfin, none }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["tp"] == StubTypes.kazfin.ToString())
        {
            if (!String.IsNullOrEmpty(Request["idu"]))
            {

                OracleString nls = String.Empty;
                OracleDecimal s = -1;
                OracleString nazn = String.Empty;

                IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
                OracleConnection oraCon = conn.GetUserConnection(HttpContext.Current);

                try
                {

                    OracleCommand comm = oraCon.CreateCommand();
                    comm.CommandType = System.Data.CommandType.Text;
                    comm.CommandText = "begin  get_rah(:id_, :nls_, :s_, :nazn_); end;";
                    comm.BindByName = true;

                    comm.Parameters.Add(new OracleParameter("id_", OracleDbType.Decimal, Request["idu"], ParameterDirection.Input));
                    comm.Parameters.Add(new OracleParameter("nls_", OracleDbType.Varchar2, 15, nls, ParameterDirection.Output));
                    comm.Parameters.Add(new OracleParameter("s_", OracleDbType.Decimal, s, ParameterDirection.Output));
                    comm.Parameters.Add(new OracleParameter("nazn_", OracleDbType.Varchar2, 160, nazn, ParameterDirection.Output));

                    comm.ExecuteNonQuery();

                    nls = (OracleString)comm.Parameters["nls_"].Value;
                    s =(OracleDecimal)comm.Parameters["s_"].Value;
                    nazn = (OracleString)comm.Parameters["nazn_"].Value;


                }
                finally
                {
                    oraCon.Close();
                    oraCon.Dispose();
                    oraCon = null;
                }

                if (!nls.IsNull)
                {
                    string newUrl = Request.Url.ToString().Replace("barsweb/dynform_sqlstub.aspx", "docinput/docinput.aspx") + 
                                    //"&DisR=1&reqv_IDFZ=" + Request["idu"] + 
                                    "&APROC=" + "set role BARS_ACCESS_DEFROLE@" + "begin bars.p_payZobDoc(" + Request["idu"] + ",:REF);end;" +
                                    "&nls_a=" + nls.Value + 
                                    "&SumC_t=" + s.ToString() + 
                                    "&nazn=" + HttpUtility.UrlEncode(nazn.Value);//UrlEncode

                    Response.Redirect(newUrl, true);
                }

            }
        }

        if (!String.IsNullOrEmpty(Request["dep_num"]) && !String.IsNullOrEmpty(Request["dep_date"]))
        {
           // OracleString dep_num = Request["dep_cum"].ToString();
           // OracleString dep_date = Request["dep_date"].ToString();
           // OracleDate dep_dates = Convert.ToDateTime(Request["dep_date"].ToString(),dd.mm.yyyy);

            string str = Request["dep_date"].ToString();

            var dt = DateTime.ParseExact(str, "dd.MM.yyyy",  CultureInfo.InvariantCulture);

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

                    comm.Parameters.Add(new OracleParameter("dep_num_", OracleDbType.Decimal, Request["dep_num"], ParameterDirection.Input));
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

               // if (!fio.IsNull)
               // {
                //DateTime p_dat_end = dat_end.IsNull ? DateTime.Now: dat_end.Value;
                //DateTime p_termination_date = termination_date.IsNull ? DateTime.Now : termination_date.Value;
                //string p_kv = kv.IsNull ? string.Empty : kv.Value;
                //decimal p_balance = balance.IsNull ? 0 : balance.Value;
                //decimal p_penalty_sum = penalty_sum.IsNull ? 0 : penalty_sum.Value;
                //string p_fio = fio.IsNull ? string.Empty : fio.Value;
                //DateTime p_birth_date = birth_date.IsNull ? DateTime.Now : birth_date.Value;
                //string p_inn = inn.IsNull ? string.Empty : inn.Value;
                //string p_doc = doc.IsNull ? string.Empty : doc.Value;
                //decimal p_res_code = result_code.IsNull ? 0 : result_code.Value;
                //string p_res_text = result_text.IsNull ? string.Empty : result_text.Value.ToString();

                Session["p_dat_end"] = dat_end.IsNull ? DateTime.Now: dat_end.Value;
                Session["p_termination_date"] = termination_date.IsNull ? DateTime.Now : termination_date.Value;
                Session["p_kv"] = kv.IsNull ? string.Empty : kv.Value;
                Session["p_balance"] = balance.IsNull ? 0 : balance.Value;
                Session["p_penalty_sum"] = penalty_sum.IsNull ? 0 : penalty_sum.Value;
                Session["p_fio"] = fio.IsNull ? string.Empty : fio.Value;
                Session["p_birth_date"] = birth_date.IsNull ? DateTime.Now : birth_date.Value;
                Session["p_inn"] = inn.IsNull ? string.Empty : inn.Value;
                Session["p_doc"] = doc.IsNull ? string.Empty : doc.Value;
                Session["p_res_code"] = result_code.IsNull ? 0 : result_code.Value;
                Session["p_res_text"] = result_text.IsNull ? string.Empty : "'" + result_text.Value.ToString() + "'" ;

                //if (dat_end.Value != null)
                //{
                //    p_dat_end = dat_end.Value.ToString();
                //}
                //else
                //{
                //    p_dat_end = "b";
                //}

                if (result_code.Value > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "sdf1", "alert('" + result_text.Value.ToString() + "');window.navigate('/barsroot/barsweb/dynform.aspx?form=frm_dep_broken_period_serch');", true);
                    return;

                }

                if (String.IsNullOrEmpty(Request["ndep_num"]) && String.IsNullOrEmpty(Request["ndep_date"]))
                {
                    string newUrl = Request.Url.ToString().Replace("barsweb/dynform_sqlstub.aspx?", "/barsweb/dynform.aspx?form=frm_dep_broken_period_old_view&");// +
                    //"&dat_end=" + p_dat_end +
                    //"&termination_date=" + p_termination_date+
                    //"&kv=" + p_kv+
                    //"&balance=" + p_balance+
                    //"&penalty_sum=" + p_penalty_sum+
                    //"&fio=" + p_fio+
                    //"&birth_date=" + p_birth_date+
                    //"&inn=" + p_inn+
                    //"&doc=" + p_doc+
                    //"&res_code=" + p_res_code+
                    //"&res_text=" + p_res_text;

                    Response.Redirect(newUrl, true);
                }
                else
                {
                    string nstr = Request["ndep_date"].ToString();

                    var ndt = DateTime.ParseExact(nstr, "dd.MM.yyyy", CultureInfo.InvariantCulture);

                   // OracleDate ndat_begin = OracleDate.Null;
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

                        ncomm.Parameters.Add(new OracleParameter("old_dpt_id_", OracleDbType.Decimal, Request["dep_num"], ParameterDirection.Input));
                        ncomm.Parameters.Add(new OracleParameter("ndep_num_", OracleDbType.Decimal, Request["ndep_num"], ParameterDirection.Input));
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

                  

                    Session["p_ndat_end"] = ndat_end.IsNull ? DateTime.Now : ndat_end.Value;
                    Session["p_nkv"] = nkv.IsNull ? string.Empty : nkv.Value;
                    Session["p_nsum"] = nsum.IsNull ? 0 : nsum.Value;
                    Session["p_nfio"] = nfio.IsNull ? string.Empty : nfio.Value;
                    Session["p_nbirth_date"] = nbirth_date.IsNull ? DateTime.Now : nbirth_date.Value;
                    Session["p_ninn"] = ninn.IsNull ? string.Empty : ninn.Value;
                    Session["p_ndoc"] = ndoc.IsNull ? string.Empty : ndoc.Value;
                    Session["p_nres_code"] = nresult_code.IsNull ? 0 : nresult_code.Value;
                    Session["p_nres_text"] = nresult_text.IsNull ? string.Empty : "'" + nresult_text.Value.ToString() + "'";


                    if (nresult_code.Value > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "sdf1", "alert('" + nresult_text.Value.ToString() + "');window.navigate('/barsroot/barsweb/dynform.aspx?form=frm_dep_broken_period_serch');", true);
                        return;

                    }
                    
                    if (!String.IsNullOrEmpty(Request["ndep_num"]) && !String.IsNullOrEmpty(Request["ndep_date"]))
                    {
                        string newUrl = Request.Url.ToString().Replace("barsweb/dynform_sqlstub.aspx?", "/barsweb/dynform.aspx?form=frm_dep_broken_period_binding&");// +
                    
                        Response.Redirect(newUrl, true);
                    }
                }
              //  }

            }
        }
        }
    
