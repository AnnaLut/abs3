CREATE OR REPLACE VIEW V_CRSOUR_INT_RECKONING AS
SELECT
 t.deal_id     , t.account_id   , t.interest_kind  , t.deal_number, t.currency_id, t.partner_mfo, t.partner_name, t.account_number,
 t.account_rest, t.interest_rate, t.interest_amount, t.date_from  , t.date_to    , t.MESSAGE    , t.state_id
FROM int_reckoning t WHERE t.reckoning_id = SYS_CONTEXT ('bars_pul', 'reckoning_id');
