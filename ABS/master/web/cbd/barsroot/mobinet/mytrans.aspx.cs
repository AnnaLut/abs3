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
using Bars.Oracle;

namespace mobinet
{
	/// <summary>
	/// Summary description for MyTrans.
	/// </summary>
    public partial class MyTrans : Bars.BarsPage
	{
		private string _strDBRole;
		private string _strTitle;
		private string _strTableSource;
		private string _strWhereClause;
        private DataSet ds;
	
		private void Page_Load(object sender, System.EventArgs e)
		{
			InitialSetup();
		}

		private void InitialSetup()
		{
			string strAct = Request.Params["act"];
			if(null==strAct) throw new Exception("В URL не задан параметр act");
			int act = int.Parse(strAct);
			switch(act)
			{
				case 0: 
				{	
					_strDBRole = "mobinet";
					_strTitle = "Свои транзакции пополнения счета за сегодня";
					_strTableSource = "v_mobi_trans";					
				};break;
				case 1: 
				{	
					_strDBRole = "mobinet";
					_strTitle = "Свои транзакции пополнения счета за период";
					_strTableSource = "v_mobi_trans";
				};break;
				case 2: 
				{	
					_strDBRole = "mobinet_admin";
					_strTitle = "Все транзакции пополнения счета за сегодня";
					_strTableSource = "mobi_trans";					
				};break;
				case 3: 
				{	
					_strDBRole = "mobinet_admin";
					_strTitle = "Все транзакции пополнения счета за период";
					_strTableSource = "mobi_trans";
				};break;
				default:
				{
					throw new Exception("Недопустимое значение параметра act");
				}
			}			
			if(0==act || 2==act)
			{
				_strWhereClause = " where trans_time>=trunc(sysdate) and trans_time<trunc(sysdate)+1 ";
			}
			else if(1==act || 3==act)  // транзакции за период
			{	// должны присутствовать даты
				string strStart  = Request.Params["start"];
				string strFinish = Request.Params["finish"];
				if(null==strStart)
					throw new Exception("Не задан параметр start");
				if(null==strFinish)
					throw new Exception("Не задан параметр finish");
				_strWhereClause = " where trans_time>=to_date('"+strStart+
					"','DD.MM.YYYY') and trans_time<to_date('"+strFinish+"','DD.MM.YYYY')+1 ";
				_strTitle += " с "+strStart+" по "+strFinish;
			}
			theTitle.Text = _strTitle;
		}
		private void FillControls()
		{
            OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
			try
			{
				OracleCommand command = new OracleCommand();
				command.Connection = connect;
				OracleDataAdapter adapter = new OracleDataAdapter(command);
				// устанавливаем роль
				command.CommandText = "set role "+_strDBRole;
				command.ExecuteNonQuery();
				command.CommandText = "select trans, '<span title=\"Нажмите для получения статуса транзакции\" onclick=\"ViewStatus('||trans||')\">'||trans||'</span>' trans_span, "
					+"decode(complete_status,NULL,'<span class=\"akaLink\" onclick=\"addCommitTrans('||trans||','||decode(bdate,mobi.getCurBankDate,0,1)||')\">Зафиксировать</span>',22,decode(ref,NULL,'<span class=\"akaLink\" onclick=\"addPayTrans('||trans||','||decode(bdate,mobi.getCurBankDate,0,1)||')\">Оплатить</span>',decode(sep_ref,NULL,'<span class=\"akaLink\" onclick=\"addRevokeTrans('||trans||')\">Аннулировать</span>',NULL)),NULL) act, "
					+"trans_time, "
					+"phone, mobi.getNamePhoneOwner(phone) name, "
					+"s/100 s, "
					+"decode(trans_status,NULL,NULL,'<span id=\"trans_status_'||trans||'\" onmouseover=\"GetMobipayMessage(trans_status_'||trans||','||trans_status||')\" onmouseout=\"ResetMobipayMessage()\">'||trans_status||'</span>') as trans_status, "					
					+"decode(check_status,NULL,NULL,'<span id=\"check_status_'||trans||'\" onmouseover=\"GetMobipayMessage(check_status_'||trans||','||check_status||')\" onmouseout=\"ResetMobipayMessage()\">'||check_status||'</span>') as check_status, "
					+"check_time, "
					+"decode(complete_status,NULL,NULL,'<span id=\"complete_status_'||trans||'\" onmouseover=\"GetMobipayMessage(complete_status_'||trans||','||complete_status||')\" onmouseout=\"ResetMobipayMessage()\">'||complete_status||'</span>') as complete_status, "
					+"complete_time, "
					+"bdate, "
					+"mobi.GetOperName(usr) opname, "
					+"mobi.GetToboName(tobo) toboname, "
					+"ref, decode(ref,NULL,NULL,'/barsroot/documentview/default.aspx?ref='||ref) as ref_url, "
					+"sep_ref, decode(sep_ref,NULL,NULL,'/barsroot/documentview/default.aspx?ref='||sep_ref||decode(mobi.GetDocSign(sep_ref),NULL,'&sign=put','')) as sep_ref_url, "
					+"sep_time "
					+"from "+_strTableSource+_strWhereClause
					+" order by trans desc";
				adapter.Fill(ds, "v_mobi_trans");
				
			}
			finally
			{	
				connect.Close();
				connect.Dispose();
			}
			dg.DataSource = ds;
			dg.DataBind();
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
			this.ds = new System.Data.DataSet();
			((System.ComponentModel.ISupportInitialize)(this.ds)).BeginInit();
			this.dg.SortCommand += new System.Web.UI.WebControls.DataGridSortCommandEventHandler(this.dg_SortCommand);
			this.dg.Load += new System.EventHandler(this.dg_Load);
			// 
			// ds
			// 
			this.ds.DataSetName = "NewDataSet";
			this.ds.Locale = new System.Globalization.CultureInfo("uk-UA");
			this.Load += new System.EventHandler(this.Page_Load);
			((System.ComponentModel.ISupportInitialize)(this.ds)).EndInit();

		}
		#endregion

		private void dg_Load(object sender, System.EventArgs e)
		{
			FillControls();		
		}

		private void dg_SortCommand(object source, System.Web.UI.WebControls.DataGridSortCommandEventArgs e)
		{
			DataView dv = new DataView(ds.Tables["v_mobi_trans"]);
			dv.Sort = e.SortExpression;
			dg.DataSource = dv;
			dg.DataBind();
		}
	}
}
