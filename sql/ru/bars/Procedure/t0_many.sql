

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/T0_MANY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure T0_MANY ***

  CREATE OR REPLACE PROCEDURE BARS.T0_MANY 
(p_dat date,  --отч.дата
 p_ID  number, -- юзер
 p_ND  number, -- реф КД
 ---
 p_31 int,
 p_mod int,
 p_dat_mod date,
 p_basey int DEFAULT 0
 ) is

/*
21-11-2012 если последний пл.день 01 число, то проц тек.мес - нет

02.11.2012 Счета  с типом SNO   в потоках учитывать по дню погашения счета (mdate).
           Если дата не заполнена тогда  брать ближайший платеж (как и по обычному счету SN ).

30.10.2012 Расчет процентов с учетом basey

          В первую пл.дату  из будущего ГПК в поток проценты берутся как сумма остатков на SN
          Дальше идет прогноз-расчет %

          --SPN относятся на отч.дату см.TK1_many
*/


--p_31 = 1 проц по пред мес
--p_31 = 0 проц по пред вунь,
-- p_mod = 1 - первый расчет процентов при построении потоков
-- p_mod = 2 - пересчет процентов при топтании потоков
-- p_dat_mod = дата, с которой топтать потоки


 l_IR       number ;
 l_fdat     date   := null;
 INT_31     number := 0 ; -- проц за прошлий месяц
 int_       number := 0 ;

 l_dat_beg date    ;  -- первая     будущая плат.дата
 l_dat_end date    ;  -- последняя  будущая плат.дата
 SN_ number        ;

begin


   -- начальные проценты = строго остаткам на счетах ( SN )  +  ( SNO c mdate=null)
   select -NVL(sum(s.ostf-s.dos+s.kos),0)
   into INT_31
   from saldoa s, nd_acc n, v_gl a
   where n.nd  = p_ND   and n.acc  = a.acc
   and ( a.tip ='SN '
         or
         a.tip ='SNO' and a.mdate is null
        )
   and a.acc = s.acc and s.fdat = (select max(fdat) from saldoa where acc=s.ACC and fdat < p_dat_mod );

   -- первая пл.дата
   select min(fdat)
   into l_dat_beg
   from test_many
   where fdat >= p_dat_mod
     and many  = 0
     and dat   = p_dat and  id=p_ID  and nd = p_ND ;


 --цикл по датам
 for k in (select * from test_many  where dat= p_dat and  id=p_ID  and nd =  p_ND ORDER BY fdat)
 loop

   If l_FDAT is null then
       -- первый вход = дате выдачи
       l_IR := k.IR;
       select max(fdat)   into l_dat_end   from test_many  where dat= p_dat and  id=p_ID  and nd = p_ND and many = 0 ;

   Else

       If k.fdat > p_dat_mod then
          -- НЕ первый вход = датам погашения
          INT_31 := INT_31 + ROUND( calp(-k.LIM1, l_IR, l_FDAT,k.FDAT-1, nvl(p_basey,0) ),  0) ;
       end if;

       --Сброс по 01 числам, если проц учтены
       If to_char(k.FDAT,'DD') ='01' then
          INT_ := INT_31 ;

          -- если последний пл.день 01 число, то проц тек.мес - нет
          If k.fdat = l_dat_end then
             int_31 := 0;
          end if;

       end if;

       If k.many = 0 then
          If p_mod = 1 then
             update test_many set p1_sn = int_ + decode(fdat,l_dat_end, int_31,0) where fdat = k.FDAT and dat= p_dat and  id=p_ID  and nd = p_ND;
          elsIf p_mod = 2 then
             update test_many set p2_sn = int_ + decode(fdat,l_dat_end, int_31,0) where fdat = k.FDAT and dat= p_dat and  id=p_ID  and nd = p_ND;
          end if;
          int_  :=0 ;
       end if;
   end if;

   If to_char(k.FDAT,'DD') ='01' then
       INT_31 := 0;
   end if;

   l_FDAT:= k.FDAT;

 end loop;

end t0_many;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/T0_MANY.sql =========*** End *** =
PROMPT ===================================================================================== 
