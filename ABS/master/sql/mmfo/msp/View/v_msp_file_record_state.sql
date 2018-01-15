PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_file_record_state.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_file_record_state ***

create or replace view v_msp_file_record_state as
select id, name from msp_file_record_state s;

PROMPT *** Create comments on v_msp_file_record_state ***

comment on column v_msp_file_record_state.id is 'id ����� �������������� ����� ������';
comment on column v_msp_file_record_state.name is '����� ����� �������������� ����� ������';


PROMPT *** Create  grants  v_msp_file_record_state ***

grant select on v_msp_file_record_state to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_file_record_state.sql =========*** End *** =
PROMPT ===================================================================================== 
