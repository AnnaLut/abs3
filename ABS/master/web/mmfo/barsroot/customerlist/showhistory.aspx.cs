using System;
using System.Collections;
using Bars;
using System.Data;
using System.Globalization;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Collections.Generic;

namespace CustomerList
{
	/// <summary>
	/// Веб-страница показывает историю счета аналогично комплексу Барс
	/// </summary>
	/// 
	public partial class ShowHistory : BarsPage
	{
		/// <summary>
		/// Роль приложения
		/// </summary>
		private string role = "";
		/// <summary>
		/// параметр страницы acc 
		/// </summary>
		private decimal acc;	
		/// <summary>
		/// перменные для передачи переода на страничку выписки по счету
		/// </summary>
		private string E, S;

        public RegisterCountsDPARepository rep = new RegisterCountsDPARepository();

        private string[] SessionDataDateArr
        {
            get
            {
                return (Session["ShowHistory"] != null) ? (string[])Session["ShowHistory"] : new string[] { "", "", "", "" };
            }
        }

        /// <summary>
        /// Проверяет коректность переданых параметров
        /// </summary>
        private void CheckPageParams()
		{
			//-- тип просмотра
			if(Request.Params.Get("type") != null)
			{
				string type = Request.Params.Get("type");
				switch (type)
				{
					case "0" : role = "wr_custlist";
						break;
					case "1" : role = "WR_USER_ACCOUNTS_LIST";
						break;
					case "2" : role = "WR_TOBO_ACCOUNTS_LIST";
						break;
					case "3" : role = "WR_ND_ACCOUNTS";
						break;
					case "4" : role = "WR_DEPOSIT_U";
						break;
                    case "5" : role = "WR_USER_ACCOUNTS_LIST";
                        break;
					default : break;
				}
			}
			else throw new Exception("Не задан параметр type!");				
			
			//-- acc счета для просмотра
			if(Request.Params.Get("acc") != null)
			{
				acc = Convert.ToDecimal(Request.Params.Get("acc"));
			}
			else throw new Exception("Не задан параметр acc!");				
		}
		/// <summary>
		/// инициализация переменных E и S
		/// </summary>
		private void GetDates()
		{
			try
			{   
				InitOraConnection(Context);
				
				SetRole("basic_info");
				hPrintFlag.Value = Convert.ToString(SQL_SELECT_scalar("select val from params where par='W_PRNVP'"));
 
				SetRole(role);

				ArrayList reader = SQL_reader("SELECT to_char(min(fdat),'dd.MM.yyyy'), to_char(bankdate,'dd.MM.yyyy') FROM fdat WHERE fdat < bankdate and fdat >= add_months(bankdate,-1)");
				if(reader.Count != 0)
				{
					S = Convert.ToString(reader[0]);
					E = Convert.ToString(reader[1]);
				}

                if (S.Trim() == "")
                {
                    System.Globalization.DateTimeFormatInfo dtf = new System.Globalization.DateTimeFormatInfo();
                    dtf.ShortDatePattern = "dd.MM.yyyy";
                    dtf.DateSeparator = ".";

                    S = Convert.ToDateTime(E, dtf).AddMonths(-1).ToString("dd.MM.yyyy", dtf);
                }
			}
			finally
			{
				DisposeOraConnection();
			}			
		}
		
		private void Page_Load(object sender, EventArgs e)
		{
            if (!IsPostBack)
            {
                // параметры страницы
                CheckPageParams();
                // даты
                GetDates();

                ed_strDt_TextBox.Text = S;
                ed_endDt_TextBox.Text = E;

                GetDataSumm(S, E, acc);
            }
        }


