

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INTEREST_TO_PAYMENT2.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INTEREST_TO_PAYMENT2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INTEREST_TO_PAYMENT2 ("ID", "ACCOUNT_ID", "INTEREST_KIND_ID", "ACCOUNT_NUMBER", "CURRENCY_ID", "OKPO", "ACCOUNT_NAME", "INTEREST_ACCOUNT_NUMBER", "DATE_FROM", "DATE_THROUGH", "INTEREST_AMOUNT", "RECEIVER_MFO", "RECEIVER_ACCOUNT", "RECEIVER_CURRENCY_ID", "PAYMENT_PURPOSE", "STATE_ID", "RECKONING_STATE", "STATE_COMMENT", "MANAGER_ID", "MANAGER_NAME", "CORPORATION_CODE", "CORPORATION_NAME") AS 
  SELECT r.id,
            r.account_id,
            r.interest_kind_id,
            a.nls account_number,
            a.kv currency_id,
            cu.okpo,
            a.nms account_name,
            ia.nls interest_account_number,
            r.date_from,
            r.date_through,
            currency_utl.from_fractional_units (r.interest_amount, a.kv)
               interest_amount,
            CASE WHEN i.mfob IS NULL THEN a.kf ELSE i.mfob END receiver_mfo,
            CASE WHEN i.nlsb IS NULL THEN a.nls ELSE i.nlsb END
               receiver_account,
            CASE WHEN i.kvb IS NULL THEN a.kv ELSE i.kvb END
               receiver_currency_id,
            CASE
               WHEN TRIM (r.payment_purpose) IS NULL
               THEN
                  interest_utl.generate_payment_purpose (r.id,
                                                         r.line_type_id,
                                                         i.metr,
                                                         a.nls,
                                                         r.date_from,
                                                         r.date_through,
                                                         r.interest_rate)
               ELSE
                  r.payment_purpose
            END
               payment_purpose,
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
            JOIN saldo a ON a.acc = r.account_id
            JOIN customer cu ON cu.rnk = a.rnk
            JOIN int_accn i
               ON i.acc = r.account_id AND i.id = r.interest_kind_id
            LEFT JOIN saldo ia ON ia.acc = i.acra
            LEFT JOIN staff$base s ON s.id = a.isp
            LEFT JOIN rnkp_kod k ON k.rnk = a.rnk
            LEFT JOIN rnkp_kod_acc w ON w.acc = a.rnk
            LEFT JOIN kod_cli c ON c.kod_cli = NVL (w.kodk, k.kodk)
      WHERE     r.grouping_line_id IS NULL
            AND r.state_id IN (5                   /*RECKONING_STATE_ACCRUED*/
                                , 9         /*RECKONING_STATE_PAYMENT_FAILED*/
                                   , 10     /*RECKONING_STATE_PAYM_DISCARDED*/
                                       )
            AND i.id = 1                                             -- пасиви
   ORDER BY a.nls, r.date_from;

PROMPT *** Create  grants  V_INTEREST_TO_PAYMENT2 ***
grant SELECT                                                                 on V_INTEREST_TO_PAYMENT2 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INTEREST_TO_PAYMENT2.sql =========***
PROMPT ===================================================================================== 
