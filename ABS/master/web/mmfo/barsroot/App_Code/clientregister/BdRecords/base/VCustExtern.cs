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
    public sealed class VCustExternRecord : BbRecord
    {
        public VCustExternRecord(): base()
        {
            fillFields();
        }
        public VCustExternRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VCustExternRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? RNK, String NAME, Decimal? DOC_TYPE, String DOC_NAME, String DOC_SERIAL, String DOC_NUMBER, DateTime? DOC_DATE, String DOC_ISSUER, DateTime? BIRTHDAY, String BIRTHPLACE, String SEX, String SEX_NAME, String ADR, String TEL, String EMAIL, Decimal? CUSTTYPE, String OKPO, Decimal? COUNTRY, String COUNTRY_NAME, String REGION, String FS, String FS_NAME, String VED, String VED_NAME, String SED, String SED_NAME, String ISE, String ISE_NAME, String NOTES
            , DateTime? DATE_PHOTO, String EDDR_ID, DateTime? ACTUAL_DATE)
            : this(Parent)
        {
            this.RNK = RNK;
            this.NAME = NAME;
            this.DOC_TYPE = DOC_TYPE;
            this.DOC_NAME = DOC_NAME;
            this.DOC_SERIAL = DOC_SERIAL;
            this.DOC_NUMBER = DOC_NUMBER;
            this.DOC_DATE = DOC_DATE;
            this.DOC_ISSUER = DOC_ISSUER;
            this.BIRTHDAY = BIRTHDAY;
            this.BIRTHPLACE = BIRTHPLACE;
            this.SEX = SEX;
            this.SEX_NAME = SEX_NAME;
            this.ADR = ADR;
            this.TEL = TEL;
            this.EMAIL = EMAIL;
            this.CUSTTYPE = CUSTTYPE;
            this.OKPO = OKPO;
            this.COUNTRY = COUNTRY;
            this.COUNTRY_NAME = COUNTRY_NAME;
            this.REGION = REGION;
            this.FS = FS;
            this.FS_NAME = FS_NAME;
            this.VED = VED;
            this.VED_NAME = VED_NAME;
            this.SED = SED;
            this.SED_NAME = SED_NAME;
            this.ISE = ISE;
            this.ISE_NAME = ISE_NAME;
            this.NOTES = NOTES;
            // COBUMMFO-8536 --->
            this.DATE_PHOTO = DATE_PHOTO;
            this.EDDR_ID = EDDR_ID;
            this.ACTUAL_DATE = ACTUAL_DATE;
            // COBUMMFO-8536 <---
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("RNK", OracleDbType.Decimal, false, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "РНК НЕ клиента"));
            Fields.Add( new BbField("NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Наименование/ФИО"));
            Fields.Add( new BbField("DOC_TYPE", OracleDbType.Decimal, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Тип документа"));
            Fields.Add( new BbField("DOC_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Наименование документа"));
            Fields.Add( new BbField("DOC_SERIAL", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Серия документв"));
            Fields.Add( new BbField("DOC_NUMBER", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Номер документа"));
            Fields.Add( new BbField("DOC_DATE", OracleDbType.Date, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Дата выдачи документа"));
            Fields.Add( new BbField("DOC_ISSUER", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Место выдачи документа"));
            Fields.Add( new BbField("BIRTHDAY", OracleDbType.Date, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Дата рождения"));
            Fields.Add( new BbField("BIRTHPLACE", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Место рождения"));
            Fields.Add( new BbField("SEX", OracleDbType.Char, false, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Пол"));
            Fields.Add( new BbField("SEX_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Пол наименование"));
            Fields.Add( new BbField("ADR", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Адрес"));
            Fields.Add( new BbField("TEL", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Телефон"));
            Fields.Add( new BbField("EMAIL", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "E_mail"));
            Fields.Add( new BbField("CUSTTYPE", OracleDbType.Decimal, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Признак (1-ЮЛ, 2-ФЛ)"));
            Fields.Add( new BbField("OKPO", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "ОКПО"));
            Fields.Add( new BbField("COUNTRY", OracleDbType.Decimal, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Код страны"));
            Fields.Add( new BbField("COUNTRY_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Наименование страны"));
            Fields.Add( new BbField("REGION", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Код региона"));
            Fields.Add( new BbField("FS", OracleDbType.Char, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Форма собственности (K081)"));
            Fields.Add( new BbField("FS_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Форма собственности (K081) наименование"));
            Fields.Add( new BbField("VED", OracleDbType.Char, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Вид эк. деят-ти (K110)"));
            Fields.Add( new BbField("VED_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Вид эк. деят-ти (K110) наименование"));
            Fields.Add( new BbField("SED", OracleDbType.Char, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Орг.-правовая форма (K051)"));
            Fields.Add( new BbField("SED_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Орг.-правовая форма (K051) наименование"));
            Fields.Add( new BbField("ISE", OracleDbType.Char, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Инст. сектор экономики (K070)"));
            Fields.Add( new BbField("ISE_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Инст. сектор экономики (K070) наименование"));
            Fields.Add( new BbField("NOTES", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Комментарий"));        
            // COBUMMFO-8536 --->
            Fields.Add(new BbField("DATE_PHOTO", OracleDbType.Date, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Дата вклеювання фото"));
            Fields.Add(new BbField("EDDR_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Унікальний номер запису в ЄДДР"));
            Fields.Add(new BbField("ACTUAL_DATE", OracleDbType.Date, true, false, false, false, false, "V_CUST_EXTERN", ObjectTypes.View, "Не клиенты банка (Представление)", "Термін дії паспорту у вигляді ID-картки"));
            // COBUMMFO-8536 <---
        }
        public Decimal? RNK { get { return (Decimal?)FindField("RNK").Value; } set {SetField("RNK", value);} }
        public String NAME { get { return (String)FindField("NAME").Value; } set {SetField("NAME", value);} }
        public Decimal? DOC_TYPE { get { return (Decimal?)FindField("DOC_TYPE").Value; } set {SetField("DOC_TYPE", value);} }
        public String DOC_NAME { get { return (String)FindField("DOC_NAME").Value; } set {SetField("DOC_NAME", value);} }
        public String DOC_SERIAL { get { return (String)FindField("DOC_SERIAL").Value; } set {SetField("DOC_SERIAL", value);} }
        public String DOC_NUMBER { get { return (String)FindField("DOC_NUMBER").Value; } set {SetField("DOC_NUMBER", value);} }
        public DateTime? DOC_DATE { get { return (DateTime?)FindField("DOC_DATE").Value; } set {SetField("DOC_DATE", value);} }
        public String DOC_ISSUER { get { return (String)FindField("DOC_ISSUER").Value; } set {SetField("DOC_ISSUER", value);} }
        public DateTime? BIRTHDAY { get { return (DateTime?)FindField("BIRTHDAY").Value; } set {SetField("BIRTHDAY", value);} }
        public String BIRTHPLACE { get { return (String)FindField("BIRTHPLACE").Value; } set {SetField("BIRTHPLACE", value);} }
        public String SEX { get { return (String)FindField("SEX").Value; } set {SetField("SEX", value);} }
        public String SEX_NAME { get { return (String)FindField("SEX_NAME").Value; } set {SetField("SEX_NAME", value);} }
        public String ADR { get { return (String)FindField("ADR").Value; } set {SetField("ADR", value);} }
        public String TEL { get { return (String)FindField("TEL").Value; } set {SetField("TEL", value);} }
        public String EMAIL { get { return (String)FindField("EMAIL").Value; } set {SetField("EMAIL", value);} }
        public Decimal? CUSTTYPE { get { return (Decimal?)FindField("CUSTTYPE").Value; } set {SetField("CUSTTYPE", value);} }
        public String OKPO { get { return (String)FindField("OKPO").Value; } set {SetField("OKPO", value);} }
        public Decimal? COUNTRY { get { return (Decimal?)FindField("COUNTRY").Value; } set {SetField("COUNTRY", value);} }
        public String COUNTRY_NAME { get { return (String)FindField("COUNTRY_NAME").Value; } set {SetField("COUNTRY_NAME", value);} }
        public String REGION { get { return (String)FindField("REGION").Value; } set {SetField("REGION", value);} }
        public String FS { get { return (String)FindField("FS").Value; } set {SetField("FS", value);} }
        public String FS_NAME { get { return (String)FindField("FS_NAME").Value; } set {SetField("FS_NAME", value);} }
        public String VED { get { return (String)FindField("VED").Value; } set {SetField("VED", value);} }
        public String VED_NAME { get { return (String)FindField("VED_NAME").Value; } set {SetField("VED_NAME", value);} }
        public String SED { get { return (String)FindField("SED").Value; } set {SetField("SED", value);} }
        public String SED_NAME { get { return (String)FindField("SED_NAME").Value; } set {SetField("SED_NAME", value);} }
        public String ISE { get { return (String)FindField("ISE").Value; } set {SetField("ISE", value);} }
        public String ISE_NAME { get { return (String)FindField("ISE_NAME").Value; } set {SetField("ISE_NAME", value);} }
        public String NOTES { get { return (String)FindField("NOTES").Value; } set {SetField("NOTES", value);} }

        // COBUMMFO-8536 --->

        // Доопрацювання картки клієнта-ЮО в частині паспортних даних пов'язаних осіб
        // ---> Добавлено 3 поля по аналогії з Person 
        public DateTime? DATE_PHOTO { get { return (DateTime?)FindField("DATE_PHOTO").Value; } set { SetField("DATE_PHOTO", value); } }
        public String EDDR_ID { get { return (String)FindField("EDDR_ID").Value; } set { SetField("EDDR_ID", value); } }
        public DateTime? ACTUAL_DATE { get { return (DateTime?)FindField("ACTUAL_DATE").Value; } set { SetField("ACTUAL_DATE", value); } }
        // COBUMMFO-8536 <---

    }

    public sealed class VCustExternFilters : BbFilters
    {
        public VCustExternFilters(BbDataSource Parent) : base (Parent)
        {
            RNK = new BBDecimalFilter(this, "RNK");
            NAME = new BBVarchar2Filter(this, "NAME");
            DOC_TYPE = new BBDecimalFilter(this, "DOC_TYPE");
            DOC_NAME = new BBVarchar2Filter(this, "DOC_NAME");
            DOC_SERIAL = new BBVarchar2Filter(this, "DOC_SERIAL");
            DOC_NUMBER = new BBVarchar2Filter(this, "DOC_NUMBER");
            DOC_DATE = new BBDateFilter(this, "DOC_DATE");
            DOC_ISSUER = new BBVarchar2Filter(this, "DOC_ISSUER");
            BIRTHDAY = new BBDateFilter(this, "BIRTHDAY");
            BIRTHPLACE = new BBVarchar2Filter(this, "BIRTHPLACE");
            SEX = new BBCharFilter(this, "SEX");
            SEX_NAME = new BBVarchar2Filter(this, "SEX_NAME");
            ADR = new BBVarchar2Filter(this, "ADR");
            TEL = new BBVarchar2Filter(this, "TEL");
            EMAIL = new BBVarchar2Filter(this, "EMAIL");
            CUSTTYPE = new BBDecimalFilter(this, "CUSTTYPE");
            OKPO = new BBVarchar2Filter(this, "OKPO");
            COUNTRY = new BBDecimalFilter(this, "COUNTRY");
            COUNTRY_NAME = new BBVarchar2Filter(this, "COUNTRY_NAME");
            REGION = new BBVarchar2Filter(this, "REGION");
            FS = new BBCharFilter(this, "FS");
            FS_NAME = new BBVarchar2Filter(this, "FS_NAME");
            VED = new BBCharFilter(this, "VED");
            VED_NAME = new BBVarchar2Filter(this, "VED_NAME");
            SED = new BBCharFilter(this, "SED");
            SED_NAME = new BBVarchar2Filter(this, "SED_NAME");
            ISE = new BBCharFilter(this, "ISE");
            ISE_NAME = new BBVarchar2Filter(this, "ISE_NAME");
            NOTES = new BBVarchar2Filter(this, "NOTES");
            // COBUMMFO-8536 --->
            DATE_PHOTO = new BBVarchar2Filter(this, "NOTES");
            EDDR_ID = new BBVarchar2Filter(this, "NOTES");
            ACTUAL_DATE = new BBVarchar2Filter(this, "NOTES");
            // COBUMMFO-8536 <---
        }
        public BBDecimalFilter RNK;
        public BBVarchar2Filter NAME;
        public BBDecimalFilter DOC_TYPE;
        public BBVarchar2Filter DOC_NAME;
        public BBVarchar2Filter DOC_SERIAL;
        public BBVarchar2Filter DOC_NUMBER;
        public BBDateFilter DOC_DATE;
        public BBVarchar2Filter DOC_ISSUER;
        public BBDateFilter BIRTHDAY;
        public BBVarchar2Filter BIRTHPLACE;
        public BBCharFilter SEX;
        public BBVarchar2Filter SEX_NAME;
        public BBVarchar2Filter ADR;
        public BBVarchar2Filter TEL;
        public BBVarchar2Filter EMAIL;
        public BBDecimalFilter CUSTTYPE;
        public BBVarchar2Filter OKPO;
        public BBDecimalFilter COUNTRY;
        public BBVarchar2Filter COUNTRY_NAME;
        public BBVarchar2Filter REGION;
        public BBCharFilter FS;
        public BBVarchar2Filter FS_NAME;
        public BBCharFilter VED;
        public BBVarchar2Filter VED_NAME;
        public BBCharFilter SED;
        public BBVarchar2Filter SED_NAME;
        public BBCharFilter ISE;
        public BBVarchar2Filter ISE_NAME;
        public BBVarchar2Filter NOTES;
        // COBUMMFO-8536 --->
        public BBVarchar2Filter DATE_PHOTO;
        public BBVarchar2Filter EDDR_ID;
        public BBVarchar2Filter ACTUAL_DATE;
        // COBUMMFO-8536 <---
    }

    public partial class VCustExtern : BbTable<VCustExternRecord, VCustExternFilters>
    {
        public VCustExtern() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VCustExtern(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VCustExternRecord> Select(VCustExternRecord Item)
        {
            List<VCustExternRecord> res = new List<VCustExternRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VCustExternRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (Decimal?)null : Convert.ToDecimal(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (DateTime?)null : Convert.ToDateTime(rdr[7]), 
                        rdr.IsDBNull(8) ?  (String)null : Convert.ToString(rdr[8]), 
                        rdr.IsDBNull(9) ?  (DateTime?)null : Convert.ToDateTime(rdr[9]), 
                        rdr.IsDBNull(10) ?  (String)null : Convert.ToString(rdr[10]), 
                        rdr.IsDBNull(11) ?  (String)null : Convert.ToString(rdr[11]), 
                        rdr.IsDBNull(12) ?  (String)null : Convert.ToString(rdr[12]), 
                        rdr.IsDBNull(13) ?  (String)null : Convert.ToString(rdr[13]), 
                        rdr.IsDBNull(14) ?  (String)null : Convert.ToString(rdr[14]), 
                        rdr.IsDBNull(15) ?  (String)null : Convert.ToString(rdr[15]), 
                        rdr.IsDBNull(16) ?  (Decimal?)null : Convert.ToDecimal(rdr[16]), 
                        rdr.IsDBNull(17) ?  (String)null : Convert.ToString(rdr[17]), 
                        rdr.IsDBNull(18) ?  (Decimal?)null : Convert.ToDecimal(rdr[18]), 
                        rdr.IsDBNull(19) ?  (String)null : Convert.ToString(rdr[19]), 
                        rdr.IsDBNull(20) ?  (String)null : Convert.ToString(rdr[20]), 
                        rdr.IsDBNull(21) ?  (String)null : Convert.ToString(rdr[21]), 
                        rdr.IsDBNull(22) ?  (String)null : Convert.ToString(rdr[22]), 
                        rdr.IsDBNull(23) ?  (String)null : Convert.ToString(rdr[23]), 
                        rdr.IsDBNull(24) ?  (String)null : Convert.ToString(rdr[24]), 
                        rdr.IsDBNull(25) ?  (String)null : Convert.ToString(rdr[25]), 
                        rdr.IsDBNull(26) ?  (String)null : Convert.ToString(rdr[26]), 
                        rdr.IsDBNull(27) ?  (String)null : Convert.ToString(rdr[27]), 
                        rdr.IsDBNull(28) ?  (String)null : Convert.ToString(rdr[28]), 
                        rdr.IsDBNull(29) ?  (String)null : Convert.ToString(rdr[29]),
                        // COBUMMFO-8536 --->
                        rdr.IsDBNull(30) ? (DateTime?)null : Convert.ToDateTime(rdr[30]),
                        rdr.IsDBNull(31) ? (String)null : Convert.ToString(rdr[31]),
                        rdr.IsDBNull(32) ? (DateTime?)null : Convert.ToDateTime(rdr[32])
                        // COBUMMFO-8536 <---
                        )
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