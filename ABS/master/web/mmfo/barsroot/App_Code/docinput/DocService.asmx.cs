using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Globalization;
using System.Web.Services;
using Bars.Doc;
using Bars.DocPrint;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.LinkDocs;
using System.Collections.Generic;
using System.Web;
using BarsWeb.Core.Logger;
using System.Linq;
using System.IO;
using System.Web.UI.WebControls;
using BarsWeb.Infrastructure.Helpers;

namespace DocInput
{
    /// <summary>
    /// Summary description for DocService.
    /// </summary>
    public class DocService : Bars.BarsWebService
    {
        string[] PAY_VERIF_TT = { "PKF" };   // todo: hardcode, use DB dict ?

        private readonly IDbLogger _dbLogger;
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        public DocService()
        {
            _dbLogger = DbLoggerConstruct.NewDbLogger();
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";
            cinfo.NumberFormat.CurrencyDecimalSeparator = ".";
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
        protected override void Dispose(bool disposing)
        {
            if (disposing && components != null)
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #endregion

        private struct oper_stuct
        {
            public OracleConnection con;
            public long Ref;	        // референс (NUMBER_Null для новых)
            public string TT;			// Код операции
            public byte Dk;				// ДК (0-дебет, 1-кредит)
            public short Vob;			// Вид обработки
            public string Nd;			// № док
            public DateTime DatD;		// Дата док
            public DateTime DatP;		// Дата ввода(поступления в банк)
            public DateTime DatV1;		// Дата валютирования основной операции
            public DateTime DatV2;		// Дата валютирования связаной операции
            public string NlsA;			// Счет-А
            public string NamA;			// Наим-А
            public string BankA;		// МФО-А
            public string NbA;			// Наим банка-А(м.б. '')
            public short KvA;			// Код вал-А
            public decimal SA;			// Сумма-А
            public string OkpoA;		// ОКПО-А
            public string NlsB;			// Счет-Б
            public string NamB;			// Наим-Б
            public string BankB;		// МФО-Б
            public string NbB;			// Наим банка-Б(м.б. '')
            public short KvB;			// Код вал-Б
            public decimal SB;			// Сумма-Б
            public string OkpoB;		// ОКПО-Б
            public string Nazn;			// Назначение пл
            public string Drec;			// Доп реквизиты
            public string OperId;		// Идентификатор ключа опрециониста
            public byte[] Sign;			// ЭЦП опрециониста
            public byte Sk;				// СКП
            public short Prty;			// Приоритет документа
            public decimal SQ;			// Эквивалент для одновалютной оп
            public string ExtSignHex;	// ЭЦП внешняя в 16-ричном формате
            public string IntSignHex;	// ЭЦП внутренняя в 16-ричном формате
            public string check_tt;
        }

        public class ValidateInfo
        {
            public string MessageType { get; set; }
            public string Message { get; set; }
            public OraDictionaryItem[] Dictionary { get; set; }
        }

        [WebMethod(EnableSession = true)]
        public ValidateInfo ValidateDoc(string[] data, string[] tags, List<LinkedDocs> checkDocsList)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            oper_stuct oper = new oper_stuct();
            oper.con = conn.GetUserConnection(Context);
            try
            {
                OracleCommand cmd = oper.con.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "gl_ui.doc_input_validation";

                var mainParamsDict = new List<OraDictionaryItem>();
                mainParamsDict.Add(new OraDictionaryItem { Key = "ref", Value = data[0] });
                mainParamsDict.Add(new OraDictionaryItem { Key = "tt", Value = data[2] });
                mainParamsDict.Add(new OraDictionaryItem { Key = "dk", Value = data[3] });
                mainParamsDict.Add(new OraDictionaryItem { Key = "nd", Value = data[6] });
                mainParamsDict.Add(new OraDictionaryItem { Key = "datd", Value = data[7] });
                mainParamsDict.Add(new OraDictionaryItem { Key = "nlsa", Value = data[8] });
                mainParamsDict.Add(new OraDictionaryItem { Key = "nama", Value = data[9] });
                mainParamsDict.Add(new OraDictionaryItem { Key = "kva", Value = data[11] });
                mainParamsDict.Add(new OraDictionaryItem { Key = "ida", Value = data[12] });

                mainParamsDict.Add(new OraDictionaryItem { Key = "nlsb", Value = data[13] });
                mainParamsDict.Add(new OraDictionaryItem { Key = "namb", Value = data[14] });
                mainParamsDict.Add(new OraDictionaryItem { Key = "kvb", Value = data[16] });
                mainParamsDict.Add(new OraDictionaryItem { Key = "idb", Value = data[17] });
                mainParamsDict.Add(new OraDictionaryItem { Key = "nazn", Value = data[18] });

                OracleParameter dictionaryMainParameter = new OracleParameter("p_dictionary_main", OracleDbType.Array, ParameterDirection.Input);
                dictionaryMainParameter.Value = (OraDictionary)mainParamsDict;
                dictionaryMainParameter.UdtTypeName = "BARS.T_DICTIONARY";
                cmd.Parameters.Add(dictionaryMainParameter);

                var paramsDict = new List<OraDictionaryItem>();
                string[] items = data[26].Replace("reqv_", "").Split(',');
                for (int i = 0; i < items.Length - 1; i++)
                {
                    string tagName = items[i];
                    string tagValue = tags[i];
                    //для обычных допреквизитов заполняем массив
                    if (!string.IsNullOrEmpty(tagValue) && items[i] != "f" && items[i] != "n$" && items[i] != "ф$")
                        tagValue = tagValue.Replace("\n", "\r\n");
                    else if (tagName == "n$")
                    {
                        tagName = "n";
                        tagValue = tagValue.Replace("\n", "\r\n");
                    }
                    else if (items[i] == "ф$")
                    {
                        tagName = "ф";
                        tagValue = tags[i].Replace("\n", "\r\n");
                    }
                    paramsDict.Add(new OraDictionaryItem { Key = tagName, Value = tagValue });
                }

                OracleParameter dictionaryParameter = new OracleParameter("p_dictionary", OracleDbType.Array, ParameterDirection.InputOutput);
                dictionaryParameter.Value = (OraDictionary)paramsDict;
                dictionaryParameter.UdtTypeName = "BARS.T_DICTIONARY";
                cmd.Parameters.Add(dictionaryParameter);

                cmd.Parameters.Add(new OracleParameter("p_message", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output));
                cmd.Parameters.Add(new OracleParameter("p_type_message", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output));
                cmd.ExecuteNonQuery();

                var message = string.Empty;
                var messageType = string.Empty;
                if (cmd.Parameters["p_message"].Value != DBNull.Value)
                    message = Convert.ToString(cmd.Parameters["p_message"].Value);
                if (cmd.Parameters["p_type_message"].Value != DBNull.Value)
                    messageType = Convert.ToString(cmd.Parameters["p_type_message"].Value);
                var oraDict = (OraDictionary)cmd.Parameters["p_dictionary"].Value;

                return new ValidateInfo { Message = message, MessageType = messageType, Dictionary = oraDict.Value };
            }
            finally
            {
                if (ConnectionState.Open == oper.con.State) oper.con.Close();
                oper.con.Dispose();
            }
        }

        [WebMethod(EnableSession = true)]
        public string PayDoc(string[] data, string[] tags, List<LinkedDocs> checkDocsList)
        {
            data[18] = Convert.ToString(data[18]).Replace("amp;", "&").Replace("lt;", "<").Replace("gt;", ">");
            data[9] = Convert.ToString(data[9]).Replace("amp;", "&").Replace("lt;", "<").Replace("gt;", ">");
            data[14] = Convert.ToString(data[14]).Replace("amp;", "&").Replace("lt;", "<").Replace("gt;", ">");

            // доп. проверка
            if (data == null || data.Length == 0 || string.IsNullOrEmpty(data[0]))
                throw new System.Exception("Порушено цілісніть даних, повторіть оплату або перезайдіть в систему");
            oper_stuct oper = new oper_stuct();

            oper.Ref = Convert.ToInt64(data[0], 10);
            string TT_Flags = data[1];
            oper.TT = data[2];
            oper.Dk = byte.Parse(data[3]);
            oper.OperId = data[5];
            oper.Nd = data[6];
            if (!string.IsNullOrEmpty(oper.Nd))
                oper.Nd = oper.Nd.Trim();
            oper.DatD = Convert.ToDateTime(data[7], cinfo);

            oper.NlsA = data[8];
            oper.NamA = data[9];
            oper.BankA = data[10];
            oper.KvA = Convert.ToInt16(data[11], 10);
            oper.OkpoA = data[12];
            oper.NlsB = data[13];
            oper.NamB = data[14];
            oper.BankB = data[15];
            oper.KvB = Convert.ToInt16(data[16], 10);
            oper.OkpoB = data[17];
            oper.Nazn = data[18].Trim();
            if (string.IsNullOrEmpty(data[29]))
                data[29] = "0";
            oper.Prty = Convert.ToInt16(data[29]);

            double digA = Convert.ToDouble(data[32], cinfo);
            double digB = Convert.ToDouble(data[33], cinfo);

            decimal kopA = Convert.ToDecimal(Math.Pow(10, digA));
            decimal kopB = Convert.ToDecimal(Math.Pow(10, digB));

            if (TT_Flags[65] == '1')
            {
                oper.SA = Convert.ToDecimal(data[19], cinfo) * kopA;
                oper.SB = Convert.ToDecimal(data[20], cinfo) * kopB;
            }
            else
            {
                oper.SA = Convert.ToDecimal(data[21], cinfo) * kopA;
                oper.SB = Convert.ToDecimal(data[21], cinfo) * kopB;
            }

            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            oper.con = conn.GetUserConnection(Context);

            try
            {
                OracleCommand cmd = oper.con.CreateCommand();

                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                cmd.CommandText = "select web_utl.get_bankdate, sysdate from dual";

                OracleDataReader rdr = cmd.ExecuteReader();
                rdr.Read();
                // При 5 флаге дата валютирования ставится системной
                if (TT_Flags[5] == '1')
                    oper.DatV1 = rdr.GetOracleDate(1).Value;
                else
                    oper.DatV1 = rdr.GetOracleDate(0).Value.Add(DateTime.Now.TimeOfDay);
                rdr.Close();
                rdr.Dispose();

                // Дата поступления в банк
                oper.DatP = DateTime.ParseExact(data[35], "yyMMdd", cinfo);

                // Дата валютирования пользовательская
                if (!string.IsNullOrEmpty(data[27]))
                    oper.DatV1 = Convert.ToDateTime(data[27], cinfo).Add(DateTime.Now.TimeOfDay);

                if (!string.IsNullOrEmpty(data[28]))
                    oper.DatV2 = Convert.ToDateTime(data[28], cinfo).Add(DateTime.Now.TimeOfDay);
                else
                    oper.DatV2 = oper.DatV1;

                if (data[22] == string.Empty) oper.Sk = Byte.MinValue;
                else oper.Sk = Convert.ToByte(data[22], 10);

                if (data[23] == string.Empty) oper.Vob = 6;
                else oper.Vob = Convert.ToInt16(data[23]);

                // внешняя ЭЦП
                oper.ExtSignHex = data[4];
                // for backward compatibility, data[43] - CryptoModule VEG\VG2
                if (string.IsNullOrEmpty(data[43]))
                {
                    oper.Sign = new byte[data[4].Length / 2];
                    int j = 0;
                    for (int i = 0; i < data[4].Length; i += 2)
                    {
                        oper.Sign[j++] = Convert.ToByte(data[4].Substring(i, 2), 16);
                    }
                }
                // внутренняя ЭЦП
                oper.IntSignHex = data[31];

                /// Функція що виконується перед/після оплати
                string AfterPayProcCall = String.Empty;
                string BeforePayProcCall = String.Empty;

                //--проверяем есть ли функция для вызова после оплаты			
                if (data[24] != string.Empty)
                {
                    string AfterPayProc = data[24].Trim();
                    string AfterPayProc_role = data[25];
                    AfterPayProcCall = conn.GetSetRoleCommand(AfterPayProc_role.ToUpper()) +
                        "@" + "begin " + AfterPayProc + " end;";
                }

                if ((data.Length >= 37) && (!String.IsNullOrEmpty(data[36])))
                    AfterPayProcCall = data[36].Trim();

                if ((data.Length >= 38) && (!String.IsNullOrEmpty(data[37])))
                    BeforePayProcCall = data[37].Trim();

                // SQ
                oper.SQ = 0;
                if (TT_Flags[14] == '1')
                    oper.SQ = Convert.ToDecimal((data[30] != "") ? (data[30]) : ("0"), cinfo) * 100;

                cDoc ourDoc = new cDoc(oper.con, oper.Ref, oper.TT, oper.Dk, oper.Vob,
                        oper.Nd,
                        oper.DatD, oper.DatP, oper.DatV1, oper.DatV2,
                        oper.NlsA, oper.NamA, oper.BankA, "", oper.KvA, oper.SA, oper.OkpoA,
                        oper.NlsB, oper.NamB, oper.BankB, "", oper.KvB, oper.SB, oper.OkpoB,
                        oper.Nazn, "", oper.OperId, oper.Sign, oper.Sk, oper.Prty, oper.SQ,
                        oper.ExtSignHex, oper.IntSignHex, AfterPayProcCall, BeforePayProcCall);

                // set crypto module, if mixed mode on
                ourDoc.CryptoModule = data[43];
                // set key hash
                //ourDoc.KeyHash = data[44];

                if (TT_Flags[58] == '1')
                    ourDoc.Nom = Convert.ToDecimal((data[30] != "") ? (data[30]) : ("0"), cinfo) * kopA;

                #region Обработка доп. реквизитов

                string[] items = data[26].Replace("reqv_", "").Split(',');
                for (int i = 0; i < items.Length - 1; i++)
                {
                    //для обычных допреквизитов заполняем массив
                    if (!string.IsNullOrEmpty(tags[i]) && items[i] != "f" && items[i] != "n$" && items[i] != "ф$")
                        ourDoc.DrecS.Add(new cDoc.Tags(items[i], tags[i].Replace("\n", "\r\n")));
                    else if (items[i] == "n$")
                        ourDoc.DrecS.Add(new cDoc.Tags("n", tags[i].Replace("\n", "\r\n")));
                    else if (items[i] == "ф$")
                        ourDoc.DrecS.Add(new cDoc.Tags("ф", tags[i].Replace("\n", "\r\n")));
                }
                // Drec
                if (!string.IsNullOrEmpty(data[38]))
                    ourDoc.Drec = data[38];
                // Sub Account
                if (!string.IsNullOrEmpty(data[42]))
                    ourDoc.SubAccount = data[42];


                // режим сохранние реквизитов для последующих операций (префик ka - keep attributtes)
                var keys = new ArrayList(Session.Keys);
                foreach (string key in keys)
                {
                    if (key.StartsWith("ka_"))
                        Session.Remove(key);
                }
                if (data.Length > 45 && data[45] == "1")
                {
                    Session["ka_Enable"] = "true";
                    Session["ka_Nazn"] = oper.Nazn;
                    foreach (var elem in ourDoc.DrecS)
                    {
                        var tag = (cDoc.Tags)elem;
                        Session["ka_" + tag.Tag] = tag.Val;
                    }
                }

                #endregion
                if (Bars.Configuration.ConfigurationSettings.AppSettings["Crypto.DebugMode"] == "1")
                {
                    try
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        if (!string.IsNullOrEmpty(oper.IntSignHex))
                        {
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("p_ref", OracleDbType.Decimal, oper.Ref, ParameterDirection.Input);
                            cmd.Parameters.Add("p_level", OracleDbType.Decimal, 0, ParameterDirection.Input);
                            cmd.Parameters.Add("p_key_id", OracleDbType.Varchar2, oper.OperId, ParameterDirection.Input);
                            cmd.Parameters.Add("p_sign_mode", OracleDbType.Varchar2, "sign", ParameterDirection.Input);
                            cmd.Parameters.Add("p_buffer_type", OracleDbType.Varchar2, "int", ParameterDirection.Input);
                            cmd.Parameters.Add("p_buffer_hex", OracleDbType.Varchar2, data[39], ParameterDirection.Input);
                            cmd.Parameters.Add("p_sign_hex", OracleDbType.Varchar2, oper.IntSignHex, ParameterDirection.Input);
                            cmd.Parameters.Add("p_verify_status", OracleDbType.Decimal, null, ParameterDirection.Input);
                            cmd.Parameters.Add("p_verify_error", OracleDbType.Varchar2, null, ParameterDirection.Input);
                            cmd.CommandText = "sgn_mgr.trace_sign";
                            cmd.ExecuteNonQuery();
                        }
                        if (!string.IsNullOrEmpty(oper.ExtSignHex))
                        {
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("p_ref", OracleDbType.Decimal, oper.Ref, ParameterDirection.Input);
                            cmd.Parameters.Add("p_level", OracleDbType.Decimal, 0, ParameterDirection.Input);
                            cmd.Parameters.Add("p_key_id", OracleDbType.Varchar2, oper.OperId, ParameterDirection.Input);
                            cmd.Parameters.Add("p_sign_mode", OracleDbType.Varchar2, "sign", ParameterDirection.Input);
                            cmd.Parameters.Add("p_buffer_type", OracleDbType.Varchar2, "ext", ParameterDirection.Input);
                            cmd.Parameters.Add("p_buffer_hex", OracleDbType.Varchar2, data[40], ParameterDirection.Input);
                            cmd.Parameters.Add("p_sign_hex", OracleDbType.Varchar2, oper.ExtSignHex, ParameterDirection.Input);
                            cmd.Parameters.Add("p_verify_status", OracleDbType.Decimal, null, ParameterDirection.Input);
                            cmd.Parameters.Add("p_verify_error", OracleDbType.Varchar2, null, ParameterDirection.Input);
                            cmd.CommandText = "sgn_mgr.trace_sign";
                            cmd.ExecuteNonQuery();
                        }
                    }
                    catch (Exception ex)
                    {
                        _dbLogger.Exception(ex);
                    }
                }

                /// Якщо це чек - платимо по-іншому
                if (TT_Flags[61] == '1')
                {
                    oper.check_tt = "ЧЕК";

                    bool txCommitted = false;

                    OracleTransaction tx = oper.con.BeginTransaction();
                    Decimal parent_ref = 0;
                    Decimal linked_ref = 0;
                    Decimal return_ref = 0;

                    try
                    {
                        ArrayList drecs = ourDoc.DrecS;
                        if (ourDoc.oDocument())
                        {
                            parent_ref = oper.Ref;
                            return_ref = oper.Ref;
                            Session["REF"] = oper.Ref.ToString();
                            _dbLogger.Financial("Ввод док Ref" + oper.Ref + ": " + oper.NlsA + "(" + oper.KvA + ") " + oper.SA.ToString("F0") + " -> " + oper.BankB + " " + oper.NlsB + "(" + oper.KvB + ") " + oper.SB.ToString("F0") + "[" + oper.NamB + "],[" + oper.Nazn + "] " + oper.OperId);

                            Bars.LinkDocs.LinkedDocs l_docs = new LinkedDocs();
                            List<LinkedDocs> l_doc_list = l_docs.SelectDocs();

                            if (l_doc_list.Count == 0)
                                l_doc_list = checkDocsList;

                            if (l_doc_list.Count == 0)
                                throw new BarsException("Не передано платежів по чекам. Спробуйте повторити ввід платежу.");

                            for (int i = 0; i < l_doc_list.Count; i++)
                            {
                                Bars.DocHand.cDocHandler.Reference r =
                                    new Bars.DocHand.cDocHandler.Reference(HttpContext.Current);

                                oper.Ref = Convert.ToInt64(r.Ref);

                                Bars.DocHand.cDocHandler.Saldo sal =
                                    new Bars.DocHand.cDocHandler.Saldo(HttpContext.Current,
                                    l_doc_list[i].Nls,
                                    Convert.ToString(oper.KvA),
                                    Convert.ToString(oper.Dk),
                                    oper.check_tt);

                                oper.OkpoA = sal.Okpo;

                                ourDoc = new cDoc(oper.con, oper.Ref, oper.check_tt, oper.Dk, oper.Vob,
                                        oper.Nd, oper.DatD, oper.DatP, oper.DatV1, oper.DatV2,
                                        oper.NlsA, oper.NamA, oper.BankA, "", oper.KvA, Convert.ToDecimal(l_doc_list[i].S) * 100, oper.OkpoA,
                                        oper.NlsB, oper.NamB, oper.BankB, "", oper.KvB, Convert.ToDecimal(l_doc_list[i].S) * 100, oper.OkpoB,
                                        l_doc_list[i].Nazn, "", oper.OperId, oper.Sign, Convert.ToByte(l_doc_list[i].Sk), oper.Prty, 0,
                                        oper.ExtSignHex, oper.IntSignHex, AfterPayProcCall, BeforePayProcCall);
                                ourDoc.DrecS.AddRange(drecs);
                                ourDoc.oDocument();

                                _dbLogger.Financial("Ввод чека ref=" + oper.Ref + ": " + oper.NlsA + "(" + oper.KvA + ") " + oper.SA.ToString("F0") + " -> " + oper.BankB + " " + oper.NlsB + "(" + oper.KvB + ") " + oper.SB.ToString("F0") + "[" + oper.NamB + "],[" + oper.Nazn + "] " + oper.OperId);

                                linked_ref = oper.Ref;

                                ourDoc.LinkDoc(parent_ref, linked_ref);

                                parent_ref = linked_ref;
                            }

                            tx.Commit();
                            txCommitted = true;

                            return return_ref.ToString();
                        }
                    }
                    finally
                    {
                        if (!txCommitted)
                            tx.Rollback();
                    }
                }
                else
                {
                    if (ourDoc.oDoc())
                    {
                        Session["REF"] = oper.Ref.ToString();
                        // Протоколируем буфер для рабора проблем с проверкой ЕЦП
                        if (!string.IsNullOrEmpty(data[39]) || !string.IsNullOrEmpty(data[40]))
                        {
                            string buffer = "DOC_BUFFER::REF={0}\nINT=|{1}|=\nEXT=|{2}|=";
                            _dbLogger.Info(string.Format(buffer, oper.Ref.ToString(), HttpUtility.UrlDecode(data[39], System.Text.Encoding.UTF8), HttpUtility.UrlDecode(data[40], System.Text.Encoding.UTF8)));
                        }
                       

                        _dbLogger.Financial("Ввод док Ref" + oper.Ref + ": " + oper.NlsA + "(" + oper.KvA + ") " + oper.SA.ToString("F0") + " -> " + oper.BankB + " " + oper.NlsB + "(" + oper.KvB + ") " + oper.SB.ToString("F0") + "[" + oper.NamB + "],[" + oper.Nazn + "] " + oper.OperId);
                        return oper.Ref.ToString();
                    }
                }
            }
            finally
            {
                if (ConnectionState.Open == oper.con.State) oper.con.Close();
                oper.con.Dispose();
            }
            return "";
        }

