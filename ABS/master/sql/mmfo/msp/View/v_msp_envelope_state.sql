PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_envelope_state.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_envelope_state ***

create or replace view v_msp_envelope_state as
select id, state, name from msp_envelope_state;

PROMPT *** Create comments on v_msp_envelope_state ***
comment on table v_msp_envelope_state is 'Стани конвертів';
comment on column v_msp_envelope_state.id is 'id стану конверта';
comment on column v_msp_envelope_state.state is 'Стан конверта';
comment on column v_msp_envelope_state.name is 'Назва стану';


PROMPT *** Create  grants  v_msp_envelope_state ***

grant select on v_msp_envelope_state to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_envelope_state.sql =========*** End *** =
PROMPT ===================================================================================== 
