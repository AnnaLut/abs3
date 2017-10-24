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
    public sealed class VCimCredgraphPaymentRecord : BbRecord
    {
        public VCimCredgraphPaymentRecord(): base()
        {
            fillFields();
        }
        public VCimCredgraphPaymentRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VCimCredgraphPaymentRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? CONTR_ID, String ROW_ID, DateTime? DAT, Decimal? S, Decimal? PAY_FLAG_ID, String PAY_FLAG)
            : this(Parent)
        {
            this.CONTR_ID = CONTR_ID;
            this.ROW_ID = ROW_ID;
            this.DAT = DAT;
            this.S = S;
            this.PAY_FLAG_ID = PAY_FLAG_ID;
            this.PAY_FLAG = PAY_FLAG;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("CONTR_ID", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_CREDGRAPH_PAYMENT", ObjectTypes.View, "Неперіодичні планові платежі графіка кредитного контракту", "ID рядка"));
            Fields.Add( new BbField("ROW_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_CREDGRAPH_PAYMENT", ObjectTypes.View, "Неперіодичні планові платежі графіка кредитного контракту", ""));
            Fields.Add( new BbField("DAT", OracleDbType.Date, false, false, false, false, false, "V_CIM_CREDGRAPH_PAYMENT", ObjectTypes.View, "Неперіодичні планові платежі графіка кредитного контракту", "Дата платежа"));
            Fields.Add( new BbField("S", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_CREDGRAPH_PAYMENT", ObjectTypes.View, "Неперіодичні планові платежі графіка кредитного контракту", "Сума платежа"));
            Fields.Add( new BbField("PAY_FLAG_ID", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_CREDGRAPH_PAYMENT", ObjectTypes.View, "Неперіодичні планові платежі графіка кредитного контракту", "id класифікатора платежа"));
            Fields.Add( new BbField("PAY_FLAG", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_CREDGRAPH_PAYMENT", ObjectTypes.View, "Неперіодичні планові платежі графіка кредитного контракту", "Класифікатор платежа"));        
        }
        public Decimal? CONTR_ID { get { return (Decimal?)FindField("CONTR_ID").Value; } set {SetField("CONTR_ID", value);} }
        public String ROW_ID { get { return (String)FindField("ROW_ID").Value; } set {SetField("ROW_ID", value);} }
        public DateTime? DAT { get { return (DateTime?)FindField("DAT").Value; } set {SetField("DAT", value);} }
        public Decimal? S { get { return (Decimal?)FindField("S").Value; } set {SetField("S", value);} }
        public Decimal? PAY_FLAG_ID { get { return (Decimal?)FindField("PAY_FLAG_ID").Value; } set {SetField("PAY_FLAG_ID", value);} }
        public String PAY_FLAG { get { return (String)FindField("PAY_FLAG").Value; } set {SetField("PAY_FLAG", value);} }
    }

    public sealed class VCimCredgraphPaymentFilters : BbFilters
    {
        public VCimCredgraphPaymentFilters(BbDataSource Parent) : base (Parent)
        {
            CONTR_ID = new BBDecimalFilter(this, "CONTR_ID");
            ROW_ID = new BBVarchar2Filter(this, "ROW_ID");
            DAT = new BBDateFilter(this, "DAT");
            S = new BBDecimalFilter(this, "S");
            PAY_FLAG_ID = new BBDecimalFilter(this, "PAY_FLAG_ID");
            PAY_FLAG = new BBVarchar2Filter(this, "PAY_FLAG");
        }
        public BBDecimalFilter CONTR_ID;
        public BBVarchar2Filter ROW_ID;
        public BBDateFilter DAT;
        public BBDecimalFilter S;
        public BBDecimalFilter PAY_FLAG_ID;
        public BBVarchar2Filter PAY_FLAG;
    }

    public partial class VCimCredgraphPayment : BbTable<VCimCredgraphPaymentRecord, VCimCredgraphPaymentFilters>
    {
        public VCimCredgraphPayment() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VCimCredgraphPayment(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VCimCredgraphPaymentRecord> Select(VCimCredgraphPaymentRecord Item)
        {
            List<VCimCredgraphPaymentRecord> res = new List<VCimCredgraphPaymentRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VCimCredgraphPaymentRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (DateTime?)null : Convert.ToDateTime(rdr[3]), 
                        rdr.IsDBNull(4) ?  (Decimal?)null : Convert.ToDecimal(rdr[4]), 
                        rdr.IsDBNull(5) ?  (Decimal?)null : Convert.ToDecimal(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]))
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