        [WebMethod(EnableSession = true)]
        public string GetFileForPrint(string refernce, bool printTrnModel)
        {
            return GetArrayFileForPrint(new[] { refernce }, printTrnModel);
        }
      
        /// <summary>
        /// Генерируем текстовый файл тикета 
        /// </summary>
        /// <param name="refernce">референс документа</param>
        /// <returns>полный путь к файлу</returns>
        [WebMethod(EnableSession = true)]
        public string GetArrayFileForPrint(string[] refernce, bool printTrnModel)
        {
            const string fileNameSpliter = "~~$$~~";
            string result = "";
            string res = "0";
            string pdfFileName = "/barsroot/documentview/default.aspx?ref={0}&typePrint=pdf&printModel=" +
                           (printTrnModel ? "1" : "0") + "&rnd=" + new Random().Next(1000) + "&printnoconfirm={1}";
            string tiketFileName = "";
            string refPdf = "";
            bool userPrintPdf = GetFlagUserPrintPdf();
            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            try
            {
                foreach (var item in refernce)
                {
                    var filePdfName = GetPdfFileName(Convert.ToDecimal(item));
                    if (userPrintPdf && !string.IsNullOrEmpty(filePdfName))
                    {
                        OracleCommand cmd = new OracleCommand("select flags from tts where tt=(select tt from oper where ref=:p_ref)", con);
                        try
                        {
                            cmd.Parameters.Add("p_ref", OracleDbType.Decimal, Convert.ToDecimal(item),
                                ParameterDirection.Input);
                            var s = Convert.ToString(cmd.ExecuteScalar());
                            if (s.Substring(45, 1) == "1") res = "1";
                        }
                        finally
                        {
                            cmd.Dispose();
                        }
                        refPdf += string.IsNullOrEmpty(refPdf) ? item : "," + item;
                    }
                    else
                    {
                        OracleConnection thisConn = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                        cDocPrint ourTick = new cDocPrint(thisConn, long.Parse(item), Server.MapPath("/TEMPLATE.RPT/"),
                            printTrnModel);
                        tiketFileName += string.IsNullOrEmpty(tiketFileName)
                            ? ourTick.GetTicketFileName()
                            : fileNameSpliter + ourTick.GetTicketFileName();
                    }
                }
            }
            finally
            {
                con.Close();
                con.Dispose();
            }


            result += string.IsNullOrEmpty(refPdf) ? "" : string.Format(pdfFileName, refPdf, res);
            if (!string.IsNullOrEmpty(tiketFileName))
                result += string.IsNullOrEmpty(result) ? tiketFileName : fileNameSpliter + tiketFileName;
            return result;
        }

