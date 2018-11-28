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
using Bars.Doc;
using BarsWeb.Core.Logger;
using FastReport.Cloud;
using Oracle.DataAccess.Client;
using BarsWeb.Areas.Sto.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sto.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.Sto;


public partial class w4_AddRegularPayment : Page
{
    private readonly IDbLogger _dbLogger;

    private IContractRepository stoRepo;

    public w4_AddRegularPayment()
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

        if (!IsPostBack)
        {
            string[] rnk = HttpContext.Current.Request.Params.GetValues("RNK");
            string[] nmk = HttpContext.Current.Request.Params.GetValues("NMK");
            string[] nlsa = HttpContext.Current.Request.Params.GetValues("NLS");
            string[] kv = HttpContext.Current.Request.Params.GetValues("KV");
            string[] typeParam = HttpContext.Current.Request.Params.GetValues("type");

            if (typeParam != null && Convert.ToString(typeParam.GetValue(0)).ToUpper() == "PRINT")
            {
                if (rnk != null)
                {
                    decimal rnkPar = Convert.ToDecimal(rnk.GetValue(0));
                    string[] iddParam = HttpContext.Current.Request.Params.GetValues("idd");
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

                OracleCommand cmd = connect.CreateCommand();
                cmd.CommandText = "select val from params$base where par = 'BANKDATE'";

                var result = Convert.ToString(cmd.ExecuteScalar());
                CultureInfo cultureinfo = new CultureInfo("en-US");
                DateTime bDate = DateTime.Parse(result, cultureinfo);
                var date = bDate.AddDays(1);

                StartDate.Value = String.Format("{0:dd/MM/yyyy}", date);
            }
        }
    }

    public string GetOurMfo(OracleConnection connect)
    {
        OracleCommand command = connect.CreateCommand();
        command.CommandText = @"SELECT val from params where par = 'MFO'";
        return Convert.ToString(command.ExecuteScalar());
    }
    public string GetCodVal(decimal rnk, string nls, decimal kv, OracleConnection connect)
    {
        OracleCommand command = connect.CreateCommand();
        command.CommandText = @"select 
                                    a.kv kv 
                                from accounts a 
                                where a.rnk = :p_rnk and a.nls = :p_nls and a.kv = :p_kv ";
        command.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
        command.Parameters.Add("p_nls", OracleDbType.Varchar2, nls, ParameterDirection.Input);
        command.Parameters.Add("p_kv", OracleDbType.Decimal, kv, ParameterDirection.Input);
        return Convert.ToString(command.ExecuteScalar());
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
                                and F.FREQ = SD.FREQ
                                and sa.IDG = " + STO_BPK_Group;
        cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);

        OracleDataReader reader2 = cmd.ExecuteReader();
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
        cmd.CommandText = "select freq, name from freq where freq not in(2,12,999,30)";

        OracleDataReader reader = cmd.ExecuteReader();

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

    //стандартная группа регулярных платежей "2924 Платежі по БПК"
    private static decimal STO_BPK_Group = 11;

