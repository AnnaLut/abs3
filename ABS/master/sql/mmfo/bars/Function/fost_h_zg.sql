
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fost_h_zg.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOST_H_ZG ( p_acc INTEGER, p_fdat DATE)
RETURN DECIMAL IS
l_dat    date;
l_s      number:=0;
dos_zg   number:=0;
kos_zg   number:=0;
BEGIN
-- вариант функции fost_h с учетом ZG
-- для отчета \BRS\SBM\NAL\6\1
-- если в конце года баланс одновременно и развернутый и свернутый
-- покажет всегда остатки без учета сворачивания (развернуто)
-- для остальных дней обычный исходящий остаток

 select max(fdat) into  l_dat  from fdat where fdat<=p_fdat;
 begin
  select nvl(sum(s),0)
    into dos_zg
    from opldok
   where fdat=l_dat
     and dk=0
     and tt like 'ZG%'
     and acc=p_acc;
   exception when no_data_found then dos_zg:=0;
 END;
 begin
  select nvl(sum(s),0)
    into kos_zg
    from opldok
   where fdat=l_dat
     and dk=1
     and tt like 'ZG%'
     and acc=p_acc;
   exception when no_data_found then kos_zg:=0;
 END;
 begin
   SELECT ostf-dos+kos+dos_zg-kos_zg INTO l_s FROM saldoa
   WHERE acc = p_acc and
        (acc,fdat) = (SELECT acc,max(fdat)  FROM saldoa
                      WHERE acc=p_acc AND fdat <=l_dat
                      GROUP BY acc );
    exception when NO_DATA_FOUND THEN l_s:=0;
 end ;
 RETURN l_s;
END FOST_H_ZG;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fost_h_zg.sql =========*** End *** 
 PROMPT ===================================================================================== 
 