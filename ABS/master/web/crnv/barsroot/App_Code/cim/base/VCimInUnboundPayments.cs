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
    public sealed class VCimInUnboundPaymentsRecord : BbRecord
    {
        public VCimInUnboundPaymentsRecord(): base()
        {
            fillFields();
        }
        public VCimInUnboundPaymentsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VCimInUnboundPaymentsRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? REF, Decimal? CUST_RNK, String CUST_OKPO, String CUST_NMK, String CUST_ND, String BENEF_NMK, String NLS, DateTime? VDAT, Decimal? KV, Decimal? TOTAL_SUM, Decimal? UNBOUND_SUM, String NAZN, String OP_TYPE, Decimal? PAY_TYPE, Decimal? IS_VISED)
            : this(Parent)
        {
            this.REF = REF;
            this.CUST_RNK = CUST_RNK;
            this.CUST_OKPO = CUST_OKPO;
            this.CUST_NMK = CUST_NMK;
            this.CUST_ND = CUST_ND;
            this.BENEF_NMK = BENEF_NMK;
            this.NLS = NLS;
            this.VDAT = VDAT;
            this.KV = KV;
            this.TOTAL_SUM = TOTAL_SUM;
            this.UNBOUND_SUM = UNBOUND_SUM;
            this.NAZN = NAZN;
            this.OP_TYPE = OP_TYPE;
            this.PAY_TYPE = PAY_TYPE;
            this.IS_VISED = IS_VISED;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("REF", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_IN_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вхідні (экспортні) платежі", "Референс платежу"));
            Fields.Add( new BbField("CUST_RNK", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_IN_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вхідні (экспортні) платежі", "Реєстраційний номер клієнта"));
            Fields.Add( new BbField("CUST_OKPO", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_IN_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вхідні (экспортні) платежі", "ЄДРПОУ клієнта"));
            Fields.Add( new BbField("CUST_NMK", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_IN_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вхідні (экспортні) платежі", "Назва клієнта"));
            Fields.Add( new BbField("CUST_ND", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_IN_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вхідні (экспортні) платежі", "№ договору з клієнтом"));
            Fields.Add( new BbField("BENEF_NMK", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_IN_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вхідні (экспортні) платежі", "Найменування контрагента"));
            Fields.Add( new BbField("NLS", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_IN_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вхідні (экспортні) платежі", "Рахунок"));
            Fields.Add( new BbField("VDAT", OracleDbType.Date, true, false, false, false, false, "V_CIM_IN_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вхідні (экспортні) платежі", "Дата валютування"));
            Fields.Add( new BbField("KV", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_IN_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вхідні (экспортні) платежі", "Валюта платежу"));
            Fields.Add( new BbField("TOTAL_SUM", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_IN_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вхідні (экспортні) платежі", "Сума платежу"));
            Fields.Add( new BbField("UNBOUND_SUM", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_IN_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вхідні (экспортні) платежі", "Частина суми платежу, не прив’язана до жодного з контрактів"));
            Fields.Add( new BbField("NAZN", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_IN_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вхідні (экспортні) платежі", "Призначення платежу"));
            Fields.Add( new BbField("OP_TYPE", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_IN_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вхідні (экспортні) платежі", "Тип операції (додатковий реквізит)"));
            Fields.Add( new BbField("PAY_TYPE", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_IN_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вхідні (экспортні) платежі", "Тип, 0-раніше не прив'язані, 1-відв'язані реальні, 2-відв'язані фантоми"));
            Fields.Add( new BbField("IS_VISED", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_IN_UNBOUND_PAYMENTS", ObjectTypes.View, "Нерозібрані вхідні (экспортні) платежі", "Признак візи, 0-незавізований,1-завізований"));        
        }
        public Decimal? REF { get { return (Decimal?)FindField("REF").Value; } set {SetField("REF", value);} }
        public Decimal? CUST_RNK { get { return (Decimal?)FindField("CUST_RNK").Value; } set {SetField("CUST_RNK", value);} }
        public String CUST_OKPO { get { return (String)FindField("CUST_OKPO").Value; } set {SetField("CUST_OKPO", value);} }
        public String CUST_NMK { get { return (String)FindField("CUST_NMK").Value; } set {SetField("CUST_NMK", value);} }
        public String CUST_ND { get { return (String)FindField("CUST_ND").Value; } set {SetField("CUST_ND", value);} }
        public String BENEF_NMK { get { return (String)FindField("BENEF_NMK").Value; } set {SetField("BENEF_NMK", value);} }
        public String NLS { get { return (String)FindField("NLS").Value; } set {SetField("NLS", value);} }
        public DateTime? VDAT { get { return (DateTime?)FindField("VDAT").Value; } set {SetField("VDAT", value);} }
        public Decimal? KV { get { return (Decimal?)FindField("KV").Value; } set {SetField("KV", value);} }
        public Decimal? TOTAL_SUM { get { return (Decimal?)FindField("TOTAL_SUM").Value; } set {SetField("TOTAL_SUM", value);} }
        public Decimal? UNBOUND_SUM { get { return (Decimal?)FindField("UNBOUND_SUM").Value; } set {SetField("UNBOUND_SUM", value);} }
        public String NAZN { get { return (String)FindField("NAZN").Value; } set {SetField("NAZN", value);} }
        public String OP_TYPE { get { return (String)FindField("OP_TYPE").Value; } set {SetField("OP_TYPE", value);} }
        public Decimal? PAY_TYPE { get { return (Decimal?)FindField("PAY_TYPE").Value; } set {SetField("PAY_TYPE", value);} }
        public Decimal? IS_VISED { get { return (Decimal?)FindField("IS_VISED").Value; } set {SetField("IS_VISED", value);} }
    }

    public sealed class VCimInUnboundPaymentsFilters : BbFilters
    {
        public VCimInUnboundPaymentsFilters(BbDataSource Parent) : base (Parent)
        {
            REF = new BBDecimalFilter(this, "REF");
            CUST_RNK = new BBDecimalFilter(this, "CUST_RNK");
            CUST_OKPO = new BBVarchar2Filter(this, "CUST_OKPO");
            CUST_NMK = new BBVarchar2Filter(this, "CUST_NMK");
            CUST_ND = new BBVarchar2Filter(this, "CUST_ND");
            BENEF_NMK = new BBVarchar2Filter(this, "BENEF_NMK");
            NLS = new BBVarchar2Filter(this, "NLS");
            VDAT = new BBDateFilter(this, "VDAT");
            KV = new BBDecimalFilter(this, "KV");
            TOTAL_SUM = new BBDecimalFilter(this, "TOTAL_SUM");
            UNBOUND_SUM = new BBDecimalFilter(this, "UNBOUND_SUM");
            NAZN = new BBVarchar2Filter(this, "NAZN");
            OP_TYPE = new BBVarchar2Filter(this, "OP_TYPE");
            PAY_TYPE = new BBDecimalFilter(this, "PAY_TYPE");
            IS_VISED = new BBDecimalFilter(this, "IS_VISED");
        }
        public BBDecimalFilter REF;
        public BBDecimalFilter CUST_RNK;
        public BBVarchar2Filter CUST_OKPO;
        public BBVarchar2Filter CUST_NMK;
        public BBVarchar2Filter CUST_ND;
        public BBVarchar2Filter BENEF_NMK;
        public BBVarchar2Filter NLS;
        public BBDateFilter VDAT;
        public BBDecimalFilter KV;
        public BBDecimalFilter TOTAL_SUM;
        public BBDecimalFilter UNBOUND_SUM;
        public BBVarchar2Filter NAZN;
        public BBVarchar2Filter OP_TYPE;
        public BBDecimalFilter PAY_TYPE;
        public BBDecimalFilter IS_VISED;
    }

    public partial class VCimInUnboundPayments : BbTable<VCimInUnboundPaymentsRecord, VCimInUnboundPaymentsFilters>
    {
        public VCimInUnboundPayments() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VCimInUnboundPayments(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VCimInUnboundPaymentsRecord> Select(VCimInUnboundPaymentsRecord Item)
        {
            List<VCimInUnboundPaymentsRecord> res = new List<VCimInUnboundPaymentsRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VCimInUnboundPaymentsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (Decimal?)null : Convert.ToDecimal(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
                        rdr.IsDBNull(8) ?  (DateTime?)null : Convert.ToDateTime(rdr[8]), 
                        rdr.IsDBNull(9) ?  (Decimal?)null : Convert.ToDecimal(rdr[9]), 
                        rdr.IsDBNull(10) ?  (Decimal?)null : Convert.ToDecimal(rdr[10]), 
                        rdr.IsDBNull(11) ?  (Decimal?)null : Convert.ToDecimal(rdr[11]), 
                        rdr.IsDBNull(12) ?  (String)null : Convert.ToString(rdr[12]), 
                        rdr.IsDBNull(13) ?  (String)null : Convert.ToString(rdr[13]), 
                        rdr.IsDBNull(14) ?  (Decimal?)null : Convert.ToDecimal(rdr[14]), 
                        rdr.IsDBNull(15) ?  (Decimal?)null : Convert.ToDecimal(rdr[15]))
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