insert into ob_corp_sess select id, kf, file_date, state_id, sys_time, 1 from ob_corporation_session w
where not exists (select 1 from ob_corp_sess q where q.id = w.id and q.kf = w.kf);
/
commit;
/