        [WebMethod(EnableSession = true)]
        public string ExportExcel(string[] data, bool? forceExecute=null)
        {
            //Form SQL QUERY FOR EXEL IMPORT
            InitOraConnection(Context);

            string role = "";
            switch (data[12])
            {
                case "0":
                    role = "WR_DOCLIST_TOBO";
                    break;
                case "1":
                    role = "WR_DOCLIST_USER";
                    break;
                case "2":
                    role = "WR_DOCLIST_SALDO";
                    break;
                default:
                    throw new Exception("Страница вызвана без необходимого параметра!");
            }

            SetRole(role);
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
            cinfo.DateTimeFormat.DateSeparator = ".";

            string dateFilter = "";
            if (!string.IsNullOrEmpty(data[9]) && !string.IsNullOrEmpty(data[10]))
            {
                // для оптимизации подставляем в виде констант
                dateFilter = String.Format(" a.PDAT >= to_date('{0}', 'dd.mm.yyyy') and a.PDAT < (to_date('{1}', 'dd.mm.yyyy')+1) ", data[9], data[10]);
            }
            else if (data[10] != "")
            {
                // для оптимизации подставляем в виде констант
                dateFilter = String.Format(" a.PDAT >= to_date('{0}', 'dd.mm.yyyy') ", data[9]);
            }
            else
            {
                dateFilter = " a.PDAT >= trunc(sysdate) and a.PDAT < (trunc(sysdate)+1) ";
            }
            string sql = "";

            if (data[11] != "V_DOCS_SALDO")
            {
                sql = "   a.REF \"Референс документа\", " +
                "a.TT \"Код операції\", " +
                "a.USERID \"Виконавець\", " +
                "a.ND \"Номер документа\", " +
                "a.MFOA \"МФО відправника\", " +
                "a.NLSA \"Рахунок-А\", " +
                "a.S_  \"Сума у валюті відправника\", " +
                "a.LCV  \"Валюта відправника\",  " +
                "a.VDAT  \"Дата валютування\", " +
                "a.S2_ \"Сума у валюті одержувача\", " +
                "a.LCV2  \"Валюта одержувача\", " +
                "a.MFOB  \"МФО одержувача\", " +
                "a.NLSB  \"Рахунок-В\", " +
                "a.DK  \"Д/К\", " +
                "a.SK  \"СКП\", " +
                "a.DATD  \"Дата документа\", " +
                "a.NAZN  \"Призначення платежу\", " +
                "a.TOBO  \"Код безбалансового відділення\", " +
                "a.ID_A  \"ОКПО відправника\", " +
                "a.NAM_A  \"Назва відправника\", "+
                "a.ID_B  \"ОКПО отримувача\", " +
                "a.NAM_B  \"Назва отримувача\" ";
            }
            else
                sql = "   a.REF \"Референс документа\", " +
                    "a.TT \"Код операції\", " +
                    "a.USERID \"Виконавець\", " +
                    "a.ND \"Номер документа\", " +
                    "a.MFOA \"МФО відправника\", " +
                    "a.NLSA \"Рахунок-А\", " +
                    //"a.ID_A  \"Референс документа\", " +
                    //"a.NAM_A  \"Референс документа\", " +
                    "a.S_  \"Сума у валюті відправника\", " +
                    "a.LCV  \"Валюта відправника\",  " +
                    "to_char(a.VDAT,'dd.mm.yyyy')  \"Дата валютування\", " +
                    "a.S2_ \"Сума у валюті одержувача\", " +
                    "a.LCV2  \"Валюта одержувача\", " +
                    "a.MFOB  \"МФО одержувача\", " +
                    "a.NLSB  \"Рахунок-В\", " +
                    //"a.ID_B  \"Референс документа\", " +
                    //"a.NAM_B  \"Референс документа\", " +
                    "a.DK  \"Д/К\", " +
                    "a.SK  \"СКП\", " +
                    "to_char(a.DATD,'dd.mm.yyyy')  \"Дата документа\", " +
                    "a.NAZN  \"Призначення платежу\", " +
                    "a.TOBO  \"Код безбалансового відділення\" ";
                    //", a.SOS  \"Референс документа\" ";
            string localBD = Convert.ToString(Session["LocalBDate"]);


            //string query = BuildSelectStatementForTable(sql, data[11] + " a", dateFilter, data);

            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////

            if (false == forceExecute)
            {
                string sql1 = BuildSelectStatementForTable(sql, data[11] + " a", dateFilter, data);
                sql1 = sql1.Replace(sql, " count(1) ");
                int entriesAmount;
                int.TryParse(SQL_SELECT_scalar(sql1).ToString(), out entriesAmount);
                if (entriesAmount > 2000)
                {
                    return entriesAmount.ToString();
                }
            }

            DataSet ds = GetFullDataSetForTable(sql, data[11] + " a", dateFilter, data);

            #region Using ExcelHelper
            List<string> moneyWildcards = new List<string> { "оборот", "кредит", "дебет", "залишок", "сума" };

            List<int> moneyColumns = new List<int>();
            for (int i = 0, max = ds.Tables[0].Columns.Count; i < max; i++)
            {
                foreach (var mw in moneyWildcards)
                {
                    if (ds.Tables[0].Columns[i].Caption.ToLower().Contains(mw.ToLower()))
                    {
                        moneyColumns.Add(i + 1);
                    }
                }
            }

            var rep = new RegisterCountsDPARepository();
            var userInf = rep.GetPrintHeader();

            string fileXls = Path.GetTempFileName() + ".xls";


            List<Dictionary<string, object>> res = new List<Dictionary<string, object>>();

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                Dictionary<string, object> row = new Dictionary<string, object>();
                for (int j = 0; j < ds.Tables[0].Columns.Count; j++)
                {
                    string key = ds.Tables[0].Columns[j].Caption;
                    var value = ds.Tables[0].Rows[i][j];
                    row[key] = value;
                }
                res.Add(row);
            }

