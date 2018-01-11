

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SV_BANK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SV_BANK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SV_BANK ("ID", "MAN_FIO_NM1", "MAN_FIO_NM2", "MAN_FIO_NM3", "MAN_MB_POS", "MAN_MB_DT", "ISP_FIO_NM1", "ISP_FIO_NM2", "ISP_FIO_NM3", "ISP_MB_TLF") AS 
  select id,
       man_fio_nm1,
       man_fio_nm2,
       man_fio_nm3,
       man_mb_pos,
       man_mb_dt,
       isp_fio_nm1,
       isp_fio_nm2,
       isp_fio_nm3,
       isp_mb_tlf
from SV_BANK;

PROMPT *** Create  grants  V_SV_BANK ***
grant SELECT                                                                 on V_SV_BANK       to BARSREADER_ROLE;
grant SELECT                                                                 on V_SV_BANK       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SV_BANK       to RPBN002;
grant SELECT                                                                 on V_SV_BANK       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SV_BANK.sql =========*** End *** ====
PROMPT ===================================================================================== 
