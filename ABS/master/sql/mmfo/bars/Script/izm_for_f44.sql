set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt переналаштування файлу #44
declare
  cnt_  number;
begin
  delete 
  from bars.nbur_lnk_files_objects
  where file_id = 15252;
  
  update bars.NBUR_REF_PROCS
  set PROC_TYPE = 'O'
  where file_id = 15252;
  
  commit;
end;
/
commit;
