

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CENTR_KURS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CENTR_KURS ***

  CREATE OR REPLACE PROCEDURE BARS.CENTR_KURS 
( p_VDATE  IN  CUR_RATES$BASE.VDATE%Type ,
  p_KV     IN  varchar2 ,
  p_BSUM   IN  varchar2 ,
  p_RATE_O IN  varchar2 , -- резерв
  p_RATE_B IN  varchar2 ,
  p_RATE_S IN  varchar2 ,
  p_RET    OUT int
 ) IS

-- 14-02-2011 Sta При отсут какой-либо вал - выход нормальный p_RET = 0
-- 08-02-2011 Sta Прием ком.курсов в ОБ (без офф.)

  -------------------------------------
  l_KV     CUR_RATES$BASE.KV%Type     ;
  l_BSUM   CUR_RATES$BASE.BSUM%Type   ;
  l_RATE_O number                     ;
  l_RATE_B CUR_RATES$BASE.RATE_B%Type ;
  l_RATE_S CUR_RATES$BASE.RATE_S%Type ;
  -------------------------------------
  l_count int;
  K_ number := 1000000000;
begin
logger.info('centr_kurs -'|| p_VDATE || ',' ||  p_KV     || ','|| p_BSUM   ||','||
                      p_RATE_O|| ',' ||  p_RATE_B || ','|| p_RATE_S );

  p_RET    := 1;
  l_KV     := to_number( p_KV     ) ;
  begin
     select 1 into l_count from tabval where kv=l_kv;
  EXCEPTION  WHEN NO_DATA_FOUND THEN
     p_RET := 0;
     RETURN;
  end;

  l_BSUM   := to_number( p_BSUM   ) ;
--l_RATE_O := to_number( replace( p_RATE_O, ',', '.' ) ) ;

  l_RATE_O := round( l_BSUM  *gl.p_icurval( l_kv, k_, p_VDATE ) / k_,4) ;

  l_RATE_B := to_number( replace( p_RATE_B, ',', '.' ) ) ;
  l_RATE_S := to_number( replace( p_RATE_S, ',', '.' ) ) ;

  for k in (select * from branch where branch like '/' || gl.aMFO || '/%' )
  loop
     l_count  := 0;
     update cur_rates$base
        set rate_b = l_RATE_B * bsum/l_BSUM,
            rate_s = l_RATE_S * bsum/l_BSUM
      where kv     = l_KV
        and vdate  = p_VDATE
        and branch = k.branch ;

     l_count := sql%rowcount;

     if l_count = 0 then
        insert into cur_rates$base
           ( branch, vdate, kv, bsum, rate_o, rate_b, rate_s )
        values (k.branch, p_VDATE, l_KV, l_BSUM, l_RATE_O, l_RATE_B, l_RATE_S);
     end if;
  end loop;

  p_RET   := 0;
  RETURN  ;

end centr_kurs ;
/
show err;

PROMPT *** Create  grants  CENTR_KURS ***
grant EXECUTE                                                                on CENTR_KURS      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CENTR_KURS      to TECH005;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CENTR_KURS.sql =========*** End **
PROMPT ===================================================================================== 
