
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_accw.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_ACCW   (p_acc  number  , ----Счет        :  Приоритетный ключ поиска
            p_kv   number  , --\             :  Альтернативный ключ поиска
            p_nls  varchar2, --/
            p_PARID  number, ---Доп.реквизит :  Приоритетный ключ поиска
            p_tag  varchar2, ---             :   Альтернативный ключ поиска
            p_dat  date      ---Отч.дата
          ) return accountsp.val%type  is
-- Возвращает значение доп.рекв счета, которое актуально на отч.дату
   WW1 accountsp%rowtype;
begin
  begin
    If NVL(p_acc,0) <= 0 and p_kv >0 and length(p_nls) > 0 then
       select acc  into WW1.acc   from accounts where kv = p_kv and nls = p_nls;
    else                WW1.acc   := p_acc   ;
    end if;

    If NVL(p_PARID,0) <= 0 and           length(p_tag) > 0 then
       select SPID into WW1.PARID from SPARAM_LIST where tag = p_tag ;
    else                WW1.PARID := p_PARID ;
    end if;

    WW1.dat1 := Nvl( p_dat, gl.bdate);

    select * into WW1 from accountsp where acc = WW1.acc and PARID = WW1.PARID and dat1 <= WW1.dat1 and WW1.dat1 <= dat2;

  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end ;

  RETURN WW1.val;

end GET_ACCW;
/
 show err;
 
PROMPT *** Create  grants  GET_ACCW ***
grant EXECUTE                                                                on GET_ACCW        to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_accw.sql =========*** End *** =
 PROMPT ===================================================================================== 
 