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
                    SQL_Reader_Exec(@"select case when ai.owner_type = 'O' then a.fio else nvl(ai.fio,a.fio) end fio
					, nvl(ai.mfob,substr(a.branch,2,6)) mfo
					, nvl(ai.okpob,a.idcode) okpo
					, a.kv, ai.nls, (a.ost-f_part_sum_immobile(a.key))/100 ost
					, a.comments
					, nvl(ai.owner_type,'O') owner_type
					, nvl(ai.pasp_n,a.pasp_n) pasp_n
                                        , nvl(ai.pasp_s,a.pasp_s) pasp_s
					, ai.comments
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

                        tbSUM_PART.MaxValue = Convert.ToDouble(tbSUM_FULL.Text);

                        if (type_owner == "O")
                        {
                            rbOwner.Checked = true;
                            rbSpadok.Checked = false;
                            rbDover.Checked = false;
                            lbOKPO.Enabled = false;
                            lbNMK.Enabled = false;
			    
                            txtNMK_PASPN.Enabled = false;
			    txtNMK_PASPS.Enabled = false;

                        }

                        if (type_owner == "S")
                        {
                            rbOwner.Checked = false;
                            rbSpadok.Checked = true;
                            rbDover.Checked = false;
                            lbOKPO.Enabled = true;
                            lbNMK.Enabled = true;
			    
			    //20170404------------------------------------------>
			    txtNMK_PASPN.Enabled = ((lbOKPO.Text=="000000000") || (lbOKPO.Text=="0000000000"));
			    txtNMK_PASPS.Enabled = ((lbOKPO.Text=="000000000") || (lbOKPO.Text=="0000000000"));
			    //txtNMK_PASPN.Enabled = true;
			    //txtNMK_PASPS.Enabled = true;
                            tbPurposePayment.Enabled = tbNLS.Text.StartsWith("3141"); 
			    //--------------------------------------------------<

                        }
                        if (type_owner == "D")
                        {
                            rbOwner.Checked = false;
                            rbSpadok.Checked = false;
                            rbDover.Checked = true;
                            lbOKPO.Enabled = true;
                            lbNMK.Enabled = true;
                            //20170404---------------------------------------->
			    txtNMK_PASPN.Enabled = ((lbOKPO.Text=="000000000") || (lbOKPO.Text=="0000000000"));
			    txtNMK_PASPS.Enabled = ((lbOKPO.Text=="000000000") || (lbOKPO.Text=="0000000000"));
			    //txtNMK_PASPN.Enabled = true;
			    //txtNMK_PASPS.Enabled = true;
                            tbPurposePayment.Enabled = tbNLS.Text.StartsWith("3141"); 
			    //------------------------------------------------<

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
            //20170404-------------------------------------------------<
	    else 
	    {
		tbPurposePayment.Enabled = tbNLS.Text.StartsWith("3141"); 
	    } 
	    //--------------------------------------------------<
	
            if (rdr.Read())
            {
                if (rdr["NAME"] == DBNull.Value )
                {
                lbERR.Text="";
                bt_save.Enabled = true;
                bt_save.ImageUrl = "/Common/Images/default/24/disk_blue.png";
                bt_pay.Enabled = false;
                bt_pay.ImageUrl = "/Common/Images/default/24/check_gray.png";

                }
                else
                {
                    lbERR.Text="*** - УВАГА! Номер рахунку містить не числові символи!";
                    bt_save.Enabled = false;
                    bt_save.ImageUrl = "/Common/Images/default/24/disk_gray.png";
                    bt_pay.Enabled = false;
                    bt_pay.ImageUrl = "/Common/Images/default/24/check_gray.png";
                    return;
                }
                if (Convert.ToString(rdr["NLS"])==tbNLS.Text )
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
        String errmsg = "";
        try
        {
           
            if (Request["KEY"] != null)
            {

                String owner_type = "";
                if(rbOwner.Checked)
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
                SetParameters("nls_", DB_TYPE.Varchar2, tbNLS.Text,  DIRECTION.Input);
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
              ClearParameters();
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
        txtNMK_PASPN.Enabled = ((lbOKPO.Text=="000000000") || (lbOKPO.Text=="0000000000"));
	txtNMK_PASPS.Enabled = ((lbOKPO.Text=="000000000") || (lbOKPO.Text=="0000000000"));
    }

    protected void rbOwner_CheckedChanged(object sender, EventArgs e)
    {
        if (rbDover.Checked)
        {
            lbOKPO.Enabled = true;
            lbNMK.Enabled = true;
	   // txtNMK_PASPN.Enabled = false;
	   // txtNMK_PASPS.Enabled = false;
	    txtNMK_PASPN.Enabled = ((lbOKPO.Text=="000000000") || (lbOKPO.Text=="0000000000"));  
            txtNMK_PASPS.Enabled = ((lbOKPO.Text=="000000000") || (lbOKPO.Text=="0000000000"));

        }
        if (rbSpadok.Checked)
        {
            lbOKPO.Enabled = true;
            lbNMK.Enabled = true;
            //txtNMK_PASPN.Enabled = true;
	    //txtNMK_PASPS.Enabled = true;
	    txtNMK_PASPN.Enabled = ((lbOKPO.Text=="000000000") || (lbOKPO.Text=="0000000000"));  
            txtNMK_PASPS.Enabled = ((lbOKPO.Text=="000000000") || (lbOKPO.Text=="0000000000"));
        }
        if(rbOwner.Checked)
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
			
                        SQL_Reader_Close();
                    }
                }
                finally
                {
                    DisposeOraConnection();
                }



            
        }
    }
}
