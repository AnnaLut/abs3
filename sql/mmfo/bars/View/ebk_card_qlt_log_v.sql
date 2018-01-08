

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/EBK_CARD_QLT_LOG_V.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view EBK_CARD_QLT_LOG_V ***

  CREATE OR REPLACE FORCE VIEW BARS.EBK_CARD_QLT_LOG_V ("RNK", "USER_ID", "USER_NAME", "DATE_UPDATED") AS 
  select l.rnk,
l.user_id,
(select fio from staff$base where id = l.user_id) as user_name,
l.date_updated
from ebk_card_qlt_log l;

PROMPT *** Create  grants  EBK_CARD_QLT_LOG_V ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBK_CARD_QLT_LOG_V to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/EBK_CARD_QLT_LOG_V.sql =========*** End
PROMPT ===================================================================================== 
