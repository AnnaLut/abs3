

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/AGG_02.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure AGG_02 ***

  CREATE OR REPLACE PROCEDURE BARS.AGG_02 ( p_MM_YYYY varchar2 ) is
 --процедура накоплени€ мес€чных снимков за истекший отчетный мес€ц в период первых 10 дней следующего
 DAT31_ date;
 DAT01_ date; --первое число отчетного мес.
 Fdat_  date;
 nTmp_  int;
/* Ќапример. gl.BDATE  = 05.12.2013
             p_MM_YYYY =    11.2013 -- отчетный  период
             DAT01_    = 01.11.2013 -- первый    день отчетного периода
             DAT31_    = 30.11.2013 -- последний день отчетного периода
*/

begin

  tuda;
  begin
    nTmp_ := length( p_MM_YYYY) ;
    If    nTmp_ = 5 then dat01_ := to_date ( '01-' || p_MM_YYYY ,'dd-mm-yy'   );
    ElsIf nTmp_ = 7 then dat01_ := to_date ( '01-' || p_MM_YYYY ,'dd-mm-yyyy' );
    Else                 dat01_ := to_date ( '01-' || p_MM_YYYY               );
    end if;
  exception when others then raise_application_error(-20100,'\8999 ‘ормат зв.перiоду повинен бути: MM-20YY або MM-YY або MON-YY');
  end ;

  DAT31_ :=  add_months( Dat01_, 1 ) - 1;  -- последний кал.день пред мес€ца

  If to_number ( to_char(gl.bdate,'DD') ) < 3  then -- тллько в первые дни нового мес
      -- ƒл€ страховки  перенакопим последний 2 кал.дн€
      Fdat_ := DAT31_;
      begin
         select 1 into nTmp_ from fdat where fdat = Fdat_; -- если посл.день был вых.
      EXCEPTION WHEN NO_DATA_FOUND THEN
         bars_accm_sync.sync_snap('BALANCE', Fdat_, 0);
         commit;
         Fdat_ := DAT31_ - 1;
         begin
            select 1 into nTmp_ from fdat where fdat = Fdat_; -- если пред.посл. и посл.день были выходными.
         EXCEPTION WHEN NO_DATA_FOUND THEN
            bars_accm_sync.sync_snap('BALANCE', Fdat_, 0);
            commit;
         end;
      end;
  end if;
  PUL.Set_Mas_Ini       ( 'MONBAL', '1' , 'ћќ∆Ќќ формировать мес.снимок' );
  bars_accm_sync.sync_AGG('MONBAL', DAT01_, 0);
  commit;


end AGG_02 ;
/
show err;

PROMPT *** Create  grants  AGG_02 ***
grant EXECUTE                                                                on AGG_02          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on AGG_02          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/AGG_02.sql =========*** End *** ==
PROMPT ===================================================================================== 
