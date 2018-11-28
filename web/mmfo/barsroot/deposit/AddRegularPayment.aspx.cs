using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Oracle;
using BarsWeb.Core.Logger;
using FastReport.Cloud;
using Oracle.DataAccess.Client;
using BarsWeb.Areas.Sto.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sto.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.Sto;

public partial class dedosit_AddRegularPayment : Page
{
    private readonly IDbLogger _dbLogger;
    private IContractRepository stoRepo;
    public dedosit_AddRegularPayment()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
        stoRepo = new ContractRepository();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HttpContext.Current.Request.HttpMethod == HttpMethod.Post)
        {
            SavePayment();
        }
        string[] typeParam = HttpContext.Current.Request.Params.GetValues("type");
        string[] rnkParam = HttpContext.Current.Request.Params.GetValues("RNK");
        if (typeParam != null && Convert.ToString(typeParam.GetValue(0)).ToUpper() == "PRINT")
        {
            if (rnkParam != null)
            {
                decimal rnk = Convert.ToDecimal(rnkParam.GetValue(0));
                string[] iddParam = HttpContext.Current.Request.Params.GetValues("idd");
                decimal idd = Convert.ToDecimal(iddParam.GetValue(0));
                PrintPayment(rnk,idd);                
            }
        }
        else
        {
            var param = HttpContext.Current.Request.Params;
            string[] nlsParam = param.GetValues("NLS");
            string[] ndParam = param.GetValues("ND");

            if (rnkParam != null)
            {
                decimal rnk = Convert.ToDecimal(rnkParam.GetValue(0));
                string nls = nlsParam == null ? "" : Convert.ToString(nlsParam.GetValue(0));
                RNK.Value = Convert.ToString(rnk);
                NLS.Value = nls;
                NLStext.Value = nls;
                decimal nd = ndParam == null ? 0 : Convert.ToDecimal(ndParam.GetValue(0));
                IOraConnection conn = (IOraConnection) Application["OracleConnectClass"];
                OracleConnection connect = conn.GetUserConnection();
                CC_DIAL ccDial = GetCcDial(nd, connect);
                NLS_DIAL nlsDial = GetNLSDial(nls, connect);

                try
                {
                    OracleCommand command = connect.CreateCommand();
                    command.CommandText = "select * from customer where rnk = :p_rnk";
                    command.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
                    OracleDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        OKPO.Value = Convert.ToString(reader["OKPO"]);
                        OKPOtext.Value = Convert.ToString(reader["OKPO"]);
                    }

                    string bancMfo = GetOurMfo(connect);
                    MFO.Value = bancMfo; 
                    MFOtext.Value = bancMfo;
		    
 		    DateTime dat_begin = DateTime.Now.Date.AddDays(1);
                    StartDate.Value = Convert.ToString(dat_begin.ToString("d"));

                    CodVal.Value = Convert.ToString(param.GetValues("CodeVal").GetValue(0)); //GetCodVal(rnk, nd, connect);
                    String sum = Convert.ToString(GetSumm(ccDial.CC_ID, ccDial.SDATE, connect));
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
    public string GetCodVal(decimal rnk, decimal nd, OracleConnection connect)
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
        OracleDataReader reader = cmd.ExecuteReader();
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
        cmd.CommandText = @" SELECT SD.ORD
                               FROM BARS.STO_GRP SG,
                                    BARS.STO_LST SA,
                                    BARS.STO_DET SD,
                                    V_FREQ_STO F
                              WHERE     SG.IDG = 12
                                    AND SA.IDG = SG.IDG
                                    AND SD.IDS = SA.IDS
                                    AND SA.RNK = :rnk
                                    AND F.FREQ(+) = SD.FREQ";
        cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);

        OracleDataReader reader2 = cmd.ExecuteReader();
        List<decimal> listExist = new List<decimal>();

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

    //стандартная группа регулярных платежей "Кредити (авто-погашення з картрахунку)"
    private readonly decimal STO_Credits_Group = 12;

    /// <summary>
    /// Нажатие на кнопку "Сохранить", создание договора на выполнение рег. платежа и макета
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

            var param = HttpContext.Current.Request.Params;

            // Создание договора на выполнение регулярных платежей
            ids contract = new ids(Convert.ToDecimal(RNK.Value), STO_Credits_Group, param.Get("NMK"))
            {
                SDAT = DateTime.Now.Date
            };
            if (stoRepo.ContractData().Where(x => x.RNK == contract.RNK && x.IDG == contract.IDG).Any())
            {
                // если есть уже для этого клиента и группы - берем существующий
                contract.IDS = stoRepo.ContractData().Where(x => x.RNK == contract.RNK && x.IDG == contract.IDG).First().IDS;
            }
            stoRepo.AddIDS(contract);

            _dbLogger.Info(string.Format("Створено новий договір на регулярні платежі: {0}", contract.IDS), "Credits");

			decimal nd = Convert.ToDecimal(param.Get("ND"));
            var ccDial = GetCcDial(nd,connect);
			
            // Начало заполнения макета платежа
            payment payment = new payment()
            {
                ord = Convert.ToDecimal(param.Get("Prior")),
                vob = 6,
                dk = 1,
                nlsa = param.Get("NLSA"),
                kva = Convert.ToDecimal(param.Get("CodVal")),
                nlsb = Convert.ToString(param.GetValues("NLS").GetValue(0)),
                tt = (Convert.ToString(param.GetValues("NLS").GetValue(0)).Substring(0, 4) == "2625") ? "PKO" : "PK!",
                WEND = -1,
                kvb = Convert.ToDecimal(param.Get("CodVal")),
                mfob = MFO.Value,
                polu = param.Get("NMK").Length > 38 ? param.Get("NMK").Substring(0, 38) : param.Get("NMK"),
                nazn = param.Get("textNazn"),
                okpo = OKPO.Value,
                DAT1 = Convert.ToDateTime(param.Get("StartDate")),
                DAT2 = Convert.ToDateTime(param.Get("EndDate")),
                FREQ = Convert.ToDecimal(param.Get("Freq")),
                DR = String.Empty,
                fsum = string.Format("F_GET_SUM_CCK( '{0}', to_date('{1}','dd/mm/yyyy'))", ccDial.CC_ID, ccDial.SDATE),
                IDS = contract.IDS
            };

            // Создание макета платежа
            Decimal idd = stoRepo.AddPayment(payment);

            var cultute = new CultureInfo("uk-UA")
            {
                DateTimeFormat = {ShortDatePattern = "dd/MM/yyyy", DateSeparator = "/"}
            };

            IDD.Value = Convert.ToString(idd);
            _dbLogger.Info(Convert.ToString(IDD.Value));

            saveResult.InnerHtml = string.Format("<div class=\"k-block k-success-colored\"><span class=\"k-icon k-i-note\">error</span> Платіж збережено. № {0}</div>", idd);
            Prior.Items.Clear();
            Prior.Items.Add(new ListItem
            {
                Selected = true, 
                Value = Convert.ToString(payment.ord) ,
                Text = Convert.ToString(payment.ord)
            });
        }
        catch (Exception e)
        {
            saveResult.InnerHtml = string.Format("<div class=\"k-block k-error-colored\"><span class=\"k-icon k-i-note\">error</span> Помилка при збереженні:<div> {0}</div></div>", e.Message);
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