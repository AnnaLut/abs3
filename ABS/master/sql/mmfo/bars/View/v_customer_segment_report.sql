

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_SEGMENT_REPORT.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_SEGMENT_REPORT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_SEGMENT_REPORT ("REGION_NAME", "BRANCH", "CLIENTS_COUNT", "ACTIVITY_SEGMENT", "FINANCIAL_SEGMENT", "BEHAVIOR_SEGMENT", "SOCIAL_VIP_SEGMENT", "TRANSACTOR_SUBSEGMENT", "GENERAL_PROD_PRESSURE", "DEPOSIT_FACTOR", "SECURED_LOANS_FACTOR", "CARD_LOANS_FACTOR", "CARDLESS_LOANS_FACTOR", "ENERGY_LOANS_FACTOR", "DEBIT_CARDS_FACTOR", "CURRENT_ACCOUNTS_FACTOR") AS 
  select b.name region_name,
       t.branch,
       case when t.record_level = 100 then t.client_name
            else to_char(t.clients_count)
       end clients_count,
       nvl(list_utl.get_item_name('CUSTOMER_SEGMENT_ACTIVITY', t.activity_segment), 'Âñ³') activity_segment,
       list_utl.get_item_name('CUSTOMER_SEGMENT_FINANCIAL', t.financial_segment) financial_segment,
       list_utl.get_item_name('CUSTOMER_SEGMENT_BEHAVIOR', t.behavior_segment) behavior_segment,
       list_utl.get_item_name('CUSTOMER_SEGMENT_SOCIAL_VIP', t.social_vip_segment) social_vip_segment,
       cast(to_char(t.transactor_subsegment) as varchar2(300 char)) transactor_subsegment,
       t.general_prod_pressure general_prod_pressure,
       t.deposit_factor deposit_factor,
       t.secured_loans_factor secured_loans_factor,
       t.card_loans_factor card_loans_factor,
       t.cardless_loans_factor cardless_loans_factor,
       t.energy_loans_factor energy_loans_factor,
       t.debit_cards_factor debit_cards_factor,
       t.current_accounts_factor current_accounts_factor
from tmp_customer_segment_report t
join branch b on b.branch = t.branch
order by t.branch nulls first, t.record_level, t.activity_segment nulls first;

PROMPT *** Create  grants  V_CUSTOMER_SEGMENT_REPORT ***
grant SELECT                                                                 on V_CUSTOMER_SEGMENT_REPORT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_SEGMENT_REPORT.sql =========
PROMPT ===================================================================================== 
