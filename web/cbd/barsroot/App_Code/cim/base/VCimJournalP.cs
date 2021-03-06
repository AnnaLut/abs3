/*
    AUTOGENERATED! Do not modify this code.
*/

using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Collections.Specialized;
using System.Data;
using System.Web.Configuration;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using ibank.core;
using Bars.Classes;

namespace cim
{
    public sealed class VCimJournalPRecord : BbRecord
    {
        public VCimJournalPRecord(): base()
        {
            fillFields();
        }
        public VCimJournalPRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VCimJournalPRecord(BbDataSource Parent, OracleDecimal RowScn, String BRANCH, Decimal? JOURNAL_NUM, Decimal? NUM, DateTime? CREATE_DATE, Decimal? RNK, String OKPO, String NMK, Decimal? BENEF_ID, String BENEF_NAME, Decimal? COUNTRY_ID, String COUNTRY_NAME, Decimal? CONTR_ID, String CONTR_NUM, DateTime? CONTR_DATE, DateTime? CONTROL_DATE, String COMMENTS, DateTime? MODIFY_DATE, DateTime? DELETE_DATE, Decimal? X_S, Decimal? DIRECT, Decimal? PAYMENT_TYPE, String PAYMENT_TYPE_NAME, Decimal? BOUND_ID, Decimal? PAYMENT_ID, DateTime? VAL_DATE, Decimal? KV_P, Decimal? S_P)
            : this(Parent)
        {
            this.BRANCH = BRANCH;
            this.JOURNAL_NUM = JOURNAL_NUM;
            this.NUM = NUM;
            this.CREATE_DATE = CREATE_DATE;
            this.RNK = RNK;
            this.OKPO = OKPO;
            this.NMK = NMK;
            this.BENEF_ID = BENEF_ID;
            this.BENEF_NAME = BENEF_NAME;
            this.COUNTRY_ID = COUNTRY_ID;
            this.COUNTRY_NAME = COUNTRY_NAME;
            this.CONTR_ID = CONTR_ID;
            this.CONTR_NUM = CONTR_NUM;
            this.CONTR_DATE = CONTR_DATE;
            this.CONTROL_DATE = CONTROL_DATE;
            this.COMMENTS = COMMENTS;
            this.MODIFY_DATE = MODIFY_DATE;
            this.DELETE_DATE = DELETE_DATE;
            this.X_S = X_S;
            this.DIRECT = DIRECT;
            this.PAYMENT_TYPE = PAYMENT_TYPE;
            this.PAYMENT_TYPE_NAME = PAYMENT_TYPE_NAME;
            this.BOUND_ID = BOUND_ID;
            this.PAYMENT_ID = PAYMENT_ID;
            this.VAL_DATE = VAL_DATE;
            this.KV_P = KV_P;
            this.S_P = S_P;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("BRANCH", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Код установи"));
            Fields.Add( new BbField("JOURNAL_NUM", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Номер журналу"));
            Fields.Add( new BbField("NUM", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Номер запису"));
            Fields.Add( new BbField("CREATE_DATE", OracleDbType.Date, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Дата реєстрації"));
            Fields.Add( new BbField("RNK", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "РНК клієнта (резидента)"));
            Fields.Add( new BbField("OKPO", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "ОКПО клієнта"));
            Fields.Add( new BbField("NMK", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Назва клієнта"));
            Fields.Add( new BbField("BENEF_ID", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "id нерезидента"));
            Fields.Add( new BbField("BENEF_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Назва нерезидента"));
            Fields.Add( new BbField("COUNTRY_ID", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "id країни"));
            Fields.Add( new BbField("COUNTRY_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Назва країни"));
            Fields.Add( new BbField("CONTR_ID", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Id контракту"));
            Fields.Add( new BbField("CONTR_NUM", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Номер контракту"));
            Fields.Add( new BbField("CONTR_DATE", OracleDbType.Date, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Дата контракту"));
            Fields.Add( new BbField("CONTROL_DATE", OracleDbType.Date, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Контрольний строк"));
            Fields.Add( new BbField("COMMENTS", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Примітка"));
            Fields.Add( new BbField("MODIFY_DATE", OracleDbType.Date, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Дата модифікації"));
            Fields.Add( new BbField("DELETE_DATE", OracleDbType.Date, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Дата видалення"));
            Fields.Add( new BbField("X_S", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Cума вторинних докуентів у валюті платежу"));
            Fields.Add( new BbField("DIRECT", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Напрям платежу"));
            Fields.Add( new BbField("PAYMENT_TYPE", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "id типу платежу"));
            Fields.Add( new BbField("PAYMENT_TYPE_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Тип платежу"));
            Fields.Add( new BbField("BOUND_ID", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Id прив`язки"));
            Fields.Add( new BbField("PAYMENT_ID", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Id платежу"));
            Fields.Add( new BbField("VAL_DATE", OracleDbType.Date, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Дата валютування"));
            Fields.Add( new BbField("KV_P", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Код валюти"));
            Fields.Add( new BbField("S_P", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_JOURNAL_P", ObjectTypes.View, "ЖУРНАЛ ПЛАТЕЖІВ", "Сума у валюті"));        
        }
        public String BRANCH { get { return (String)FindField("BRANCH").Value; } set {SetField("BRANCH", value);} }
        public Decimal? JOURNAL_NUM { get { return (Decimal?)FindField("JOURNAL_NUM").Value; } set {SetField("JOURNAL_NUM", value);} }
        public Decimal? NUM { get { return (Decimal?)FindField("NUM").Value; } set {SetField("NUM", value);} }
        public DateTime? CREATE_DATE { get { return (DateTime?)FindField("CREATE_DATE").Value; } set {SetField("CREATE_DATE", value);} }
        public Decimal? RNK { get { return (Decimal?)FindField("RNK").Value; } set {SetField("RNK", value);} }
        public String OKPO { get { return (String)FindField("OKPO").Value; } set {SetField("OKPO", value);} }
        public String NMK { get { return (String)FindField("NMK").Value; } set {SetField("NMK", value);} }
        public Decimal? BENEF_ID { get { return (Decimal?)FindField("BENEF_ID").Value; } set {SetField("BENEF_ID", value);} }
        public String BENEF_NAME { get { return (String)FindField("BENEF_NAME").Value; } set {SetField("BENEF_NAME", value);} }
        public Decimal? COUNTRY_ID { get { return (Decimal?)FindField("COUNTRY_ID").Value; } set {SetField("COUNTRY_ID", value);} }
        public String COUNTRY_NAME { get { return (String)FindField("COUNTRY_NAME").Value; } set {SetField("COUNTRY_NAME", value);} }
        public Decimal? CONTR_ID { get { return (Decimal?)FindField("CONTR_ID").Value; } set {SetField("CONTR_ID", value);} }
        public String CONTR_NUM { get { return (String)FindField("CONTR_NUM").Value; } set {SetField("CONTR_NUM", value);} }
        public DateTime? CONTR_DATE { get { return (DateTime?)FindField("CONTR_DATE").Value; } set {SetField("CONTR_DATE", value);} }
        public DateTime? CONTROL_DATE { get { return (DateTime?)FindField("CONTROL_DATE").Value; } set {SetField("CONTROL_DATE", value);} }
        public String COMMENTS { get { return (String)FindField("COMMENTS").Value; } set {SetField("COMMENTS", value);} }
        public DateTime? MODIFY_DATE { get { return (DateTime?)FindField("MODIFY_DATE").Value; } set {SetField("MODIFY_DATE", value);} }
        public DateTime? DELETE_DATE { get { return (DateTime?)FindField("DELETE_DATE").Value; } set {SetField("DELETE_DATE", value);} }
        public Decimal? X_S { get { return (Decimal?)FindField("X_S").Value; } set {SetField("X_S", value);} }
        public Decimal? DIRECT { get { return (Decimal?)FindField("DIRECT").Value; } set {SetField("DIRECT", value);} }
        public Decimal? PAYMENT_TYPE { get { return (Decimal?)FindField("PAYMENT_TYPE").Value; } set {SetField("PAYMENT_TYPE", value);} }
        public String PAYMENT_TYPE_NAME { get { return (String)FindField("PAYMENT_TYPE_NAME").Value; } set {SetField("PAYMENT_TYPE_NAME", value);} }
        public Decimal? BOUND_ID { get { return (Decimal?)FindField("BOUND_ID").Value; } set {SetField("BOUND_ID", value);} }
        public Decimal? PAYMENT_ID { get { return (Decimal?)FindField("PAYMENT_ID").Value; } set {SetField("PAYMENT_ID", value);} }
        public DateTime? VAL_DATE { get { return (DateTime?)FindField("VAL_DATE").Value; } set {SetField("VAL_DATE", value);} }
        public Decimal? KV_P { get { return (Decimal?)FindField("KV_P").Value; } set {SetField("KV_P", value);} }
        public Decimal? S_P { get { return (Decimal?)FindField("S_P").Value; } set {SetField("S_P", value);} }
    }

    public sealed class VCimJournalPFilters : BbFilters
    {
        public VCimJournalPFilters(BbDataSource Parent) : base (Parent)
        {
            BRANCH = new BBVarchar2Filter(this, "BRANCH");
            JOURNAL_NUM = new BBDecimalFilter(this, "JOURNAL_NUM");
            NUM = new BBDecimalFilter(this, "NUM");
            CREATE_DATE = new BBDateFilter(this, "CREATE_DATE");
            RNK = new BBDecimalFilter(this, "RNK");
            OKPO = new BBVarchar2Filter(this, "OKPO");
            NMK = new BBVarchar2Filter(this, "NMK");
            BENEF_ID = new BBDecimalFilter(this, "BENEF_ID");
            BENEF_NAME = new BBVarchar2Filter(this, "BENEF_NAME");
            COUNTRY_ID = new BBDecimalFilter(this, "COUNTRY_ID");
            COUNTRY_NAME = new BBVarchar2Filter(this, "COUNTRY_NAME");
            CONTR_ID = new BBDecimalFilter(this, "CONTR_ID");
            CONTR_NUM = new BBVarchar2Filter(this, "CONTR_NUM");
            CONTR_DATE = new BBDateFilter(this, "CONTR_DATE");
            CONTROL_DATE = new BBDateFilter(this, "CONTROL_DATE");
            COMMENTS = new BBVarchar2Filter(this, "COMMENTS");
            MODIFY_DATE = new BBDateFilter(this, "MODIFY_DATE");
            DELETE_DATE = new BBDateFilter(this, "DELETE_DATE");
            X_S = new BBDecimalFilter(this, "X_S");
            DIRECT = new BBDecimalFilter(this, "DIRECT");
            PAYMENT_TYPE = new BBDecimalFilter(this, "PAYMENT_TYPE");
            PAYMENT_TYPE_NAME = new BBVarchar2Filter(this, "PAYMENT_TYPE_NAME");
            BOUND_ID = new BBDecimalFilter(this, "BOUND_ID");
            PAYMENT_ID = new BBDecimalFilter(this, "PAYMENT_ID");
            VAL_DATE = new BBDateFilter(this, "VAL_DATE");
            KV_P = new BBDecimalFilter(this, "KV_P");
            S_P = new BBDecimalFilter(this, "S_P");
        }
        public BBVarchar2Filter BRANCH;
        public BBDecimalFilter JOURNAL_NUM;
        public BBDecimalFilter NUM;
        public BBDateFilter CREATE_DATE;
        public BBDecimalFilter RNK;
        public BBVarchar2Filter OKPO;
        public BBVarchar2Filter NMK;
        public BBDecimalFilter BENEF_ID;
        public BBVarchar2Filter BENEF_NAME;
        public BBDecimalFilter COUNTRY_ID;
        public BBVarchar2Filter COUNTRY_NAME;
        public BBDecimalFilter CONTR_ID;
        public BBVarchar2Filter CONTR_NUM;
        public BBDateFilter CONTR_DATE;
        public BBDateFilter CONTROL_DATE;
        public BBVarchar2Filter COMMENTS;
        public BBDateFilter MODIFY_DATE;
        public BBDateFilter DELETE_DATE;
        public BBDecimalFilter X_S;
        public BBDecimalFilter DIRECT;
        public BBDecimalFilter PAYMENT_TYPE;
        public BBVarchar2Filter PAYMENT_TYPE_NAME;
        public BBDecimalFilter BOUND_ID;
        public BBDecimalFilter PAYMENT_ID;
        public BBDateFilter VAL_DATE;
        public BBDecimalFilter KV_P;
        public BBDecimalFilter S_P;
    }

    public partial class VCimJournalP : BbTable<VCimJournalPRecord, VCimJournalPFilters>
    {
        public VCimJournalP() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VCimJournalP(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VCimJournalPRecord> Select(VCimJournalPRecord Item)
        {
            List<VCimJournalPRecord> res = new List<VCimJournalPRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VCimJournalPRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (String)null : Convert.ToString(rdr[1]), 
                        rdr.IsDBNull(2) ?  (Decimal?)null : Convert.ToDecimal(rdr[2]), 
                        rdr.IsDBNull(3) ?  (Decimal?)null : Convert.ToDecimal(rdr[3]), 
                        rdr.IsDBNull(4) ?  (DateTime?)null : Convert.ToDateTime(rdr[4]), 
                        rdr.IsDBNull(5) ?  (Decimal?)null : Convert.ToDecimal(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
                        rdr.IsDBNull(8) ?  (Decimal?)null : Convert.ToDecimal(rdr[8]), 
                        rdr.IsDBNull(9) ?  (String)null : Convert.ToString(rdr[9]), 
                        rdr.IsDBNull(10) ?  (Decimal?)null : Convert.ToDecimal(rdr[10]), 
                        rdr.IsDBNull(11) ?  (String)null : Convert.ToString(rdr[11]), 
                        rdr.IsDBNull(12) ?  (Decimal?)null : Convert.ToDecimal(rdr[12]), 
                        rdr.IsDBNull(13) ?  (String)null : Convert.ToString(rdr[13]), 
                        rdr.IsDBNull(14) ?  (DateTime?)null : Convert.ToDateTime(rdr[14]), 
                        rdr.IsDBNull(15) ?  (DateTime?)null : Convert.ToDateTime(rdr[15]), 
                        rdr.IsDBNull(16) ?  (String)null : Convert.ToString(rdr[16]), 
                        rdr.IsDBNull(17) ?  (DateTime?)null : Convert.ToDateTime(rdr[17]), 
                        rdr.IsDBNull(18) ?  (DateTime?)null : Convert.ToDateTime(rdr[18]), 
                        rdr.IsDBNull(19) ?  (Decimal?)null : Convert.ToDecimal(rdr[19]), 
                        rdr.IsDBNull(20) ?  (Decimal?)null : Convert.ToDecimal(rdr[20]), 
                        rdr.IsDBNull(21) ?  (Decimal?)null : Convert.ToDecimal(rdr[21]), 
                        rdr.IsDBNull(22) ?  (String)null : Convert.ToString(rdr[22]), 
                        rdr.IsDBNull(23) ?  (Decimal?)null : Convert.ToDecimal(rdr[23]), 
                        rdr.IsDBNull(24) ?  (Decimal?)null : Convert.ToDecimal(rdr[24]), 
                        rdr.IsDBNull(25) ?  (DateTime?)null : Convert.ToDateTime(rdr[25]), 
                        rdr.IsDBNull(26) ?  (Decimal?)null : Convert.ToDecimal(rdr[26]), 
                        rdr.IsDBNull(27) ?  (Decimal?)null : Convert.ToDecimal(rdr[27]))
                    );
                }
            }
            finally
            {
                DisposeDataReader(rdr);
                if (ConnectionResult.New == connectionResult)
                    Connection.CloseConnection();
            }
            return res;
        }
    }
}