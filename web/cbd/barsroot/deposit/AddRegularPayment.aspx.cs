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

public partial class dedosit_AddRegularPayment : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HttpContext.Current.Request.HttpMethod == HttpMethod.Post)
        {
            SavePayment();
        }
        var typeParam = HttpContext.Current.Request.Params.GetValues("type");
        var rnkParam = HttpContext.Current.Request.Params.GetValues("RNK");
        if (typeParam != null && Convert.ToString(typeParam.GetValue(0)).ToUpper() == "PRINT")
        {
            if (rnkParam != null)
            {
                var rnk = Convert.ToDecimal(rnkParam.GetValue(0));
                var iddParam = HttpContext.Current.Request.Params.GetValues("idd");
                decimal idd = Convert.ToDecimal(iddParam.GetValue(0));
                PrintPayment(rnk,idd);                
            }
        }
        else
        {
            var param = HttpContext.Current.Request.Params;
            var nlsParam = param.GetValues("NLS");
            var ndParam = param.GetValues("ND");

            if (rnkParam != null)
            {
                var rnk = Convert.ToDecimal(rnkParam.GetValue(0));
                string nls = nlsParam == null ? "" : Convert.ToString(nlsParam.GetValue(0));
                RNK.Value = Convert.ToString(rnk);
                NLS.Value = nls;
                NLStext.Value = nls;
                decimal nd = ndParam == null ? 0 : Convert.ToDecimal(ndParam.GetValue(0));
                IOraConnection conn = (IOraConnection) Application["OracleConnectClass"];
                OracleConnection connect = conn.GetUserConnection();
                var ccDial = GetCcDial(nd, connect);
                var nlsDial = GetNLSDial(nls, connect);

                try
                {
                    var command = connect.CreateCommand();
                    command.CommandText = "select * from customer where rnk = :p_rnk";
                    command.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
                    var reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        OKPO.Value = Convert.ToString(reader["OKPO"]);
                        OKPOtext.Value = Convert.ToString(reader["OKPO"]);
                    }

                    string bancMfo = GetOurMfo(connect);
                    MFO.Value = bancMfo;
                    MFOtext.Value = bancMfo;
                    StartDate.Value = Convert.ToString(DateTime.Now.Date.ToString("d"));

                    CodVal.Value = Convert.ToString(param.GetValues("CodeVal").GetValue(0)); //GetCodVal(rnk, nd, connect);
                    var sum = Convert.ToString(GetSumm(ccDial.CC_ID, ccDial.SDATE, connect));
                    SUM.Value = sum;
                    SUMtext.Value = GetSummT(ccDial.CC_ID, ccDial.SDATE);

                    InitFreq(connect);
                    if (!IsPostBack)
                    {
                        InitPrior(rnk, connect);
                        textNazn.Value = string.Format("Поповнення рахунку № {0} за договором № {1} від {2}", nls, nlsDial.ND, nlsDial.DATZ);
                    }
                }
                finally
                {
                    connect.Close();
                    connect.Dispose();
                }
            }
        }
    }

    public string GetOurMfo(OracleConnection connect)
    {
        OracleCommand command = connect.CreateCommand();
        command.CommandText = @"SELECT val from params where par = 'MFO'";
        return Convert.ToString(command.ExecuteScalar());
    }
    public string GetCodVal(decimal rnk,decimal nd,OracleConnection connect)
    {
        OracleCommand command = connect.CreateCommand();
        command.CommandText = @"select 
                                    a.kv kv 
                                from cc_deal c, 
                                    nd_acc ca, 
                                    accounts a 
                                where 
                                    ca.nd = c.nd 
                                    and ca.acc = a.acc 
                                    and c.rnk = :p_rnk 
                                    and c.nd = :p_nd 
                                    --and a.tip in ('SG') 
                                    --and nls like '2620%'
                                    and (a.tip in ('SS ', 'SG ') or a.nbs = '2620')";
        command.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
        command.Parameters.Add("p_nd", OracleDbType.Decimal, nd, ParameterDirection.Input);
        return Convert.ToString(command.ExecuteScalar());
    }

    protected void InitFreq(OracleConnection connect)
    {
        Freq.Items.Clear();
        // Регулярные платежи
        OracleCommand cmd = connect.CreateCommand();
        cmd.CommandText = "select * from BARS.FREQ where freq=2 order by FREQ";
        var reader = cmd.ExecuteReader();
        while (reader.Read())
        {
            Freq.Items.Add(new ListItem
            {
                Value = Convert.ToString(reader["FREQ"]),
                Text = "Згідно з графіком погашення кредиту"//Convert.ToString(reader["NAME"])
            });
        }
    }
    protected void InitPrior(decimal rnk,  OracleConnection connect)
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

    public class CC_DIAL 
    {
        public decimal ND { get; set; }
        public string CC_ID { get; set; }
        public string SDATE { get; set; }
    }
    private CC_DIAL GetCcDial(decimal nd, OracleConnection connect)
    {
        OracleCommand command = connect.CreateCommand();
        command.Parameters.Add("p_nd", OracleDbType.Decimal, nd, ParameterDirection.Input);
        command.CommandText = @"select 
                                    c.ND,
                                    to_char(c.sdate, 'dd/mm/yyyy') as sdate,
                                    c.CC_ID
                                from cc_deal c
                                where c.nd = :p_nd";
        var reader = command.ExecuteReader();
        CC_DIAL res = null;
        if (reader.Read())
        {
            res = new CC_DIAL
            {
                CC_ID = Convert.ToString(reader["cc_id"]),
                ND = Convert.ToDecimal(reader["ND"]),
                SDATE = Convert.ToString(reader["sdate"]),
            };
        }

        return res;
    }

    public class NLS_DIAL
    {
        public string ND { get; set; }        
        public string DATZ { get; set; }
    }
    private NLS_DIAL GetNLSDial(string nls, OracleConnection connect)
    {
        OracleCommand command = connect.CreateCommand();
        command.Parameters.Add("p_nls", OracleDbType.Varchar2, nls, ParameterDirection.Input);
        command.CommandText = @"select max(deposit_id) ND, to_char(max(d.datz),'dd.mm.yyyy') DATZ
                                from dpt_deposit d, accounts a
                                where a.acc = d.acc                                
                                and a.nls = :p_nls";
        var reader = command.ExecuteReader();
        NLS_DIAL res = null;
        if (reader.Read())
        {
            res = new NLS_DIAL
            {
                ND = Convert.ToString(reader["ND"]),
                DATZ = Convert.ToString(reader["DATZ"])
            };
        }

        return res;
    }

    private decimal GetSumm(string ccId,string date,OracleConnection connect)
    {
        OracleCommand command = connect.CreateCommand();
        decimal summ = 0;
        command.Parameters.Add("p_cc_id", OracleDbType.Varchar2,ccId, ParameterDirection.Input);
        command.Parameters.Add("p_date", OracleDbType.Varchar2, date, ParameterDirection.Input);
        command.CommandText = "select GET_INFO_SUM_EXT(:p_cc_id, to_date(:p_date,'dd/mm/yyyy')) from dual";
        summ = Convert.ToDecimal(command.ExecuteScalar());
        return summ;
    }

    private string GetSummT(string ccId, string date)
    {
        String summT = string.Format("Згідно з графіком погашення кредиту № {0} від {1}",ccId,date); 
        return summT;
    }
    /// <summary>
    /// Нажатие на кнопку "Сохранить"
    /// </summary>
    protected void SavePayment()
    {
        // Создаем соединение
        IOraConnection conn = (IOraConnection) Application["OracleConnectClass"];
        OracleConnection connect = conn.GetUserConnection();

        try
        {
            // Открываем соединение с БД
            OracleCommand command = connect.CreateCommand();

            Decimal pIdg = 12; // STO_GRP. 
            Decimal pIds = 0;
            DateTime pSdat = DateTime.Now.Date;

            var param = HttpContext.Current.Request.Params;
            string nmk = param.Get("NMK");

            command.Parameters.Clear();
            command.Parameters.Add("IDG", OracleDbType.Decimal, pIdg, ParameterDirection.Input);
            command.Parameters.Add("p_IDS", OracleDbType.Decimal, pIds, ParameterDirection.Output);
            command.Parameters.Add("RNK", OracleDbType.Decimal, RNK.Value, ParameterDirection.Input);
            command.Parameters.Add("NAME", OracleDbType.Varchar2, (nmk), ParameterDirection.Input);
            command.Parameters.Add("SDAT", OracleDbType.Date, pSdat, ParameterDirection.Input);
            command.CommandText = "begin sto_all.add_RegularLST(:IDG, :p_IDS, :RNK, :NAME, :SDAT); end;";
            command.ExecuteNonQuery();

            pIds = Convert.ToDecimal(Convert.ToString(command.Parameters["p_IDS"].Value));

            DBLogger.Info(string.Format("Створено новий регулярний платіж {0}", pIds) ,"Credit");

            Decimal ord = Convert.ToDecimal(param.Get("Prior"));           
            Decimal vob = 6;
            Decimal dk = 1;
            String nlsa = param.Get("NLSA");
            Decimal kva = Convert.ToDecimal(param.Get("CodVal"));
            String nlsb = Convert.ToString(param.GetValues("NLS").GetValue(0));
            String tt = String.Empty;
            Decimal wend = -1;

            if (nlsb.Substring(0, 4) == "2625")
            {
                 tt = "PKO";        
            }
            else 
            {    tt = "PK!";   
            }
           

            Decimal kvb = Convert.ToDecimal(param.Get("CodVal"));
            String mfob = MFO.Value;
            String polu = nmk.Length > 38 ? nmk.Substring(0, 38) : nmk;
            String nazn = param.Get("textNazn");
            decimal nd = Convert.ToDecimal(param.Get("ND"));
            var ccDial = GetCcDial(nd,connect);
            string sum = string.Format("F_GET_SUM_CCK( '{0}', to_date('{1}','dd/mm/yyyy'))", ccDial.CC_ID, ccDial.SDATE);
            String okpo = OKPO.Value;
            DateTime datBegin = Convert.ToDateTime(param.Get("StartDate"));
            DateTime datEnd = Convert.ToDateTime(param.Get("EndDate"));
            Decimal freq = Convert.ToDecimal(param.Get("Freq"));           
            Decimal idd = 0;

            decimal statusId = 0;
            string statusText ="";
           
            String dr = String.Empty;

            var cultute = new CultureInfo("uk-UA")
            {
                DateTimeFormat = {ShortDatePattern = "dd/MM/yyyy", DateSeparator = "/"}
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
            command.Parameters.Add("fsum", OracleDbType.Varchar2, sum, ParameterDirection.Input);
            command.Parameters.Add("okpo", OracleDbType.Varchar2, okpo, ParameterDirection.Input);
            command.Parameters.Add("DAT1", OracleDbType.Date, datBegin, ParameterDirection.Input);
            command.Parameters.Add("DAT2", OracleDbType.Date, datEnd, ParameterDirection.Input);
            command.Parameters.Add("FREQ", OracleDbType.Decimal, freq, ParameterDirection.Input);
            command.Parameters.Add("WEND", OracleDbType.Decimal, wend, ParameterDirection.Input);
            command.Parameters.Add("DR", OracleDbType.Varchar2, dr, ParameterDirection.Input);
            command.Parameters.Add("p_nd", OracleDbType.Decimal, ccDial.ND, ParameterDirection.Input);
            command.Parameters.Add("p_sdate", OracleDbType.Date, Convert.ToDateTime(ccDial.SDATE,cultute) , ParameterDirection.Input);
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
                                            :p_nd,
                                            :p_sdate,
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

            IDD.Value = Convert.ToString(idd);
            DBLogger.Info(Convert.ToString(IDD.Value));

            if (statusId == 0)
            {
                saveResult.InnerHtml =
                    string.Format("<div class=\"k-block k-success-colored\"><span class=\"k-icon k-i-note\">error</span> Платіж збережено. № {0}</div>", idd);
                Prior.Items.Clear();
                Prior.Items.Add(new ListItem
                {
                    Selected = true, 
                    Value = Convert.ToString(ord) ,
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
    protected void PrintPayment(decimal rnk,decimal idd)
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