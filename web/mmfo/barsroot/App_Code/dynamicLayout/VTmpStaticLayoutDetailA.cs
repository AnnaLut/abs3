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

namespace Bars.DynamicLayout
{
    public sealed class VTmpStaticLayoutDetailARecord : BbRecord
    {
        public VTmpStaticLayoutDetailARecord(): base()
        {
            fillFields();
        }
        public VTmpStaticLayoutDetailARecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VTmpStaticLayoutDetailARecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? ID, String ND, Decimal? KV, String BRANCH, String BRANCH_NAME, String NLS_A, String NAMA, String OKPOA, String MFOB, String MFOB_NAME, String NLS_B, String NAMB, String OKPOB, Decimal? PERCENT, Decimal? SUMM_A, Decimal? SUMM_B, Decimal? DELTA, String TT, Decimal? VOB, String NAZN, String REF, Decimal? NLS_COUNT, Decimal? ORD, Decimal? USERID)
            : this(Parent)
        {
            this.ID = ID;
            this.ND = ND;
            this.KV = KV;
            this.BRANCH = BRANCH;
            this.BRANCH_NAME = BRANCH_NAME;
            this.NLS_A = NLS_A;
            this.NAMA = NAMA;
            this.OKPOA = OKPOA;
            this.MFOB = MFOB;
            this.MFOB_NAME = MFOB_NAME;
            this.NLS_B = NLS_B;
            this.NAMB = NAMB;
            this.OKPOB = OKPOB;
            this.PERCENT = PERCENT;
            this.SUMM_A = SUMM_A;
            this.SUMM_B = SUMM_B;
            this.DELTA = DELTA;
            this.TT = TT;
            this.VOB = VOB;
            this.NAZN = NAZN;
            this.REF = REF;
            this.NLS_COUNT = NLS_COUNT;
            this.ORD = ORD;
            this.USERID = USERID;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("ID", OracleDbType.Decimal, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("ND", OracleDbType.Varchar2, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("KV", OracleDbType.Decimal, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("BRANCH", OracleDbType.Varchar2, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("BRANCH_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("NLS_A", OracleDbType.Varchar2, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("NAMA", OracleDbType.Varchar2, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("OKPOA", OracleDbType.Varchar2, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("MFOB", OracleDbType.Varchar2, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("MFOB_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("NLS_B", OracleDbType.Varchar2, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("NAMB", OracleDbType.Varchar2, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("OKPOB", OracleDbType.Varchar2, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("PERCENT", OracleDbType.Decimal, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("SUMM_A", OracleDbType.Decimal, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("SUMM_B", OracleDbType.Decimal, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("DELTA", OracleDbType.Decimal, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("TT", OracleDbType.Varchar2, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("VOB", OracleDbType.Decimal, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("NAZN", OracleDbType.Varchar2, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("REF", OracleDbType.Varchar2, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("NLS_COUNT", OracleDbType.Decimal, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("ORD", OracleDbType.Decimal, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("USERID", OracleDbType.Decimal, true, false, false, false, false, "V_TMP_STATIC_LAYOUT_DETAIL_A", ObjectTypes.View, "", ""));        
        }
        public Decimal? ID { get { return (Decimal?)FindField("ID").Value; } set {SetField("ID", value);} }
        public String ND { get { return (String)FindField("ND").Value; } set {SetField("ND", value);} }
        public Decimal? KV { get { return (Decimal?)FindField("KV").Value; } set {SetField("KV", value);} }
        public String BRANCH { get { return (String)FindField("BRANCH").Value; } set {SetField("BRANCH", value);} }
        public String BRANCH_NAME { get { return (String)FindField("BRANCH_NAME").Value; } set {SetField("BRANCH_NAME", value);} }
        public String NLS_A { get { return (String)FindField("NLS_A").Value; } set {SetField("NLS_A", value);} }
        public String NAMA { get { return (String)FindField("NAMA").Value; } set {SetField("NAMA", value);} }
        public String OKPOA { get { return (String)FindField("OKPOA").Value; } set {SetField("OKPOA", value);} }
        public String MFOB { get { return (String)FindField("MFOB").Value; } set {SetField("MFOB", value);} }
        public String MFOB_NAME { get { return (String)FindField("MFOB_NAME").Value; } set {SetField("MFOB_NAME", value);} }
        public String NLS_B { get { return (String)FindField("NLS_B").Value; } set {SetField("NLS_B", value);} }
        public String NAMB { get { return (String)FindField("NAMB").Value; } set {SetField("NAMB", value);} }
        public String OKPOB { get { return (String)FindField("OKPOB").Value; } set {SetField("OKPOB", value);} }
        public Decimal? PERCENT { get { return (Decimal?)FindField("PERCENT").Value; } set {SetField("PERCENT", value);} }
        public Decimal? SUMM_A { get { return (Decimal?)FindField("SUMM_A").Value; } set {SetField("SUMM_A", value);} }
        public Decimal? SUMM_B { get { return (Decimal?)FindField("SUMM_B").Value; } set {SetField("SUMM_B", value);} }
        public Decimal? DELTA { get { return (Decimal?)FindField("DELTA").Value; } set {SetField("DELTA", value);} }
        public String TT { get { return (String)FindField("TT").Value; } set {SetField("TT", value);} }
        public Decimal? VOB { get { return (Decimal?)FindField("VOB").Value; } set {SetField("VOB", value);} }
        public String NAZN { get { return (String)FindField("NAZN").Value; } set {SetField("NAZN", value);} }
        public String REF { get { return (String)FindField("REF").Value; } set {SetField("REF", value);} }
        public Decimal? NLS_COUNT { get { return (Decimal?)FindField("NLS_COUNT").Value; } set {SetField("NLS_COUNT", value);} }
        public Decimal? ORD { get { return (Decimal?)FindField("ORD").Value; } set {SetField("ORD", value);} }
        public Decimal? USERID { get { return (Decimal?)FindField("USERID").Value; } set {SetField("USERID", value);} }
    }

    public sealed class VTmpStaticLayoutDetailAFilters : BbFilters
    {
        public VTmpStaticLayoutDetailAFilters(BbDataSource Parent) : base (Parent)
        {
            ID = new BBDecimalFilter(this, "ID");
            ND = new BBVarchar2Filter(this, "ND");
            KV = new BBDecimalFilter(this, "KV");
            BRANCH = new BBVarchar2Filter(this, "BRANCH");
            BRANCH_NAME = new BBVarchar2Filter(this, "BRANCH_NAME");
            NLS_A = new BBVarchar2Filter(this, "NLS_A");
            NAMA = new BBVarchar2Filter(this, "NAMA");
            OKPOA = new BBVarchar2Filter(this, "OKPOA");
            MFOB = new BBVarchar2Filter(this, "MFOB");
            MFOB_NAME = new BBVarchar2Filter(this, "MFOB_NAME");
            NLS_B = new BBVarchar2Filter(this, "NLS_B");
            NAMB = new BBVarchar2Filter(this, "NAMB");
            OKPOB = new BBVarchar2Filter(this, "OKPOB");
            PERCENT = new BBDecimalFilter(this, "PERCENT");
            SUMM_A = new BBDecimalFilter(this, "SUMM_A");
            SUMM_B = new BBDecimalFilter(this, "SUMM_B");
            DELTA = new BBDecimalFilter(this, "DELTA");
            TT = new BBVarchar2Filter(this, "TT");
            VOB = new BBDecimalFilter(this, "VOB");
            NAZN = new BBVarchar2Filter(this, "NAZN");
            REF = new BBVarchar2Filter(this, "REF");
            NLS_COUNT = new BBDecimalFilter(this, "NLS_COUNT");
            ORD = new BBDecimalFilter(this, "ORD");
            USERID = new BBDecimalFilter(this, "USERID");
        }
        public BBDecimalFilter ID;
        public BBVarchar2Filter ND;
        public BBDecimalFilter KV;
        public BBVarchar2Filter BRANCH;
        public BBVarchar2Filter BRANCH_NAME;
        public BBVarchar2Filter NLS_A;
        public BBVarchar2Filter NAMA;
        public BBVarchar2Filter OKPOA;
        public BBVarchar2Filter MFOB;
        public BBVarchar2Filter MFOB_NAME;
        public BBVarchar2Filter NLS_B;
        public BBVarchar2Filter NAMB;
        public BBVarchar2Filter OKPOB;
        public BBDecimalFilter PERCENT;
        public BBDecimalFilter SUMM_A;
        public BBDecimalFilter SUMM_B;
        public BBDecimalFilter DELTA;
        public BBVarchar2Filter TT;
        public BBDecimalFilter VOB;
        public BBVarchar2Filter NAZN;
        public BBVarchar2Filter REF;
        public BBDecimalFilter NLS_COUNT;
        public BBDecimalFilter ORD;
        public BBDecimalFilter USERID;
    }

    public partial class VTmpStaticLayoutDetailA : BbTable<VTmpStaticLayoutDetailARecord, VTmpStaticLayoutDetailAFilters>
    {
        public VTmpStaticLayoutDetailA() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VTmpStaticLayoutDetailA(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VTmpStaticLayoutDetailARecord> Select(VTmpStaticLayoutDetailARecord Item)
        {
            List<VTmpStaticLayoutDetailARecord> res = new List<VTmpStaticLayoutDetailARecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VTmpStaticLayoutDetailARecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (Decimal?)null : Convert.ToDecimal(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
                        rdr.IsDBNull(8) ?  (String)null : Convert.ToString(rdr[8]), 
                        rdr.IsDBNull(9) ?  (String)null : Convert.ToString(rdr[9]), 
                        rdr.IsDBNull(10) ?  (String)null : Convert.ToString(rdr[10]), 
                        rdr.IsDBNull(11) ?  (String)null : Convert.ToString(rdr[11]), 
                        rdr.IsDBNull(12) ?  (String)null : Convert.ToString(rdr[12]), 
                        rdr.IsDBNull(13) ?  (String)null : Convert.ToString(rdr[13]), 
                        rdr.IsDBNull(14) ?  (Decimal?)null : Convert.ToDecimal(rdr[14]), 
                        rdr.IsDBNull(15) ?  (Decimal?)null : Convert.ToDecimal(rdr[15]), 
                        rdr.IsDBNull(16) ?  (Decimal?)null : Convert.ToDecimal(rdr[16]), 
                        rdr.IsDBNull(17) ?  (Decimal?)null : Convert.ToDecimal(rdr[17]), 
                        rdr.IsDBNull(18) ?  (String)null : Convert.ToString(rdr[18]), 
                        rdr.IsDBNull(19) ?  (Decimal?)null : Convert.ToDecimal(rdr[19]), 
                        rdr.IsDBNull(20) ?  (String)null : Convert.ToString(rdr[20]), 
                        rdr.IsDBNull(21) ?  (String)null : Convert.ToString(rdr[21]), 
                        rdr.IsDBNull(22) ?  (Decimal?)null : Convert.ToDecimal(rdr[22]), 
                        rdr.IsDBNull(23) ?  (Decimal?)null : Convert.ToDecimal(rdr[23]), 
                        rdr.IsDBNull(24) ?  (Decimal?)null : Convert.ToDecimal(rdr[24]))
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