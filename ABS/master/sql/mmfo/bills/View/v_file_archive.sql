prompt view v_file_archive
create or replace force view v_file_archive
as
select 
kf,
file_id,
file_name,
description,
file_data,
load_date,
file_status
from file_archive;

grant select on v_file_archive to bars_access_defrole;