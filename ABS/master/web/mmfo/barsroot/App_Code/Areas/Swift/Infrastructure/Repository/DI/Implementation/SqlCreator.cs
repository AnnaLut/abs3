using Areas.Swift.Models;
using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;

namespace BarsWeb.Areas.Swift.Infrastructure.DI.Implementation {
    public class SqlCreator
    {
        static public BarsSql ClaimsImpmsgMessageChangeuser(ClaimsImpmsgMessageChangeuser obj)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                        bars_swift.impmsg_message_changeuser(p_swRef => :p_swRef, p_srcUserID => :p_srcUserID, p_tgtUserID => :p_tgtUserID);
                    end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_swRef", OracleDbType.Decimal) { Value = obj.SWREF },
                    new OracleParameter("p_srcUserID", OracleDbType.Int32) { Value = obj.ID },
                    new OracleParameter("p_tgtUserID", OracleDbType.Int32) { Value = obj.TARGET_ID }
                }
            };
        }

        static public BarsSql ClaimsRowTitle(string bic)
        {
            return new BarsSql()
            {
                SqlText = @"select name from sw_banks where bic = :p_bic",
                SqlParams = new object[]
                {
                    new OracleParameter("p_bic", OracleDbType.Char) { Value = bic }
                }
            };
        }

        static public BarsSql TransbackInfo(string bic)
        {
            return new BarsSql()
            {
                SqlText = @"select chrset, transback from sw_banks where bic = :p_bic",
                SqlParams = new object[]
                {
                    new OracleParameter("p_bic", OracleDbType.Char) { Value = bic }
                }
            };
        }

        static public BarsSql ClaimsRowDataCent(decimal swref)
        {
            return new BarsSql()
            {
                SqlText = @"select tag,opt,value from sw_operw where swref = :p_swref order by tag",
                SqlParams = new object[]
                {
                    new OracleParameter("p_swref", OracleDbType.Decimal) { Value = swref }
                }
            };
        }

        static public BarsSql ClaimsRowData(decimal swref)
        {
            return new BarsSql()
            {
                SqlText = @"select chr(10)||listagg(lpad(TAG||OPT||': ',6)||replace(VALUE,chr(10),(chr(10)||'      ')),chr(10)) within group (ORDER BY N, TAG, SEQ) RESULT
                            FROM sw_operw
                            where swref = :p_swref",
                SqlParams = new object[] 
                {
                    new OracleParameter("p_swref", OracleDbType.Decimal) { Value = swref }
                }
            };
        }

        static public BarsSql SwiftClaims(string sFILTR, char io_ind = 'O')
        {
            return new BarsSql()
            {
                SqlText = string.Format(
                                @"select v.SWREF,v.MT,v.TRN,v.SENDER,v.SENDER_NAME,v.RECEIVER,v.RECEIVER_NAME,
                                    v.PAYER,v.PAYEE,v.CURRENCY,v.KV,v.DIG,(NVL(v.AMOUNT, 0)/100) AMOUNT,v.ACCD,v.ACCK,v.IO_IND,
                                    v.DATE_IN,v.DATE_OUT,v.DATE_REC,v.DATE_PAY,v.VDATE, NVL(v.ID, 0) as ID, v.FIO,v.TRANSIT,
                                    v.TAG20,
                                    (select AC.NLS from accounts ac where v.accd = ac.acc) nlsa,
                                    (select AC.NLS from accounts ac where v.acck = ac.acc) nlsb,
                                    v.IS_PDE
                                from v_sw_impmsg v
                                where {0}
                                v.io_ind = :io_ind
                                order by v.swref",
                                sFILTR
                            ),

                SqlParams = new object[] {
                    new OracleParameter("io_ind", OracleDbType.Char) { Value = io_ind }
                }
            };
        }

        public static BarsSql ListOperationsForProcessing(OperationsForProcessing obj)
        {
            string sql = obj.sUserF == 0 ? 
                            @"select t_.tt, t_.name
                                from bars.tts t_, bars.sw_tt_import w
                                where (t_.tt = w.tt and w.io_ind = :strioind)  
                                order by w.ord" :
                            @"select t_.tt, t_.name
                                from bars.tts t_, bars.staff_tts s, bars.sw_tt_import w
                                where (t_.tt = s.tt and s.id = user_id()) 
                                and (t_.tt = w.tt and w.io_ind = :strioind)  
                                order by w.ord";
            return new BarsSql()
            {
                SqlText = sql,
                SqlParams = new object[] {
                    new OracleParameter("strIoInd", OracleDbType.Char) { Value = obj.strIoInd }
                }
            };
        }

        public static BarsSql DocForKvit(string Ccy, DateTime? strVDocMin, DateTime? strVDocMax, long? AccD, long? AccKr, decimal? Amnt, string Tag20)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT REF, VDAT, NLSA, NLSB, (NVL(AMOUNT,0)/100) AMOUNT, LCV, DIG, DK, NAZN, TAG20, TT, NEXTVISAGRP 
                            FROM BARS.V_SW_IMPMSG_DOC
                            WHERE (lcv = :Ccy or :Ccy is null) 
                            AND (FDAT >= :strVDocMin and FDAT <= :strVDocMax)
                            AND (accd = :AccDb or :AccDb is null)
                            AND (acck = :AccKr or :AccKr is null)
                            AND ((s between :Amnt-100 and :Amnt+100) or :Amnt is null)
                            AND (tag20 = :Tag20 or :Tag20 is null)
                            ",
                SqlParams = new object[] {
                    new OracleParameter("Ccy", OracleDbType.Char) { Value = Ccy },
                    new OracleParameter("Ccy", OracleDbType.Char) { Value = Ccy },
                    new OracleParameter("strVDocMin", OracleDbType.Date) { Value = strVDocMin },
                    //new OracleParameter("strVDocMin", OracleDbType.Date) { Value = strVDocMin },
                    new OracleParameter("strVDocMax", OracleDbType.Date) { Value = strVDocMax },
                    //new OracleParameter("strVDocMax", OracleDbType.Date) { Value = strVDocMax },
                    new OracleParameter("AccDb", OracleDbType.Long) { Value = AccD },
                    new OracleParameter("AccDb", OracleDbType.Long) { Value = AccD },
                    new OracleParameter("AccKr", OracleDbType.Long) { Value = AccKr },
                    new OracleParameter("AccKr", OracleDbType.Long) { Value = AccKr },
                    new OracleParameter("Amnt", OracleDbType.Decimal) { Value = Amnt },
                    new OracleParameter("Amnt", OracleDbType.Decimal) { Value = Amnt },
                    new OracleParameter("Amnt", OracleDbType.Decimal) { Value = Amnt },
                    new OracleParameter("Tag20", OracleDbType.Varchar2) { Value = Tag20 },
                    new OracleParameter("Tag20", OracleDbType.Varchar2) { Value = Tag20 }
                }
            };
        }

        public static BarsSql DocForKvit(long value)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT REF, VDAT, NLSA, NLSB, (NVL(AMOUNT,0)/100) AMOUNT, LCV, DIG, DK, NAZN, TAG20, TT, NEXTVISAGRP 
                            FROM BARS.V_SW_IMPMSG_DOC_ALL
                            WHERE REF = :P_REF
                            ",
                SqlParams = new object[] {
                    new OracleParameter("P_REF", OracleDbType.Int64) { Value = value }
                }
            };
        }

        public static BarsSql DocForKvit(DateTime strVDocMin, DateTime strVDocMax)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT REF, VDAT, NLSA, NLSB, (NVL(AMOUNT,0)/100) AMOUNT, LCV, DIG, DK, NAZN, TAG20, TT, NEXTVISAGRP 
                            FROM BARS.V_SW_IMPMSG_DOC_ALL
                            WHERE FDAT >= :strVDocMin and FDAT <= :strVDocMax
                            ",
                SqlParams = new object[] {
                    new OracleParameter("strVDocMin", OracleDbType.Date) { Value = strVDocMin },
                    new OracleParameter("strVDocMax", OracleDbType.Date) { Value = strVDocMax }
                }
            };
        }

        public static BarsSql ImpmsgDocumentLink(ImpMsgDocumentLink obj)
        {
            // IsKvit2 - using procedure without dates limitation
            string proc = obj.IsKvit2 ? "impmsg_document_link_all" : "impmsg_document_link";

            return new BarsSql()
            {
                SqlText = string.Format(@"begin
                        bars_swift.{0}(p_docRef => :p_docRef, p_swRef => :p_swRef);
                    end;", proc),
                SqlParams = new object[]
                {
                    new OracleParameter("p_docRef", OracleDbType.Decimal) { Value = obj.REF },
                    new OracleParameter("p_swRef", OracleDbType.Decimal) { Value = obj.SWREF }
                }
            };
        }

        public static BarsSql ImpmsgDocumentGetparams(decimal p_swRef)
        {
            ImpmsgDocumentParams dataIDP = new ImpmsgDocumentParams();
            return new BarsSql()
            {
                SqlText = @"
                    begin
                        bars_swift.impmsg_document_getparams(
                          p_swRef        =>:p_swRef,
                          p_docMfoB      =>:p_docMfoB,
                          p_docCurCode   =>:p_docCurCode,
                          p_docAccNum    =>:p_docAccNum,
                          p_docRcvrId    =>:p_docRcvrId,
                          p_docRcvrName  =>:p_docRcvrName,
                          p_docAmount    =>:p_docAmount,
                          p_docValueDate =>:p_docValueDate
                        );
                    end;
                ",
                SqlParams = new object[]
                {
                    new OracleParameter("p_swRef",          OracleDbType.Decimal) { Value = p_swRef },
                    new OracleParameter("p_docMfoB",        OracleDbType.Varchar2, 4000,    dataIDP.p_docMfoB,          ParameterDirection.InputOutput),
                    new OracleParameter("p_docCurCode",     OracleDbType.Decimal,           dataIDP.p_docCurCode,       ParameterDirection.InputOutput),
                    new OracleParameter("p_docAccNum",      OracleDbType.Varchar2, 4000,    dataIDP.p_docAccNum,        ParameterDirection.InputOutput),
                    new OracleParameter("p_docRcvrId",      OracleDbType.Varchar2, 4000,    dataIDP.p_docRcvrId,        ParameterDirection.InputOutput),
                    new OracleParameter("p_docRcvrName",    OracleDbType.Varchar2, 4000,    dataIDP.p_docRcvrName,      ParameterDirection.InputOutput),
                    new OracleParameter("p_docAmount",      OracleDbType.Decimal,           dataIDP.p_docAmount,        ParameterDirection.InputOutput),
                    new OracleParameter("p_docValueDate",   OracleDbType.Date,              dataIDP.p_docValueDate,     ParameterDirection.InputOutput)
                }
            };
        }

        public static BarsSql PGetRcvr(decimal swref_)
        {
            P_GET_RCVR data = new P_GET_RCVR();
            return new BarsSql()
            {
                SqlText = @"
                    begin
                        bars.p_get_rcvr(
                          swref_    =>:swref_,
                          okpo_     =>:okpo_,
                          mfo_      =>:mfo_,
                          nls_      =>:nls_,
                          kv_       =>:kv_,
                          nazv_     =>:nazv_,
                          sum_      =>:sum_,
                          datv_     =>:datv_,
                          val_      =>:val_
                        );
                    end;
                ",
                SqlParams = new object[]
                {
                    new OracleParameter("swref_",   OracleDbType.Decimal) { Value = swref_ },
                    new OracleParameter("okpo_",    OracleDbType.Varchar2, 4000,    data.okpo_,    ParameterDirection.InputOutput),
                    new OracleParameter("mfo_",     OracleDbType.Varchar2, 4000,    data.mfo_,     ParameterDirection.InputOutput),
                    new OracleParameter("nls_",     OracleDbType.Varchar2, 4000,    data.nls_,     ParameterDirection.InputOutput),
                    new OracleParameter("kv_",      OracleDbType.Decimal,           data.kv_,      ParameterDirection.InputOutput),
                    new OracleParameter("nazv_",    OracleDbType.Varchar2, 4000,    data.nazv_,    ParameterDirection.InputOutput),
                    new OracleParameter("sum_",     OracleDbType.Decimal,           data.sum_,     ParameterDirection.InputOutput),
                    new OracleParameter("datv_",    OracleDbType.Date,              data.datv_,    ParameterDirection.InputOutput),
                    new OracleParameter("val_",     OracleDbType.Decimal,           data.val_,     ParameterDirection.InputOutput)
                }
            };
        }

        static public BarsSql PaymentData(string tt)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT t.name,t.flags,t.fli,t.flv,t.dk,t.sk,t.nlsa,t.nlsb,t.KV,t.KVK 
                            FROM tts t 
                            WHERE t.tt=:tt",
                SqlParams = new object[]
                {
                    new OracleParameter("tt", OracleDbType.Char) { Value = tt }
                }
            };
        }

        static public BarsSql CurrencyCode(string sLcv)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT kv,dig
                            FROM tabval 
                            WHERE lcv=:sLcv",
                SqlParams = new object[]
                {
                    new OracleParameter("sLcv", OracleDbType.Char) { Value = sLcv }
                }
            };
        }

        static public BarsSql BankName(decimal nSwRef)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT substr(bars_swift.get_name_bank(p_swref=>:nSwRef),1,150) sNameBank FROM dual",
                SqlParams = new object[]
                {
                    new OracleParameter("nSwRef", OracleDbType.Decimal) { Value = nSwRef }
                }
            };
        }

        public static BarsSql StmtDocumentLink(StmtDocumentLink obj)
        {
            return new BarsSql()
            {
                SqlText = string.Format(@"begin 
                                bars_swift.stmt_document_link(
                                    p_stmtref => :nSwRef, 
                                    {0}, 
                                    bars_swift.t_listref(m_nRef => :m_nRef), 
                                    0
                            ); 
                            end;", obj.sUserF != 0 ? @"user_id()" : "0"),
                SqlParams = new object[]
                {
                    new OracleParameter("nSwRef", OracleDbType.Decimal) { Value = obj.nSwRef },     
                    new OracleParameter("m_nRef", OracleDbType.Decimal) { Value = obj.m_nRef }      
                }
            };
        }

        public static BarsSql SwiftUsers(string io)
        {
            return new BarsSql()
            {
                SqlText = @"select distinct ID, FIO
                            from v_sw_staff
                            where io = :io
                            and io is not null
                            order by 1",
                SqlParams = new object[]
                {
                    new OracleParameter("io", OracleDbType.Char) { Value = io }
                }
            };
        }

        public static BarsSql ImpmsgMessageDelete(decimal swref)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                bars_swift.impmsg_message_delete(:p_swref);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_swref", OracleDbType.Decimal) { Value = swref }
                }
            };
        }

        static public BarsSql ClaimsRowDataObject(decimal swref)
        {
            return new BarsSql()
            {
                SqlText = @"select tag,opt,value
                            FROM sw_operw
                            where swref = :p_swref order by n",
                SqlParams = new object[]
                {
                    new OracleParameter("p_swref", OracleDbType.Decimal) { Value = swref }
                }
            };
        }

        public static BarsSql SwiftToStr(string Value_, string Charset_)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT SWIFT.SWIFTTOSTR(:Value_, :Charset_) FROM DUAL",      // return Varchar2 !!!!!!
                SqlParams = new object[]
                {
                    new OracleParameter("Value_", OracleDbType.Varchar2) { Value = Value_ },
                    new OracleParameter("Charset_", OracleDbType.Varchar2) { Value = Charset_ }
                }
            };
        }

        public static BarsSql TransactionType(decimal swref, byte sUserF)
        {
            return new BarsSql()
            {
                SqlText = string.Format(@"SELECT t.TTNAME 
                            from SW_TT t, sw_950d d 
                            WHERE t.SWTT = d.swtt 
                            and d.swref = :swref
                            and n = {0}", sUserF != 0 ? @"user_id()" : "0"),
                SqlParams = new object[] 
                {
                    new OracleParameter("swref", OracleDbType.Decimal) { Value = swref }
                }
            };
        }

        public static BarsSql Bankdate()
        {
            return new BarsSql()
            {
                SqlText = @"select bankdate() from dual",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql NlsFromV_CORR_ACC(string BIC, string LCV)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT T.NLS
                                FROM V_CORR_ACC t
                                WHERE T.BIC LIKE UPPER(:P_BIC) || '%'
                                AND T.LCV = :P_LCV",
                SqlParams = new object[]
                {
                    new OracleParameter("P_BIC", OracleDbType.Char) { Value = BIC },
                    new OracleParameter("P_LCV", OracleDbType.Char) { Value = LCV }
                }
            };
        }

        public static BarsSql NextVisa(decimal swref)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT nextvisagrp as sNextVisa, tt as sTt FROM oper WHERE ref=:nRef",
                SqlParams = new object[]
                {
                    new OracleParameter("nRef", OracleDbType.Decimal) { Value = swref }
                }
            };
        }

        public static BarsSql Sos(decimal swref)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT sos FROM oper WHERE ref=:nRef",
                SqlParams = new object[]
                {
                    new OracleParameter("nRef", OracleDbType.Decimal) { Value = swref }
                }
            };
        }

        public static BarsSql TtsFlags(string sTt)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT flags FROM tts WHERE tt=:sTt",
                SqlParams = new object[]
                {
                    new OracleParameter("sTt", OracleDbType.Char) { Value = sTt }
                }
            };
        }

        public static BarsSql Pay(decimal p_ref)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                gl.PAY(2, :p_ref, bankdate());
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_ref", OracleDbType.Decimal) { Value = p_ref }
                }
            };
        }

        public static BarsSql GetSignInfo()
        {
            return new BarsSql()
            {
                SqlText = @"select docsign.get_user_keyid user_keyid, docsign.get_user_sign_type sign_type from dual",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql PutNos(decimal p_ref, decimal nGrp)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                CHK.PUT_NOS(:p_ref, :nGrp);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_ref", OracleDbType.Decimal) { Value = p_ref },
                    new OracleParameter("nGrp", OracleDbType.Decimal) { Value = nGrp }
                }
            };
        }

        public static BarsSql OperVisa(decimal nRef, decimal nGrp, short nTmp, byte[] m_lsSign, bool visaSign, string strKeyId)
        {
            List<object> paramsList = new List<object>()
            {
                new OracleParameter("nRef", OracleDbType.Decimal) { Value = nRef },
                new OracleParameter("nGrp", OracleDbType.Decimal) { Value = nGrp },
                new OracleParameter("nTmp", OracleDbType.Int16) { Value = nTmp }
            };
            if (visaSign)
            {
                paramsList.Add(new OracleParameter("strKeyId", OracleDbType.Varchar2) { Value = strKeyId });
                paramsList.Add(new OracleParameter("m_lsSign", OracleDbType.Raw) { Value = m_lsSign });
            }

            return new BarsSql()
            {
                SqlText = string.Format(@"INSERT INTO oper_visa(ref, dat, userid, groupid, status{0}) 
                            VALUES(:nRef, bankdate(), user_id(), :nGrp, :nTmp{1})", 
                            visaSign ? ", keyid, sign" : "",
                            visaSign ? ",:strKeyId,:m_lsSign" : ""),
                SqlParams = paramsList.ToArray()
            };
        }

        public static BarsSql GetIdOper()
        {
            return new BarsSql()
            {
                SqlText = @"SELECT docsign.getIdOper() FROM dual",
                SqlParams = new object[] { }
            };
        }
    }
}
