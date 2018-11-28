prompt create function bills.get_bill_param

create or replace function get_bill_param(p_param in varchar2)
return varchar2
result_cache relies_on (bill_params)
is
l_result bill_params.val%type;
begin
    select val into l_result
    from bill_params
    where par = p_param;
    return l_result;
exception
    when no_data_found then
        return null;
end;
/
show errors;