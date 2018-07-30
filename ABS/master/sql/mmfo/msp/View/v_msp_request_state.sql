PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_request_state.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_request_state ***

create or replace view v_msp_request_state as
select id, state, name from msp_request_state;

PROMPT *** Create comments on v_msp_request_state ***

comment on table v_msp_request_state is 'Стани запитів';
comment on column v_msp_request_state.id is 'id стану запиту';
comment on column v_msp_request_state.state is 'Стан запиту';
comment on column v_msp_request_state.name is 'Назва стану запиту';


PROMPT *** Create  grants  v_msp_request_state ***

grant select on v_msp_request_state to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_request_state.sql =========*** End *** =
PROMPT ===================================================================================== 
