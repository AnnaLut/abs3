using System;
using System.Linq;
using Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Models
{
    public class V_SEC_AUDIT_UI
    {
        public decimal REC_ID { get; set; }
        public decimal REC_UID { get; set; }
        public string REC_UNAME { get; set; }
        public string REC_UPROXY { get; set; }
        public DateTime REC_DATE { get; set; }
        public DateTime REC_BDATE { get; set; }
        public string REC_TYPE { get; set; }
        public string REC_MODULE { get; set; }
        public string REC_MESSAGE { get; set; }
        public string MACHINE { get; set; }
        public string REC_OBJECT { get; set; }
        public decimal REC_USERID { get; set; }
        public string BRANCH { get; set; }
        public string REC_STACK { get; set; }
        public string CLIENT_IDENTIFIER { get; set; }
        public string SEC_TYPECOMM { get; set; }
    }

    public class BRANCHES
    {
        public string BRANCH { get; set; }
        public string NAME { get; set; }
        public string ROLES { get; set; }
    }
    public class EAD_DOCS
    {
        public decimal ID { get; set; }
        public DateTime? CRT_DATE { get; set; }
        public decimal? CRT_STAFF_ID { get; set; }
        public string CRT_BRANCH { get; set; }
        public string TYPE_ID { get; set; }
        public string TEMPLATE_ID { get; set; }
        public byte[] SCAN_DATA { get; set; }
        public decimal? EA_STRUCT_ID { get; set; }
        public DateTime? SIGN_DATE { get; set; }
        public decimal? RNK { get; set; }
        public decimal? AGR_ID { get; set; }
        public decimal? PAGE_COUNT { get; set; }

    }

    public class BARS_BOARD
    {
        public decimal? ID { get; set; }
        public DateTime? MSG_DATE { get; set; }
        public string MSG_TITLE { get; set; }
        public string MSG_TEXT { get; set; }
        public string WRITER { get; set; }
        public string WRITER_FIO { get; set; }
    }

    public class V_USER_MESSAGES
    {
        public decimal? MSG_ID { get; set; }
        public decimal? USER_ID { get; set; }
        public decimal? MSG_SENDER_ID { get; set; }
        public string MSG_SENDER_FIO { get; set; }
        public string MSG_SUBJECT { get; set; }
        public string MSG_TEXT { get; set; }
        public DateTime? MSG_DATE { get; set; }
        public decimal? MSG_DONE { get; set; }
        public string USER_COMMENT { get; set; }
        public string DATE_TEXT { get; set; }
        public decimal? TODAY { get; set; }
        public string MSG_DONE_TEXT { get; set; }
    }

    public class USER_PARAM
    {
        public decimal? USER_ID { get; set; }
        public string USER_FULLNAME { get; set; }
        public string BANKDATE { get; set; }
        public string TOBO { get; set; }
        public string TOBONAME { get; set; }
        public string IDOPER { get; set; }
        public string ROLES { get; set; }
        public TELLER_USER_PARAM TELLER_USER_PARAM { get; set; }
    }

    public class TELLER_USER_PARAM
    {
        public int HAS_TELLER_ROLE { get; set; }
        public int IS_TELLER_ON { get; set; }
    }
    
    public class BP_REASON
    {
        public decimal ID { get; set; }
        public string REASON { get; set; }
    }

    public class V_VISALIST
    {
        public decimal? REF { get; set; }
        public decimal? COUNTER { get; set; }
        public decimal? SQNC { get; set; }
        public string MARK { get; set; }
        public decimal? MARKID { get; set; }
        public string CHECKGROUP { get; set; }
        public string USERNAME { get; set; }
        public DateTime? DAT { get; set; }
        public decimal? INCHARGE { get; set; }
        public decimal? SIGN_FLAG { get; set; }
        public string BUFINT { get; set; }
    }

    public class DtSystemSignParams
    {
        public decimal SIGNLNG { get; set; }
        public string DOCKEY { get; set; }
        public string BDATE { get; set; }
        public decimal SEPNUM { get; set; }
        public string SIGNTYPE { get; set; }
        public decimal VISASIGN { get; set; }
        public decimal INTSIGN { get; set; }
        public string REGNCODE { get; set; }
        public string EXTSIGNBUFF { get; set; }
    }
    /// <summary>
    /// клас справочника (valueID,valueNAME)
    /// </summary>
    public class Handbook
    {
        public string ID { get; set; }
        public string NAME { get; set; }
        public string DATA { get; set; }
    }

    public class V_CUST_RELATIONS
    {
        public decimal RNK { get; set; }
        public decimal? REL_INTEXT { get; set; }
        public decimal? RELEXT_ID { get; set; }
        public decimal? RELCUST_RNK { get; set; }
        public string NAME { get; set; }
        public decimal? DOC_TYPE { get; set; }
        public string DOC_NAME { get; set; }
        public string DOC_SERIAL { get; set; }
        public string DOC_NUMBER { get; set; }
        public DateTime? DOC_DATE { get; set; }
        public string DOC_ISSUER { get; set; }
        public DateTime? BIRTHDAY { get; set; }
        public string BIRTHPLACE { get; set; }
        public string SEX { get; set; }
        public string SEX_NAME { get; set; }
        public string ADR { get; set; }
        public string TEL { get; set; }
        public string EMAIL { get; set; }
        public decimal? CUSTTYPE { get; set; }
        public string OKPO { get; set; }
        public decimal? COUNTRY { get; set; }
        public string COUNTRY_NAME { get; set; }
        public string REGION { get; set; }
        public string FS { get; set; }
        public string FS_NAME { get; set; }
        public string VED { get; set; }
        public string VED_NAME { get; set; }
        public string SED { get; set; }
        public string SED_NAME { get; set; }
        public string ISE { get; set; }
        public string ISE_NAME { get; set; }
        public string NOTES { get; set; }
    }

    public class V_CUST_REL_TYPES
    {
        public decimal? ID { get; set; }
        public string NAME { get; set; }
        public string DATASET_ID { get; set; }
    }

    public class V_CUSTOMER_REL
    {
        public decimal? RNK { get; set; }
        public decimal? REL_ID { get; set; }
        public decimal? REL_RNK { get; set; }
        public decimal? REL_INTEXT { get; set; }
        public string NAME { get; set; }
        public decimal? DOC_TYPE { get; set; }
        public string DOC_SERIAL { get; set; }
        public string DOC_NUMBER { get; set; }
        public DateTime? DOC_DATE { get; set; }
        public string DOC_ISSUER { get; set; }
        public DateTime? BIRTHDAY { get; set; }
        public string BIRTHPLACE { get; set; }
        public string SEX { get; set; }
        public string ADR { get; set; }
        public string TEL { get; set; }
        public string EMAIL { get; set; }
        public decimal? CUSTTYPE { get; set; }
        public string OKPO { get; set; }
        public decimal? COUNTRY { get; set; }
        public string REGION { get; set; }
        public string FS { get; set; }
        public string VED { get; set; }
        public string SED { get; set; }
        public string ISE { get; set; }
        public string NOTES { get; set; }
        public decimal? VAGA1 { get; set; }
        public decimal? VAGA2 { get; set; }
        public decimal? TYPE_ID { get; set; }
        public string POSITION { get; set; }
        public string FIRST_NAME { get; set; }
        public string MIDDLE_NAME { get; set; }
        public string LAST_NAME { get; set; }
        public decimal? DOCUMENT_TYPE_ID { get; set; }
        public string DOCUMENT { get; set; }
        public string TRUST_REGNUM { get; set; }
        public DateTime? TRUST_REGDAT { get; set; }
        public DateTime? BDATE { get; set; }
        public DateTime? EDATE { get; set; }
        public string NOTARY_NAME { get; set; }
        public string NOTARY_REGION { get; set; }
        public decimal? SIGN_PRIVS { get; set; }
        public decimal? SIGN_ID { get; set; }
        public string NAME_R { get; set; }
    }

    public class CUSTOMER_UPDATE_HISTORY
    {
        public string PAR { get; set; }
        public string TABNAME { get; set; }
        public string OLD { get; set; }
        public string NEW { get; set; }
        public string DAT { get; set; }
        public string USR { get; set; }
        public string FIO { get; set; }
    }

    public class V_OPERAPP_UI
    {
        public string APPNAME { get; set; }
        public string CODEAPP { get; set; }
        public decimal? CODEOPER { get; set; }
        public string DATE_FINISH { get; set; }
        public string FUNCNAME { get; set; }
        public decimal? HITS { get; set; }
        public DateTime? LAST_HIT { get; set; } 
        public string OPERNAME { get; set; }
        public decimal? TOP { get; set; }
    }

    public class META_SORTORDER
    {
        public decimal TABID { get; set; }
        public decimal COLID { get; set; }
        public decimal SORTORDER { get; set; }
        public string SORTWAY { get; set; }
    }

    public class META_COL_INTL_FILTERS
    {
        public decimal FILTER_ID { get; set; }
        public decimal TABID { get; set; }
        public decimal COLID { get; set; }
        public short MANDATORY_FLAG_ID { get; set; }
    }

    public class DocSchemeReport
    {
        public string Id { get; set; }
        public string Name { get; set; }

        public decimal? State { get; set; }
        public string PRINT_NUMBER { get; set; }
        public decimal? Struct_Code { get; set; }

        public string DKBO_NUMBER { get; set; }
        public decimal RNK { get; set; }
    }

    public static class Function
    {
        public static string FConvertVal(this EntitiesBars entities, decimal valFrom, decimal summFrom, DateTime date, decimal valTo, string sourse = "O")
        {
            object[] parameters = 
                    { 
                        new OracleParameter("p_val_a",OracleDbType.Decimal).Value = valFrom,
                        new OracleParameter("p_sum",OracleDbType.Decimal).Value = summFrom,
                        new OracleParameter("p_date",OracleDbType.Date).Value = date,
                        new OracleParameter("p_val_b",OracleDbType.Decimal).Value = valTo,
                        new OracleParameter("p_kurs_type",OracleDbType.Varchar2).Value = sourse
                    };
            var result = entities.ExecuteStoreQuery<string>(
                "select f_convert_val(:p_val_a, :p_sum, :p_date, :p_val_b,  :p_kurs_type) from dual",parameters).FirstOrDefault();
            return result;
        } 
    }

    public class Documents 
    {
        public Decimal REF { get; set; }
        public Decimal? USERID { get; set; }
        public String ND { get; set; }
        public String NLSA { get; set; }
        public Decimal? S_ { get; set; }
        public String LCV2 { get; set; }
        public String MFOB { get; set; }
        public String NLSB { get; set; }
        public Decimal? DK { get; set; }
        public Decimal? SK { get; set; }
        public DateTime? DATD { get; set; }
        public String NAZN { get; set; }
        public Decimal? SOS { get; set; }
        public String TOBO { get; set; }
        public DateTime? PDAT { get; set; }
        public String TT { get; set; }
    }

}