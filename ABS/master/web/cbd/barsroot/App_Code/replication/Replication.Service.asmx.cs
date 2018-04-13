using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Web;
using System.Web.Services;
using System.Xml;
using Bars.Configuration;

/// <summary>
/// Summary description for Service.
/// </summary>
public class ReplicationService : Bars.BarsWebService
{
    public ReplicationService() { InitializeComponent(); }
	#region Component Designer generated code
	
	//Required by the Web Services Designer 
	private IContainer components = null;
			
	/// <summary>
	/// Required method for Designer support - do not modify
	/// the contents of this method with the code editor.
	/// </summary>
	private void InitializeComponent()
	{
	}

	/// <summary>
	/// Clean up any resources being used.
	/// </summary>
	protected override void Dispose( bool disposing )
	{
		if(disposing && components != null)
		{
			components.Dispose();
		}
		base.Dispose(disposing);		
	}
	
	#endregion
	/// <summary>
	/// 
	/// </summary>
    [WebMethod(EnableSession = true)]
	public void BeginReplication()
	{
		try
		{
			InitOraConnection ();
			SetRole("ABS_ADMIN");
			SQL_PROCEDURE("bars_repl.refresh");	
		}
		finally
		{
			DisposeOraConnection();
		}
	}
    /// <summary>
    /// 
    /// </summary>
    /// <param name="data"></param>
    /// <returns></returns>
	[WebMethod(EnableSession = true)]
	public object[] GetLog(string[] data)
	{
		try {
			InitOraConnection();
			SetRole("ABS_ADMIN");					
			ArrayList arr = SQL_reader(@"SELECT TO_CHAR(sync_request_date,'dd/MM/yyyy/hh:mm:ss'),
				TO_CHAR(sync_begin_date,'dd/MM/yyyy/hh:mm:ss'),
				TO_CHAR(sync_end_date,'dd/MM/yyyy/hh:mm:ss'),
				sync_status FROM V_REPL_SYNC");

			String val = Convert.ToString(arr[0]) + "%" + Convert.ToString(arr[1]) +
					"%" + Convert.ToString(arr[2]) + "%" + Convert.ToString(arr[3]);
			
			object[] obj_arr = BindTableWithNewFilter("TO_CHAR(sync_record_date,'dd/MM/yyyy/hh:mm:ss') as DAT, sync_record_message as INF","V_REPL_SYNCLOG","",data);
			obj_arr[2] = val;

			return obj_arr;
		}
		finally{				
			DisposeOraConnection();
		}
	}
}

