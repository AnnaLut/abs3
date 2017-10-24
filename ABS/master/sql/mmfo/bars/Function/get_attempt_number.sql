
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_attempt_number.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_ATTEMPT_NUMBER (p_ref oper.ref%type) return integer is
    l_atn       integer;
    l_value     operw.value%type;
    l_template  operw.value%type;
  begin
    l_template := 'Рахунок зайнято, спроба оплати № ';
    begin
        select value into l_value from operw where ref=p_ref and tag='PSTAT';
        if l_value like l_template||'%' then
            l_atn := to_number(substr(l_value, length(l_template)));
        else
            l_atn := 0;
        end if;
    exception when no_data_found then
        l_atn := 0;
    end;
    return l_atn;
  end get_attempt_number;
 
/
 show err;
 
PROMPT *** Create  grants  GET_ATTEMPT_NUMBER ***
grant EXECUTE                                                                on GET_ATTEMPT_NUMBER to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_attempt_number.sql =========***
 PROMPT ===================================================================================== 
 