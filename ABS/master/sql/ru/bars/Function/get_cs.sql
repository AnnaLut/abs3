
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_cs.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_CS return varchar2 is
    CL_FIRST_CALLER  constant number := 2;   
    l_stack       varchar2(4096) default dbms_utility.format_call_stack;
    l_line        varchar2(4000);
    l_linesep     number;
    l_stackFound  boolean        default false;
    l_callerLevel number         default 0;
    l_owner       varchar2(30);
    l_object      varchar2(30);
    l_lineno      number;
    begin
        loop
            l_linesep := instr(l_stack, chr(10));
            exit when (l_callerLevel = CL_FIRST_CALLER+1 or l_linesep is null or l_linesep = 0);
            l_line  := substr(l_stack, 1, l_linesep-1);
            l_stack := substr(l_stack, l_linesep+1);
            if (not l_stackFound) then
                if (l_line like '%handle%number%name%') then
                    l_stackFound := true;
                end if;
            else
                l_callerLevel := l_callerLevel + 1;
                if (l_callerLevel = CL_FIRST_CALLER) then
                    -- search LineNo position
                    l_line   := ltrim(substr(l_line, instr(l_line, ' ')));
                    l_lineno := to_number(substr(l_line, 1, instr(l_line, ' ')));
                    -- search object position
                    l_line := ltrim(substr(l_line, instr(l_line, ' ')));
                    l_line := ltrim(substr(l_line, instr(l_line, ' ')));
                    if (l_line like 'block%' or l_line like 'body%') then
                        l_line := ltrim(substr(l_line, instr(l_line, ' ')));
                    end if;
                    l_owner  := ltrim(rtrim(substr(l_line, 1, instr(l_line, '.') - 1)));
                    l_object := ltrim(rtrim(substr(l_line, instr(l_line, '.') + 1)));
                    if (l_owner is null) then
                        l_owner  := user;
                        l_object := 'ANONYMOUS BLOCK';
                    end if;
                end if;
            end if;
        end loop;
        return substr(l_owner || '.' || l_object, 1, 100);
    end get_cs; 
/
 show err;
 
PROMPT *** Create  grants  GET_CS ***
grant EXECUTE                                                                on GET_CS          to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_cs.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 