

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_GRT_EVENTS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GRT_EVENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_GRT_EVENTS ("ID", "DEAL_ID", "TYPE_ID", "EVENT_NAME", "EVENT_DESCR", "PLANNED_DATE", "ACTUAL_DATE", "COMMENT_TEXT") AS 
  select
 e.id, e.deal_id, e.type_id, et.event_name, et.event_descr,
 e.planned_date, e.actual_date, e.comment_text
from grt_events e, grt_event_types et
where e.type_id = et.event_id;

PROMPT *** Create  grants  V_GRT_EVENTS ***
grant SELECT                                                                 on V_GRT_EVENTS    to BARSREADER_ROLE;
grant SELECT                                                                 on V_GRT_EVENTS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_GRT_EVENTS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_GRT_EVENTS.sql =========*** End *** =
PROMPT ===================================================================================== 
