
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fostzn.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOSTZN 
(p_ACC  INT,
 p_DAT date, -- отчетная дата. т.е. дата, на которую надо взять остаток
 p_DDD DATE DEFAULT null -- НЕ используем . резерв пока   null
 ) RETURN DECIMAL IS

/*
26-10-2010 Особенности всех дат : 31, 01, . . ., 05,06, . . . , 15,16, . . ., 31
  была ерунда, только для 31 чисел

26.10.2010 Sta получения ост с учетос корр.оборотов.
  c NULL - умодч.значением
  намерена использовать ее в НБУ (в пакедже CP)
*/

  DD_ int;
  s_DAT date ; -- след.банк.дата

  DAT_01 date ;  -- дата начала поиска корр. >= 01 числа
  DAT_15 date ;  -- дата завершения посика корр = 15 число

  nn1_   DECIMAL := 0 ;
  nn2_   DECIMAL := 0 ;

BEGIN

  --Часть-1. Поиск натурального остатка на отч.дату
  BEGIN
    SELECT ostf-dos+kos   INTO nn1_   from saldoa
    WHERE acc=p_ACC AND FDAT=(select max(fdat) from saldoa where acc=p_ACC and fdat <= p_DAT ) ;
  EXCEPTION WHEN NO_DATA_FOUND THEN nn1_:=0;
  END;

  DD_ := to_number( to_char( p_DAT, 'DD' ) );

  If  DD_ < 15 then

     -- А) 01-14 это первые раб дни нов мес
     --    корр. в прошлом уже включены
     --  + м.б. в будущем
     DAT_01 := p_DAT + 1 ;

  ElsIf DD_ >= 15 and DD_ <= 25  then

     -- Б) 15-25  корр. искать не надо. Они уже включены
     RETURN nn1_ ;

  Else

     -- след.банк.дата
     select min(fdat) into  s_DAT from fdat where fdat > p_DAT ;

     If to_char( s_DAT, 'YYYYMM' ) = to_char( p_DAT, 'YYYYMM' ) then

        -- В) это обычные 26 27 28 29 30 числа, но не последние в мес
        --    корр. искать не надо.
        RETURN nn1_ ;

     Else

        -- Г) (26 27 28 29 30) 31 это последний раб день в мес.
        --   + корр. м.б. только в будущем
        DAT_01 := s_DAT;

     end if;

 end if;

 DAT_15 := trunc (  DAT_01,'MM') + 14;

  --Часть-2. Суммарный оборот по корр
  select Nvl( sum( o.S * decode (o.dk,0,-1,1) ),0 )  into nn2_  from opldok o
  where fdat >=  DAT_01 and FDAT <= DAT_15 and acc=p_ACC
    and exists (select 1 from oper where ref=o.REF and vob in (96,99) );

  nn1_ := nn1_ + nn2_;
  RETURN  nn1_;

END FOSTZn;
/
 show err;
 
PROMPT *** Create  grants  FOSTZN ***
grant EXECUTE                                                                on FOSTZN          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FOSTZN          to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fostzn.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 