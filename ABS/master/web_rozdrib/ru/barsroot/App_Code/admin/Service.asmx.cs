using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Web;
using System.Web.Services;
using System.Xml;

namespace BarsWeb.Admin
{
	/// <summary>
	/// Summary description for Service.
	/// </summary>
	public class Service : Bars.BarsWebService
	{
		public Service()
		{
			//CODEGEN: This call is required by the ASP.NET Web Services Designer
			InitializeComponent();
		}

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

		// WEB SERVICE EXAMPLE
		// The HelloWorld() example service returns the string Hello World
		// To build, uncomment the following lines then save and build the project
		// To test this web service, press F5

		[WebMethod(EnableSession = true)]
		public void BeginReplication()
		{
			try
			{
				InitOraConnection ();
				SetRole("ABS_ADMIN");
				SQL_PROCEDURE("bars_repl.refresh");	
//				GenerateXmlFile();
			}
			finally
			{
				DisposeOraConnection();
			}
		}
		public void GenerateXmlFile()
		{
			try
			{
				InitOraConnection ();
				SetRole("BASIC_INFO");
				DataSet ds = SQL_SELECT_dataset("SELECT logname,fio FROM staff WHERE bax=1 ORDER BY id");

				XmlDocument doc = new XmlDocument();
				doc.Load(Bars.Configuration.ConfigurationSettings.UserMapConfig);
				ClearUsers(doc);

				foreach (DataRow r in ds.Tables[0].Rows)
				{
					InsertUser(r.ItemArray[0].ToString(),r[1].ToString(),doc);
				}					
			}
			finally
			{
				DisposeOraConnection();
			}
		}
		public void InsertUser(String username, String FIO, XmlDocument doc)
		{
			XmlNode section =  doc.SelectSingleNode("//userMapSettings");

			XmlNode node;
			if (section.ChildNodes.Count == 0)
			{
				node = doc.CreateNode(XmlNodeType.Element,"map",doc.NamespaceURI);
				XmlAttribute webuser = doc.CreateAttribute("webuser");
				node.Attributes.Append(webuser);
				XmlAttribute dbuser = doc.CreateAttribute("dbuser");
				node.Attributes.Append(dbuser);
				XmlAttribute errormode = doc.CreateAttribute("errormode");
				node.Attributes.Append(errormode);
				XmlAttribute webpass = doc.CreateAttribute("webpass");
				node.Attributes.Append(webpass);
				XmlAttribute comm = doc.CreateAttribute("comm");
				node.Attributes.Append(comm);
			}
			else
			{
				node = section.ChildNodes[0].Clone();
			}

			node.Attributes["webuser"].Value = username;
			node.Attributes["dbuser"].Value = username;
			node.Attributes["errormode"].Value = "0";
			node.Attributes["webpass"].Value = "";
			node.Attributes["comm"].Value = FIO;
				
			section.AppendChild(node);

			doc.Save(Bars.Configuration.ConfigurationSettings.UserMapConfig);
		}
		private void ClearUsers(XmlDocument doc)
		{
			XmlNode section =  doc.SelectSingleNode("//userMapSettings");

			section.RemoveAll();
			doc.Save(Bars.Configuration.ConfigurationSettings.UserMapConfig);
		}
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
}
