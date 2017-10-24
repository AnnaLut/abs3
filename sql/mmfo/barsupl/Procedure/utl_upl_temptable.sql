

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Procedure/UTL_UPL_TEMPTABLE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure UTL_UPL_TEMPTABLE ***

  CREATE OR REPLACE PROCEDURE BARSUPL.UTL_UPL_TEMPTABLE ( p_action varchar2, p_group_id number  default 0, p_file_id number default 0, p_test number default 0 )
as
   l_group   number;
   l_file    number;
   l_msg_str varchar2(100);
begin
   l_group   := NVL(p_group_id, 0);
   l_file    := NVL(p_file_id,  0);
   l_msg_str := 'utl_upl_tempTable('||p_action||','||l_group||','||l_file||'):';
   dbms_output.put_line(l_msg_str);
   for c in (  select distinct
                      c.file_id, c.filename_prfx, --c.group_id,
                      'create table barsupl.tmp_g' || l_group || '_' || c.filename_prfx ||chr(13)||chr(10)|| ' (' ||
                      listagg(c.cols, ','||chr(13)||chr(10)) within group (order by c.col_id) over (partition by c.file_id, c.group_id) ||  ')' sq_txt, --реальная размерность колонок (cols)
                      'create table barsupl.tmp_g' || l_group || '_' || c.filename_prfx ||chr(13)||chr(10)|| ' (' ||
                      listagg(c.cols1, ','||chr(13)||chr(10)) within group (order by c.col_id) over (partition by c.file_id, c.group_id) || ')' sq_txt1, --дефолтная  размерность колонок (cols1)
                      'drop table barsupl.tmp_g' || l_group || '_' || c.filename_prfx || ' purge' sq_txt_drop,
                      'truncate table barsupl.tmp_g' || l_group || '_' || c.filename_prfx sq_txt_trunc1,
                      'truncate table barsupl.tmp_g' || l_group || '_' || c.filename_prfx || ' DROP STORAGE' sq_txt_trunc2
                 from (
                       select f.file_id, f.filename_prfx, c.COL_ID, r.group_id,
                              c.COL_NAME || '   ' || c.COL_TYPE || decode(c.COL_TYPE, 'DATE', '', '(' || COL_LENGTH || nvl2(COL_SCALE, ',' || COL_SCALE, '') || ')') cols,
                              c.COL_NAME || '   ' || c.COL_TYPE || decode(c.COL_TYPE, 'DATE', '',
                                                                                      'CHAR', '(255)',
                                                                                      'VARCHAR2', '(255)',
                                                                                      'NUMBER', ''
                                                                                      ) cols1
                         from barsupl.upl_files f,
                              barsupl.upl_columns c,
                              barsupl.upl_filegroups_rln r
                        where c.file_id  = f.file_id
                          and r.file_id  = f.file_id
                          and (r.group_id = p_group_id or l_group = 0)
                          and (f.file_id  = l_file     or l_file  = 0)
                          and f.isactive > 0
                      ) c
                order by c.file_id
            )
   loop
      begin
         case upper(p_action)
            when 'CREATE' then
                 if p_test != 0 then
                    dbms_output.put_line('file=' || c.file_id || '--' || c.filename_prfx || ': ' || c.sq_txt1);
                 else 
                     begin
                       execute immediate c.sq_txt1; --create
                     exception when others then dbms_output.put_line(' file=' || c.file_id || '--' || c.filename_prfx || '--' || SQLERRM); null;
                     end;
                 end if;
            when 'RECREATE' then
                 if p_test != 0 then
                    dbms_output.put_line('file=' || c.file_id || '--' || c.filename_prfx || ': ' || c.sq_txt_drop);
                    dbms_output.put_line('file=' || c.file_id || '--' || c.filename_prfx || ': ' || c.sq_txt1);
                 else 
                     begin 
                       execute immediate c.sq_txt_drop; --drop
                     exception when others then dbms_output.put_line(' file=' || c.file_id || '--' || c.filename_prfx || '--' || SQLERRM); null;
                     end;
                     execute immediate c.sq_txt1; --create
                 end if;
            when 'DROP' then
                 if p_test != 0 then
                    dbms_output.put_line('file=' || c.file_id || '--' || c.filename_prfx || ': ' || c.sq_txt_drop);
                 else 
                    execute immediate c.sq_txt_drop; --drop
                 end if;
            when 'TRUNC' then
                 if p_test != 0 then
                    dbms_output.put_line('file=' || c.file_id || '--' || c.filename_prfx || ': ' || c.sq_txt_trunc1);
                 else 
                     begin 
                       execute immediate c.sq_txt_trunc1; --truncate
                     exception when others then dbms_output.put_line(c.file_id || '--' || c.filename_prfx || '--' || SQLERRM); null;
                     end;
                 end if;
         end case;
         dbms_output.put_line(' file=' || c.file_id || '--' || c.filename_prfx || '--' || 'OK');
         exception
            when others then
                 dbms_output.put_line(' file=' || c.file_id || '--' || c.filename_prfx || '--' || SQLERRM);
      end;
   end loop;
end utl_upl_tempTable;


--наполнение таблиц UPL
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Procedure/UTL_UPL_TEMPTABLE.sql =========
PROMPT ===================================================================================== 
