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

namespace clientregister
{
    public sealed class VCustRelationTypesRecord : BbRecord
    {
        public VCustRelationTypesRecord(): base()
        {
            fillFields();
        }
        public VCustRelationTypesRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VCustRelationTypesRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? RNK, Decimal? REL_INTEXT, Decimal? REL_RNK, Decimal? REL_ID, String REL_NAME, String DATASET_ID, Decimal? RELID_SELECTED)
            : this(Parent)
        {
            this.RNK = RNK;
            this.REL_INTEXT = REL_INTEXT;
            this.REL_RNK = REL_RNK;
            this.REL_ID = REL_ID;
            this.REL_NAME = REL_NAME;
            this.DATASET_ID = DATASET_ID;
            this.RELID_SELECTED = RELID_SELECTED;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("RNK", OracleDbType.Decimal, false, false, false, false, false, "V_CUST_RELATION_TYPES", ObjectTypes.View, "Типы связей клиента (Представление)", "РНК клиента"));
            Fields.Add( new BbField("REL_INTEXT", OracleDbType.Decimal, false, false, false, false, false, "V_CUST_RELATION_TYPES", ObjectTypes.View, "Типы связей клиента (Представление)", "Тип связанного лица (1 - клиент банка, 0 - НЕ клиент банка)"));
            Fields.Add( new BbField("REL_RNK", OracleDbType.Decimal, false, false, false, false, false, "V_CUST_RELATION_TYPES", ObjectTypes.View, "Типы связей клиента (Представление)", "Код связанного лица в таблице источнике (rel_intext=1 - customer.rnk; rel_intext=0 - customer_extern.id)"));
            Fields.Add( new BbField("REL_ID", OracleDbType.Decimal, false, false, false, false, false, "V_CUST_RELATION_TYPES", ObjectTypes.View, "Типы связей клиента (Представление)", "Идентификатор типа связи"));
            Fields.Add( new BbField("REL_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_CUST_RELATION_TYPES", ObjectTypes.View, "Типы связей клиента (Представление)", "Наименование типа связи"));
            Fields.Add( new BbField("DATASET_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_RELATION_TYPES", ObjectTypes.View, "Типы связей клиента (Представление)", "Идентификатор набора данных (TRUSTEE - довірена особа, VAGA - з врахуванням ваги, SIMPLE - базовий)"));
            Fields.Add( new BbField("RELID_SELECTED", OracleDbType.Decimal, true, false, false, false, false, "V_CUST_RELATION_TYPES", ObjectTypes.View, "Типы связей клиента (Представление)", "Признак того, что типа связи выбран"));        
        }
        public Decimal? RNK { get { return (Decimal?)FindField("RNK").Value; } set {SetField("RNK", value);} }
        public Decimal? REL_INTEXT { get { return (Decimal?)FindField("REL_INTEXT").Value; } set {SetField("REL_INTEXT", value);} }
        public Decimal? REL_RNK { get { return (Decimal?)FindField("REL_RNK").Value; } set {SetField("REL_RNK", value);} }
        public Decimal? REL_ID { get { return (Decimal?)FindField("REL_ID").Value; } set {SetField("REL_ID", value);} }
        public String REL_NAME { get { return (String)FindField("REL_NAME").Value; } set {SetField("REL_NAME", value);} }
        public String DATASET_ID { get { return (String)FindField("DATASET_ID").Value; } set {SetField("DATASET_ID", value);} }
        public Decimal? RELID_SELECTED { get { return (Decimal?)FindField("RELID_SELECTED").Value; } set {SetField("RELID_SELECTED", value);} }
    }

    public sealed class VCustRelationTypesFilters : BbFilters
    {
        public VCustRelationTypesFilters(BbDataSource Parent) : base (Parent)
        {
            RNK = new BBDecimalFilter(this, "RNK");
            REL_INTEXT = new BBDecimalFilter(this, "REL_INTEXT");
            REL_RNK = new BBDecimalFilter(this, "REL_RNK");
            REL_ID = new BBDecimalFilter(this, "REL_ID");
            REL_NAME = new BBVarchar2Filter(this, "REL_NAME");
            DATASET_ID = new BBVarchar2Filter(this, "DATASET_ID");
            RELID_SELECTED = new BBDecimalFilter(this, "RELID_SELECTED");
        }
        public BBDecimalFilter RNK;
        public BBDecimalFilter REL_INTEXT;
        public BBDecimalFilter REL_RNK;
        public BBDecimalFilter REL_ID;
        public BBVarchar2Filter REL_NAME;
        public BBVarchar2Filter DATASET_ID;
        public BBDecimalFilter RELID_SELECTED;
    }

    public partial class VCustRelationTypes : BbTable<VCustRelationTypesRecord, VCustRelationTypesFilters>
    {
        public VCustRelationTypes() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VCustRelationTypes(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VCustRelationTypesRecord> Select(VCustRelationTypesRecord Item)
        {
            List<VCustRelationTypesRecord> res = new List<VCustRelationTypesRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VCustRelationTypesRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (Decimal?)null : Convert.ToDecimal(rdr[2]), 
                        rdr.IsDBNull(3) ?  (Decimal?)null : Convert.ToDecimal(rdr[3]), 
                        rdr.IsDBNull(4) ?  (Decimal?)null : Convert.ToDecimal(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (Decimal?)null : Convert.ToDecimal(rdr[7]))
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