            List<string[]> title = new List<string[]>();
            for (int i = 0; i < ds.Tables[0].Columns.Count; i++)
            {
                title.Add(new string[] { ds.Tables[0].Columns[i].ColumnName, ds.Tables[0].Columns[i].Caption });
            }

            List<TableInfo> tableInfo = new List<TableInfo>();
            for (int i = 0; i < ds.Tables[0].Columns.Count; i++)
            {
                string colDataType = string.Empty;
                int exelRowNum = i + 1;
                if (moneyColumns.Contains(exelRowNum))
                {
                    colDataType = "Money";
                }
                else
                {
                    colDataType = ds.Tables[0].Columns[i].DataType.FullName;
                }

                tableInfo.Add(new TableInfo(ds.Tables[0].Columns[i].ColumnName, ds.Tables[0].Columns[i].MaxLength, colDataType, ds.Tables[0].Columns[i].AllowDBNull));
            }

            List<string> hat = new List<string>
            {
                "АТ 'ОЩАДБАНК'",
                "Користувач:" + userInf.USER_NAME,
                "Дата: " + userInf.DATE.ToString("dd'.'MM'.'yyyy") + " Час: " + userInf.DATE.Hour + ":" + userInf.DATE.Minute + ":" + userInf.DATE.Second
            };
            var excel = new ExcelHelpers<List<Dictionary<string, object>>>(res, title, tableInfo, null, hat);

            using (MemoryStream ms = excel.ExportToMemoryStream())
            {
                ms.Position = 0;
                File.WriteAllBytes(fileXls, ms.ToArray());
            }
            return fileXls;
            #endregion
        }

