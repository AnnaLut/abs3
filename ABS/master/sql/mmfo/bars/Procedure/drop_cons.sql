

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DROP_CONS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DROP_CONS ***

  CREATE OR REPLACE PROCEDURE BARS.DROP_CONS (p_table in varchar2, p_column in varchar2) is
/*
  процедура для удаления check и referential констрейнтов на заданной таблице
  по заданному полю
*/
begin
   dbms_output.put_line('drop_cons(): Удаление check и referential констрейнтов на '||p_table||'.'||p_column);
 for c in (select tl.CONSTRAINT_NAME cn
  from user_cons_columns cl, user_constraints tl
  where tl.table_name = p_table
    and tl.CONSTRAINT_NAME = cl.CONSTRAINT_NAME
    and cl.COLUMN_NAME = p_column
                  and tl.constraint_type in ('C','R'))
 loop
  execute immediate 'alter table '||p_table||' drop constraint '||c.cn;
  dbms_output.put_line('Constraint '||c.cn||' dropped');
 end loop;
  dbms_output.put_line('drop_cons(): finish');
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DROP_CONS.sql =========*** End ***
PROMPT ===================================================================================== 
