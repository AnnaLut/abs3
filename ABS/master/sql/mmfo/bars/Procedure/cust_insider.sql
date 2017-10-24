

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CUST_INSIDER.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CUST_INSIDER ***

  CREATE OR REPLACE PROCEDURE BARS.CUST_INSIDER (p_rnk in customer.rnk%type)
is
 l_kl060 customer.prinsider%type;
begin
 begin
  select prinsider
    into l_kl060
    from customer
   where rnk = p_rnk;
 exception when no_data_found then return;
 end;

 if l_kl060 = 99
 then
   for t_unlock in (select a.acc, a.nbs, a.nls, a.blkd, du.dat_begin, du.dat_end
         from accounts a,
              dpu_deal du
        where a.rnk = p_rnk
          and a.nbs in ('2525', '2546', '2610', '2615', '2651', '2652')
          and a.dazs is null
          and du.acc = a.acc(+)
          and a.blkd = 12
          and du.dat_end >= gl.bdate
        union all
        select a.acc, a.nbs, a.nls, a.blkd, d.dat_begin, d.dat_end
         from accounts a,
              dpt_deposit d
        where a.rnk = p_rnk
          and a.nbs in ('2630', '2635')
          and a.dazs is null
          and d.acc = a.acc(+)
          and a.blkd = 12
          and d.dat_end >= gl.bdate)
   loop
    update accounts
       set blkd = 0
     where acc = t_unlock.acc
       and rnk = p_rnk;
   end loop;

 else
  for t_lock in (select a.acc, a.nbs, a.nls, a.blkd, du.dat_begin, du.dat_end
         from accounts a,
              dpu_deal du
        where a.rnk = p_rnk
          and a.nbs in ('2525', '2546', '2610', '2615', '2651', '2652')
          and a.dazs is null
          and du.acc = a.acc(+)
          and a.blkd = 0
          and du.dat_end >= gl.bdate
        union all
        select a.acc, a.nbs, a.nls, a.blkd, d.dat_begin, d.dat_end
         from accounts a,
              dpt_deposit d
        where a.rnk = p_rnk
          and a.nbs in ('2630', '2635')
          and a.dazs is null
          and d.acc = a.acc(+)
          and a.blkd = 0
          and d.dat_end >= gl.bdate)
   loop
    /*update accounts
       set blkd = 12
     where acc = t_lock.acc
       and rnk = p_rnk;*/ null;
   end loop;

 end if;


end cust_insider;
/
show err;

PROMPT *** Create  grants  CUST_INSIDER ***
grant EXECUTE                                                                on CUST_INSIDER    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CUST_INSIDER.sql =========*** End 
PROMPT ===================================================================================== 
