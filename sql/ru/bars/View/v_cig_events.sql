

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_EVENTS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIG_EVENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIG_EVENTS ("EVT_ID", "EVT_DATE", "USER_ID", "USER_NAME", "EVT_STATE_ID", "GROUP_ID", "GROUP_NAME", "STATE_NAME", "EVT_MESSAGE", "EVT_ORAERR", "EVT_ND", "EVT_RNK", "EVT_DTYPE", "EVT_CUSTTYPE", "BRANCH", "BRANCH_DOG") AS 
  SELECT ce.evt_id,
          ce.evt_date,
          ce.evt_uname AS user_id,
          s.logname AS user_name,
          ce.evt_state_id,
          g.GROUP_ID,
          g.group_name,
          cs.state_name,
          ce.evt_message,
          ce.evt_oraerr,
          ce.evt_nd,
          ce.evt_rnk,
          DECODE (ce.evt_dtype,
                  3, '¡œ ',
                  4, 'Œ‚Â‰‡ÙÚ',
                  5, '√‡‡ÌÚ≥ˇ',
                  6, 'Ã¡ ',
                  7, 'Ã¡ ',
                  NULL)
             evt_dtype,
          DECODE (ce.evt_custtype,
                  3, DECODE (cgi.classification, 2, '‘Œœ', '‘Œ'),
                  2, 'ﬁŒ',
                  ce.evt_custtype)
             evt_custtype,
          ce.branch,
           (case when CE.EVT_DTYPE in (1, 5, 6, 7) and CE.EVT_ND is not null  then (select d.branch from cc_deal d where d.nd=CE.EVT_ND)
                    when CE.EVT_DTYPE in (1, 5, 6, 7) and CE.EVT_ND is  null       then   (select min(d.branch) from cc_deal d where d.rnk=CE.EVT_RNK)
                    when CE.EVT_DTYPE=3 and CE.EVT_ND is  not null  then   (select min(a.branch) from w4_acc w, accounts a where w.nd=CE.EVT_ND and W.ACC_PK=a.acc)
                    when CE.EVT_DTYPE=3 and CE.EVT_ND is   null  then   (select min(a.branch) from  accounts a where  a.rnk=CE.EVT_RNK and a.nbs like '9129%' and a.dazs is null)
                    when CE.EVT_DTYPE=4 and CE.EVT_ND is  not null  then   (select min(a.branch) from  acc_over d, accounts a where  d.nd=CE.EVT_ND  and d.acc=a.acc)
                    end
           ) branch_dog
     FROM cig_events ce,
          cig_states cs,
          cig_state_groups g,
          staff$base s,
          cig_customers cgc,
          cig_cust_individual cgi
    WHERE     ce.evt_uname = s.id
          AND ce.evt_state_id = cs.state_id
          AND cs.GROUP_ID = g.GROUP_ID
          AND cgc.rnk(+) = ce.evt_rnk
          AND cgc.cust_id = cgi.cust_id(+)
          AND cgc.branch = cgi.branch(+);

PROMPT *** Create  grants  V_CIG_EVENTS ***
grant SELECT                                                                 on V_CIG_EVENTS    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_EVENTS.sql =========*** End *** =
PROMPT ===================================================================================== 
