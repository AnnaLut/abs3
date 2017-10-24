

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GETXRATE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GETXRATE ***

  CREATE OR REPLACE PROCEDURE BARS.GETXRATE 
( rat_o OUT NUMBER,     -- xrato
  rat_b OUT NUMBER,     -- xratb
  rat_s OUT NUMBER,     -- xrats
  kv1_      NUMBER,     -- cur1
  kv2_      NUMBER,     -- cur2
  dat_      DATE DEFAULT NULL ) IS

--26-05-2011 Наконечний  виключив контроль комерційних курсів для металів
--17-12-2010 Sta + Наконечный  реакция на VDAT

--процедура переопределения кросс-курсов пок-прод валют

-- Описать в ini-файле наряду с кассой
--[AnyParameters]
--KOD_TOBO=100375 ; Псевдо-МФО (он же код) ТОБО
--CASH=100238037 ; счет кассы в этом ТОБО

--по глобальному параметру ищет имя процедуры получения кросс-курса
--PARAMS.PAR=   'XRATFUN'
--PARAMS.VAL=  'BARS.GetXRate' -- или другое
--PARAMS.comm= 'Имя функции вычисления КРОС-КУРСА (по ум. из CUR_RATES)'
--Если параметр там не описан -
--работаем по-старому,  Т.е. имя этой процедуры = GL.x_rat
--Сама же процедура Bars.GetXRate страхуется от ошибок той же GL.x_rat
-----------------------------------------------------------
   l_kv   tabval.kv%type;
   ern    CONSTANT POSITIVE := 103;
   erm    VARCHAR2(80);
   err    EXCEPTION;
BEGIN
   -- ВСЕ три Курса ма максимально известную дату.
   -- кот м.б. и меньше текущей
   GL.x_rat ( rat_o, rat_b, rat_s,  kv1_, kv2_, dat_ );

   -- но для пок/продажи (кроме конверсии)
   -- нам надо именно Непустой коммерческий по СОВПАДЕНИЮ дат
   if  kv1_ <> kv2_ and gl.baseval in ( kv1_,kv2_ ) then

       If kv1_ = gl.baseval then l_kv := kv2_;
       else                      l_kv := kv1_;
       end if;

       begin
         select nvl(RATE_B/BSUM,0),  nvl(RATE_S/BSUM,0)
         into   rat_b,  rat_s
         from   cur_rates
         where   kv= l_kv and  VDATE = dat_;
       EXCEPTION when NO_DATA_FOUND THEN rat_b:=0; rat_s:=0;
       end;

       if l_kv not in (959, 961, 962) and (rat_b=0 or rat_s=0) then
          erm := '9002 - Вiдсутнiй комерцiйний КУРС вал ' || l_kv||
                 ' для бранча '|| SYS_CONTEXT('bars_context','user_branch');
          RAISE err;
       end if;

   end if;

   RETURN;

EXCEPTION
   WHEN err THEN
      raise_application_error(-(20000+ern),'\' ||erm,TRUE);
   WHEN OTHERS THEN
      raise_application_error(-(20000+ern),SQLERRM,TRUE);
END GetXRate;
/
show err;

PROMPT *** Create  grants  GETXRATE ***
grant EXECUTE                                                                on GETXRATE        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GETXRATE        to PYOD001;
grant EXECUTE                                                                on GETXRATE        to RCC_DEAL;
grant EXECUTE                                                                on GETXRATE        to WR_ALL_RIGHTS;
grant EXECUTE                                                                on GETXRATE        to WR_DOCHAND;
grant EXECUTE                                                                on GETXRATE        to WR_DOC_INPUT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GETXRATE.sql =========*** End *** 
PROMPT ===================================================================================== 
