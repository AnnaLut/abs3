PROMPT *** Create  procedure P_D8_041 ***

create or replace procedure p_d8_041 (rnk in varchar2 default null)
is
-- version 2.0 18.09.2017
begin
    update d8_cust_link_groups t
    set t.link_code = tools.number_to_base(t.link_group,62);
end;
/
show err;

PROMPT *** Create  grants  P_D8_041 ***
grant EXECUTE                                                                on P_D8_041        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_D8_041        to START1;

