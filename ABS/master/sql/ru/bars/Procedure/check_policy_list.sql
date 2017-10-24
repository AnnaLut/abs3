

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CHECK_POLICY_LIST.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CHECK_POLICY_LIST ***

  CREATE OR REPLACE PROCEDURE BARS.CHECK_POLICY_LIST (p_policy_list in varchar2) is
    l_char  varchar2(1);
    l_pos	integer;
begin
    l_pos := 1;
    loop
    	l_char := substr(p_policy_list,l_pos,1);
    	exit when l_char is null;
        begin
        	select policy_char into l_char from policy_mnemonics where policy_char=l_char;
        exception when no_data_found then
        	raise_application_error(-20000, 'Символ политики '''||l_char||''' не определен', true);
        end;
        l_pos := l_pos + 1;
    end loop;
end check_policy_list;
/
show err;

PROMPT *** Create  grants  CHECK_POLICY_LIST ***
grant EXECUTE                                                                on CHECK_POLICY_LIST to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CHECK_POLICY_LIST.sql =========***
PROMPT ===================================================================================== 
