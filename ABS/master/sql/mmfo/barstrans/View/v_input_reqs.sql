CREATE or replace view V_INPUT_REQS as
  select 
  r.ID,
  r.HTTP_TYPE,
  r.TYPE_NAME,
  t.type_desc,
  r.REQ_ACTION,
  r.REQ_USER,
  /*nvl(s.fio, s1.fio||' Пряме зєднання')*/ null as fio,
  r.INSERT_TIME,
  r.CONVERT_TIME,
  s.name as status,
  r.PROCESSED_TIME
  from INPUT_REQS r
  left join INPUT_STATE s on r.status = s.id
  left join input_types t on r.type_name = t.type_name;
  --left join bars.staff$base s on s.logname = r.req_user
  --left join bars.staff$base s1 on s1.logname = substr(r.req_user,6);
/
grant select on v_input_reqs to bars_access_defrole;
/