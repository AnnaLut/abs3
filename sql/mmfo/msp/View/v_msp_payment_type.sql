PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_payment_type.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create view v_msp_payment_type ***

create or replace view v_msp_payment_type as
select distinct payment_type
from v_msp_envelopes_match2
order by 1;

PROMPT *** Create comments on v_msp_payment_type ***

comment on table v_msp_payment_type is 'Список типів виплати за останніх 2 місяці';
comment on column v_msp_payment_type.payment_type is 'Тип виплати';

PROMPT *** Create  grants  v_msp_payment_type ***

grant select on v_msp_payment_type to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_payment_type.sql =========*** End *** =
PROMPT ===================================================================================== 
