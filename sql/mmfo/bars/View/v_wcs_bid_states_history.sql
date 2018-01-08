

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_STATES_HISTORY.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_STATES_HISTORY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_STATES_HISTORY ("ID", "BID_ID", "STATE_ID", "STATE_NAME", "IS_DISP", "CHECKOUTED", "CHECKOUT_DAT", "CHECKOUT_USER_ID", "CHECKOUT_USER_F", "USER_COMMENT", "CHANGE_ACTION", "CHANGE_ACTION_NAME", "CHANGE_DAT") AS 
  select bsh.id,
       bsh.bid_id,
       bsh.state_id,
       s.name as state_name,
       s.is_disp,
       bsh.checkouted,
       bsh.checkout_dat,
       bsh.checkout_user_id,
       fio(sb.fio, 1) as checkout_user_f,
       bsh.user_comment,
       bsh.change_action,
       sha.name as change_action_name,
       bsh.change_dat
  from wcs_bid_states_history   bsh,
       wcs_state_history_action sha,
       wcs_states               s,
       staff$base               sb
 where bsh.change_action <> 'SET_IMMEDIATE'
   and (bsh.user_comment is not null or
       bsh.change_action in ('CHECK_OUT', 'CHECK_IN'))
   and bsh.change_action = sha.id
   and bsh.state_id = s.id
   and bsh.checkout_user_id = sb.id(+)
 order by bsh.bid_id desc, bsh.id desc;

PROMPT *** Create  grants  V_WCS_BID_STATES_HISTORY ***
grant SELECT                                                                 on V_WCS_BID_STATES_HISTORY to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_STATES_HISTORY.sql =========*
PROMPT ===================================================================================== 
