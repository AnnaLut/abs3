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

namespace Bars.CoinInvoice
{
    public sealed class VCoinInvoiceRecord : BbRecord
    {
        public VCoinInvoiceRecord(): base()
        {
            fillFields();
        }
        public VCoinInvoiceRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VCoinInvoiceRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? TYPE_ID, String ND, DateTime? DAT, String REASON, String BAILEE, String PROXY, Decimal? TOTAL_COUNT, Decimal? TOTAL_NOMINAL, Decimal? TOTAL_SUM, Decimal? TOTAL_WITHOUT_VAT, Decimal? VAT_PERCENT, Decimal? VAT_SUM, Decimal? TOTAL_NOMINAL_PRICE, Decimal? TOTAL_WITH_VAT, Decimal? REF, String SUM_PR)
            : this(Parent)
        {
            this.TYPE_ID = TYPE_ID;
            this.ND = ND;
            this.DAT = DAT;
            this.REASON = REASON;
            this.BAILEE = BAILEE;
            this.PROXY = PROXY;
            this.TOTAL_COUNT = TOTAL_COUNT;
            this.TOTAL_NOMINAL = TOTAL_NOMINAL;
            this.TOTAL_SUM = TOTAL_SUM;
            this.TOTAL_WITHOUT_VAT = TOTAL_WITHOUT_VAT;
            this.VAT_PERCENT = VAT_PERCENT;
            this.VAT_SUM = VAT_SUM;
            this.TOTAL_NOMINAL_PRICE = TOTAL_NOMINAL_PRICE;
            this.TOTAL_WITH_VAT = TOTAL_WITH_VAT;
            this.REF = REF;
            this.SUM_PR = SUM_PR;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("TYPE_ID", OracleDbType.Decimal, true, false, false, false, false, "V_COIN_INVOICE", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("ND", OracleDbType.Varchar2, true, false, false, false, false, "V_COIN_INVOICE", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("DAT", OracleDbType.Date, true, false, false, false, false, "V_COIN_INVOICE", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("REASON", OracleDbType.Varchar2, true, false, false, false, false, "V_COIN_INVOICE", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("BAILEE", OracleDbType.Varchar2, true, false, false, false, false, "V_COIN_INVOICE", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("PROXY", OracleDbType.Varchar2, true, false, false, false, false, "V_COIN_INVOICE", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("TOTAL_COUNT", OracleDbType.Decimal, true, false, false, false, false, "V_COIN_INVOICE", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("TOTAL_NOMINAL", OracleDbType.Decimal, true, false, false, false, false, "V_COIN_INVOICE", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("TOTAL_SUM", OracleDbType.Decimal, true, false, false, false, false, "V_COIN_INVOICE", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("TOTAL_WITHOUT_VAT", OracleDbType.Decimal, true, false, false, false, false, "V_COIN_INVOICE", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("VAT_PERCENT", OracleDbType.Decimal, true, false, false, false, false, "V_COIN_INVOICE", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("VAT_SUM", OracleDbType.Decimal, true, false, false, false, false, "V_COIN_INVOICE", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("TOTAL_NOMINAL_PRICE", OracleDbType.Decimal, true, false, false, false, false, "V_COIN_INVOICE", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("TOTAL_WITH_VAT", OracleDbType.Decimal, true, false, false, false, false, "V_COIN_INVOICE", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("REF", OracleDbType.Decimal, true, false, false, false, false, "V_COIN_INVOICE", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("SUM_PR", OracleDbType.Varchar2, true, false, false, false, false, "V_COIN_INVOICE", ObjectTypes.View, "", ""));        
        }
        public Decimal? TYPE_ID { get { return (Decimal?)FindField("TYPE_ID").Value; } set {SetField("TYPE_ID", value);} }
        public String ND { get { return (String)FindField("ND").Value; } set {SetField("ND", value);} }
        public DateTime? DAT { get { return (DateTime?)FindField("DAT").Value; } set {SetField("DAT", value);} }
        public String REASON { get { return (String)FindField("REASON").Value; } set {SetField("REASON", value);} }
        public String BAILEE { get { return (String)FindField("BAILEE").Value; } set {SetField("BAILEE", value);} }
        public String PROXY { get { return (String)FindField("PROXY").Value; } set {SetField("PROXY", value);} }
        public Decimal? TOTAL_COUNT { get { return (Decimal?)FindField("TOTAL_COUNT").Value; } set {SetField("TOTAL_COUNT", value);} }
        public Decimal? TOTAL_NOMINAL { get { return (Decimal?)FindField("TOTAL_NOMINAL").Value; } set {SetField("TOTAL_NOMINAL", value);} }
        public Decimal? TOTAL_SUM { get { return (Decimal?)FindField("TOTAL_SUM").Value; } set {SetField("TOTAL_SUM", value);} }
        public Decimal? TOTAL_WITHOUT_VAT { get { return (Decimal?)FindField("TOTAL_WITHOUT_VAT").Value; } set {SetField("TOTAL_WITHOUT_VAT", value);} }
        public Decimal? VAT_PERCENT { get { return (Decimal?)FindField("VAT_PERCENT").Value; } set {SetField("VAT_PERCENT", value);} }
        public Decimal? VAT_SUM { get { return (Decimal?)FindField("VAT_SUM").Value; } set {SetField("VAT_SUM", value);} }
        public Decimal? TOTAL_NOMINAL_PRICE { get { return (Decimal?)FindField("TOTAL_NOMINAL_PRICE").Value; } set {SetField("TOTAL_NOMINAL_PRICE", value);} }
        public Decimal? TOTAL_WITH_VAT { get { return (Decimal?)FindField("TOTAL_WITH_VAT").Value; } set {SetField("TOTAL_WITH_VAT", value);} }
        public Decimal? REF { get { return (Decimal?)FindField("REF").Value; } set {SetField("REF", value);} }
        public String SUM_PR { get { return (String)FindField("SUM_PR").Value; } set {SetField("SUM_PR", value);} }
    }

    public sealed class VCoinInvoiceFilters : BbFilters
    {
        public VCoinInvoiceFilters(BbDataSource Parent) : base (Parent)
        {
            TYPE_ID = new BBDecimalFilter(this, "TYPE_ID");
            ND = new BBVarchar2Filter(this, "ND");
            DAT = new BBDateFilter(this, "DAT");
            REASON = new BBVarchar2Filter(this, "REASON");
            BAILEE = new BBVarchar2Filter(this, "BAILEE");
            PROXY = new BBVarchar2Filter(this, "PROXY");
            TOTAL_COUNT = new BBDecimalFilter(this, "TOTAL_COUNT");
            TOTAL_NOMINAL = new BBDecimalFilter(this, "TOTAL_NOMINAL");
            TOTAL_SUM = new BBDecimalFilter(this, "TOTAL_SUM");
            TOTAL_WITHOUT_VAT = new BBDecimalFilter(this, "TOTAL_WITHOUT_VAT");
            VAT_PERCENT = new BBDecimalFilter(this, "VAT_PERCENT");
            VAT_SUM = new BBDecimalFilter(this, "VAT_SUM");
            TOTAL_NOMINAL_PRICE = new BBDecimalFilter(this, "TOTAL_NOMINAL_PRICE");
            TOTAL_WITH_VAT = new BBDecimalFilter(this, "TOTAL_WITH_VAT");
            REF = new BBDecimalFilter(this, "REF");
            SUM_PR = new BBVarchar2Filter(this, "SUM_PR");
        }
        public BBDecimalFilter TYPE_ID;
        public BBVarchar2Filter ND;
        public BBDateFilter DAT;
        public BBVarchar2Filter REASON;
        public BBVarchar2Filter BAILEE;
        public BBVarchar2Filter PROXY;
        public BBDecimalFilter TOTAL_COUNT;
        public BBDecimalFilter TOTAL_NOMINAL;
        public BBDecimalFilter TOTAL_SUM;
        public BBDecimalFilter TOTAL_WITHOUT_VAT;
        public BBDecimalFilter VAT_PERCENT;
        public BBDecimalFilter VAT_SUM;
        public BBDecimalFilter TOTAL_NOMINAL_PRICE;
        public BBDecimalFilter TOTAL_WITH_VAT;
        public BBDecimalFilter REF;
        public BBVarchar2Filter SUM_PR;
    }

    public partial class VCoinInvoice : BbTable<VCoinInvoiceRecord, VCoinInvoiceFilters>
    {
        public VCoinInvoice() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VCoinInvoice(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VCoinInvoiceRecord> Select(VCoinInvoiceRecord Item)
        {
            List<VCoinInvoiceRecord> res = new List<VCoinInvoiceRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VCoinInvoiceRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (DateTime?)null : Convert.ToDateTime(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (Decimal?)null : Convert.ToDecimal(rdr[7]), 
                        rdr.IsDBNull(8) ?  (Decimal?)null : Convert.ToDecimal(rdr[8]), 
                        rdr.IsDBNull(9) ?  (Decimal?)null : Convert.ToDecimal(rdr[9]), 
                        rdr.IsDBNull(10) ?  (Decimal?)null : Convert.ToDecimal(rdr[10]), 
                        rdr.IsDBNull(11) ?  (Decimal?)null : Convert.ToDecimal(rdr[11]), 
                        rdr.IsDBNull(12) ?  (Decimal?)null : Convert.ToDecimal(rdr[12]), 
                        rdr.IsDBNull(13) ?  (Decimal?)null : Convert.ToDecimal(rdr[13]), 
                        rdr.IsDBNull(14) ?  (Decimal?)null : Convert.ToDecimal(rdr[14]), 
                        rdr.IsDBNull(15) ?  (Decimal?)null : Convert.ToDecimal(rdr[15]), 
                        rdr.IsDBNull(16) ?  (String)null : Convert.ToString(rdr[16]))
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