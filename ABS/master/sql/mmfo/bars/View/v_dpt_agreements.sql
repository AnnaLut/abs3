

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_AGREEMENTS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_AGREEMENTS ***

CREATE OR REPLACE FORCE VIEW BARS.V_DPT_AGREEMENTS
(
   AGRMNT_ID,
   AGRMNT_DATE,
   AGRMNT_NUM,
   AGRMNT_TYPE,
   AGRMNT_TYPENAME,
   DPT_ID,
   BRANCH,
   OWNER_ID,
   BANKDATE,
   TEMPLATE_ID,
   TRUST_ID,
   TRUSTEE_ID,
   TRUSTEE_NAME,
   AGRMNT_STATE,
   FL_ACTIVITY,
   COMMENTS,
   WB
)
AS
   SELECT                                /* все доп.соглашения о 3-их лицах */
         x.agrmnt_id,
          x.agrmnt_date,
          x.agrmnt_num,
          x.agrmnt_type,
          f.name,
          x.dpt_id,
          x.branch,
          x.cust_id,
          x.bankdate,
          x.template_id,
          x.trustee_id,
          x.rnk_tr,
          c.nmk,
          x.agrmnt_state,
          (CASE
              WHEN x.agrmnt_term_state IN (8, 9) THEN 0
              ELSE x.agrmnt_state
           END),
             (CASE
                 WHEN x.agrmnt_state = 1 THEN 'активна'
                 WHEN x.agrmnt_state = 0 THEN 'закрита' || x.undocomm
                 ELSE 'сторнована'
              END)
          || (CASE
                 WHEN x.dates IS NOT NULL
                 THEN
                       ', термін дії'
                    || x.dates
                    || (CASE
                           WHEN x.agrmnt_term_state = 8
                           THEN
                              ' - ще не настав'
                           WHEN x.agrmnt_term_state = 9
                           THEN
                              ' - вже минув'
                           ELSE
                              ' - триває'
                        END)
              END),
            (select wb from dpt_deposit where deposit_id = x.dpt_id) wb  
     FROM dpt_vidd_flags f,
          customer c,
          (SELECT da.agrmnt_id,
                  da.agrmnt_date,
                  da.agrmnt_num,
                  da.agrmnt_type,
                  da.dpt_id,
                  da.branch,
                  da.cust_id,
                  da.bankdate,
                  da.template_id,
                  da.trustee_id,
                  t.rnk_tr,
                  da.agrmnt_state,
                  (CASE
                      WHEN u.add_num IS NOT NULL
                      THEN
                            ', анульована дод. угодою №'
                         || u.add_num
                   END)
                     undocomm,
                  (CASE
                      WHEN da.agrmnt_type = 12
                      THEN
                            NVL2 (da.date_begin, ' з ', NULL)
                         || TO_CHAR (da.date_begin, 'dd.mm.yyyy')
                         || NVL2 (da.date_end, ' по ', NULL)
                         || TO_CHAR (da.date_end, 'dd.mm.yyyy')
                      ELSE
                         NULL
                   END)
                     dates,
                  (CASE
                      WHEN     da.agrmnt_type = 12
                           AND da.date_begin > TRUNC (SYSDATE)
                      THEN
                         8
                      WHEN     da.agrmnt_type = 12
                           AND da.date_end < TRUNC (SYSDATE)
                      THEN
                         9
                      ELSE
                         da.agrmnt_state
                   END)
                     agrmnt_term_state
             FROM dpt_agreements da, dpt_trustee t, dpt_trustee u
            WHERE     da.trustee_id = t.id
                  AND t.id = u.undo_id(+)
                  AND da.agrmnt_type != 7) x
    WHERE x.agrmnt_type = f.id AND x.rnk_tr = c.rnk
   UNION ALL
   SELECT                                   /* все остальные доп.соглашения */
         da.agrmnt_id,
          da.agrmnt_date,
          da.agrmnt_num,
          da.agrmnt_type,
          f.name,
          da.dpt_id,
          da.branch,
          da.cust_id,
          da.bankdate,
          da.template_id,
          NULL,
          NULL,
          NULL,
          da.agrmnt_state,
          da.agrmnt_state,
          DECODE (da.agrmnt_state,
                  1, 'активна',
                  0, 'закрита',
                  'сторнована'),
         (select wb from dpt_deposit where deposit_id = da.dpt_id) wb  
     FROM dpt_agreements da, dpt_vidd_flags f
    WHERE     da.agrmnt_type = f.id
          AND (da.trustee_id IS NULL OR da.agrmnt_type = 7);

PROMPT *** Create  grants  V_DPT_AGREEMENTS ***
grant SELECT                                                                 on V_DPT_AGREEMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_AGREEMENTS to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_AGREEMENTS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_AGREEMENTS.sql =========*** End *
PROMPT ===================================================================================== 
