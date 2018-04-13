using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;
using System.Data;
using System.Drawing;
using Oracle.DataAccess.Client;
using System.Globalization;
using Oracle.DataAccess.Types;
using System.Threading;
using System.Web.Security;
using Bars.UserControls;
using Bars.Web.Controls;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using Bars.Doc;

public partial class tools_retur_transfer : Bars.BarsPage
{
 
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    /// <summary>
    ///  Вікно з повідомленням
    /// </summary>
    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText.Replace("\n", "").Replace("\r", "") + "');", true);
    }

    /// <summary>
    /// Пошук референса виплати переказу 
    /// </summary>
    protected void Bt_Search_Click(object sender, ImageClickEventArgs e)
    {
        String Glbd;
        String Datdok;

        if (String.IsNullOrEmpty(Tb_Ref.Text))
        { ShowError("Ведіть референс документу виплати переказу!!! "); }
        else
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

            try
            {
                cmd.ExecuteNonQuery();
                cmd.Parameters.Add("REF_", OracleDbType.Int64, Convert.ToInt64(Tb_Ref.Text), ParameterDirection.Input);
                cmd.CommandText = (@" select o.ref , to_char(o.datd,'dd/mm/yyyy') as datd , to_char(p.s/100,'9999999990.00') as s, p.sq, o.nlsa, o.nam_a, '('||o.kv||')' as kv, a.nls, o.nazn, o.branch, tt.tt, tt.name , 
                                               f_dop(o.REF, 'FIO') as fio,
                                               f_dop(o.REF, 'NAMED') as NAMED,
                                               f_dop(o.REF, 'PASPN') as PASPN,
                                               f_dop(o.REF, 'ATRT ') as ATRT ,
                                               f_dop(o.REF, 'ADRES') as ADRES, to_char(sysdate,'dd/mm/yyyy') as bdate
                                         from oper o, opldok p, accounts a, tts tt
                                          where o.ref = p.ref     and
                                                p.acc = a.acc     and
                                                p.dk = 0          and p.sos = 5 and
                                                a.nbs = '2809'    and 
                                                a.ob22 in (select ob22_2809 from SWI_MTI_LIST )   
                                                and o.tt = tt.tt
                                                --and p.fdat > to_date('01012013','ddmmyyyy')
                                                and o.ref = :REF_
                                                --and f_dop(o.REF, 'PASPN') is not null   ");

                OracleDataReader rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    Pn_ref.Visible = true;
                    Lb_err.Visible = false;

                    Lb_reason.Visible = true;
                    Tb_reason.Visible = true;
                    Lb_kom.Visible = true;
                    Lb_kom1.Visible = true;

                    Bt_Ret_Pay.Visible = true;
                    Tb_Ref.Enabled = false;
                    Bt_Search.Visible = false;


                    LinREF.Visible = true;
                    Lb_linRef.Visible = true;
                    LinREF.Text = Convert.ToString(Tb_Ref.Text);
                    LinREF.NavigateUrl = "/barsroot/documentview/default.aspx?ref=" + Convert.ToString(Tb_Ref.Text);


                    LinREF.Attributes.Add("onclick",
                      "javascript:" +
                      "window.showModalDialog(" +
                      LinREF.ClientID + ".href," +
                      "'ModalDialog'," +
                      "'dialogHeight:600px; dialogLeft:100px; dialogTop:100px; dialogWidth:1100px; help:no; resizable:yes; scroll:yes;'" +
                      ");" +
                      "return false;"
                      );



                    Lb_nlsa1.Text = rdr["NLSA"] == DBNull.Value ? (String)null : (String)rdr["NLSA"];
                    Lb_nlsa2.Text = rdr["NAM_A"] == DBNull.Value ? (String)null : (String)rdr["NAM_A"];

                    Lb_SumN.Text = rdr["S"]  == DBNull.Value ? (String)null : (String)rdr["S"];
                    Lb_Kv.Text   = rdr["KV"] == DBNull.Value ? (String)null : (String)rdr["KV"];

                    Lb_Nazn1.Text = rdr["NAZN"] == DBNull.Value ? (String)null : (String)rdr["NAZN"];
                    Lb_fio1.Text = rdr["FIO"] == DBNull.Value ? (String)null : (String)rdr["FIO"];
                    Lb_tdok1.Text = rdr["NAMED"] == DBNull.Value ? (String)null : (String)rdr["NAMED"];
                    Lb_paspn1.Text = rdr["PASPN"] == DBNull.Value ? (String)null : (String)rdr["PASPN"];
                    Lb_ATRT1.Text = rdr["ATRT"] == DBNull.Value ? (String)null : (String)rdr["ATRT"];
                    Lb_ADRES1.Text = rdr["ADRES"] == DBNull.Value ? (String)null : (String)rdr["ADRES"];
                    Glbd = rdr["BDATE"] == DBNull.Value ? (String)null : (String)rdr["BDATE"];
                    Datdok = rdr["DATD"] == DBNull.Value ? (String)null : (String)rdr["DATD"];
                    Lb_pdat1.Text = Datdok;
                    Lb_GLBD.Text = Glbd;

                    if (Glbd == Datdok)
                    {
                        Lb_kom.Visible = false;
                        Lb_kom1.Visible = false;
                        Lb_kom1.Text = "0";
                    }
                    else
                    {
                        Lb_kom.Visible = true;
                        Lb_kom1.Visible = true;
                        Lb_kom1.Text = null;
                    }

                    

                }
                else
                {
                    ShowError("Документ не знайдено");
                    LinREF.Visible = false;
                    Lb_linRef.Visible = false;
                    Pn_ref.Visible = false;


                    Lb_reason.Visible = false;
                    Tb_reason.Visible = false;
                    Lb_kom.Visible = false;
                    Lb_kom1.Visible = false;

                    Bt_Ret_Pay.Visible = false;

                    Tb_Ref.Enabled = true;
                    Bt_Search.Visible = true;
                }


                rdr.Close();
                rdr.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }

    /// <summary>
    /// Проведення операції повернення коштів 
    /// </summary>
    protected void Bt_Ret_Pay_Click(object sender, System.EventArgs e)
    {
        Decimal? ErrCode;
        String ErrMessage;
        Decimal? Out_Ref;


        Lb_kom1.Text = Lb_kom1.Text.Replace(",", ".");

        if ((String.IsNullOrEmpty(Lb_kom1.Text) || ( Lb_GLBD.Text != Lb_pdat1.Text) && Lb_kom1.Text == "0"))
        {
            ShowError("Не заповнено суму комісії!");
            return;
        }
            
            if (String.IsNullOrEmpty(Tb_reason.Text))
        {
            ShowError("Не заповнено причину поверення переказу!");
            return; 
        }



            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
            try
            {
                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "Return_Tranfer";
                cmd.Parameters.Add("REF_", OracleDbType.Int64, Convert.ToUInt64(Tb_Ref.Text), ParameterDirection.Input);
                cmd.Parameters.Add("REASON_", OracleDbType.Varchar2, Tb_reason.Text, ParameterDirection.Input);
                cmd.Parameters.Add("S_kom_", OracleDbType.Decimal, Convert.ToDecimal(Lb_kom1.Text), ParameterDirection.Input);
                cmd.Parameters.Add("ERR_Code", OracleDbType.Decimal, null, ParameterDirection.Output);
                cmd.Parameters.Add("ERR_Message", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                cmd.Parameters.Add("Out_Ref", OracleDbType.Decimal, null, ParameterDirection.Output);

                cmd.ExecuteNonQuery();

                ErrCode = ((OracleDecimal)cmd.Parameters["ERR_Code"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmd.Parameters["ERR_Code"].Value).Value;
                ErrMessage = ((OracleString)cmd.Parameters["ERR_Message"].Value).IsNull ? (String)null : ((OracleString)cmd.Parameters["ERR_Message"].Value).Value;
                Out_Ref = ((OracleDecimal)cmd.Parameters["Out_Ref"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmd.Parameters["Out_Ref"].Value).Value;

                // анализируем результат
                //if (ErrCode.HasValue)
                if (ErrCode == 1) 
                {
                    ShowError(ErrMessage);
                }
                else
                {
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "alert('Дані збережено'); ", true);
                    Bt_Ret_Pay.Enabled = false;
                    Tb_reason.Enabled  = false;
                    Lb_kom1.Enabled = false;


                    
                    
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "window.showModalDialog('/barsroot/documentview/default.aspx?ref=" + Convert.ToString(Out_Ref) + "', 'aaaa', 'dialogHeight:600px; dialogLeft:100px; dialogTop:100px; dialogWidth:1100px; help:no; resizable:yes; scroll:yes;" + "')", true);
                    
                    LinRef2.Visible = true;
                    LinRef2.Text = Convert.ToString(Out_Ref);
                    LinRef2.NavigateUrl = "/barsroot/documentview/default.aspx?ref=" + Convert.ToString(Out_Ref);


                    LinRef2.Attributes.Add("onclick",
                      "javascript:" +
                      "window.showModalDialog(" +
                      LinRef2.ClientID + ".href," +
                      "'ModalDialog'," +
                      "'dialogHeight:600px; dialogLeft:100px; dialogTop:100px; dialogWidth:1100px; help:no; resizable:yes; scroll:yes;'" +
                      ");" +
                      "return false;"
                      );
                    
                }
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

    }
}