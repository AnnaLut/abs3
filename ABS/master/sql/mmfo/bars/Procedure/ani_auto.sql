

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ANI_AUTO.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ANI_AUTO ***

  CREATE OR REPLACE PROCEDURE BARS.ANI_AUTO (p_Reg int, p_dat date DEFAULT null  )  IS

  -- 14.11.2016 Sta  Изменено для ММФО
  -- процедура автоматической подготовки информации для печати управленческих
  -- отчетов в бранчах, в. т.ч. на ВЕБ
  YYYY_MM_ char(7);
  dat_ date;
begin

  dat_:= NVL( p_dat, trunc (sysdate) );

--EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_ANI';
--tuda;
  delete from TMP_ANI where  BRANCH like '/'|| gl.aMfo||'/%'; --
  -------- Бюджет за прошлый звытний мic з КОР.ОБ по бранчам уровня-2
  YYYY_MM_ := to_char( add_months ( Dat_, -1 ), 'yyyy-MM' );
  ANI4_bU_ex (1, 2, YYYY_MM_, DAT_ );
  insert into tmp_ani ( YYYY_MM, DAT, TE, MO, BRANCH,ID, n1,n2,n3,n4, n5, n6)
  select YYYY_MM_, DAT_, 1,2, substr(branch,1,15), id ,
         sum(d6)/100, sum(d7)/100, sum(s6)/100, sum(s7)/100,
         sum(k6)/100, sum(k7)/100
  from TEST_ANI4_bu  group by substr(branch,1,15), id ;
  commit;
  -------- Бюджет за прошлый день по бранчам уровня-2
  YYYY_MM_ := to_char(  Dat_, 'yyyy-MM' );
  ANI4_bU_ex (2, 2, YYYY_MM_, DAT_ );
  insert into tmp_ani (YYYY_MM, dat,TE, Mo, BRANCH,ID, n1,n2,n3,n4, n5, n6)
  select YYYY_MM_,DAT_, 2,2, substr(branch,1,15), id ,
         sum(d6)/100, sum(d7)/100, sum(s6)/100, sum(s7)/100,
         sum(k6)/100, sum(k7)/100
  from TEST_ANI4_bu  group by substr(branch,1,15), id ;
  commit;

end ANI_auto;
/
show err;

PROMPT *** Create  grants  ANI_AUTO ***
grant EXECUTE                                                                on ANI_AUTO        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ANI_AUTO        to START1;
grant EXECUTE                                                                on ANI_AUTO        to TECH005;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ANI_AUTO.sql =========*** End *** 
PROMPT ===================================================================================== 
