using System;
using System.IO;
using System.ComponentModel;
using System.Data;
using System.Globalization;
using System.Collections;
using System.Web;
using System.Web.Services;
using Bars;
using Bars.Web.Report;
using Bars.Doc;
using BarsWeb.Core.Logger;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Collections.Generic;
using BarsWeb.Infrastructure.Helpers;
using System.Text;

namespace barsroot.udeposit
{   // 2017-10-03 //
    public class DptUService : BarsWebService
    {
        string base_role = "wr_deposit_u";
        int rowsLimit = 2000;
        private IDbLogger DBLogger; 

        private struct oper_stuct
        {
            public OracleConnection con;
            public long Ref;				// референс (NUMBER_Null для новых)
            public string TT;				// Код операции
            public byte Dk;					// ДК (0-дебет, 1-кредит)
            public short Vob;				// Вид обработки
            public string Nd;				// № док
            public DateTime DatD;		// Дата док
            public DateTime DatP;		// Дата ввода(поступления в банк)
            public DateTime DatV1;	// Дата валютирования основной операции
            public DateTime DatV2;	// Дата валютирования связаной операции
            public string NlsA;			// Счет-А
            public string NamA;			// Наим-А
            public string BankA;		// МФО-А
            public string NbA;			// Наим банка-А(м.б. '')
            public short KvA;				// Код вал-А
            public decimal SA;			// Сумма-А
            public string OkpoA;		// ОКПО-А
            public string NlsB;			// Счет-Б
            public string NamB;			// Наим-Б
            public string BankB;		// МФО-Б
            public string NbB;			// Наим банка-Б(м.б. '')
            public short KvB;				// Код вал-Б
            public decimal SB;			// Сумма-Б
            public string OkpoB;		// ОКПО-Б
            public string Nazn;			// Назначение пл
            public string Drec;			// Доп реквизиты
            public string OperId;		// Идентификатор ключа опрециониста
            public byte[] Sign;			// ЭЦП опрециониста
            public byte Sk;					// СКП
            public short Prty;			// Приоритет документа
            public decimal SQ;			// Эквивалент для одновалютной оп
        }

        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        public DptUService()
        {
            InitializeComponent();
            cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
            cinfo.DateTimeFormat.DateSeparator = ".";
            cinfo.NumberFormat.NumberDecimalSeparator = ".";
            DBLogger = DbLoggerConstruct.NewDbLogger();
        }

        //Договора
        [WebMethod(EnableSession = true)]
        public object[] GetDepositUDeals(string[] data)
        {
            object[] arr = new object[10];
            try
            {
                InitOraConnection();

                // string filter = " nvl(d.closed, 0) = 0 ";
                
                string filter = " ";

                if ((data[9] != string.Empty) && (data[9].Trim() != "null"))
                {
                    // НАДРА БАНК
                    if (BankType.GetOurMfo() == "380764") 
                    {
                        if (data[9] != "0")//збочення для банку НАДРА: поділ за сегментами. в разі, якщо сегмент = 0 то всі сегменти.
                            filter += " AND d.segment=" + data[9];
                    }
                    else
                    {
                        filter += " AND " + data[9];
                    }
                }

                object[] tmp = BindTableWithNewFilter("d.dpu_id DPU_ID, d.nd ND, d.dpu_gen DPU_GEN, d.dpu_add DPU_ADD, " +
                    "d.vidd VIDD, d.name NAME, " +
                    "d.kv KV, d.iso ISO, d.namev NAMEV, " +
                    "d.sum/100 SUM, gl.p_icurval(d.kv, d.sum, bankdate)/100 SUMQ, " +
                    "d.rnk RNK, d.nmk NMK, d.okpo OKPO, " +
                    "d.acc ACC, d.nls NLS, d.ostc/100 OST, d.ostb/100 OST_PL, d.ostq/100 OSTQ, " +
                    "d.acra ACCN, d.proc PROC, d.ostn/100 OSTN, " +
                    "d.freqn nFREQN, d.freqv nFREQV, d.freq_name FREQV, " +
                    "TO_CHAR(d.dat_z,'DD.MM.YYYY') DATZ, TO_CHAR(d.dat_n,'DD.MM.YYYY') DATN, " +
                    "TO_CHAR(d.dat_o,'DD.MM.YYYY') DATO, TO_CHAR(d.dat_v,'DD.MM.YYYY') DATV, " +
                    "d.dat_z DATZ_SORT, d.dat_n DAT_N_SORT, " +
                    "d.dat_o DAT_O_SORT, d.dat_v DAT_V_SORT, " +
                    "d.DAT_Z, d.DAT_N, d.DAT_O, d.DAT_V, d.branch BRANCH, " +
                    "d.mfod MFOD, d.nlsd ACCD, d.nmsd NMSD," +
                    "d.mfop MFOP, d.nlsp ACCP, d.nmsd NMSP," +
                    "SIGN(d.DAT_O - bankdate) FL_1, SIGN(d.DAT_O - bankdate - 7) FL_2, SIGN(d.DAT_O - bankdate - 30) FL_3, " +
                    "d.fl_add FL_ADD, d.id_stop ID_STOP, d.min_sum/100 MIN_SUM, d.user_id ISP, d.closed CLOSED",
                    "BARS.DPT_U d", filter, data);
                arr[0] = tmp[0]; // XML with data
                arr[1] = tmp[1]; // number of pages
                ArrayList reader = SQL_reader("select f_ourmfo, nb, user_id, TO_CHAR(bankdate,'DD.MM.YYYY'), tobopack.gettobo, tobopack.GetTOBOName, TO_CHAR(bankdate-1,'DD.MM.YYYY') from banks where mfo=f_ourmfo");
                if (reader.Count != 0)
                {
                    arr[2] = reader[0];
                    arr[3] = reader[1];
                    arr[4] = reader[2];
                    arr[5] = reader[3];
                    arr[6] = reader[4];
                    arr[7] = reader[5];
                    arr[9] = reader[6];
                }

                string depositLine = Convert.ToString(SQL_SELECT_scalar("select decode(count(*), 0, 'K', 'P') from dpu_vidd where fl_extend = 2"));
                if (string.IsNullOrEmpty(depositLine))
                    depositLine = "K";
                arr[8] = depositLine;
                DBLogger.Info("Пользователь просматривает таблицу депозитов юр. лиц.", "BarsWeb.DepositU");
            }
            finally
            {
                DisposeOraConnection();
            }
            return arr;
        }

        [WebMethod(EnableSession = true)]
        public string GenerateReport(string dpu_id, string templateID, bool reCreate)
        {
            string fileName = string.Empty;
            RtfReporter rep = new RtfReporter(Context);
            rep.RoleList = "reporter,cc_doc";
            rep.ContractNumber = Convert.ToInt64(dpu_id);
            rep.TemplateID = templateID;
            rep.Generate();
            fileName = rep.ReportFile;

            InitOraConnection();
            try
            {
                SetParameters("template", DB_TYPE.Varchar2, templateID, DIRECTION.Input);
                SetParameters("dptid", DB_TYPE.Varchar2, dpu_id, DIRECTION.Input);
                SetParameters("adds", DB_TYPE.Decimal, 0, DIRECTION.Input);

                int docsCount = Convert.ToInt32(SQL_SELECT_scalar("select count(id) from cc_docs where id=:template and nd=:dptid and adds=:adds"));
                if (docsCount == 0 || reCreate)
                {
                    if (reCreate)
                        SQL_NONQUERY("delete from cc_docs where id=:template and nd=:dptid and adds=:adds");

                    StreamReader sr = new StreamReader(rep.ReportFile, System.Text.Encoding.GetEncoding(1251));
                    String str = sr.ReadToEnd();
                    sr.Close();

                    SetParameters("txt", DB_TYPE.Clob, str, DIRECTION.Input);

                    SQL_PROCEDURE("dpt_web.create_text");
                    DBLogger.Debug("Формирование тексту депозитного договору ЮО №" + dpu_id + ".", "udeposit");
                }
            }
            finally
            {
                DisposeOraConnection();
            }
            return fileName;
        }

