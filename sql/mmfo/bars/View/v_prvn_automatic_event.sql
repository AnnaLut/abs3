

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PRVN_AUTOMATIC_EVENT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PRVN_AUTOMATIC_EVENT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PRVN_AUTOMATIC_EVENT ("ID", "REF_AGR", "RNK", "REPORTING_DATE", "EVENT_DATE", "RESTR_END_DAT", "ZO", "EVENT_TYPE", "EVENT_NAME", "OBJECT_TYPE", "OBJECT_NAME", "PRD_TP", "NMK", "CUSTTYPE") AS 
  select pa.id, pa.ref_agr ,  pa.rnk, pa.reporting_date         ,  pa.event_date,      pa.restr_end_dat, pa.ZO,
       pa.event_type     ,  substr(pe.name,1,100)  event_name ,
       pa.object_type    ,  substr(ot.name,1,100) object_name ,  ot.PRD_TP ,
       c.nmk, c.custtype
  from prvn_automatic_event pa,
       prvn_event_type      pe,
       prvn_object_type     ot,
       customer             C
 where pa.event_type  =  pe.id
   and pa.object_type =  ot.id
   and pa.rnk = c.rnk ;

PROMPT *** Create  grants  V_PRVN_AUTOMATIC_EVENT ***
grant SELECT                                                                 on V_PRVN_AUTOMATIC_EVENT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PRVN_AUTOMATIC_EVENT to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PRVN_AUTOMATIC_EVENT.sql =========***
PROMPT ===================================================================================== 
