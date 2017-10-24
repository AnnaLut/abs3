

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_OTC_VE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_OTC_VE ***

  CREATE OR REPLACE PROCEDURE BARS.P_OTC_VE 
(p_DAT    DATE,         -- отчетная дата
 p_KODF   VARCHAR2      --код файла IS
 ) IS

   mfou_ varchar2(12);
   mfo_  varchar2(12);
   pr_   number;
   kodp_ varchar2(30);
   kodpN_ varchar2(30);

   XX_  char(2);
   X1_  char(2);
   X8_  char(8);
 begin

   mfo_ := gl.aMfo;
   BEGIN
      SELECT NVL(trim(mfou), mfo_)  INTO mfou_  FROM BANKS   WHERE mfo = mfo_;
   EXCEPTION WHEN NO_DATA_FOUND THEN mfou_ := mfo_;
   END;


-- по просьбе ОПЕРУ СБ для счетов тех.переоценки изменяем код валюты на 978
-- при отсутствии номинала для данной валюты с 01.03.2008

IF mfou_ <> '300465' OR P_DAT < to_date('01032008','ddmmyyyy') then
   RETURN;
end if;

-- для #?
If p_KODF <>'01' and p_kodf<>'02' THEN
   return;
end if;


for k in (select 1 BAL, nls, kv, kodp, znap from rnbu_trace
          where nls LIKE '3800_000000000%' and  kv not in (840,978,643)
          union all
          select 9,     nls, kv, kodp, znap   from rnbu_trace
          where nls LIKE '9910_001'       and kv<> 980
          order by 2,3,4
          )
loop

   XX_:= substr(k.kodp,1,2);

   -- для #01
   If p_KODF ='01' and XX_ <>'10'  and XX_ <> '20' THEN
      GOTO RecNext;
   end if;

   -- для #02
   If p_KODF ='02' and XX_ <>'10'  and XX_ <> '20'
--                   and XX_ <>'50'  and XX_ <> '60'
      THEN
      GOTO RecNext;
   end if;


   X1_:= substr(k.kodp,1,1)||'1';
   X8_:= substr(k.kodp,3,8);
LOGGER.INFO('HB -1 ' || K.nls || ',' || K.kv || ',' || K.kodp || ','|| K.znap );
LOGGER.INFO('HB -2 ' || X1_ || ',' || X8_ );

   -- если есть родной номинал,  ОК
   begin
      select 1 into pr_  from rnbu_trace
      where substr(kodp,1,2)=X1_ and substr(kodp,3,8)=X8_ and rownum=1;
LOGGER.INFO('HB -3 ok' );
      GOTO RecNext;
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
   end;

   If k.BAL = 1 then
      -- для баланса - заворачиваем всегда на 978
      kodp_:= substr(k.kodp,1,6) || '978' || substr(k.kodp,-1) ;
      update rnbu_trace set kodp=kodp_,comm='*'
       where nls=k.nls  and kv=k.kv AND KODP=K.KODP;
LOGGER.INFO('HB -4 '|| kodp_);
      GOTO RecNext;
   end if;

   -- для ВНЕбаланса
   begin
     --1) Если есть - переводим на др.бал счет в своей валюте
     select SUBSTR(kodp,1,1) || '0' || SUBSTR(KODP,3)
     into kodpN_
     from rnbu_trace
     where substr(kodp,1,3)=X1_||'9' and substr(kodp,7,3)=substr('00'||k.kv,-3)
       and znap >100  and rownum=1;

     update rnbu_trace set kodp=kodpN_,comm='*'
     where nls=k.nls and kv=k.kv AND KODP=K.KODP;
LOGGER.INFO('HB -5 '|| kodpn_);

     GOTO RecNext;
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
   end;

   <<RecNext>> null;
end loop;

END P_OTC_VE;
 
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_OTC_VE.sql =========*** End *** 
PROMPT ===================================================================================== 
