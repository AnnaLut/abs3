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
    public sealed class VInsFrequenciesRecord : BbRecord
    {
        public VInsFrequenciesRecord(): base()
        {
            fillFields();
        }
        public VInsFrequenciesRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VInsFrequenciesRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? ID, String NAME)
            : this(Parent)
        {
            this.ID = ID;
            this.NAME = NAME;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("ID", OracleDbType.Decimal, false, false, false, false, false, "V_INS_FREQUENCIES", ObjectTypes.View, "Список періодичностей для страховок (Представлення)", "Ідентифікатор"));
            Fields.Add( new BbField("NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_INS_FREQUENCIES", ObjectTypes.View, "Список періодичностей для страховок (Представлення)", "Найменування"));        
        }
        public Decimal? ID { get { return (Decimal?)FindField("ID").Value; } set {SetField("ID", value);} }
        public String NAME { get { return (String)FindField("NAME").Value; } set {SetField("NAME", value);} }
    }

    public sealed class VInsFrequenciesFilters : BbFilters
    {
        public VInsFrequenciesFilters(BbDataSource Parent) : base (Parent)
        {
            ID = new BBDecimalFilter(this, "ID");
            NAME = new BBVarchar2Filter(this, "NAME");
        }
        public BBDecimalFilter ID;
        public BBVarchar2Filter NAME;
    }

    public partial class VInsFrequencies : BbTable<VInsFrequenciesRecord, VInsFrequenciesFilters>
    {
        public VInsFrequencies() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VInsFrequencies(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VInsFrequenciesRecord> Select(VInsFrequenciesRecord Item)
        {
            List<VInsFrequenciesRecord> res = new List<VInsFrequenciesRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VInsFrequenciesRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]))
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