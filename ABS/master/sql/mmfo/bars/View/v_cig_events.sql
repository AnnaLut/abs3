

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_EVENTS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIG_EVENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIG_EVENTS ("EVT_ID", "EVT_DATE", "EVT_UNAME", "USER_NAME", "EVT_STATE_ID", "GROUP_ID", "GROUP_NAME", "STATE_NAME", "EVT_MESSAGE", "EVT_ORAERR", "EVT_ND", "EVT_RNK", "EVT_DTYPE", "EVT_CUSTTYPE", "BRANCH", "BRANCH_DOG") AS 
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
                  1, 'Стандартні кредити',
                  2, 'Кредині лінії',
                  3, 'БПК',
                  4, 'Овердрафт',
                  5, 'Гарантія',
                  6, 'МБК',
                  7, 'МБК',
                  NULL)
             evt_dtype,
          DECODE (ce.evt_custtype,
                  1, 'Банки',
                  3, DECODE (cgi.classification, 2, 'ФОП', 'ФО'),
                  2, 'ЮО',
                  ce.evt_custtype)
             evt_custtype,
          ce.branch,
          (CASE
              WHEN CE.EVT_DTYPE IN (1, 5, 6, 7) AND CE.EVT_ND IS NOT NULL
              THEN
                 (SELECT d.branch
                    FROM cc_deal d
                   WHERE d.nd = CE.EVT_ND)
              WHEN CE.EVT_DTYPE IN (1, 5, 6, 7) AND CE.EVT_ND IS NULL
              THEN
                 (SELECT MIN (d.branch)
                    FROM cc_deal d
                   WHERE d.rnk = CE.EVT_RNK)
              WHEN CE.EVT_DTYPE = 3 AND CE.EVT_ND IS NOT NULL
              THEN
                 (SELECT MIN (a.branch)
                    FROM w4_acc w, accounts a
                   WHERE w.nd = CE.EVT_ND AND W.ACC_PK = a.acc)
              WHEN CE.EVT_DTYPE = 3 AND CE.EVT_ND IS NULL
              THEN
                 (SELECT MIN (a.branch)
                    FROM accounts a
                   WHERE     a.rnk = CE.EVT_RNK
                         AND a.nbs LIKE '9129%'
                         AND a.dazs IS NULL)
              WHEN CE.EVT_DTYPE = 4 AND CE.EVT_ND IS NOT NULL
              THEN
                 (SELECT MIN (a.branch)
                    FROM acc_over d, accounts a
                   WHERE d.nd = CE.EVT_ND AND d.acc = a.acc)
           END)
             branch_dog
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
          AND cgc.branch = cgi.branch(+)
          and ce.branch = SYS_CONTEXT ('bars_context', 'user_branch');

PROMPT *** Create  grants  V_CIG_EVENTS ***
grant SELECT                                                                 on V_CIG_EVENTS    to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIG_EVENTS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIG_EVENTS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_EVENTS.sql =========*** End *** =
PROMPT ===================================================================================== 
