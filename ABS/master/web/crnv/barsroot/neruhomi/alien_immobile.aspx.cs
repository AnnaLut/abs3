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




public partial class alien : Bars.BarsPage
{
   protected OracleConnection con;

 
    
    private void FillData()
    {
        Response.Redirect(String.Format("/barsroot/neruhomi/alien_immobile.aspx?key={0}", Request["KEY"]));
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

                    String type_owner;

                    SetParameters("key", DB_TYPE.Varchar2, Request["KEY"], DIRECTION.Input);

                    EnableFullPay.Value = "1";
                    SQL_Reader_Exec(@"select key from PART_PAY_IMMOBILE where key = :key");
                    if (SQL_Reader_Read())
                    {
                        EnableFullPay.Value = "0";
                        rbPART.Checked = tbSUM_PART.Enabled = true;
                        rbFULL.Enabled = false;
                    }
                    SQL_Reader_Close();

                    SQL_Reader_Exec(@"select case when ai.owner_type = 'O' then a.fio else nvl(a.fio,ai.fio) end fio
					, nvl(substr(a.branch,2,6),ai.mfob) mfo
					, nvl(a.idcode,ai.okpob) okpo
					, a.kv, ai.nls, (a.ost-f_part_sum_immobile(a.key))/100 ost
					, a.comments
					, nvl(ai.owner_type,'O') owner_type
					, nvl(a.pasp_n,ai.pasp_n) pasp_n
                    , nvl(a.pasp_s,ai.pasp_s) pasp_s
					, ai.comments
                    , a.nd 
                                        from asvo_immobile a, alien_immobile ai
                                        where a.key=ai.key(+) 
                                        and  a.key=:key");
                    while (SQL_Reader_Read())
                    {
                        ArrayList reader = SQL_Reader_GetValues();
                        lbNMK.Text = Convert.ToString(reader[0]);
                        lbMFO.Value = Convert.ToString(reader[1]);
                        lbOKPO.Text = Convert.ToString(reader[2]);
                        lbKV.Text = Convert.ToString(reader[3]);
                        tbNLS.Text = Convert.ToString(reader[4]);
                        tbSUM_FULL.Text = Convert.ToString(reader[5]);
                        tbComments.Text = Convert.ToString(reader[6]);
                        type_owner = Convert.ToString(reader[7]);

                        txtNMK_PASPN.Text = Convert.ToString(reader[8]);
                        txtNMK_PASPS.Text = Convert.ToString(reader[9]);
                        tbPurposePayment.Text = Convert.ToString(reader[10]);
                        ND.Value = Convert.ToString(reader[11]);

                        tbSUM_PART.MaxValue = Convert.ToDouble(tbSUM_FULL.Text);


                        rbOwner.Checked = type_owner == "O";
                        rbSpadok.Checked = type_owner == "S";
                        rbDover.Checked = type_owner == "D";
                        lbOKPO.Enabled = lbNMK.Enabled = type_owner != "O";

                        txtNMK_PASPN.Enabled = txtNMK_PASPS.Enabled = ((type_owner == "S") || (type_owner == "D")) ? 
                            ((lbOKPO.Text == "000000000") || (lbOKPO.Text == "0000000000")) : false;

                        if (type_owner == "O")
                            rbPART.Enabled = false;

                        if ((type_owner == "S") || (type_owner == "D"))
                        {
                            tbPurposePayment.Enabled = tbNLS.Text.StartsWith("3141");
                            if(EnableFullPay.Value == "0")
                            {
                                lbMFO.Value = null;
                                lbOKPO.Text = tbNLS.Text = lbNMK.Text = string.Empty;
                            }
                        }
                    }
                    SQL_Reader_Close();
                    

                    EditFormForRub(true);
                }
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        else
        {

            if ((lbKV.Text == "643") && !tbNLS.Text.StartsWith("2909"))
            {
                lbERR.Text = "** - Для валюти 643 має бути тільки рахунок 2909";
                bt_save.Enabled = false;
                bt_save.ImageUrl = "/Common/Images/default/24/disk_gray.png";
                bt_pay.Enabled = false;
                bt_pay.ImageUrl = "/Common/Images/default/24/check_gray.png";
                return;
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
        if ((lbKV.Text == "643") && !tbNLS.Text.StartsWith("2909"))
        {
            lbERR.Text = "** - Для валюти 643 має бути тільки рахунок 2909";
            bt_save.Enabled = false;
            bt_save.ImageUrl = "/Common/Images/default/24/disk_gray.png";
            bt_pay.Enabled = false;
            bt_pay.ImageUrl = "/Common/Images/default/24/check_gray.png";
            return;
        }
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
            //20170404-------------------------------------------------<
            else
            {
                tbPurposePayment.Enabled = tbNLS.Text.StartsWith("3141");
            }
            //--------------------------------------------------<

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
        if ((lbKV.Text == "643") && !tbNLS.Text.StartsWith("2909"))
        {
            lbERR.Text = "** - Для валюти 643 має бути тільки рахунок 2909";
            bt_save.Enabled = false;
            bt_save.ImageUrl = "/Common/Images/default/24/disk_gray.png";
            bt_pay.Enabled = false;
            bt_pay.ImageUrl = "/Common/Images/default/24/check_gray.png";
            return;
        }
        if (rbPART.Checked && (tbSUM_PART.Value == null || tbSUM_PART.Value == 0  ))
        {
            lbERR.Text = "Неможливо зберегти з частковою некоректною сумою!";
            bt_save.Enabled = false;
            bt_save.ImageUrl = "/Common/Images/default/24/disk_gray.png";
            bt_pay.Enabled = false;
            bt_pay.ImageUrl = "/Common/Images/default/24/check_gray.png";
            return;
        }
        InitOraConnection();
        String errmsg = "";
        try
        {

            if (Request["KEY"] != null)
            {

                String owner_type = "";
                if (rbOwner.Checked)
                {
                    owner_type = "O";
                }

                if (rbSpadok.Checked)
                {
                    owner_type = "S";
                }


                if (rbDover.Checked)
                {
                    owner_type = "D";
                }


                ClearParameters();
                SetParameters("nls_", DB_TYPE.Varchar2, tbNLS.Text, DIRECTION.Input);
                SetParameters("mfob_", DB_TYPE.Varchar2, lbMFO.Value, DIRECTION.Input);
                SetParameters("okpob_", DB_TYPE.Varchar2, lbOKPO.Text, DIRECTION.Input);
                SetParameters("fio_", DB_TYPE.Varchar2, lbNMK.Text, DIRECTION.Input);
                SetParameters("type_", DB_TYPE.Varchar2, owner_type, DIRECTION.Input);

                SetParameters("PASP_N_", DB_TYPE.Varchar2, txtNMK_PASPN.Text, DIRECTION.Input);
                SetParameters("PASP_S_", DB_TYPE.Varchar2, txtNMK_PASPS.Text, DIRECTION.Input);
                SetParameters("COMMENTS", DB_TYPE.Varchar2, tbPurposePayment.Text, DIRECTION.Input);

                SetParameters("key_", DB_TYPE.Decimal, Request["KEY"], DIRECTION.Input);
                SetParameters("key2_", DB_TYPE.Decimal, Request["KEY"], DIRECTION.Input);
                SetParameters("nls2_", DB_TYPE.Varchar2, tbNLS.Text, DIRECTION.Input);
                SetParameters("mfob2_", DB_TYPE.Varchar2, lbMFO.Value, DIRECTION.Input);
                SetParameters("okpob2_", DB_TYPE.Varchar2, lbOKPO.Text, DIRECTION.Input);
                SetParameters("fio2_", DB_TYPE.Varchar2, lbNMK.Text, DIRECTION.Input);
                SetParameters("type2_", DB_TYPE.Varchar2, owner_type, DIRECTION.Input);

                SetParameters("PASP_N_2", DB_TYPE.Varchar2, txtNMK_PASPN.Text, DIRECTION.Input);
                SetParameters("PASP_S_2", DB_TYPE.Varchar2, txtNMK_PASPS.Text, DIRECTION.Input);
                SetParameters("COMMENTS_2", DB_TYPE.Varchar2, tbPurposePayment.Text, DIRECTION.Input);

                SetParameters("comments_", DB_TYPE.Varchar2, tbComments.Text, DIRECTION.Input);
                SetParameters("key3_", DB_TYPE.Decimal, Request["KEY"], DIRECTION.Input);

                SQL_NONQUERY(@"begin
                                 begin  
                                            update alien_immobile 
                                            set nls=:nls_
						, mfob=:mfob_
						, okpob = :okpob_
						, fio=:fio_
						, owner_type=:type_
						, PASP_N = :PASP_N_
						, PASP_S = :PASP_S_
                                                , COMMENTS = :COMMENTS 
                                            where key=:key_ ; 
                                     if sql%rowcount=0 then
                                         begin
                                          insert into alien_immobile(key, nls, mfob, okpob, fio, owner_type, PASP_N, PASP_S, COMMENTS) 
                                          values(:key2_, :nls2_, :mfob2_, :okpob2_, :fio2_, :type2_, :PASP_N_2, :PASP_S_2, :COMMENTS_2);
                                          exception when dup_val_on_index then null;
                                          end;
                                      end if; 
                              end; 
                              update asvo_immobile set comments = :comments_ where key=:key3_;  
                             end;");
            }
        }
        finally
        {
            DisposeOraConnection();

        }
        bt_save.Enabled = false;
        bt_save.ImageUrl = "/Common/Images/default/24/disk_gray.png";
      
        if (String.IsNullOrEmpty(lbOKPO.Text))
        {
            errmsg="***** Увага не заповнено ідентифікаційний номер клієнта. Оплата не може бути виконана. Заповніть ідентифікаційний номер!";
            
        }
        else
        {
            if ((lbOKPO.Text.Length > 7 || lbOKPO.Text == "99999" || lbOKPO.Text == "000000000" || lbOKPO.Text == "0000000000") &&
            (
            lbOKPO.Text != "00000000" && lbOKPO.Text != "11111111" && lbOKPO.Text != "22222222" && lbOKPO.Text != "33333333" && lbOKPO.Text != "44444444"
            && lbOKPO.Text != "55555555" && lbOKPO.Text != "66666666" && lbOKPO.Text != "77777777" && lbOKPO.Text != "88888888"
            && lbOKPO.Text != "99999999" &&
            lbOKPO.Text != "111111111" && lbOKPO.Text != "222222222" && lbOKPO.Text != "333333333" && lbOKPO.Text != "444444444"
            && lbOKPO.Text != "555555555" && lbOKPO.Text != "666666666" && lbOKPO.Text != "777777777" && lbOKPO.Text != "888888888"
            && lbOKPO.Text != "999999999"
            && lbOKPO.Text != "1111111111" && lbOKPO.Text != "2222222222" && lbOKPO.Text != "3333333333" && lbOKPO.Text != "4444444444"
            && lbOKPO.Text != "5555555555" && lbOKPO.Text != "6666666666" && lbOKPO.Text != "7777777777" && lbOKPO.Text != "8888888888" && lbOKPO.Text != "9999999999"))
            {
               
                errmsg = "";
            }
            else
            {
                errmsg="***** Увага не коректно заповнено ідентифікаційний номер клієнта. Оплата не може бути виконана!";
                
            }
        }

        if (String.IsNullOrEmpty(lbNMK.Text))
        {
            errmsg = "***** Увага не заповнено отримувача. Оплата не може бути виконана!";
            
        }
       

        if (lbNMK.Text.StartsWith(" "))
        {
            errmsg = "***** Увага перший символ не може бути пустим. Оплата не може бути виконана!";
            
        }
        

        if (errmsg == "")
        {
            bt_pay.Enabled = true;
            bt_pay.ImageUrl = "/Common/Images/default/24/check.png";
            bt_save.Enabled = false;
            bt_save.ImageUrl = "/Common/Images/default/24/disk_gray.png";
        }
        else 
        {
            lbERR.Text = errmsg;
            bt_pay.Enabled = false;
            bt_pay.ImageUrl = "/Common/Images/default/24/check_gray.png";
            bt_save.Enabled = true;
            bt_save.ImageUrl = "/Common/Images/default/24/disk_blue.png";
        }
    }
    protected void rbFULL_CheckedChanged(object sender, EventArgs e)
    {
        if (rbPART.Checked)
        {
            tbSUM_PART.Enabled = true;
        }
        else
        {
            tbSUM_PART.Enabled = false;
            tbSUM_PART.Text = "0";
        }
        
    }
    protected void bt_pay_Click(object sender, ImageClickEventArgs e)
    {
        if ((lbKV.Text == "643") && !tbNLS.Text.StartsWith("2909"))
        {
            lbERR.Text = "** - Для валюти 643 має бути тільки рахунок 2909";
            bt_save.Enabled = false;
            bt_save.ImageUrl = "/Common/Images/default/24/disk_gray.png";
            bt_pay.Enabled = false;
            bt_pay.ImageUrl = "/Common/Images/default/24/check_gray.png";
            return;
        }

        InitOraConnection();
        
        try
        {
          
            if (rbFULL.Checked)
            {
               String summa = tbSUM_FULL.Text;
                ClearParameters();
                SetParameters("key_", DB_TYPE.Decimal, Request["KEY"], DIRECTION.Input);
                SetParameters("key2_", DB_TYPE.Decimal, Request["KEY"], DIRECTION.Input);
                SetParameters("key3_", DB_TYPE.Decimal, Request["KEY"], DIRECTION.Input);

                SQL_NONQUERY(@"begin
                              update asvo_immobile 
                                set fl=8
                                where key=:key_;
                                begin  
                                      update alien_immobile 
                                            set userid=user_id
                                            where key=:key2_ ; 
                                     if sql%rowcount=0 then
                                         begin
                                          insert into alien_immobile(key, userid) values(:key3_, user_id);
                                          exception when dup_val_on_index then null;
                                          end;
                                      end if; 
                                end; 
                             end;");
            }
            if (rbPART.Checked)
            {
                String owner_type = "";
                if (rbOwner.Checked)
                {
                    owner_type = "O";
                }

                if (rbSpadok.Checked)
                {
                    owner_type = "S";
                }


                if (rbDover.Checked)
                {
                    owner_type = "D";
                }
              

              String summa = tbSUM_PART.Text;
             /* ClearParameters();
              SetParameters("key_", DB_TYPE.Decimal, Request["KEY"], DIRECTION.Input);
              SetParameters("key2_", DB_TYPE.Decimal, Request["KEY"], DIRECTION.Input);
              SetParameters("nls_", DB_TYPE.Varchar2, tbNLS.Text, DIRECTION.Input);
              SetParameters("sum_", DB_TYPE.Varchar2, summa, DIRECTION.Input);
              SetParameters("mfob_", DB_TYPE.Varchar2, lbMFO.Value, DIRECTION.Input);
              SetParameters("okpob_", DB_TYPE.Varchar2, lbOKPO.Text, DIRECTION.Input);
              SetParameters("fio_", DB_TYPE.Varchar2, lbNMK.Text, DIRECTION.Input);
              SetParameters("type_", DB_TYPE.Varchar2, owner_type, DIRECTION.Input);

      	      SetParameters("PASP_N_", DB_TYPE.Varchar2, txtNMK_PASPN.Text, DIRECTION.Input);	
              SetParameters("PASP_S_", DB_TYPE.Varchar2, txtNMK_PASPS.Text, DIRECTION.Input);
              SetParameters("COMMENTS_", DB_TYPE.Varchar2, tbPurposePayment.Text, DIRECTION.Input);

              SQL_NONQUERY(@"begin
                              update asvo_immobile 
                                set fl=10
                                where key=:key_;
                              insert into part_pay_immobile(key, pdat, nls, sum, userid, status, mfob, okpob, fio, owner_type, PASP_N, PASP_S, COMMENTS) 
                                values(:key2_, sysdate, :nls_, to_number(:sum_)*100, user_id, 0, :mfob_, :okpob_, :fio_, :type_, :PASP_N_, :PASP_S_, COMMENTS_);
                             end;"); */
			 ClearParameters();
 	          SetParameters("p_key_", DB_TYPE.Decimal, Request["KEY"], DIRECTION.Input);
	          SetParameters("p_key2_", DB_TYPE.Decimal, Request["KEY"], DIRECTION.Input);
              SetParameters("p_nls_", DB_TYPE.Varchar2, tbNLS.Text, DIRECTION.Input);
              SetParameters("p_sum_", DB_TYPE.Varchar2, summa, DIRECTION.Input);
              SetParameters("p_mfob_", DB_TYPE.Varchar2, lbMFO.Value, DIRECTION.Input);
              SetParameters("p_okpob_", DB_TYPE.Varchar2, lbOKPO.Text, DIRECTION.Input);
              SetParameters("p_fio_", DB_TYPE.Varchar2, lbNMK.Text, DIRECTION.Input);
              SetParameters("p_type_", DB_TYPE.Varchar2, owner_type, DIRECTION.Input);
              SetParameters("p_PASP_N_", DB_TYPE.Varchar2, txtNMK_PASPN.Text, DIRECTION.Input);	
              SetParameters("p_PASP_S_", DB_TYPE.Varchar2, txtNMK_PASPS.Text, DIRECTION.Input);
              SetParameters("p_COMMENTS_", DB_TYPE.Varchar2, tbPurposePayment.Text, DIRECTION.Input);
 
              SQL_NONQUERY (@"begin
									BARS.upd_asv_ins_part(:p_key_ ,   
									:p_key2_ , 
									:p_nls_  ,
									:p_sum_  ,
									:p_mfob_ ,
									:p_okpob_ ,
									:p_fio_   ,
									:p_type_  ,
									:p_PASP_N_ ,
									:p_PASP_S_ ,
									:p_COMMENTS);
									end;");	
           
		   }

            
        }
        finally
        {
            DisposeOraConnection();
             
        }
    }
    protected void tbComments_TextChanged(object sender, EventArgs e)
    {
        lbERR.Text = "";
        bt_save.Enabled = true;
        bt_save.ImageUrl = "/Common/Images/default/24/disk_blue.png"; 
    }

    protected void lbOKPO_TextChanged(object sender, EventArgs e)
    {
        txtNMK_PASPN.Enabled = ((lbOKPO.Text == "000000000") || (lbOKPO.Text == "0000000000"));
        txtNMK_PASPS.Enabled = ((lbOKPO.Text == "000000000") || (lbOKPO.Text == "0000000000"));
    }

    protected void rbOwner_CheckedChanged(object sender, EventArgs e)
    {
        tbPurposePayment.Text = PurposeLayout.Text;
        if (rbDover.Checked || rbSpadok.Checked)
        {
            rbPART.Enabled = true;
            lbOKPO.Enabled = true;
            lbNMK.Enabled = true;
            // txtNMK_PASPN.Enabled = false;
            // txtNMK_PASPS.Enabled = false;
            txtNMK_PASPN.Enabled = ((lbOKPO.Text == "000000000") || (lbOKPO.Text == "0000000000"));
            txtNMK_PASPS.Enabled = ((lbOKPO.Text == "000000000") || (lbOKPO.Text == "0000000000"));
            lbMFO.Value = null;
            lbOKPO.Text = tbNLS.Text = lbNMK.Text = string.Empty;

        }
        if (rbOwner.Checked)
        {
            String s1 = "";
            String s2 = "";
            String s3 = "";
            String s4 = "";
            String s5 = "";

            try
            {
                InitOraConnection();


                if (Request["KEY"] != null)
                {

                    SetParameters("key", DB_TYPE.Varchar2, Request["KEY"], DIRECTION.Input);
                    SQL_Reader_Exec(@"select a.fio fio, a.idcode okpo, a.pasp_n, a.pasp_s, a.comments
                                         from asvo_immobile a
                                        where  a.key=:key");
                    while (SQL_Reader_Read())
                    {
                        ArrayList reader = SQL_Reader_GetValues();
                        s1 = Convert.ToString(reader[0]);
                        s2 = Convert.ToString(reader[1]);
                        s3 = Convert.ToString(reader[2]);
                        s4 = Convert.ToString(reader[3]);
                        s5 = Convert.ToString(reader[4]);

                    }

                    lbNMK.Text = s1;
                    lbOKPO.Text = s2;
                    txtNMK_PASPN.Text = s3;
                    txtNMK_PASPS.Text = s4;
                    tbComments.Text = s5;

                    lbOKPO.Enabled = false;
                    lbNMK.Enabled = false;
                    txtNMK_PASPN.Enabled = false;
                    txtNMK_PASPS.Enabled = false;
                    tbComments.Enabled = false;
                    rbPART.Enabled = false;
                    if (rbPART.Checked)
                    {
                        tbSUM_PART.Value = null;
                        rbPART.Checked = tbSUM_PART.Enabled = false;
                        rbFULL.Checked = true;
                    }

                    SQL_Reader_Close();
                }
            }
            finally
            {
                DisposeOraConnection();
            }

        }

        EditFormForRub(false);

        if(EnableFullPay.Value == "0")
        {
            rbPART.Checked = tbSUM_PART.Enabled = true;
            rbFULL.Enabled = false;
        }
    }

    private void EditFormForRub(bool onLoad)
    {
        if (!(lbKV.Text == "643"))
            return;

        lbNMK.Enabled = lbOKPO.Enabled = false;
        tbPurposePayment.Rows = 5;


        if (onLoad)
        {
            string OkpoOrPassp = ((lbOKPO.Text == "") || (lbOKPO.Text.Length < 10) || (lbOKPO.Text == "0000000000")) ? (txtNMK_PASPS.Text + ", " + txtNMK_PASPN.Text) : lbOKPO.Text;
            tbPurposePayment.Text = String.Format("Виплата нерухомого вкладу {0}, {1}, {2}", lbNMK.Text, ND.Value, OkpoOrPassp);
            PurposeLayout.Text = tbPurposePayment.Text;
        }
        lbNMK.Text = lbMFO.Value = lbOKPO.Text = txtNMK_PASPN.Text = txtNMK_PASPS.Text = "";

        if (rbOwner.Checked)
        {
            DopInfo.Visible = dop_name.IsRequired = dop_pasp_num.IsRequired =
                dop_pasp_serial.IsRequired = dop_doc_num.IsRequired = dop_doc_date.IsRequired = false;
        }
        else if((rbDover.Checked || rbSpadok.Checked))
        {
            DopInfo.Visible = dop_name.IsRequired = dop_pasp_num.IsRequired = 
                dop_pasp_serial.IsRequired = dop_doc_num.IsRequired = dop_doc_date.IsRequired = true;
            lbl_dop_doc_num.Text = rbDover.Checked ? "Номер доручення:" : "Номер спадкової справи:";
            lbl_dop_doc_date.Text = rbDover.Checked ? "Дата доручення:" : "Дата спадкової справи:";
            lbl_dop_name.Text = rbDover.Checked ? "Довірена особа:" : "Cпадкоємець:";
            rbPART.Enabled = lbl_dop_part_of_inheritance.Visible = dop_part_of_inheritance.Visible = rbSpadok.Checked;
        }
    }
    protected void LbMFO_Changed(object sender, EventArgs e)
    {
        if (lbKV.Text == "643")
        {
            using (OracleConnection connect = OraConnector.Handler.IOraConnection.GetUserConnection())
            using (OracleCommand cmd = connect.CreateCommand())
            {
                cmd.CommandText = @"select b.okpo, bs.nb from banks_ru b, banks bs where b.mfo = bs.mfo and b.mfo = :mfo";
                cmd.Parameters.Add("mfo", OracleDbType.Varchar2, lbMFO.Value, ParameterDirection.Input);
                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        lbOKPO.Text = rdr.GetString(0);
                        lbNMK.Text = rdr.GetString(1);
                    }
                }
            }
        }
    }

    protected void DopInfoValueChanged(object sender, EventArgs e)
    {
        List<string> dop_info = new List<string> {
            dop_name.Value,
            dop_okpo.Value != null && ((dop_okpo.Value == "") || (dop_okpo.Value.Length < 10) || (dop_okpo.Value == "0000000000")) ? string.Empty : dop_okpo.Value,
            dop_pasp_num.Value, dop_pasp_serial.Value, dop_doc_num.Value, dop_part_of_inheritance.Value, dop_doc_date.Value
        };

        string nazn = PurposeLayout.Text;

        foreach (string val in dop_info)
            if (!String.IsNullOrEmpty(val))
                if (val.Length + nazn.Length + 2 <= 160)
                    nazn += ", " + val;
                else
                    lbERR.Text = "Призначення не може бути більшим за 160 символів. Дані, що не влазать, обрізані.";

        tbPurposePayment.Text = nazn;

    }
}
