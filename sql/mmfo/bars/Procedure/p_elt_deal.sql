

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ELT_DEAL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ELT_DEAL ***

  CREATE OR REPLACE PROCEDURE BARS.P_ELT_DEAL (
p_mode   int,
p_nd     e_deal$base.nd%type,
p_dat1   e_deal$base.sdate%type,   -- ���� �����
p_sos    e_deal$base.sos%type,
p_cc_id  e_deal$base.cc_id%type,
p_rnk    e_deal$base.rnk%type,
p_acc26  e_deal$base.acc26%type,
p_nls36  e_deal$base.acc36%type,
p_nls_p  e_deal$base.accp%type,
p_avto   int
)
is
l_user_id  int;
l_acc26    accounts.acc%type;
l_sdate    e_deal$base.sdate%type;
l_wdate    e_deal$base.wdate%type;
begin
  l_user_id := user_id;

  if p_mode = 1 then --insert

    begin
       select min(a.acc) into l_acc26
       from accounts a
       where a.rnk=p_rnk
              and a.nbs in (select nbs from e_nbs) -- (2560,2572,2600,2603,2604,2620,2650,2062,2063)
              and a.tip in ('ODB','BDB','SS')
             and a.dazs is null;
    exception when no_data_found then raise_application_error(-20444, '�� �������� ������� ���������� �������.', true);
    end;

    if p_dat1 is null then
      l_sdate := trunc(sysdate);
    else
      l_sdate := p_dat1;
    end if;

    select trunc(l_sdate, 'MM') - 1 into l_wdate from dual; -- ���� ������������ ���������� �������������� ������� ���� ������������ �����.

    begin
      insert into e_deal$base (nd, sos,   cc_id,   sdate,   rnk,   user_id,   acc26,   wdate) values
                              ( 0,  10, p_cc_id, l_sdate, p_rnk, l_user_id, l_acc26, l_wdate);
    exception when dup_val_on_index then null;
    end;

  end if;

end;
/
show err;

PROMPT *** Create  grants  P_ELT_DEAL ***
grant EXECUTE                                                                on P_ELT_DEAL      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ELT_DEAL.sql =========*** End **
PROMPT ===================================================================================== 
