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
//using System.Web.UI.HtmlControls;
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

public partial class tools_maket_maket : Bars.BarsPage
{
    int row_counter = 0;
     

    protected void Page_Load(object sender, EventArgs e)
    {
        
     
        RegisterClientScript();
        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();
                ddGRP.DataSource = SQL_SELECT_dataset("select grp, name from makw_grp").Tables[0];
                ddGRP.DataTextField = "name";
                ddGRP.DataValueField = "grp";
                //Биндим
                ddGRP.DataBind();
                ddGRP.Items.Insert(0, new ListItem("Виберіть групу макету", ""));
                
            }
            finally
            {
                DisposeOraConnection();
            }
           
            
        }

        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();
                dl_TT.DataSource = SQL_SELECT_dataset("select tt, tt||'-'||name as name from tts where tt in ('PS1','PS2','K20') order by tt").Tables[0];
                dl_TT.DataTextField = "name";
                dl_TT.DataValueField = "tt";
                //Биндим
                dl_TT.DataBind();
                dl_TT.Items.Insert(0, new ListItem("Виберіть операцію", ""));


                dl_BRANCH.DataSource = SQL_SELECT_dataset("select branch, branch as name from branch where branch like  SYS_CONTEXT ('bars_context', 'user_branch_mask') and date_closed is null order by branch ").Tables[0];
                dl_BRANCH.DataTextField = "name";
                dl_BRANCH.DataValueField = "branch";
                //Биндим
                dl_BRANCH.DataBind();
                dl_BRANCH.Items.Insert(0, new ListItem("", ""));



                dl_VOB.DataSource = SQL_SELECT_dataset("select vob, name from vob where vob > 0 and rep_prefix is not null and vob in (select vob from tts_vob where tt in ('PS1', 'PS2', 'K20')) order by vob").Tables[0];
                dl_VOB.DataTextField = "name";
                dl_VOB.DataValueField = "vob";
                //Биндим
                dl_VOB.DataBind();
                dl_VOB.Items.Insert(0, new ListItem("Виберіть друковану форму", ""));

            }

            finally
            {
                DisposeOraConnection();
            }

            cb_sump.Enabled = true;
            cb_sump.Checked = false;

        }

       
        if (!IsPostBack) OURMFO__.Value = BankType.GetOurMfo();
    }

    private void FillData()
    {
     
        try
        {
            InitOraConnection();
            SetRole("WR_DOC_INPUT");
            ClearParameters();


            Int64 p_grp_;
            Int16 p_sump_;

            if (cb_sump.Checked == true) { p_sump_ = 1; }
            else { p_sump_ = 0; }


            if (string.IsNullOrEmpty(ddGRP.SelectedValue))
            p_grp_ = 0;
            else  p_grp_ = Convert.ToInt64(ddGRP.SelectedValue);

            SetParameters("psump", DB_TYPE.Int64, p_sump_, DIRECTION.Input);
            SetParameters("grp", DB_TYPE.Int64, p_grp_, DIRECTION.Input);
            DataMaket.DataSource = SQL_SELECT_dataset(@"select id, grp, tt, trim(nlsa) as nlsa,trim(nlsb) as nlsb, mfob, okpob, nazn, substr(nam_b,1,38) as nam_b, branch, vob, ord , decode(:psump,0,0,sump) as sump
                                                          from MAKW_det
                                                          where grp = :grp  order by ord, id
                                                                       ");


            DataMaket.DataBind();

        }
        finally
        {
            DisposeOraConnection();
        }
        pn_nazn.Visible = true;
        btPay.Visible = true;
        btPay.Enabled = true;
        dop_nazn.Text = null;
        dop_nazn.Enabled = true;
        cb_nazn.Checked = false;
        cb_nazn.Enabled = true;
        imgPrintAll.Visible = false;
        clear_form();
        pnDataMaket.Visible = true;
        pnResult.Visible = false;
        pn_nazn.Visible = true;
    }
    
    private void FillData_Rules()
    {

        try
        {
            InitOraConnection();
            SetRole("WR_DOC_INPUT");
            ClearParameters();


            String p_id_;

            if (string.IsNullOrEmpty(dl_TT.SelectedValue))
            {
                p_id_ = "0"; 
                pn_rules.Visible = false;
            }
            else
            {
                p_id_ = p_id.Text; 
                pn_rules.Visible = true;
            }

            SetParameters("id", DB_TYPE.Int64, p_id_, DIRECTION.Input);
            SetParameters("id", DB_TYPE.Int64, p_id_, DIRECTION.Input);
            SetParameters("tt", DB_TYPE.Varchar2, dl_TT.SelectedValue, DIRECTION.Input);
            SetParameters("id", DB_TYPE.Int64, p_id_, DIRECTION.Input);
            GridRules.DataSource = SQL_SELECT_dataset(@"select id, a.tag, a.value, f.name , opt
                                                                  from (
                                                                select id, tag, value , 'O' as opt from makw_operw where id = :id
                                                                  union all
                                                                select :id, o.tag, o.val , opt
                                                                   from op_rules o
                                                                  where  o.tt = :tt
                                                                  and tag not in  (select tag from makw_operw where id = :id )) a,
                                                                        op_field f
                                                                 where a.tag = f.tag
                                                                       ");


            GridRules.DataBind();

            if (Convert.ToInt64(GridRules.PageCount) == 0) { pn_rules.Visible = false; } else { pn_rules.Visible = true; }
        }
        finally
        {
            DisposeOraConnection();
        }
  

        // Chexbox показати панель чи ні
        if (cb_operw.Checked == false)
        { pn_rules.Visible = false; }

    }
    
    private void RegisterClientScript()
    {
        string script = @"<script language='javascript'>
			var selectedRow;
            var lastColor;
			function S_A(id,id_,grp_,cus, prod)
			{
			 if(selectedRow != null) selectedRow.style.backgroundColor = lastColor;
			 lastColor = document.getElementById('r_'+id).style.backgroundColor;
             document.getElementById('r_'+id).style.backgroundColor = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			   document.getElementById('ID_').value = id_;
             document.getElementById('GRP_').value = grp_;
     //        document.getElementById('CUS_').value = cus;
     //        document.getElementById('PROD_').value = prod;
     //          nd = nd1;
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script_A", script);
    }
    
    protected void DataDepository_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        row_counter++;

        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            string row_id = "r_" + row_counter.ToString();
            GridViewRow row = e.Row;



            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S_A('" + row_counter + "','" +
                row.Cells[11].Text + "','" + ddGRP.SelectedValue + "',\"" +
                row.Cells[0].Text + "\",'" + row.Cells[0].Text + "')");

          //  Response.Write("-" + row.Cells[10].Text  );

                    }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            if (string.IsNullOrEmpty(HttpUtility.HtmlDecode(e.Row.Cells[1].Text).Trim())
               ||
               string.IsNullOrEmpty(HttpUtility.HtmlDecode(e.Row.Cells[3].Text).Trim()))
            {
                e.Row.Cells[6].Enabled = false;
                e.Row.Cells[7].Enabled = false;
            }
        }
    }
    
    protected void ddTts_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddGRP.SelectedValue == "0"||String.IsNullOrEmpty(ddGRP.SelectedValue))
        {
            cb_sump.Enabled = true;
            cb_sump.Checked = false;
            cb_sump.Visible = false;
            FillData();
            pnDataMaket.Visible = false;
            pn_nazn.Visible = false;
            btPay.Visible = false;
            btPay.Enabled = false;
            dop_nazn.Text = null;
            cb_nazn.Checked = false;
            imgPrintAll.Visible = false;
            clear_form();
            
        }
        else
        {
            cb_sump.Enabled = true;
            cb_sump.Checked = false;
            cb_sump.Visible = true;
            FillData();
           
        }
    }
    
    protected void btRefresh_Click(object sender, EventArgs e)
    {
        ddTts_SelectedIndexChanged(1,e);
        //if (ddGRP.SelectedValue != "0" || !String.IsNullOrEmpty(ddGRP.SelectedValue))
        //FillData();
    }
    
    protected void btPay_Click(object sender, EventArgs e)
    {
        int docsCount = 0;
        Decimal Z_sum = 0;
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
        try
        {
            hRefList.Value = null;
            btPay.Enabled = false;
            dop_nazn.Enabled = false;
            cb_nazn.Enabled = false;
            pn_nazn.Visible = false;
            //CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            //cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            //cinfo.DateTimeFormat.DateSeparator = "/";
            //DateTime dat = Convert.ToDateTime(tbFDat.Text, cinfo);
            
            String OutRef;
            int pos = 0;
            foreach (GridViewRow row in DataMaket.Rows)
            {
               
                string sNazn  = ((TextBox)row.Cells[7].Controls[1]).Text.Trim();
                string sCount = ((TextBox)row.Cells[6].Controls[1]).Text.Trim();
                if (string.IsNullOrEmpty(sCount)) sCount = "0";
                decimal count = decimal.Parse(sCount.Replace(",","."));
                


                if (cb_nazn.Checked == true)
                    sNazn = sNazn + " " + dop_nazn.Text;
                {


                    if (count * 100 >= 1)
                    {
                        Z_sum = Z_sum + count;
                        Int64 GRP = Convert.ToInt64(DataMaket.DataKeys[pos].Values[0]);
                        Int64 ID = Convert.ToInt64(DataMaket.DataKeys[pos].Values[1]);


                        cmd.Parameters.Clear();

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "makw_pack.add_pay";
                        cmd.Parameters.Add("ID_", OracleDbType.Int64, ID, ParameterDirection.Input);
                        cmd.Parameters.Add("GRP", OracleDbType.Int64, GRP, ParameterDirection.Input);
                        cmd.Parameters.Add("NAZN_", OracleDbType.Varchar2, sNazn, ParameterDirection.Input);
                        cmd.Parameters.Add("SUMP_", OracleDbType.Int64, count * 100, ParameterDirection.Input);
                        cmd.Parameters.Add("REF_", OracleDbType.Int64, null, ParameterDirection.InputOutput);
                        cmd.ExecuteNonQuery();

                        OutRef = Convert.ToString(((OracleDecimal)cmd.Parameters["REF_"].Value).Value);
                     //   Response.Write(OutRef + ";");
                        if (OutRef != "0")
                        {
        
                            row.Cells[8].Text = "<a href=# onclick=\"window.open('/barsroot/documentview/default.aspx?ref=" + OutRef + "', 'aaaa', 'width=1050, height=500, resizable=yes,scrollbars=yes,status=yes" + "')\">" + OutRef + "</a>";
                            hRefList.Value += OutRef + ";";
                            // imgPrintAll.Visible = true;
                            docsCount++;
                        }
                        else
                        { row.Cells[8].Text = "Проводка не виконана"; }
                        row.Cells[6].Enabled = false;
                        row.Cells[7].Enabled = false;

                    }
                    else { row.Visible = false; }
               }
                pos++;
            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        if (docsCount > 0)
        {
            lbInfo.Text = "Породжено <b>" + docsCount + " </b> документів(и) на загальну суму <b>" + Z_sum + " грн. </b> Детальніше - дивись колонку [РеФ.]. Для нового вводу - натисніть [Перечитати]";
            lbInfo.ForeColor = System.Drawing.Color.Green;
          //  imgPrintAll.Visible = true;
        }
        else
        {
            lbInfo.Text = "Не вказано суми для жодного макету.";
            lbInfo.ForeColor = System.Drawing.Color.Red;
            
        }
        pnResult.Visible = true;

        btPay.Enabled = false;
        cb_sump.Enabled = false;
        clear_form();
    }
    
    protected void save_rules()
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
        try
        {
            int pos = 0;
            foreach (GridViewRow row in GridRules.Rows)
            {
               
                string sValue = ((TextBox)row.Cells[1].Controls[1]).Text.Trim();
                    
                    {
                        String TAG = Convert.ToString(GridRules.DataKeys[pos].Values[0]);
                        Int64 ID = Convert.ToInt64(GridRules.DataKeys[pos].Values[1]);


                        cmd.Parameters.Clear();

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "makw_pack.add_operw";
                        cmd.Parameters.Add("ID_", OracleDbType.Int64, ID, ParameterDirection.Input);
                        cmd.Parameters.Add("TAG_", OracleDbType.Varchar2, TAG, ParameterDirection.Input);
                        cmd.Parameters.Add("VALUE_", OracleDbType.Varchar2, sValue, ParameterDirection.Input);
                        
                        cmd.ExecuteNonQuery();

                    }
                    pos++;

            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    
    }
    
    protected void Clik_bt_insert(object sender, ImageClickEventArgs e)
    {

        clear_form();
        Pn_maket.Visible = true;
        ID_.Value = "0";
        GRP_.Value = ddGRP.SelectedValue;

        p_id.Text = (ID_.Value);
        p_grp.Text = (GRP_.Value);
        FillData_Rules();
        cb_operw.Visible = false;
    }
    
    protected void bt_Cancel_Click(object sender, EventArgs e)
    {
               FillData();
    }
    
    protected void bt_Ok_Click(object sender, EventArgs e)
    {
        Decimal? ErrCode;
        String ErrMessage;


        if (String.IsNullOrEmpty(dl_TT.SelectedValue) ||
            String.IsNullOrEmpty(tb_NLSA.Text) ||
            String.IsNullOrEmpty(tb_NLSB.Text) ||
            String.IsNullOrEmpty(tb_OKPOB.Text) ||
            String.IsNullOrEmpty(tb_MFO.Text) ||
            String.IsNullOrEmpty(tb_NAM_B.Text) ||
            String.IsNullOrEmpty(tb_NAZN.Text) ||
            String.IsNullOrEmpty(dl_VOB.SelectedValue)           
            )
        {
            ShowError("Не заповнено всі обов`язкові реквізити!!! ");
        }
        else if (tb_NAZN.Text.Length > 159)
        {
            ShowError("Призначення платежу більше 160 символів!!! (" + tb_NAZN.Text.Length + ")");
        }
        else
        {
            {

                OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
                OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
                try
                {

                    Decimal p_tb_sump;

                    if (  String.IsNullOrEmpty(tb_sump.Text))
                    { p_tb_sump = 0; }
                    else { p_tb_sump = Convert.ToDecimal(tb_sump.Text); }


                    cmd.Parameters.Clear();

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "makw_pack.add_det";
                    cmd.Parameters.Add("ID_", OracleDbType.Int64, Convert.ToUInt64(p_id.Text), ParameterDirection.Input);
                    cmd.Parameters.Add("GRP", OracleDbType.Int64, Convert.ToUInt64(p_grp.Text), ParameterDirection.Input);
                    cmd.Parameters.Add("TT_", OracleDbType.Varchar2, dl_TT.SelectedValue, ParameterDirection.Input);
                    cmd.Parameters.Add("NLSA_", OracleDbType.Varchar2, tb_NLSA.Text, ParameterDirection.Input);
                    cmd.Parameters.Add("NLSB_", OracleDbType.Varchar2, tb_NLSB.Text, ParameterDirection.Input);
                    cmd.Parameters.Add("MFOB_", OracleDbType.Varchar2, tb_MFO.Text, ParameterDirection.Input);
                    cmd.Parameters.Add("OKPOB_", OracleDbType.Varchar2, tb_OKPOB.Text, ParameterDirection.Input);
                    cmd.Parameters.Add("NAZN_", OracleDbType.Varchar2, tb_NAZN.Text, ParameterDirection.Input);
                    cmd.Parameters.Add("SUMP_", OracleDbType.Decimal, p_tb_sump, ParameterDirection.Input);
                    cmd.Parameters.Add("NAM_B_", OracleDbType.Varchar2, tb_NAM_B.Text, ParameterDirection.Input);
                    cmd.Parameters.Add("BRANCH_", OracleDbType.Varchar2, dl_BRANCH.SelectedValue, ParameterDirection.Input);
                    cmd.Parameters.Add("VOB_", OracleDbType.Varchar2, dl_VOB.SelectedValue, ParameterDirection.Input);
                    cmd.Parameters.Add("ORD_", OracleDbType.Varchar2, tb_ord.Text, ParameterDirection.Input);
                    cmd.Parameters.Add("ERR_Code", OracleDbType.Decimal, null, ParameterDirection.Output);
                    cmd.Parameters.Add("ERR_Message", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                    cmd.ExecuteNonQuery();

                    ErrCode = ((OracleDecimal)cmd.Parameters["ERR_Code"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmd.Parameters["ERR_Code"].Value).Value;
                    ErrMessage = ((OracleString)cmd.Parameters["ERR_Message"].Value).IsNull ? (String)null : ((OracleString)cmd.Parameters["ERR_Message"].Value).Value;

                    // анализируем результат
                    if (ErrCode.HasValue)
                    {
                        ShowError(ErrMessage);
                        //return false;
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "alert('Дані збережено'); ", true);
                        FillData();
                        p_id.Text = null;
                        p_grp.Text = null;
                    }
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                    //DisposeOraConnection();
                }



            }
            // збережемо допреквізити
            save_rules();
        }
    }
    
    private void clear_form()
    {
        ID_.Value = null;
        GRP_.Value = null;

        dl_BRANCH.SelectedValue = "";
        dl_TT.SelectedValue = "";
        dl_VOB.SelectedValue = "";
        tb_MFO.Text = null;
        tb_NAM_B.Text = null;
        tb_sump.Text = null;
        tb_NAZN.Text = null;
        tb_NLSA.Text = null;
        tb_NLSB.Text = null;
        tb_OKPOB.Text = null;
        LB_NMS.Text = null;
        LB_NMSB.Text = null;
        LB_MFOB.Text = null;
        tb_ord.Text = null;

        cb_operw.Checked = false;

        Pn_maket.Visible = false;
        
    }
    
    protected void Clik_bt_del(object sender, ImageClickEventArgs e)
    {
        if (String.IsNullOrEmpty(ID_.Value))
        { ShowError("Виберіть макет документа!!! "); }
        else
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
            try
            {
                cmd.Parameters.Clear();

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "makw_pack.del_det";
                cmd.Parameters.Add("ID_", OracleDbType.Int64, ID_.Value, ParameterDirection.Input);
                cmd.Parameters.Add("GRP", OracleDbType.Int64, GRP_.Value, ParameterDirection.Input);
                cmd.ExecuteNonQuery();


            }
            finally
            {
                con.Close();
                con.Dispose();
                //DisposeOraConnection();
            }
            FillData();
        }
    }
    
    protected void Clik_bt_edit(object sender, ImageClickEventArgs e)
    {

        p_id.Text = ID_.Value;
        p_grp.Text = GRP_.Value;
        
        Decimal p_vob;
        if (String.IsNullOrEmpty(ID_.Value))
        { ShowError("Виберіть макет документа!!! "); }
        else
        {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            cmd.ExecuteNonQuery();
            cmd.Parameters.Add("ID_", OracleDbType.Int64, p_id.Text, ParameterDirection.Input);
            cmd.Parameters.Add("GRP_", OracleDbType.Int64, p_grp.Text, ParameterDirection.Input);
            cmd.CommandText = (@"select id, grp, tt, trim(nlsa) as nlsa,trim(nlsb) as nlsb, mfob, okpob, nazn,nam_b, branch, vob, to_char(ord) as ord, sump 
                                   from makw_det where id = :ID_ and grp = :GRP_");

            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {


                try { dl_TT.SelectedValue = rdr["TT"] == DBNull.Value ? (String)null : (String)rdr["TT"]; } catch (Exception) { }

                tb_NLSA.Text = rdr["NLSA"] == DBNull.Value ? (String)null : (String)rdr["NLSA"];
                tb_NLSB.Text = rdr["NLSB"] == DBNull.Value ? (String)null : (String)rdr["NLSB"];
                tb_OKPOB.Text = rdr["OKPOB"] == DBNull.Value ? (String)null : (String)rdr["OKPOB"];
                tb_MFO.Text = rdr["MFOB"] == DBNull.Value ? (String)null : (String)rdr["MFOB"];
                tb_NAM_B.Text = rdr["NAM_B"] == DBNull.Value ? (String)null : (String)rdr["NAM_B"];
                tb_NAZN.Text = rdr["NAZN"] == DBNull.Value ? (String)null : (String)rdr["NAZN"];

                try { dl_BRANCH.SelectedValue = rdr["BRANCH"] == DBNull.Value ? (String)null : (String)rdr["BRANCH"]; }  catch (Exception) { }
                
                p_vob = rdr["VOB"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["VOB"];

                tb_sump.Text = String.Format("{0:0.00}", rdr["SUMP"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["SUMP"]);
                    
                
                try { dl_VOB.SelectedValue = Convert.ToString(p_vob); } catch (Exception) { }

                tb_ord.Text = rdr["ORD"] == DBNull.Value ? (String)null : (String)rdr["ORD"];

               
                

               //catch (Exception ex)
               // {  Handle the error
               //  throw ex;
               // }
                
                
            }


            rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }


        tb_NLSA_Changed("", e);
        tb_NLSB_Changed("", e);
        tb_MFOB_Changed("", e);
            Pn_maket.Visible = true;
            cb_operw.Visible = true;
            TT__.Value = dl_TT.SelectedValue;
            FillData_Rules();
        }
    }
    
    private void ShowError(String ErrorText)
    {
        //Response.Write("!" + ErrorText + "!");
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText.Replace("\n", "").Replace("\r", "") + "');", true);
    }
    
    protected void tb_NLSA_Changed(object sender, EventArgs e)
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            cmd.ExecuteNonQuery();
            cmd.Parameters.Add("NLS_", OracleDbType.Varchar2, tb_NLSA.Text, ParameterDirection.Input);
            cmd.CommandText = (@"select * from saldo where nls =  :NLS_ and kv = 980 and dazs is null");

            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {



                LB_NMS.Text = rdr["NMS"] == DBNull.Value ? (String)null : (String)rdr["NMS"];


            }
            else { LB_NMS.Text = null; }


            rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
        tb_MFO.Focus();
    }
    
    protected void tb_NLSB_Changed(object sender, EventArgs e)
    {

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            cmd.ExecuteNonQuery();
            cmd.Parameters.Add("NLS_", OracleDbType.Varchar2, tb_NLSB.Text, ParameterDirection.Input);
            cmd.Parameters.Add("MFO_", OracleDbType.Varchar2, tb_MFO.Text, ParameterDirection.Input);
            cmd.CommandText = (@"select * from accounts where nls =  :NLS_ and kv = 980 and dazs is null and kf = :MFO_");

            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {



                LB_NMSB.Text = rdr["NMS"] == DBNull.Value ? (String)null : (String)rdr["NMS"];
                if (String.IsNullOrEmpty(tb_NAM_B.Text))
                    tb_NAM_B.Text = rdr["NMS"] == DBNull.Value ? (String)null : (String)rdr["NMS"];
               

            }
            else { LB_NMSB.Text = null; }


            rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
       tb_OKPOB.Focus();
    }
    
    protected void tb_MFOB_Changed(object sender, EventArgs e)
    {

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            cmd.ExecuteNonQuery();
            cmd.Parameters.Add("MFO_", OracleDbType.Varchar2, tb_MFO.Text, ParameterDirection.Input);
            cmd.CommandText = (@"select * from banks$base where mfo = :MFO_ and blk = 0");

            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {



                LB_MFOB.Text = rdr["NB"] == DBNull.Value ? (String)null : (String)rdr["NB"];


            }
            else { LB_MFOB.Text = null; }


            rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
       tb_NLSB.Focus();
    }
    
    protected void  Select_dl_tt(object sender, EventArgs e)
{
    FillData_Rules();
    TT__.Value = dl_TT.SelectedValue;
}
    
    protected void Checked_cb_operw(object sender, EventArgs e)
{
    FillData_Rules();
}


    protected void cb_sump_CheckedChanged(object sender, EventArgs e)
    {
        if (ddGRP.SelectedValue == "0" || String.IsNullOrEmpty(ddGRP.SelectedValue))
        {

            FillData();
            pnDataMaket.Visible = false;
            pn_nazn.Visible = false;
            btPay.Visible = false;
            btPay.Enabled = false;
            dop_nazn.Text = null;
            cb_nazn.Checked = false;
            imgPrintAll.Visible = false;
            clear_form();

        }
        else
        {

            FillData();

        }
    }
}
