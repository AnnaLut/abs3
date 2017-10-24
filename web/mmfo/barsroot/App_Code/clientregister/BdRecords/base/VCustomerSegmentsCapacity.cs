/*
    AUTOGENERATED! Do not modify this code.
*/

using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Collections.Specialized;
using System.Data;
using System.Web;
using System.Web.Configuration;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using ibank.core;

namespace clientregister
{
    public sealed class VCustomerSegmentsCapacityRecord : BbRecord
    {
        public VCustomerSegmentsCapacityRecord(): base()
        {
            fillFields();
        }
        public VCustomerSegmentsCapacityRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VCustomerSegmentsCapacityRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? RNK, Decimal? PRODUCT_AMOUNT, Decimal? DEPOSIT_AMOUNT, Decimal? CREDITS_AMOUNT, Decimal? CARDCREDITS_AMOUNT, Decimal? GARANT_CREDITS_AMOUNT, Decimal? ENERGYCREDITS_AMOUNT, Decimal? CARDS_AMOUNT, Decimal? ACCOUNTS_AMOUNT, Decimal? INDIVIDUAL_SAFES_AMOUNT, Decimal? CASHLOANS_AMOUNT, Decimal? BPK_CREDITLINE_AMOUNT, Decimal? INSURANCE_AVTOCIVILKA_AMOUNT, Decimal? INSURANCE_AVTOCIVILKAPLUS_AMOUNT, Decimal? INSURANCE_OBERIG_AMOUNT, Decimal? INSURANCE_CASH_AMOUNT)
            : this(Parent)
        {
            this.RNK = RNK;
            this.PRODUCT_AMOUNT = PRODUCT_AMOUNT;
            this.DEPOSIT_AMOUNT = DEPOSIT_AMOUNT;
            this.CREDITS_AMOUNT = CREDITS_AMOUNT;
            this.CARDCREDITS_AMOUNT = CARDCREDITS_AMOUNT;
            this.GARANT_CREDITS_AMOUNT = GARANT_CREDITS_AMOUNT;
            this.ENERGYCREDITS_AMOUNT = ENERGYCREDITS_AMOUNT;
            this.CARDS_AMOUNT = CARDS_AMOUNT;
            this.ACCOUNTS_AMOUNT = ACCOUNTS_AMOUNT;
            this.INDIVIDUAL_SAFES_AMOUNT = INDIVIDUAL_SAFES_AMOUNT;
            this.CASHLOANS_AMOUNT = CASHLOANS_AMOUNT;
            this.BPK_CREDITLINE_AMOUNT = BPK_CREDITLINE_AMOUNT;
            this.INSURANCE_AVTOCIVILKA_AMOUNT = INSURANCE_AVTOCIVILKA_AMOUNT;
            this.INSURANCE_AVTOCIVILKAPLUS_AMOUNT = INSURANCE_AVTOCIVILKAPLUS_AMOUNT;
            this.INSURANCE_OBERIG_AMOUNT = INSURANCE_OBERIG_AMOUNT;
            this.INSURANCE_CASH_AMOUNT = INSURANCE_CASH_AMOUNT;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("RNK", OracleDbType.Decimal, false, false, false, false, false, "V_CUSTOMER_SEGMENTS_CAPACITY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("PRODUCT_AMOUNT", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_CAPACITY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("DEPOSIT_AMOUNT", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_CAPACITY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CREDITS_AMOUNT", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_CAPACITY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CARDCREDITS_AMOUNT", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_CAPACITY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("GARANT_CREDITS_AMOUNT", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_CAPACITY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("ENERGYCREDITS_AMOUNT", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_CAPACITY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CARDS_AMOUNT", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_CAPACITY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("ACCOUNTS_AMOUNT", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_CAPACITY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("INDIVIDUAL_SAFES_AMOUNT", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_CAPACITY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CASHLOANS_AMOUNT", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_CAPACITY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("BPK_CREDITLINE_AMOUNT", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_CAPACITY", ObjectTypes.View, "", ""));
            Fields.Add(new BbField("INSURANCE_AVTOCIVILKA_AMOUNT", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_CAPACITY", ObjectTypes.View, "", ""));
            Fields.Add(new BbField("INSURANCE_AVTOCIVILKAPLUS_AMNT", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_CAPACITY", ObjectTypes.View, "", ""));
            Fields.Add(new BbField("INSURANCE_OBERIG_AMOUNT", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_CAPACITY", ObjectTypes.View, "", ""));
            Fields.Add(new BbField("INSURANCE_CASH_AMOUNT", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_CAPACITY", ObjectTypes.View, "", ""));
        }
        public Decimal? RNK { get { return (Decimal?)FindField("RNK").Value; } set {SetField("RNK", value);} }
        public Decimal? PRODUCT_AMOUNT { get { return (Decimal?)FindField("PRODUCT_AMOUNT").Value; } set {SetField("PRODUCT_AMOUNT", value);} }
        public Decimal? DEPOSIT_AMOUNT { get { return (Decimal?)FindField("DEPOSIT_AMOUNT").Value; } set {SetField("DEPOSIT_AMOUNT", value);} }
        public Decimal? CREDITS_AMOUNT { get { return (Decimal?)FindField("CREDITS_AMOUNT").Value; } set {SetField("CREDITS_AMOUNT", value);} }
        public Decimal? CARDCREDITS_AMOUNT { get { return (Decimal?)FindField("CARDCREDITS_AMOUNT").Value; } set {SetField("CARDCREDITS_AMOUNT", value);} }
        public Decimal? GARANT_CREDITS_AMOUNT { get { return (Decimal?)FindField("GARANT_CREDITS_AMOUNT").Value; } set {SetField("GARANT_CREDITS_AMOUNT", value);} }
        public Decimal? ENERGYCREDITS_AMOUNT { get { return (Decimal?)FindField("ENERGYCREDITS_AMOUNT").Value; } set {SetField("ENERGYCREDITS_AMOUNT", value);} }
        public Decimal? CARDS_AMOUNT { get { return (Decimal?)FindField("CARDS_AMOUNT").Value; } set {SetField("CARDS_AMOUNT", value);} }
        public Decimal? ACCOUNTS_AMOUNT { get { return (Decimal?)FindField("ACCOUNTS_AMOUNT").Value; } set {SetField("ACCOUNTS_AMOUNT", value);} }
        public Decimal? INDIVIDUAL_SAFES_AMOUNT { get { return (Decimal?)FindField("INDIVIDUAL_SAFES_AMOUNT").Value; } set {SetField("INDIVIDUAL_SAFES_AMOUNT", value);} }
        public Decimal? CASHLOANS_AMOUNT { get { return (Decimal?)FindField("CASHLOANS_AMOUNT").Value; } set {SetField("CASHLOANS_AMOUNT", value);} }
        public Decimal? BPK_CREDITLINE_AMOUNT { get { return (Decimal?)FindField("BPK_CREDITLINE_AMOUNT").Value; } set {SetField("BPK_CREDITLINE_AMOUNT", value);} }
        public Decimal? INSURANCE_AVTOCIVILKA_AMOUNT { get { return (Decimal?)FindField("INSURANCE_AVTOCIVILKA_AMOUNT").Value; } set { SetField("INSURANCE_AVTOCIVILKA_AMOUNT", value); } }
        public Decimal? INSURANCE_AVTOCIVILKAPLUS_AMOUNT { get { return (Decimal?)FindField("INSURANCE_AVTOCIVILKAPLUS_AMNT").Value; } set { SetField("INSURANCE_AVTOCIVILKAPLUS_AMNT", value); } }
        public Decimal? INSURANCE_OBERIG_AMOUNT { get { return (Decimal?)FindField("INSURANCE_OBERIG_AMOUNT").Value; } set { SetField("INSURANCE_OBERIG_AMOUNT", value); } }
        public Decimal? INSURANCE_CASH_AMOUNT { get { return (Decimal?)FindField("INSURANCE_CASH_AMOUNT").Value; } set { SetField("INSURANCE_CASH_AMOUNT", value); } }
    }

    public sealed class VCustomerSegmentsCapacityFilters : BbFilters
    {
        public VCustomerSegmentsCapacityFilters(BbDataSource Parent) : base (Parent)
        {
            RNK = new BBDecimalFilter(this, "RNK");
            PRODUCT_AMOUNT = new BBDecimalFilter(this, "PRODUCT_AMOUNT");
            DEPOSIT_AMOUNT = new BBDecimalFilter(this, "DEPOSIT_AMOUNT");
            CREDITS_AMOUNT = new BBDecimalFilter(this, "CREDITS_AMOUNT");
            CARDCREDITS_AMOUNT = new BBDecimalFilter(this, "CARDCREDITS_AMOUNT");
            GARANT_CREDITS_AMOUNT = new BBDecimalFilter(this, "GARANT_CREDITS_AMOUNT");
            ENERGYCREDITS_AMOUNT = new BBDecimalFilter(this, "ENERGYCREDITS_AMOUNT");
            CARDS_AMOUNT = new BBDecimalFilter(this, "CARDS_AMOUNT");
            ACCOUNTS_AMOUNT = new BBDecimalFilter(this, "ACCOUNTS_AMOUNT");
            INDIVIDUAL_SAFES_AMOUNT = new BBDecimalFilter(this, "INDIVIDUAL_SAFES_AMOUNT");
            CASHLOANS_AMOUNT = new BBDecimalFilter(this, "CASHLOANS_AMOUNT");
            BPK_CREDITLINE_AMOUNT = new BBDecimalFilter(this, "BPK_CREDITLINE_AMOUNT");
            INSURANCE_AVTOCIVILKA_AMOUNT = new BBDecimalFilter(this, "INSURANCE_AVTOCIVILKA_AMOUNT");
            INSURANCE_AVTOCIVILKAPLUS_AMOUNT = new BBDecimalFilter(this, "INSURANCE_AVTOCIVILKAPLUS_AMNT");
            INSURANCE_OBERIG_AMOUNT = new BBDecimalFilter(this, "INSURANCE_OBERIG_AMOUNT");
            INSURANCE_CASH_AMOUNT = new BBDecimalFilter(this, "INSURANCE_CASH_AMOUNT");
        }
        public BBDecimalFilter RNK;
        public BBDecimalFilter PRODUCT_AMOUNT;
        public BBDecimalFilter DEPOSIT_AMOUNT;
        public BBDecimalFilter CREDITS_AMOUNT;
        public BBDecimalFilter CARDCREDITS_AMOUNT;
        public BBDecimalFilter GARANT_CREDITS_AMOUNT;
        public BBDecimalFilter ENERGYCREDITS_AMOUNT;
        public BBDecimalFilter CARDS_AMOUNT;
        public BBDecimalFilter ACCOUNTS_AMOUNT;
        public BBDecimalFilter INDIVIDUAL_SAFES_AMOUNT;
        public BBDecimalFilter CASHLOANS_AMOUNT;
        public BBDecimalFilter BPK_CREDITLINE_AMOUNT;
        public BBDecimalFilter INSURANCE_AVTOCIVILKA_AMOUNT;
        public BBDecimalFilter INSURANCE_AVTOCIVILKAPLUS_AMOUNT;
        public BBDecimalFilter INSURANCE_OBERIG_AMOUNT;
        public BBDecimalFilter INSURANCE_CASH_AMOUNT;
    }

    public partial class VCustomerSegmentsCapacity : BbTable<VCustomerSegmentsCapacityRecord, VCustomerSegmentsCapacityFilters>
    {
        public VCustomerSegmentsCapacity(): base(new BbConnection())
        {
        }
        public VCustomerSegmentsCapacity(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VCustomerSegmentsCapacityRecord> Select(VCustomerSegmentsCapacityRecord Item)
        {
            if (useCache && null != HttpRuntime.Cache[cacheKey])
            {
                return (List<VCustomerSegmentsCapacityRecord>)HttpRuntime.Cache[cacheKey];
            }    
            else
            {
                List<VCustomerSegmentsCapacityRecord> res = new List<VCustomerSegmentsCapacityRecord>();
                OracleDataReader rdr = null;
                ConnectionResult connectionResult = Connection.InitConnection();
                try
                {
                    rdr = ExecuteReader(Item);
                    while (rdr.Read())
                    {
                        res.Add(new VCustomerSegmentsCapacityRecord(this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (Decimal?)null : Convert.ToDecimal(rdr[2]), 
                        rdr.IsDBNull(3) ?  (Decimal?)null : Convert.ToDecimal(rdr[3]), 
                        rdr.IsDBNull(4) ?  (Decimal?)null : Convert.ToDecimal(rdr[4]), 
                        rdr.IsDBNull(5) ?  (Decimal?)null : Convert.ToDecimal(rdr[5]), 
                        rdr.IsDBNull(6) ?  (Decimal?)null : Convert.ToDecimal(rdr[6]), 
                        rdr.IsDBNull(7) ?  (Decimal?)null : Convert.ToDecimal(rdr[7]), 
                        rdr.IsDBNull(8) ?  (Decimal?)null : Convert.ToDecimal(rdr[8]), 
                        rdr.IsDBNull(9) ?  (Decimal?)null : Convert.ToDecimal(rdr[9]), 
                        rdr.IsDBNull(10) ? (Decimal?)null : Convert.ToDecimal(rdr[10]), 
                        rdr.IsDBNull(11) ? (Decimal?)null : Convert.ToDecimal(rdr[11]),
                        rdr.IsDBNull(12) ? (Decimal?)null : Convert.ToDecimal(rdr[12]),
                        rdr.IsDBNull(13) ? (Decimal?)null : Convert.ToDecimal(rdr[13]),
                        rdr.IsDBNull(14) ? (Decimal?)null : Convert.ToDecimal(rdr[14]),
                        rdr.IsDBNull(15) ? (Decimal?)null : Convert.ToDecimal(rdr[15]),
                        rdr.IsDBNull(16) ? (Decimal?)null : Convert.ToDecimal(rdr[16]))
                        );
                    }
                }
                finally
                {
                    DisposeDataReader(rdr);
                    if (ConnectionResult.New == connectionResult)
                        Connection.CloseConnection();
                }
                if (useCache)
                {
                    HttpRuntime.Cache[cacheKey] = res;
                }
                return res;
            }
        }
    }
}