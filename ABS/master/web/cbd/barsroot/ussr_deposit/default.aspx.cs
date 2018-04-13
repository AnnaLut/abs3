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
using Bars.Oracle;
using Oracle.DataAccess.Client;
using System.Web.Services;
using Bars.Classes;
using Oracle.DataAccess.Types;
using Bars.Logger;

public partial class deposit_compensation_Default : System.Web.UI.Page
{
    private int row_counter = 0;
    protected System.Data.DataSet dsKV;
    protected System.Data.DataSet dsDptType;
    /// <summary>
    /// 
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
//      CreatePayoffTable();
        tblAllDeposits.Visible = false;
        RegisterClientScript();
        
        if (!IsPostBack)
            InitDocType();
    }
    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        if (sourceControl.GetType().Name == "BarsGridView" || (eventArgument != null && eventArgument.Length > 4 && eventArgument.Substring(0, eventArgument.IndexOf("$")) == "Bars"))
        {
            tblAllDeposits.Visible = false;
            InitClientGrid(); 
        }

        base.RaisePostBackEvent(sourceControl, eventArgument);
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btSearch_Click(object sender, EventArgs e)
    {
        InitClientGrid();
    }
    private void InitClientGrid()
    {
        dsClients.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsClients.PreliminaryStatement = "begin " +
          Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
          " begin set_full_access; end; end;";
        dsClients.SelectParameters.Clear();
        dsClients.SelectCommand = @"select '<A href=# onclick=''GetClientCard('||RNK||')''>'||RNK||'</a>' RNK, 
                NMK, OKPO, SER, NUMDOC, 
                ORG, ADR, BRANCH, BRANCH_NAME, 
                replace(to_char(LIM,'FM999G999G999G990D00'),',',' ') LIM,
                DBCODE, RNK as CARD
                from v_ussr_customer
                where 1=1 ";

        if (ddType.SelectedItem != null)
        {
            dsClients.SelectCommand += " and PASSP = :PASSP ";
            Parameter par = new Parameter("PASSP", TypeCode.Decimal, ddType.SelectedValue);
            dsClients.SelectParameters.Add(par);
        }
        if (!String.IsNullOrEmpty(SERIAL.Text))
        {
            dsClients.SelectCommand += " and ser = :SERIAL ";
            Parameter par = new Parameter("SERIAL", TypeCode.String, SERIAL.Text);
            par.Size = 100;
            dsClients.SelectParameters.Add(par);
        }
        if (!String.IsNullOrEmpty(NUMBER.Text))
        {
            dsClients.SelectCommand += " and numdoc = :NUM ";
            Parameter par = new Parameter("NUM", TypeCode.String, NUMBER.Text);
            par.Size = 100;
            dsClients.SelectParameters.Add(par);
        }
        if (!String.IsNullOrEmpty(sFIO.Text))
        {
            dsClients.SelectCommand += " and upper(nmk) like upper(:sFIO) || '%' ";
            Parameter par = new Parameter("sFIO", TypeCode.String, sFIO.Text);
            par.Size = 200;
            dsClients.SelectParameters.Add(par);

        }
        if (!String.IsNullOrEmpty(DBCODE.Text))
        {
            dsClients.SelectCommand += " and dbcode = :DBCODE ";
            Parameter par = new Parameter("DBCODE", TypeCode.String, DBCODE.Text);
            par.Size = 100;
            dsClients.SelectParameters.Add(par);
        }

        Bars.Logger.DBLogger.Info("Пошук клієнта: ПІБ = " + sFIO.Text +
            ", серія = " + SERIAL.Text + ", номер = " + NUMBER.Text + 
            ", DBCODE = " + DBCODE.Text,
            "ussr_deposit");
        
        // "and (p.ser = '" + SERIAL.Text +
        //"' or p.numdoc = '" + NUMBER.Text +
        //"' or upper(c.nmk) like upper('%" + sFIO.Text + "%'))";
        //dsClients.SelectParameters.Add("SER", TypeCode.String, SERIAL.Text);
        //dsClients.SelectParameters.Add("NDOC", TypeCode.String, NUMBER.Text);
        //dsClients.SelectParameters.Add("NMK", TypeCode.String, "%" + sFIO.Text + "%");
    }
    private void InitGrid(String rnk)
    {
        dsDeposits.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsDeposits.PreliminaryStatement = "begin " + 
          Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
          " begin set_full_access; end; end;";

        String addition = " NULL NLS_CORRECT, ";
        if (Request["mode"] == "edit_account")
            addition = "'<A href=# onclick=''AccCard('||a.acc||')''>Картка рахунку</a>' NLS_CORRECT, ";

        dsDeposits.SelectCommand = @"select '<A href=# onclick=''ShowDepositCard('||d.deposit_id||')''>Перегляд</a>' DPT_ID, 
                d.nd DPT_NUM, v.type_name TYPE_NAME, 
                '<A href=# onclick=''Acc('||a.acc||')''>'||a.nls||'</a>' NLS, a.kv KV, " +
                addition + 
                @" replace(to_char(-a.ostc/100,'FM999G999G999G990D00'),',',' ') OSTC, 
                replace(to_char(sum(nvl(s.dos,0))/100,'FM999G999G999G990D00'),',',' ') INIT,
                replace(to_char(sum(nvl(s.kos,0))/100,'FM999G999G999G990D00'),',',' ') PAID,
                a.tobo TOBO, t.name TOBO_NAME, d.deposit_id SDPTID                 
            from saldoa s, dpt_deposit d, accounts a, dpt_vidd v, tobo t 
            where s.acc(+) = d.acc and d.rnk = :rnk and d.acc = a.acc and d.vidd = v.vidd and t.tobo = a.tobo
            group by d.deposit_id, d.nd, v.type_name, a.acc, a.nls, a.kv, a.ostc, a.tobo, t.name";
        dsDeposits.SelectParameters.Add("rnk", TypeCode.Decimal, rnk);
    }
    /// <summary>
    /// Клієнтський скріпт, який
    /// при виборі рядка таблиці
    /// виділяє його кольором
    /// </summary>
    private void RegisterClientScript()
    {
        string script = @"<script language='javascript'>
			var selectedRow;
			function S_A(id,p_dptid)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
             document.getElementById('DPT_ID').value = p_dptid;
             selectDeposit();
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script_A", script);
    }
    protected void gridDeposits_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            if (Request["mode"] != "edit_account") 
                e.Row.Cells[5].Visible = false;
        }
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();
            GridViewRow row = e.Row;
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S_A('" + row_counter + "','" + row.Cells[1].Text + "')");

            if (Request["mode"] != "edit_account")
                e.Row.Cells[5].Visible = false;
        }
    }

    [WebMethod(EnableSession = true)]
    public static String[] GetDptDates(String dpt_id)
    {
        OracleConnection connect = new OracleConnection();
        String[] result = new String[2];
        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"select to_char(dat_begin,'dd/mm/yyyy'),to_char(dat_end,'dd/mm/yyyy') 
                from dpt_deposit
                where deposit_id = :dpt_id";
            cmd.Parameters.Add("DPT_ID", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                    result[0] = rdr.GetOracleString(0).Value;
                if (!rdr.IsDBNull(1))
                    result[1] = rdr.GetOracleString(1).Value;
                rdr.Close();
                rdr.Dispose();
                return result;
            }
            else
            {
                rdr.Close();
                rdr.Dispose();
                return null;
            }
        }
        catch (Exception ex)
        {
            Deposit.SaveException(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    [WebMethod(EnableSession = true)]
    public static String[] GetBlocking(String dpt_id, String dummy)
    {
        OracleConnection connect = new OracleConnection();
        String[] result = new String[2];
        result[0] = "Опис відсутній";
        result[1] = "Опис відсутній";
        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();


            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSetAccess = connect.CreateCommand();
            cmdSetAccess.CommandText = "begin set_full_access; end;";
            cmdSetAccess.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"select r.name, r1.name
                from dpt_deposit d, accounts a, rang r, rang r1
                where d.deposit_id = :dpt_id and d.acc = a.acc and 
                a.blkd = r.rang and a.blkk = r1.rang";
            cmd.Parameters.Add("DPT_ID", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                    result[0] = rdr.GetOracleString(0).Value;
                if (!rdr.IsDBNull(1))
                    result[1] = rdr.GetOracleString(1).Value;
                rdr.Close();
                rdr.Dispose();
                return result;
            }
            else
            {
                rdr.Close();
                rdr.Dispose();
                return null;
            }
        }
        catch (Exception ex)
        {
            Deposit.SaveException(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    [WebMethod(EnableSession = true)]
    public static String CheckMFO(String mfo)
    {
        OracleConnection connect = new OracleConnection();
        /// 0 - помилка, >0 - успіх
        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "select count(*) from banks where mfo = :mfo";
            cmd.Parameters.Add("mfo", OracleDbType.Decimal, mfo, ParameterDirection.Input);

            return Convert.ToString(cmd.ExecuteScalar());
        }
        catch (Exception ex)
        {
            Deposit.SaveException(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }    
    private void InitKvList(DropDownList ddCASHKV)
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleDataAdapter adapterKV = new OracleDataAdapter();
            OracleCommand cmdKV = connect.CreateCommand();
            cmdKV.CommandText = @"select kv KV, lcv || ' - ' || name NAME
                from tabval
                order by kv";
            adapterKV.SelectCommand = cmdKV;
            
            // Заполняем список стран
            dsKV = new DataSet();
            adapterKV.Fill(dsKV);
            ddCASHKV.DataSource = dsKV;
            ddCASHKV.DataValueField = "KV";
            ddCASHKV.DataTextField = "NAME";
            ddCASHKV.DataBind();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }    
    private void InitDocType()
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleDataAdapter adapterDocType = new OracleDataAdapter();
            OracleCommand cmdDocType = connect.CreateCommand();
            cmdDocType.CommandText = @"select DC, PASSP from passp
                where passp > 0
                order by passp";
            adapterDocType.SelectCommand = cmdDocType;
            
            // Заполняем список стран
            DataSet dsDocType = new DataSet();
            adapterDocType.Fill(dsDocType);
            
            ddType.DataSource = dsDocType;
            ddType.DataValueField = "PASSP";
            ddType.DataTextField = "DC";
            ddType.DataBind();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    private void InitDptTypeList(DropDownList ddType)
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleDataAdapter adapterDptType = new OracleDataAdapter();
            OracleCommand cmdDptType = connect.CreateCommand();
            cmdDptType.CommandText = "select vidd, type_name from v_dpt_vidd_user where kv = 980 order by 1";
            adapterDptType.SelectCommand = cmdDptType;
            
            // Заполняем список стран
            dsDptType = new DataSet();
            adapterDptType.Fill(dsDptType);
            
            ddType.DataSource = dsDptType;
            ddType.DataValueField = "VIDD";
            ddType.DataTextField = "TYPE_NAME";
            ddType.DataBind();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }    
    private void CreatePayoffTable()
    {
        for (int i = 0; i < tbl_payoff.Rows.Count - 1; i++)
            tbl_payoff.Rows[i].Controls.Clear();

        SUM_TOVALIDATE.Value = String.Empty;
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();
            Decimal max_params = 3;

            OracleCommand izvrat = connect.CreateCommand();
            izvrat.CommandText = @"select max(s1) + 1 from
                (
                select (sign(p1) + sign(p2) + sign(p3) + sign(p4) + sign(p5) + sign(p6) + sign(p7)) s1
                from (
                select 
                instr(type_params, '#', 1, 1) p1,
                instr(type_params, '#', 1, 2) p2,
                instr(type_params, '#', 1, 3) p3,
                instr(type_params, '#', 1, 4) p4,
                instr(type_params, '#', 1, 5) p5,
                instr(type_params, '#', 1, 6) p6,
                instr(type_params, '#', 1, 7) p7
                from v_ussr_payofftypes 
                order by 7 desc, 6 desc, 5 desc, 4 desc, 3 desc,2 desc ,1 desc)
                )";
            max_params = Convert.ToDecimal(Convert.ToString(izvrat.ExecuteScalar()));
            
            OracleCommand cmdClientSearch = connect.CreateCommand();
            cmdClientSearch.CommandText = "select type_id, type_code, type_name, type_params, type_proc, type_tt from v_ussr_payofftypes order by type_id desc";
            OracleDataReader rdr = cmdClientSearch.ExecuteReader();
            ArrayList ussr_payoff = new ArrayList();
            
            while (rdr.Read())
            {
                ussr_payofftype p1 = new ussr_payofftype();
                p1.type_id = rdr.GetOracleDecimal(0).Value;
                p1.type_code = rdr.GetOracleString(1).Value;
                p1.type_name = rdr.GetOracleString(2).Value;
                p1.type_params = rdr.GetOracleString(3).Value;
                if (!rdr.IsDBNull(4))
                    p1.type_proc = rdr.GetOracleString(4).Value;
                p1.type_tt = rdr.GetOracleString(5).Value;

                HtmlTableRow row = new HtmlTableRow();
                for (int i = 0; i < max_params + 1; i++ )
                    row.Cells.Add(new HtmlTableCell());

                tbl_payoff.Rows.Insert(0, row);

                tbl_payoff.Rows[0].Cells[0].Style.Add("WIDTH", "20%");
                for (int i = 1; i < max_params + 1; i++)
                {
                    tbl_payoff.Rows[0].Cells[i].Style.Add("WIDTH", Convert.ToString(Math.Round(80 / max_params)) + "%");
                }

                Label lb = new Label();
                lb.ID = "lb_" + p1.type_id;
                lb.Text = p1.type_name;
                lb.CssClass = "InfoText95";
                tbl_payoff.Rows[0].Cells[0].Controls.Add(lb);

                String[] arr = p1.type_params.Split('#');
                WebControl ctrl = new TextBox(); 
                int cell_pos = 1;                
                foreach (String tpar in arr)
                {
                    ussr_payofftype_params p2 = new ussr_payofftype_params();
                    p2.par_name = tpar;
                    switch (tpar)
                    {
                        case "SUM": { 
                            ctrl = new Bars.Web.Controls.NumericEdit();
                            ctrl.ToolTip = "Сума";
                            SUM_TOVALIDATE.Value += tpar + "_" + p1.type_code + ";";
                            ctrl.Attributes["title"] = "Сума";
                        } break;
                        case "CUR": { 
                            ctrl = new DropDownList();
                            ctrl.CssClass = "BaseDropDownList";
                            InitKvList((DropDownList)ctrl);
                        } break;
                        case "MFO": { 
                            ctrl = new TextBox();
                            ctrl.CssClass = "InfoText95";
                            ctrl.Attributes["onblur"] = "ckMFO('" + tpar + "_" + p1.type_code + "'); Verify('" + "_" + p1.type_code + "') ";
                            ctrl.Attributes["title"] = "МФО";
                        } break;
                        case "ACC": {
                            ctrl = new TextBox();
                            ctrl.CssClass = "InfoText95";
                            ctrl.Attributes["title"] = "Рахунок";
                            ctrl.Attributes["onblur"] = "Verify('" + "_" + p1.type_code + "')";
                        } break;
                        case "OKPO":{
                            ctrl = new TextBox();
                            ctrl.CssClass = "InfoText95";
                            ctrl.Attributes["title"] = "Ідентифікаційний код";
                            //ctrl.Attributes["onblur"] = "Verify('" + "_" + p1.type_code + "')";
                        } break;
                        case "NAME":{
                            ctrl = new TextBox();
                            ctrl.CssClass = "InfoText95";
                            ctrl.Attributes["title"] = "Найменування";
                            //ctrl.Attributes["onblur"] = "Verify('" + "_" + p1.type_code + "')";
                        } break;
                        case "DPTYPE":{
                            ctrl = new DropDownList();
                            ctrl.CssClass = "BaseDropDownList";
                            ctrl.Attributes["title"] = "Тип депозиту";
                            //ctrl.Attributes["onblur"] = "Verify('" + "_" + p1.type_code + "')";
                            InitDptTypeList((DropDownList)ctrl);
                        } break;
                        case "CARD":{
                            ctrl = new TextBox();
                            ctrl.CssClass = "InfoText95";
                            ctrl.Attributes["title"] = "Картковий рахунок";
                            //ctrl.Attributes["onblur"] = "Verify('" + "_" + p1.type_code + "')";
                        } break;
                    }
                    ctrl.ID = tpar + "_" + p1.type_code;
                    p2.control_name = ctrl.ID;
                    ctrl.TabIndex = Convert.ToInt16(p1.type_id * 10 + cell_pos + 30 );
                    p1.type_params_val.Add(p2);
                    tbl_payoff.Rows[0].Cells[cell_pos].Controls.Add(ctrl);

                    cell_pos++;
                }

                ussr_payoff.Add(p1);
            }
            rdr.Close();
            rdr.Dispose();

            SUM_TOVALIDATE.Value = SUM_TOVALIDATE.Value.Substring(0, SUM_TOVALIDATE.Value.Length - 1);
            Session["USSR_PAYOFF"] = ussr_payoff;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    protected void btPay_Click(object sender, EventArgs e)
    {
        Decimal overall_sum = 0;
        for (int i = 0; i < ((ArrayList)Session["USSR_PAYOFF"]).Count; i++)
        {
            ussr_payofftype p1 = (ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i];
            p1.dpt_id = Convert.ToDecimal(DPT_ID.Value);
            foreach (ussr_payofftype_params p2 in p1.type_params_val)
            {
                if (p2.par_name.ToUpper() != "SUM")
                    p2.par_val = Convert.ToString(Request.Form[p2.control_name]);
                else
                {
                    if (!String.IsNullOrEmpty(Convert.ToString(Request.Form[p2.control_name])))
                    {
                        Decimal mSum = Convert.ToDecimal(
                            Convert.ToString(Request.Form[p2.control_name]).Replace(" ",String.Empty)
                            ) * 100;
                        overall_sum += mSum;
                        if (mSum <= 0) {
                            ((ArrayList)Session["USSR_PAYOFF"]).Remove(p1);
                            i--;
                            break;
                        }
                        else
                            p2.par_val = Convert.ToString(mSum);
                    }
                    else {
                        ((ArrayList)Session["USSR_PAYOFF"]).Remove(p1);
                        i--;
                        break;
                    }
                }
            }
        }

        if (((ArrayList)Session["USSR_PAYOFF"]).Count < 1)
        {
            Response.Write("<script>alert('Не вибраний жоден спосіб виплати!');</script>");
            InitGrid(Convert.ToString(RNK.Value));
            tblClientInfo.Visible = true;
            CreatePayoffTable();
            return;
        }

        ussr_payofftype p = new ussr_payofftype();
        p.dpt_id = Convert.ToDecimal(DPT_ID.Value);
        p.type_id = 0;
        p.type_params_val.Add(new ussr_payofftype_params("SUM",Convert.ToString(overall_sum)));

        ((ArrayList)Session["USSR_PAYOFF"]).Insert(0, p);

        Response.Redirect("sign.aspx");
    }
    protected void gridClients_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "GET_DEPOSITS")
        {
            tblAllDeposits.Visible = true;
            InitGrid(
                Convert.ToString(
                    ( ( LinkButton)
                            gridClients.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Controls[0]).Text.Substring(21)
                )
            );
        }
    }
}
