declare
l_count number;
begin
update tms_task t
   set BRANCH_PROCESSING_MODE = 3,
       TASK_STATEMENT = 'begin kfile_pack.kfile_vzd(); end;'
 where TASK_NAME = 'Формування файлів управлінської звітності (К-файлів по корпоративних клієнтах Ощадбанку)';
 l_count:=sql%rowcount;
 dbms_output.put_line('Оновлено '||l_count||' запис.');
 if l_count = 1 then
 commit;
 else
 rollback;
 end if;
end;
/