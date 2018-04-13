using System;
using System.Collections;
using System.Text;
using System.Data;
using Oracle.DataAccess.Client;
using System.Web;

namespace Bars.Doc
{

    public class BarsException : System.Exception
    {
        //Creates a constructor for the BarsException.
        public BarsException(string Message) : base(Message) { }
        public BarsException(string Message, System.Exception innerEx) : base(Message, innerEx) { }
    }
    /// <summary>
    /// Summary description for Doc
    /// </summary>
    public class cDoc
    {
        public long Ref;
        public string TT;        // тип транзакции
        public byte Dk;        // признак дебета / кредита
        public short Vob;       // вид документа
        public string Nd;        // номер документа
        public DateTime DatD;      // дата на документе
        public DateTime DatV1;     // дата валютирования документа 1
        public DateTime DatV2;     // дата валютирования документа 2
        public DateTime DatP;      // дата ввода документа
        public Storona A;         // сторона А
        public Storona B;         // сторона Б
        public string Nazn;      // назначение платежа
        public string Drec;      // дополнительные реквизиты
        public byte Sk;        // символ кассплана
        public string Nazns;     // способ заполнения "назначения платежа"
        public string Naznk;     // код "назначения платежа"
        public byte Bis;       // номер БИС
        public string OperId;    // идентификатор операциониста
        public byte[] Sign;      // подпись на документе
        public byte SignLen;   // ширина подписи в байтах
        public short Sos;       //
        public short Otm;       // отметка на документе (в норме-0 в процессинге (1,2,3)
        public long Rec;       // номер записи в ARC_RRP
        public short Err;       // код ошибки при записи в ARC_RRP
        public decimal Nom;       // сумма номинала ЦБ
        public long RefH;      // референция parent - документа
        public long RefL;      // референция child -  документа
        public long RefF;      // референция филиала
        public string Ref_A;     // Референция отправителя (в норме = m_nRef)
        public short Prty;      // приоритет документа (0/1)
        public decimal SQ;        // эквивалент суммы
        public byte Flg;       // флаг оплаты основной операции
        public byte Fli;       // флаг межбанк
        public byte Fpy;       // флаг разрешения факт оплаты (всегда 1)
        public string ExtSignHex;	// Внешняя ЭЦП в 16-ричном формате (оно же закодированное поле byte[] Sign)
        public string IntSignHex;	// Внутренняя ЭЦП в 16-ричном формате
        public string TTFlags;      // Флаги операции
        public string SubAccount;   // Суб. счет
        /// процедура перед/після оплати. виконується в одній транзакції
        /// APROC='встановлення_ролі@повний_виклик_процедури'
        /// BPROC='встановлення_ролі@повний_виклик_процедури'
        /// 
        private string AfterPayProc;
        private string BeforePayProc;
        private long? TaxRef;

