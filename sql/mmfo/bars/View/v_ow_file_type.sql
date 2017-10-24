create or replace force view bars.v_ow_file_type
(
   name,
   offset,
   offsetexpire
)
as
   select name, offset, offsetexpire
     from ow_file_type
    where file_type = 'ATRANSFERS';
/
grant select,delete,update,insert on bars.v_ow_file_type to bars_access_defrole;
/