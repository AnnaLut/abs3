

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMS_DECL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMS_DECL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMS_DECL ("FN", "DAT", "N", "LEN", "CDAT", "ISNULL", "NDAT", "MDAT", "CTYPE", "CNUM_CST", "CNUM_YEAR", "CNUM_NUM", "MVM_FEAT", "S_OKPO", "S_NAME", "S_ADRES", "S_TYPE", "S_TAXID", "R_OKPO", "R_NAME", "R_ADRES", "R_TYPE", "R_TAXID", "F_OKPO", "F_NAME", "F_ADRES", "F_TYPE", "F_TAXID", "F_COUNTRY", "UAH_NLS", "UAH_MFO", "CCY_NLS", "CCY_MFO", "KV", "KURS", "S", "NOM", "ALLOW_DAT", "CMODE_CODE", "RESERV", "DOC", "SDATE", "FDATE", "SIGN_KEY", "SIGN", "CHARACTER", "RESERVE2", "FL_EIK", "IDT", "DATJ", "KF") AS 
  SELECT fn,
          dat,
          n,
          len,
          cdat,
          isnull,
          ndat,
          mdat,
          translatedos2win (ctype) ctype,
          cnum_cst,
          cnum_year,
          cnum_num,
          mvm_feat,
          s_okpo,
          translatedos2win (s_name) s_name,
          translatedos2win (s_adres) s_adres,
          s_type,
          s_taxid,
          r_okpo,
          translatedos2win (r_name) r_name,
          translatedos2win (r_adres) r_adres,
          r_type,
          r_taxid,
          f_okpo,
          translatedos2win (f_name) f_name,
          translatedos2win (f_adres) f_adres,
          f_type,
          f_taxid,
          f_country,
          UAH_NLS,
          uah_mfo,
          ccy_nls,
          ccy_mfo,
          kv,
          kurs,
          s,
          --   ROUND(((S/100)/(KURS/100000000)),2) NOM,
          gl.p_ncurval (kv, s, TRUNC (ALLOW_dat)) / 100 nom,
          allow_dat,
          cmode_code,
          reserv,
          doc,
          sdate,
          fdate,
          sign_key,
          SIGN,
          character,
          reserve2,
          fl_eik,
          idt,
          datj,
          kf
     FROM CUSTOMS_DECL;

PROMPT *** Create  grants  V_CUSTOMS_DECL ***
grant FLASHBACK,SELECT                                                       on V_CUSTOMS_DECL  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMS_DECL  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMS_DECL.sql =========*** End ***
PROMPT ===================================================================================== 
