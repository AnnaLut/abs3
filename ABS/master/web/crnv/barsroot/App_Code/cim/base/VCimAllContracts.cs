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
    public sealed class VCimAllContractsRecord : BbRecord
    {
        public VCimAllContractsRecord(): base()
        {
            fillFields();
        }
        public VCimAllContractsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VCimAllContractsRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? CONTR_ID, Decimal? CONTR_TYPE, String CONTR_TYPE_NAME, String NUM, Decimal? RNK, String OKPO, String NMK, String ND, String VED, String VED_NAME, DateTime? OPEN_DATE, DateTime? CLOSE_DATE, Decimal? KV, Decimal? S, Decimal? BENEF_ID, String BENEF_NAME, Decimal? COUNTRY_ID, String COUNTRY_NAME, Decimal? STATUS_ID, String STATUS_NAME, String COMMENTS, String BRANCH, String BRANCH_NAME)
            : this(Parent)
        {
            this.CONTR_ID = CONTR_ID;
            this.CONTR_TYPE = CONTR_TYPE;
            this.CONTR_TYPE_NAME = CONTR_TYPE_NAME;
            this.NUM = NUM;
            this.RNK = RNK;
            this.OKPO = OKPO;
            this.NMK = NMK;
            this.ND = ND;
            this.VED = VED;
            this.VED_NAME = VED_NAME;
            this.OPEN_DATE = OPEN_DATE;
            this.CLOSE_DATE = CLOSE_DATE;
            this.KV = KV;
            this.S = S;
            this.BENEF_ID = BENEF_ID;
            this.BENEF_NAME = BENEF_NAME;
            this.COUNTRY_ID = COUNTRY_ID;
            this.COUNTRY_NAME = COUNTRY_NAME;
            this.STATUS_ID = STATUS_ID;
            this.STATUS_NAME = STATUS_NAME;
            this.COMMENTS = COMMENTS;
            this.BRANCH = BRANCH;
            this.BRANCH_NAME = BRANCH_NAME;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("CONTR_ID", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Внутрішній код контракту"));
            Fields.Add( new BbField("CONTR_TYPE", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Тип контракту"));
            Fields.Add( new BbField("CONTR_TYPE_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Найменування типу контракту"));
            Fields.Add( new BbField("NUM", OracleDbType.Varchar2, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Символьний номер контракту"));
            Fields.Add( new BbField("RNK", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Внутрішній номер (rnk) контрагента контракту"));
            Fields.Add( new BbField("OKPO", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "ОКПО контрагента контракту"));
            Fields.Add( new BbField("NMK", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Найменування контрагента"));
            Fields.Add( new BbField("ND", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Номер договору контрагента"));
            Fields.Add( new BbField("VED", OracleDbType.Char, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Код виду економічної діяльності"));
            Fields.Add( new BbField("VED_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Вид економічної діяльності"));
            Fields.Add( new BbField("OPEN_DATE", OracleDbType.Date, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Дата відкриття"));
            Fields.Add( new BbField("CLOSE_DATE", OracleDbType.Date, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Дата закриття "));
            Fields.Add( new BbField("KV", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Валюта контракту"));
            Fields.Add( new BbField("S", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Сума контракту"));
            Fields.Add( new BbField("BENEF_ID", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Код клієнта-неризидента"));
            Fields.Add( new BbField("BENEF_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Найменування клієнта-неризидента"));
            Fields.Add( new BbField("COUNTRY_ID", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", ""));
            Fields.Add( new BbField("COUNTRY_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", ""));
            Fields.Add( new BbField("STATUS_ID", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Код статусу контракту"));
            Fields.Add( new BbField("STATUS_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Статус контракту"));
            Fields.Add( new BbField("COMMENTS", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Деталі контракту"));
            Fields.Add( new BbField("BRANCH", OracleDbType.Varchar2, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Код відділеня"));
            Fields.Add( new BbField("BRANCH_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v1.0", "Відділеня"));        
        }
        public Decimal? CONTR_ID { get { return (Decimal?)FindField("CONTR_ID").Value; } set {SetField("CONTR_ID", value);} }
        public Decimal? CONTR_TYPE { get { return (Decimal?)FindField("CONTR_TYPE").Value; } set {SetField("CONTR_TYPE", value);} }
        public String CONTR_TYPE_NAME { get { return (String)FindField("CONTR_TYPE_NAME").Value; } set {SetField("CONTR_TYPE_NAME", value);} }
        public String NUM { get { return (String)FindField("NUM").Value; } set {SetField("NUM", value);} }
        public Decimal? RNK { get { return (Decimal?)FindField("RNK").Value; } set {SetField("RNK", value);} }
        public String OKPO { get { return (String)FindField("OKPO").Value; } set {SetField("OKPO", value);} }
        public String NMK { get { return (String)FindField("NMK").Value; } set {SetField("NMK", value);} }
        public String ND { get { return (String)FindField("ND").Value; } set {SetField("ND", value);} }
        public String VED { get { return (String)FindField("VED").Value; } set {SetField("VED", value);} }
        public String VED_NAME { get { return (String)FindField("VED_NAME").Value; } set {SetField("VED_NAME", value);} }
        public DateTime? OPEN_DATE { get { return (DateTime?)FindField("OPEN_DATE").Value; } set {SetField("OPEN_DATE", value);} }
        public DateTime? CLOSE_DATE { get { return (DateTime?)FindField("CLOSE_DATE").Value; } set {SetField("CLOSE_DATE", value);} }
        public Decimal? KV { get { return (Decimal?)FindField("KV").Value; } set {SetField("KV", value);} }
        public Decimal? S { get { return (Decimal?)FindField("S").Value; } set {SetField("S", value);} }
        public Decimal? BENEF_ID { get { return (Decimal?)FindField("BENEF_ID").Value; } set {SetField("BENEF_ID", value);} }
        public String BENEF_NAME { get { return (String)FindField("BENEF_NAME").Value; } set {SetField("BENEF_NAME", value);} }
        public Decimal? COUNTRY_ID { get { return (Decimal?)FindField("COUNTRY_ID").Value; } set {SetField("COUNTRY_ID", value);} }
        public String COUNTRY_NAME { get { return (String)FindField("COUNTRY_NAME").Value; } set {SetField("COUNTRY_NAME", value);} }
        public Decimal? STATUS_ID { get { return (Decimal?)FindField("STATUS_ID").Value; } set {SetField("STATUS_ID", value);} }
        public String STATUS_NAME { get { return (String)FindField("STATUS_NAME").Value; } set {SetField("STATUS_NAME", value);} }
        public String COMMENTS { get { return (String)FindField("COMMENTS").Value; } set {SetField("COMMENTS", value);} }
        public String BRANCH { get { return (String)FindField("BRANCH").Value; } set {SetField("BRANCH", value);} }
        public String BRANCH_NAME { get { return (String)FindField("BRANCH_NAME").Value; } set {SetField("BRANCH_NAME", value);} }
    }

    public sealed class VCimAllContractsFilters : BbFilters
    {
        public VCimAllContractsFilters(BbDataSource Parent) : base (Parent)
        {
            CONTR_ID = new BBDecimalFilter(this, "CONTR_ID");
            CONTR_TYPE = new BBDecimalFilter(this, "CONTR_TYPE");
            CONTR_TYPE_NAME = new BBVarchar2Filter(this, "CONTR_TYPE_NAME");
            NUM = new BBVarchar2Filter(this, "NUM");
            RNK = new BBDecimalFilter(this, "RNK");
            OKPO = new BBVarchar2Filter(this, "OKPO");
            NMK = new BBVarchar2Filter(this, "NMK");
            ND = new BBVarchar2Filter(this, "ND");
            VED = new BBCharFilter(this, "VED");
            VED_NAME = new BBVarchar2Filter(this, "VED_NAME");
            OPEN_DATE = new BBDateFilter(this, "OPEN_DATE");
            CLOSE_DATE = new BBDateFilter(this, "CLOSE_DATE");
            KV = new BBDecimalFilter(this, "KV");
            S = new BBDecimalFilter(this, "S");
            BENEF_ID = new BBDecimalFilter(this, "BENEF_ID");
            BENEF_NAME = new BBVarchar2Filter(this, "BENEF_NAME");
            COUNTRY_ID = new BBDecimalFilter(this, "COUNTRY_ID");
            COUNTRY_NAME = new BBVarchar2Filter(this, "COUNTRY_NAME");
            STATUS_ID = new BBDecimalFilter(this, "STATUS_ID");
            STATUS_NAME = new BBVarchar2Filter(this, "STATUS_NAME");
            COMMENTS = new BBVarchar2Filter(this, "COMMENTS");
            BRANCH = new BBVarchar2Filter(this, "BRANCH");
            BRANCH_NAME = new BBVarchar2Filter(this, "BRANCH_NAME");
        }
        public BBDecimalFilter CONTR_ID;
        public BBDecimalFilter CONTR_TYPE;
        public BBVarchar2Filter CONTR_TYPE_NAME;
        public BBVarchar2Filter NUM;
        public BBDecimalFilter RNK;
        public BBVarchar2Filter OKPO;
        public BBVarchar2Filter NMK;
        public BBVarchar2Filter ND;
        public BBCharFilter VED;
        public BBVarchar2Filter VED_NAME;
        public BBDateFilter OPEN_DATE;
        public BBDateFilter CLOSE_DATE;
        public BBDecimalFilter KV;
        public BBDecimalFilter S;
        public BBDecimalFilter BENEF_ID;
        public BBVarchar2Filter BENEF_NAME;
        public BBDecimalFilter COUNTRY_ID;
        public BBVarchar2Filter COUNTRY_NAME;
        public BBDecimalFilter STATUS_ID;
        public BBVarchar2Filter STATUS_NAME;
        public BBVarchar2Filter COMMENTS;
        public BBVarchar2Filter BRANCH;
        public BBVarchar2Filter BRANCH_NAME;
    }

    public partial class VCimAllContracts : BbTable<VCimAllContractsRecord, VCimAllContractsFilters>
    {
        public VCimAllContracts() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VCimAllContracts(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VCimAllContractsRecord> Select(VCimAllContractsRecord Item)
        {
            List<VCimAllContractsRecord> res = new List<VCimAllContractsRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VCimAllContractsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (Decimal?)null : Convert.ToDecimal(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (Decimal?)null : Convert.ToDecimal(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
                        rdr.IsDBNull(8) ?  (String)null : Convert.ToString(rdr[8]), 
                        rdr.IsDBNull(9) ?  (String)null : Convert.ToString(rdr[9]), 
                        rdr.IsDBNull(10) ?  (String)null : Convert.ToString(rdr[10]), 
                        rdr.IsDBNull(11) ?  (DateTime?)null : Convert.ToDateTime(rdr[11]), 
                        rdr.IsDBNull(12) ?  (DateTime?)null : Convert.ToDateTime(rdr[12]), 
                        rdr.IsDBNull(13) ?  (Decimal?)null : Convert.ToDecimal(rdr[13]), 
                        rdr.IsDBNull(14) ?  (Decimal?)null : Convert.ToDecimal(rdr[14]), 
                        rdr.IsDBNull(15) ?  (Decimal?)null : Convert.ToDecimal(rdr[15]), 
                        rdr.IsDBNull(16) ?  (String)null : Convert.ToString(rdr[16]), 
                        rdr.IsDBNull(17) ?  (Decimal?)null : Convert.ToDecimal(rdr[17]), 
                        rdr.IsDBNull(18) ?  (String)null : Convert.ToString(rdr[18]), 
                        rdr.IsDBNull(19) ?  (Decimal?)null : Convert.ToDecimal(rdr[19]), 
                        rdr.IsDBNull(20) ?  (String)null : Convert.ToString(rdr[20]), 
                        rdr.IsDBNull(21) ?  (String)null : Convert.ToString(rdr[21]), 
                        rdr.IsDBNull(22) ?  (String)null : Convert.ToString(rdr[22]), 
                        rdr.IsDBNull(23) ?  (String)null : Convert.ToString(rdr[23]))
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