

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REVDAT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REVDAT ***

  CREATE OR REPLACE PROCEDURE BARS.P_REVDAT (p_date date default NULL, p_day int, p_sec int) IS
--   *****   Версия от 24/01-06   *****
--   Вызов процедур переоценки ВП и валютных счетов
--   за дату p_date со сдвигом на P_day
--   p_sec = 0/1 (не разрешено/разрешено) контроль на закрытую дату
dat_ DATE;
kv_  int;
zapret int;
 sErr_ varchar2(150);
 ern CONSTANT POSITIVE   := 208; err EXCEPTION; erm VARCHAR2(80);

BEGIN
   zapret := 1;
   kv_  := gl.baseval;
   dat_ := p_date;         -- из комплекса локальная банк. дата
   if p_date is NULL then
      dat_ := bankdate_g;  -- глобальная
   end if;
   if p_day < 0 then
   select CALC_PDAT(dat_) + p_day into dat_ from dual;
   end if;

 if P_sec = 0 then
    begin
    select 0 into zapret from fdat where fdat = dat_ and stat = 9;
    EXCEPTION WHEN NO_DATA_FOUND THEN zapret := 1;
    end;
        if zapret <> 1 then
        deb.trace( ern, 'Режим ',to_char(P_sec)||' Б.дат '||to_char(dat_)||' закрита!');
          erm := '7777 - Банк. дата '||to_char(dat_)||' закрита. ! Вихiд -> <Продовжити> - КОРЕКТНИЙ';
          RAISE err;
        end if;
   end if;

   FOR k IN (SELECT fdat FROM fdat WHERE fdat >= dat_)
   LOOP
   dbms_output.put_line('Переоценка ВП за '||k.fdat);
   gl.p_pvp(NULL,k.fdat);
   dbms_output.put_line('Переоценка остатков вал-х счетов за '||k.fdat);
   FOR c IN (SELECT kv FROM tabval WHERE kv <> kv_)
   LOOP
       p_rev(c.kv,k.fdat);
   END LOOP;
   end loop;
   COMMIT;

EXCEPTION
      WHEN err THEN
      raise_application_error(-(20000+ern),'\'||erm,TRUE);
      WHEN OTHERS THEN
      raise_application_error(-(20000+ern),SQLERRM,TRUE);

END P_RevDat;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REVDAT.sql =========*** End *** 
PROMPT ===================================================================================== 
