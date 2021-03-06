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

namespace credit
{
    public sealed class VWcsSubproductCreditdataRecord : BbRecord
    {
        public VWcsSubproductCreditdataRecord(): base()
        {
            fillFields();
        }
        public VWcsSubproductCreditdataRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsSubproductCreditdataRecord(BbDataSource Parent, OracleDecimal RowScn, String SUBPRODUCT_ID, String CRDDATA_ID, String CRDDATA_NAME, String TYPE_ID, String TYPE_NAME, String QUESTION_ID, Decimal? IS_VISIBLE, String IS_READONLY, Decimal? IS_CHECKABLE, String CHECK_PROC)
            : this(Parent)
        {
            this.SUBPRODUCT_ID = SUBPRODUCT_ID;
            this.CRDDATA_ID = CRDDATA_ID;
            this.CRDDATA_NAME = CRDDATA_NAME;
            this.TYPE_ID = TYPE_ID;
            this.TYPE_NAME = TYPE_NAME;
            this.QUESTION_ID = QUESTION_ID;
            this.IS_VISIBLE = IS_VISIBLE;
            this.IS_READONLY = IS_READONLY;
            this.IS_CHECKABLE = IS_CHECKABLE;
            this.CHECK_PROC = CHECK_PROC;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("SUBPRODUCT_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SUBPRODUCT_CREDITDATA", ObjectTypes.View, "Параметры кредита по субпродукту (Представление)", "Идентификатор субродукта"));
            Fields.Add( new BbField("CRDDATA_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SUBPRODUCT_CREDITDATA", ObjectTypes.View, "Параметры кредита по субпродукту (Представление)", "Идентификатор параметра"));
            Fields.Add( new BbField("CRDDATA_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SUBPRODUCT_CREDITDATA", ObjectTypes.View, "Параметры кредита по субпродукту (Представление)", "Наименование параметра"));
            Fields.Add( new BbField("TYPE_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SUBPRODUCT_CREDITDATA", ObjectTypes.View, "Параметры кредита по субпродукту (Представление)", "Идентификатор типа"));
            Fields.Add( new BbField("TYPE_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SUBPRODUCT_CREDITDATA", ObjectTypes.View, "Параметры кредита по субпродукту (Представление)", "Наименование типа"));
            Fields.Add( new BbField("QUESTION_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SUBPRODUCT_CREDITDATA", ObjectTypes.View, "Параметры кредита по субпродукту (Представление)", "Идентификатор вопроса"));
            Fields.Add( new BbField("IS_VISIBLE", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_SUBPRODUCT_CREDITDATA", ObjectTypes.View, "Параметры кредита по субпродукту (Представление)", "Отображать/не отображать"));
            Fields.Add( new BbField("IS_READONLY", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SUBPRODUCT_CREDITDATA", ObjectTypes.View, "Параметры кредита по субпродукту (Представление)", "Только чтение (null/1/true - OK, 0/false - NOT OK)"));
            Fields.Add( new BbField("IS_CHECKABLE", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_SUBPRODUCT_CREDITDATA", ObjectTypes.View, "Параметры кредита по субпродукту (Представление)", "Проверять/не проверять"));
            Fields.Add( new BbField("CHECK_PROC", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SUBPRODUCT_CREDITDATA", ObjectTypes.View, "Параметры кредита по субпродукту (Представление)", "Текст проверки"));        
        }
        public String SUBPRODUCT_ID { get { return (String)FindField("SUBPRODUCT_ID").Value; } set {SetField("SUBPRODUCT_ID", value);} }
        public String CRDDATA_ID { get { return (String)FindField("CRDDATA_ID").Value; } set {SetField("CRDDATA_ID", value);} }
        public String CRDDATA_NAME { get { return (String)FindField("CRDDATA_NAME").Value; } set {SetField("CRDDATA_NAME", value);} }
        public String TYPE_ID { get { return (String)FindField("TYPE_ID").Value; } set {SetField("TYPE_ID", value);} }
        public String TYPE_NAME { get { return (String)FindField("TYPE_NAME").Value; } set {SetField("TYPE_NAME", value);} }
        public String QUESTION_ID { get { return (String)FindField("QUESTION_ID").Value; } set {SetField("QUESTION_ID", value);} }
        public Decimal? IS_VISIBLE { get { return (Decimal?)FindField("IS_VISIBLE").Value; } set {SetField("IS_VISIBLE", value);} }
        public String IS_READONLY { get { return (String)FindField("IS_READONLY").Value; } set {SetField("IS_READONLY", value);} }
        public Decimal? IS_CHECKABLE { get { return (Decimal?)FindField("IS_CHECKABLE").Value; } set {SetField("IS_CHECKABLE", value);} }
        public String CHECK_PROC { get { return (String)FindField("CHECK_PROC").Value; } set {SetField("CHECK_PROC", value);} }
    }

    public sealed class VWcsSubproductCreditdataFilters : BbFilters
    {
        public VWcsSubproductCreditdataFilters(BbDataSource Parent) : base (Parent)
        {
            SUBPRODUCT_ID = new BBVarchar2Filter(this, "SUBPRODUCT_ID");
            CRDDATA_ID = new BBVarchar2Filter(this, "CRDDATA_ID");
            CRDDATA_NAME = new BBVarchar2Filter(this, "CRDDATA_NAME");
            TYPE_ID = new BBVarchar2Filter(this, "TYPE_ID");
            TYPE_NAME = new BBVarchar2Filter(this, "TYPE_NAME");
            QUESTION_ID = new BBVarchar2Filter(this, "QUESTION_ID");
            IS_VISIBLE = new BBDecimalFilter(this, "IS_VISIBLE");
            IS_READONLY = new BBVarchar2Filter(this, "IS_READONLY");
            IS_CHECKABLE = new BBDecimalFilter(this, "IS_CHECKABLE");
            CHECK_PROC = new BBVarchar2Filter(this, "CHECK_PROC");
        }
        public BBVarchar2Filter SUBPRODUCT_ID;
        public BBVarchar2Filter CRDDATA_ID;
        public BBVarchar2Filter CRDDATA_NAME;
        public BBVarchar2Filter TYPE_ID;
        public BBVarchar2Filter TYPE_NAME;
        public BBVarchar2Filter QUESTION_ID;
        public BBDecimalFilter IS_VISIBLE;
        public BBVarchar2Filter IS_READONLY;
        public BBDecimalFilter IS_CHECKABLE;
        public BBVarchar2Filter CHECK_PROC;
    }

    public partial class VWcsSubproductCreditdata : BbTable<VWcsSubproductCreditdataRecord, VWcsSubproductCreditdataFilters>
    {
        public VWcsSubproductCreditdata() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsSubproductCreditdata(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsSubproductCreditdataRecord> Select(VWcsSubproductCreditdataRecord Item)
        {
            List<VWcsSubproductCreditdataRecord> res = new List<VWcsSubproductCreditdataRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsSubproductCreditdataRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (String)null : Convert.ToString(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (Decimal?)null : Convert.ToDecimal(rdr[7]), 
                        rdr.IsDBNull(8) ?  (String)null : Convert.ToString(rdr[8]), 
                        rdr.IsDBNull(9) ?  (Decimal?)null : Convert.ToDecimal(rdr[9]), 
                        rdr.IsDBNull(10) ?  (String)null : Convert.ToString(rdr[10]))
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