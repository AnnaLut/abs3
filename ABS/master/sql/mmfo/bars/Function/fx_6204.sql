
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fx_6204.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FX_6204 ( p_tag1 number,  p_nbs  varchar2,  p_ob22 varchar2, p_dat1 date, p_dat2 date ) return NUMBER IS
  l_S number  := 0   ; l_z int := 0; d1a_ date ; d2a_ date ; d1b_ date ; d2b_ date ;  Sa_ number ;  Sb_ number ; ka_ int; kb_ int;
begin
   If p_ob22 = '**' then
-- Ãð.13 = A * (N-F) – B* (M-E)
      for x in (select * from fx_deal where swap_tag = p_tag1 order by deal_tag )
      loop
         If x.deal_tag =  p_tag1 then ka_  := x.kva ; SA_  := x.suma ; D1a_ := x.dat_a ;
                                      kb_  := x.kvb ; Sb_  := x.sumb ; d1b_ := x.dat_b ;
         else                                                          D2a_ := least ( x.dat_b, p_dat2) ;
                                                                       d2b_ := least ( x.dat_a, p_dat2) ;
         end if;
      end loop;
      If ka_ <> gl.baseval  then     l_S := l_s + ( gl.p_icurval(ka_, sa_, D2a_)  - gl.p_icurval(ka_, sa_, D1a_)  ) ;   end if;
      If kb_ <> gl.baseval  then     l_S := l_s - ( gl.p_icurval(kb_, sb_, D2b_)  - gl.p_icurval(kb_, sb_, D1b_)  ) ;   end if;
--logger.info ( ka_||','|| sa_ ||', '|| D2a_|| ','|| D1a_ || ' '||  kb_||','|| sb_ ||', '|| D2b_|| ','|| D1a_);
   Else
     select sum(decode (o.dk , 0,-1, +1) * o.s )   into l_S
     from fx_deal_ref r,
         (select ref,acc,dk,s from opldok   where fdat >= p_dat1 and fdat <= p_dat2 ) o,
         (select acc          from accounts where nbs = p_nbs    and ob22  = p_ob22 ) a,
         (select deal_tag     from fx_deal  where nvl(swap_tag,deal_tag)   = p_tag1 ) f
     where o.acc= a.acc and  o.ref = r.ref  and   r.deal_tag = f.deal_tag ;
   end if;
   Return nvl(l_s,0);
end fx_6204;
/
 show err;
 
PROMPT *** Create  grants  FX_6204 ***
grant EXECUTE                                                                on FX_6204         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FX_6204         to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fx_6204.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 