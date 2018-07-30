PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_file_record_state.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_file_record_state ***

create or replace view v_msp_file_record_state as
select id, name from msp_file_record_state s;

PROMPT *** Create comments on v_msp_file_record_state ***

comment on table v_msp_file_record_state is 'Стани інформаційних рядків файла';
comment on column v_msp_file_record_state.id is 'id стану інформаційного рядка реєстра';
comment on column v_msp_file_record_state.name is 'Назва стану інформаційного рядка реєстру';


PROMPT *** Create  grants  v_msp_file_record_state ***

grant select on v_msp_file_record_state to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_file_record_state.sql =========*** End *** =
PROMPT ===================================================================================== 
