

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_net_toss_log =========*** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE FORCE VIEW BARS.v_net_toss_log  as 
select * from  net_toss_log where rec_date > sysdate - 1/24 order by rec_id desc;

grant SELECT                                                                 on v_net_toss_log      to BARSREADER_ROLE;
grant SELECT                                                                 on v_net_toss_log      to BARS_ACCESS_DEFROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_net_toss_log  =========*** End *** ===
PROMPT ===================================================================================== 
