

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Procedure/CORR_UPL_TEMPTABLE.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CORR_UPL_TEMPTABLE ***

  CREATE OR REPLACE PROCEDURE BARSUPL.CORR_UPL_TEMPTABLE ( p_group_id number, p_file_id number default 0, p_test number default 0  )
as
   l_file    number;
begin
   l_file    := NVL(p_file_id,  0);
   for c in (
               select c.file_id, r.group_id, 'update barsupl.tmp_g' || r.group_id || '_' || f.FILENAME_PRFX 
                      || ' set ' || c.col_name || '=' || 'substr(' || c.col_name || ', 1, length(' || c.col_name || ') - 2) where length(' || c.col_name || ') > 2 and '
                      || c.col_name || ' is not null' sql_txt
                 from barsupl.upl_columns c,
                      barsupl.upl_filegroups_rln r,
                      barsupl.upl_files f
                where r.file_id = c.file_id
                  and f.file_id = c.file_id
                  and c.prefun = 'TRUNC_E2'
                  and r.group_id = p_group_id
                  and (c.file_id  = l_file or l_file  = 0)
                order by r.group_id, c.file_id, c.col_id
            )
   loop
      begin
          if p_test != 0 then
             dbms_output.put_line('file=' || c.file_id || chr(13)||chr(10) || c.sql_txt);
          else 
             execute immediate c.sql_txt;
             commit;
          end if;
          execute immediate c.sql_txt;
      exception when others then
          dbms_output.put_line('file=' || c.file_id || chr(13)||chr(10) || c.sql_txt);
          dbms_output.put_line(' file=' || c.file_id || '--' || chr(10) || dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
          --update barsupl.tmp_test_Table
          --   set err_log = dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace()
          -- where group_id = c.group_id and file_id  = c.file_id;
          --commit;
          null;
      end;
   end loop;
end corr_upl_tempTable;



--проверка
--test_tempTable - наполняет tmp_test_Table запросами для проверки
--drop procedure test_upl_tempTable;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Procedure/CORR_UPL_TEMPTABLE.sql ========
PROMPT ===================================================================================== 
