

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_STATES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_STATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_STATES ("BID_ID", "STATE_ID", "STATE_NAME", "IS_DISP", "CHECKOUTED", "CHECKOUT_DAT", "CHECKOUT_USER_ID", "CHECKOUT_USER_F", "USER_COMMENT") AS 
  select bs.bid_id,
       bs.state_id,
       s.name as state_name,
       s.is_disp,
       bs.checkouted,
       bs.checkout_dat,
       bs.checkout_user_id,
       fio(sb.fio, 1) as checkout_user_f,
       bs.user_comment
  from wcs_bid_states bs, wcs_states s, staff$base sb
 where bs.state_id = s.id
   and bs.checkout_user_id = sb.id(+)
 order by bs.checkout_dat desc nulls last;

PROMPT *** Create  grants  V_WCS_BID_STATES ***
grant SELECT                                                                 on V_WCS_BID_STATES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_STATES.sql =========*** End *
PROMPT ===================================================================================== 
