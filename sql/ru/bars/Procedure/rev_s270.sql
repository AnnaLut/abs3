

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/REV_S270.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure REV_S270 ***

  CREATE OR REPLACE PROCEDURE BARS.REV_S270 
 ( p_NBS     accounts.NBS%type,
   p_Branch accounts.Branch%type) is
 -- ревизия параметра S270
 -- применяется для счетов просрочек тех бранчей, которые
 -- перешли в безбаланс , т.е. открыты счета, но утеряна кредитная история

 l_nd   cc_deal.Nd%type;
 l_S    accounts.ostc%type;
 l_K    int;
 l_fdat cc_lim.FDAT%type;
 l_s270 specparam.S270%type;
begin
  for k in (select * from accounts
            where nbs like p_NBS
              and ostc<0
              and ostc=ostb
 --and acc = 103582
              and branch like p_Branch ||'%')
  loop
    select nvl(max(nd),0) into l_ND from nd_acc where acc=k.ACC;

    If l_nd = 0 then GOTO nexrec; end if;

    If gl.bdate - k.daos  > 180 then
       update specparam
       set s270 = null
       where acc in (select a.acc
                      from accounts a, nd_acc n
                      where n.nd = l_ND and
                            n.acc = a.acc);

       GOTO nexrec;
    end if;

    -------------------------------------
    l_k := 0; l_s := - k.ostc; l_fdat := gl.bdate;

    for g in (select * from cc_lim
              where nd=l_ND
                and sumg > 0
                and fdat< l_fdat
              order by fdat desc)
    loop
      If l_S - g.sumg >= 0 then l_k := l_k + ( l_fdat - g.fdat);
      else                      l_s270 :=  '07';  GOTO UPDATE_S270 ;
      end if;
      If l_k > 180         then l_s270 :=  '08';  GOTO UPDATE_S270 ;  end if;
    end loop;

  <<UPDATE_S270>> null;

    FOR z IN (select a.acc
              from accounts a, nd_acc n
              where n.nd = l_ND and
                    n.acc = a.acc and
                    a.nls like '2%' and
                    substr(a.nls, 4, 1) in ('7', '8', '9'))
    loop
        update specparam set s270 = l_s270 where acc=z.acc;
        if SQL%rowcount = 0 then
           insert into  specparam (acc,s270) values (z.acc, l_s270);
        end if;
    end loop;

    <<nexrec>> null;

  end loop;

end REV_S270;
/
show err;

PROMPT *** Create  grants  REV_S270 ***
grant EXECUTE                                                                on REV_S270        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on REV_S270        to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/REV_S270.sql =========*** End *** 
PROMPT ===================================================================================== 
