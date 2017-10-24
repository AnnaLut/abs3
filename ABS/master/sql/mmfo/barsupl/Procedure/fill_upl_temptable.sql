

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Procedure/FILL_UPL_TEMPTABLE.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FILL_UPL_TEMPTABLE ***

  CREATE OR REPLACE PROCEDURE BARSUPL.FILL_UPL_TEMPTABLE ( p_dt varchar2, p_group_id number  default 0, p_file_id number default 0, p_test number default 0 )
as
   l_group   number;
   l_file    number;
   l_msg_str varchar2(100);
   l_sql       clob;
begin
   l_group   := NVL(p_group_id, 0);
   l_file    := NVL(p_file_id,  0);
   l_msg_str := 'utl_upl_tempTable('||p_dt||','||l_group||','||l_file||'):';
   dbms_output.put_line(l_msg_str);
   for c in (
               select f.file_id, s.sql_id, 'insert into barsupl.tmp_g' || r.group_id || '_' || f.FILENAME_PRFX ||chr(13)||chr(10)|| s.sql_text SQL_TXT, 'COMMIT' CMT
                 from barsupl.upl_files f,
                      barsupl.upl_filegroups_rln r,
                      barsupl.upl_sql s
                where r.file_id = f.file_id
                  and f.isactive > 0
                  and s.sql_id = r.sql_id
                  and (r.group_id = p_group_id or l_group = 0)
                  and (f.file_id  = l_file     or l_file  = 0)
                order by f.file_id
            )
   loop
      begin
             l_sql := REGEXP_REPLACE(c.SQL_TXT, ':\w+', '''' || p_dt || '''');
             if p_test != 0 then
                dbms_output.put_line('file=' || c.file_id || '--' || c.sql_id || ': ' || l_sql);
             else 
                execute immediate l_sql;
                execute immediate c.CMT;
             end if;
             dbms_output.put_line(' file=' || c.file_id || '--' || c.sql_id || '-- OK');
             exception when others then
              dbms_output.put_line(' file=' || c.file_id || '--' || c.sql_id || '--' || SQLERRM);
              null;
      end;
   end loop;
end fill_upl_tempTable;


-- tmp_test_Table - протокол сверки
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Procedure/FILL_UPL_TEMPTABLE.sql ========
PROMPT ===================================================================================== 
