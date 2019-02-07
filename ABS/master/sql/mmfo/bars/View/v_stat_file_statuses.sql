create or replace view v_stat_file_statuses as
select ID,
       NAME
from stat_file_statuses
where id <> 0;
