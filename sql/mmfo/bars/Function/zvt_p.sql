
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/zvt_p.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.ZVT_P (DAT_ date)    return number is
 -- определение суммы оборотов техн.переоценки в целом по МФО по фин.учету
 n_  number;
begin

 select sum(dos) into n_
 from ( select sum(s.dos) DOS from saldoa s, accounts a
        where  s.acc=a.acc and a.kv =980 and a.nbs not like '8%' and s.fdat=dat_
 union all
        select sum(s.dos) DOS from saldob s, accounts a
        where  s.acc=a.acc and a.kv<>980 and a.nbs not like '8%' and s.fdat=dat_
       );
  return n_ ;

end ZVT_P ;
/
 show err;
 
PROMPT *** Create  grants  ZVT_P ***
grant EXECUTE                                                                on ZVT_P           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ZVT_P           to RPBN001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/zvt_p.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 