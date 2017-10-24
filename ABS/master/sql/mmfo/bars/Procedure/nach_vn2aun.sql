

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NACH_VN2AUN.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NACH_VN2AUN ***

  CREATE OR REPLACE PROCEDURE BARS.NACH_VN2AUN (p_MFO varchar2, p_DAT date) is

/*
 Sta 17-01-2011  ‘ормирование SALDOA за 12 пред мес.
*/
----------
 l_kv    accounts.kv%type  ;
 l_ostc  accounts.ostc%type;
 l_dos   accounts.dos%type ;
 l_kos   accounts.kos%type ;
 l_nls   accounts.nls%type ;
 l_dat   accounts.dapp%type;
 dat01_  date ;
 s_DAT01  varchar2(50) ;
 s_DAT  varchar2(50) := 'to_date('''|| to_char(p_dat,'dd.mm.yyyy') ||''',''dd.mm.yyyy'')';
begin

 tuda;


 --dat01_  := add_months (p_DAT ,-12); -- за пред 12 мес€цев.

 dat01_  := trunc( p_DAT,'YYYY') ;  -- от 01.01.“≈ .год
  s_DAT01 :=  'to_date('''|| to_char( dat01_ ,'dd.mm.yyyy') ||''',''dd.mm.yyyy'')';

 logger.info ( 'NACH_VN2a : p_MFO = ' || p_MFO || ' , s_DAT = ' ||  s_DAT || ' , s_DAT01 = ' || s_DAT01 );

 -- есть ли баланс по accounts
 begin
    select kv, s into l_kv, l_ostc  from
      (select kv,sum(ostc) s from accounts
       where nls not like '8%' group by kv having sum(ostc)<>0)
    where rownum =1 ;
    Raise_application_error(-20100, '     NACH_VN2a: ЌеЅаланс по accounts ' || l_KV || ' '|| l_ostc );
 EXCEPTION WHEN NO_DATA_FOUND THEN null;
 end;

 EXECUTE IMMEDIATE
'declare
    l_va  S6_UN_OBNLS.i_va%type ;  l_da  S6_UN_OBNLS.da%type   ;
 begin
    -- есть ли оборотн?й баланс по S6_UN_OBNLS
    select kv, da into l_va, l_da
    from (select i_va KV, da, sum(dos_v) DOS, sum(kos_v) KOS
          from S6_UN_OBNLS
          where NLS  not like ''8%''
            and da <= ' || s_DAT  || '
            and da > ' ||  s_DAT01 || '
            and  ( nvl(dos_v,0) + nvl(kos_v,0) ) <>0
          group by i_va, da
          having sum(dos_v) <> sum(kos_v) )
    where rownum =1 ;
    Raise_application_error(-20100,
       ''     NACH_VN2: ЌеЅаланс по S6_UN_OBNLS '' || l_Va || '' ''|| l_da );
 EXCEPTION WHEN NO_DATA_FOUND THEN null;
 end;
 ';

 EXECUTE IMMEDIATE
'declare
    l_va  S6_UN_OBNLS.i_va%type ;  l_nls  S6_UN_OBNLS.nls%type   ; l_da  S6_UN_OBNLS.da%type   ;
 begin
    select i_va, nls, da
    into l_va, l_nls , l_da
    from S6_UN_OBNLS s
    where  s.da <= '|| s_DAT || '
      and da > ' ||  s_DAT01 || '
      and  ( nvl(dos_v,0) + nvl(kos_v,0) ) <>0
      and  not exists
       (select 1 from accounts a where trim(s.nls) = a.nls and s.i_va = a.kv )
      and rownum =1 ;
    Raise_application_error(-20100,
       ''     NACH_VN2: Ќет сч в accounts '' || l_Va || '' '' || l_nls || '' '' || l_da );
 EXCEPTION WHEN NO_DATA_FOUND THEN null;
 end;
 ';

-- очистьить saldoa
 delete from saldoa;
 commit;

 -- наполнить saldoa оборотами
 EXECUTE IMMEDIATE
'insert into saldoa (acc, fdat, ostf, dos,kos)
 select a.acc, s.da, 0, s.dos_v*100, s.kos_v*100
 from accounts a, S6_UN_OBNLS s
 where trim(s.nls) = a.nls and s.i_va = a.kv
   and (nvl(dos_v,0) + nvl(kos_v,0) ) <>0
  ';
 commit;

 insert into saldoa (acc, fdat,  ostf, dos,kos)
 select acc, daT01_, 0,0,0 from accounts A;
 commit;

 -- расчитать остатки в saldoa
 update saldoa t  set
  t.pdat = (select max(fdat) from saldoa   where acc=t.acc and fdat < t.fdat),
  t.ostf = nvl( (select ostc from accounts where acc=t.acc ) , 0 )
           -
           nvl( (select sum(kos-dos) from saldoa
                 where acc=t.acc and fdat>=t.fdat ) , 0 );

 commit;

 insert into fdat (fdat)
 select distinct fdat from saldoa where (dos+kos)>0 and fdat not in
        (select fdat from fdat);
 commit;

 -- есть ли баланс по saldoa
 begin
    select kv, s into l_kv, l_ostc   from
      (select kv,sum(fost(acc,p_DAT)) s from accounts
       where nls not like '8%' group by kv having sum(fost(acc,p_DAT))<>0)
    where rownum =1 ;
    Raise_application_error(-20100,
       '     NACH_VN2: ЌеЅаланс по saldoa ' || l_KV || ' '||l_ostc );
 EXCEPTION WHEN NO_DATA_FOUND THEN null;
 end;

/* какие счета не сход€тс€

select acc, kv, nls, nbs, daos, dazs, ostc, fost (acc,gl.bd) OST
from accounts where nls not like '8%' and ostc<> fost (acc, p_DAT);

*/

 suda;

end NACH_VN2aun;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NACH_VN2AUN.sql =========*** End *
PROMPT ===================================================================================== 