        public short Tim;       // время переинициализации подписи (в минутах)
        public string ErrMesage;
        public ArrayList DrecS;     // = new Tags[5];       // Список допреквизитов
        public OracleConnection con;
        // -----------------------------------------------------------------------------------------
        //      Локальные переменные
        // -----------------------------------------------------------------------------------------
        private DateTime DatV;
        //public OracleConnection con;
        private OracleTransaction tx;
        private byte nDk;
        private decimal nSA, nSB;
        private string sNlsM, sNlsK;
        private string sS, sS2, sTT;
        // -----------------------------------------------------------------------------------------
        public cDoc(OracleConnection con,
            long Ref,	        // референс (NUMBER_Null для новых)
            string TT,			// Код операции
            byte Dk,			// ДК (0-дебет, 1-кредит)
            short Vob,			// Вид обработки
            string Nd,			// № док
            DateTime DatD,		// Дата док
            DateTime DatP,		// Дата ввода(поступления в банк)
            DateTime DatV1,		// Дата валютирования основной операции
            DateTime DatV2,		// Дата валютирования связаной операции
            string NlsA,		// Счет-А
            string NamA,		// Наим-А
            string BankA,		// МФО-А
            string NbA,			// Наим банка-А(м.б. '')
            short KvA,			// Код вал-А
            decimal SA,			// Сумма-А
            string OkpoA,		// ОКПО-А
            string NlsB,		// Счет-Б
            string NamB,		// Наим-Б
            string BankB,		// МФО-Б
            string NbB,			// Наим банка-Б(м.б. '')
            short KvB,			// Код вал-Б
            decimal SB,			// Сумма-Б
            string OkpoB,		// ОКПО-Б
            string Nazn,		// Назначение пл
            string Drec,		// Доп реквизиты
            string OperId,		// Идентификатор ключа опрециониста
            byte[] Sign,		// ЭЦП опрециониста
            byte Sk,			// СКП
            short Prty,			// Приоритет документа
            decimal SQ,			// Эквивалент для одновалютной оп
            string ExtSignHex,	// Внешняя ЭЦП в 16-ричном формате (оно же закодированное поле byte[] Sign)
            string IntSignHex,	// Внутренняя ЭЦП в 16-ричном формате
            string pAfterPayProc, /// процедура після оплати
            string pBeforePayProc /// процедура перед оплатою
            )
        {
            this.con = con;
            this.Ref = Ref;
            this.TT = TT;
            this.Dk = Dk;
            this.Vob = Vob;
            this.Nd = DeInva(Nd);
            this.DatD = DatD.Date;
            this.DatV1 = DatV1.Date;
            this.DatV2 = DatV2.Date;
            this.DatP = DatP;
            this.A = new Storona(NlsA, NamA, BankA, NbA, KvA, SA, OkpoA);
            this.B = new Storona(NlsB, NamB, BankB, NbB, KvB, SB, OkpoB);
            this.Nazn = DeInva(Nazn);
            if (this.Nazn.Length > 160)
                this.Nazn = this.Nazn.Substring(0, 160);
            this.Sk = Sk;
            this.Prty = Prty;
            this.Drec = DeInva(Drec);
            if (this.Drec.Length > 0)
                this.Nazns = "11";
            else
                this.Nazns = "10";
            this.Naznk = null;
            this.Ref_A = null;
            this.Bis = 0;
            this.OperId = OperId;
            this.Sign = Sign;
            this.Rec = long.MinValue;
            this.RefH = long.MinValue;
            this.RefL = long.MinValue;
            this.RefF = long.MinValue;
            this.Otm = 0;
            this.SQ = SQ;
            this.Fpy = 1;
            this.ExtSignHex = ExtSignHex;
            this.IntSignHex = IntSignHex;

            this.AfterPayProc = pAfterPayProc;
            this.BeforePayProc = pBeforePayProc;

            this.DrecS = new ArrayList();
        }
        /// <summary>
        /// 
        /// </summary>
        public class Storona
        {
            public string Nls;  // номер счета
            public string Nam;  // намиенвание счета
            public string Bank; // код банка
            public string Nb;   // наименование банка
            public short Kv;   // код валюты
            public decimal S;    // сумма
            public string Okpo; // код клиента
            public Storona(string Nls, string Nam, string Bank, string Nb, short Kv, decimal S, string Okpo)
            {
                this.Nls = Nls.Trim();
                this.Nam = Nam.Trim();
                this.Bank = Bank.Trim();
                this.Nb = Nb.Trim();
                this.Kv = Kv;
                this.S = S;
                this.Okpo = Okpo.Trim();
            }
        }
        /// <summary>
        /// 
        /// </summary>
        public class Tags
        {
            public string Tag; // Тег
            public string Val; // Значение
            public Tags(string Tag, string Val)
            { this.Tag = Tag; this.Val = Val; }
        }
        /// <summary>
        /// Оплата документа
        /// </summary>
        /// <returns></returns>
        public bool oDocument()
        {
            if (!String.IsNullOrEmpty(this.BeforePayProc))
                RunPayProc(this.BeforePayProc);

            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = "SELECT dk,nlsm,nlsk,fli,SUBSTR(flags,38,1),name, flags, s, s2 FROM tts WHERE tt=:TT";
            cmd.Parameters.Add("TT", OracleDbType.Varchar2, this.TT, ParameterDirection.Input);

            OracleDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                nDk = (byte)rdr.GetOracleDecimal(0).Value;
                try
                {
                    if (rdr.GetOracleString(1).IsNull) sNlsM = string.Empty;
                    else sNlsM = rdr.GetOracleString(1).Value;
                }
                catch (InvalidCastException) { sNlsM = string.Empty; }
                try
                {
                    if (rdr.GetOracleString(2).IsNull) sNlsK = string.Empty;
                    else sNlsK = rdr.GetOracleString(2).Value;
                }
                catch (InvalidCastException) { sNlsK = string.Empty; }
                this.Fli = rdr.GetOracleDecimal(3).ToByte();
                this.Flg = (byte)Convert.ToDecimal(rdr.GetOracleString(4).Value);
                string sNam = rdr.GetOracleString(5).Value;
                this.TTFlags = Convert.ToString(rdr.GetValue(6));
                try
                {
                    if (rdr.GetOracleString(7).IsNull) sS = string.Empty;
                    else sS = rdr.GetOracleString(7).Value;
                }
                catch (InvalidCastException) { sS = string.Empty; }
                try
                {
                    if (rdr.GetOracleString(8).IsNull) sS2 = string.Empty;
                    else sS2 = rdr.GetOracleString(8).Value;
                }
                catch (InvalidCastException) { sS2 = string.Empty; }
            }
            rdr.Close();
            rdr.Dispose();

