

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GETXRATETIC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GETXRATETIC ***

  CREATE OR REPLACE PROCEDURE BARS.GETXRATETIC 
( rat_o OUT NUMBER,     -- xrato
  rat_b OUT NUMBER,     -- xratb
  rat_s OUT NUMBER,     -- xrats
  kv1_      NUMBER,     -- cur1
  kv2_      NUMBER,     -- cur2
  dat_      DATE DEFAULT NULL ) IS

-- процедура переопределения кросс-курсов пок-прод валют
-- для печати тикетов

   l_kv   tabval.kv%type;
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

   end if;

   RETURN;

END GetXRateTic;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GETXRATETIC.sql =========*** End *
PROMPT ===================================================================================== 
