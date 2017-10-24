﻿using System;
using System.Data;
using Bars.Oracle;
using Oracle.DataAccess.Client;

	/// <summary>
	/// Summary description for SelectCountry.
	/// </summary>
    public partial class SelectCountry : Bars.BarsPage
	{
		protected System.Data.DataSet dsCountry;
		private void Page_Load(object sender, System.EventArgs e)
		{
			OracleConnection connect = new OracleConnection();	

			try
			{
				// Создаем соединение
				IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
				connect = conn.GetUserConnection();
				// Открываем соединение с БД
				
				// Установка роли
				OracleCommand cmdSetRole = new OracleCommand();
				cmdSetRole.Connection = connect;
				cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
				cmdSetRole.ExecuteNonQuery();

				OracleDataAdapter adapterCountry = new OracleDataAdapter();
				OracleCommand cmdSelectCountry = connect.CreateCommand();
				cmdSelectCountry.CommandText = "select country, name from country";
				adapterCountry.SelectCommand = cmdSelectCountry;
				// Заполняем список стран
				adapterCountry.Fill(dsCountry);
				listCountry.DataBind();

				Client client = ((SocialDeposit)Session["DepositInfo"]).Client;

				listCountry.SelectedIndex = listCountry.Items.IndexOf(listCountry.Items.FindByValue(client.CountryCode.ToString()));
			}
			finally	
			{
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
			this.dsCountry = new System.Data.DataSet();
			((System.ComponentModel.ISupportInitialize)(this.dsCountry)).BeginInit();
			// 
			// dsCountry
			// 
			this.dsCountry.DataSetName = "dsCountry";
			this.dsCountry.Locale = new System.Globalization.CultureInfo("ru");
			this.Load += new System.EventHandler(this.Page_Load);
			((System.ComponentModel.ISupportInitialize)(this.dsCountry)).EndInit();

		}
		#endregion
}
