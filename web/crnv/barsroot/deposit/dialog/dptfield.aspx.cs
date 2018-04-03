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
using Bars.Oracle;
using Bars.Logger;
using Oracle.DataAccess.Client;

/// <summary>
/// Депозитний модуль: Додаткові реквізити вкладу
/// </summary>
public partial class DptField : Bars.BarsPage
{
	private void Page_Load(object sender, System.EventArgs e)
	{
		if (Request["dpt_id"]==null)
			Response.Redirect("../barsweb/welcome.aspx");

		GetDptFields();
	}

    /// <summary>
    /// Локализация
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        lbTitle.Text = lbTitle.Text.Replace("%s", Convert.ToString(Request["dpt_id"]));
    }
	/// <summary>
	/// 
	/// </summary>
	private void GetDptFields()
	{
		dpt_controls.Value = String.Empty;
		mand_field.Value = String.Empty;

		if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
		{
			tbDptField.Visible = false;
		}
		else if (BankType.GetCurrentBank() == BANKTYPE.UPB)
		{
			OracleConnection connect = new OracleConnection();
			Deposit dpt = new Deposit(Convert.ToDecimal(Convert.ToString(Request["dpt_id"])));
			dpt.ReadDptField();

			if (dpt.DptField.Count < 1)
			{
				tbDptField.Visible = false;
				btUpdate.Enabled = false;
				return;
			}
			else
			{
				HtmlTableRow row;

				for (int i = 0; i<dpt.DptField.Count; i++)
				{
					DepositField dpf = (DepositField)dpt.DptField[i];

					row = new HtmlTableRow();
					row.Cells.Add(new HtmlTableCell());
					row.Cells.Add(new HtmlTableCell());
					row.Cells.Add(new HtmlTableCell());

					tbDptField.Rows.Add(row);

					String control_name = dpf.Tag;
					int ws_pos = control_name.IndexOf(" ");
					if (ws_pos > 0)
						control_name = control_name.Substring(0,ws_pos);

					dpt_controls.Value += control_name + ",";

					tbDptField.Rows[i+1].Cells[0].Style.Add("WIDTH","20%");
					tbDptField.Rows[i+1].Cells[1].Style.Add("WIDTH","25%");
					tbDptField.Rows[i+1].Cells[2].Style.Add("WIDTH","55%");
										
					tbDptField.Rows[i+1].Cells[0].InnerText = dpf.Nmk;
					tbDptField.Rows[i+1].Cells[0].Style.Add("FONT-FAMILY","Arial");
					tbDptField.Rows[i+1].Cells[0].Style.Add("FONT-SIZE","10pt");
				
					int tab_index = (10 + i);

					tbDptField.Rows[i+1].Cells[1].NoWrap = true;
					tbDptField.Rows[i+1].Cells[1].InnerHtml = "<input name=\"" + control_name
						+"\" type=\"text\" runat=\"server\" TabIndex=\""+ tab_index +"\" value=\""+dpf.Val+"\"";
					tbDptField.Rows[i+1].Cells[1].InnerHtml += "class=\"InfoText\"";
					tbDptField.Rows[i+1].Cells[1].InnerHtml += " />";

					if (dpf.Req == "1")
					{							
						tbDptField.Rows[i+1].Cells[0].Style.Add("color","red");
						mand_field.Value += control_name + ",";
					}					
				}
				if (mand_field.Value.Length > 0)
					mand_field.Value = mand_field.Value.Remove(mand_field.Value.Length-1,1);
			}
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
		this.btUpdate.Click += new System.EventHandler(this.btUpdate_Click);
	}
	#endregion
	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void btUpdate_Click(object sender, System.EventArgs e)
	{
		Deposit dpt = new Deposit(Convert.ToDecimal(Convert.ToString(Request["dpt_id"])));
		dpt.ReadDptField();

		String[] dpt_fields = dpt_controls.Value.Split(',');
		foreach (String name in dpt_fields)
		{
			for (int i = 0;i<dpt.DptField.Count;i++)
			{
				DepositField dpf = (DepositField)dpt.DptField[i];
				if (dpf.Tag != name)
					continue;
				dpf.Val = Request.Form[name].ToString();
				break;
			}				
		}
		OracleConnection connect = new OracleConnection();
		try {
			// Создаем соединение
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			// Открываем соединение с БД
			

			// Установка роли
			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

			dpt.WriteDptField(connect);
		}
		finally {
			if (connect.State != ConnectionState.Closed)
			{connect.Close();connect.Dispose();}
		}
		
		Page_Load(sender,e);

        Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al41 + "');</script>");
        //Response.Write("<script>alert('Доп. реквизиты вклада были успешно обновлены.');</script>");
		Response.Flush();
	}
}

