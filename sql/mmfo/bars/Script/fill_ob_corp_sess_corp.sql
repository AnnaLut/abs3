insert into OB_CORP_SESS_CORP
select distinct SESS_ID, KF, CORP_ID, case when LAST_S = SESS_ID then 1 else 0 end as IS_LAST from
(select SESS_ID, KF, CORP_ID, max(sess_id) over (partition by kf, corp_id, (select file_date from OB_CORP_SESS q where q.id = l.SESS_ID)) as LAST_S from ob_corp_data_acc l) w
where not exists (select 1 from OB_CORP_SESS_CORP q where w.sess_id = q.sess_id and w.corp_id = q.corp_id);
/
commit;
/
