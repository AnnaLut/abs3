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
        public VCimAllContractsRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? CONTR_ID, Decimal? CONTR_TYPE, String CONTR_TYPE_NAME, String NUM, String SUBNUM, Decimal? RNK, String OKPO, String NMK, String NMKK, Decimal? CUSTTYPE, String ND, String VED, String VED_NAME, DateTime? OPEN_DATE, DateTime? CLOSE_DATE, Decimal? KV, Decimal? S, Decimal? BENEF_ID, String BENEF_NAME, String BENEF_ADR, Decimal? COUNTRY_ID, String COUNTRY_NAME, Decimal? STATUS_ID, String STATUS_NAME, String COMMENTS, String BRANCH, String BRANCH_NAME, Decimal? OWNER, Decimal? OWNER_UID, String OWNER_NAME, Decimal? CAN_DELETE, String BIC, String B010, String BANK_NAME, Decimal? ATTANTION_FLAG, String SERVICE_BRANCH, String EA_URL)
            : this(Parent)
        {
            this.CONTR_ID = CONTR_ID;
            this.CONTR_TYPE = CONTR_TYPE;
            this.CONTR_TYPE_NAME = CONTR_TYPE_NAME;
            this.NUM = NUM;
            this.SUBNUM = SUBNUM;
            this.RNK = RNK;
            this.OKPO = OKPO;
            this.NMK = NMK;
            this.NMKK = NMKK;
            this.CUSTTYPE = CUSTTYPE;
            this.ND = ND;
            this.VED = VED;
            this.VED_NAME = VED_NAME;
            this.OPEN_DATE = OPEN_DATE;
            this.CLOSE_DATE = CLOSE_DATE;
            this.KV = KV;
            this.S = S;
            this.BENEF_ID = BENEF_ID;
            this.BENEF_NAME = BENEF_NAME;
            this.BENEF_ADR = BENEF_ADR;
            this.COUNTRY_ID = COUNTRY_ID;
            this.COUNTRY_NAME = COUNTRY_NAME;
            this.STATUS_ID = STATUS_ID;
            this.STATUS_NAME = STATUS_NAME;
            this.COMMENTS = COMMENTS;
            this.BRANCH = BRANCH;
            this.BRANCH_NAME = BRANCH_NAME;
            this.OWNER = OWNER;
            this.OWNER_UID = OWNER_UID;
            this.OWNER_NAME = OWNER_NAME;
            this.CAN_DELETE = CAN_DELETE;
            this.BIC = BIC;
            this.B010 = B010;
            this.BANK_NAME = BANK_NAME;
            this.ATTANTION_FLAG = ATTANTION_FLAG;
            this.SERVICE_BRANCH = SERVICE_BRANCH;
            this.EA_URL = EA_URL;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("CONTR_ID", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Внутрішній код контракту"));
            Fields.Add( new BbField("CONTR_TYPE", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Тип контракту"));
            Fields.Add( new BbField("CONTR_TYPE_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Найменування типу контракту"));
            Fields.Add( new BbField("NUM", OracleDbType.Varchar2, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Символьний номер контракту"));
            Fields.Add( new BbField("SUBNUM", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Cубномер контракту"));
            Fields.Add( new BbField("RNK", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Внутрішній номер (rnk) контрагента контракту"));
            Fields.Add( new BbField("OKPO", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "ОКПО контрагента контракту"));
            Fields.Add( new BbField("NMK", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Найменування контрагента"));
            Fields.Add( new BbField("NMKK", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Коротке найменування контрагента"));
            Fields.Add( new BbField("CUSTTYPE", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Тип контрагента (1 -банк, 2 - ЮО, 3-ФО)"));
            Fields.Add( new BbField("ND", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Номер договору контрагента"));
            Fields.Add( new BbField("VED", OracleDbType.Char, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Код виду економічної діяльності"));
            Fields.Add( new BbField("VED_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Вид економічної діяльності"));
            Fields.Add( new BbField("OPEN_DATE", OracleDbType.Date, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Дата відкриття"));
            Fields.Add( new BbField("CLOSE_DATE", OracleDbType.Date, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Дата закриття "));
            Fields.Add( new BbField("KV", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Валюта контракту"));
            Fields.Add( new BbField("S", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Сума контракту"));
            Fields.Add( new BbField("BENEF_ID", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Код клієнта-неризидента"));
            Fields.Add( new BbField("BENEF_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Найменування клієнта-неризидента"));
            Fields.Add( new BbField("BENEF_ADR", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Адреса клієнта-нерезидента"));
            Fields.Add( new BbField("COUNTRY_ID", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "id країни клієнта-нерезидента"));
            Fields.Add( new BbField("COUNTRY_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Назва країни клієнта-нерезидента"));
            Fields.Add( new BbField("STATUS_ID", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Код статусу контракту"));
            Fields.Add( new BbField("STATUS_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Статус контракту"));
            Fields.Add( new BbField("COMMENTS", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Деталі контракту"));
            Fields.Add( new BbField("BRANCH", OracleDbType.Varchar2, false, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Код відділеня"));
            Fields.Add( new BbField("BRANCH_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Відділеня"));
            Fields.Add( new BbField("OWNER", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Установа - власник контракту (1 - так, 0 - ні)"));
            Fields.Add( new BbField("OWNER_UID", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Id користувача, за яким закріплено контракт"));
            Fields.Add( new BbField("OWNER_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "ПІБ користувача, за яким закріплено контракт"));
            Fields.Add( new BbField("CAN_DELETE", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Можливість видалення контракту (1 - так, 0 - ні)"));
            Fields.Add( new BbField("BIC", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "BIC-код банку-нерезидента"));
            Fields.Add( new BbField("B010", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Код B010 банку нерезидента"));
            Fields.Add( new BbField("BANK_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Назва банку нерезидента"));
            Fields.Add( new BbField("ATTANTION_FLAG", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Відмітка про наявність нових МД по контракту"));
            Fields.Add( new BbField("SERVICE_BRANCH", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Установа, відповідальна за прийом первинних документів"));
            Fields.Add( new BbField("EA_URL", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_ALL_CONTRACTS", ObjectTypes.View, "Довідник контрактів v 1.00.02", "Адреса сервера електронного архіву ВК"));        
        }
        public Decimal? CONTR_ID { get { return (Decimal?)FindField("CONTR_ID").Value; } set {SetField("CONTR_ID", value);} }
        public Decimal? CONTR_TYPE { get { return (Decimal?)FindField("CONTR_TYPE").Value; } set {SetField("CONTR_TYPE", value);} }
        public String CONTR_TYPE_NAME { get { return (String)FindField("CONTR_TYPE_NAME").Value; } set {SetField("CONTR_TYPE_NAME", value);} }
        public String NUM { get { return (String)FindField("NUM").Value; } set {SetField("NUM", value);} }
        public String SUBNUM { get { return (String)FindField("SUBNUM").Value; } set {SetField("SUBNUM", value);} }
        public Decimal? RNK { get { return (Decimal?)FindField("RNK").Value; } set {SetField("RNK", value);} }
        public String OKPO { get { return (String)FindField("OKPO").Value; } set {SetField("OKPO", value);} }
        public String NMK { get { return (String)FindField("NMK").Value; } set {SetField("NMK", value);} }
        public String NMKK { get { return (String)FindField("NMKK").Value; } set {SetField("NMKK", value);} }
        public Decimal? CUSTTYPE { get { return (Decimal?)FindField("CUSTTYPE").Value; } set {SetField("CUSTTYPE", value);} }
        public String ND { get { return (String)FindField("ND").Value; } set {SetField("ND", value);} }
        public String VED { get { return (String)FindField("VED").Value; } set {SetField("VED", value);} }
        public String VED_NAME { get { return (String)FindField("VED_NAME").Value; } set {SetField("VED_NAME", value);} }
        public DateTime? OPEN_DATE { get { return (DateTime?)FindField("OPEN_DATE").Value; } set {SetField("OPEN_DATE", value);} }
        public DateTime? CLOSE_DATE { get { return (DateTime?)FindField("CLOSE_DATE").Value; } set {SetField("CLOSE_DATE", value);} }
        public Decimal? KV { get { return (Decimal?)FindField("KV").Value; } set {SetField("KV", value);} }
        public Decimal? S { get { return (Decimal?)FindField("S").Value; } set {SetField("S", value);} }
        public Decimal? BENEF_ID { get { return (Decimal?)FindField("BENEF_ID").Value; } set {SetField("BENEF_ID", value);} }
        public String BENEF_NAME { get { return (String)FindField("BENEF_NAME").Value; } set {SetField("BENEF_NAME", value);} }
        public String BENEF_ADR { get { return (String)FindField("BENEF_ADR").Value; } set {SetField("BENEF_ADR", value);} }
        public Decimal? COUNTRY_ID { get { return (Decimal?)FindField("COUNTRY_ID").Value; } set {SetField("COUNTRY_ID", value);} }
        public String COUNTRY_NAME { get { return (String)FindField("COUNTRY_NAME").Value; } set {SetField("COUNTRY_NAME", value);} }
        public Decimal? STATUS_ID { get { return (Decimal?)FindField("STATUS_ID").Value; } set {SetField("STATUS_ID", value);} }
        public String STATUS_NAME { get { return (String)FindField("STATUS_NAME").Value; } set {SetField("STATUS_NAME", value);} }
        public String COMMENTS { get { return (String)FindField("COMMENTS").Value; } set {SetField("COMMENTS", value);} }
        public String BRANCH { get { return (String)FindField("BRANCH").Value; } set {SetField("BRANCH", value);} }
        public String BRANCH_NAME { get { return (String)FindField("BRANCH_NAME").Value; } set {SetField("BRANCH_NAME", value);} }
        public Decimal? OWNER { get { return (Decimal?)FindField("OWNER").Value; } set {SetField("OWNER", value);} }
        public Decimal? OWNER_UID { get { return (Decimal?)FindField("OWNER_UID").Value; } set {SetField("OWNER_UID", value);} }
        public String OWNER_NAME { get { return (String)FindField("OWNER_NAME").Value; } set {SetField("OWNER_NAME", value);} }
        public Decimal? CAN_DELETE { get { return (Decimal?)FindField("CAN_DELETE").Value; } set {SetField("CAN_DELETE", value);} }
        public String BIC { get { return (String)FindField("BIC").Value; } set {SetField("BIC", value);} }
        public String B010 { get { return (String)FindField("B010").Value; } set {SetField("B010", value);} }
        public String BANK_NAME { get { return (String)FindField("BANK_NAME").Value; } set {SetField("BANK_NAME", value);} }
        public Decimal? ATTANTION_FLAG { get { return (Decimal?)FindField("ATTANTION_FLAG").Value; } set {SetField("ATTANTION_FLAG", value);} }
        public String SERVICE_BRANCH { get { return (String)FindField("SERVICE_BRANCH").Value; } set {SetField("SERVICE_BRANCH", value);} }
        public String EA_URL { get { return (String)FindField("EA_URL").Value; } set {SetField("EA_URL", value);} }
    }

    public sealed class VCimAllContractsFilters : BbFilters
    {
        public VCimAllContractsFilters(BbDataSource Parent) : base (Parent)
        {
            CONTR_ID = new BBDecimalFilter(this, "CONTR_ID");
            CONTR_TYPE = new BBDecimalFilter(this, "CONTR_TYPE");
            CONTR_TYPE_NAME = new BBVarchar2Filter(this, "CONTR_TYPE_NAME");
            NUM = new BBVarchar2Filter(this, "NUM");
            SUBNUM = new BBVarchar2Filter(this, "SUBNUM");
            RNK = new BBDecimalFilter(this, "RNK");
            OKPO = new BBVarchar2Filter(this, "OKPO");
            NMK = new BBVarchar2Filter(this, "NMK");
            NMKK = new BBVarchar2Filter(this, "NMKK");
            CUSTTYPE = new BBDecimalFilter(this, "CUSTTYPE");
            ND = new BBVarchar2Filter(this, "ND");
            VED = new BBCharFilter(this, "VED");
            VED_NAME = new BBVarchar2Filter(this, "VED_NAME");
            OPEN_DATE = new BBDateFilter(this, "OPEN_DATE");
            CLOSE_DATE = new BBDateFilter(this, "CLOSE_DATE");
            KV = new BBDecimalFilter(this, "KV");
            S = new BBDecimalFilter(this, "S");
            BENEF_ID = new BBDecimalFilter(this, "BENEF_ID");
            BENEF_NAME = new BBVarchar2Filter(this, "BENEF_NAME");
            BENEF_ADR = new BBVarchar2Filter(this, "BENEF_ADR");
            COUNTRY_ID = new BBDecimalFilter(this, "COUNTRY_ID");
            COUNTRY_NAME = new BBVarchar2Filter(this, "COUNTRY_NAME");
            STATUS_ID = new BBDecimalFilter(this, "STATUS_ID");
            STATUS_NAME = new BBVarchar2Filter(this, "STATUS_NAME");
            COMMENTS = new BBVarchar2Filter(this, "COMMENTS");
            BRANCH = new BBVarchar2Filter(this, "BRANCH");
            BRANCH_NAME = new BBVarchar2Filter(this, "BRANCH_NAME");
            OWNER = new BBDecimalFilter(this, "OWNER");
            OWNER_UID = new BBDecimalFilter(this, "OWNER_UID");
            OWNER_NAME = new BBVarchar2Filter(this, "OWNER_NAME");
            CAN_DELETE = new BBDecimalFilter(this, "CAN_DELETE");
            BIC = new BBVarchar2Filter(this, "BIC");
            B010 = new BBVarchar2Filter(this, "B010");
            BANK_NAME = new BBVarchar2Filter(this, "BANK_NAME");
            ATTANTION_FLAG = new BBDecimalFilter(this, "ATTANTION_FLAG");
            SERVICE_BRANCH = new BBVarchar2Filter(this, "SERVICE_BRANCH");
            EA_URL = new BBVarchar2Filter(this, "EA_URL");
        }
        public BBDecimalFilter CONTR_ID;
        public BBDecimalFilter CONTR_TYPE;
        public BBVarchar2Filter CONTR_TYPE_NAME;
        public BBVarchar2Filter NUM;
        public BBVarchar2Filter SUBNUM;
        public BBDecimalFilter RNK;
        public BBVarchar2Filter OKPO;
        public BBVarchar2Filter NMK;
        public BBVarchar2Filter NMKK;
        public BBDecimalFilter CUSTTYPE;
        public BBVarchar2Filter ND;
        public BBCharFilter VED;
        public BBVarchar2Filter VED_NAME;
        public BBDateFilter OPEN_DATE;
        public BBDateFilter CLOSE_DATE;
        public BBDecimalFilter KV;
        public BBDecimalFilter S;
        public BBDecimalFilter BENEF_ID;
        public BBVarchar2Filter BENEF_NAME;
        public BBVarchar2Filter BENEF_ADR;
        public BBDecimalFilter COUNTRY_ID;
        public BBVarchar2Filter COUNTRY_NAME;
        public BBDecimalFilter STATUS_ID;
        public BBVarchar2Filter STATUS_NAME;
        public BBVarchar2Filter COMMENTS;
        public BBVarchar2Filter BRANCH;
        public BBVarchar2Filter BRANCH_NAME;
        public BBDecimalFilter OWNER;
        public BBDecimalFilter OWNER_UID;
        public BBVarchar2Filter OWNER_NAME;
        public BBDecimalFilter CAN_DELETE;
        public BBVarchar2Filter BIC;
        public BBVarchar2Filter B010;
        public BBVarchar2Filter BANK_NAME;
        public BBDecimalFilter ATTANTION_FLAG;
        public BBVarchar2Filter SERVICE_BRANCH;
        public BBVarchar2Filter EA_URL;
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
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (Decimal?)null : Convert.ToDecimal(rdr[6]), 
                        rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
                        rdr.IsDBNull(8) ?  (String)null : Convert.ToString(rdr[8]), 
                        rdr.IsDBNull(9) ?  (String)null : Convert.ToString(rdr[9]), 
                        rdr.IsDBNull(10) ?  (Decimal?)null : Convert.ToDecimal(rdr[10]), 
                        rdr.IsDBNull(11) ?  (String)null : Convert.ToString(rdr[11]), 
                        rdr.IsDBNull(12) ?  (String)null : Convert.ToString(rdr[12]), 
                        rdr.IsDBNull(13) ?  (String)null : Convert.ToString(rdr[13]), 
                        rdr.IsDBNull(14) ?  (DateTime?)null : Convert.ToDateTime(rdr[14]), 
                        rdr.IsDBNull(15) ?  (DateTime?)null : Convert.ToDateTime(rdr[15]), 
                        rdr.IsDBNull(16) ?  (Decimal?)null : Convert.ToDecimal(rdr[16]), 
                        rdr.IsDBNull(17) ?  (Decimal?)null : Convert.ToDecimal(rdr[17]), 
                        rdr.IsDBNull(18) ?  (Decimal?)null : Convert.ToDecimal(rdr[18]), 
                        rdr.IsDBNull(19) ?  (String)null : Convert.ToString(rdr[19]), 
                        rdr.IsDBNull(20) ?  (String)null : Convert.ToString(rdr[20]), 
                        rdr.IsDBNull(21) ?  (Decimal?)null : Convert.ToDecimal(rdr[21]), 
                        rdr.IsDBNull(22) ?  (String)null : Convert.ToString(rdr[22]), 
                        rdr.IsDBNull(23) ?  (Decimal?)null : Convert.ToDecimal(rdr[23]), 
                        rdr.IsDBNull(24) ?  (String)null : Convert.ToString(rdr[24]), 
                        rdr.IsDBNull(25) ?  (String)null : Convert.ToString(rdr[25]), 
                        rdr.IsDBNull(26) ?  (String)null : Convert.ToString(rdr[26]), 
                        rdr.IsDBNull(27) ?  (String)null : Convert.ToString(rdr[27]), 
                        rdr.IsDBNull(28) ?  (Decimal?)null : Convert.ToDecimal(rdr[28]), 
                        rdr.IsDBNull(29) ?  (Decimal?)null : Convert.ToDecimal(rdr[29]), 
                        rdr.IsDBNull(30) ?  (String)null : Convert.ToString(rdr[30]), 
                        rdr.IsDBNull(31) ?  (Decimal?)null : Convert.ToDecimal(rdr[31]), 
                        rdr.IsDBNull(32) ?  (String)null : Convert.ToString(rdr[32]), 
                        rdr.IsDBNull(33) ?  (String)null : Convert.ToString(rdr[33]), 
                        rdr.IsDBNull(34) ?  (String)null : Convert.ToString(rdr[34]), 
                        rdr.IsDBNull(35) ?  (Decimal?)null : Convert.ToDecimal(rdr[35]), 
                        rdr.IsDBNull(36) ?  (String)null : Convert.ToString(rdr[36]), 
                        rdr.IsDBNull(37) ?  (String)null : Convert.ToString(rdr[37]))
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