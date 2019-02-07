create or replace view v_stat_file_workflow as
select f.id  file_id,
       so.id ope_id,
       so.name,
       so.need_sign,
       oh.user_id,
       u.fio,
       oh.oper_date ,
       oh.way  ,
       case oh.way when 1 then '�����' when 2 then '�����' when 3 then '�����(�������)' end as direction
  from    stat_files f
     join stat_file_types t            on f.file_type_id = t.id
     join stat_workflow_operations wo  on wo.wf_id = t.wf_id
     join stat_operations so           on so.id = wo.oper_id
left join stat_file_operations_hist oh on oh.file_id  = f.id and oh.oper_id = so.id and oh.way = 1
left join staff$base u                 on u.id = oh.user_id
order by so.id, oh.id;
