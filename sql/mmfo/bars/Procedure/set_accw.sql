

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SET_ACCW.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SET_ACCW ***

  CREATE OR REPLACE PROCEDURE BARS.SET_ACCW   (p_acc  number  ,  ----Счет        :  Приоритетный ключ поиска
            p_kv   number  ,  --\             :  Альтернативный ключ поиска
            p_nls  varchar2,  --/
            p_PARID  number,  ---Доп.реквизит :  Приоритетный ключ поиска
            p_tag  varchar2,  ---             :   Альтернативный ключ поиска
            p_dat  date    ,  ---дата Применения
            p_val varchar2    -- Значение доп.рекв
           )  is
--Устанавливает значение доп.рекв счета с датой начала действия
   WW1 accountsp%rowtype;
begin
   If NVL(p_acc,0) <= 0 and p_kv >0 and length(p_nls) > 0 then
      begin select acc  into WW1.acc   from accounts where kv = p_kv and nls = p_nls;
      EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20000, 'НЕ знайдено РАХ для дод/рекв '|| p_kv ||'/'||p_nls );
      end;
   else                     WW1.acc   := p_acc   ;
   end if;

   If NVL(p_PARID,0) <= 0 and           length(p_tag) > 0 then
      begin select SPID into WW1.PARID from SPARAM_LIST where tag = p_tag ;
      EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20000, 'НЕ знайдено ТЕГ для дод/рекв '|| p_tag );
      end;
   else                     WW1.PARID := p_PARID ;
   end if;

   WW1.dat1 := Nvl( p_dat, gl.bdate);
   update ACCOUNTSPV set val = p_val where acc = WW1.acc and PARID = WW1.PARID and  dat1 = WW1.dat1;
   if SQL%rowcount = 0 then insert into ACCOUNTSPV ( ACC, DAT1, PARID, VAL ) values ( WW1.acc, WW1.dat1, WW1.PARID, p_val ); end if;

end SET_ACCW;
/
show err;

PROMPT *** Create  grants  SET_ACCW ***
grant EXECUTE                                                                on SET_ACCW        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SET_ACCW        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SET_ACCW.sql =========*** End *** 
PROMPT ===================================================================================== 
