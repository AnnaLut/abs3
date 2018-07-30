PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_file_state.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_file_state ***

create or replace view v_msp_file_state as
select id, state, name from msp_file_state s;

PROMPT *** Create comments on v_msp_file_state ***

comment on table v_msp_file_state is 'Стани файла';
comment on column v_msp_file_state.id is 'id стану реєстра';
comment on column v_msp_file_state.state is 'Стан реєстра';
comment on column v_msp_file_state.name is 'Назва стану';


PROMPT *** Create  grants  v_msp_file_state ***

grant select on v_msp_file_state to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_file_state.sql =========*** End *** =
PROMPT ===================================================================================== 