            // читаем параметр INTSIGN
            cmd.CommandText = "SELECT to_number(val) FROM params WHERE par='INTSIGN'";
            rdr = cmd.ExecuteReader();
            int par_INTSIGN = 0;
            if (rdr.Read()) par_INTSIGN = (int)rdr.GetDecimal(0);
            rdr.Close();

            // проверка: оплата документов в СЭП по факту запрещена !
            if (1 == Fli && 1 == Flg) throw new BarsException("Оплата документов в СЭП по факту запрещена!");

            // ===========================
            if (this.Ref == 0 || this.Ref == long.MinValue) this.Ref = cRef();
            if (this.Nd == "") this.Nd = Convert.ToString(this.Ref, 10);
            // ===========================
            if (!iDoc()) return false;
            ////
            if (this.TT == "ЧЕК")
            {
                nSA = this.A.S;
                if (this.A.Kv == this.B.Kv)
                    nSB = Decimal.MinValue;
                else
                    nSB = this.B.S;
                nSA = sTrans(nSA, sS);
                nSB = sTrans(nSB, sS2);
            }
            //// 
            // ===========================
            if (!iDop()) return false;
            // ===========================


            if (sNlsM == string.Empty) sNlsM = A.Nls;
            if (sNlsK == string.Empty) sNlsK = B.Nls;
            if ((this.Flg == 0 || this.Flg == 1) && (this.Dk == 0 || this.Dk == 1))
            {
                if (!PayTT(0, this.Ref, this.DatV1, this.TT, this.Dk, this.A.Kv, this.A.Nls, this.A.S, this.B.Kv, this.B.Nls, this.B.S)) return false;
            }
            if (!pLnk()) return false;
            // оплата по-факту, если надо
            if (1 == Flg) FullPay();

            // запись внешней и внутренней ЭЦП при включенном режиме INTSIGN=2
            if (2 == par_INTSIGN) PutVisa();

            if (!String.IsNullOrEmpty(this.AfterPayProc))
                RunPayProc(this.AfterPayProc);

            
            //-----если присуцтвует параметр обработки после оплаты---
            //if (AfterPayProc != string.Empty) RunAfterPayProc();