        private void GetDataSumm(string dat1_, string dat2_, decimal acc)
        {
            InitOraConnection(Context);
            DataTable result = new DataTable();

            try
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
                cinfo.DateTimeFormat.DateSeparator = ".";

                DateTime dat1 = Convert.ToDateTime(dat1_.Trim(), cinfo);
                DateTime dat2 = Convert.ToDateTime(dat2_.Trim(), cinfo);
                //long acc = Convert.ToInt64(data[10].Trim(), cinfo);

                string sql = @" 
            select CH_FDAT
, CH_OSTF/100 CH_OSTF
, ch_dos/100 ch_dos
, ch_kos/100 ch_kos
, IX/100 IX
  from  (select
            0 acc,
            0 dig,
            'Загалом         :' ch_fdat,
                   fost(:acc, :dat1-1) ch_ostf, fdos ( :acc, :dat1, :dat2) ch_dos, fkos(:acc, :dat1, :dat2) ch_kos,     
                   fost(:acc, :dat2) ix from dual
            union all
            select 
            0 acc,
            0 dig,
            'Ср.банк/' || count(*) ||'     :' pr,
                   round(sum(fost(:acc, f.fdat-1) )/count(*) ,0) vx,
                   round(fdos(:acc,:dat1,:dat2) /count(*),0) dos,   
                   round(fkos(:acc, :dat1, :dat2)/count(*),0) kos ,
                   round(sum(fost(:acc, f.fdat) ) /count(*),0) ix
            from  fdat f
            where fdat >= :dat1 and fdat <=:dat2
            having COUNT (*) > 0
            union all
            select 
            0 acc,
            0 dig,
             'Ср.календ/.' || count(*)||':'  pr ,
                   round(sum(fost(:acc, f.fdat-1) )/count(*) ,0) vx,
                   round(fdos(:acc,:dat1,:dat2) /count(*),0) dos,  
                   round(fkos(:acc, :dat1, :dat2)/count(*),0) kos,
                   round(sum(fost(:acc, f.fdat) ) /count(*),0) ix     
            from (select TO_DATE(:dat1) + (num - 1) FDAT from conductor where TO_DATE(:dat1) + (num - 1) <= :dat2 ) f ) ddd";

                ClearParameters();

                SetParameters("acc", DB_TYPE.Int64, acc, DIRECTION.Input);
                SetParameters("dat1", DB_TYPE.Date, dat1, DIRECTION.Input);
                SetParameters("acc", DB_TYPE.Int64, acc, DIRECTION.Input);
                SetParameters("dat1", DB_TYPE.Date, dat1, DIRECTION.Input);
                SetParameters("dat2", DB_TYPE.Date, dat2, DIRECTION.Input);
                SetParameters("acc", DB_TYPE.Int64, acc, DIRECTION.Input);
                SetParameters("dat1", DB_TYPE.Date, dat1, DIRECTION.Input);
                SetParameters("dat2", DB_TYPE.Date, dat2, DIRECTION.Input);

                SetParameters("acc", DB_TYPE.Int64, acc, DIRECTION.Input);
                SetParameters("dat2", DB_TYPE.Date, dat2, DIRECTION.Input);

                SetParameters("acc", DB_TYPE.Int64, acc, DIRECTION.Input);

                SetParameters("acc", DB_TYPE.Int64, acc, DIRECTION.Input);
                SetParameters("dat1", DB_TYPE.Date, dat1, DIRECTION.Input);
                SetParameters("dat2", DB_TYPE.Date, dat2, DIRECTION.Input);

                SetParameters("acc", DB_TYPE.Int64, acc, DIRECTION.Input);
                SetParameters("dat1", DB_TYPE.Date, dat1, DIRECTION.Input);
                SetParameters("dat2", DB_TYPE.Date, dat2, DIRECTION.Input);

                SetParameters("acc", DB_TYPE.Int64, acc, DIRECTION.Input);

                SetParameters("dat1", DB_TYPE.Date, dat1, DIRECTION.Input);
                SetParameters("dat2", DB_TYPE.Date, dat2, DIRECTION.Input);

                SetParameters("acc", DB_TYPE.Int64, acc, DIRECTION.Input);

                SetParameters("acc", DB_TYPE.Int64, acc, DIRECTION.Input);
                SetParameters("dat1", DB_TYPE.Date, dat1, DIRECTION.Input);
                SetParameters("dat2", DB_TYPE.Date, dat2, DIRECTION.Input);

                SetParameters("acc", DB_TYPE.Int64, acc, DIRECTION.Input);
                SetParameters("dat1", DB_TYPE.Date, dat1, DIRECTION.Input);
                SetParameters("dat2", DB_TYPE.Date, dat2, DIRECTION.Input);

                SetParameters("acc", DB_TYPE.Int64, acc, DIRECTION.Input);

                SetParameters("dat1", DB_TYPE.Date, dat1, DIRECTION.Input);
                SetParameters("dat1", DB_TYPE.Date, dat1, DIRECTION.Input);
                SetParameters("dat2", DB_TYPE.Date, dat2, DIRECTION.Input);

                var ds = SQL_SELECT_dataset(sql);

                gvTable.DataSource = ds.Tables[0];
                gvTable.DataBind();
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        private void BindGrid()
        {
            // параметры страницы
            CheckPageParams();

            S = Request.Form[ed_strDt_TextBox.UniqueID];
            E = Request.Form[ed_endDt_TextBox.UniqueID];

            GetDataSumm(S, E, acc);
        }

        protected void btnExcel_Click(object sender, EventArgs e)
        {
            ExportToExcel();
        }

        protected void ExportToExcel()
        {
            DataTable table2 = new DataTable();
            ///Створюємо шапку
            var userInf = rep.GetPrintHeader();
            List<string> hat = new List<string>
                {
                    "АТ 'ОЩАДБАНК'",
                    "Користувач: " + userInf.USER_NAME,
                    "Дата: " + userInf.DATE.ToString("dd'.'MM'.'yyyy") + " Час: " + userInf.DATE.Hour + ":" + userInf.DATE.Minute + ":" + userInf.DATE.Second
                };

            ///Дістаємо дані верхнього гріда. 
            StringReader theReader = new StringReader(SessionDataDateArr[0].ToString());
            DataSet theDataSet = new DataSet();
            theDataSet.ReadXml(theReader);

            if (theDataSet.Tables.Count > 0)
            {
                //ACC DIG CH_FDAT CH_OSTF CH_DOS CH_KOS  CH_OST RNUM
                DataView view = new DataView(theDataSet.Tables[0]);
                table2 = view.ToTable(true, "CH_FDAT", "CH_OSTF", "CH_DOS", "CH_KOS", "CH_OST");

                foreach (DataRow row in table2.Rows)
                {
                    foreach (DataColumn col in table2.Columns)
                    {
                        if (row[col] != row["CH_FDAT"])
                        {
                            row[col] = (Convert.ToDecimal(row[col]) / 100).ToString();
                        }
                    }
                }
            }
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=CustHistory.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                { 
                    //Експортуємо всі сторінки
                    gvTable.AllowPaging = false;
                    this.BindGrid();

                    gvTable.HeaderRow.BackColor = Color.White;
                    foreach (TableCell cell in gvTable.HeaderRow.Cells)
                    {
                        cell.BackColor = gvTable.HeaderStyle.BackColor;
                    }
                    foreach (GridViewRow row in gvTable.Rows)
                    {
                        row.BackColor = Color.White;
                        foreach (TableCell cell in row.Cells)
                        {
                            if (row.RowIndex % 2 == 0)
                            {
                                cell.BackColor = gvTable.AlternatingRowStyle.BackColor;
                            }
                            else
                            {
                                cell.BackColor = gvTable.RowStyle.BackColor;
                            }
                            //cell.CssClass = "textmode";
                        }
                    }

                    //string style = @"<style> .textmode { } </style>";

                    string style = @"<style> td { mso-number-format:'### ### ### ### ### ##0.00'; } </style> ";

                    Response.Output.Write(style);
                    Response.Output.Write(string.Join("<br>", hat));
                    Response.Output.Write("<br>");
                    Response.Output.Write(SessionDataDateArr[2].ToString()); ;
                    Response.Output.Write("<br>");

                    gvTable.RenderControl(hw);
                    Response.Output.Write(sw.ToString());

                    ///Створюємо віртуальний грід

                    if (table2.Rows.Count > 0)
                    {
                        GridView excel = new GridView();
                        excel.AutoGenerateColumns = false;
                        for (int i = 0; i < table2.Columns.Count; i++)
                        {
                            BoundField boundfield = new BoundField();
                            string ht = table2.Columns[i].ColumnName.ToString();
                            string df = table2.Columns[i].DefaultValue.ToString();
                            boundfield.HeaderText = (ht == "CH_FDAT") ? "Дата руху" : "";
                            boundfield.DataField = ht;
                            excel.Columns.Add(boundfield);
                        }
                        excel.DataSource = table2;
                        excel.DataBind();
                        excel.RenderControl(new HtmlTextWriter(Response.Output));
                    }
                    Response.Flush();
                    Response.End();
                }
            }
        }

        protected void btnAcceptDates_Click(object sender, EventArgs e)
        {
            BindGrid();
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
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
			this.Load += new System.EventHandler(this.Page_Load);

		}
        #endregion
    }
}