        [WebMethod(EnableSession = true)]
        public string TransNazn(string Nazn, string TT, string NlsA, string BankA, string KvA, string SumA, string NlsB, string BankB, string KvB, string SumB, string ND)
        {
            string result = Nazn;

            int index_start = result.IndexOf("?");
            if (index_start != -1 || result.IndexOf("#{") != -1)
            {
                IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
                OracleConnection con = conn.GetUserConnection(Context);
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();
                try
                {
                    while (index_start != -1)
                    {
                        int index_end = result.IndexOf(" ", index_start);
                        string id = string.Empty;
                        if (index_end == -1)
                            id = result.Substring(index_start + 1);
                        else
                            id = result.Substring(index_start + 1, index_end - index_start - 1);
                        if (id.Trim().Length > 0 && id.Trim().Length <= 2)
                        {
                            cmd.CommandText = "SELECT TRIM(txt) FROM tnaznf WHERE n=" + id;
                            string res = Convert.ToString(cmd.ExecuteScalar());
                            if (null != res || string.Empty != res)
                                result = result.Replace("?" + id, "#{" + res + "}");
                        }
                        index_start = result.IndexOf("?", index_start + 1);
                    }

                    result = result.Replace("#(TT)", TT);
                    result = result.Replace("#(S)", SumA);
                    result = result.Replace("#(S2)", SumB);
                    result = result.Replace("#(NLSA)", NlsA);
                    result = result.Replace("#(NLSB)", NlsB);
                    result = result.Replace("#(MFOA)", BankA);
                    result = result.Replace("#(MFOB)", BankB);
                    result = result.Replace("#(KVA)", KvA);
                    result = result.Replace("#(KVB)", KvB);
                    result = result.Replace("#(ND)", ND);

                    index_start = result.IndexOf("#{");
                    OracleDataAdapter adapter = new OracleDataAdapter();
                    adapter.SelectCommand = cmd;
                    while (index_start != -1)
                    {
                        int index_end = result.IndexOf("}", index_start);
                        string formula = result.Substring(index_start + 2, index_end - index_start - 2);
                        string text = "select " + formula + " from dual";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "exec_refcursor";

                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("sql_str", OracleDbType.Varchar2, text, ParameterDirection.Input);
                        cmd.Parameters.Add("param", OracleDbType.Varchar2, null, ParameterDirection.Input);
                        cmd.Parameters.Add("P_CURSOR", OracleDbType.RefCursor, 2000, ParameterDirection.Output);
                        DataSet ds = new DataSet();
                        adapter.Fill(ds);

                        string res = Convert.ToString(ds.Tables[0].Rows[0][0]);
                        if (null != res && string.Empty != res)
                            result = result.Replace("#{" + formula + "}", res);
                        cmd.Parameters.Clear();

                        index_start = result.IndexOf("#{", index_start + 2);
                    }
                }
                finally
                {
                    con.Close();
                    cmd.Dispose();
                    con.Dispose();
                }
            }
            else
            {
                result = result.Replace("#(TT)", TT);
                result = result.Replace("#(S)", SumA);
                result = result.Replace("#(S2)", SumB);
                result = result.Replace("#(NLSA)", NlsA);
                result = result.Replace("#(NLSB)", NlsB);
                result = result.Replace("#(MFOA)", BankA);
                result = result.Replace("#(MFOB)", BankB);
                result = result.Replace("#(KVA)", KvA);
                result = result.Replace("#(KVB)", KvB);
                result = result.Replace("#(ND)", ND);
            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        public bool PaymentVerificationTT(string tt)
        {
            return PAY_VERIF_TT.Contains(tt);

            //bool result = false;
            //IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            //OracleConnection con = new OracleConnection();
            //OracleCommand cmd = new OracleCommand();
            //try
            //{
            //    con = conn.GetUserConnection(Context);
            //    cmd = con.CreateCommand();

            //    cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
            //    cmd.ExecuteNonQuery();

            //    cmd.Parameters.Add("p_tt", OracleDbType.Varchar2, tt, ParameterDirection.Input);
            //    cmd.CommandText = @"select tt from teller_tt where tt = :p_tt";
            //    OracleDataReader reader = cmd.ExecuteReader();
            //    result = reader.HasRows;
            //}
            //finally
            //{
            //    con.Close();
            //    cmd.Dispose();
            //    con.Dispose();
            //}
            //return result;
        }

        [WebMethod(EnableSession = true)]
        public string FormulaCalc(string Formula, string[] pars, string[] vals)
        {
            string result = string.Empty;
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection con = new OracleConnection();
            OracleCommand cmd = new OracleCommand();
            try
            {
                con = conn.GetUserConnection(Context);
                cmd = con.CreateCommand();
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                if (Formula.StartsWith("#"))
                {
                    Formula = Formula.Substring(2);
                    Formula = Formula.Substring(0, Formula.Length - 1);
                }
                for (int i = 0; i < pars.Length; i++)
                {
                    string par = pars[i];
                    string val = "'" + vals[i] + "'";
                    Formula = Formula.Replace("#(" + par + ")", val);
                }

                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = cmd;

                string text = "select " + Formula + " from dual";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "exec_refcursor";

                cmd.Parameters.Clear();
                cmd.Parameters.Add("sql_str", OracleDbType.Varchar2, text, ParameterDirection.Input);
                cmd.Parameters.Add("param", OracleDbType.Varchar2, null, ParameterDirection.Input);
                cmd.Parameters.Add("P_CURSOR", OracleDbType.RefCursor, 2000, ParameterDirection.Output);
                DataSet ds = new DataSet();
                adapter.Fill(ds);
                if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    result = Convert.ToString(ds.Tables[0].Rows[0][0]);
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        public decimal TransNom(string Formula, string Nom, string TT, string NlsA, string BankA, string KvA, string SumA, string NlsB, string BankB, string KvB, string SumB, string ND)
        {
            string strNom = Formula;
            decimal result = 0;
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection con = new OracleConnection();
            OracleCommand cmd = new OracleCommand();
            try
            {
                con = conn.GetUserConnection(Context);
                cmd = con.CreateCommand();
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                strNom = strNom.Replace("#(NOM)", Nom);
                strNom = strNom.Replace("#(TT)", TT);
                strNom = strNom.Replace("#(S)", SumA);
                strNom = strNom.Replace("#(S2)", SumB);
                strNom = strNom.Replace("#(NLSA)", NlsA);
                strNom = strNom.Replace("#(NLSB)", NlsB);
                strNom = strNom.Replace("#(MFOA)", BankA);
                strNom = strNom.Replace("#(MFOB)", BankB);
                strNom = strNom.Replace("#(KVA)", KvA);
                strNom = strNom.Replace("#(KVB)", KvB);
                strNom = strNom.Replace("#(ND)", ND);


                cmd.CommandText = "begin DOC_STRANS(:text_,:res_);end;";
                cmd.Parameters.Add("text_", OracleDbType.Varchar2, "SELECT " + strNom.ToString() + " FROM dual", ParameterDirection.Input);
                cmd.Parameters.Add("res_", OracleDbType.Decimal, 0, ParameterDirection.Output);

                cmd.ExecuteNonQuery();
                result = Convert.ToDecimal(cmd.Parameters["res_"].Value.ToString(), cinfo);
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
            return result;
        }

        public class ReqvInfo
        {
            public string Name { get; set; }
            public string Value { get; set; }
            public bool IsEdit { get; set; }
            public bool IsEmpty { get; set; }
        }

        [WebMethod(EnableSession = true)]
        public List<ReqvInfo> CheckKodN(string tt, string kodN)
        {
            var validatedParams = new List<ReqvInfo>();
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection con = new OracleConnection();
            OracleCommand cmd = new OracleCommand();
            try
            {
                con = conn.GetUserConnection(Context);
                cmd = con.CreateCommand();
                cmd.Parameters.Add("tt", OracleDbType.Varchar2, tt, ParameterDirection.Input);
                cmd.Parameters.Add("kodN", OracleDbType.Varchar2, kodN, ParameterDirection.Input);
                cmd.CommandText = "select * from V_PARAMS_PRIME_LOAD t where t.tt=:tt and :kodN like t.N_VALUE and t.N_VALUE is not null and tag!='KOD_N'";
                OracleDataReader oraReader = cmd.ExecuteReader();
                while (oraReader.Read())
                {
                    var paramName = Convert.ToString(oraReader["TAG"]).ToUpper();
                    var paramValue = Convert.ToString(oraReader["VALUE"]);
                    var isParamEmpty = Convert.ToString(oraReader["IS_EMPTY"]) == "1";
                    var isParamEdit = Convert.ToString(oraReader["IS_EDIT"]) == "1";
                    validatedParams.Add(new ReqvInfo() { Name = paramName, Value = paramValue, IsEdit = isParamEdit, IsEmpty = isParamEmpty });
                }
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
            return validatedParams;
        }

        [WebMethod(EnableSession = true)]
        public string[] SelectPodotw(string id, int mode)
        {
            string[] result = new string[10];
            result[0] = "0";
            string podt_id = string.Empty;
            try
            {
                InitOraConnection();
                SetRole("WR_DOC_INPUT");
                if (mode == 0)
                {
                    SetParameters("nls", DB_TYPE.Varchar2, id, DIRECTION.Input);
                    int count = Convert.ToInt32(SQL_SELECT_scalar("SELECT count(*) FROM podotw WHERE tag='NLS' AND val=:nls"));
                    if (count == 1)
                        podt_id = Convert.ToString(SQL_SELECT_scalar("SELECT id FROM podotw WHERE tag='NLS' AND val=:nls"));
                    result[0] = count.ToString();
                }
                else
                {
                    podt_id = id;
                }
                if (!string.IsNullOrEmpty(podt_id))
                {
                    ClearParameters();
                    SetParameters("id", DB_TYPE.Decimal, podt_id, DIRECTION.Input);
                    SQL_Reader_Exec("select tag,val from podotw where id=:id");
                    int index = 1;
                    while (SQL_Reader_Read())
                    {
                        ArrayList reader = SQL_Reader_GetValues();
                        result[index++] = Convert.ToString(reader[0]) + "=" + Convert.ToString(reader[1]);
                    }
                    SQL_Reader_Close();
                }
            }
            finally
            {
                DisposeOraConnection();
            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        public void SaveCurRates(string[] data)
        {
            try
            {
                InitOraConnection();
                SetRole("WR_DOC_INPUT");

                string update_query = "UPDATE v_tobo_currates set rate_b=:rate_b,rate_s=:rate_s,bsum=:bsum where kv=:kv";
                string insert_query = "INSERT into v_tobo_currates(rate_b,rate_s,bsum,kv,vdate,tobo) VALUES(:rate_b,:rate_s,:bsum,:kv,web_utl.get_bankdate,tobopack.gettobo)";
                int status = 0;
                string str_log = "курсы:";

                for (int i = 0; i < 12; i += 4)
                {
                    if (data[i] != string.Empty && data[i + 1] != string.Empty)
                    {
                        ClearParameters();
                        SetParameters("rate_b", DB_TYPE.Decimal, data[i], DIRECTION.Input);
                        SetParameters("rate_s", DB_TYPE.Decimal, data[i + 1], DIRECTION.Input);
                        SetParameters("bsum", DB_TYPE.Decimal, data[i + 2], DIRECTION.Input);
                        SetParameters("kv", DB_TYPE.Decimal, data[i + 3], DIRECTION.Input);
                        str_log += " kv=" + data[i + 3] + "(покупка=" + data[i] + ",продажа=" + data[i + 1] + ");";
                        status = SQL_NONQUERY(update_query);
                        if (status == 0)
                        {
                            SQL_NONQUERY(insert_query);
                        }
                    }
                }
                SetRole("BASIC_INFO");
                ArrayList reader = SQL_reader("select user_id,tobopack.gettobo from dual");
                _dbLogger.Info("Установка курса валют в отделеннии №" + reader[1] + " пользователем №" + reader[0] + ", " + str_log, "WEB_CURR");
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        [WebMethod(EnableSession = true)]
        public void InsertAttr(string[] data)
        {
            try
            {
                InitOraConnection();
                SetRole("WR_DOC_INPUT");
                int status = 0;
                string nazn = string.Empty;
                if (data.Length == 6)
                {
                    SetParameters("nb", DB_TYPE.Varchar2, data[2], DIRECTION.Input);
                    SetParameters("okpo", DB_TYPE.Varchar2, data[3], DIRECTION.Input);
                    SetParameters("mfo", DB_TYPE.Varchar2, data[1], DIRECTION.Input);
                    SetParameters("kv", DB_TYPE.Decimal, data[4], DIRECTION.Input);
                    SetParameters("nls", DB_TYPE.Varchar2, data[0], DIRECTION.Input);
                    status = SQL_NONQUERY("update alien set name=:nb,okpo=:okpo where mfo=:mfo and kv=:kv and nls=:nls and id=user_id");
                    if (status == 0)
                    {
                        SQL_NONQUERY("INSERT INTO alien (name,okpo,mfo,kv,nls,id) VALUES (:nb,:okpo,:mfo,:kv,:nls,user_id)");
                    }
                    nazn = data[5];
                }
                else
                    nazn = data[0];
                ClearParameters();
                SetParameters("nazn", DB_TYPE.Varchar2, nazn, DIRECTION.Input);
                status = Convert.ToInt32(SQL_SELECT_scalar("select count(np) from np where id=user_id and np=:nazn"));
                if (status == 0)
                {
                    SQL_NONQUERY("INSERT INTO np(id,np) values(user_id,:nazn)");
                }
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        [WebMethod(EnableSession = true)]
        public string CheckDopReq(string Checker, string Tag, string Val, string TT, string NlsA, string BankA, string KvA, string SA, string NlsB, string BankB, string KvB, string SB)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection con = conn.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                string sql = Checker;
                sql = sql.Replace("#(TAG)", "'" + Tag + "'");
                sql = sql.Replace("#(VAL)", "'" + Val + "'");
                sql = sql.Replace("#(S)", "'" + SA + "'");
                sql = sql.Replace("#(S2)", "'" + SB + "'");
                sql = sql.Replace("#(NLSA)", "'" + NlsA + "'");
                sql = sql.Replace("#(NLSB)", "'" + NlsB + "'");
                sql = sql.Replace("#(MFOA)", "'" + BankA + "'");
                sql = sql.Replace("#(MFOB)", "'" + BankB + "'");
                sql = sql.Replace("#(KVA)", "'" + KvA + "'");
                sql = sql.Replace("#(KVB)", "'" + KvB + "'");
                sql = sql.Replace("#(TT)", "'" + TT + "'");

                OracleDataAdapter adapter = new OracleDataAdapter();
                adapter.SelectCommand = cmd;

                string text = "select " + sql + " from dual";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "exec_refcursor";

                cmd.Parameters.Clear();
                cmd.Parameters.Add("sql_str", OracleDbType.Varchar2, text, ParameterDirection.Input);
                cmd.Parameters.Add("param", OracleDbType.Varchar2, null, ParameterDirection.Input);
                cmd.Parameters.Add("P_CURSOR", OracleDbType.RefCursor, 2000, ParameterDirection.Output);
                DataSet ds = new DataSet();
                adapter.Fill(ds);
                string res = Convert.ToString(ds.Tables[0].Rows[0][0]);
                return res;
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
        }
       
        /// <summary>
        /// Метод получения данных для грида из функции доввода доп. реквизитов документа
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public object[] GetData_DocDrecs(string[] data)
        {
            try
            {
                InitOraConnection(Context);
                SetRole("WR_DOC_INPUT");
                return BindTableWithNewFilter(@"  
                    oper.ref as ref, oper.tt as tt, oper.userid as userid, oper.nlsa as nlsa, oper.s as s, v1.lcv as lcv, 
                    to_char(oper.vdat,'dd.mm.yyyy') as vdat, oper.s2 as s2, v2.lcv as lcv2,oper.mfob as mfob, oper.nlsb as nlsb, oper.dk as dk, 
                    oper.sk as sk, to_char(oper.datd,'dd.mm.yyyy') as datd, v1.dig as dig, v2.dig as dig2",
                    "oper, tabval v1, tabval v2", "oper.kv=v1.kv AND oper.kv2=v2.kv",
                data);
            }
            finally
            {
                DisposeOraConnection();
            }
        }
       
        /// <summary>
        /// Проверка кода валюты
        /// </summary>
        /// <param name="kv"></param>
        /// <param name="colname"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string[] checkKV(string kv, string colname)
        {
            string[] result = new string[3];
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection con = conn.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            OracleDataReader reader = null;
            try
            {
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();
                cmd.Parameters.Add("val", OracleDbType.Varchar2, kv.ToUpper(), ParameterDirection.Input);
                cmd.CommandText = "select kv,lcv,dig from tabval where " + colname + "=:val";
                reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    result[0] = Convert.ToString(reader.GetValue(0));
                    result[1] = Convert.ToString(reader.GetValue(1));
                    result[2] = Convert.ToString(reader.GetValue(2));
                }
                return result;
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
        }

        /// <summary>
        /// Сума прописью
        /// </summary>
        /// <param name="nKv"></param>
        /// <param name="nSum"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string getSumPr(decimal nKv, decimal nSum)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection con = conn.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();
                cmd.CommandText = "select f_sumpr(:nSum,:nKv,(select gender from tabval where kv=:nKv)) from dual";
                cmd.Parameters.Add("nSum", OracleDbType.Decimal, nSum, ParameterDirection.Input);
                cmd.Parameters.Add("nKv", OracleDbType.Decimal, nKv, ParameterDirection.Input);
                return Convert.ToString(cmd.ExecuteScalar());
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
        }

        /// <summary>
        /// Параметры для платежного поручения
        /// </summary>
        /// <param name="tt"></param>
        /// <param name="kv"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string[] getSwiftParam(string tt, decimal kv)
        {
            string[] result = new string[10];
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection con = conn.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                cmd.CommandText = "gl.ref";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("ref", OracleDbType.Decimal, 0, ParameterDirection.InputOutput);
                cmd.ExecuteNonQuery();
                result[0] = cmd.Parameters["ref"].Value.ToString();

                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("tt", OracleDbType.Char, tt, ParameterDirection.Input);
                cmd.CommandText = @"select flags||fli||flv,dk,docsign.GetIdOper,
                                   (select val from params where par='MFO') mfo,nlsb,mfob,
                                   docsign.GetSignType SIGNTYPE,
                                   (select nvl(val,'00') from params where par='REGNCODE') REGNCODE
                                    from tts where tt=:tt";

                OracleDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    result[1] = Convert.ToString(reader.GetValue(0));
                    result[2] = Convert.ToString(reader.GetValue(1));
                    result[3] = Convert.ToString(reader.GetValue(2));
                    result[4] = Convert.ToString(reader.GetValue(3));
                    result[5] = Convert.ToString(reader.GetValue(4));
                    result[6] = Convert.ToString(reader.GetValue(5));
                    result[7] = Convert.ToString(reader.GetValue(6));
                    result[8] = Convert.ToString(reader.GetValue(7));
                }

                return result;
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
        }



        /// <summary>
        /// Сохранение в справочник бенифициаров
        /// </summary>
        /// <param name="tt"></param>
        /// <param name="kv"></param>
        /// <returns></returns>
        /// <summary>
        [WebMethod(EnableSession = true)]
        public void saveBeneficiary(string nls, string name, string address)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection con = conn.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();
                cmd.Parameters.Add("nls", OracleDbType.Varchar2, nls, ParameterDirection.Input);
                cmd.CommandText = "select 1 from alien_sw where nls=:nls";
                if (Convert.ToString(cmd.ExecuteScalar()) == "1")
                {
                    cmd.CommandText = "update alien_sw set name=:name,address=:address where id = user_id and nls=:nls";
                }
                else
                {
                    cmd.CommandText = "insert into alien_sw(name,address,nls,id) values (:name,:address,:nls,user_id)";
                }
                cmd.Parameters.Clear();

                cmd.Parameters.Add("name", OracleDbType.Varchar2, name, ParameterDirection.Input);
                cmd.Parameters.Add("address", OracleDbType.Varchar2, address, ParameterDirection.Input);
                cmd.Parameters.Add("nls", OracleDbType.Varchar2, nls, ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
        }


        /// <summary>
        /// Сохранение в справочник данных о банке бенифициара
        /// </summary>
        /// <param name="nls"></param>
        /// <param name="name"></param>
        /// <param name="address"></param>
        [WebMethod(EnableSession = true)]
        public void saveBeneficiaryBank(string nls, string bic, string name, string address)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection con = conn.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();
                cmd.Parameters.Add("nls", OracleDbType.Varchar2, nls, ParameterDirection.Input);
                cmd.Parameters.Add("bic", OracleDbType.Varchar2, bic, ParameterDirection.Input);
                cmd.CommandText = "select 1 from v_alien_bank_sw where nls=:nls and bic=:bic";
                if (Convert.ToString(cmd.ExecuteScalar()) == "1")
                {
                    cmd.CommandText = "update v_alien_bank_sw set name=:name,address=:address where nls=:nls and bic=:bic";
                }
                else
                {
                    cmd.CommandText = "insert into v_alien_bank_sw(name,address,nls,bic) values (:name,:address,:nls,:bic)";
                }
                cmd.Parameters.Clear();

                cmd.Parameters.Add("name", OracleDbType.Varchar2, name, ParameterDirection.Input);
                cmd.Parameters.Add("address", OracleDbType.Varchar2, address, ParameterDirection.Input);
                cmd.Parameters.Add("nls", OracleDbType.Varchar2, nls, ParameterDirection.Input);
                cmd.Parameters.Add("bic", OracleDbType.Varchar2, bic, ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
        }

        [WebMethod(EnableSession = true)]
        public string PayDocSwift(string[] data, string[] tags, string[] swfields)
        {
            string refDoc = PayDoc(data, tags, null);
            swfields[0] = refDoc;
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection con = conn.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                cmd.CommandText = @"insert into sw_template(ref,nd,datd,kv,s,sw50nls,sw50name,sw50address,sw56bic,sw56name,sw57nls,sw57bic,sw57name,sw57address,sw59nls,sw59name,sw59address,sw70nazn,sw70flag,sw71charge,tt,kod_g,okpo,swbankord,swbankben,swterm,swother,sumstr,user_id)
                                    values (:ref,:nd,:datd,:kv,:s,:sw50nls,:sw50name,:sw50address,:sw56bic,:sw56name,:sw57nls,:sw57bic,:sw57name,:sw57address,:sw59nls,:sw59name,:sw59address,:sw70nazn,:sw70flag,:sw71charge,:tt,:kod_g,:okpo,:swbankord,:swbankben,:swterm,:swother,:sumstr,user_id)";

                cmd.Parameters.Add("ref", OracleDbType.Decimal, swfields[0], ParameterDirection.Input);
                cmd.Parameters.Add("nd", OracleDbType.Varchar2, swfields[1], ParameterDirection.Input);
                cmd.Parameters.Add("datd", OracleDbType.Date, Convert.ToDateTime(swfields[2], cinfo), ParameterDirection.Input);
                cmd.Parameters.Add("kv", OracleDbType.Decimal, swfields[3], ParameterDirection.Input);
                cmd.Parameters.Add("s", OracleDbType.Decimal, swfields[4], ParameterDirection.Input);
                cmd.Parameters.Add("sw50nls", OracleDbType.Varchar2, swfields[5], ParameterDirection.Input);
                cmd.Parameters.Add("sw50name", OracleDbType.Varchar2, swfields[6], ParameterDirection.Input);
                cmd.Parameters.Add("sw50address", OracleDbType.Varchar2, swfields[7], ParameterDirection.Input);
                cmd.Parameters.Add("sw56bic", OracleDbType.Varchar2, swfields[8], ParameterDirection.Input);
                cmd.Parameters.Add("sw56name", OracleDbType.Varchar2, swfields[9], ParameterDirection.Input);
                cmd.Parameters.Add("sw57nls", OracleDbType.Varchar2, swfields[10], ParameterDirection.Input);
                cmd.Parameters.Add("sw57bic", OracleDbType.Varchar2, swfields[11], ParameterDirection.Input);
                cmd.Parameters.Add("sw57name", OracleDbType.Varchar2, swfields[12], ParameterDirection.Input);
                cmd.Parameters.Add("sw57address", OracleDbType.Varchar2, swfields[13], ParameterDirection.Input);
                cmd.Parameters.Add("sw59nls", OracleDbType.Varchar2, swfields[14], ParameterDirection.Input);
                cmd.Parameters.Add("sw59name", OracleDbType.Varchar2, swfields[15], ParameterDirection.Input);
                cmd.Parameters.Add("sw59address", OracleDbType.Varchar2, swfields[16], ParameterDirection.Input);
                cmd.Parameters.Add("sw70nazn", OracleDbType.Varchar2, swfields[17], ParameterDirection.Input);
                cmd.Parameters.Add("sw70flag", OracleDbType.Decimal, swfields[18], ParameterDirection.Input);
                cmd.Parameters.Add("sw71charge", OracleDbType.Varchar2, swfields[19], ParameterDirection.Input);
                cmd.Parameters.Add("tt", OracleDbType.Varchar2, swfields[20], ParameterDirection.Input);
                cmd.Parameters.Add("kod_g", OracleDbType.Varchar2, swfields[21], ParameterDirection.Input);
                cmd.Parameters.Add("okpo", OracleDbType.Varchar2, swfields[22], ParameterDirection.Input);
                cmd.Parameters.Add("swbankord", OracleDbType.Varchar2, swfields[23], ParameterDirection.Input);
                cmd.Parameters.Add("swbankben", OracleDbType.Varchar2, swfields[24], ParameterDirection.Input);
                cmd.Parameters.Add("swterm", OracleDbType.Varchar2, swfields[25], ParameterDirection.Input);
                cmd.Parameters.Add("swother", OracleDbType.Varchar2, swfields[26], ParameterDirection.Input);
                cmd.Parameters.Add("sumstr", OracleDbType.Varchar2, swfields[27], ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
            return refDoc;
        }

        [WebMethod(EnableSession = true)]
        public string[] SaveDocTemplate(string[] fields)
        {
            string[] result = new string[2];
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection con = conn.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                cmd.CommandText = @"insert into doc_template(template_name,nls_a,kv_a,mfo_a,nam_a,id_a,nls_b,kv_b,mfo_b,nam_b,id_b,nazn,user_id)
                                    values (:template_name,:nls_a,:kv_a,:mfo_a,:nam_a,:id_a,:nls_b,:kv_b,:mfo_b,:nam_b,:id_b,:nazn,user_id) returning template_id into :template_id";

                cmd.Parameters.Add("template_name", OracleDbType.Varchar2, fields[0], ParameterDirection.Input);
                cmd.Parameters.Add("nls_a", OracleDbType.Varchar2, fields[1], ParameterDirection.Input);
                cmd.Parameters.Add("kv_a", OracleDbType.Decimal, fields[2], ParameterDirection.Input);
                cmd.Parameters.Add("mfo_a", OracleDbType.Varchar2, fields[3], ParameterDirection.Input);
                cmd.Parameters.Add("nam_a", OracleDbType.Varchar2, fields[4], ParameterDirection.Input);
                cmd.Parameters.Add("id_a", OracleDbType.Varchar2, fields[5], ParameterDirection.Input);
                cmd.Parameters.Add("nls_b", OracleDbType.Varchar2, fields[6], ParameterDirection.Input);
                cmd.Parameters.Add("kv_b", OracleDbType.Decimal, fields[7], ParameterDirection.Input);
                cmd.Parameters.Add("mfo_b", OracleDbType.Varchar2, fields[8], ParameterDirection.Input);
                cmd.Parameters.Add("nam_b", OracleDbType.Varchar2, fields[9], ParameterDirection.Input);
                cmd.Parameters.Add("id_b", OracleDbType.Varchar2, fields[10], ParameterDirection.Input);
                cmd.Parameters.Add("nazn", OracleDbType.Varchar2, fields[11], ParameterDirection.Input);

                cmd.Parameters.Add("template_id", OracleDbType.Decimal, 0, ParameterDirection.InputOutput);

                cmd.ExecuteNonQuery();

                result[0] = Convert.ToString(cmd.Parameters["template_id"].Value);
                result[1] = fields[0];
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        public int DelDocTemplate(string templateId)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection con = conn.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                cmd.Parameters.Add("template_id", OracleDbType.Decimal, templateId, ParameterDirection.Input);
                cmd.CommandText = "delete from doc_template where template_id=:template_id";
                return cmd.ExecuteNonQuery();
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
        }

        [WebMethod(EnableSession = true)]
        public string[] GetDocTemplate(string templateId)
        {
            string[] result = new string[11];
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection con = conn.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                cmd.Parameters.Add("template_id", OracleDbType.Decimal, templateId, ParameterDirection.Input);
                cmd.CommandText = "select nls_a,kv_a,mfo_a,nam_a,id_a,nls_b,kv_b,mfo_b,nam_b,id_b,nazn from doc_template where template_id=:template_id";

                OracleDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    result[0] = Convert.ToString(reader.GetValue(0));
                    result[1] = Convert.ToString(reader.GetValue(1));
                    result[2] = Convert.ToString(reader.GetValue(2));
                    result[3] = Convert.ToString(reader.GetValue(3));
                    result[4] = Convert.ToString(reader.GetValue(4));
                    result[5] = Convert.ToString(reader.GetValue(5));
                    result[6] = Convert.ToString(reader.GetValue(6));
                    result[7] = Convert.ToString(reader.GetValue(7));
                    result[8] = Convert.ToString(reader.GetValue(8));
                    result[9] = Convert.ToString(reader.GetValue(9));
                    result[10] = Convert.ToString(reader.GetValue(10));
                }
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
            return result;
        }


        [WebMethod(EnableSession = true)]
        public string[] SaveSwiftTemplate(string[] swfields)
        {
            string[] result = new string[2];
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection con = conn.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                cmd.CommandText = @"insert into sw_template(nd,sw50nls,sw50name,sw50address,sw56bic,sw56name,sw57nls,sw57bic,sw57name,sw57address,sw59nls,sw59name,sw59address,sw70nazn,sw70flag,sw71charge,tt,kod_g,okpo,swbankord,swbankben,swterm,swother,template_name,user_id)
                                    values (:nd,:sw50nls,:sw50name,:sw50address,:sw56bic,:sw56name,:sw57nls,:sw57bic,:sw57name,:sw57address,:sw59nls,:sw59name,:sw59address,:sw70nazn,:sw70flag,:sw71charge,:tt,:kod_g,:okpo,:swbankord,:swbankben,:swterm,:swother,:template_name,user_id) returning rec_id into :rec_id";

                cmd.Parameters.Add("nd", OracleDbType.Varchar2, swfields[1], ParameterDirection.Input);
                cmd.Parameters.Add("sw50nls", OracleDbType.Varchar2, swfields[5], ParameterDirection.Input);
                cmd.Parameters.Add("sw50name", OracleDbType.Varchar2, swfields[6], ParameterDirection.Input);
                cmd.Parameters.Add("sw50address", OracleDbType.Varchar2, swfields[7], ParameterDirection.Input);
                cmd.Parameters.Add("sw56bic", OracleDbType.Varchar2, swfields[8], ParameterDirection.Input);
                cmd.Parameters.Add("sw56name", OracleDbType.Varchar2, swfields[9], ParameterDirection.Input);
                cmd.Parameters.Add("sw57nls", OracleDbType.Varchar2, swfields[10], ParameterDirection.Input);
                cmd.Parameters.Add("sw57bic", OracleDbType.Varchar2, swfields[11], ParameterDirection.Input);
                cmd.Parameters.Add("sw57name", OracleDbType.Varchar2, swfields[12], ParameterDirection.Input);
                cmd.Parameters.Add("sw57address", OracleDbType.Varchar2, swfields[13], ParameterDirection.Input);
                cmd.Parameters.Add("sw59nls", OracleDbType.Varchar2, swfields[14], ParameterDirection.Input);
                cmd.Parameters.Add("sw59name", OracleDbType.Varchar2, swfields[15], ParameterDirection.Input);
                cmd.Parameters.Add("sw59address", OracleDbType.Varchar2, swfields[16], ParameterDirection.Input);
                cmd.Parameters.Add("sw70nazn", OracleDbType.Varchar2, swfields[17], ParameterDirection.Input);
                cmd.Parameters.Add("sw70flag", OracleDbType.Decimal, swfields[18], ParameterDirection.Input);
                cmd.Parameters.Add("sw71charge", OracleDbType.Varchar2, swfields[19], ParameterDirection.Input);
                cmd.Parameters.Add("tt", OracleDbType.Varchar2, swfields[20], ParameterDirection.Input);
                cmd.Parameters.Add("kod_g", OracleDbType.Varchar2, swfields[21], ParameterDirection.Input);
                cmd.Parameters.Add("okpo", OracleDbType.Varchar2, swfields[22], ParameterDirection.Input);
                cmd.Parameters.Add("swbankord", OracleDbType.Varchar2, swfields[23], ParameterDirection.Input);
                cmd.Parameters.Add("swbankben", OracleDbType.Varchar2, swfields[24], ParameterDirection.Input);
                cmd.Parameters.Add("swterm", OracleDbType.Varchar2, swfields[25], ParameterDirection.Input);
                cmd.Parameters.Add("swother", OracleDbType.Varchar2, swfields[26], ParameterDirection.Input);
                cmd.Parameters.Add("template_name", OracleDbType.Varchar2, swfields[28], ParameterDirection.Input);
                cmd.Parameters.Add("rec_id", OracleDbType.Decimal, 0, ParameterDirection.InputOutput);

                cmd.ExecuteNonQuery();

                result[0] = Convert.ToString(cmd.Parameters["rec_id"].Value);
                result[1] = swfields[28];
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        public int DelSwiftTemplate(string recId)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection con = conn.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                cmd.Parameters.Add("rec_id", OracleDbType.Decimal, recId, ParameterDirection.Input);
                cmd.CommandText = "delete from sw_template where rec_id=:rec_id and ref is null";
                return cmd.ExecuteNonQuery();
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
        }



        [WebMethod(EnableSession = true)]
        public string[] GetSwiftTemplate(string refDoc, string recId)
        {
            string[] result = new string[29];
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection con = conn.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                cmd.CommandText = "select ref,nd,to_char(datd,'dd.MM.yyyy'),kv,s,sw50nls,sw50name,sw50address,sw56bic,sw56name,sw57nls,sw57bic,sw57name,sw57address,sw59nls,sw59name,sw59address,sw70nazn,sw70flag,sw71charge,tt,kod_g,okpo,swbankord,swbankben,swterm,swother,sumstr, b.office from  sw_template t, sw_banks b where t.sw57bic=b.bic(+) and ";
                if (!string.IsNullOrEmpty(refDoc))
                {
                    cmd.CommandText += "ref=:ref";
                    cmd.Parameters.Add("ref", OracleDbType.Decimal, refDoc, ParameterDirection.Input);
                }
                else
                {
                    cmd.CommandText += "rec_id=:rec_id";
                    cmd.Parameters.Add("rec_id", OracleDbType.Decimal, recId, ParameterDirection.Input);
                }

                OracleDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    result[0] = Convert.ToString(reader.GetValue(0));
                    result[1] = Convert.ToString(reader.GetValue(1));
                    result[2] = Convert.ToString(reader.GetValue(2));
                    result[3] = Convert.ToString(reader.GetValue(3));
                    result[4] = Convert.ToString(reader.GetValue(4));
                    result[5] = Convert.ToString(reader.GetValue(5));
                    result[6] = Convert.ToString(reader.GetValue(6));
                    result[7] = Convert.ToString(reader.GetValue(7));
                    result[8] = Convert.ToString(reader.GetValue(8));
                    result[9] = Convert.ToString(reader.GetValue(9));
                    result[10] = Convert.ToString(reader.GetValue(10));
                    result[11] = Convert.ToString(reader.GetValue(11));
                    result[12] = Convert.ToString(reader.GetValue(12));
                    result[13] = Convert.ToString(reader.GetValue(13));
                    result[14] = Convert.ToString(reader.GetValue(14));
                    result[15] = Convert.ToString(reader.GetValue(15));
                    result[16] = Convert.ToString(reader.GetValue(16));
                    result[17] = Convert.ToString(reader.GetValue(17));
                    result[18] = Convert.ToString(reader.GetValue(18));
                    result[19] = Convert.ToString(reader.GetValue(19));
                    result[20] = Convert.ToString(reader.GetValue(20));
                    result[21] = Convert.ToString(reader.GetValue(21));
                    result[22] = Convert.ToString(reader.GetValue(22));
                    result[23] = Convert.ToString(reader.GetValue(23));
                    result[24] = Convert.ToString(reader.GetValue(24));
                    result[25] = Convert.ToString(reader.GetValue(25));
                    result[26] = Convert.ToString(reader.GetValue(26));
                    result[27] = Convert.ToString(reader.GetValue(27));
                    result[28] = Convert.ToString(reader.GetValue(28));
                }

            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
            return result;
        }

        public class ResponseBase
        {
            public Int32 StatusCode;
            public String ErrorMessage;
        }

        public class BindIncasatorsDataRes : ResponseBase
        {
            public String Atrt;
            public String Pasp;
            public String Paspn;
        }

        [WebMethod(EnableSession = true)]
        public BindIncasatorsDataRes BindIncasatorsData(int id)
        {
            BindIncasatorsDataRes res = new BindIncasatorsDataRes();
            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            try
            {
                string strSql = "select ATRT, PASP, PASPN from PODOTCH where id=:i_id";
                using (OracleCommand com = new OracleCommand(strSql, con))
                {
                    com.Parameters.Add("i_id", OracleDbType.Int32, id, ParameterDirection.Input);
                    using (OracleDataReader reader = com.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            res.Atrt = Convert.ToString(reader.GetValue(0));
                            res.Pasp = Convert.ToString(reader.GetValue(1));
                            res.Paspn = Convert.ToString(reader.GetValue(2));
                        }
                    }
                }
                res.StatusCode = 0;
                return res;
            }
            catch(System.Exception ex)
            {
                res.StatusCode = -1;
                res.ErrorMessage = ex.Message;
                return res;
            }
            finally
            {
                con.Dispose();
                con.Close();
                con = null;
            }
        }
      
        /// <summary>
        /// признак чи має користувач можливість друку в PDF
        /// </summary>
        /// <returns>true- має ; false-не має</returns>
        private static bool GetFlagUserPrintPdf()
        {
            bool res;
            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            try
            {
                const string select = @"select print_pdf 
                            from users_print_pdf 
                                where id=getcurrentuserid";
                OracleCommand cmd = new OracleCommand(select, con);
                res = Convert.ToString(cmd.ExecuteScalar()) == "1";
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            return res;
        }

        /// <summary>
        /// функция фозврящяет имя тикета для печяти в PDF
        /// </summary>
        /// <param name="p_ref">референс документа</param>
        /// <returns>имя тикета или пустую строку если тикета нет</returns>
        public static String GetPdfFileName(decimal p_ref)
        {
            String res = String.Empty;
            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            try
            {
                OracleCommand cmd = new OracleCommand("select v.REP_PREFIX_FR from vob v, oper o where o.ref=:p_ref and o.vob=v.vob", con);
                cmd.Parameters.Add("p_ref", OracleDbType.Decimal, p_ref, ParameterDirection.Input);
                res = Convert.ToString(cmd.ExecuteScalar());
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            return res;
        }
      
        /// <summary>
        /// признак документа для печати без подтверждения
        /// </summary>
        /// <param name="p_ref">референс документа</param>
        /// <returns>true-да; false - нет</returns>
        public static bool GetPrintNoConfirm(decimal p_ref)
        {
            bool res = false;
            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            try
            {
                OracleCommand cmd = new OracleCommand("select flags from tts where tt=(select tt from oper where ref=:p_ref)", con);
                cmd.Parameters.Add("p_ref", OracleDbType.Decimal, p_ref, ParameterDirection.Input);
                var s = Convert.ToString(cmd.ExecuteScalar());
                if (s.Substring(45, 1) == "1") res = true;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            return res;
        }

        /// <summary>
        /// Перевірка на блокування рахунків 2625, 2605     (COBUMMFO-3907)
        /// </summary>
        /// <param name="acc"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string[] checkAcc(string acc)
        {
            string[] result = { "1", "" };      // 1 - BLOCKED  0 - OK
            using (var con = ((IOraConnection)Application["OracleConnectClass"]).GetUserConnection())
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = "select check_blkd(a.nls, a.kv) from accounts a where a.nls = :p_nls";
                    cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, acc, ParameterDirection.Input);
                    try
                    {
                        result[0] = Convert.ToString(cmd.ExecuteScalar());
                    }
                    catch (Exception e)
                    {
                        result[0] = "1";
                        result[1] = e.InnerException != null ? e.InnerException.Message : e.Message;
                    }
                }
            }
            return result;
        }

    }
}
