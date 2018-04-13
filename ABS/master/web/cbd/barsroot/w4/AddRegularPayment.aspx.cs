using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Logger;
using Bars.Oracle;
using FastReport.Cloud;
using Oracle.DataAccess.Client;

public partial class w4_AddRegularPayment : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HttpContext.Current.Request.HttpMethod == HttpMethod.Post)
        {
            SavePayment();
        }

        if (!IsPostBack)
        {
            var rnk = HttpContext.Current.Request.Params.GetValues("RNK");
            var nmk = HttpContext.Current.Request.Params.GetValues("NMK");
            var nlsa = HttpContext.Current.Request.Params.GetValues("NLS");
            var typeParam = HttpContext.Current.Request.Params.GetValues("type");

            if (typeParam != null && Convert.ToString(typeParam.GetValue(0)).ToUpper() == "PRINT")
            {
                if (rnk != null)
                {
                    var rnkPar = Convert.ToDecimal(rnk.GetValue(0));
                    var iddParam = HttpContext.Current.Request.Params.GetValues("idd");
                    decimal idd = Convert.ToDecimal(iddParam.GetValue(0));
                    PrintPayment(rnkPar, idd);
                }
            }
            else
            {

                tbNlsA.Value = nlsa.GetValue(0).ToString();
                tbNmkA.Value = nmk.GetValue(0).ToString();

                IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
                OracleConnection connect = conn.GetUserConnection();

                InitPrior(Convert.ToDecimal(rnk.GetValue(0).ToString()), connect);
                InitPeriod(connect);

                StartDate.Value = String.Format("{0:dd/MM/yyyy}", DateTime.Today);
            }
        }
    }

    public string GetOurMfo(OracleConnection connect)
    {
        OracleCommand command = connect.CreateCommand();
        command.CommandText = @"SELECT val from params where par = 'MFO'";
        return Convert.ToString(command.ExecuteScalar());
    }
    public string GetCodVal(decimal rnk, OracleConnection connect)
    {
        OracleCommand command = connect.CreateCommand();
        command.CommandText = @"select 
                                    a.kv kv 
                                from accounts a 
                                where a.rnk = :p_rnk ";
        command.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
        return Convert.ToString(command.ExecuteScalar());
    }

    protected void InitFreq(OracleConnection connect)
    {
        //Freq.Items.Clear();
        // Регулярные платежи
        OracleCommand cmd = connect.CreateCommand();
        cmd.CommandText = "select * from BARS.FREQ where freq=2 order by FREQ";
        var reader = cmd.ExecuteReader();
        while (reader.Read())
        {
            /*Freq.Items.Add(new ListItem
            {
                Value = Convert.ToString(reader["FREQ"]),
                Text = "Згідно з графіком погашення кредиту"//Convert.ToString(reader["NAME"])
            });*/
        }
    }
    protected void InitPrior(decimal rnk, OracleConnection connect)
    {
        Prior.Items.Clear();
        OracleCommand cmd = connect.CreateCommand();
        cmd.CommandText = @"SELECT 
                                SD.ORD
                            FROM 
                                BARS.STO_LST SA, 
                                BARS.STO_DET SD, 
                                FREQ F
                            Where 
                                SD.IDS = SA.IDS 
                                and SA.RNK = :p_rnk 
                                and F.FREQ = SD.FREQ";
        cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);

        var reader2 = cmd.ExecuteReader();
        var listExist = new List<decimal>();

        while (reader2.Read())
        {
            listExist.Add(Convert.ToDecimal(reader2["ord"]));
        }
        decimal max = 0;
        if (listExist.Any())
        {
            max = listExist.AsEnumerable().Max();
        }

        for (decimal i = 1; i < max + 6; i++)
        {
            if (listExist.FirstOrDefault(item => item == i) == 0)
            {
                Prior.Items.Add(new ListItem
                {
                    Value = Convert.ToString(i),
                    Text = Convert.ToString(i)
                });
            }
        }
    }

    protected void InitPeriod(OracleConnection connect)
    {
        Period.Items.Clear();
        OracleCommand cmd = connect.CreateCommand();

        cmd.CommandText = "";
        cmd.CommandText = "select freq, name from freq";

        var reader = cmd.ExecuteReader();
        
        while (reader.Read())
        {
            Period.Items.Add(new ListItem
            {
                Value = reader["freq"].ToString(),
                Text = reader["name"].ToString()
            });
        }

        Period.SelectedIndex = 3;
    }

    /// <summary>
    /// Нажатие на кнопку "Сохранить"
    /// </summary>
    protected void SavePayment()
    {
        // Создаем соединение
        IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
        OracleConnection connect = conn.GetUserConnection();

        try
        {
            // Открываем соединение с БД
            OracleCommand command = connect.CreateCommand();

            Decimal pIdg = 11; // STO_GRP. 
            Decimal pIds = 0;
            DateTime pSdat = DateTime.Now.Date;

            var param = HttpContext.Current.Request.Params;
            string nmk = param.Get("NMK");
            Decimal rnk = Convert.ToDecimal(param.Get("RNK"));

            command.Parameters.Clear();
            command.Parameters.Add("IDG", OracleDbType.Decimal, pIdg, ParameterDirection.Input);
            command.Parameters.Add("p_IDS", OracleDbType.Decimal, pIds, ParameterDirection.Output);
            command.Parameters.Add("RNK", OracleDbType.Decimal, rnk, ParameterDirection.Input);
            command.Parameters.Add("NAME", OracleDbType.Varchar2, (nmk), ParameterDirection.Input);
            command.Parameters.Add("SDAT", OracleDbType.Date, pSdat, ParameterDirection.Input);
            command.CommandText = "begin sto_all.add_RegularLST(:IDG, :p_IDS, :RNK, :NAME, :SDAT); end;";
            command.ExecuteNonQuery();

            pIds = Convert.ToDecimal(Convert.ToString(command.Parameters["p_IDS"].Value));

            DBLogger.Info(string.Format("Створено новий регулярний платіж {0}", pIds), "Credit");

            Decimal ord = Convert.ToDecimal(Prior.Value);
            Decimal vob = 6;
            Decimal dk = 1;
            String nlsa = param.Get("NLS");
            Decimal kva = Convert.ToDecimal(GetCodVal(rnk, connect));
            String nlsb = param.Get("tbNlsB");//tbNlsB.Value;
            String tt = String.Empty;
            Decimal wend = -1;

            command.Parameters.Clear();
            command.CommandText = "select f_ourmfo_g as f_mfo from dual";

            var reader = command.ExecuteReader();
            decimal fMfo = 0;

            while (reader.Read())
            {
                fMfo = Convert.ToDecimal(reader["f_mfo"].ToString());
            }

            if (fMfo != Convert.ToDecimal(param.Get("tbMfoB").ToString()))
            {
                tt = "W4G";
            }
            else
            {
                tt = "PK!";
            }


            Decimal kvb = Convert.ToDecimal(GetCodVal(rnk, connect));
            String mfob = param.Get("tbMfoB");
            String polu = param.Get("tbNmkB").Length > 38 ? param.Get("tbNmkB").Substring(0, 38) : param.Get("tbNmkB");
            String nazn = param.Get("taNazn");
            String okpo = param.Get("tbOkpoB");
            DateTime datBegin = Convert.ToDateTime(StartDate.Value);
            DateTime datEnd = Convert.ToDateTime(param.Get("EndDate"));
            Decimal freq = Convert.ToDecimal(param.Get("Period"));
            Decimal idd = 0;

            decimal statusId = 0;
            string statusText = "";

            String dr = String.Empty;

            String fsum = String.Format("{0}", Convert.ToDecimal(param.Get("tbSum")) * 100);

            var cultute = new CultureInfo("uk-UA")
            {
                DateTimeFormat = { ShortDatePattern = "dd/MM/yyyy", DateSeparator = "/" }
            };

            command.Parameters.Clear();
            command.Parameters.Add("IDS", OracleDbType.Decimal, pIds, ParameterDirection.Input);
            command.Parameters.Add("ord", OracleDbType.Decimal, ord, ParameterDirection.Input);
            command.Parameters.Add("tt", OracleDbType.Varchar2, tt, ParameterDirection.Input);
            command.Parameters.Add("vob", OracleDbType.Decimal, vob, ParameterDirection.Input);
            command.Parameters.Add("dk", OracleDbType.Decimal, dk, ParameterDirection.Input);
            command.Parameters.Add("nlsa", OracleDbType.Varchar2, nlsa, ParameterDirection.Input);
            command.Parameters.Add("kva", OracleDbType.Decimal, kva, ParameterDirection.Input);
            command.Parameters.Add("nlsb", OracleDbType.Varchar2, nlsb, ParameterDirection.Input);
            command.Parameters.Add("kvb", OracleDbType.Decimal, kvb, ParameterDirection.Input);
            command.Parameters.Add("mfob", OracleDbType.Varchar2, mfob, ParameterDirection.Input);
            command.Parameters.Add("polu", OracleDbType.Varchar2, polu, ParameterDirection.Input);
            command.Parameters.Add("nazn", OracleDbType.Varchar2, nazn, ParameterDirection.Input);
            command.Parameters.Add("fsum", OracleDbType.Varchar2, fsum, ParameterDirection.Input);
            command.Parameters.Add("okpo", OracleDbType.Varchar2, okpo, ParameterDirection.Input);
            command.Parameters.Add("DAT1", OracleDbType.Date, datBegin, ParameterDirection.Input);
            command.Parameters.Add("DAT2", OracleDbType.Date, datEnd, ParameterDirection.Input);
            command.Parameters.Add("FREQ", OracleDbType.Decimal, freq, ParameterDirection.Input);
            command.Parameters.Add("WEND", OracleDbType.Decimal, wend, ParameterDirection.Input);
            command.Parameters.Add("DR", OracleDbType.Varchar2, dr, ParameterDirection.Input);
            command.Parameters.Add("p_idd", OracleDbType.Decimal, idd, ParameterDirection.Output);
            command.Parameters.Add("p_status", OracleDbType.Decimal, statusId, ParameterDirection.Output);
            command.Parameters.Add("p_status_text", OracleDbType.Varchar2, 50000, statusText, ParameterDirection.Output);


            command.CommandText = @"begin sto_all.Add_RegularTreaty( 
                                            :IDS, 
                                            :ord, 
                                            :tt, 
                                            :vob, 
                                            :dk, 
                                            :nlsa,
                                            :kva, 
                                            :nlsb, 
                                            :kvb, 
                                            :mfob, 
                                            :polu, 
                                            :nazn,
                                            :fsum, 
                                            :okpo, 
                                            :DAT1, 
                                            :DAT2, 
                                            :FREQ, 
                                            null,
                                            :WEND, 
                                            :DR, 
                                            null, 
                                            null,
                                            null,
                                            :p_idd,
                                            :p_status,
                                            :p_status_text);
                                        end;";

            DBLogger.Info(Convert.ToString(command.Parameters["IDS"].Value) + "," +
                Convert.ToString(command.Parameters["ord"].Value) + "," +
                Convert.ToString(command.Parameters["tt"].Value) + "," +
                Convert.ToString(command.Parameters["vob"].Value) + "," +
                Convert.ToString(command.Parameters["dk"].Value) + "," +
                Convert.ToString(command.Parameters["p_idd"].Value) + "," +
                Convert.ToString(command.Parameters["nlsa"].Value)
                );
            OracleDataReader rdr = command.ExecuteReader();

            idd = Convert.ToDecimal(Convert.ToString(command.Parameters["p_idd"].Value));
            statusId = Convert.ToDecimal(Convert.ToString(command.Parameters["p_status"].Value));
            statusText = Convert.ToString(command.Parameters["p_status_text"].Value);
            //DBLogger.Info(Convert.ToString(command.Parameters["p_status_text"].Value));

            tbNumb.Value = Convert.ToString(idd);
            DBLogger.Info(Convert.ToString(tbNumb.Value));

            if (statusId == 0)
            {
                saveResult.InnerHtml =
                    string.Format("<div class=\"k-block k-success-colored\"><span class=\"k-icon k-i-note\">error</span> Платіж збережено. № {0}</div>", idd);
                Prior.Items.Clear();
                Prior.Items.Add(new ListItem
                {
                    Selected = true,
                    Value = Convert.ToString(ord),
                    Text = Convert.ToString(ord)
                });
                //btPrint.Enabled = true;
            }
            else
            {
                saveResult.InnerHtml =
                    string.Format("<div class=\"k-block k-error-colored\"><span class=\"k-icon k-i-note\">error</span> Помилка при збереженні:<div> {0}</div></div>", statusText);
            }

            rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

    }
    protected void PrintPayment(decimal rnk, decimal idd)
    {
        // Друк Заяви
        FrxParameters pars = new FrxParameters
        {
            new FrxParameter("rnk", TypeCode.Int64, rnk),
            new FrxParameter("IDD", TypeCode.String, idd)
        };

        const string template = "dpt_agrmreg";

        FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(template)), pars, Page);

        // выбрасываем в поток в формате PDF
        using (var str = new MemoryStream())
        {
            doc.ExportToMemoryStream(FrxExportTypes.Pdf, str);
            Response.ClearContent();
            Response.ClearHeaders();
            Response.AppendHeader("content-disposition", "attachment;filename=" + template + "_" + rnk + "_" + idd + ".pdf");
            Response.ContentType = "application/pdf";
            Response.BinaryWrite(str.ToArray());
            Response.Flush();
            Response.End();
        }
    }
}