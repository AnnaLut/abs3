create or replace view v_stat_file_workflow as
select level a, a."FILE_ID",a."OPE_ID",a."NAME",a."NEED_SIGN",a."USER_ID",a."FIO",a."OPER_DATE",a."BEGIN_STATUS",a."END_STATUS",a."WAY",a."DIRECTION"
from (select   f.id  file_id,
               so.id ope_id,
               so.name,
               so.need_sign,
               oh.user_id,
               u.fio,
               oh.oper_date,
               so.begin_status,
               so.end_status,
               oh.way  ,
               case oh.way when 1 then 'пряма' when 2 then 'відміна' when 3 then 'пряма(відмінена)' end as direction
          from    stat_files f
             join stat_file_types t            on f.file_type_id = t.id
             join stat_workflow_operations wo  on wo.wf_id = t.wf_id
             join stat_operations so           on so.id = wo.oper_id
        left join stat_file_operations_hist oh on oh.file_id  = f.id and oh.oper_id = so.id and oh.way = 1
        left join staff$base u                 on u.id = oh.user_id
      where f.id = TO_NUMBER (pul.Get_Mas_Ini_Val ('FILE_ID')) ) a
start with a.begin_status=0
connect by prior a.end_status=a.begin_status
order  by 1;
