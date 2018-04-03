using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Oracle.DataAccess.Client;
using Bars.Logger;
using Bars.Oracle;
using Bars.Exception;

/// <summary>
/// Депозитний модуль: Коректування банківського файлу
/// </summary>
public partial class DepositBFRowCorrection : Bars.BarsPage
{
	private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositBFRowCorrection;
		if (!IsPostBack)
		{
			if (Request["info_id"]==null)
			{
                throw new DepositException("Некоректне посилання на сторінку!");
			}
			Decimal info_id = Convert.ToDecimal(Convert.ToString(Request["info_id"]));
			FillControls(info_id);
		}
	}
	/// <summary>
	/// 
	/// </summary>
	/// <param name="info_id"></param>
	private void FillControls(Decimal info_id)
	{
		OracleConnection connect = new OracleConnection();
        OracleDataReader rdr = null;
		try
		{
			// Открываем соединение с БД
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			            

			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

			OracleCommand cmdSearch = connect.CreateCommand();
			cmdSearch.CommandText = "SELECT NLS, " +
				"branch_code,dpt_code,SUM/100,fio,pasp,REF,incorrect,closed,excluded,branch,agency_name " +
				"FROM V_DPT_FILE_ROW WHERE info_id=:info_id";
			
			cmdSearch.Parameters.Add("info_id",OracleDbType.Decimal,info_id,ParameterDirection.Input);

			rdr = cmdSearch.ExecuteReader();
			if (!rdr.Read())
			{
                throw new DepositException("Запис в базі про стрічку банківського файлу з номером " 
					+ info_id.ToString() + " не знайдена!");
			}

			if (!rdr.IsDBNull(0))
				textNLS.Text = Convert.ToString(rdr.GetOracleString(0).Value);
			if (!rdr.IsDBNull(1))
				textBranchCode.Text = Convert.ToString(rdr.GetOracleDecimal(1).Value);
			if (!rdr.IsDBNull(2))
				textDptCode.Text = Convert.ToString(rdr.GetOracleDecimal(2).Value);
			if (!rdr.IsDBNull(3))
				Sum.ValueDecimal = Convert.ToDecimal(Convert.ToString(rdr.GetOracleDecimal(3).Value));
			if (!rdr.IsDBNull(4))
				textFIO.Text = Convert.ToString(rdr.GetOracleString(4).Value);
			if (!rdr.IsDBNull(5))
				textPasp.Text = Convert.ToString(rdr.GetOracleString(5).Value);
			if (!rdr.IsDBNull(6))
                textRef.Text = Convert.ToString(rdr.GetOracleDecimal(6).Value);
			if (!rdr.IsDBNull(7))
			{
				Decimal dummy = Convert.ToDecimal(Convert.ToString(rdr.GetOracleDecimal(7).Value));
				ckIncorrect.Checked = (dummy == 1) ?  true : false;
			}
			if (!rdr.IsDBNull(8))
			{
				Decimal dummy = Convert.ToDecimal(Convert.ToString(rdr.GetOracleDecimal(8).Value));
				ckClosed.Checked = (dummy == 1) ?  true : false;
			}
			if (!rdr.IsDBNull(9))
			{
				Decimal dummy = Convert.ToDecimal(Convert.ToString(rdr.GetOracleDecimal(9).Value));
				ckExcluded.Checked = (dummy == 1) ?  true : false;
			}

            String tmp_branch = String.Empty;
            if (!rdr.IsDBNull(10))
                tmp_branch = Convert.ToString(rdr.GetOracleString(10).Value);

            if (!rdr.IsDBNull(11))
                textAgency.Text = Convert.ToString(rdr.GetOracleString(11).Value);

			if (!rdr.IsClosed)
			{ rdr.Close();rdr.Dispose(); }

            OracleDataAdapter ad = new OracleDataAdapter();
            DataSet dsBranch = new DataSet();
            OracleCommand cmdFillBranch = connect.CreateCommand();
            cmdFillBranch.CommandText = @"select b.branch, b.name 
                from branch b, (
                            SELECT CHILD_BRANCH || '%' branch
                            FROM DPT_FILE_SUBST
                            WHERE PARENT_BRANCH = sys_context('bars_context','user_branch')
                        ) sub
                WHERE b.branch = sys_context('bars_context','user_branch')
                     OR b.BRANCH like sub.branch";

            ad.SelectCommand = cmdFillBranch;
            ad.Fill(dsBranch);

            ddBranch.DataSource = dsBranch;
            ddBranch.DataTextField = "NAME";
            ddBranch.DataValueField = "BRANCH";
            ddBranch.DataBind();

            ddBranch.SelectedIndex = ddBranch.Items.IndexOf(
                ddBranch.Items.FindByValue(tmp_branch));
		}
		finally	
		{
            if (!rdr.IsClosed)
            { rdr.Close(); rdr.Dispose(); }
			if (connect.State != ConnectionState.Closed)
			{connect.Close();connect.Dispose();}
		}
	}
	#region Web Form Designer generated code
	override protected void OnInit(EventArgs e)
	{
		//
		// CODEGEN: This call is required by the ASP.NET Web Form Designer.
		//
		InitializeComponent();
		base.OnInit(e);
	}
	
	/// <summary>
	/// Required method for Designer support - do not modify
	/// the contents of this method with the code editor.
	/// </summary>
	private void InitializeComponent()
	{    
		this.btAccept.Click += new System.EventHandler(this.btAccept_Click);
	}
	#endregion
	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void btAccept_Click(object sender, System.EventArgs e)
	{
		OracleConnection connect = new OracleConnection();
		Decimal info_id = Convert.ToDecimal(Convert.ToString(Request["info_id"]));

        string message = "";

        try
		{
			// Открываем соединение с БД
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			

			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

            //OracleCommand cmdGetMfo = connect.CreateCommand();
            //cmdGetMfo.CommandText = "SELECT MFO_B " +
            //    "FROM DPT_FILE_HEADER h,DPT_FILE_ROW r " +
            //    "WHERE r.info_id=:info_id AND r.filename=h.filename AND r.dat = h.dat";
            //cmdGetMfo.Parameters.Add("info_id",		OracleDbType.Decimal,	info_id, ParameterDirection.Input);

            //Decimal mfo = Convert.ToDecimal(Convert.ToString(cmdGetMfo.ExecuteScalar()));

            /// Не перевіряємо карткові рахунки
            if (textNLS.Text.Trim().Length < 4)
            {
                Response.Write("<script>alert('Довжина рахунку менша допустимої!');</script>");
                return;
            }
            if (BankFile.IsCardAcc(textNLS.Text.Trim()))
            {
                OracleCommand cmdCkCardAcc = connect.CreateCommand();
                cmdCkCardAcc.CommandText = "select dpt_social.check_tm_card(:nls,:branch)+dpt_social.is_valid_social_card(:nls,:branch) from dual";
                cmdCkCardAcc.BindByName = true;
                cmdCkCardAcc.Parameters.Add("nls", OracleDbType.Varchar2, textNLS.Text.Trim(), ParameterDirection.Input);
                cmdCkCardAcc.Parameters.Add("branch", OracleDbType.Varchar2, ddBranch.SelectedValue, ParameterDirection.Input);
                Decimal res = Convert.ToDecimal(cmdCkCardAcc.ExecuteScalar());
                if (res < 1 && !ckExcluded.Checked)
                {
                    Response.Write("<script>alert('Картковий рахунок не існує або некоректний!');</script>");
                    return;
                }
            }
            else
            {
                OracleCommand cmdCheckNLS = connect.CreateCommand();
                cmdCheckNLS.CommandText = "begin dpt_social.check_account_access(:nls,:branch,:p_exists); dpt_social.check_account_closed(:nls, :branch,:p_closed); end;";
                cmdCheckNLS.BindByName = true;

                Decimal p_exists = 0;
                Decimal p_closed = 1;
                cmdCheckNLS.Parameters.Add("nls", OracleDbType.Varchar2, textNLS.Text.Trim(), ParameterDirection.Input);
                cmdCheckNLS.Parameters.Add("branch", OracleDbType.Varchar2, ddBranch.SelectedValue, ParameterDirection.Input);
                cmdCheckNLS.Parameters.Add("p_exists", OracleDbType.Decimal, p_exists, ParameterDirection.Output);
                cmdCheckNLS.Parameters.Add("p_closed", OracleDbType.Decimal, p_closed, ParameterDirection.Output);

                cmdCheckNLS.ExecuteNonQuery();
                p_exists = Convert.ToDecimal(Convert.ToString(cmdCheckNLS.Parameters["p_exists"].Value));
                p_closed = Convert.ToDecimal(Convert.ToString(cmdCheckNLS.Parameters["p_closed"].Value));

                if ((p_exists - p_closed <= 0) && !ckExcluded.Checked)
                {
                    message = "Введенный счет не существует либо закрыт!\\nВведите корректные данные.";
                    message = Resources.Deposit.GlobalResources.al42;

                    //Response.Write("<script>alert('Введенный счет не существует либо закрыт!\\nВведите корректные данные.');</script>");
                    Response.Write("<script>alert('" + message + "');</script>");
                    return;
                }
            }

			OracleCommand cmdUpdate = connect.CreateCommand();
			cmdUpdate.CommandText = "update DPT_FILE_ROW set NLS=:nls, " +
				" branch_code=:branch_code,dpt_code=:dpt_code,SUM=:sum,fio=:fio, " +
                "pasp = :pasp,excluded = :excluded, branch = :branch, incorrect = 0, closed = 0 " +
				"WHERE info_id=:info_id";
			
			cmdUpdate.Parameters.Add("nls",			OracleDbType.Varchar2,	textNLS.Text.Trim(),					ParameterDirection.Input);
			cmdUpdate.Parameters.Add("branch_code",	OracleDbType.Decimal,	Convert.ToDecimal(textBranchCode.Text),	ParameterDirection.Input);
			cmdUpdate.Parameters.Add("dpt_code",	OracleDbType.Decimal,	Convert.ToDecimal(textDptCode.Text),	ParameterDirection.Input);
			cmdUpdate.Parameters.Add("sum",			OracleDbType.Decimal,	Sum.ValueDecimal * 100,					ParameterDirection.Input);
			cmdUpdate.Parameters.Add("fio",			OracleDbType.Varchar2,	textFIO.Text,							ParameterDirection.Input);
			cmdUpdate.Parameters.Add("pasp",		OracleDbType.Varchar2,	textPasp.Text,							ParameterDirection.Input);
			cmdUpdate.Parameters.Add("excluded",	OracleDbType.Decimal,	ckExcluded.Checked?1:0,					ParameterDirection.Input);
            cmdUpdate.Parameters.Add("branch",      OracleDbType.Varchar2, ddBranch.SelectedValue, ParameterDirection.Input);
			cmdUpdate.Parameters.Add("info_id",		OracleDbType.Decimal,	info_id,								ParameterDirection.Input);

			cmdUpdate.ExecuteNonQuery();

			FillControls(info_id);

            message = "Обновление прошло успешно!";
            message = Resources.Deposit.GlobalResources.al43;
            Response.Write("<script>alert('" + message + "');</script>");
		}
		finally	
		{
			if (connect.State != ConnectionState.Closed)
			{connect.Close();connect.Dispose();}
		}		
	}
}

