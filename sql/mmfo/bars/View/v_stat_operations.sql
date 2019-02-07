create or replace view v_stat_operations as
select o.id,
       o.name,
       o.begin_status,
       sb.name begin_status_name,
       o.end_status,
       se.name end_status_name,
       o.need_sign,
       case o.need_sign when 'N' then 'Ні' when 'Y' then 'Так' when 'H' then 'Тільки на HASH' end need_sign_expl
from stat_operations o,
     stat_file_statuses sb,
     stat_file_statuses se
where o.begin_status = sb.id
  and o.end_status   = se.id
 -- and o.id <>0
order by o.id
;
