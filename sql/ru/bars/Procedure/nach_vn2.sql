

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NACH_VN2.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NACH_VN2 ***

  CREATE OR REPLACE PROCEDURE BARS.NACH_VN2 ( p_MFO varchar2, p_DAT date) is

/*
  10-04-2011 Вернула дин SQL/ 31.12.2009 = константа
  22-02-2011 Sta    Формирование saldoA + saldoB
*/

  l_kv   accounts.kv%type   ;
  l_ostc accounts.ostc%type ;
  fdat_  saldob.fdat%type   ;
  ostf_  saldob.ostf%type   ;
  dat31_ date := to_date ( '31.12.2009', 'dd.mm.yyyy' );

begin

  ---- ==== 1 ) Подготовка =====

  --Исходная таблица S6_OBNLS, которую Боря импортит из СКАРБА.
  --Умножить все суммы на 100.  S6_OBNLS не д.б. копеек !!

execute immediate '
  declare
    nTmp_   int;
  begin
    select 1 into nTmp_ from s6_obnls
    where (mod(dos,1)   <> 0 or mod(kos,1)   <> 0 or
           mod(dos_v,1) <> 0 or mod(kos_v,1) <> 0 )
      and rownum=1;
    Update S6_OBNLS set dos_v = dos_v * 100, kos_v = kos_v * 100,
                        dos   = dos   * 100, kos   = kos   * 100;
    Update S6_OBNLS set dos_v = dos,         kos_v = kos   where i_va=980;
  EXCEPTION WHEN NO_DATA_FOUND THEN   null;
  end ; ' ;

  tuda;

  for k in (select * from oper where sos=5)
  loop
    ful_bak(k.ref);
  end loop;

  ---- ==== 2 ) SALDOA =====

  --удалить из SALDOA плохую истоию
  delete from saldoa ;
  commit;

  -- наполнить saldoa оборотами
  execute immediate '
  insert into saldoa (acc, fdat, ostf, dos,kos)
  select a.acc, s.da, 0, s.dos_v, s.kos_v
  from accounts a, S6_OBNLS s
  where trim(s.nls) = substr(a.nls,1,4) || substr(a.nls,6,9)
    and s.i_va = a.kv
     and ( nvl(dos_v,0) + nvl(kos_v,0) ) <>0 ' ;

  commit;

  -- расчитать остатки в saldoa
  update saldoa t  set
   t.pdat = (select max(fdat) from saldoa   where acc=t.acc and fdat < t.fdat),
   t.ostf = nvl( (select ostc from accounts where acc=t.acc ) , 0 )
            -
            nvl( (select sum(kos-dos) from saldoa
                  where acc=t.acc and fdat>=t.fdat ) , 0 );

  commit;

  -- добавить вх.остатки до 31 числа по тем счетам. по кот было движение

execute immediate '
  insert into saldoa (acc, fdat, ostf, dos,kos)
  select a.acc, to_date(''31-12-2009'',''dd.mm.yyyy'' ) , a.ostc -sum(s.kos_v) + sum(s.dos_v), 0, 0
  from accounts a, S6_OBNLS s
  where trim(s.nls) = substr(a.nls,1,4) || substr(a.nls,6,9)
    and s.i_va = a.kv
    and s.da >  to_date(''31-12-2009'',''dd.mm.yyyy'' )
  group by a.acc,a.ostc
  having  (a.ostc -sum(s.kos_v) + sum(s.dos_v) ) <>0  ' ;

  commit;

  -- добавить вх.остатки до 31 числа по тем счетам. по кот НЕ было движения
  execute immediate '
  insert into saldoa (acc, fdat, ostf, dos,kos)
  select a.acc,   to_date(''31-12-2009'',''dd.mm.yyyy'' ) , a.ostc , 0, 0
  from accounts a
  where a.ostc<> 0
    and not exists (select 1 from S6_OBNLS s
                    where trim(s.nls) = substr(a.nls,1,4) || substr(a.nls,6,9)
                      and s.i_va = a.kv
                      and s.da >   to_date(''31-12-2009'',''dd.mm.yyyy'' )  ) ' ;
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
       '     NACH_VN2: НеБаланс по saldoa ' || l_KV || ' '||l_ostc );
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end;

/* какие счета не сходятся

select acc, kv, nls, nbs, daos, dazs, ostc, fost (acc,gl.bd) OST
from accounts where nls not like '8%' and ostc<> fost (acc, p_DAT);

*/

  tuda;

  -- Переоценка
  for k in ( select acc
             from accounts
             where nls in
                 ( vkrzn(substr(gl.AMFO,1,5),'99000999999999'),  --- веш. 9000-9599
                   vkrzn(substr(gl.AMFO,1,5),'99100999999999'),  --- веш. 9600-9999
                   vkrzn(substr(gl.AMFO,1,5),'38000000000000'),  --- веш. 1000-7999
                   vkrzn(substr(gl.AMFO,1,5),'38010000000000')
                 )
              and daos > DAT31_
           )

  loop
     update accounts set daos = dat31_ where acc=k.acc;
  end loop;
  -------------------
--p_rev_ob( dat31_ );
  -------------------

  -- Вынести начальную разницу округлений  в 31 число
  for k in (select acc from accounts where nbs is null and nls like '3800%')
  loop
    select min(fdat) into fdat_ from saldob where acc =k.acc;
    If fdat_ > dat31_ then
       select ostf into ostf_ from saldoB where acc=k.acc and fdat=fdat_;
       if ostf_ <>0 then
          insert into saldoB (acc,fdat,ostf,dos,kos) values (k.acc,dat31_,ostf_,0,0);
       end if;
    end if ;
  end loop;

  commit;


 -- есть ли баланс по saldoB
 begin
    select kv, s into l_kv, l_ostc   from
      (select kv,sum(fostQ(acc,p_DAT)) s from accounts
       where nls not like '8%' group by kv having sum(fostQ(acc,p_DAT))<>0)
    where rownum =1 ;
    Raise_application_error(-20100,
       '     NACH_VN2: НеБаланс по saldoB ' || l_KV || ' '||l_ostc );
 EXCEPTION WHEN NO_DATA_FOUND THEN null;
 end;


end NACH_VN2;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NACH_VN2.sql =========*** End *** 
PROMPT ===================================================================================== 
