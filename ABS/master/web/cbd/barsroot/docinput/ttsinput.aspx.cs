using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Oracle;
using Oracle.DataAccess.Client;

namespace DocInput
{
	/// <summary>
	/// Summary description for TtsInput.
	/// </summary>
	public partial class TtsInput : Bars.BarsPage
	{
        protected void Page_Load(object sender, EventArgs e)
		{
			if(!this.IsPostBack)
			{
                IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
				OracleConnection con = conn.GetUserConnection(Context);
				try
				{
					OracleCommand cmd = con.CreateCommand();

					cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
					cmd.ExecuteNonQuery();			
			
					cmd.CommandText = @"SELECT DISTINCT REPLACE(NVL(f.name,'...'),'""',''''), t.tt,
								REPLACE(t.tt||'-'||t.name,'""',''''),decode(substr(t.flags,38,1),'0','RO','RW')
                                FROM tts t, folders f, folders_tts ft, staff_tts s 
                               where ft.tt(+)=t.tt and ft.idfo=f.idfo(+) and s.tt=t.tt and 
                        			  s.id in (select bars.user_id  from dual union all select id_whom from staff_substitute where id_who=user_id and date_is_valid(date_start, date_finish, null, null)=1 )  and
                                   t.fli<3 and substr(flags,1,1)='1' and substr(flags, 63, 1)='0' order by 1,2";
			
					OracleDataReader rdr = cmd.ExecuteReader();
					string sGroup = "", sFold, sTT, sName;
					int i = -1;
					int j = -1;
					while (rdr.Read())
					{
						sFold  =       rdr.GetOracleString(0).Value;
						sTT    =       rdr.GetOracleString(1).Value;
						sName  =       rdr.GetOracleString(2).Value;
						if (sFold != sGroup)
						{
							i++; j=-1; sGroup=sFold;
							if("" != sGroup)
								listTts.Controls.Add(new LiteralControl("</DIV>"));
							listTts.Controls.Add(new LiteralControl("<div class=\"tree-item\" onclick=\"sM('"+i+"')\" >"));
                            listTts.Controls.Add(new LiteralControl("<img id='i_" + i + "' align=\"absmiddle\" src=\"/Common/Images/default/16/folder.gif\" />"));
							listTts.Controls.Add(new LiteralControl("&nbsp<span onselectstart='return false;' onmouseleave=\"this.style.textDecoration='none'\" onmousemove=\"this.style.textDecoration='underline'\" class=mi >"+sGroup+"</span>"));
							listTts.Controls.Add(new LiteralControl("</DIV>"));
							if(i == 0)
								listTts.Controls.Add(new LiteralControl("<DIV id='o_"+i+"' class=mn>"));
							else 
								listTts.Controls.Add(new LiteralControl("<DIV id='o_"+i+"' class=mo>"));
						}
						j++;
						listTts.Controls.Add(new LiteralControl("<DIV>"));	
						listTts.Controls.Add(new LiteralControl("<LI>"));
                        listTts.Controls.Add(new LiteralControl("&nbsp<span onselectstart='return false;' onmouseleave=\"this.style.textDecoration='none'\" onmousemove=\"this.style.textDecoration='underline'\" onclick=\"go('" + sTT + "'," + i + ")\" class=ms>"));
						if("RO"==rdr.GetOracleString(3).Value )
                            listTts.Controls.Add(new LiteralControl("<img align=\"absmiddle\" src=\"/Common/Images/default/16/form_green.png\" title=\"Операція по плану\" />&nbsp"));
                        else
                            listTts.Controls.Add(new LiteralControl("<img align=\"absmiddle\" src=\"/Common/Images/default/16/form_blue.png\" title=\"Операція по факту\" />&nbsp"));
						listTts.Controls.Add(new LiteralControl(sName+"</span>"));
						listTts.Controls.Add(new LiteralControl("</DIV>"));	
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
			//this.Load += new EventHandler(this.Page_Load);

		}
		#endregion
	}
}
