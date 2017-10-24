

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Procedure/PRINT_CLOB.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PRINT_CLOB ***

  CREATE OR REPLACE PROCEDURE BARSAQ.PRINT_CLOB ( p_clob in clob )
as
     l_offset   integer default 1;
     l_newline  integer;
     l_length   integer;
begin
   l_length := dbms_lob.getlength(p_clob);
   loop
     exit when l_offset > l_length;
     l_newline := dbms_lob.instr(p_clob, chr(10), l_offset);
     if l_newline=0 then
        l_newline := l_length;
     end if;
     dbms_output.put_line(
        dbms_lob.substr(
            p_clob,
            l_newline-l_offset + case when l_newline=l_length then 1 else 0 end,
            l_offset )
     );
     l_offset := l_newline+1;
   end loop;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Procedure/PRINT_CLOB.sql =========*** End 
PROMPT ===================================================================================== 
