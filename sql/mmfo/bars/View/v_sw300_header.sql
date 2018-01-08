

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW300_HEADER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW300_HEADER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW300_HEADER ("SWREF", "MT", "IO_IND", "TRN", "SENDER", "RECEIVER", "VDATE", "DATE_IN") AS 
  select j.swref, j.mt, j.io_ind, j.trn, j.sender, j.receiver, j.vdate, j.date_in
  from sw_journal j,
       (select io_ind, swref
          from sw_journal
         where mt = 300
        minus
        select io_ind, swref
          from (select 'O' io_ind, swi_ref swref
                  from fx_deal
                 where swi_ref is not null
                union all
                select 'I' io_ind, swo_ref swref
                  from fx_deal
                 where swo_ref is not null) ) q
 where j.mt = '300'
   and j.swref = q.swref
   and j.vdate between bankdate_g-7 and bankdate_g +7;

PROMPT *** Create  grants  V_SW300_HEADER ***
grant SELECT                                                                 on V_SW300_HEADER  to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SW300_HEADER  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SW300_HEADER  to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_SW300_HEADER  to SWIFT001;
grant SELECT                                                                 on V_SW300_HEADER  to UPLD;
grant FLASHBACK,SELECT                                                       on V_SW300_HEADER  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW300_HEADER.sql =========*** End ***
PROMPT ===================================================================================== 
