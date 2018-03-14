create or replace view v_nbu_session_to_sign as
select s.id, nbu_object_utl.get_object_json(s.object_id, s.report_id) data_to_sign
from   nbu_session s
where  s.state_id = 1 /*SESSION_STATE_NEW*/;

grant all on v_nbu_session_to_sign to bars_access_defrole;
