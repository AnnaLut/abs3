

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_CM_ERR_TRANS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CM_ERR_TRANS ***

  CREATE OR REPLACE FORCE VIEW PFU.V_CM_ERR_TRANS ("KF", "NAME", "ID", "UPD_DATE") AS 
  select t.kf,
       t.name,
       (select nvl(tu0.id, 0)  from transport_unit tu0 where tu0.id = tu2.id and tu0.state_id = 5) id,
       (select max(tt0.sys_time)  from transport_tracking tt0 where tt0.unit_id = tu2.id) upd_date
    from pfu_syncru_params t
    left join (select tu.receiver_url, max(tu.id) id
                 from transport_unit tu
                where tu.unit_type_id = 8
                --  and tu.state_id = 5
                group by tu.receiver_url) tu2 on (tu2.receiver_url = t.sync_service_url)
   -- left join transport_tracking tt on (tu2.id = tt.unit_id and tt.state_id = 5)
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_CM_ERR_TRANS.sql =========*** End *** 
PROMPT ===================================================================================== 
