PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VMD.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** Create  view VMD ***

  CREATE OR REPLACE FORCE VIEW BARS.VMD
(
   DAT,
   FN,
   N,
   CDAT,
   ISNULL,
   NDAT,
   MDAT,
   CTYPE,
   CNUM_CST,
   CNUM_YEAR,
   CNUM_NUM,
   MVM_FEAT,
   S_OKPO,
   S_NAME,
   S_ADRES,
   S_TYPE,
   S_TAXID,
   R_OKPO,
   R_NAME,
   R_ADRES,
   R_TYPE,
   R_TAXID,
   F_OKPO,
   F_NAME,
   F_ADRES,
   F_TYPE,
   F_TAXID,
   F_COUNTRY,
   UAH_NLS,
   UAH_MFO,
   CCY_NLS,
   CCY_MFO,
   KV,
   KURS,
   S,
   ALLOW_DAT,
   CMODE_CODE,
   DOC,
   BEG_DATE,
   END_DATE,
   CHARACTER,
   UAH_MFO_NEW,
   CCY_MFO_NEW,
   FN_MM,
   MDAT_NEW,
   CIM_ID 
 )
AS
   SELECT dat,
          fn,
          n,
          cdat,
          isnull,
          ndat,
          mdat,
          ctype,
          cnum_cst,
          cnum_year,
          cnum_num,
          mvm_feat,
          s_okpo,
          s_name,
          s_adres,
          s_type,
          s_taxid,
          r_okpo,
          r_name,
          r_adres,
          r_type,
          r_taxid,
          f_okpo,
          f_name,
          f_adres,
          f_type,
          f_taxid,
          f_country,
          uah_nls,
          uah_mfo,
          ccy_nls,
          ccy_mfo,
          kv,
          kurs,
          s,
          allow_dat,
          cmode_code,
          doc,
          sdate,
          fdate,
          character,
          UAH_MFO_NEW,
          CCY_MFO_NEW,
          FN_MM,
          MDAT_NEW,
          CIM_ID
     FROM customs_decl;
	 
PROMPT *** Create  grants  VMD ***
grant SELECT                                                                 on VMD             to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VMD             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VMD             to RPBN001;
grant SELECT                                                                 on VMD             to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on VMD             to VMD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VMD             to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on VMD             to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VMD.sql =========*** End *** ==========
PROMPT ===================================================================================== 
