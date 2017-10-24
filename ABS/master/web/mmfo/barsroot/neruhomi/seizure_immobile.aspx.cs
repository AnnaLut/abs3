using System;
using System.Collections.Generic;
using System.Collections;
using Bars.Classes;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Web.UI.HtmlControls;
using Oracle.DataAccess.Client;
using System.Globalization;
using Oracle.DataAccess.Types;
using System.Threading;
using System.Web.Security;
using Bars.UserControls;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;




public partial class seizure_immobile : Bars.BarsPage
{
    protected OracleConnection con;

    private void FillData()
    {
        Response.Redirect(String.Format("/barsroot/neruhomi/seizure_immobile.aspx?key={0}", Request["KEY"]));
    }


    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            bt_save.Enabled = false;
            bt_pay.Enabled = false;


            try
            {
                InitOraConnection();

                if (Request["KEY"] != null)
                {
                    SetParameters("key", DB_TYPE.Varchar2, Request["KEY"], DIRECTION.Input);
                    SQL_Reader_Exec(@"select 
                                           (select fio from part_pay_immobile where key=a.key and status=2) fio, 
                                           (select mfob from part_pay_immobile  where key=a.key and status=2) mfo, 
                                           (select okpob from part_pay_immobile  where key=a.key and status=2) okpo, 
                                           a.kv, 
                                            (select nls from part_pay_immobile  where key=a.key and status=2) nls, 
                                           (a.ost-f_part_sum_immobile(a.key))/100 ost, 
                                            a.comments , 
                                           f_part_sum_immobile_seizure(a.key)/100, 
                                           (select status from part_pay_immobile  where key=a.key and status=2) status, 
                                           a.fio
                                         from asvo_immobile a
                                        where a.key=:key ");
                    while (SQL_Reader_Read())
                    {
                        ArrayList reader = SQL_Reader_GetValues();
                        lbNMK.Text = Convert.ToString(reader[0]);
                        lbMFO.Value = Convert.ToString(reader[1]);
                        if (!String.IsNullOrEmpty(reader[2].ToString()))
                        {
                            lbOKPO.Text =  Convert.ToString(reader[2]);
                        }
                       
                        lbKV.Text = Convert.ToString(reader[3]);
                        tbNLS.Text = Convert.ToString(reader[4]);
                        tbSUM_FULL.Text = Convert.ToString(reader[5]);
                        tbComments.Text = Convert.ToString(reader[6]);
                        tbSumSeizure.Text = Convert.ToString(reader[7]);
                        String status = Convert.ToString(reader[8]);
                        tbSender.Text = Convert.ToString(reader[9]);


                        if (status == "2")
                        {
                            tbSumSeizure.Enabled = false;
                            tbComments.Enabled = false;
                            tbSumSeizure.MaxValue = Convert.ToDouble(tbSUM_FULL.Text)+ Convert.ToDouble(tbSumSeizure.Text);
                        }
                        else

                        {
                             tbSumSeizure.MaxValue = Convert.ToDouble(tbSUM_FULL.Text);
                        }

                    }
                    SQL_Reader_Close();
                }
            }
            finally
            {
                DisposeOraConnection();
            }


        }

    }

    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText + "');", true);
    }

    protected void bt_Cencel_Click(object sender, EventArgs e)
    {
        FillData();
    }

    protected void bt_back_Click(object sender, EventArgs e)
    {
        Response.Redirect("/barsroot/neruhomi/confirm_immobile.aspx");
    }
    protected void tbNLS_TextChanged(object sender, EventArgs e)
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            // установка роли
            cmd.ExecuteNonQuery();
            cmd.CommandText = "select translate(:p_nls,'#0123456789','#') NAME, vkrzn(substr(:p_mfo,1,5),nvl(:p_nls2,'2')) NLS from dual";
            cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, tbNLS.Text, ParameterDirection.Input);
            cmd.Parameters.Add("p_mfo", OracleDbType.Varchar2, lbMFO.Value, ParameterDirection.Input);
            cmd.Parameters.Add("p_nls2", OracleDbType.Varchar2, tbNLS.Text, ParameterDirection.Input);
            OracleDataReader rdr = cmd.ExecuteReader();
            if (tbNLS.Text.Length < 5)
            {
                lbERR.Text = "** - УВАГА! Номер рахунку повинен містити не менше 5 символів!";
                bt_save.Enabled = false;
                bt_save.ImageUrl = "/Common/Images/default/24/disk_gray.png";
                bt_pay.Enabled = false;
                bt_pay.ImageUrl = "/Common/Images/default/24/check_gray.png";
                return;
            }
            if (rdr.Read())
            {
                if (rdr["NAME"] == DBNull.Value)
                {
                    lbERR.Text = "";
                    bt_save.Enabled = true;
                    bt_save.ImageUrl = "/Common/Images/default/24/disk_blue.png";
                    bt_pay.Enabled = false;
                    bt_pay.ImageUrl = "/Common/Images/default/24/check_gray.png";

                }
                else
                {
                    lbERR.Text = "*** - УВАГА! Номер рахунку містить не числові символи!";
                    bt_save.Enabled = false;
                    bt_save.ImageUrl = "/Common/Images/default/24/disk_gray.png";
                    bt_pay.Enabled = false;
                    bt_pay.ImageUrl = "/Common/Images/default/24/check_gray.png";
                    return;
                }

               if (Convert.ToString(rdr["NLS"]) == tbNLS.Text)
                {
                    lbERR.Text = "";
                    bt_save.Enabled = true;
                    bt_save.ImageUrl = "/Common/Images/default/24/disk_blue.png";
                }
                else
                {
                    lbERR.Text = "**** - УВАГА! Невірний контрольний розряд рахунку!";
                    bt_back.Enabled = false;
                    bt_save.ImageUrl = "/Common/Images/default/24/disk_gray.png";
                    bt_pay.Enabled = false;
                    bt_pay.ImageUrl = "/Common/Images/default/24/check_gray.png";
                }

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
    protected void bt_save_Click(object sender, ImageClickEventArgs e)
    {
        InitOraConnection();

        try
        {
            bt_save.Enabled = false;
            bt_save.ImageUrl = "/Common/Images/default/24/disk_gray.png";
            if (Convert.ToDecimal(tbSumSeizure.Text) <= 0 || String.IsNullOrEmpty(tbComments.Text))
            {
                lbERR.Text = "***** Увага не заповнено суму арешту та привід для арешту!";
                bt_pay.Enabled = false;
                bt_pay.ImageUrl = "/Common/Images/default/24/check_gray.png";
                return;
            }

            if (Request["KEY"] != null)
            {
                String summa = tbSumSeizure.Text;
                ClearParameters();
                //update
                SetParameters("nls_", DB_TYPE.Varchar2, tbNLS.Text, DIRECTION.Input);
                SetParameters("sum_", DB_TYPE.Varchar2, summa, DIRECTION.Input);
                SetParameters("mfob_", DB_TYPE.Varchar2, lbMFO.Value, DIRECTION.Input);
                SetParameters("nmk_", DB_TYPE.Varchar2, lbNMK.Text, DIRECTION.Input);
                SetParameters("okpob_", DB_TYPE.Varchar2, lbOKPO.Text, DIRECTION.Input);
                SetParameters("key_", DB_TYPE.Decimal, Request["KEY"], DIRECTION.Input);
                //insert
                SetParameters("key2_", DB_TYPE.Decimal, Request["KEY"], DIRECTION.Input);
                SetParameters("nls2_", DB_TYPE.Varchar2, tbNLS.Text, DIRECTION.Input);
                SetParameters("sum2_", DB_TYPE.Varchar2, summa, DIRECTION.Input);
                SetParameters("mfob2_", DB_TYPE.Varchar2, lbMFO.Value, DIRECTION.Input);
                SetParameters("nmk2_", DB_TYPE.Varchar2, lbNMK.Text, DIRECTION.Input);
                SetParameters("okpob2_", DB_TYPE.Varchar2, lbOKPO.Text, DIRECTION.Input);
                //change status 
                SetParameters("comments_", DB_TYPE.Varchar2, tbComments.Text, DIRECTION.Input);
                SetParameters("key3_", DB_TYPE.Decimal, Request["KEY"], DIRECTION.Input);

                SQL_NONQUERY(@"begin
                                  begin  
                                      update part_pay_immobile 
                                        set pdat=sysdate,
                                            nls=:nls_,
                                            sum=to_number(:sum_)*100, 
                                            userid=user_id,
                                            status=2,
                                            mfob=:mfob_,
                                            fio=:nmk_, 
                                            okpob=:okpob_
                                      where key=:key_ and status=2;
                                     if sql%rowcount=0 then
                                         begin
                                           insert into part_pay_immobile(key, pdat, nls, sum, userid, status, mfob, fio, okpob) 
                                             values(:key2_, sysdate, :nls2_, to_number(:sum2_)*100, user_id, 2, :mfob2_, :nmk2_, :okpob2_);
                                          exception when dup_val_on_index then null;
                                          end;
                                      end if; 
                                   end; 
                                     --Помітка про те що накладено арешт на рахунок
                                      update asvo_immobile set comments = :comments_, fl=12 where key=:key3_;  
                                    
                             end;");
            }

            bt_pay.Enabled = true;
            bt_pay.ImageUrl = "/Common/Images/default/24/check.png";


        }
        finally
        {
            DisposeOraConnection();

        }
       
    }


    protected void bt_pay_Click(object sender, ImageClickEventArgs e)
    {
        

        InitOraConnection();
        
        try
        {

            bt_pay.Enabled = false;
            bt_pay.ImageUrl = "/Common/Images/default/24/check_gray.png";
            if (Convert.ToDecimal(tbSumSeizure.Text) <= 0 
                || String.IsNullOrEmpty(tbComments.Text)
                ||String.IsNullOrEmpty(tbNLS.Text)
                ||String.IsNullOrEmpty(lbMFO.Value)
                ||String.IsNullOrEmpty(lbNMK.Text)
                ||String.IsNullOrEmpty(lbOKPO.Text))
            {
                lbERR.Text = "***** Увага не заповнено всі необхідні реквізити!";
                bt_pay.Enabled = false;
                bt_pay.ImageUrl = "/Common/Images/default/24/check_gray.png";
                return;
            }

            if (Request["KEY"] != null)
            {
                String summa = tbSumSeizure.Text;
                ClearParameters();
                //update
                SetParameters("nls_", DB_TYPE.Varchar2, tbNLS.Text, DIRECTION.Input);
                SetParameters("sum_", DB_TYPE.Varchar2, summa, DIRECTION.Input);
                SetParameters("mfob_", DB_TYPE.Varchar2, lbMFO.Value, DIRECTION.Input);
                SetParameters("nmk_", DB_TYPE.Varchar2, lbNMK.Text, DIRECTION.Input);
                SetParameters("okpob_", DB_TYPE.Varchar2, lbOKPO.Text, DIRECTION.Input);
                SetParameters("key_", DB_TYPE.Decimal, Request["KEY"], DIRECTION.Input);
                //insert
                SetParameters("key2_", DB_TYPE.Decimal, Request["KEY"], DIRECTION.Input);
                SetParameters("nls2_", DB_TYPE.Varchar2, tbNLS.Text, DIRECTION.Input);
                SetParameters("sum2_", DB_TYPE.Varchar2, summa, DIRECTION.Input);
                SetParameters("mfob2_", DB_TYPE.Varchar2, lbMFO.Value, DIRECTION.Input);
                SetParameters("nmk2_", DB_TYPE.Varchar2, lbNMK.Text, DIRECTION.Input);
                SetParameters("okpob2_", DB_TYPE.Varchar2, lbOKPO.Text, DIRECTION.Input);
                //change status 
                SetParameters("comments_", DB_TYPE.Varchar2, tbComments.Text, DIRECTION.Input);
                SetParameters("key3_", DB_TYPE.Decimal, Request["KEY"], DIRECTION.Input);

                SQL_NONQUERY(@"begin
                                  begin  
                                      update part_pay_immobile 
                                        set pdat=sysdate,
                                            nls=:nls_,
                                            sum=to_number(:sum_)*100, 
                                            userid=user_id,
                                            status=0,
                                            mfob=:mfob_,
                                            fio=:nmk_, 
                                            okpob=:okpob_
                                      where key=:key_ and status=2;
                                     if sql%rowcount=0 then
                                         begin
                                           insert into part_pay_immobile(key, pdat, nls, sum, userid, status, mfob, fio, okpob) 
                                             values(:key2_, sysdate, :nls2_, to_number(:sum2_)*100, user_id, 0, :mfob2_, :nmk2_, :okpob2_);
                                          exception when dup_val_on_index then null;
                                          end;
                                      end if; 
                                   end; 
                                     --Помітка про те що накладено арешт на рахунок
                                      update asvo_immobile set comments = :comments_, fl=13 where key=:key3_;  
                                    
                             end;");
            }
            ClientScript.RegisterClientScriptBlock(Page.GetType(), "close", "window.returnValue = true; window.close();", true);

        }
        finally
        {
            DisposeOraConnection();
            
            //bt_pay.OnClientClick = "close_window()";
        }
    }
    protected void tbComments_TextChanged(object sender, EventArgs e)
    {
        lbERR.Text = "";
        bt_save.Enabled = true;
        bt_save.ImageUrl = "/Common/Images/default/24/disk_blue.png"; 
    }
}
