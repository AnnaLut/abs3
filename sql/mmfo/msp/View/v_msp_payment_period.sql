PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_payment_period.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create view v_msp_payment_period ***

create or replace view v_msp_payment_period as
select distinct payment_period
from v_msp_envelopes_match2
order by 1;

PROMPT *** Create comments on v_msp_payment_period ***

comment on table v_msp_payment_period is 'Список періодів для формування квитанції 2';
comment on column v_msp_payment_period.payment_period is 'Період';

PROMPT *** Create  grants  v_msp_payment_period ***

grant select on v_msp_payment_period to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_payment_period.sql =========*** End *** =
PROMPT ===================================================================================== 
