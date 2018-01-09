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

namespace Bars.Ins
{
    public sealed class VInsUserPartnerTypeTariffRecord : BbRecord
    {
        public VInsUserPartnerTypeTariffRecord(): base()
        {
            fillFields();
        }
        public VInsUserPartnerTypeTariffRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VInsUserPartnerTypeTariffRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? PARTNER_ID, Decimal? TYPE_ID, String TARIFF_ID, String TARIFF_NAME, Decimal? MIN_VALUE, Decimal? MIN_PERC, Decimal? MAX_VALUE, Decimal? MAX_PERC, Decimal? AMORT)
            : this(Parent)
        {
            this.PARTNER_ID = PARTNER_ID;
            this.TYPE_ID = TYPE_ID;
            this.TARIFF_ID = TARIFF_ID;
            this.TARIFF_NAME = TARIFF_NAME;
            this.MIN_VALUE = MIN_VALUE;
            this.MIN_PERC = MIN_PERC;
            this.MAX_VALUE = MAX_VALUE;
            this.MAX_PERC = MAX_PERC;
            this.AMORT = AMORT;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("PARTNER_ID", OracleDbType.Decimal, false, false, false, false, false, "V_INS_USER_PARTNER_TYPE_TARIFF", ObjectTypes.View, "Тариф по партнеру/типу доступний користувачу (Представлення)", "Ідентифікатор СК"));
            Fields.Add( new BbField("TYPE_ID", OracleDbType.Decimal, false, false, false, false, false, "V_INS_USER_PARTNER_TYPE_TARIFF", ObjectTypes.View, "Тариф по партнеру/типу доступний користувачу (Представлення)", "Ідентифікатор типу страхового договору"));
            Fields.Add( new BbField("TARIFF_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_INS_USER_PARTNER_TYPE_TARIFF", ObjectTypes.View, "Тариф по партнеру/типу доступний користувачу (Представлення)", "Ід. тарифу на компанію та тип"));
            Fields.Add( new BbField("TARIFF_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_INS_USER_PARTNER_TYPE_TARIFF", ObjectTypes.View, "Тариф по партнеру/типу доступний користувачу (Представлення)", "Найм. тарифу на компанію та тип"));
            Fields.Add( new BbField("MIN_VALUE", OracleDbType.Decimal, true, false, false, false, false, "V_INS_USER_PARTNER_TYPE_TARIFF", ObjectTypes.View, "Тариф по партнеру/типу доступний користувачу (Представлення)", "Мінімальна сума"));
            Fields.Add( new BbField("MIN_PERC", OracleDbType.Decimal, true, false, false, false, false, "V_INS_USER_PARTNER_TYPE_TARIFF", ObjectTypes.View, "Тариф по партнеру/типу доступний користувачу (Представлення)", "Мінімальний процент"));
            Fields.Add( new BbField("MAX_VALUE", OracleDbType.Decimal, true, false, false, false, false, "V_INS_USER_PARTNER_TYPE_TARIFF", ObjectTypes.View, "Тариф по партнеру/типу доступний користувачу (Представлення)", "Максимальна сума"));
            Fields.Add( new BbField("MAX_PERC", OracleDbType.Decimal, true, false, false, false, false, "V_INS_USER_PARTNER_TYPE_TARIFF", ObjectTypes.View, "Тариф по партнеру/типу доступний користувачу (Представлення)", "Максимальний процент"));
            Fields.Add( new BbField("AMORT", OracleDbType.Decimal, true, false, false, false, false, "V_INS_USER_PARTNER_TYPE_TARIFF", ObjectTypes.View, "Тариф по партнеру/типу доступний користувачу (Представлення)", "Коефіцієнт амортизації"));        
        }
        public Decimal? PARTNER_ID { get { return (Decimal?)FindField("PARTNER_ID").Value; } set {SetField("PARTNER_ID", value);} }
        public Decimal? TYPE_ID { get { return (Decimal?)FindField("TYPE_ID").Value; } set {SetField("TYPE_ID", value);} }
        public String TARIFF_ID { get { return (String)FindField("TARIFF_ID").Value; } set {SetField("TARIFF_ID", value);} }
        public String TARIFF_NAME { get { return (String)FindField("TARIFF_NAME").Value; } set {SetField("TARIFF_NAME", value);} }
        public Decimal? MIN_VALUE { get { return (Decimal?)FindField("MIN_VALUE").Value; } set {SetField("MIN_VALUE", value);} }
        public Decimal? MIN_PERC { get { return (Decimal?)FindField("MIN_PERC").Value; } set {SetField("MIN_PERC", value);} }
        public Decimal? MAX_VALUE { get { return (Decimal?)FindField("MAX_VALUE").Value; } set {SetField("MAX_VALUE", value);} }
        public Decimal? MAX_PERC { get { return (Decimal?)FindField("MAX_PERC").Value; } set {SetField("MAX_PERC", value);} }
        public Decimal? AMORT { get { return (Decimal?)FindField("AMORT").Value; } set {SetField("AMORT", value);} }
    }

    public sealed class VInsUserPartnerTypeTariffFilters : BbFilters
    {
        public VInsUserPartnerTypeTariffFilters(BbDataSource Parent) : base (Parent)
        {
            PARTNER_ID = new BBDecimalFilter(this, "PARTNER_ID");
            TYPE_ID = new BBDecimalFilter(this, "TYPE_ID");
            TARIFF_ID = new BBVarchar2Filter(this, "TARIFF_ID");
            TARIFF_NAME = new BBVarchar2Filter(this, "TARIFF_NAME");
            MIN_VALUE = new BBDecimalFilter(this, "MIN_VALUE");
            MIN_PERC = new BBDecimalFilter(this, "MIN_PERC");
            MAX_VALUE = new BBDecimalFilter(this, "MAX_VALUE");
            MAX_PERC = new BBDecimalFilter(this, "MAX_PERC");
            AMORT = new BBDecimalFilter(this, "AMORT");
        }
        public BBDecimalFilter PARTNER_ID;
        public BBDecimalFilter TYPE_ID;
        public BBVarchar2Filter TARIFF_ID;
        public BBVarchar2Filter TARIFF_NAME;
        public BBDecimalFilter MIN_VALUE;
        public BBDecimalFilter MIN_PERC;
        public BBDecimalFilter MAX_VALUE;
        public BBDecimalFilter MAX_PERC;
        public BBDecimalFilter AMORT;
    }

    public partial class VInsUserPartnerTypeTariff : BbTable<VInsUserPartnerTypeTariffRecord, VInsUserPartnerTypeTariffFilters>
    {
        public VInsUserPartnerTypeTariff() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VInsUserPartnerTypeTariff(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VInsUserPartnerTypeTariffRecord> Select(VInsUserPartnerTypeTariffRecord Item)
        {
            List<VInsUserPartnerTypeTariffRecord> res = new List<VInsUserPartnerTypeTariffRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VInsUserPartnerTypeTariffRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (Decimal?)null : Convert.ToDecimal(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (Decimal?)null : Convert.ToDecimal(rdr[5]), 
                        rdr.IsDBNull(6) ?  (Decimal?)null : Convert.ToDecimal(rdr[6]), 
                        rdr.IsDBNull(7) ?  (Decimal?)null : Convert.ToDecimal(rdr[7]), 
                        rdr.IsDBNull(8) ?  (Decimal?)null : Convert.ToDecimal(rdr[8]), 
                        rdr.IsDBNull(9) ?  (Decimal?)null : Convert.ToDecimal(rdr[9]))
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