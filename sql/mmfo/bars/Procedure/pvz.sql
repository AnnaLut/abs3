

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PVZ.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PVZ ***

  CREATE OR REPLACE PROCEDURE BARS.PVZ 
 (p_nd    IN  number  ,          --:A(SEM=Реф_КД,TYPE=N)
  P_DAT01 IN  date default null --:D(SEM=Зв_дата_01,TYPE=D)
  ) is

  dat01_     date   ;
  PVZ_       nbu23_rez.pvz%type;
  OBESP_     number ; -- обеспечение для включения в потоки по рын.стоимости, уже умноженное на коеф ликвидности
  wdate_     cc_deal.wdate%type; 
  l_DAY_IMP  int    ; -- ПЛАНОВОЕ КОЛИЧЕСТВО ДНЕЙ ДЛЯ РЕАЛИЗАЦИИ ЗАЛОГА ЭТОГО ВИДА 
  fdat_      date   ; -- дата в поторе для залога
  k180   int := 180 ; -- ПЛАНОВОЕ КОЛИЧЕСТВО ДНЕЙ ДЛЯ РЕАЛИЗАЦИИ ЗАЛОГА любого ВИДА - по умолчанию = 180 дней
BEGIN

 If p_ND is null then  RETURN; end if;
 -------------------------------------
 -- по умолчанию делается отчет за 30-11-2012 (остатки) -- на 01-12-2012
 DAT01_ := NVL(p_DAT01,to_date('01-01-2013','dd-mm-yyyy'));  -- 01 число отч мес

 FOR k IN (SELECT rowid RI, zal, nd, wdate, irr, acc, id FROM nbu23_rez WHERE fdat = dat01_ 
--and id like 'CCK2%' 
and pvz is null and p_nd in (0, nd) and zal>0 
)

 loop
    -- справедливая стоимость залога = ликвидной сумме
    PVZ_      := k.zal  ;
    wdate_    := k.wdate;
    l_DAY_IMP := null   ;
    fdat_     := null   ;

    IF k.ID like 'CCK2%' then 

       if wdate_ is null  then
          begin
            select wdate into wdate_ from cc_deal where nd=k.nd;
          EXCEPTION WHEN NO_DATA_FOUND THEN wdate_ := dat01_-1;
          end;
       end if;

       --справедливая стотмость залога  по эф.ставке
       If k.IRR >0  then

          If wdate_ < dat01_ then 
             l_DAY_IMP  := 1;
          else 
             begin
               SELECT nvl(DAY_IMP,k180) INTO    l_DAY_IMP FROM TMP_REZ_OBESP23  where DAT = DAT01_ and accs=K.acc and rownum =1 ;
             EXCEPTION WHEN NO_DATA_FOUND THEN  l_DAY_IMP  := k180;
             END;
          end if;

          fdat_ := greatest( nvl( WDATE_, dat01_) , dat01_) + l_DAY_IMP ;
          PVZ_  := Round(PVZ_ / power (  (1+ k.IRR/100 ), (fdat_ - DAT01_ )/365 ) ,2);
        end if;

    end if;

    update  nbu23_rez set pvz =  PVZ_, wdate = wdate_ where rowid=k.RI;

 END LOOP; -- k
 commit;
end PVZ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PVZ.sql =========*** End *** =====
PROMPT ===================================================================================== 
