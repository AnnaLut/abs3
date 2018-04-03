using System;
using System.Collections;
using System.Data;
using System.Web.UI.WebControls;

namespace Bars.WebServices
{
	/// <summary>
	/// Summary description for Filter.
	/// </summary>
	public partial class Filter : BarsPage
	{
	
		public struct Tag
		{
			public string sQCol;
			public string sQTab;
			public string sName;
			public string sType;
			public string sSTabName;
			public string sSColName;
			public string sSSemantic;
			public string sHColName;
			public string sRTabAlias;
			public string sRColName;
            public string sCaseSensitive;
		}	

		private Hashtable tags;
		private string tabid;
		private int nTagNum = 0;
	
		
		public bool InitFilter(string sTableName)
		{
            sTableName = sTableName.ToUpper();
            
			if(Application[sTableName+"_filter"] != null)
			{
                tags = (Hashtable)Application[sTableName + "_filter"];
                tabid = (string)Application[sTableName + "_tabid"];
				nTagNum = tags.Count;
				return true;
			}
			try
			{
				InitOraConnection();
				SetRole("wr_filter");
				SetParameters("tbl",DB_TYPE.Varchar2,sTableName,DIRECTION.Input);
				tabid = Convert.ToString(SQL_SELECT_scalar("SELECT tabid FROM meta_tables WHERE tabname=:tbl"));
				if(tabid == null) return false;
				ClearParameters();
				SetParameters("tabid",DB_TYPE.Decimal,tabid,DIRECTION.Input);
				tags = new Hashtable();
				SQL_Reader_Exec(@"SELECT c.colid, c.colname, c.semantic, c.coltype, c.extrnval, c.showpos, nvl(c.case_sensitive,0)
								  FROM meta_columns c 
								  WHERE c.tabid=:tabid AND c.showin_fltr=1
								  ORDER BY 6");
				while(SQL_Reader_Read())
				{
					ArrayList list = SQL_Reader_GetValues();
					if(list[4].ToString() != "1")
                        NewTag(list[1].ToString(), sTableName, list[2].ToString(), list[3].ToString(), list[6].ToString());
					else
					{
						ClearParameters();
						SetParameters("tabid",DB_TYPE.Decimal,tabid,DIRECTION.Input);
						SetParameters("colid",DB_TYPE.Decimal,list[0],DIRECTION.Input);
						ArrayList data = SQL_reader(@"SELECT c.colname, t.tabname, s.colname 
													  FROM meta_extrnval e, meta_columns c, meta_columns s,	meta_tables t
													  WHERE e.srctabid=t.tabid AND e.srccolid=c.colid AND e.srctabid=c.tabid AND
														    e.srctabid=s.tabid AND s.instnssemantic=1 AND
														    e.tabid=:tabid   AND e.colid=:colid");
                        NewTagFK(list[1].ToString(), list[2].ToString(), list[3].ToString(), data[1].ToString(), data[0].ToString(), data[2].ToString(), sTableName, list[6].ToString());
					}

				}
				SQL_Reader_Close();

				ClearParameters();
				SetParameters("tabid",DB_TYPE.Decimal,tabid,DIRECTION.Input);
                SQL_Reader_Exec(@"SELECT var_colid, av.colname, cond_tag, av.coltype, av.extrnval, ta.tabname, ta.tabid, addtabalias, hc.colname, ac.colname, nvl(ac.case_sensitive,0)
							      FROM meta_browsetbl, meta_tables ta, meta_columns hc, meta_columns ac, meta_columns av
								  WHERE ta.tabid = addtabid  AND  
										hc.tabid = hosttabid AND hc.colid = hostcolkeyid AND
										ac.tabid = addtabid  AND ac.colid = addcolkeyid  AND
										av.tabid = addtabid  AND av.colid = var_colid    AND
										addtabid IS NOT NULL AND hosttabid = :tabid");
				while(SQL_Reader_Read())
				{
					ArrayList list = SQL_Reader_GetValues();
					if(list[4].ToString() != "1")
                        NewTagAttach(list[1].ToString(), list[2].ToString(), list[3].ToString(), list[5].ToString(), list[7].ToString(), list[8].ToString(), list[9].ToString(), list[10].ToString());
					else
					{
						ClearParameters();
						SetParameters("tabid",DB_TYPE.Decimal,tabid,DIRECTION.Input);
						SetParameters("colid",DB_TYPE.Decimal,list[0],DIRECTION.Input);
						ArrayList data = SQL_reader(@"SELECT c.colname, t.tabname, s.colname 
													  FROM meta_extrnval e, meta_columns c, meta_columns s,meta_tables t
													  WHERE e.srctabid=t.tabid AND e.srccolid=c.colid AND e.srctabid=c.tabid AND 
															e.srctabid=s.tabid AND s.instnssemantic=1 AND
															e.tabid=:tabid AND e.colid=:colid");
						if(data.Count != 0)
							NewTagAttachFK(list[1].ToString(),list[2].ToString(),list[3].ToString(),list[5].ToString(),list[7].ToString(),list[8].ToString(),list[9].ToString(),data[1].ToString(),data[0].ToString(),data[2].ToString(),list[10].ToString());
					}

				}
				SQL_Reader_Close();

                Application[sTableName + "_filter"] = tags;
                Application[sTableName + "_tabid"] = tabid;

				return true;
			}
			finally
			{
				DisposeOraConnection();
			}
		}
		private void NewTag(string sQCol,string sQTab,string sName,string sType, string case_sensitive)
		{
			Tag tag = new Tag();
			tag.sQCol = sQCol;
			tag.sQTab = sQTab;
			tag.sName = sName.Replace("~"," ");
			tag.sType = sType;
            tag.sCaseSensitive = case_sensitive;
			tags.Add(nTagNum,tag);
			nTagNum++;
		}
		private void NewTagFK(string sQCol,string sName,string sType,string sATab,string sACol,string sSCol,string sFTabName,string case_sensitive)
		{
			Tag tag = new Tag();
			tag.sSTabName = sATab.ToUpper();
			tag.sSColName = sACol.ToUpper();
			tag.sSSemantic = sSCol.ToUpper();
			tag.sQCol = sQCol;
			tag.sQTab = sFTabName;
			tag.sName = sName.Replace("~"," ");
			tag.sType = sType;
            tag.sCaseSensitive = case_sensitive;
			tags.Add(nTagNum,tag);
			nTagNum++;
		}
		private void NewTagAttach(string sQCol,string sName,string sType,string sATab,string sATabA,string sHCol,string sACol, string case_sensitive)
		{
			Tag tag = new Tag();
			tag.sHColName = sHCol.ToUpper();
			tag.sRTabAlias = sATabA;
			tag.sRColName = sACol.ToUpper();
			tag.sQCol = sQCol;
			tag.sQTab = sATab;
			tag.sName = sName.Replace("~"," ");
			tag.sType = sType;
            tag.sCaseSensitive = case_sensitive;
			tags.Add(nTagNum,tag);
			nTagNum++;
		}
        private void NewTagAttachFK(string sQCol, string sName, string sType, string sATab, string sATabA, string sHCol, string sACol, string sSTab, string sSKey, string sSCol, string case_sensitive)
		{
			Tag tag = new Tag();
			tag.sHColName = sHCol.ToUpper();
			tag.sRTabAlias = sATabA;
			tag.sRColName = sACol.ToUpper();
			
			tag.sSTabName = sSTab;
			tag.sSColName = sSKey;
			tag.sSSemantic = sSCol;

			tag.sQCol = sQCol;
			tag.sQTab = sATab;
			tag.sName = sName.Replace("~"," ");
			tag.sType = sType;
            tag.sCaseSensitive = case_sensitive;
			tags.Add(nTagNum,tag);
			nTagNum++;
		}

		private void Page_Load(object sender, EventArgs e)
		{
			if(!IsPostBack)
			{
				try
				{
                    string message1 = Resources.webservices.GlobalResources.dontUseSysFilter;
                    string message2 = Resources.webservices.GlobalResources.dontUseUserFilter;
                    string table = Request.Params.Get("table").ToUpper();
					if(table == null)
						throw new ApplicationException("Не задано имя таблицы");
					InitFilter(table);
                    bool isTags = false;
                    for (int i = 0; i < tags.Count; i++)
                    {
                        if (tags[i] is Tag)
                        {
                            Tag tag = ((Tag)tags[i]);

                            ListItem item = new ListItem();
                            if (tag.sHColName != null)
                                item.Value = tag.sQCol + ";" + tag.sCaseSensitive + ";" + tag.sType + ";" + tag.sQTab + ";" + tag.sHColName + ";" + tag.sRColName;
                            else
                                item.Value = tag.sQCol + ";" + tag.sCaseSensitive + ";" + tag.sType;
                            item.Text = tag.sName;
                            attr.Items.Add(item);
                            isTags = true;
                        }
                    }
                    if (!isTags && tags.Count > 0)
                    {
                        Application.Remove(table + "_filter");
                        Response.Redirect(Request.Url.AbsoluteUri);
                        return;
                    }
                    
					attr.Items.Add(new ListItem());
					attr.SelectedIndex = -1;
					InitOraConnection(Context);
					SetRole("wr_filter");

					SetParameters("tabid",DB_TYPE.Decimal,tabid,DIRECTION.Input);
					DataSet ds = SQL_SELECT_dataset(@"SELECT filter_id id, semantic name FROM dyn_filter
							     WHERE tabid = :tabid AND userid IS NULL 
								 ORDER BY semantic");
					DataRow row = ds.Tables[0].NewRow();
					row[0] = -1;
                    row[1] = message1;// "Не использовать системный фильтр";
					ds.Tables[0].Rows.InsertAt(row,0);
					dgSys.DataSource = ds;
					dgSys.DataBind();

					ds = SQL_SELECT_dataset(@"SELECT filter_id id, semantic name,where_clause FROM dyn_filter
							     WHERE tabid = :tabid AND userid = user_id
								 ORDER BY semantic");
					row = ds.Tables[0].NewRow();
					row[0] = -1;
                    row[1] = message2;//"Не использовать пользовательский фильтр";
					ds.Tables[0].Rows.InsertAt(row,0);
					dgUser.DataSource = ds;

					dgUser.DataBind();
					
					TID.Value = tabid;
				}
				finally
				{
					DisposeOraConnection();
				}
			}
		}

        /// <summary>
        /// Локализация DataGrid
        /// </summary>
        protected override void OnPreRender(EventArgs evt)
        {
            // Локализируем грид
            if (dgSys.Controls.Count > 0)
            {
                Table tb =  dgSys.Controls[0] as Table;
                tb.Rows[0].Cells[0].Text = Resources.webservices.GlobalResources.tb1;
                tb.Rows[0].Cells[1].Text = Resources.webservices.GlobalResources.tb2;
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
			this.dgSys.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.dgSys_ItemDataBound);
			this.dgUser.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.dgUser_ItemDataBound);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void dgSys_ItemDataBound(object sender, DataGridItemEventArgs e)
		{
			if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				DataGridItem row = e.Item;
				if(sysIs.Value != "1" && row.Cells[0].Text != "-1") sysIs.Value = "1";
				if(row.Cells[0].Text == "-1"){
					row.Style.Add("color","red");
					row.Style.Add("font-weight","bold");
					row.Cells[0].Text = "*";
				}
				string row_id = "y_" + row.Cells[0].Text;
				row.Attributes.Add("id", row_id);
				row.Style.Add("cursor","hand");
				row.Attributes.Add("onclick", "Sel_Sys('"+row.Cells[0].Text+"')");
				row.Attributes.Add("ondblclick", "Apl_Sys('"+row.Cells[0].Text+"')");
			}
		}

		private void dgUser_ItemDataBound(object sender, DataGridItemEventArgs e)
		{
			if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				DataGridItem row = e.Item;
				if(usrIs.Value != "1" && row.Cells[0].Text != "-1") usrIs.Value = "1";
				if(row.Cells[0].Text == "-1")
				{
					row.Style.Add("color","red");
					row.Style.Add("font-weight","bold");
					row.Cells[0].Text = "*";
				}
				string row_id = "u_" + row.Cells[0].Text;
				row.Attributes.Add("id", row_id);
				row.Style.Add("cursor","hand");
				row.Attributes.Add("onclick", "Sel_Usr('"+row.Cells[0].Text+"')");
				row.Attributes.Add("ondblclick", "Apl_Usr('"+row.Cells[0].Text+"')");
				row.Attributes.Add("cw",row.Cells[2].Text);
			}
		}
        protected void btnRefresh_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            string table = Request.Params.Get("table").ToUpper();
            Application.Remove(table + "_filter");
            InitFilter(table);
            Response.Redirect(Request.Url.AbsoluteUri);
        }
}
}
