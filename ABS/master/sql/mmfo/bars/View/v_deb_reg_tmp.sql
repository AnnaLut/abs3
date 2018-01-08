

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DEB_REG_TMP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DEB_REG_TMP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DEB_REG_TMP ("EVENTTYPE", "CCOLOR", "ACC", "CRNLS", "OKPO", "NMK", "ADR", "CUSTTYPE", "PRINSIDER", "KV", "CRDAGRNUM", "CRDDATE", "SUM", "DEBDATE", "DAY", "REZID", "SUM_FLOAT", "SUM_STR", "SUMD", "OSN", "EVENTDATE", "DENOM") AS 
  SELECT deb_reg_tmp.EVENTTYPE,
          deb_reg_tmp.CCOLOR,
          deb_reg_tmp.acc,
          deb_reg_tmp.nls CRNLS,
          deb_reg_tmp.OKPO,
          deb_reg_tmp.NMK,
          deb_reg_tmp.ADR,
          deb_reg_tmp.CUSTTYPE,
          deb_reg_tmp.PRINSIDER,
          deb_reg_tmp.KV,
          deb_reg_tmp.CRDAGRNUM,
          deb_reg_tmp.CRDDATE CRDDATE,
          deb_reg_tmp.SUM,
          deb_reg_tmp.DEBDATE,
          deb_reg_tmp.DAY,
          deb_reg_tmp.rezid,
          deb_reg_tmp.SUM / tabval.denom SUM_FLOAT,
          TO_CHAR (
             deb_reg_tmp.SUM / tabval.denom,
             'FM999G999G999G999G999G999D' || RPAD ('0', tabval.dig, '0'),
             'NLS_NUMERIC_CHARACTERS = ''. ''')
             SUM_STR,
          deb_reg_tmp.SUMD / 100 SUMD,
          deb_reg_tmp.osn,
          deb_reg_tmp.eventdate,
          tabval.denom
     FROM deb_reg_tmp, tabval
    WHERE deb_reg_tmp.kv = tabval.kv;

PROMPT *** Create  grants  V_DEB_REG_TMP ***
grant SELECT                                                                 on V_DEB_REG_TMP   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DEB_REG_TMP   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DEB_REG_TMP   to DEB_REG;
grant SELECT                                                                 on V_DEB_REG_TMP   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DEB_REG_TMP.sql =========*** End *** 
PROMPT ===================================================================================== 