            return true;
        }
        /// <summary>
        /// Оплата документа (оболочка)
        /// </summary>
        /// <returns></returns>
        public bool oDoc()
        {
            bool txCommitted = false;

            tx = con.BeginTransaction();

            try
            {
                if (oDocument())
                {
                    tx.Commit();
                    txCommitted = true;
                }
            }
            finally
            {
                if (!txCommitted) tx.Rollback();
                con.Close();
                con.Dispose();
            }
            return true;
        }
        /// <summary>
        /// Оплата по-факту
        /// </summary>
        public void FullPay()
        {
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = "begin gl.pay(2,:ref,gl.bDATE); end;";
            cmd.Parameters.Add("ref", OracleDbType.Decimal, this.Ref, ParameterDirection.Input);
            try
            { cmd.ExecuteNonQuery(); }
            catch (OracleException e)
            {
                throw new BarsException("cRef:" + GetBarsErrMess(e.Message), e);
            }
        }
        /// <summary>
        /// Получение нового референса
        /// </summary>
        /// <returns></returns>
        public long cRef()
        {
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = "gl.ref";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("ref", OracleDbType.Decimal, this.Ref, ParameterDirection.InputOutput);  //0
            try
            { cmd.ExecuteNonQuery(); }
            catch (OracleException e)
            {
                throw new BarsException("cRef:" + GetBarsErrMess(e.Message), e);
            }
            return Convert.ToInt64(cmd.Parameters["ref"].Value.ToString());
        }
        /// <summary>
        /// Вставка документа в OPER
        /// </summary>
        /// <returns></returns>
        public bool iDoc()
        {
            if ((DateTime.Compare(this.DatV2, DateTime.MinValue) == 0) ||
                (DateTime.Compare(this.DatV2, this.DatV1) > 0))
                DatV = this.DatV2;
            else
                DatV = this.DatV1;

            OracleCommand cmd = con.CreateCommand();
            string sNlsA = this.A.Nls;
            string sNamA = this.A.Nam;
            string sNlsB = this.B.Nls;
            string sNamB = this.B.Nam;
            
            // Проверка на 24 флаг - передача суб-счета
            bool isSubAccount = (!string.IsNullOrEmpty(this.TTFlags) && this.TTFlags.Length > 24 && this.TTFlags.Substring(24,1) == "1");

            if(isSubAccount)
                cmd.CommandText = "gl.in_doc4";
            else
                cmd.CommandText = "gl.in_doc2";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("ref", OracleDbType.Decimal, this.Ref, ParameterDirection.Input);  //0
            cmd.Parameters.Add("tt", OracleDbType.Varchar2, this.TT, ParameterDirection.Input);  //1
            cmd.Parameters.Add("vob", OracleDbType.Decimal, this.Vob, ParameterDirection.Input);  //2
            cmd.Parameters.Add("nd", OracleDbType.Varchar2, this.Nd, ParameterDirection.Input);  //3
            cmd.Parameters.Add("pdat", OracleDbType.Date, DateTime.Now, ParameterDirection.Input);  //4
            cmd.Parameters.Add("vdat", OracleDbType.Date, this.DatV, ParameterDirection.Input);  //5
            cmd.Parameters.Add("dk", OracleDbType.Decimal, this.Dk, ParameterDirection.Input);  //6  		
            cmd.Parameters.Add("kv", OracleDbType.Decimal, this.A.Kv, ParameterDirection.Input);  //7
            cmd.Parameters.Add("s", OracleDbType.Decimal, this.A.S, ParameterDirection.Input);  //8
            cmd.Parameters.Add("kv2", OracleDbType.Decimal, this.B.Kv, ParameterDirection.Input);  //9
            cmd.Parameters.Add("s2", OracleDbType.Decimal, this.B.S, ParameterDirection.Input);  //10
            cmd.Parameters.Add("sq", OracleDbType.Decimal, this.SQ, ParameterDirection.Input);  //11
            if (this.Sk != byte.MinValue)
                cmd.Parameters.Add("sk", OracleDbType.Decimal, this.Sk, ParameterDirection.Input); //12
            else
                cmd.Parameters.Add("sk", OracleDbType.Decimal, null, ParameterDirection.Input);	//12

            if (isSubAccount) // доп. параметр - суб. счет
                cmd.Parameters.Add("sub", OracleDbType.Decimal, this.SubAccount, ParameterDirection.Input);	//12

            cmd.Parameters.Add("data", OracleDbType.Date, this.DatD, ParameterDirection.Input);  //13
            cmd.Parameters.Add("datp", OracleDbType.Date, this.DatP.Date, ParameterDirection.Input);  //14

            cmd.Parameters.Add("nam_a", OracleDbType.Varchar2,
                sNamA.Length < 38 ? sNamA : sNamA.Substring(0, 38),
                ParameterDirection.Input);  //15
            cmd.Parameters.Add("nlsa", OracleDbType.Varchar2, sNlsA, ParameterDirection.Input);  //16
            cmd.Parameters.Add("mfoa", OracleDbType.Varchar2, this.A.Bank, ParameterDirection.Input);  //17
            cmd.Parameters.Add("nam_b", OracleDbType.Varchar2,
                sNamB.Length < 38 ? sNamB : sNamB.Substring(0, 38),
                ParameterDirection.Input);  //18
            cmd.Parameters.Add("nlsb", OracleDbType.Varchar2, sNlsB, ParameterDirection.Input);  //19
            cmd.Parameters.Add("mfob", OracleDbType.Varchar2, this.B.Bank, ParameterDirection.Input);  //20
            cmd.Parameters.Add("nazn", OracleDbType.Varchar2, this.Nazn, ParameterDirection.Input);  //21
            cmd.Parameters.Add("d_rec", OracleDbType.Varchar2, this.Drec, ParameterDirection.Input);  //22
            cmd.Parameters.Add("id_a", OracleDbType.Varchar2, this.A.Okpo, ParameterDirection.Input);  //23
            cmd.Parameters.Add("id_b", OracleDbType.Varchar2, this.B.Okpo, ParameterDirection.Input);  //24
            cmd.Parameters.Add("id_o", OracleDbType.Varchar2, this.OperId, ParameterDirection.Input);  //25
            cmd.Parameters.Add("sign", OracleDbType.Raw, this.Sign, ParameterDirection.Input);  //26
            cmd.Parameters.Add("sos", OracleDbType.Decimal, this.Sos, ParameterDirection.Input);  //27
            cmd.Parameters.Add("prty", OracleDbType.Decimal, this.Prty, ParameterDirection.Input);  //28
            cmd.Parameters.Add("uid", OracleDbType.Decimal, null, ParameterDirection.Input);  //29

            try
            { cmd.ExecuteNonQuery(); }
            catch (OracleException e)
            {
                throw new BarsException("iDoc: " + GetBarsErrMess(e.Message), e);
            }
            return true;
        }
        /// <summary>
        /// Вставка допреквизитов
        /// </summary>
        /// <returns></returns>
        public bool iDop()
        {
            foreach (Tags rec in this.DrecS)
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandText = "INSERT INTO operw (ref, tag, value) VALUES (:ref, :tag, :val)";
                cmd.Parameters.Add("ref", OracleDbType.Decimal, this.Ref, ParameterDirection.Input);  //0
                cmd.Parameters.Add("tag", OracleDbType.Varchar2, rec.Tag, ParameterDirection.Input);
                cmd.Parameters.Add("val", OracleDbType.Varchar2, rec.Val, ParameterDirection.Input);
                cmd.CommandType = CommandType.Text;
                try
                { cmd.ExecuteNonQuery(); }
                catch (OracleException e)
                { throw new BarsException("OPERW:" + GetBarsErrMess(e.Message), e); }
            }
            return true;
        }
        /// <summary>
        /// 
        /// </summary>
        public void PutVisa()
        {
            Bars.Oracle.IOraConnection icon = new Bars.Oracle.Connection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = "begin chk.put_visa(:p_ref,:p_tt,:p_grp,:p_status,:p_keyid,:p_sign1,:p_sign2); end;";
                cmd.Parameters.Add("p_ref", OracleDbType.Long, this.Ref, ParameterDirection.Input);
                cmd.Parameters.Add("p_tt", OracleDbType.Varchar2, this.TT, ParameterDirection.Input);
                cmd.Parameters.Add("p_grp", OracleDbType.Long, null, ParameterDirection.Input);
                cmd.Parameters.Add("p_status", OracleDbType.Long, 0, ParameterDirection.Input);
                cmd.Parameters.Add("p_keyid", OracleDbType.Varchar2, this.OperId, ParameterDirection.Input);
                cmd.Parameters.Add("p_sign1", OracleDbType.Varchar2, this.IntSignHex, ParameterDirection.Input);
                cmd.Parameters.Add("p_sign2", OracleDbType.Varchar2, this.ExtSignHex, ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            catch (OracleException e)
            {
                throw new BarsException("AfterPayProc:" + GetBarsErrMess(e.Message), e);
            }
        }
        /// <summary>
        /// Собственно оплата
        /// </summary>
        /// <param name="Flg"></param>
        /// <param name="Ref"></param>
        /// <param name="DatV"></param>
        /// <param name="TT"></param>
        /// <param name="Dk"></param>
        /// <param name="KvA"></param>
        /// <param name="NlsA"></param>
        /// <param name="SA"></param>
        /// <param name="KvB"></param>
        /// <param name="NlsB"></param>
        /// <param name="SB"></param>
        /// <returns></returns>
        public bool PayTT(byte Flg, long Ref, DateTime DatV, string TT, byte Dk, short KvA, string NlsA, decimal SA, short KvB, string NlsB, decimal SB)
        {
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = "PAYTT";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("flg", OracleDbType.Decimal, Flg, ParameterDirection.Input);  //0
            cmd.Parameters.Add("ref", OracleDbType.Decimal, Ref, ParameterDirection.Input);  //1
            cmd.Parameters.Add("vdat", OracleDbType.Date, DatV, ParameterDirection.Input);  //2
            cmd.Parameters.Add("tt", OracleDbType.Varchar2, TT, ParameterDirection.Input);  //3
            cmd.Parameters.Add("dk", OracleDbType.Decimal, Dk, ParameterDirection.Input);  //4
            cmd.Parameters.Add("kva", OracleDbType.Decimal, KvA, ParameterDirection.Input);  //5
            cmd.Parameters.Add("nlsa", OracleDbType.Varchar2, NlsA, ParameterDirection.Input);  //6
            cmd.Parameters.Add("sa", OracleDbType.Decimal, SA, ParameterDirection.Input);  //7
            cmd.Parameters.Add("kvb", OracleDbType.Decimal, KvB, ParameterDirection.Input);  //8
            cmd.Parameters.Add("nlsb", OracleDbType.Varchar2, NlsB, ParameterDirection.Input);  //9
            if (SB == Decimal.MinValue)
                cmd.Parameters.Add("sb", OracleDbType.Decimal, null, ParameterDirection.Input); //10
            else
                cmd.Parameters.Add("sb", OracleDbType.Decimal, SB, ParameterDirection.Input); //10

            try
            { cmd.ExecuteNonQuery(); }
            catch (OracleException e)
            { throw new BarsException(" PAYTT: (tt=" + TT + "sa=" + SA + ",nlsa=" + NlsA + ",kva=" + KvA + ", nlsb=" + NlsB + ",kvb=" + KvB + ") " + GetBarsErrMess(e.Message), e); }
            return true;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public bool pLnk()
        {
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = "SELECT t.tt,t.dk,a.dk,t.s,t.s2 FROM tts t, ttsap a WHERE a.ttap=t.tt AND a.tt=:TT order by t.tt";
            cmd.Parameters.Add("TT", OracleDbType.Varchar2, this.TT, ParameterDirection.Input);

            OracleDataReader rdr = cmd.ExecuteReader();

            try
            {
                while (rdr.Read())
                {
                    sTT = rdr.GetOracleString(0).Value;
                    //try {nDkTT  = (byte)rdr.GetOracleDecimal(1).Value;}
                    //catch (InvalidCastException) {nDkTT = 1;}
                    nDk = (byte)rdr.GetOracleDecimal(2).Value;
                    try
                    {
                        if (rdr.GetOracleString(3).IsNull) sS = string.Empty;
                        else sS = rdr.GetOracleString(3).Value;
                    }
                    catch (InvalidCastException) { sS = string.Empty; }
                    try
                    {
                        if (rdr.GetOracleString(4).IsNull) sS2 = string.Empty;
                        else sS2 = rdr.GetOracleString(4).Value;
                    }
                    catch (InvalidCastException) { sS2 = string.Empty; }

                    if (nDk == 1)
                        if (this.Dk == 0) nDk = 1; else nDk = 0;
                    else
                        nDk = this.Dk;

                    nSA = this.A.S;

                    if (this.A.Kv == this.B.Kv)
                        nSB = Decimal.MinValue;
                    else
                        nSB = this.B.S;

                    nSA = sTrans(nSA, sS);
                    nSB = sTrans(nSB, sS2);

                    if (DateTime.Compare(this.DatV2, DateTime.MinValue) == 0)
                        DatV = this.DatV1;
                    else
                        DatV = this.DatV2;

                    if (!PayTT(0, this.Ref, DatV, sTT, nDk, this.A.Kv, this.A.Nls, nSA, this.B.Kv, this.B.Nls, nSB))
                    {
                        return false;
                    }
                }
            }
            finally
            {
                rdr.Close();
                rdr.Dispose();
                cmd.Dispose();
            }
            return true;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        private string DeInva(string s)
        {
            char[] sArray = new char[s.Length];
            s.CopyTo(0, sArray, 0, s.Length);

            for (int i = 0; i < s.Length; i++)
            {
                if (sArray[i] < ' ') sArray[i] = ' ';
            }
            return new String(sArray);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="nS"></param>
        /// <param name="sS"></param>
        /// <returns></returns>
        private decimal sTrans(decimal nS, string sS)
        {
            if (sS == string.Empty) { return nS; }
            else
            {
                StringBuilder s = new StringBuilder(sS.ToUpper());

                s.Replace("#(S)", this.A.S.ToString("#"));
                s.Replace("#(S2)", this.B.S.ToString("#"));
                s.Replace("#(NOM)", this.Nom.ToString("#"));
                s.Replace("#(NLSA)", this.A.Nls);
                s.Replace("#(NLSB)", this.B.Nls);
                s.Replace("#(MFOA)", this.A.Bank);
                s.Replace("#(MFOB)", this.B.Bank);
                s.Replace("#(KVA)", Convert.ToString(this.A.Kv, 10));
                s.Replace("#(KVB)", Convert.ToString(this.B.Kv, 10));
                s.Replace("#(REF)", Convert.ToString(this.Ref, 10));

                foreach (Tags rec in this.DrecS)
                {
                    s.Replace("#(" + rec.Tag + ")", rec.Val);
                }

                Decimal result = Decimal.MinValue;
                OracleCommand cmd = con.CreateCommand();

                //cmd.CommandText = "SELECT ROUND(" + s.ToString() + ",0) FROM dual";
                //				try
                //				{ 	return (decimal)cmd.ExecuteScalar(); }
                //				catch (OracleException e)
                //				{	throw new BarsException (" fSUM: "+GetBarsErrMess(e.Message)+cmd.CommandText, e);	}				

                cmd.CommandText = "begin DOC_STRANS(:text_,:res_);end;";
                cmd.Parameters.Add("text_", OracleDbType.Varchar2, "SELECT ROUND(" + s.ToString() + ",0) FROM dual", ParameterDirection.Input);
                cmd.Parameters.Add("res_", OracleDbType.Decimal, result, ParameterDirection.Output);

                try
                {
                    cmd.ExecuteNonQuery();
                    result = Convert.ToDecimal(cmd.Parameters["res_"].Value.ToString());
                }
                catch (System.Exception e)
                {
                    throw new BarsException(" fSUM: " + GetBarsErrMess(e.Message) + cmd.CommandText + " text_=SELECT ROUND(" + s.ToString() + ",0) FROM dual", e);
                }

                return result;
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="eMessage"></param>
        /// <returns></returns>
        private string GetBarsErrMess(string eMessage)
        {
            string s = eMessage;
            if (s.Substring(0, 6) == "ORA-20")
            {
                int i = s.IndexOf("\\");
                if (i >= 0) { s = s.Substring(i); }
                s = s.Substring(0, s.IndexOf("\n"));
            }
            return s;
        }
        /// <summary>
        /// 
        /// </summary>
        private void RunPayProc(String proc)
        {
            /// Формат стічки : 
            /// команда на встановлення ролі @ виклик процедури
            int pos = proc.IndexOf('@');
            String setRoleText = proc.Substring(0, pos);
            String commandText = proc.Substring(pos + 1);

            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = setRoleText;
            cmd.BindByName = true;
            cmd.ExecuteNonQuery();

            bool remember_taxref = false;

            if (proc.Replace(":l_taxref_in", "") != proc)
            {
                remember_taxref = true;
                cmd.Parameters.Add(":l_taxref_in", OracleDbType.Long, 38, this.TaxRef, ParameterDirection.Output);
            }

            if (proc.Replace(":REF", "") != proc)
                cmd.Parameters.Add(":REF", OracleDbType.Long, this.Ref, ParameterDirection.Input);

            if (proc.Replace(":TAXREF", "") != proc)
                cmd.Parameters.Add(":TAXREF", OracleDbType.Long, this.TaxRef, ParameterDirection.Input);

            cmd.CommandText = "begin " + commandText + " end;";
            cmd.ExecuteNonQuery();

            if (remember_taxref)
            {
                String out_taxref = Convert.ToString(cmd.Parameters[":l_taxref_in"].Value);

                if (String.IsNullOrEmpty(out_taxref))
                    this.TaxRef = null;
                else
                {
                    try
                    {
                        this.TaxRef = Convert.ToInt64(out_taxref);
                    }
                    catch (FormatException)
                    {
                        this.TaxRef = null;
                    }
                }
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="parent_ref"></param>
        /// <param name="linked_ref"></param>
        public void LinkDoc(Decimal parent_ref, Decimal linked_ref)
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = "update oper set refl=:refl where ref = :ref";
            cmd.Parameters.Add(":refl", OracleDbType.Decimal, linked_ref, ParameterDirection.Input);
            cmd.Parameters.Add(":ref", OracleDbType.Decimal, parent_ref, ParameterDirection.Input);

            cmd.ExecuteNonQuery();
        }
    }
}




