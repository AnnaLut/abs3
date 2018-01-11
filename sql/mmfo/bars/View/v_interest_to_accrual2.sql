

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INTEREST_TO_ACCRUAL2.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INTEREST_TO_ACCRUAL2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INTEREST_TO_ACCRUAL2 ("ID", "ACCOUNT_ID", "INTEREST_KIND_ID", "ACCOUNT_NUMBER", "CURRENCY_ID", "OKPO", "ACCOUNT_NAME", "INTEREST_KIND_NAME", "INTEREST_ACCOUNT_NUMBER", "DATE_FROM", "DATE_THROUGH", "ACCOUNT_REST", "INTEREST_RATE", "INTEREST_AMOUNT", "COUNTER_ACCOUNT", "ACCRUAL_PURPOSE", "STATE_ID", "RECKONING_STATE", "STATE_COMMENT", "MANAGER_ID", "MANAGER_NAME", "CORPORATION_CODE", "CORPORATION_NAME") AS 
  SELECT r.id,
        r.account_id,
        r.interest_kind_id,
        a.nls account_number,
        a.kv currency_id,
        cu.okpo,
        a.nms account_name,
        ik.name interest_kind_name,
        ia.nls interest_account_number,
        r.date_from,
        r.date_through,
        currency_utl.from_fractional_units (r.account_rest, a.kv) account_rest,
        r.interest_rate,
        currency_utl.from_fractional_units (r.interest_amount, a.kv) interest_amount,
        ca.nls counter_account,
        CASE WHEN r.state_id IN (1, /*RECKONING_STATE_RECKONED*/
                                 2, /*RECKONING_STATE_MODIFIED*/
                                 6 /*RECKONING_STATE_ACCRUAL_FAILED*/) THEN
                  CASE WHEN r.accrual_purpose IS NULL THEN
                       interest_utl2.generate_accrual_purpose (r.id, r.line_type_id, i.metr, a.nls, r.date_from, r.date_through, r.interest_rate)
                  ELSE
                       r.accrual_purpose
                  END
             ELSE ''
        END
       accrual_purpose,
    r.state_id,
    list_utl.get_item_name ('INTEREST_RECKONING_STATE', r.state_id)
       reckoning_state,
    interest_utl.get_reckoning_comment (r.id,
                                        r.state_id,
                                        r.accrual_document_id,
                                        r.payment_document_id)
       state_comment,
    a.isp manager_id,
    s.fio manager_name,
    NVL (w.kodk, k.kodk) corporation_code,
    c.name_cli corporation_name
FROM int_reckonings r
    JOIN accounts a ON a.acc = r.account_id
    JOIN customer cu ON cu.rnk = a.rnk
    JOIN int_accn i
       ON i.acc = r.account_id AND i.id = r.interest_kind_id
    JOIN int_idn ik ON ik.id = i.id
    LEFT JOIN accounts ia ON ia.acc = i.acra
    LEFT JOIN accounts ca ON ca.acc = i.acrb
    LEFT JOIN rnkp_kod k ON k.rnk = a.rnk
    LEFT JOIN rnkp_kod_acc w ON w.acc = a.rnk
    LEFT JOIN kod_cli c ON c.kod_cli = NVL (w.kodk, k.kodk)
    LEFT JOIN staff$base s ON s.id = a.isp
WHERE     r.grouping_line_id IS NULL
    AND (   r.state_id IN (1              /*RECKONING_STATE_RECKONED*/
                            , 2           /*RECKONING_STATE_MODIFIED*/
                               , 3  /*RECKONING_STATE_RECKONING_FAIL*/
                                  , 6 /*RECKONING_STATE_ACCRUAL_FAILED*/
                                     )
         OR (r.state_id = 99             /*RECKONING_STATE_ONLY_INFO*/
                            AND pul.get ('SHOW_ZERO_RECKONINGS') = 'Y'))
ORDER BY a.nls, r.date_from;

PROMPT *** Create  grants  V_INTEREST_TO_ACCRUAL2 ***
grant SELECT                                                                 on V_INTEREST_TO_ACCRUAL2 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INTEREST_TO_ACCRUAL2.sql =========***
PROMPT ===================================================================================== 
