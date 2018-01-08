

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DEB_REG_MAN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DEB_REG_MAN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DEB_REG_MAN ("EVENTTYPE", "ACC", "OKPO", "NMK", "ADR", "CUSTTYPE", "PRINSIDER", "KV", "CRDAGRNUM", "CRDDATE", "SUM", "DEBDATE", "DAY", "REZID", "SUMD", "OSN", "EVENTDATE") AS 
  select eventtype,
            acc,
            okpo,
            nmk,
            adr,
            custtype,
            prinsider,
            kv,
            crdagrnum,
            crddate,
            sum,
            debdate,
            day,
            rezid,
            sum / 100 sumd,
            osn,
            eventdate
       from deb_reg_man
   order by custtype, okpo;

PROMPT *** Create  grants  V_DEB_REG_MAN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DEB_REG_MAN   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DEB_REG_MAN   to DEB_REG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DEB_REG_MAN.sql =========*** End *** 
PROMPT ===================================================================================== 