        /// <summary>
        /// Параметри (картка) депозитного договору 
        /// </summary>
        /// <param name="dpu_id"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public object[] GetDepositDealParams(string dpu_id)
        {
            object[] result = new object[59];
            try
            {
                InitOraConnection();
                
                SetParameters("DPU_ID", DB_TYPE.Decimal, dpu_id, DIRECTION.Input);

                ArrayList reader = SQL_reader("select ND" + //0
                                              ", VIDD" + //1
                                              ", VIDD_NAME" + //2
                                              ", RNK" + //3
                                              ", SUM" + //4
                                              ", to_char(DAT_BEGIN,'dd.mm.yyyy')" + //5
                                              ", to_char(DAT_END,'dd.mm.yyyy')" + //6
                                              ", to_char(DATZ,'dd.mm.yyyy')" + //7
                                              ", to_char(DATV,'dd.mm.yyyy')" + //8
                                              ", MFO_D" + //9
                                              ", NLS_D" + //10
                                              ", NMS_D" + //11
                                              ", NB_D" +  //12
                                              ", MFO_P" + //13
                                              ", NLS_P" + //14
                                              ", NMS_P" + //15
                                              ", NB_P" +  //16
                                              ", COMMENTS" + //17
                                              ", KV" + //18
                                              ", LCV" + //19
                                              ", NAMEV" + //20
                                              ", NMK" + //21
                                              ", OKPO" + //22
                                              ", ADR" + //23
                                              ", to_char(BDAT,'dd.mm.yyyy')" + //24
                                              ", BR"          + // 25
                                              ", BR_NAME"     + // 26
                                              ", OP"          + // 27
                                              ", IR"          + // 28
                                              ", FREQV"       + // 29
                                              ", FREQV_NAME"  + // 30
                                              ", ACC"         + // 31
                                              ", NLS"         + // 32
                                              ", ACRA"        + // 33
                                              ", COMPROC"     + // 34
                                              ", DPU_ADD"     + // 35
                                              ", DPU_GEN"     + // 36
                                              ", ID_STOP"     + // 37
                                              ", STOP_NAME"   + // 38
                                              ", MIN_SUM"     + // 39
                                              ", F_OURMFO()"  + // 40
                                              ", ACR_NLS"     + // 41
                                              ", FL_EXT"      + // 42
                                              ", BRANCH"      + // 43
                                              ", BRANCH_NAME" + // 44
                                              ", DPU_CODE"    + // 45
                                              ", TAS_ID"      + // 46
                                              ", DPU_TYPE"    + // 47
                                              ", TERM_TYPE"   + // 48
                                              ", OSTC"        + // 49
                                              ", ACC2"        + // 50
                                              ", TEMPLATE_ID" + // 51
                                              ", K013"        + // 52
                                              ", TYPE_ID"     + // 53
                                              ", TYPE_NAME"   + // 54
                                              ", OKPO_P"      + // 55
                                              ", CNT_DUBL"    + // 56
                                              ", ( select nvl(min(FR),-1) from DOC_SCHEME where ID = TEMPLATE_ID ) as TPL_TP"  + // 57
                                              ", (length(sys_context('bars_context','user_branch'))-1)/7 as USR_LVL" + // 58
                                              " from V_DPU_DEAL_WEB WHERE DPU_ID=:DPU_ID");

                DBLogger.Info("Пользователь просматривает параметры депозитного договора № " + dpu_id, "BarsWeb.DepositU");

                if (reader.Count != 0)
                {
                    reader.CopyTo(result);
                    return result;
                }
                return null;
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        //Доп. соглашения
        [WebMethod(EnableSession = true)]
        public object[] GetDepositAddDealParams(string dpu_id)
        {
            object[] result = new object[42];
            try
            {
                InitOraConnection();
                SetRole(base_role);
                SetParameters("DPU_ID", DB_TYPE.Decimal, dpu_id, DIRECTION.Input);
                ArrayList reader = SQL_reader("select to_char(dpu.f_next_add_number(dpu_id))" + // 0
                    ", VIDD"        + // 01
                    ", VIDD_NAME"   + // 02
                    ", ACC"         + // 03
                    ", NLS"         + // 04
                    ", ACRA"        + // 05
                    ", RNK"         + // 06
                    ", NMK"         + // 07
                    ", OKPO"        + // 08
                    ", ADR"         + // 09
                    ", KV"          + // 10
                    ", LCV"         + // 11
                    ", NAMEV"       + // 12
                    ", BRANCH"      + // 13
                    ", BRANCH_NAME" + // 14
                    ", NLS"         + // 15
                    ", ACR_NLS"     + // 16
                    ", TAS_ID"      + // 17
                    ", TAS_FIO"     + // 18
                    ", TAS_POS"     + // 19
                    ", TAS_DOC"     + // 20
                    ", to_char(DAT_END,'dd.mm.yyyy')" + // 21
                    ", to_char(DATV,   'dd.mm.yyyy')" + // 22
                    ", TYPE_ID"     + // 23
                    ", K013"        + // 24
                    ", FREQV"       + // 25
                    ", FREQV_NAME"  + // 26
                    ", ID_STOP"     + // 27
                    ", STOP_NAME"   + // 28
                    ", MFO_D"       + // 29
                    ", NLS_D"       + // 30
                    ", NMS_D"       + // 31
                    ", NB_D"        + // 32
                    ", MFO_P"       + // 33
                    ", NLS_P"       + // 34
                    ", NMS_P"       + // 35
                    ", NB_P"        + // 36
                    ", OKPO_P"      + // 37
                    ", BR"          + // 38
                    ", BR_NAME"     + // 39
                    ", OP"          + // 40
                    ", IR"          + // 41
                    "  from V_DPU_DEAL_WEB where DPU_ID = :DPU_ID");
                DBLogger.Info("Пользователь просматривает параметры доп. соглашения № " + dpu_id, "BarsWeb.DepositU");
                if (reader.Count != 0)
                {
                    reader.CopyTo(result);
                    return result;
                }
                return null;
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        // Начисление процентов
        [WebMethod(EnableSession = true)]
        public string MakeInt(decimal acc, string date)
        {
            DBLogger.Info("Користувач розпочав нарахування %% по рахунку #" + acc.ToString(), "BarsWeb.DepositU");

            string result = string.Empty;
            DateTime pdat = (!string.IsNullOrEmpty(date)) ? (Convert.ToDateTime(date, cinfo)) : (DateTime.MinValue);
            try
            {
                InitOraConnection();
                SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);

                SQL_NONQUERY(@"insert into int_queue 
									(kf, branch, deal_id, deal_num, deal_dat, cust_id, int_id, 
									 acc_id, acc_num, acc_cur, acc_nbs, acc_name, acc_iso,     
									 acc_open, acc_amount, int_details, int_tt, mod_code)
							  select a.kf, a.branch, d.dpu_id, d.nd, d.datz, d.rnk, i.id,
									 a.acc, a.nls, a.kv, a.nbs, substr(a.nms, 1, 38), t.lcv,
									 a.daos, null, null, nvl(i.tt, '%%1'), 'DPU' 
								from accounts a, int_accn i, tabval t, dpu_deal d
							   where a.acc        = :acc
								 and d.acc        = a.acc   
								 and a.acc        = i.acc 
								 and i.id         = 1 
								 and a.kv         = t.kv");

                ClearParameters();

                SetParameters("p_dat2", DB_TYPE.Date, pdat, DIRECTION.Input);
                SetParameters("p_runmode", DB_TYPE.Decimal, 1, DIRECTION.Input);
                SetParameters("p_runid", DB_TYPE.Decimal, 0, DIRECTION.Input);
                SetParameters("p_intamount", DB_TYPE.Decimal, 0, DIRECTION.Output);
                SetParameters("p_err", DB_TYPE.Decimal, null, DIRECTION.Output);

                SQL_NONQUERY(@"declare p_errflg boolean; p_ret number;
							   begin make_int(:p_dat2, :p_runmode, :p_runid, :p_intamount, p_errflg);
							   if p_errflg
							   then p_ret := 1;
							   else p_ret := 0;
							   end if;
							   :p_err := p_ret;
							   end; ");

                result = Convert.ToString(GetParameter("p_err"));

                if (result == "0")
                {
                    DBLogger.Info("Сума нарахованих %% по рахунку #" + acc.ToString() + " становить " + Convert.ToString(GetParameter("p_intamount")), "BarsWeb.DepositU");
                }
                else
                {
                    DBLogger.Info("Виникла помилка при нарахуванні %% по рахунку #" + acc.ToString(), "BarsWeb.DepositU");
                }
            }
            finally
            {
                DisposeOraConnection();
            }

            return result;
        }

        //Состояние договора
        [WebMethod(EnableSession = true)]
        public object[] GetDepositDealState(string dpu_id, string dpu_gen)
        {
            object[] result = new object[46];
            try
            {
                InitOraConnection();
                SetRole(base_role);
                SetParameters("DPU_ID", DB_TYPE.Decimal, dpu_id, DIRECTION.Input);
                ArrayList reader = SQL_reader("SELECT " +
                    "ND," +//0
                    "DATZ," +//1
                    "NMK," +//2
                    "VIDD_NAME," +//3
                    "NAMEV, " +//4
                    "FREQV_NAME, " +//5
                    "ACC," +//6
                    "NLS," +//7
                    "OSTB," +//8
                    "ACRA," +//9
                    "ACR_NLS," +//10
                    "ACR_OSTB," +//11
                    "OKPO," +//12
                    "to_char(ACR_DAT,'DD.MM.YYYY')," +//13
                    "CLOSED, " +//14
                    "bankdate, " +//15
                    "DAT_BEGIN, " +//16
                    "DAT_END," +//17
                    "FL_ADD " +//18
                    ", d.ACR_DAT-bankdate+1" + // 19
                    ", nvl(d.ID_STOP,0)"     + // 20
                    ", d.KV"                 + // 21  
                    ", d.MFO_D"              + // 22
                    ", d.NLS_D"              + // 23
                    ", d.NMS_D"              + // 24
                    ", d.NB_D"               + // 25
                    ", d.SUM"                + // 26
                    ", d.VISED"              + // 27
                    ", d.MFO_P"              + // 28
                    ", d.NLS_P"              + // 29
                    ", d.NMS_P"              + // 30
                    ", d.OKPO_P"             + // 31
                    ", d.OSTC"               + // 32
                " from BARS.V_DPU_DEAL_WEB d where d.DPU_ID = :DPU_ID");
                if (reader.Count != 0)
                    reader.CopyTo(result);

                result[37] = Convert.ToString(result[27]);

                // реквізити для виплати %%
                result[38] = Convert.ToString(result[28]);
                result[39] = Convert.ToString(result[29]);
                result[40] = Convert.ToString(result[30]);
                result[41] = Convert.ToString(result[31]);

                if (Convert.ToString(result[14]) != "1")
                {
                    DateTime bdate = Convert.ToDateTime(result[15], cinfo);
                    DateTime datZ = Convert.ToDateTime(result[1], cinfo);
                    DateTime datN = Convert.ToDateTime(result[16], cinfo);
                    DateTime datO = DateTime.MinValue;
                    Int32 stopDone = 0;
                    Int32 pny_id = Convert.ToInt32(result[20]);

                    if (Convert.ToString(result[17]) != "")
                        datO = Convert.ToDateTime(result[17], cinfo);

                    if (Convert.ToDecimal(result[32], cinfo) > 0)
                    {
                        if (datN <= bdate && ( datO > bdate || datO == DateTime.MinValue) )
                        {
                            // Поповнення
                            if (Convert.ToDecimal(result[18], cinfo) == 1)
                            {
                                result[28] = 1;
                            }
                            else
                            {
                                result[28] = 0;
                            }

                            // была ли операция штрафования
                            if (pny_id > 0 && datO != DateTime.MinValue)
                            {
                                ClearParameters();

                                SetParameters("DATN", DB_TYPE.Date, datN, DIRECTION.Input);

                                SetParameters("DPU_ID", DB_TYPE.Decimal, dpu_id, DIRECTION.Input);

                                stopDone = Convert.ToInt32(SQL_SELECT_scalar("select count( o.REF ) " +
                                    "  from BARS.OPLDOK t " +
                                    "  join BARS.OPER   o        on (  o.REF    = t.REF ) " +
                                    "  join BARS.DPU_ACCOUNTS da on ( da.ACCID  = t.ACC ) " +
                                    "  join BARS.DPU_PAYMENTS dp on ( dp.DPU_ID = da.DPUID  AND  dp.REF = t.REF )   " +
                                    " where t.FDAT between :DATN AND greatest(trunc(SYSDATE), bankdate) " +
                                    "   and t.dk = 0  " +
                                    "   and t.sos > 0 " +
                                    "   and o.TT IN ( 'DUS', 'DUT' ) " +
                                    "   and dp.DPU_ID = :DPU_ID"));
                            }

                            // Штрафування ( відсутній факт штрафування )
                            if (stopDone == 0)
                            {
                                result[30] = 1; // Enabled
                            }
                            else
                                result[30] = 0; // Disabled
                        }

                        // Погашення ( є плановий залишок AND код штрафу = 0 
                        // OR договір завершився 
                        // OR договір дозапитання 
                        // OR наявний факт штрафування 
                        if (Convert.ToDecimal(result[8]) > 0 && (datO < bdate || datO == DateTime.MinValue || stopDone > 0 || pny_id == 0))
                            result[31] = 1; // Enabled
                        else
                            result[31] = 0; // Disabled
                    }
                    else
                    {
                        // розміщення (якщо договір ще не закінчився)
                        if (datN <= bdate && datO > bdate)
                        {
                            result[27] = 1;
                        }
                        else
                        {
                            result[27] = 0;
                        }

                        result[28] = 0;
                        result[29] = 0;
                        result[30] = 0;
                        result[31] = 0;

                    }

                    // Виплата. нарах. %% (якщо наявний план. залишок на рах. нарах.%%)
                    if (Convert.ToDecimal(result[11], cinfo) > 0)
                    {
                        result[29] = 1;
                    }
                    else
                    {
                        result[29] = 0;
                    }
                }

                //
                ClearParameters();
                SetParameters("dpu_gen", DB_TYPE.Decimal, dpu_gen, DIRECTION.Input);
                result[36] = SQL_SELECT_scalar("SELECT ' №'||nd||' от '||to_char(datz,'dd/MM/yyyy') FROM dpu_deal WHERE dpu_id = :dpu_gen");

                // 
                string nls = Convert.ToString(result[7]);
                if (nls.StartsWith("8"))
                {
                    ClearParameters();
                    SetParameters("dpu_id", DB_TYPE.Decimal, dpu_id, DIRECTION.Input);
                    result[42] = SQL_SELECT_scalar("SELECT a.nls FROM V_DPU_RELATION_ACC d, ACCOUNTS a WHERE d.DEP_ID = :dpu_id AND d.TIP_ACC = 'DEP' AND d.GEN_ACC = a.acc");
                }
                else
                {
                    result[42] = result[7];
                }

                string nlsN = Convert.ToString(result[10]);
                if (nlsN.StartsWith("8"))
                {
                    ClearParameters();
                    SetParameters("dpu_id", DB_TYPE.Decimal, dpu_id, DIRECTION.Input);
                    result[43] = SQL_SELECT_scalar("SELECT a.nls FROM V_DPU_RELATION_ACC d, ACCOUNTS a WHERE d.DEP_ID = :dpu_id AND d.TIP_ACC = 'DEN' AND d.GEN_ACC = a.acc");
                }
                else
                {
                    result[43] = result[10];
                }

                // TTS
                Int32 kv = Convert.ToInt32(result[21]);

                ClearParameters();

                SetParameters("p_curid", DB_TYPE.Decimal, kv, DIRECTION.Input);
                SetParameters("p_curid", DB_TYPE.Decimal, kv, DIRECTION.Input);
                SetParameters("p_curid", DB_TYPE.Decimal, kv, DIRECTION.Input);
                SetParameters("p_mfod", DB_TYPE.Varchar2, Convert.ToString(result[22]), DIRECTION.Input);
                SetParameters("p_curid", DB_TYPE.Decimal, kv, DIRECTION.Input);
                SetParameters("p_mfop", DB_TYPE.Varchar2, Convert.ToString(result[38]), DIRECTION.Input);

                ArrayList list = SQL_reader("select DPU.GET_TT( 0, :p_curid, gl.kf(), Null )" // 0 - Розміщення депозиту
                                              + " , DPU.GET_TT( 1, :p_curid, gl.kf(), Null )" // 1 - Поповнення депозиту
                                              + " , DPU.GET_TT( 2, :p_curid, :p_mfod, Null )" // 2 - Deposit  payout (2)
                                              + " , DPU.GET_TT( 4, :p_curid, :p_mfop, Null )" // 3 - Interest payout (4)
                                              + " from DUAL");

                if (list.Count > 0)
                {
                    result[32] = Convert.ToString(list[0]);
                    result[33] = Convert.ToString(list[1]);
                    result[34] = Convert.ToString(list[2]);
                    result[35] = Convert.ToString(list[3]);
                }

                if ( kv != 980 )
                {
                    ClearParameters();
                    string bankMfo = GetGlobalParam("MFO", "BASIC_INFO");

                    if (Convert.ToString(result[22]) != bankMfo)
                    {
                        try
                        {
                            ClearParameters();
                            SetParameters("p_mfo", DB_TYPE.Varchar2, Convert.ToString(result[22]), DIRECTION.Input);
                            SetParameters("p_dpuid", DB_TYPE.Decimal, dpu_id, DIRECTION.Input);
                            SetParameters("p_tt", DB_TYPE.Varchar2, Convert.ToString(result[34]), DIRECTION.Input);
                            result[44] = Convert.ToString(SQL_SELECT_scalar("select case DPU.IS_OSCHADBANK( :p_mfo ) when 0 "
                                                                                 + "then DPU.GET_SWT_DTL( :p_dpuid, :p_tt ) "
                                                                                 + "else NULL end from DUAL"));
                        }
                        catch(Exception ex)
                        {
                            result[44] = string.Empty;
                        }
                    }

                    if (Convert.ToString(result[38]) != bankMfo)
                    {
                        try
                        {
                            ClearParameters();
                            SetParameters("p_mfo", DB_TYPE.Varchar2, Convert.ToString(result[22]), DIRECTION.Input);
                            SetParameters("p_dpuid", DB_TYPE.Decimal, dpu_id, DIRECTION.Input);
                            SetParameters("p_tt", DB_TYPE.Varchar2, Convert.ToString(result[35]), DIRECTION.Input);
                            result[45] = Convert.ToString(SQL_SELECT_scalar("select case DPU.IS_OSCHADBANK( :p_mfo ) when 0 "
                                                                                 + "then DPU.GET_SWT_DTL( :p_dpuid, :p_tt ) "
                                                                                 + "else NULL end from DUAL"));
                        }
                        catch(Exception ex)
                        {
                            result[45] = string.Empty;
                        }
                    }
                }

                DBLogger.Info("Пользователь просматривает текущее состояние депозитного договора № " + dpu_id, "barsroot.udeposit");
            }
            finally
            {
                DisposeOraConnection();
            }
            return result;
        }

        /// <summary>
        /// Fill tables
        /// </summary>
        /// <param name="acc"></param>
        /// <param name="accN"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string[] fillTables(string acc, string accN)
        {
            string[] result = new string[500];
            try
            {
                InitOraConnection();
                SetRole(base_role);
                SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
                SQL_Reader_Exec("SELECT to_char(fdat,'DD.MM.YYYY'), kos/100, dos/100,(ostf-dos+kos)/100, acrn.fprocn(acc,1,fdat) " +
                                "FROM saldoa WHERE acc = :acc ORDER BY fdat desc");
                int index = 0;
                while (SQL_Reader_Read() && index <= 50)
                {
                    ArrayList reader = SQL_Reader_GetValues();
                    result[index++] = "1;<a href=# onclick=fnShowSal(" + acc + ",'" + Convert.ToString(reader[0]) + "')>" + Convert.ToString(reader[0]) + "</a>;" + Convert.ToString(reader[1]) + ";" + Convert.ToString(reader[2]) + ";" + Convert.ToString(reader[3]) + ";" + Convert.ToString(reader[4]);
                }
                SQL_Reader_Close();

                ClearParameters();
                SetParameters("accN", DB_TYPE.Decimal, accN, DIRECTION.Input);
                SQL_Reader_Exec("SELECT to_char(fdat,'DD.MM.YYYY'), kos/100, dos/100,(ostf-dos+kos)/100 " +
                                "FROM saldoa WHERE acc = :accN ORDER BY fdat desc");
                while (SQL_Reader_Read() && index <= 101)
                {
                    ArrayList reader = SQL_Reader_GetValues();
                    result[index++] = "2;<a href=# onclick=fnShowSal(" + accN + ",'" + Convert.ToString(reader[0]) + "')>" + Convert.ToString(reader[0]) + "</a>;" + Convert.ToString(reader[1]) + ";" + Convert.ToString(reader[2]) + ";" + Convert.ToString(reader[3]);
                }
            }
            finally
            {
                DisposeOraConnection();
            }
            return result;
        }

        ////// <summary>
        ///// Штраф
        ///// </summary>
        //[WebMethod(EnableSession = true)]
        //public string[] getPenalty(string dpt_id, string date)
        //{
        //    string[] result = new string[5];
        //    try
        //    {
        //        DateTime bdate = Convert.ToDateTime(date, cinfo);
        //        InitOraConnection();
        //        SetParameters("p_dpu_id", DB_TYPE.Decimal, dpt_id, DIRECTION.Input);
        //        SetParameters("p_dat", DB_TYPE.Date, bdate, DIRECTION.Input);
        //        SetParameters("p_fact_sum", DB_TYPE.Decimal, 24, null, DIRECTION.Output);
        //        SetParameters("p_penyasum", DB_TYPE.Decimal, 24, null, DIRECTION.Output);
        //        SetParameters("p_penya_rate", DB_TYPE.Decimal, 24, null, DIRECTION.Output);
        //        SetParameters("p_comment", DB_TYPE.Varchar2, 2000, null, DIRECTION.Output);

        //        SQL_PROCEDURE("dpu.p_penalty");

        //        result[0] = Convert.ToString(GetParameter("p_fact_sum"));
        //        result[1] = Convert.ToString(GetParameter("p_penyasum"));
        //        result[2] = Convert.ToString(GetParameter("p_penya_rate"));
        //        result[3] = Convert.ToString(GetParameter("p_comment"));

        //        string fileName = Path.GetTempFileName();
        //        using (StreamWriter sw = new StreamWriter(fileName, false, System.Text.Encoding.GetEncoding(1251)))
        //        {
        //            sw.Write(result[3]);
        //        }
        //        result[4] = fileName;
        //    }
        //    finally
        //    {
        //        DisposeOraConnection();
        //    }
        //    return result;
        //}
        
        /// <summary>
        /// Розрахунок відсоткової ставки та сум штрафу при достроковому поверененні коштів по деп. дог.
        /// </summary>
        /// <param name="dpt_id"></param>
        /// <param name="bnk_dt"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string[] getPenaltyEx( string dpt_id, string bnk_dt )
        {
            string[] result = new string[5];

            try
            {
                DateTime bdate = Convert.ToDateTime(bnk_dt, cinfo);

                Decimal amntRet = 0;
                Decimal amntPay = 0;

                InitOraConnection();

                SetParameters("p_dpuid", DB_TYPE.Decimal, dpt_id, DIRECTION.Input);
                SetParameters("p_bdate", DB_TYPE.Date, bdate, DIRECTION.Input);

                SetParameters("p_totalint_nom", DB_TYPE.Decimal, 24, null, DIRECTION.Output);
                SetParameters("p_totalint_eqv", DB_TYPE.Decimal, 24, null, DIRECTION.Output);
                SetParameters("p_penyaint_nom", DB_TYPE.Decimal, 24, null, DIRECTION.Output);
                SetParameters("p_penyaint_eqv", DB_TYPE.Decimal, 24, null, DIRECTION.Output);
                SetParameters("p_intpay_nom", DB_TYPE.Decimal, 24, null, DIRECTION.Output);
                SetParameters("p_intpay_eqv", DB_TYPE.Decimal, 24, null, DIRECTION.Output);
                SetParameters("p_dptpay_nom", DB_TYPE.Decimal, 24, null, DIRECTION.Output);
                SetParameters("p_dptpay_eqv", DB_TYPE.Decimal, 24, null, DIRECTION.Output);
                
                SetParameters("p_penya_rate", DB_TYPE.Decimal, 24, null, DIRECTION.Output);
                
                SetParameters("p_tax_inc_ret", DB_TYPE.Decimal, 24, null, DIRECTION.Output);
                SetParameters("p_tax_mil_ret", DB_TYPE.Decimal, 24, null, DIRECTION.Output);
                SetParameters("p_tax_inc_pay", DB_TYPE.Decimal, 24, null, DIRECTION.Output);
                SetParameters("p_tax_mil_pay", DB_TYPE.Decimal, 24, null, DIRECTION.Output);

                SetParameters("p_details", DB_TYPE.Varchar2, 2000, null, DIRECTION.Output);

                SQL_PROCEDURE("DPU.GET_PENALTY_EX");

                result[0] = GetParameter("p_details").ToString().Trim();

                amntRet = Convert.ToDecimal(GetParameter("p_totalint_nom").ToString());
                amntPay = Convert.ToDecimal(GetParameter("p_penyaint_nom").ToString());

                result[2] = Convert.ToString((amntRet - amntPay));

                amntRet = Convert.ToDecimal(GetParameter("p_tax_inc_ret").ToString());
                amntPay = Convert.ToDecimal(GetParameter("p_tax_inc_pay").ToString());

                result[3] =  Convert.ToString((amntRet-amntPay));

                amntRet = Convert.ToDecimal(GetParameter("p_tax_mil_ret").ToString());
                amntPay = Convert.ToDecimal(GetParameter("p_tax_mil_pay").ToString());

                result[4] = Convert.ToString((amntRet - amntPay));

                string fileName = Path.GetTempFileName();
                using (StreamWriter sw = new StreamWriter(fileName, false, System.Text.Encoding.GetEncoding(1251)))
                {
                    sw.Write(result[0]);
                }
                result[1] = fileName;
            }
            finally
            {
                DisposeOraConnection();
            }

            return result;
        }

        /// <summary>
        /// Стягнення штрафу при достроковому поверененні коштів по деп. дог.
        /// </summary>
        /// <param name="sDptId">ід. деп. дог.</param>
        /// <param name="sTotPnyAmnt">сума штрафу в копійках</param>
        /// <param name="sIntPnyAmnt">сума відсотків нарахованих по штрафній ставці</param>
        /// <param name="sTaxIncAmnt">сума повернення утриманого податку на прибуток з ФО</param>
        /// <param name="sTaxMilAmnt">сума повернення утриманого військового збору   з ФО</param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string payPenaltyEx(string sDptId, string sTotPnyAmnt, string sIntPnyAmnt, string sTaxIncAmnt, string sTaxMilAmnt)
        {
            string result = string.Empty;
            
            try
            {
                InitOraConnection();

                SetParameters("p_dpuid", DB_TYPE.Decimal, Convert.ToDecimal(sDptId), DIRECTION.Input);
                SetParameters("p_penalty", DB_TYPE.Decimal, Convert.ToDecimal(sTotPnyAmnt), DIRECTION.Input);
                SetParameters("p_int_pay", DB_TYPE.Decimal, Convert.ToDecimal(sIntPnyAmnt), DIRECTION.Input);
                SetParameters("p_tax_inc_ret", DB_TYPE.Decimal, Convert.ToDecimal(sTaxIncAmnt), DIRECTION.Input);
                SetParameters("p_tax_mil_ret", DB_TYPE.Decimal, Convert.ToDecimal(sTaxMilAmnt), DIRECTION.Input);

                SQL_PROCEDURE("DPU.PENALTY_PAYMENT");

                DBLogger.Info("Користувач виконав штрафування депозитного договору № " + sDptId, "barsroot.udeposit");
            }
            catch(Exception ex)
            {
                result = ex.Message;
            }
            finally
            {
                DisposeOraConnection();
            }

            return result;
        }

        ///// <summary>
        ///// Проводки по утриманню штрафу
        ///// </summary>
        ///// <param name="dpt_id"></param>
        ///// <param name="date"></param>
        ///// <param name="sPenalty"></param>
        ///// <param name="sKv"></param>
        ///// <returns></returns>
        //[WebMethod(EnableSession = true)]
        //public string payPenalty(string dpt_id, string date, string sPenalty, string sKv)
        //{
        //    string result = string.Empty;

        //    try
        //    {
        //        InitOraConnection();

        //        string bankMfo = GetGlobalParam("MFO", "BASIC_INFO");

        //        SetParameters("p_dpuid", DB_TYPE.Decimal, dpt_id, DIRECTION.Input);

        //        // НАДРА БАНК
        //        if (bankMfo == "380764")
        //        {
        //            SetParameters("p_penalty", DB_TYPE.Decimal, sPenalty, DIRECTION.Input);
        //            SetParameters("p_int_pay", DB_TYPE.Decimal, 0, DIRECTION.Input);

        //            SQL_PROCEDURE("DPU.PENALTY_PAYMENT");

        //            DBLogger.Info("Користувач виконав штрафування депозитного договору № " + dpt_id, "barsroot.udeposit");
        //        }
        //        else
        //        {
        //            DateTime bdate = Convert.ToDateTime(date, cinfo);
        //            oper_stuct oper = new oper_stuct();

        //            ArrayList reader = SQL_reader(@"SELECT a.acc, a.nls, a.ostb, b.acc, b.nls, b.ostb, i.acrb, i.acr_dat, d.closed,
        //                    d.mfo_p, d.nls_p, d.nms_p, d.nd, to_char(d.datz,'DD.mm.YYYY'), user_id
        //               FROM accounts a, dpu_deal d, int_accn i, accounts b 
        //              WHERE d.acc = a.acc 
        //                AND a.acc = i.acc 
        //                AND i.id = 1 
        //                AND i.acra = b.acc 
        //                AND d.dpu_id = :dpt_id");
        //            string nls = Convert.ToString(reader[1]);
        //            string accn = Convert.ToString(reader[3]);

        //            decimal ostb_pl = Convert.ToDecimal(reader[5]);
        //            string acc7 = Convert.ToString(reader[6]);
        //            string nd = Convert.ToString(reader[12]);
        //            string datz = Convert.ToString(reader[13]);
        //            string user_id = Convert.ToString(reader[14]);
        //            short kv = Convert.ToInt16(sKv);

        //            ClearParameters();
        //            SetParameters("accn", DB_TYPE.Decimal, accn, DIRECTION.Input);
        //            reader = SQL_reader(@"SELECT a.nls, substr(a.nms,1,38), c.okpo
        //              FROM accounts a, customer c
        //             WHERE a.rnk = c.rnk AND a.acc = :accn");

        //            if (reader.Count > 0)
        //            {
        //                oper.NlsA = Convert.ToString(reader[0]);
        //                oper.NamA = Convert.ToString(reader[1]);
        //                oper.OkpoA = Convert.ToString(reader[2]);
        //                oper.KvA = kv;
        //            }
        //            else
        //            {
        //                return "Не знайдений рахунок нарахованих відсотків для депозитного договору  №" + dpt_id;
        //            }

        //            ClearParameters();
        //            SetParameters("p_dpuid", DB_TYPE.Decimal, dpt_id, DIRECTION.Input);
        //            reader = SQL_reader(@"SELECT a.nls, a.kv, substr(a.nms,1,38), c.okpo
        //                FROM accounts a
        //                JOIN customer c on ( c.RNK = a.rnk ) 
        //               WHERE (a.kf, a.nls, a.kv) in ( select r.KF, r.G67N, 980 
        //                                                from PROC_DR$base  r 
        //                                                join DPU_VIDD v on ( v.vidd = r.rezid AND v.bsd = r.nbs )
        //                                                join DPU_DEAL d on ( d.vidd = v.vidd  AND d.branch = r.branch ) 
        //                                               where d.dpu_id = :p_dpuid 
        //                             and r.sour = 4 )");
        //            if (reader.Count > 0)
        //            {
        //                oper.NlsB  = Convert.ToString(reader[0]);
        //                oper.KvB   = Convert.ToInt16(reader[1]);
        //                oper.NamB  = Convert.ToString(reader[2]);
        //                oper.OkpoB = Convert.ToString(reader[3]);
        //            }
        //            else
        //            {
        //                return "Не знайдений рахунок зменшення витрат для депозитного договору №" + dpt_id;
        //            }
                    
        //            string vob = "6";
        //            decimal penaltyQ = 0;
        //            decimal penalty = Convert.ToDecimal(sPenalty);
        //            decimal penaltyD = Math.Max(penalty - ostb_pl, 0);

        //            if (kv != 980)
        //            {
        //                vob = Convert.ToString(SQL_SELECT_scalar("SELECT min(vob) FROM tts_vob WHERE tt = 'DUS' AND vob <> 6"));
        //                if (string.IsNullOrEmpty(vob))
        //                    vob = "16";
        //                //
        //                ClearParameters();
        //                SetParameters("RatO", DB_TYPE.Decimal, 0, DIRECTION.InputOutput);
        //                SetParameters("RatB", DB_TYPE.Decimal, 0, DIRECTION.InputOutput);
        //                SetParameters("RatS", DB_TYPE.Decimal, 0, DIRECTION.InputOutput);
        //                SetParameters("Kv1", DB_TYPE.Decimal, kv, DIRECTION.Input);
        //                SetParameters("Kv2", DB_TYPE.Decimal, 980, DIRECTION.Input);
        //                SetParameters("Dat", DB_TYPE.Date, bdate, DIRECTION.Input);
        //                SQL_PROCEDURE("gl.x_rat");
        //                string sRatO = Convert.ToString(GetParameter("RatO")).Replace(",", ".");
        //                decimal RatO = Convert.ToDecimal(sRatO, cinfo);
        //                penaltyQ = penalty * RatO;
        //            }
        //            else
        //            {
        //                vob = "6";
        //                penaltyQ = penalty;
        //            }
        //            oper.Vob = Convert.ToInt16(vob);
        //            oper.Nazn = "Повернення зайво нарахованих відсотків при достроковому розірванні депозитного договору №" + nd + " від " + datz;

        //            oper.con = Bars.Classes.OraConnector.Handler.UserConnection;

        //            oper.TT = "DUS";
        //            oper.Dk = 1;
        //            oper.Nd = "";
        //            oper.DatD = DateTime.Now;
        //            oper.DatP = DateTime.Now;
        //            oper.DatV1 = bdate;
        //            oper.DatV2 = bdate;
        //            oper.BankA = bankMfo;
        //            oper.BankB = bankMfo;
        //            oper.SA = Math.Abs(penalty);
        //            oper.SB = Math.Abs(penaltyQ);
        //            oper.OperId = user_id;

        //            cDoc ourDoc = new cDoc(oper.con, oper.Ref, oper.TT, oper.Dk, oper.Vob,
        //                    oper.Nd,
        //                    oper.DatD, oper.DatP, oper.DatV1, oper.DatV2,
        //                    oper.NlsA, oper.NamA, oper.BankA, "", oper.KvA, oper.SA, oper.OkpoA,
        //                    oper.NlsB, oper.NamB, oper.BankB, "", oper.KvB, oper.SB, oper.OkpoB,
        //                    oper.Nazn, "", oper.OperId, oper.Sign, oper.Sk, oper.Prty, 0,
        //                    "", "", "", "");
        //            if (ourDoc.oDoc())
        //            {
        //                long Ref = ourDoc.Ref;
        //                if (penaltyD > 0)
        //                {
        //                    oper.Ref = Ref;
        //                    oper.con = Bars.Classes.OraConnector.Handler.UserConnection;
        //                    oper.TT = "DUT";
        //                    oper.Dk = 1;
        //                    oper.Vob = 6;

        //                    oper.NlsB = oper.NlsA;
        //                    oper.NamB = "";
        //                    oper.OkpoB = "";
        //                    oper.KvB = kv;

        //                    oper.NlsA = nls;
        //                    oper.NamA = "";
        //                    oper.OkpoA = "";
        //                    oper.KvA = kv;

        //                    oper.SA = Math.Abs(penaltyD);
        //                    oper.SB = 0;

        //                    PayV(1, Ref, oper.DatV1, oper.TT, oper.Dk, oper.KvA, oper.NlsA, oper.SA, oper.KvB, oper.NlsB, oper.SB);

        //                }
        //            }
        //            else
        //            {
        //                return "Неможливо оплатити операцію DUS!";
        //            }
        //        }
        //    }
        //    finally
        //    {
        //        DisposeOraConnection();
        //    }
        //    return result;
        //}

        private void PayV(decimal pay, decimal rf, DateTime datv, string tt, decimal dk, decimal kva, string nlsa, decimal sa, decimal kvb, string nlsb, decimal sb)
        {
            ClearParameters();
            SetParameters("Pay", DB_TYPE.Decimal, pay, DIRECTION.Input);
            SetParameters("Ref", DB_TYPE.Decimal, rf, DIRECTION.Input);
            SetParameters("DatV", DB_TYPE.Date, datv, DIRECTION.Input);
            SetParameters("TT", DB_TYPE.Varchar2, tt, DIRECTION.Input);
            SetParameters("Dk", DB_TYPE.Decimal, dk, DIRECTION.Input);
            SetParameters("KvA", DB_TYPE.Decimal, kva, DIRECTION.Input);
            SetParameters("NlsA", DB_TYPE.Varchar2, nlsa, DIRECTION.Input);
            SetParameters("SA", DB_TYPE.Decimal, sa, DIRECTION.Input);
            SetParameters("KvB", DB_TYPE.Decimal, kvb, DIRECTION.Input);
            SetParameters("NlsB", DB_TYPE.Varchar2, nlsb, DIRECTION.Input);
            SetParameters("SB", DB_TYPE.Decimal, sb, DIRECTION.Input);
            SQL_NONQUERY("begin gl.PAYV(:Pay,:Ref,:DatV,:TT,:Dk,:KvA,:NlsA,:SA,:KvB,:NlsB,:SB);end;");
            ClearParameters();
        }

        //Mfo
        [WebMethod(EnableSession = true)]
        public string getMfo(string id)
        {
            string result = string.Empty;
            try
            {
                InitOraConnection();
                SetRole(base_role);
                SetParameters("ID", DB_TYPE.Decimal, id, DIRECTION.Input);
                result = Convert.ToString(SQL_SELECT_scalar("SELECT nb FROM banks WHERE nvl(blk,0) <>4 AND mfo=:ID"));
            }
            finally
            {
                DisposeOraConnection();
            }
            return result;
        }
        //Nls
        [WebMethod(EnableSession = true)]
        public string[] getNls(string nls, string kv, string rnk)
        {
            string[] result = new string[2];
            try
            {
                InitOraConnection();
                SetRole(base_role);
                SetParameters("kv", DB_TYPE.Decimal, kv, DIRECTION.Input);
                SetParameters("nls", DB_TYPE.Varchar2, nls, DIRECTION.Input);
                ArrayList array = SQL_reader("SELECT ca.rnk, a.nms FROM accounts a, cust_acc ca " +
                                             "WHERE a.kv=:kv AND a.nls=:nls and ca.acc=a.acc AND a.dazs is null");
                if (array.Count != 0)
                {
                    result[0] = array[0].ToString();
                    result[1] = array[1].ToString();
                }
            }
            finally
            {
                DisposeOraConnection();
            }
            return result;
        }
        //Customer
        [WebMethod(EnableSession = true)]
        public string[] getClientInfo(string rnk)
        {
            string[] result = new string[5];
            try
            {
                InitOraConnection();
                SetRole(base_role);
                SetParameters("rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);
                //
                ArrayList array = SQL_reader("SELECT c.rnk,c.okpo,c.nmk, c.adr, (SELECT substr(w.value, 1, 1) FROM customerw w WHERE w.tag = 'K013' AND w.rnk = c.rnk) FROM customer c WHERE c.rnk=:rnk and c.date_off IS NULL AND (c.custtype = 2 OR (c.custtype = 3 AND substr(c.sed, 1, 2) IN ('91', '34')))");
                if (array.Count != 0)
                {
                    result[0] = Convert.ToString(array[0]);
                    result[1] = Convert.ToString(array[1]);
                    result[2] = Convert.ToString(array[2]);
                    result[3] = Convert.ToString(array[3]);
                    result[4] = Convert.ToString(array[4]);
                }
            }
            finally
            {
                DisposeOraConnection();
            }
            return result;
        }
        //Check number of add deal
        [WebMethod(EnableSession = true)]
        public string CheckNd(string dpt_gen, string nd, string branch)
        {
            string result = string.Empty;
            try
            {
                InitOraConnection();
                SetRole(base_role);
                if (dpt_gen != string.Empty)
                {
                    SetParameters("dpt_gen", DB_TYPE.Decimal, dpt_gen, DIRECTION.Input);
                    SetParameters("nd", DB_TYPE.Varchar2, nd, DIRECTION.Input);
                    result = Convert.ToString(SQL_SELECT_scalar("SELECT count(*) FROM dpu_deal WHERE dpu_gen=:dpt_gen and dpu_add=:nd"));
                }
                else
                {
                    // SetParameters("branch", DB_TYPE.Varchar2, branch, DIRECTION.Input);
                    // SetParameters("nd", DB_TYPE.Varchar2, nd, DIRECTION.Input);
                    // result = Convert.ToString(SQL_SELECT_scalar("SELECT SIGN(dpu.f_calc_nd(:branch) - :nd) from dual "));
                    result = "0";
                }

            }
            finally
            {
                DisposeOraConnection();
            }
            return result;
        }

        // Параметри виду депозиту
        [WebMethod(EnableSession = true)]
        public object[] getVal(string id, string dateN)
        {
            object[] result = new object[23];
            try
            {
                InitOraConnection();
                SetRole(base_role);
                SetParameters("ID", DB_TYPE.Decimal, id, DIRECTION.Input);
                ArrayList reader = SQL_reader("select d.TERM_MAX, d.KV, t.lcv, t.name, d.freq_v, f.name, d.br_id, b.name, NVL(d.comproc,0), NVL(d.fl_extend,0)" +
                                              "     , d.id_stop, s.name, d.bsd, d.bsn, d.DPU_TYPE, br.branch, br.name, d.SHABLON" +
                                              "     , nvl(d.MIN_SUMM,0)/100, nvl(d.MAX_SUMM,0)/100, nvl(d.TERM_TYPE,2)" +
                                              "  from TABVAL t, DPU_VIDD d, FREQ f, BRATES b, DPT_STOP s, BRANCH br " + 
                                              " where br.BRANCH = sys_context('bars_context','user_branch') and d.kv=t.kv(+) and d.freq_v=f.freq(+) " +
                                              "   and d.BR_ID = b.BR_ID(+) and d.ID_STOP = s.ID(+) and d.VIDD = :id" );
                if (reader.Count != 0)
                {
                    reader.CopyTo(result);
                }
                if (result[0].ToString() != string.Empty && dateN != string.Empty)
                {
                    decimal term = Convert.ToDecimal(result[0], cinfo);
                    int month = (int)term;
                    int days = (int)((term - month) * 10000);

                    ClearParameters();
                    SetParameters("dateN", DB_TYPE.Date, Convert.ToDateTime(dateN, cinfo), DIRECTION.Input);
                    SetParameters("mnth", DB_TYPE.Decimal, month, DIRECTION.Input);
                    SetParameters("days", DB_TYPE.Decimal, days, DIRECTION.Input);

                    string dateO = SQL_SELECT_scalar("select to_char(BARS.DPU.F_DURATION(:dateN,:mnth,:days),'dd.MM.yyyy') from DUAL").ToString();

                    result[21] = dateO;

                    string dateV = SQL_SELECT_scalar("select to_char(DAT_NEXT_U(BARS.DPU.F_DURATION(:dateN,:mnth,:days),1),'dd.MM.yyyy') from DUAL").ToString();

                    result[22] = dateV;
                }
            }
            finally
            {
                DisposeOraConnection();
            }
            return result;
        }
        //UpdateDeal
        [WebMethod(EnableSession = true)]
        public string UpdateDeal(string[] data)
        {
            bool txCommited = false;
            string result = string.Empty;
            try
            {
                InitOraConnection();
                BeginTransaction();
                SetRole(base_role);

                DateTime datz_ = (data[7] != "") ? (Convert.ToDateTime(data[7], cinfo)) : (DateTime.MinValue);// дата заключения
                DateTime datn_ = (data[5] != "") ? (Convert.ToDateTime(data[5], cinfo)) : (DateTime.MinValue);// дата начала
                DateTime dato_ = (data[6] != "") ? (Convert.ToDateTime(data[6], cinfo)) : (DateTime.MinValue);// дата окончания
                DateTime datv_ = (data[8] != "") ? (Convert.ToDateTime(data[8], cinfo)) : (DateTime.MinValue);// дата возврата
                DateTime datBr = (data[26] != "") ? (Convert.ToDateTime(data[26], cinfo)) : (DateTime.MinValue);// дата проц. ставки

                SetParameters("dpu_id", DB_TYPE.Decimal, data[16], DIRECTION.Input);
                SetParameters("nd", DB_TYPE.Varchar2, data[0], DIRECTION.Input);
                SetParameters("sum", DB_TYPE.Decimal, data[1], DIRECTION.Input);
                SetParameters("min_sum", DB_TYPE.Decimal, data[2], DIRECTION.Input);
                SetParameters("freqv", DB_TYPE.Varchar2, data[3], DIRECTION.Input);
                SetParameters("id_stop", DB_TYPE.Varchar2, data[4], DIRECTION.Input);
                if (datz_ == DateTime.MinValue)
                    SetParameters("datz_", DB_TYPE.Date, null, DIRECTION.Input);
                else
                    SetParameters("datz_", DB_TYPE.Date, datz_, DIRECTION.Input);
                if (datn_ == DateTime.MinValue)
                    SetParameters("datn_", DB_TYPE.Date, null, DIRECTION.Input);
                else
                    SetParameters("datn_", DB_TYPE.Date, datn_, DIRECTION.Input);
                if (dato_ == DateTime.MinValue)
                    SetParameters("dato_", DB_TYPE.Date, null, DIRECTION.Input);
                else
                    SetParameters("dato_", DB_TYPE.Date, dato_, DIRECTION.Input);
                if (datv_ == DateTime.MinValue)
                    SetParameters("datv_", DB_TYPE.Date, null, DIRECTION.Input);
                else
                    SetParameters("datv_", DB_TYPE.Date, datv_, DIRECTION.Input);
                SetParameters("mfo_d", DB_TYPE.Varchar2, data[9], DIRECTION.Input);
                SetParameters("nls_d", DB_TYPE.Varchar2, data[10], DIRECTION.Input);
                SetParameters("nms_d", DB_TYPE.Varchar2, data[11], DIRECTION.Input);
                SetParameters("mfo_p", DB_TYPE.Varchar2, data[12], DIRECTION.Input);
                SetParameters("nls_p", DB_TYPE.Varchar2, data[13], DIRECTION.Input);
                SetParameters("nms_p", DB_TYPE.Varchar2, data[14], DIRECTION.Input);
                SetParameters("okpo_p", DB_TYPE.Varchar2, data[28], DIRECTION.Input);
                SetParameters("ir_", DB_TYPE.Varchar2, data[23], DIRECTION.Input);
                SetParameters("op_", DB_TYPE.Varchar2, data[25], DIRECTION.Input);
                SetParameters("br_", DB_TYPE.Varchar2, data[24], DIRECTION.Input);
                if (datBr == DateTime.MinValue)
                    SetParameters("p_indrate", DB_TYPE.Date, null, DIRECTION.Input);
                else
                    SetParameters("p_indrate", DB_TYPE.Date, datBr, DIRECTION.Input);
                SetParameters("branch_", DB_TYPE.Varchar2, data[27], DIRECTION.Input);
                SetParameters("trust_id", DB_TYPE.Decimal, 0, DIRECTION.Input);
                SetParameters("comments", DB_TYPE.Varchar2, data[15], DIRECTION.Input);

                SQL_PROCEDURE("dpu.upd_dealparams");

                CommitTransaction();
                txCommited = true;
                DBLogger.Info("Пользователь изменил параметры депозитного договора № " + data[16], "barsroot.udeposit");
            }
            finally
            {
                if (!txCommited) RollbackTransaction();
                DisposeOraConnection();
            }
            return result;
        }

        //InsertDeal
        [WebMethod(EnableSession = true)]
        public string[] InsertDeal(string[] data)
        {
            string[] result = new string[2];
            try
            {
                InitOraConnection();

                SetRole(base_role);

                string nd_ = (data[0].Length > 35) ? (data[0].Substring(0, 35)) : (data[0]); //номер договора
                string rnk_ = data[20];   // рег.№ клиента
                string vidd_ = data[25];  // вид депозита
                decimal sum_ = Convert.ToDecimal(data[1], cinfo) / 100;  // сумма договора
                DateTime datz_ = (data[7] != "") ? (Convert.ToDateTime(data[7], cinfo)) : (DateTime.MinValue);// дата заключения
                DateTime datn_ = (data[5] != "") ? (Convert.ToDateTime(data[5], cinfo)) : (DateTime.MinValue);// дата начала
                DateTime dato_ = (data[6] != "") ? (Convert.ToDateTime(data[6], cinfo)) : (DateTime.MinValue);// дата окончания
                DateTime datv_ = (data[8] != "") ? (Convert.ToDateTime(data[8], cinfo)) : (DateTime.MinValue);// дата возврата
                string mfov_ = (data[12].Length > 12) ? (data[12].Substring(0, 12)) : (data[12]);  // МФО для выплаты %%
                string nlsv_ = (data[13].Length > 15) ? (data[13].Substring(0, 15)) : (data[13]);  // счет для выплаты %%
                string nmsv_ = (data[14].Length > 38) ? (data[14].Substring(0, 38)) : (data[14]);  // получатель %%
                string mfop_ = (data[9].Length > 12) ? (data[9].Substring(0, 12)) : (data[9]);  // МФО для возврата депозита
                string nlsp_ = (data[10].Length > 15) ? (data[10].Substring(0, 15)) : (data[10]);  // счет для возврата депозита
                string nmsp_ = (data[11].Length > 38) ? (data[11].Substring(0, 38)) : (data[11]);  // получатель депозита
                string freq_ = data[26];  // период-ть выплаты %%
                decimal comproc_ = Convert.ToDecimal(data[27]);// признак капитализации %%
                string id_stop_ = data[28];// код штрафа
                decimal min_sum_ = Convert.ToDecimal(data[2], cinfo) / 100;// сумма неснижаемого остатка
                string ir_ = data[21]; // индивид.%-ная ставка
                string br_ = data[22];// код базовой ставки
                string op_ = data[23];// код операции меджу BR и IR
                string comment_ = (data[15].Length > 128) ? (data[15].Substring(0, 128)) : (data[15]);// комментарий
                decimal grp_ = Convert.ToDecimal(data[29]);// группа доступа
                decimal isp_ = Convert.ToDecimal(data[30]);// ответ.исполнитель
                string dpu_id_ = string.Empty;//  референс договора
                string dpu_gen_ = data[31];//  референс договора
                string branch_ = data[32];//  отделение
                string err_ = string.Empty;// сообщение об ошибке 
                string trustId = Convert.ToString(data[19]); // Id доверенного лица

                SetParameters("nd_", DB_TYPE.Varchar2, nd_, DIRECTION.Input);
                if (dpu_gen_ != string.Empty)
                    SetParameters("dpu_gen_ ", DB_TYPE.Varchar2, dpu_gen_, DIRECTION.Input);
                SetParameters("rnk_", DB_TYPE.Decimal, rnk_, DIRECTION.Input);
                SetParameters("vidd_", DB_TYPE.Decimal, vidd_, DIRECTION.Input);
                SetParameters("sum_", DB_TYPE.Decimal, sum_, DIRECTION.Input);
                if (datz_ == DateTime.MinValue)
                    SetParameters("datz_", DB_TYPE.Date, null, DIRECTION.Input);
                else
                    SetParameters("datz_", DB_TYPE.Date, datz_, DIRECTION.Input);
                if (datn_ == DateTime.MinValue)
                    SetParameters("datn_", DB_TYPE.Date, null, DIRECTION.Input);
                else
                    SetParameters("datn_", DB_TYPE.Date, datn_, DIRECTION.Input);
                if (dato_ == DateTime.MinValue)
                    SetParameters("dato_", DB_TYPE.Date, null, DIRECTION.Input);
                else
                    SetParameters("dato_", DB_TYPE.Date, dato_, DIRECTION.Input);
                if (datv_ == DateTime.MinValue)
                    SetParameters("datv_", DB_TYPE.Date, null, DIRECTION.Input);
                else
                    SetParameters("datv_", DB_TYPE.Date, datv_, DIRECTION.Input);
                SetParameters("mfov_", DB_TYPE.Varchar2, mfov_, DIRECTION.Input);
                SetParameters("nlsv_", DB_TYPE.Varchar2, nlsv_, DIRECTION.Input);
                SetParameters("nmsv_", DB_TYPE.Varchar2, nmsv_, DIRECTION.Input);
                SetParameters("mfop_", DB_TYPE.Varchar2, mfop_, DIRECTION.Input);
                SetParameters("nlsp_", DB_TYPE.Varchar2, nlsp_, DIRECTION.Input);
                SetParameters("nmsp_", DB_TYPE.Varchar2, nmsp_, DIRECTION.Input);
                SetParameters("freq_", DB_TYPE.Varchar2, freq_, DIRECTION.Input);
                SetParameters("comproc_", DB_TYPE.Decimal, comproc_, DIRECTION.Input);
                SetParameters("id_stop_", DB_TYPE.Varchar2, id_stop_, DIRECTION.Input);
                SetParameters("min_sum_", DB_TYPE.Decimal, min_sum_, DIRECTION.Input);
                SetParameters("ir_", DB_TYPE.Varchar2, ir_, DIRECTION.Input);
                SetParameters("br_", DB_TYPE.Varchar2, br_, DIRECTION.Input);
                SetParameters("op_", DB_TYPE.Varchar2, op_, DIRECTION.Input);
                SetParameters("comment_", DB_TYPE.Varchar2, comment_, DIRECTION.Input);
                SetParameters("grp_", DB_TYPE.Varchar2, null, DIRECTION.Input);
                SetParameters("isp_", DB_TYPE.Decimal, isp_, DIRECTION.Input);
                if (dpu_gen_ == string.Empty)
                    SetParameters("branch_", DB_TYPE.Varchar2, branch_, DIRECTION.Input);
                SetParameters("trust_id", DB_TYPE.Varchar2, trustId, DIRECTION.Input);
                if (dpu_gen_ != string.Empty)
                    SetParameters("old_dpu_id_", DB_TYPE.Decimal, DBNull.Value, DIRECTION.Input);
                SetParameters("dpu_id_", DB_TYPE.Decimal, dpu_id_, DIRECTION.Output);
                SetParameters("err_", DB_TYPE.Varchar2, err_, DIRECTION.Output);

                if (dpu_gen_ != string.Empty)
                    SQL_PROCEDURE("dpu.p_open_deposit_line");
                else
                    SQL_PROCEDURE("dpu.p_open_standart");

                result[0] = Convert.ToString(GetParameter("dpu_id_"));
                string err = Convert.ToString(GetParameter("err_"));
                if (err == "null")
                    err = "";
                result[1] = err;

                if (dpu_gen_ != string.Empty)
                    DBLogger.Info("Пользователь создал новое доп. соглашени № " + result[0], "BarsWeb.DepositU");
                else
                    DBLogger.Info("Пользователь создал новый депозитный договор № " + result[0], "BarsWeb.DepositU");
            }
            finally
            {
                DisposeOraConnection();
            }
            return result;
        }

        /// <summary>
        /// Пролонгація депозиту
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string ProlongationDeal(string[] data)
        {
            bool txCommited = false;
            string result = string.Empty;
            try
            {
                InitOraConnection();
                BeginTransaction();
                SetRole(base_role);

                DateTime bdat_ = (data[0] != "") ? (Convert.ToDateTime(data[0], cinfo)) : (DateTime.MinValue);
                DateTime dato_ = (data[2] != "") ? (Convert.ToDateTime(data[2], cinfo)) : (DateTime.MinValue);

                // банківська дата
                if (bdat_ == DateTime.MinValue)
                    SetParameters("p_bdat", DB_TYPE.Date, null, DIRECTION.Input);
                else
                    SetParameters("p_bdat", DB_TYPE.Date, bdat_, DIRECTION.Input);

                // id депозиту
                SetParameters("p_dpuid", DB_TYPE.Decimal, data[1], DIRECTION.Input);

                // нова дата завершення договору
                if (dato_ == DateTime.MinValue)
                    SetParameters("p_datend", DB_TYPE.Date, null, DIRECTION.Input);
                else
                    SetParameters("p_datend", DB_TYPE.Date, dato_, DIRECTION.Input);

                // відсоткова ставка по договору після пролонгації
                SetParameters("p_rate", DB_TYPE.Varchar2, data[3], DIRECTION.Input);

                SQL_PROCEDURE("dpu.deal_prolongation");

                CommitTransaction();

                txCommited = true;

                DBLogger.Info("Користувач пролонгував депозитний договір № " + data[1], "barsroot.udeposit");
            }
            finally
            {
                if (!txCommited) RollbackTransaction();
                DisposeOraConnection();
            }
            return result;
        }

        /// <summary>
        /// Закриття депозиту
        /// </summary>
        /// <param name="dpu_id"></param>
        /// <param name="flag"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string CloseDeal(string dpu_id)
        {
            string result = string.Empty;

            OracleString error_msg = null;
            
            try
            {
                InitOraConnection();
                // BeginTransaction();
                SetRole(base_role);

                ClearParameters();

                // id депозиту
                SetParameters("dpu_id", DB_TYPE.Decimal, dpu_id, DIRECTION.Input);
                SetParameters("p_errmsg", DB_TYPE.Varchar2, 2000, null, DIRECTION.Output);

                SQL_PROCEDURE("dpu.close_deal");

                error_msg = (OracleString)GetParameter("p_errmsg");

                if (error_msg.IsNull)
                {
                    DBLogger.Info("Користувач закрив депозитний договір № " + dpu_id, "barsroot.udeposit");
                }
                else
                {
                    result = error_msg.ToString();
                }
            }
            catch (Exception ex)
            {
                result = ex.Message;
            }
            finally
            {
                DisposeOraConnection();
            }

            return result;

        }
        
        //GetProcs
        [WebMethod(EnableSession = true)]
        public string GetProcs(string vidd, string dat_open, string dat_close, string sum)
        {
            string result = string.Empty;
            try
            {
                InitOraConnection();
                SetRole(base_role);

                SetParameters("vidd", DB_TYPE.Decimal, vidd, DIRECTION.Input);
                SetParameters("dat_open", DB_TYPE.Date, Convert.ToDateTime(dat_open, cinfo), DIRECTION.Input);
                SetParameters("dat_close", DB_TYPE.Date, Convert.ToDateTime(dat_close, cinfo), DIRECTION.Input);
                SetParameters("sum", DB_TYPE.Decimal, sum, DIRECTION.Input);

                result = Convert.ToString(SQL_SELECT_scalar("select dpu.f_calc_rate(:vidd,:dat_open,:dat_close,:sum) from dual"));
            }
            finally
            {
                DisposeOraConnection();
            }
            return result;
        }

        /// <summary>
        /// GetProcEx
        /// </summary>
        /// <param name="vidd"></param>
        /// <param name="dat_open"></param>
        /// <param name="dat_close"></param>
        /// <param name="sum"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public decimal[] GetProcEX(string vidd, string dat_open, string dat_close, string sum)
        {
            decimal[] result = new decimal[2];
            try
            {
                InitOraConnection();
                SetRole(base_role);

                ClearParameters();

                SetParameters("typeid", DB_TYPE.Decimal, DBNull.Value, DIRECTION.Input);
                SetParameters("kv", DB_TYPE.Decimal, DBNull.Value, DIRECTION.Input);
                SetParameters("vidd", DB_TYPE.Decimal, vidd, DIRECTION.Input);
                SetParameters("amount", DB_TYPE.Decimal, sum, DIRECTION.Input);
                SetParameters("datbeg", DB_TYPE.Date, Convert.ToDateTime(dat_open, cinfo), DIRECTION.Input);
                SetParameters("datend", DB_TYPE.Date, Convert.ToDateTime(dat_close, cinfo), DIRECTION.Input);
                SetParameters("actrate", DB_TYPE.Decimal, 24, null, DIRECTION.Output);
                SetParameters("maxrate", DB_TYPE.Decimal, 24, null, DIRECTION.Output);
                SetParameters("p_penya_rate", DB_TYPE.Decimal, 24, null, DIRECTION.Output);

                SQL_NONQUERY(@"begin 
                                 dpu.get_scalerate( p_typeid => :typeid, p_kv => :kv, p_vidd => :vidd, 
                                                    p_amount => :amount, p_datbeg  => :datbeg, p_datend => :datend,
                                                    p_actrate => :actrate, p_maxrate => :maxrate, p_recid => :recid);
                               end;");

                result[0] = Convert.ToDecimal(GetParameter("actrate"));
                result[1] = Convert.ToDecimal(GetParameter("maxrate"));
            }
            finally
            {
                DisposeOraConnection();
            }

            return result;
        }

        [WebMethod(EnableSession = true)]
        public string[] GetGenAccounts(string nGen)
        {
            string[] result = new string[3];
            try
            {
                InitOraConnection();
                SetRole(base_role);

                SetParameters("nGen", DB_TYPE.Decimal, Convert.ToDecimal(nGen), DIRECTION.Input);
                ArrayList reader = SQL_reader("SELECT d.nd, ad.nls, ap.nls FROM dpt_u d, accounts ad, accounts ap WHERE d.acc = ad.acc AND d.acra = ap.acc AND d.dpu_id = :nGEN");
                if (reader.Count != 0)
                {
                    reader.CopyTo(result);
                    return result;
                }
            }
            finally
            {
                DisposeOraConnection();
            }
            return null;
        }

        [WebMethod(EnableSession = true)]
        public string[] GetSecAccounts(string nAcc2)
        {
            string[] result = new string[2];
            try
            {
                InitOraConnection();
                SetRole(base_role);

                SetParameters("nAcc2", DB_TYPE.Decimal, Convert.ToDecimal(nAcc2), DIRECTION.Input);
                ArrayList reader = SQL_reader("SELECT d.nls, p.nls FROM accounts d, int_accn i, accounts p WHERE d.acc = i.acc AND i.id = 1 AND i.acra = p.acc AND d.acc = :nAcc2");
                if (reader.Count != 0)
                {
                    reader.CopyTo(result);
                    return result;
                }
            }
            finally
            {
                DisposeOraConnection();
            }
            return null;
        }

        /// <summary>
        /// Дата закінчення депозитного договору
        /// </summary>
        /// <param name="sDateBegin">Дата початку договору</param>
        /// <param name="sVIDD">Вид депозиту</param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string GetDateEnd(string sDateBegin, string sVIDD)
        {
            string result = string.Empty;

            if ((sDateBegin != string.Empty) && (sVIDD != string.Empty))
            {
                DBLogger.Info("GetDateEnd(sDateBegin=" + sDateBegin + ", sVIDD=" + sVIDD +")" );

                DateTime DateBegin = Convert.ToDateTime(sDateBegin, cinfo);
                Decimal Vidd = Convert.ToDecimal(sVIDD, cinfo);

                try
                {
                    InitOraConnection();

                    // SetRole(base_role);
                    // ClearParameters();

                    SetParameters("dateN", DB_TYPE.Date, DateBegin, DIRECTION.Input);

                    SetParameters("vidd", DB_TYPE.Decimal, Vidd, DIRECTION.Input);

                    result = SQL_SELECT_scalar("select to_char(add_months(:dateN, trunc(TERM_MAX)) + ((TERM_MAX - trunc(TERM_MAX)) * 10000 - 1),'DD.MM.YYYY') from DPU_VIDD where VIDD = :vidd").ToString();
                }
                finally
                {
                    DisposeOraConnection();
                }
            }

            return result;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="vidd"></param>
        /// <param name="dateN"></param>
        /// <param name="dateO"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string DptValidateDate(string vidd, string dateN, string dateO)
        {
            DateTime startDate = Convert.ToDateTime(dateN, cinfo);
            DateTime endDate = Convert.ToDateTime(dateO, cinfo);
            try
            {
                InitOraConnection();
                SetRole(base_role);
                SetParameters("vidd", DB_TYPE.Decimal, vidd, DIRECTION.Input);
                SetParameters("datN", DB_TYPE.Date, startDate, DIRECTION.Input);
                SetParameters("datO", DB_TYPE.Date, endDate, DIRECTION.Input);
                return Convert.ToString(SQL_SELECT_scalar("SELECT dpu.date_validate(:vidd,:datN,:datO) FROM dual"));
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        /// <summary>
        /// Дата повернення
        /// </summary>
        /// <param name="kv"></param>
        /// <param name="start_date"></param>
        /// <param name="step"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string CorrectDate(string kv, string start_date, byte step)
        {
            // DBLogger.Info("CorrectDate(" + kv + ", " + start_date + ", " + step + ").", "BarsWeb.DepositU");

            DateTime startDate;

            if (string.IsNullOrEmpty(start_date)) {
                startDate = Convert.ToDateTime(BankType.GetBankDate(), cinfo);
            }
            else {
	        startDate = Convert.ToDateTime(start_date, cinfo);
	    }

            if (BankType.GetDptBankType() == BANKTYPE.SBER)
            {
                // Для Ощадбанку дата повернення = дата завершення + 1 день
                startDate = startDate.AddDays(1);
            }

            try
            {
                InitOraConnection();
                SetRole(base_role);

                while (true)
                {
                    ClearParameters();
                    SetParameters("kv", DB_TYPE.Decimal, kv, DIRECTION.Input);
                    SetParameters("dat", DB_TYPE.Date, startDate, DIRECTION.Input);
                    string result = Convert.ToString(SQL_SELECT_scalar("SELECT kv FROM holiday WHERE (kv=980 or kv=:kv) and holiday=:dat"));
                    if (string.IsNullOrEmpty(result)) break;
                    startDate = startDate.AddDays(step);
                }
            }
            finally
            {
                DisposeOraConnection();
            }
            return startDate.ToString("dd.MM.yyyy");
        }

        [WebMethod(EnableSession = true)]
        public object[] GetDepositLines(string[] data)
        {
            object[] arr = new object[2];
            try
            {
                InitOraConnection();
                SetRole(base_role);
                string filter = @"o.ref = n.ref1 
					   AND o.sos = 5
					   AND n.ref2 IS NULL 
					   AND a.acc = n.acc
					   AND o.ref = p.ref 
					   AND p.acc = a.acc
					   AND p.sos = 5 
					   AND p.dk = 1 
					   AND a.acc IN (SELECT distinct accc FROM accounts 
					   WHERE nvl(substr(nbs,1,1),'0') IN ('0','8') AND accc IS NOT NULL)";
                if (data[9] != string.Empty && data[9].Trim() != "null")
                {
                    filter += " AND a.tip=:tip";
                    SetParameters("tip", DB_TYPE.Varchar2, data[9], DIRECTION.Input);
                }
                data[3] = "a.kv DESC, p.fdat, o.s";
                object[] tmp = BindTableWithNewFilter("a.acc ACC, a.kv KV, a.nls NLS, a.nms NMS, a.ostc/100 OSTC, a.ostb/100 OSTB," +
                    "(SELECT sum(ostc)/100 FROM accounts WHERE accc = a.ACC) OST8," +
                    "n.ref1 REF1, TO_CHAR(p.fdat, 'dd.MM.yyyy') FDAT, o.s/100 S, o.s SK, o.nazn NAZN",
                    "accounts a, nlk_ref n, oper o, opldok p", filter, data);
                arr[0] = tmp[0];
                arr[1] = tmp[1];
                DBLogger.Info("Пользователь просматривает картотеку поступлений на консолидированные балансовые счета.", "BarsWeb.DepositU");
            }
            finally
            {
                DisposeOraConnection();
            }
            return arr;
        }

        [WebMethod(EnableSession = true)]
        public string[][] GetSlaveAccounts(string acc)
        {
            string[][] result = null;
            try
            {
                InitOraConnection();
                SetRole(base_role);
                SetParameters("acc", DB_TYPE.Decimal, Convert.ToDecimal(acc), DIRECTION.Input);
                DataSet ds = SQL_SELECT_dataset(@"SELECT a.acc, a.kv, a.nls, a.nms, a.ostc/100, a.ostb/100 
					FROM accounts a
					WHERE a.accc = :acc AND a.dazs IS NULL AND 
					nvl(substr(a.nbs,1,1),'0') IN ('0','8')
					ORDER BY a.nls");
                result = new string[ds.Tables[0].Rows.Count][];
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    result[i] = new string[ds.Tables[0].Rows[i].ItemArray.Length];
                    for (int j = 0; j < ds.Tables[0].Rows[i].ItemArray.Length; j++)
                    {
                        if (j == 4 || j == 5)
                            result[i][j] = String.Format("{0:##### #### ##0.00}", Convert.ToDecimal(ds.Tables[0].Rows[i].ItemArray.GetValue(j)));
                        else
                            result[i][j] = Convert.ToString(ds.Tables[0].Rows[i].ItemArray.GetValue(j));
                    }
                }
            }
            finally
            {
                DisposeOraConnection();
            }
            return result;
        }
        [WebMethod(EnableSession = true)]
        public int SeizeFromCardIndex(string acc, string ref1)
        {
            if (String.IsNullOrEmpty(acc) || String.IsNullOrEmpty(ref1))
            {
                return 0;
            }
            else
            {
                try
                {
                    InitOraConnection();
                    SetRole(base_role);
                    SetParameters("acc", DB_TYPE.Decimal, Convert.ToDecimal(acc), DIRECTION.Input);
                    SetParameters("ref1", DB_TYPE.Decimal, Convert.ToDecimal(ref1), DIRECTION.Input);
                    int res = SQL_NONQUERY("DELETE FROM NLK_REF WHERE ACC = :acc AND REF1 = :ref1");
                    return res;
                }
                finally
                {
                    DisposeOraConnection();
                }
            }
        }

        [WebMethod(EnableSession = true)]
        public int Register(string vdat, string sk, string acc1, string ref1, string acc2)
        {
            if (String.IsNullOrEmpty(acc1) || String.IsNullOrEmpty(acc2) ||
                String.IsNullOrEmpty(sk) || String.IsNullOrEmpty(vdat) ||
                String.IsNullOrEmpty(ref1))
            {
                return 0;
            }
            else
            {
                try
                {
                    InitOraConnection();
                    SetRole(base_role);

                    ClearParameters();
                    SetParameters("vdat", DB_TYPE.Date, Convert.ToDateTime(vdat), DIRECTION.Input);
                    SQL_NONQUERY("begin gl.bdate:=:vdat; end;");

                    ClearParameters();
                    SetParameters("sk1", DB_TYPE.Decimal, Convert.ToDecimal(sk), DIRECTION.Input);
                    SetParameters("sk2", DB_TYPE.Decimal, Convert.ToDecimal(sk), DIRECTION.Input);
                    SetParameters("acc1", DB_TYPE.Decimal, Convert.ToDecimal(acc1), DIRECTION.Input);
                    SQL_NONQUERY("UPDATE accounts SET dapp = gl.bd, ostc=ostc+:sk1, ostb=ostb+:sk2 WHERE acc=:acc1");

                    ClearParameters();
                    SQL_NONQUERY("begin gl.param; end;");

                    ClearParameters();
                    SetParameters("ref1", DB_TYPE.Decimal, Convert.ToDecimal(ref1), DIRECTION.Input);
                    SetParameters("acc2", DB_TYPE.Decimal, Convert.ToDecimal(acc2), DIRECTION.Input);
                    SQL_NONQUERY("UPDATE nlk_ref SET ref2=ref1 WHERE ref1=:ref1 AND acc=:acc2");
                    return 1;
                }
                finally
                {
                    DisposeOraConnection();
                }
            }
        }

        #region AdditionalOptions

        /// <summary>
        /// Реквізити довіреної особи по депозитному договору
        /// </summary>
        /// <param name="trust_id"></param>
        /// <returns></returns>
        public object[] GetConfidantInfo(decimal trust_id)
        {
            object[] result = new object[3];

            try
            {
                InitOraConnection();
                SetRole(base_role);
                
                SetParameters("p_dpuid", DB_TYPE.Decimal, trust_id, DIRECTION.Input);

                ArrayList reader = SQL_reader("select FIO, POSITION, DOCUMENT" +
                                              "  from BARS.V_TRUSTEE_ALLOW2SIGN" +
                                              " where ID = :trust_id" );
                if (reader.Count != 0)
                {
                    reader.CopyTo(result);
                }
                //else
                //{
                //    result = null;
                //}
            }
            catch (Exception ex)
            {
                DBLogger.Error(ex.Message);
            }
            finally
            {
                DisposeOraConnection();
            }

            return result;
        }

        /// <summary>
        /// Збереження змін в додаткових парамерах депозитного договору
        /// </summary>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string SetAdditionalOptions(decimal dpu_id, string[] data)
        {
            string result = string.Empty;

            // 1st parteposit");
            string trust_id = data[0].Trim();
            string comments = data[1].Trim();

            OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

            try
            {
                OracleCommand cmd = connect.CreateCommand();

                cmd.CommandText = "update DPU_DEAL set TRUSTEE_ID = nvl(:trust_id,TRUSTEE_ID), COMMENTS = :comments where DPU_ID = :dpu_id";

                // trust_id
                if (string.IsNullOrEmpty(trust_id))
                    cmd.Parameters.Add("trust_id", OracleDbType.Decimal, DBNull.Value, ParameterDirection.Input );
                else
                    cmd.Parameters.Add("trust_id", OracleDbType.Decimal, Convert.ToDecimal(trust_id), ParameterDirection.Input);

                // comments
                if (string.IsNullOrEmpty(comments))
                    cmd.Parameters.Add("comments", OracleDbType.Varchar2, DBNull.Value, ParameterDirection.Input );
                else
                    cmd.Parameters.Add("comments", OracleDbType.Varchar2, comments, ParameterDirection.Input);

                // dpu_id
                cmd.Parameters.Add("dpu_id", OracleDbType.Decimal, dpu_id, ParameterDirection.Input);

                cmd.ExecuteNonQuery();

                DBLogger.Info("Користувач вніс зміни в параметри депозитного договору #" + dpu_id.ToString(), "barsroot.udeposit");

            }
            catch (Exception ex)
            {
                result = "Помилка при збереженні параметрів депозитного договору #" + dpu_id.ToString() + "\r\n(" + ex.Message + ")";
                DBLogger.Info("data[0]=(" + trust_id + ")", "barsroot.udeposit");
                DBLogger.Info("data[1]=(" + comments + ")", "barsroot.udeposit");
                DBLogger.Error(ex.Message);
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }

            // 2nd part
            int objLendth = data.Length;

            if (objLendth > 2)
            {
                string[] param = new string[2];

                try
                {
                    InitOraConnection();
                    SetRole(base_role);

                    for (int i = 2; i < objLendth; i++)
                    {

                        DBLogger.Info("data[i]=" + data[i], "barsroot.udeposit");

                        param = data[i].Split('|');

                        ClearParameters();

                        if (param[0] == "IS_PLEDGE")
                        {
                            // ід. депозитного договору
                            SetParameters("p_dpuid", DB_TYPE.Decimal, dpu_id, DIRECTION.Input);

                            if (String.IsNullOrWhiteSpace(param[1]))
                            {
                                // Розблокування депозиту
                                SetParameters("p_nd", DB_TYPE.Decimal, DBNull.Value, DIRECTION.Input);
                            }
                            else
                            {
                                // блокування депозиту
                                SetParameters("p_nd", DB_TYPE.Decimal, Convert.ToDecimal(param[1]), DIRECTION.Input);
                            }

                            //
                            SetParameters("p_errmsg", DB_TYPE.Varchar2, 2000, null, DIRECTION.Output);

                            SQL_PROCEDURE("dpu.block_contract");

                            result = Convert.ToString(GetParameter("p_errmsg"));
                        }
                        else
                        {
                            // ід. депозитного договору
                            SetParameters("p_dpuid", DB_TYPE.Decimal, dpu_id, DIRECTION.Input);

                            // код додаткового параметру
                            SetParameters("p_tag", DB_TYPE.Varchar2, param[0], DIRECTION.Input);

                            // значення додаткового параметру
                            SetParameters("p_value", DB_TYPE.Varchar2, param[1], DIRECTION.Input);

                            SQL_PROCEDURE("dpu.set_parameters");

                            DBLogger.Info("Користувач вніс зміни в дод. парам. депозитного договору #" + data[1], "barsroot.udeposit");
                        }
                    }
                }
                catch (Exception ex)
                {
                    result = result + (String.IsNullOrEmpty(result) ? "<br>" : "") +
                        "Помилка при збереженні дод.     парам. " + param[0] + " депозитного договору #" + dpu_id;
                    DBLogger.Error(ex.Message);
                }
                finally
                {
                    DisposeOraConnection();
                }
            }
            
            return result;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="dpu_id"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public object[] GetAdditionalOptions(decimal dpu_id)
        {
            object[] result = new object[1];
            ArrayList Options = new ArrayList();

            try
            {
                InitOraConnection();
                SetRole(base_role);

                // TRUSTEE_ID and COMMENTS
                SetParameters("p_dpuid", DB_TYPE.Decimal, dpu_id, DIRECTION.Input);

                Options = SQL_reader("select d.TRUSTEE_ID, d.COMMENTS" +
                                     "  from BARS.DPU_DEAL d" +
                                     " where d.DPU_ID = :p_dpuid");

                // TAGs
                ClearParameters();

                SetParameters("p_dpuid", DB_TYPE.Decimal, dpu_id, DIRECTION.Input);

                SQL_Reader_Exec("select NAME, VALUE, TAG, DIRECTORY_NAME, KEY_FIELD" +
                                "  from BARS.V_DPU_DEALW " +
                                " where DPU_ID = :p_dpuid)" );

                while (SQL_Reader_Read())
                {
                    ArrayList reader = SQL_Reader_GetValues();
                    Options.Add(String.Format("{0};{1};{2};{3}:{4}", Convert.ToString(reader[0]), Convert.ToString(reader[1])
                                      , Convert.ToString(reader[2]), Convert.ToString(reader[3]), Convert.ToString(reader[4])));
                }
                SQL_Reader_Close();
            }
            catch (Exception ex)
            {
                DBLogger.Error(ex.Message);
                // HttpContext.Current.Session["AppError"] = ex;
            }
            finally
            {
                DisposeOraConnection();
            }

            if (Options.Count != 0)
            {
                // Resize the array to a bigger size
                Array.Resize(ref result, Options.Count);
                Options.CopyTo(result);
            }
            else
            {
                result = null;
            }
            
            return result;
        }
        #endregion

        #region SwiftDetails
        /// <summary>
        /// SWIFT реквізити для виплат по договору (read from DB)
        /// </summary>
        /// <param name="dpu_id"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public object[] GetSwiftDetails(Int64 dpu_id)
        {
            object[] result = new object[10];

            try
            {
                InitOraConnection();

                SetParameters("p_dpuid", DB_TYPE.Decimal, dpu_id, DIRECTION.Input);

                ArrayList reader = SQL_reader("select TAG56_NAME, TAG56_ADR, TAG56_CODE" +
                                              "     , TAG57_NAME, TAG57_ADR, TAG57_CODE, TAG57_ACC" +
                                              "     , TAG59_NAME, TAG59_ADR, TAG59_ACC" +
                                              "  from BARS.DPU_DEAL_SWTAGS" +
                                              " where DPU_ID = :p_dpuid" );
                if (reader.Count != 0)
                {
                    reader.CopyTo(result);
                }
                else //  if ( String.IsNullOrEmpty(Convert.ToString(reader[7])) && String.IsNullOrEmpty(Convert.ToString(reader[8])))
                {
                    reader = SQL_reader("select null, null, null, null, null, null, null" +
                                        "     , BARS_SWIFT.STRVERIFY2( upper( coalesce(c.NMKV,F_TRANSLATE_KMU(c.NMK)) ), 'TRANS' )" +
                                        "     , BARS_SWIFT.STRVERIFY2( upper( F_TRANSLATE_KMU(c.ADR) ), 'TRANS' )"+
                                        "     , d.NLS_D" +
                                        "  from DPU_DEAL d" +
                                        "  join CUSTOMER c" +
                                        "    on ( c.RNK = d.RNK )" +
                                        " where d.DPU_ID = :p_dpuid" );
                    reader.CopyTo(result);
                }
            }
            finally
            {
                DisposeOraConnection();
            }

            return result;
        }

        /// <summary>
        /// SWIFT реквізити для виплат по договору (write to DB)
        /// </summary>
        /// <param name="dpu_id"></param>
        /// <param name="data"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string SetSwiftDetails(Int64 dpu_id, string[] data)
        {
            string result = string.Empty;

            try
            {
                InitOraConnection();

                SetParameters("p_dpuid", DB_TYPE.Decimal, dpu_id, DIRECTION.Input);

                SetParameters("p_tag56_name", DB_TYPE.Varchar2, data[0], DIRECTION.Input);
                SetParameters("p_tag56_adr", DB_TYPE.Varchar2, data[1], DIRECTION.Input);
                SetParameters("p_tag56_code", DB_TYPE.Varchar2, data[2], DIRECTION.Input);
                SetParameters("p_tag57_name", DB_TYPE.Varchar2, data[3], DIRECTION.Input);
                SetParameters("p_tag57_adr", DB_TYPE.Varchar2, data[4], DIRECTION.Input);
                SetParameters("p_tag57_code", DB_TYPE.Varchar2, data[5], DIRECTION.Input);
                SetParameters("p_tag57_acc", DB_TYPE.Varchar2, data[6], DIRECTION.Input);
                SetParameters("p_tag59_name", DB_TYPE.Varchar2, data[7], DIRECTION.Input);
                SetParameters("p_tag59_adr", DB_TYPE.Varchar2, data[8], DIRECTION.Input);
                SetParameters("p_tag59_acc", DB_TYPE.Varchar2, data[9], DIRECTION.Input);

                SQL_PROCEDURE("dpu.set_dealswtags");

                DBLogger.Info("Користувач змінив SWIFT реквізити депозитного договру #" + dpu_id.ToString(), "barsroot.udeposit");
            }
            catch (Exception ex)
            {
                result = "Помилка збереження SWIFT реквізитів депозитного договору #" + dpu_id.ToString() + ": " + ex.Message;
                DBLogger.Error(ex.Message);
            }
            finally
            {
                DisposeOraConnection();
            }

            return result;
        }
        #endregion

        #region Agreements
        /// <summary>
        /// 
        /// </summary>
        /// <param name="dpu_id"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public object[] GetAgreementConditions(Int64 dpu_id)
        {
            object[] result = new object[10];

            try
            {
                InitOraConnection();

                SetParameters("p_dpuid", DB_TYPE.Decimal, dpu_id, DIRECTION.Input);

                ArrayList reader = SQL_reader("select FREQV, STOP_ID, MIN_AMNT, MAX_AMNT, FL_AUTOEXTEND" +
                                              "     , CAPITALIZATION, TERM_TYPE, DAT_END_MIN, DAT_END_MAX" +
                                              "     , BARS.DPU_AGR.GET_NEXT_END_DATE(DPU_ID)" +
                                              "  from BARS.V_DPU_AGRMNT_CONDITIONS" +
                                              " where DPU_ID = :p_dpuid");
                if (reader.Count != 0)
                {
                    reader.CopyTo(result);
                }
            }
            finally
            {
                DisposeOraConnection();
            }

            return result;
        }
        
        /// <summary>
        /// 
        /// </summary>
        /// <param name="dpu_id"></param>
        /// <param name="data"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string CreateAgreement(Int64 dpu_id, string[] data)
        {
            string result = string.Empty;

            Int32 agrmnt_tp = Convert.ToInt32(data[0]);
            DateTime? agrmnt_dt = Convert.ToDateTime(data[2], cinfo);

            String details = null;
            Int64? agrmnt_id = null;
            Int64? amount = null;
            Decimal? rate = null;
            Int32? freq = null;
            Int32? pny_id = null;
            DateTime? beg_dt = null;
            DateTime? end_dt = null;

            switch (agrmnt_tp)
            {
                case 1:
                    {
                        // ДУ про зміну суми договору
                        amount = Convert.ToInt64(data[3]) * 100;
                        break;
                    }
                case 2:
                    {
                        // ДУ про зміну відсоткової ставки по договору
                        rate = Convert.ToDecimal(data[4]);
                        break;
                    }
                case 3:
                    {
                        // ДУ про зміну періодичності виплати відсотків
                        freq = Convert.ToInt32(data[5]);
                        break;
                    }
                case 4:
                    {
                        // ДУ про зміну рахунку повернення депозиту
                        details = Uri.UnescapeDataString(data[9]);
                        // HttpUtility.UrlDecode / HttpUtility.HtmlDecode
                        break;
                    }
                case 5:
                    {
                        // ДУ про зміну терміну договору
                        end_dt = Convert.ToDateTime(data[7], cinfo);
                        break;
                    }
                case 6:
                    {
                        // ДУ про зміну періодичності виплати відсотків
                        pny_id = Convert.ToInt32(data[8]);
                        break;
                    }
                case 7:
                    {
                        // ДУ про пролонгацію договору
                        beg_dt = Convert.ToDateTime(data[6], cinfo);
                        end_dt = Convert.ToDateTime(data[7], cinfo);
                        break;
                    }
                default:
                    {
                        break;
                    }
            }

            try
            {
                InitOraConnection();

                SetParameters("p_dpu_id", DB_TYPE.Decimal, dpu_id, DIRECTION.Input);
                SetParameters("p_agrmnt_type", DB_TYPE.Decimal, agrmnt_tp, DIRECTION.Input);
                SetParameters("p_agrmnt_num", DB_TYPE.Varchar2, data[1], DIRECTION.Input);
                SetParameters("p_due_date", DB_TYPE.Date, agrmnt_dt, DIRECTION.Input);
                SetParameters("p_amount", DB_TYPE.Decimal, amount, DIRECTION.Input);
                SetParameters("p_rate", DB_TYPE.Decimal, rate, DIRECTION.Input);
                SetParameters("p_freq", DB_TYPE.Decimal, freq, DIRECTION.Input);
                SetParameters("p_begin_date", DB_TYPE.Date, beg_dt, DIRECTION.Input);
                SetParameters("p_end_date", DB_TYPE.Date, end_dt, DIRECTION.Input);
                SetParameters("p_stop_id", DB_TYPE.Decimal, pny_id, DIRECTION.Input);
                SetParameters("p_payment_dtl", DB_TYPE.Varchar2, details, DIRECTION.Input);
                SetParameters("p_agrmnt_id", DB_TYPE.Decimal, agrmnt_id, DIRECTION.Output);

                SQL_PROCEDURE("DPU_AGR.CREATE_AGREEMENT");

                DBLogger.Info("Користувач створив ДУ #" + agrmnt_id.ToString() + " до депозитного договру #" + dpu_id.ToString(), "barsroot.udeposit");
            }
            catch (Exception ex)
            {
                result = "Помилка при створенні ДУ до депозитного договору #" + dpu_id.ToString() + ": " + ex.Message;
                DBLogger.Error(ex.Message);
            }
            finally
            {
                DisposeOraConnection();
            }

            return result;
        }
        # endregion

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string DiscrepancyBalances()
        {
            string result = string.Empty;

            try
            {
                InitOraConnection();
                result = Convert.ToString(SQL_SELECT_scalar("select DPU.GET_DISCREPANCY_BALANCES(null) from DUAL"));
            }
            finally
            {
                DisposeOraConnection();
            }

            return result;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string CalcInt()
        {
            DBLogger.Info("Користувач підтвердив нарахування відсотків по депозитному портфелю", "barsroot.udeposit");
            
            string result = string.Empty;

            DateTime? bankDate = null;

            try
            {
                InitOraConnection();

                string UserLevel = Convert.ToString(SQL_SELECT_scalar("select (length(sys_context('bars_context','user_branch'))-1)/7 from dual"));

                if (UserLevel == "1")
                {
                    result = Convert.ToString(SQL_SELECT_scalar("select case " +
                    "       when ( GL.GBD() = BARS.DAT_NEXT_U(trunc(sysdate), 0)   " + // -- first_work_day_cur_mon
                    "          and GL.BD()  = BARS.DAT_NEXT_U(trunc(sysdate),-1) ) " + // -- last_work_day_prev_mon
                    "       then GL.BD() " +
                    "       else null " +
                    "       end as BANK_DT " +
                    "  from dual "));

                    if (!String.IsNullOrEmpty(result))
                    {
                        bankDate = Convert.ToDateTime(result, cinfo);
                    }

                    ClearParameters();

                    SetParameters("p_dpuid", DB_TYPE.Decimal, 0, DIRECTION.Input);
                    SetParameters("p_bdate", DB_TYPE.Date, bankDate, DIRECTION.Input);

                    SQL_PROCEDURE("DPU.AUTO_MAKE_INTEREST");
                }
                else
                {
                    result = "Заборонено виконання даної ф-ї на " + UserLevel + "-му рівні !";
                }
            }
            catch (Exception ex)
            {
                result = ex.Message;

                DBLogger.Error(result, "barsroot.udeposit");

                result = result.Substring(0, result.IndexOf("ORA-06512") - 1);

                Int32 pos = result.IndexOf("ORA-20");
                
                while (pos >= 0)
                {
                    result = result.Remove(pos, 11);
                    pos = result.IndexOf("ORA-20");
                }

                pos = result.IndexOf("DPU-00666");

                if (pos >= 0)
                {
                    result = result.Remove(pos, 10);
                }

                result = "Помилка при нарахуванні відсотків: <BR>" + result;
            }
            finally
            {
                DisposeOraConnection();
            }

            return result;
        }
        
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public string PayOutInt()
        {
            DBLogger.Info("Користувач підтвердив виплату відсотків по депозитному портфелю", "barsroot.udeposit");

            string errMsg = string.Empty;

            try
            {
                InitOraConnection();

                string UserLevel = Convert.ToString(SQL_SELECT_scalar("select (length(sys_context('bars_context','user_branch'))-1)/7 from dual"));

                if ( UserLevel == "1" )
                {
                    ClearParameters();

                    SetParameters("p_bdate", DB_TYPE.Date, null, DIRECTION.Input);

                    SQL_PROCEDURE("DPU.AUTO_PAYOUT_INTEREST");
                }
                else
                {
                    errMsg = "Заборонено виконання даної ф-ї на " + UserLevel + "-му рівні !";
                }

            }
            catch (Exception ex)
            {
                errMsg = ex.Message;

                DBLogger.Error(errMsg, "barsroot.udeposit");

                errMsg = errMsg.Substring(0, errMsg.IndexOf("ORA-06512")-1);

                Int32 pos = errMsg.IndexOf("ORA-20");

                while (pos >= 0)
                {
                    errMsg = errMsg.Remove(pos, 11);
                    pos = errMsg.IndexOf("ORA-20");
                }

                pos = errMsg.IndexOf("DPU-00666");

                if (pos >= 0)
                {
                    errMsg = errMsg.Remove(pos, 10);
                }

                errMsg = "Помилка при виплаті відсотків:<BR>" + errMsg;
            }
            finally
            {
                DisposeOraConnection();
            }

            return errMsg;
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
    }
}
