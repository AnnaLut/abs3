
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_deal_penalty.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_DEAL_PENALTY 
( p_dptid  in   dpt_deposit.deposit_id%type
) return number
is
  l_acc_dep     accounts.acc%type;
  l_acc_int     accounts.acc%type;
  l_dat_begin   dpt_deposit.dat_begin%type;
  l_dat_end     dpt_deposit.dat_begin%type;
  l_penalty     number;
begin

  begin

    select dc.acc, dc.dat_begin, dc.dat_end, i.acra
      into l_acc_dep, l_dat_begin, l_dat_end, l_acc_int
      from BARS.DPT_DEPOSIT_CLOS dc
     inner join bars.int_accn i on (i.acc = dc.acc and i.id = 1)
     where dc.deposit_id = p_dptid
       and dc.action_id = 5;

    select sum(decode(q.tt,'DPT', q.s, 'DPS', q.s, 0)) - sum(decode(q.tt, '%%1', q.s, 0))
    into l_penalty
    from ( select o.tt, o.s
             from opldok o
            where o.acc = l_acc_int
              and o.fdat between l_dat_begin and l_dat_end
              and not exists ( select 1 from ACR_DOCS r where r.int_ref = o.ref )
              and o.tt in ('%%1','DPS')
            union all
           select o.tt, o.s
             from opldok o
            where o.acc = l_acc_dep
              and o.fdat between l_dat_begin and l_dat_end
              and o.tt = 'DPT' ) q;

    l_penalty := nvl(l_penalty/100, 0);

  exception
    when OTHERS then
      l_penalty := null;
      bars_audit.info( 'DPT.get_deal_penalty: ' || sqlerrm || dbms_utility.format_error_backtrace() );
  end;

  RETURN l_penalty;

end get_deal_penalty;
/
 show err;
 
PROMPT *** Create  grants  GET_DEAL_PENALTY ***
grant EXECUTE                                                                on GET_DEAL_PENALTY to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_deal_penalty.sql =========*** E
 PROMPT ===================================================================================== 
 