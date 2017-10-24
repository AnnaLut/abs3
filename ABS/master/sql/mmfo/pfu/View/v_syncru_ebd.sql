

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_SYNCRU_EBD.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SYNCRU_EBD ***

  CREATE OR REPLACE FORCE VIEW PFU.V_SYNCRU_EBD ("KF", "NAME", "CURDATE", "CURSTATE", "LASTDATE") AS 
  select p.kf,
       p.name,
       (select min(tt.sys_time) keep(dense_rank last order by tt.id)
          from transport_tracking tt
         where tt.unit_id = t.minall) curdate,
       nvl(t.stat,0) curstate,
       (select min(tt.sys_time) keep(dense_rank last order by tt.id)
          from transport_tracking tt
         where tt.unit_id = t.mindone) lastdate
  from pfu_syncru_params p,
       (select u.receiver_url,
               min(u.id) keep(dense_rank last order by u.id) minall,
               min(case
                     when u.state_id = 6 then
                      u.id
                     else
                      null
                   end) keep(dense_rank last order by u.id) mindone,
               min(u.state_id) keep(dense_rank last order by u.id) stat
          from transport_unit u, pfu_syncru_params p
         where p.sync_service_url = u.receiver_url
           and u.unit_type_id = 5
         group by u.receiver_url) t
 where p.sync_service_url = t.receiver_url(+);



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_SYNCRU_EBD.sql =========*** End *** ==
PROMPT ===================================================================================== 
