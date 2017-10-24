

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW320_HEADER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW320_HEADER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW320_HEADER ("SWREF", "MT", "IO_IND", "TRN", "SENDER", "RECEIVER", "VDATE", "DATE_IN") AS 
  select j.swref, j.mt, j.io_ind, j.trn, j.sender, j.receiver, j.vdate, j.date_in
  from sw_journal j,
       (select io_ind, swref
          from sw_journal
         where mt = 320
        minus
        select io_ind, swref
          from (select 'O' io_ind, swi_ref swref
                  from cc_add
                 where swi_ref is not null
                union all
                select 'I' io_ind, swo_ref swref
                  from cc_add
                 where swo_ref is not null) ) q
 where j.mt = '320'
   and j.swref = q.swref
   and j.vdate between bankdate_g-7 and bankdate_g +7
 ;

PROMPT *** Create  grants  V_SW320_HEADER ***
grant SELECT                                                                 on V_SW320_HEADER  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SW320_HEADER  to FOREX;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SW320_HEADER  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW320_HEADER.sql =========*** End ***
PROMPT ===================================================================================== 
