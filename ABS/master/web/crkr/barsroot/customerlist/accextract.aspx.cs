using System;
using System.Data;
using System.IO;
using System.Collections;
using System.Globalization;
using System.Resources;
using System.Threading;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Bars;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace CustomerList
{
    /// <summary>
    /// веб-страница моделирует выписку по счету аналогично 
    /// комплексу Барс
    /// получает параметрами acc счета и дату date
    /// </summary>
    public partial class AccExtract : BarsPage
    {
        /// <summary>
        /// параметры страницы acc и date
        /// </summary>
        private decimal AccParam;
        private DateTime date;
        private string NLS = "";
        private string role = "";

        protected override void OnPreRender(EventArgs evt)
        {
            // Локализируем грид
            if (gridAccExtract.Controls[0] != null)
            {
                Table tb = gridAccExtract.Controls[0] as Table;
                tb.Rows[0].Cells[0].Text = Resources.customerlist.GlobalResources.tb1;
                tb.Rows[0].Cells[2].Text = Resources.customerlist.GlobalResources.tb2;
                tb.Rows[0].Cells[3].Text = Resources.customerlist.GlobalResources.tb3;
                tb.Rows[0].Cells[4].Text = Resources.customerlist.GlobalResources.tb4;
                tb.Rows[0].Cells[5].Text = Resources.customerlist.GlobalResources.tb5;
                tb.Rows[0].Cells[6].Text = Resources.customerlist.GlobalResources.tb6;
            }
        }


        /// <summary>
        /// создаем tooltip и заголовок для toolbar в котором указаны 
        /// номер счета и дата
        /// </summary>

        //Процедуры для кнопок наToolBar'е
        private void ShowTitle()
        {
            InitOraConnection(Context);
            try
            {
                SetRole("basic_info");
                hPrintFlag.Value = Convert.ToString(SQL_SELECT_scalar("select val from params where par='W_PRNVP'"));

                SetRole(role);

                SetParameters("pacс", DB_TYPE.Decimal, AccParam, DIRECTION.Input);
                object res = this.SQL_SELECT_scalar("select NLS from SALDO where ACC = :pacc");

                if (res != null)
                {
                    NLS = (string)res;
                }
                else NLS = "Нет данных";
            }
            finally
            {
                DisposeOraConnection();
            }

            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
            cinfo.DateTimeFormat.DateSeparator = ".";

            TitleNLS.InnerText = NLS + " ";
            TitleDate.InnerText = date.ToString("dd.MM.yyyy");
        }
        /// <summary>
        /// инициализация параметров, в случве их некоректности 
        /// acc = 0 и date = сегодня
        /// </summary>
        private void FirstGetParams()
        {
            try
            {
                AccParam = decimal.Parse(Request.Params.Get("acc"));
            }
            catch
            {
                AccParam = 0;
            }

            try
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
                cinfo.DateTimeFormat.DateSeparator = ".";

                date = DateTime.Parse(Request.Params.Get("date"), cinfo);
            }
            catch
            {
                date = DateTime.Now;
            }
        }
        /// <summary>
        /// показываем заголовок грида
        /// (cxbnadftv данные и раскрашиваем их)
        /// </summary>
        private void InsertGridHeader()
        {
            String SumFormat = "### ### ### ### ##0.";

            decimal INPOST = 0;
            decimal DOS = 0;
            decimal KOS = 0;
            decimal OST = 0;

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_acc", OracleDbType.Decimal, AccParam, ParameterDirection.Input);
                cmd.CommandText = @"select t.dig
                                      from tabval t
                                     where t.kv = (select ac.kv from accounts ac where ac.acc = :p_acc)";
                Int16 Dig = Convert.ToInt16(cmd.ExecuteScalar());
                SumFormat += "0".PadRight(Dig, '0');

                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_dig", OracleDbType.Int16, Dig, ParameterDirection.Input);
                cmd.Parameters.Add("p_acc", OracleDbType.Decimal, AccParam, ParameterDirection.Input);
                cmd.Parameters.Add("p_date", OracleDbType.Date, date, ParameterDirection.Input);
                cmd.CommandText = @"select s.ostf / t.dig as inpost,
                                           s.dos / t.dig as dos,
                                           s.kos / t.dig as kos,
                                           (s.ostf + s.kos - s.dos) / t.dig as ost
                                      from saldoa s, (select power(10, :p_dig) as dig from dual) t
                                     where s.acc = :p_acc
                                       and s.fdat = :p_date";

                using (OracleDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        INPOST = Convert.ToDecimal(rdr["inpost"]);
                        DOS = Convert.ToDecimal(rdr["dos"]);
                        KOS = Convert.ToDecimal(rdr["kos"]);
                        OST = Convert.ToDecimal(rdr["ost"]);
                    }
                    rdr.Close();
                }
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            //Подставляем данные в Label'ы и раскрашиваем их
            lbVhodDat.InnerText = date.ToString("dd.MM.yyyy");
            lbIshodDat.InnerText = date.ToString("dd.MM.yyyy");
            if (INPOST <= 0)
            {
                lbVhodDeb.Visible = true;
                lbVhodKred.Visible = false;
                lbVhodDeb.InnerText = Math.Abs(INPOST).ToString(SumFormat);
                lbVhodDeb.Style.Add("Color", "Red");
                lbVhodSald.Style.Add("Color", "Red");
                lbVhodDat.Style.Add("Color", "Red");
            }
            else
            {
                lbVhodDeb.Visible = false;
                lbVhodKred.Visible = true;
                lbVhodKred.InnerText = INPOST.ToString(SumFormat);
                lbVhodKred.Style.Add("Color", "DarkBlue");
                lbVhodSald.Style.Add("Color", "DarkBlue");
                lbVhodDat.Style.Add("Color", "DarkBlue");
            }
            lbSumDeb.InnerText = DOS.ToString(SumFormat);
            lbSumKred.InnerText = KOS.ToString(SumFormat);
            if (OST < 0)
            {
                lbIshodDeb.Visible = true;
                lbIshodKred.Visible = false;
                lbIshodDeb.InnerText = Math.Abs(OST).ToString(SumFormat);
                lbIshodDeb.Style.Add("Color", "Red");
                lbIshodSald.Style.Add("Color", "Red");
                lbIshodDat.Style.Add("Color", "Red");
            }
            else
            {
                lbIshodDeb.Visible = false;
                lbIshodKred.Visible = true;
                lbIshodKred.InnerText = OST.ToString(SumFormat);
                lbIshodKred.Style.Add("Color", "DarkBlue");
                lbIshodSald.Style.Add("Color", "DarkBlue");
                lbIshodDat.Style.Add("Color", "DarkBlue");
            }

        }
        /// <summary>
        /// раскрашиваем рядки грида в зависимосте от их SOS
        /// </summary>
        private void GridAppearance()
        {
            int RowCount = gridAccExtract.Items.Count;

            for (int i = 0; i < RowCount; i++)
            {
                int ColIndx = 7;
                double temp = double.Parse(gridAccExtract.Items[i].Cells[ColIndx].Text);

                if (temp >= 5) gridAccExtract.Items[i].Style.Add("Color", "Black");
                else if (temp == 3) gridAccExtract.Items[i].Style.Add("Color", "Blue");
                else if (temp == 2) gridAccExtract.Items[i].Style.Add("Color", "Purple");
                else if (temp == 1) gridAccExtract.Items[i].Style.Add("Color", "Green");
                else if (temp < 0) gridAccExtract.Items[i].Style.Add("Color", "Red");
            }
        }
        private void FirstInitGridAccExtract(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            String SumFormat = "### ### ### ### ##0.";

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_acc", OracleDbType.Decimal, AccParam, ParameterDirection.Input);
                cmd.CommandText = @"select t.dig
                                      from tabval t
                                     where t.kv = (select ac.kv from accounts ac where ac.acc = :p_acc)";
                Int16 Dig = Convert.ToInt16(cmd.ExecuteScalar());
                SumFormat += "0".PadRight(Dig, '0');

                // форматируем количество знаков после запятой
                ((BoundColumn)gridAccExtract.Columns[3]).DataFormatString = "{0:" + SumFormat + "}";
                ((BoundColumn)gridAccExtract.Columns[4]).DataFormatString = "{0:" + SumFormat + "}";

                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_dig", OracleDbType.Int16, Dig, ParameterDirection.Input);
                cmd.Parameters.Add("p_acc", OracleDbType.Decimal, AccParam, ParameterDirection.Input);
                cmd.Parameters.Add("p_date", OracleDbType.Date, date, ParameterDirection.Input);
                cmd.CommandText = @"select o.sos,
                                        o.tt," + 
				 	"'<a title=\"" + Resources.customerlist.GlobalResources.docKart + "\" href=\"/barsroot/documentview/default.aspx?ref='|| o.REF ||'\">'|| o.REF ||'<a>' as REF, " +
                                        @"decode(o.dk, 0, o.s / d.dig, 0) as dos,
                                        decode(o.dk, 1, o.s / d.dig, 0) as kos,
                                        decode(o.tt, p.tt, p.nazn, t.name) as comm,
                                        to_char(p.pdat, 'dd.mm.yyyy hh24:mi:ss') as pdat,
                                        p.nam_b,
                                        p.nd
                                    from opldok o,
                                        oper p,
                                        tts t,
                                        (select power(10, :p_dig) as dig from dual) d
                                    where o.ref = p.ref
                                    and o.acc = :p_acc
                                    and t.tt = o.tt
                                    and o.fdat = :p_date
                                    order by fdat desc, o.dk, o.s";

                using (OracleDataAdapter adp = new OracleDataAdapter(cmd))
                {
                    Int32 Result = adp.Fill(dt);
                }
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            //Наполняем грид
            gridAccExtract.DataSource = dt;
            gridAccExtract.DataBind();
            //Прячем колонку SOS
            //gridAccExtract.Columns[0].Visible = false;
        }

        private void InitPrintScript()
        {
            Page.RegisterStartupScript("reports", @"<script language=javascript>
													function printExtract(format)
													{
													  window.open('/barsroot/crystalreports/default.aspx?template=0&format='+format+'&nls=" + NLS + @"&dateB=" + date.ToString("dd.MM.yyyy") + @"&dateE=" + date.ToString("dd.MM.yyyy") + @"',null,'height='+(window.screen.height-200)+',width='+(window.screen.width-10)+',left=0,top=0');
													}
											       </script>");
        }

        private void Page_Load(object sender, EventArgs e)
        {
            string type = Convert.ToString(Request.Params.Get("type"));
            if (type == "0")
            {
                role = "wr_custlist";
            }
            else if (type == "1")
            {
                role = "WR_USER_ACCOUNTS_LIST";
            }
            else if (type == "2")
            {
                role = "WR_TOBO_ACCOUNTS_LIST";
            }
            else if (type == "3")
            {
                role = "WR_ND_ACCOUNTS";
            }
            else if (type == "4")
            {
                role = "WR_DEPOSIT_U";
            }
            FirstGetParams();
            if (!IsPostBack)
            {
                ShowTitle();
                FirstInitGridAccExtract(sender, e);
                InsertGridHeader();
                GridAppearance();
                InitPrintScript();
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
            this.Load += new System.EventHandler(this.Page_Load);
        }
        #endregion

    }
}
