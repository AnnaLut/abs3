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
    public sealed class VCimOutUnboundPaymentsRecord : BbRecord
    {
        public VCimOutUnboundPaymentsRecord(): base()
        {
            fillFields();
        }
        public VCimOutUnboundPaymentsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VCimOutUnboundPaymentsRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? REF, Decimal? CUST_RNK, String CUST_OKPO, String CUST_NMK, String CUST_ND, String BENEF_NMK, Decimal? ACC, String NLS, DateTime? PDAT, DateTime? VDAT, Decimal? KV, Decimal? TOTAL_SUM, Decimal? UNBOUND_SUM, String NAZN, Decimal? OP_TYPE_ID, String OP_TYPE, Decimal? PAY_TYPE, String PAY_TYPE_NAME, Decimal? IS_VISED, Decimal? DIRECT, String DIRECT_NAME, String TT, Decimal? BACKGROUND_COLOR)
            : this(Parent)
        {
            this.REF = REF;
            this.CUST_RNK = CUST_RNK;
            this.CUST_OKPO = CUST_OKPO;
            this.CUST_NMK = CUST_NMK;
            this.CUST_ND = CUST_ND;
            this.BENEF_NMK = BENEF_NMK;
            this.ACC = ACC;
            this.NLS = NLS;
            this.PDAT = PDAT;
            this.VDAT = VDAT;
            this.KV = KV;
            this.TOTAL_SUM = TOTAL_SUM;
            this.UNBOUND_SUM = UNBOUND_SUM;
            this.NAZN = NAZN;
            this.OP_TYPE_ID = OP_TYPE_ID;
            this.OP_TYPE = OP_TYPE;
            this.PAY_TYPE = PAY_TYPE;
            this.PAY_TYPE_NAME = PAY_TYPE_NAME;
            this.IS_VISED = IS_VISED;
            this.DIRECT = DIRECT;
            this.DIRECT_NAME = DIRECT_NAME;
            this.TT = TT;
            this.BACKGROUND_COLOR = BACKGROUND_COLOR;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("REF", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "Референс платежу"));
            Fields.Add( new BbField("CUST_RNK", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "Реєстраційний номер клієнта"));
            Fields.Add( new BbField("CUST_OKPO", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "ЄДРПОУ клієнта"));
            Fields.Add( new BbField("CUST_NMK", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "Назва клієнта"));
            Fields.Add( new BbField("CUST_ND", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "№ договору з клієнтом"));
            Fields.Add( new BbField("BENEF_NMK", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "Найменування контрагента"));
            Fields.Add( new BbField("ACC", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "ACC рахунку"));
            Fields.Add( new BbField("NLS", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "Рахунок"));
            Fields.Add( new BbField("PDAT", OracleDbType.Date, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "Дата створення локумента"));
            Fields.Add( new BbField("VDAT", OracleDbType.Date, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "Дата валютування"));
            Fields.Add( new BbField("KV", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "Валюта платежу"));
            Fields.Add( new BbField("TOTAL_SUM", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "Сума платежу"));
            Fields.Add( new BbField("UNBOUND_SUM", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "Частина суми платежу, не прив’язана до жодного з контрактів"));
            Fields.Add( new BbField("NAZN", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "Призначення платежу"));
            Fields.Add( new BbField("OP_TYPE_ID", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", ""));
            Fields.Add( new BbField("OP_TYPE", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "Тип операції (додатковий реквізит)"));
            Fields.Add( new BbField("PAY_TYPE", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "Тип, 0-раніше не прив'язані, 1-відв'язані реальні, 2-відв'язані фантоми"));
            Fields.Add( new BbField("PAY_TYPE_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "Назва типу"));
            Fields.Add( new BbField("IS_VISED", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "Признак візи, 0-незавізований,1-завізований"));
            Fields.Add( new BbField("DIRECT", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "Напрям платежу 0 - вхідні, 1 - вихідні"));
            Fields.Add( new BbField("DIRECT_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", ""));
            Fields.Add( new BbField("TT", OracleDbType.Char, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "Код операції"));
            Fields.Add( new BbField("BACKGROUND_COLOR", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_OUT_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вихідні (імпортні) платежі", "Колір фону (1 - жовтий, 0 - колір по замовчуванню)"));        
        }
        public Decimal? REF { get { return (Decimal?)FindField("REF").Value; } set {SetField("REF", value);} }
        public Decimal? CUST_RNK { get { return (Decimal?)FindField("CUST_RNK").Value; } set {SetField("CUST_RNK", value);} }
        public String CUST_OKPO { get { return (String)FindField("CUST_OKPO").Value; } set {SetField("CUST_OKPO", value);} }
        public String CUST_NMK { get { return (String)FindField("CUST_NMK").Value; } set {SetField("CUST_NMK", value);} }
        public String CUST_ND { get { return (String)FindField("CUST_ND").Value; } set {SetField("CUST_ND", value);} }
        public String BENEF_NMK { get { return (String)FindField("BENEF_NMK").Value; } set {SetField("BENEF_NMK", value);} }
        public Decimal? ACC { get { return (Decimal?)FindField("ACC").Value; } set {SetField("ACC", value);} }
        public String NLS { get { return (String)FindField("NLS").Value; } set {SetField("NLS", value);} }
        public DateTime? PDAT { get { return (DateTime?)FindField("PDAT").Value; } set {SetField("PDAT", value);} }
        public DateTime? VDAT { get { return (DateTime?)FindField("VDAT").Value; } set {SetField("VDAT", value);} }
        public Decimal? KV { get { return (Decimal?)FindField("KV").Value; } set {SetField("KV", value);} }
        public Decimal? TOTAL_SUM { get { return (Decimal?)FindField("TOTAL_SUM").Value; } set {SetField("TOTAL_SUM", value);} }
        public Decimal? UNBOUND_SUM { get { return (Decimal?)FindField("UNBOUND_SUM").Value; } set {SetField("UNBOUND_SUM", value);} }
        public String NAZN { get { return (String)FindField("NAZN").Value; } set {SetField("NAZN", value);} }
        public Decimal? OP_TYPE_ID { get { return (Decimal?)FindField("OP_TYPE_ID").Value; } set {SetField("OP_TYPE_ID", value);} }
        public String OP_TYPE { get { return (String)FindField("OP_TYPE").Value; } set {SetField("OP_TYPE", value);} }
        public Decimal? PAY_TYPE { get { return (Decimal?)FindField("PAY_TYPE").Value; } set {SetField("PAY_TYPE", value);} }
        public String PAY_TYPE_NAME { get { return (String)FindField("PAY_TYPE_NAME").Value; } set {SetField("PAY_TYPE_NAME", value);} }
        public Decimal? IS_VISED { get { return (Decimal?)FindField("IS_VISED").Value; } set {SetField("IS_VISED", value);} }
        public Decimal? DIRECT { get { return (Decimal?)FindField("DIRECT").Value; } set {SetField("DIRECT", value);} }
        public String DIRECT_NAME { get { return (String)FindField("DIRECT_NAME").Value; } set {SetField("DIRECT_NAME", value);} }
        public String TT { get { return (String)FindField("TT").Value; } set {SetField("TT", value);} }
        public Decimal? BACKGROUND_COLOR { get { return (Decimal?)FindField("BACKGROUND_COLOR").Value; } set {SetField("BACKGROUND_COLOR", value);} }
    }

    public sealed class VCimOutUnboundPaymentsFilters : BbFilters
    {
        public VCimOutUnboundPaymentsFilters(BbDataSource Parent) : base (Parent)
        {
            REF = new BBDecimalFilter(this, "REF");
            CUST_RNK = new BBDecimalFilter(this, "CUST_RNK");
            CUST_OKPO = new BBVarchar2Filter(this, "CUST_OKPO");
            CUST_NMK = new BBVarchar2Filter(this, "CUST_NMK");
            CUST_ND = new BBVarchar2Filter(this, "CUST_ND");
            BENEF_NMK = new BBVarchar2Filter(this, "BENEF_NMK");
            ACC = new BBDecimalFilter(this, "ACC");
            NLS = new BBVarchar2Filter(this, "NLS");
            PDAT = new BBDateFilter(this, "PDAT");
            VDAT = new BBDateFilter(this, "VDAT");
            KV = new BBDecimalFilter(this, "KV");
            TOTAL_SUM = new BBDecimalFilter(this, "TOTAL_SUM");
            UNBOUND_SUM = new BBDecimalFilter(this, "UNBOUND_SUM");
            NAZN = new BBVarchar2Filter(this, "NAZN");
            OP_TYPE_ID = new BBDecimalFilter(this, "OP_TYPE_ID");
            OP_TYPE = new BBVarchar2Filter(this, "OP_TYPE");
            PAY_TYPE = new BBDecimalFilter(this, "PAY_TYPE");
            PAY_TYPE_NAME = new BBVarchar2Filter(this, "PAY_TYPE_NAME");
            IS_VISED = new BBDecimalFilter(this, "IS_VISED");
            DIRECT = new BBDecimalFilter(this, "DIRECT");
            DIRECT_NAME = new BBVarchar2Filter(this, "DIRECT_NAME");
            TT = new BBCharFilter(this, "TT");
            BACKGROUND_COLOR = new BBDecimalFilter(this, "BACKGROUND_COLOR");
        }
        public BBDecimalFilter REF;
        public BBDecimalFilter CUST_RNK;
        public BBVarchar2Filter CUST_OKPO;
        public BBVarchar2Filter CUST_NMK;
        public BBVarchar2Filter CUST_ND;
        public BBVarchar2Filter BENEF_NMK;
        public BBDecimalFilter ACC;
        public BBVarchar2Filter NLS;
        public BBDateFilter PDAT;
        public BBDateFilter VDAT;
        public BBDecimalFilter KV;
        public BBDecimalFilter TOTAL_SUM;
        public BBDecimalFilter UNBOUND_SUM;
        public BBVarchar2Filter NAZN;
        public BBDecimalFilter OP_TYPE_ID;
        public BBVarchar2Filter OP_TYPE;
        public BBDecimalFilter PAY_TYPE;
        public BBVarchar2Filter PAY_TYPE_NAME;
        public BBDecimalFilter IS_VISED;
        public BBDecimalFilter DIRECT;
        public BBVarchar2Filter DIRECT_NAME;
        public BBCharFilter TT;
        public BBDecimalFilter BACKGROUND_COLOR;
    }

    public partial class VCimOutUnboundPayments : BbTable<VCimOutUnboundPaymentsRecord, VCimOutUnboundPaymentsFilters>
    {
        public VCimOutUnboundPayments() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VCimOutUnboundPayments(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VCimOutUnboundPaymentsRecord> Select(VCimOutUnboundPaymentsRecord Item)
        {
            List<VCimOutUnboundPaymentsRecord> res = new List<VCimOutUnboundPaymentsRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VCimOutUnboundPaymentsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (Decimal?)null : Convert.ToDecimal(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (Decimal?)null : Convert.ToDecimal(rdr[7]), 
                        rdr.IsDBNull(8) ?  (String)null : Convert.ToString(rdr[8]), 
                        rdr.IsDBNull(9) ?  (DateTime?)null : Convert.ToDateTime(rdr[9]), 
                        rdr.IsDBNull(10) ?  (DateTime?)null : Convert.ToDateTime(rdr[10]), 
                        rdr.IsDBNull(11) ?  (Decimal?)null : Convert.ToDecimal(rdr[11]), 
                        rdr.IsDBNull(12) ?  (Decimal?)null : Convert.ToDecimal(rdr[12]), 
                        rdr.IsDBNull(13) ?  (Decimal?)null : Convert.ToDecimal(rdr[13]), 
                        rdr.IsDBNull(14) ?  (String)null : Convert.ToString(rdr[14]), 
                        rdr.IsDBNull(15) ?  (Decimal?)null : Convert.ToDecimal(rdr[15]), 
                        rdr.IsDBNull(16) ?  (String)null : Convert.ToString(rdr[16]), 
                        rdr.IsDBNull(17) ?  (Decimal?)null : Convert.ToDecimal(rdr[17]), 
                        rdr.IsDBNull(18) ?  (String)null : Convert.ToString(rdr[18]), 
                        rdr.IsDBNull(19) ?  (Decimal?)null : Convert.ToDecimal(rdr[19]), 
                        rdr.IsDBNull(20) ?  (Decimal?)null : Convert.ToDecimal(rdr[20]), 
                        rdr.IsDBNull(21) ?  (String)null : Convert.ToString(rdr[21]), 
                        rdr.IsDBNull(22) ?  (String)null : Convert.ToString(rdr[22]), 
                        rdr.IsDBNull(23) ?  (Decimal?)null : Convert.ToDecimal(rdr[23]))
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