    /// <summary>
    /// Нажатие на кнопку "Сохранить", создание договора на рег. платежи и макета платежа
    /// </summary>
    protected void SavePayment()
    {
        IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
        OracleConnection connect = conn.GetUserConnection();
        OracleDataReader reader = null;
        try
        {
            OracleCommand command = connect.CreateCommand();

            var param = HttpContext.Current.Request.Params;

            // Создание договора на выполнение регулярных платежей
            ids contract = new ids(Convert.ToDecimal(param.Get("RNK")), STO_BPK_Group, param.Get("NMK"))
            {
                SDAT = DateTime.Now.Date
            };
            if (stoRepo.ContractData().Where(x => x.RNK == contract.RNK && x.IDG == contract.IDG).Any())
            {
                // если есть уже для этого клиента и группы - берем существующий
                contract.IDS = stoRepo.ContractData().Where(x => x.RNK == contract.RNK && x.IDG == contract.IDG).First().IDS;
            }
            stoRepo.AddIDS(contract);
            _dbLogger.Info(string.Format("Створено новий договір на регулярні платежі: {0}", contract.IDS), "BPK");

            // Начало заполнения макета платежа
            payment payment = new payment()
            {
                ord = Convert.ToDecimal(Prior.Value),
                vob = 6,
                dk = 1,
                nlsa = param.Get("NLS"),
                kva = Convert.ToDecimal(param.Get("KV")),
                nlsb = param.Get("tbNlsB"),
                tt = tbTTs.Value,
                WEND = Weekends1.Checked == true ? 1 : -1,
                kvb = Convert.ToDecimal(param.Get("KV")),
                mfob = param.Get("tbMfoB"),
                polu = param.Get("tbNmkB").Length > 38 ? param.Get("tbNmkB").Substring(0, 38) : param.Get("tbNmkB"),
                nazn = param.Get("taNazn"),
                okpo = param.Get("tbOkpoB"),
                DAT1 = Convert.ToDateTime(StartDate.Value),
                DAT2 = Convert.ToDateTime(param.Get("EndDate")),
                FREQ = Convert.ToDecimal(param.Get("Period")),
                DR = String.Empty,
                fsum = String.Format("{0}", Convert.ToDecimal(param.Get("tbSum").Replace(",", ".")) * 100),
                IDS = contract.IDS
            };

            // Создание макета платежа
            Decimal idd = stoRepo.AddPayment(payment);

            tbNumb.Value = Convert.ToString(idd);
            _dbLogger.Info(Convert.ToString(tbNumb.Value));

            saveResult.InnerHtml = string.Format("<div class=\"k-block k-success-colored\"><span class=\"k-icon k-i-note\">error</span> Платіж збережено. № {0}</div>", payment.idd);
            Prior.Items.Clear();
            Prior.Items.Add(new ListItem
            {
                Selected = true,
                Value = Convert.ToString(payment.ord),
                Text = Convert.ToString(payment.ord)
            });

            if (cbFee.Checked)
            {
                // Начало заполнения данных для платежа комиссии
                String sumFee = tbFee.Value;
                String ob22 = param.Get("OB22");
                String branch = param.Get("BRANCH").Substring(0, 15);
                command.Parameters.Clear();
                command.CommandText = "select f_ourmfo as f_mfo from dual";

                reader = command.ExecuteReader();
                decimal fMfo = 0;

                while (reader.Read())
                {
                    fMfo = Convert.ToDecimal(reader["f_mfo"].ToString());
                }

                command.Parameters.Clear();
                command.CommandText = "select nms from accounts where nls = :NLSA and KV = :KVA";
                command.Parameters.Add(new OracleParameter("NLSA", OracleDbType.Varchar2, payment.nlsa, ParameterDirection.Input));
                command.Parameters.Add(new OracleParameter("KVA", OracleDbType.Varchar2, payment.kva, ParameterDirection.Input));

                reader = command.ExecuteReader();
                String nmsA = String.Empty;

                while (reader.Read())
                {
                    nmsA = reader["nms"].ToString();
                }

                var culture = new CultureInfo("uk-UA")
                {
                    DateTimeFormat = { ShortDatePattern = "dd/MM/yyyy", DateSeparator = "/" }
                };

                command.Parameters.Clear();

                Bars.WebServices.NewNbs ws = new Bars.WebServices.NewNbs();
                string _nbs = ws.UseNewNbs() ? "6510" : "6110";

                command.CommandText = string.Format(@"select a.nls, 
                                           a.nms, 
                                           a.kf, 
                                           user_id as userid
                                      from accounts a, 
                                           w4_nbs_ob22 wob 
                                     where a.nbs = {0} 
                                       and a.ob22 = wob.ob_6110 
                                       and wob.nbs = 2625 
                                       and wob.ob22 = :p_ob22 
                                       and a.branch = :p_branch
                                       and rownum = 1", _nbs);
                command.Parameters.Add("p_ob22", OracleDbType.Varchar2, ob22, ParameterDirection.Input);
                command.Parameters.Add("p_branch", OracleDbType.Varchar2, branch, ParameterDirection.Input);

                reader = command.ExecuteReader();
                String nlsk = String.Empty;
                String nmsk = String.Empty;
                String mfoB = String.Empty;
                decimal userId = 0;

                while (reader.Read())
                {
                    nlsk = reader["nls"].ToString();
                    nmsk = reader["nms"].ToString();
                    mfoB = reader["kf"].ToString();
                    userId = Convert.ToDecimal(reader["userid"].ToString());
                }

                long Ref = 0;	                // референс 
                string TT = "W4S";   // Код операции
                byte Dk = (byte)payment.dk;                // ДК (0-дебет, 1-кредит)
                short Vob = (short)payment.vob; // Вид обработки
                string Nd = string.Empty;	// № док
                DateTime DatD = DateTime.Now;		// Дата док
                DateTime DatP = DatD;		// Дата ввода(поступления в банк)
                DateTime DatV1 = DateTime.Now; // Дата валютирования основной операции
                DateTime DatV2 = DatV1;		// Дата валютирования связаной операции
                string NlsA = payment.nlsa;		// Счет-А
                string NamA = nmsA;		// Наим-А
                string BankA = Convert.ToString(fMfo); 		// МФО-А
                string NbA = string.Empty;		// Наим банка-А(м.б. '')
                short KvA = (short)payment.kva;			// Код вал-А
                decimal SA = Convert.ToDecimal(tbFee.Value) * 100;			// Сумма-А
                string OkpoA = param.Get("OKPO");		// ОКПО-А
                string NlsB = nlsk;		// Счет-Б
                string NamB = nmsk;		// Наим-Б
                string BankB = mfoB;		// МФО-Б
                string NbB = string.Empty;			// Наим банка-Б(м.б. '')
                short KvB = 980;			// Код вал-Б
                decimal SB = Convert.ToDecimal(tbFee.Value) * 100;			// Сумма-Б
                string OkpoB = payment.okpo;		// ОКПО-Б
                string Nazn = "Плата за оформлення регулярного платежа БПК";	// Назначение пл
                string Drec = string.Empty;		// Доп реквизиты
                string OperId = Convert.ToString(userId);		// Идентификатор ключа опрециониста
                byte[] Sign = new byte[0];		// ЭЦП опрециониста
                byte Sk = 0;			// СКП
                short Prty = 0;			// Приоритет документа
                decimal SQ = 0;			// Эквивалент для одновалютной оп
                string ExtSignHex = string.Empty;	// Внешняя ЭЦП в 16-ричном формате (оно же закодированное поле byte[] Sign)
                string IntSignHex = string.Empty;	// Внутренняя ЭЦП в 16-ричном формате
                string pAfterPayProc = string.Empty; /// процедура після оплати
                string pBeforePayProc = string.Empty; /// процедура перед оплатою
                cDoc outDoc = new cDoc(connect, Ref, TT, Dk, Vob, Nd, DatD, DatP, DatV1, DatV2, NlsA, NamA, BankA, NbA, KvA, SA, OkpoA, NlsB, NamB, BankB, NbB, KvB, SB, OkpoB, Nazn, Drec, OperId, Sign, Sk, Prty, SQ, ExtSignHex, IntSignHex, pAfterPayProc, pBeforePayProc);

                if (outDoc.oDocument())
                {
                    saveResult.InnerHtml += string.Format("<div class=\"k-block k-success-colored\"><span class=\"k-icon k-i-note\">error</span> Платіж комісії збережено. реф. {0}</div>", outDoc.Ref);
                }
            }
        }
        catch (Exception e)
        {
            saveResult.InnerHtml =
                    string.Format("<div class=\"k-block k-error-colored\"><span class=\"k-icon k-i-note\">error</span> Помилка при збереженні:<div> {0}</div></div>", e.Message);
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            {
                connect.Close();
                connect.Dispose();
            }
            if (reader != null)
                reader.Dispose();
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

        const string template = "sto_agrmreg";

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