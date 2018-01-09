using System;
using System.Web.UI;
using Oracle.DataAccess.Client;
using Bars.Oracle;
using System.Web.UI.WebControls;
namespace bars.web
{
	/// <summary>
	/// Меню АРМов
	/// </summary>
	public partial class applist : System.Web.UI.Page
	{
	
		protected void Page_Load(object sender, System.EventArgs e)
		{			
			//IMenuReader menurdr = (IMenuReader) new MenuReader();
			//menurdr.FillMenu(listbarApp);
			PopulateMainMenu();
		}

		private void PopulateMainMenu()
		{
			// Открываем соединение
			IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
			OracleConnection connect = conn.GetUserConnection(Context);			
			
			try
			{
				OracleCommand cmd = new OracleCommand();
				try
				{	
					cmd.Connection = connect;
					// устанавливаем роль
					OracleCommand command = connect.CreateCommand();				
					command.CommandText = conn.GetSetRoleCommand("menu_reader");
					command.ExecuteNonQuery();
					// вычитываем содержимое армов
					// не включаем арм WTOP так как этот арм отображается в меню верхних ссылок
					string strArms = @"select codeapp,appname,codeoper,opername,funcname 
						from v_operapp 
						where frontend=1 
						and runable <> 3 
						and codeapp <> 'WTOP' 
						order by appname, opername";
					cmd.CommandText = strArms;
					OracleDataReader rdr = cmd.ExecuteReader();
					string strPrevArm = "";

					PlaceHolder apps = null;
					Table tbl = null;
					TableRow row = null;
					TableCell cell = null;
					while(rdr.Read())
					{
						string strCodeapp = rdr.GetString(0);
						string strAppname = rdr.GetString(1);
						string strOpername = rdr.GetString(3);
						string strUrl = rdr.GetString(4);
						string display = "";
						string img_menu = "images/uparrows.gif";
						if(strPrevArm!=strCodeapp)  // добавляем АРМ, если надо
						{							
							if(""!=strPrevArm)
							{
								apps.Controls.Add(new LiteralControl("</DIV>"));
                                apps.Controls.Add(new LiteralControl("<br>"));
							}
                            display = "none";
                            img_menu = "images/downarrows.gif";

							apps = new PlaceHolder();
                            
                            
                            apps.Controls.Add(new LiteralControl("<b class=\"rtop\"><b class=\"r1\"></b><b class=\"r2\"></b> <b class=\"r3\"></b> <b class=\"r4\"></b></b>"));
                            apps.Controls.Add(new LiteralControl("<div class=\"menuTitle\">"));
							tbl = new Table();
                            tbl.CellPadding = 0;
                            tbl.CellSpacing = 0;
							
							row = new TableRow();
							row.Style.Add("font-family","Verdana");
							row.Style.Add("font-size","10pt");
							row.Style.Add("height","23px");
							row.Style.Add("cursor","Hand");
                            //row.Attributes.Add("onclick", "subMenu('" + strCodeapp.Trim() + "',this)");
							
							cell = new TableCell();
							cell.Text = strAppname;
							cell.Style.Add("width","98%");
							row.Cells.Add(cell);
							cell = new TableCell();
                            cell.Attributes.Add("valign", "top");
							cell.Controls.Add(new LiteralControl("<img onclick=\"subMenu('"+strCodeapp.Trim()+"',this)\" align=\"absmiddle\" src=\""+img_menu+"\" />"));
							row.Cells.Add(cell);

							tbl.Controls.Add(row);
							apps.Controls.Add(tbl);
							apps.Controls.Add(new LiteralControl("</DIV>"));
                            apps.Controls.Add(new LiteralControl("<DIV id='" + strCodeapp.Trim() + "' class=\"menuItem\" style=\"display:" + display + " \">"));
							strPrevArm=strCodeapp;
                        }						
						// если функция "ПЕЧАТЬ ОТЧЕТОВ" ==> добавляем в URL код АРМа
                        const string strCbiRep = "/barsroot/cbirep/rep_list.aspx?codeapp=\\w+";
						const string strReferences = "/barsroot/barsweb/references/reflist.aspx";
						if(strUrl.ToLower()==strCbiRep.ToLower())
						{
                            strUrl = "/barsroot/cbirep/rep_list.aspx?codeapp=" + strCodeapp;
						}
						else if(strUrl.ToLower()==strReferences)
						{
							strUrl += "?app="+strCodeapp;
						}
						// добавляем функции
						
//						apps.Controls.Add(new LiteralControl("<LI style=\"cursor:Hand;MARGIN-LEFT:15px\" onclick=\"go('"+strUrl+"')\" onmouseleave=\"this.style.color='Black';this.style.textDecoration='none'\" onmousemove=\"this.style.color='Black';this.style.textDecoration='underline'\">"+strOpername+"</li>"));
                        apps.Controls.Add(new LiteralControl("<LI class=\"menuItem\" onclick=\"go('" + strUrl + "')\" >" + strOpername + "</li>"));
						 
						listApp.Controls.Add(apps);
					}
					listApp.Controls.Add(new LiteralControl("</DIV>"));
					rdr.Close();					
				}
				finally
				{
					cmd.Dispose();
				}
			}
			finally
			{
				connect.Close();
				connect.Dispose();
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

		}
		#endregion

	}
}
