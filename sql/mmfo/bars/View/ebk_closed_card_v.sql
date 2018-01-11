

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/EBK_CLOSED_CARD_V.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view EBK_CLOSED_CARD_V ***

  CREATE OR REPLACE FORCE VIEW BARS.EBK_CLOSED_CARD_V ("KF", "RNK", "CUSTTYPE", "CHGDATE", "DATE_OFF") AS 
  select b.KF
     , cu.RNK
     , CASE
         WHEN (cu.custtype = 2) THEN 'corp'
         WHEN (cu.custtype = 3 AND cu.K050 = '910') THEN 'personspd'
         ELSE 'person'
       END
     , cu.CHGDATE
     , cu.DATE_OFF
  from CUSTOMER_UPDATE cu,
       ( SELECT VAL AS KF
           FROM BARS.PARAMS$GLOBAL
          WHERE PAR = 'GLB-MFO'
       ) b
 where cu.CUSTTYPE IN ( 2, 3 )
   and cu.CHGACTION = 3
   and cu.DATE_OFF IS NOT NULL
   and cu.CHGDATE > coalesce( ( SELECT CAST(actual_start_date AS DATE) -- дата последней выгрузки закрытых карточек ФЛ
                                  FROM ( SELECT actual_start_date
                                           FROM all_scheduler_job_run_details
                                          WHERE job_name = 'EBK_CLOSED_CARD_JOB'
                                            AND status = 'SUCCEEDED'
                                          ORDER BY log_id DESC )
                                 WHERE ROWNUM = 1 )
                            , ( SELECT CAST(actual_start_date AS DATE) -- дата 1-ой пакетной выгрузки открытых карточек ФЛ
                                  FROM ( SELECT actual_start_date
                                           FROM all_scheduler_job_run_details
                                          WHERE job_name = 'EBK_CARD_PACAKGES_JOB'
                                            AND status = 'SUCCEEDED'
                                          ORDER BY log_id ASC )
                                 WHERE ROWNUM = 1 )
                            );

PROMPT *** Create  grants  EBK_CLOSED_CARD_V ***
grant SELECT                                                                 on EBK_CLOSED_CARD_V to BARSREADER_ROLE;
grant SELECT                                                                 on EBK_CLOSED_CARD_V to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBK_CLOSED_CARD_V to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/EBK_CLOSED_CARD_V.sql =========*** End 
PROMPT ===================================================================================== 
