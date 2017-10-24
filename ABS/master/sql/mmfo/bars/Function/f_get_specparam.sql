
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_specparam.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_SPECPARAM ( p_tag varchar2, p_val varchar2, p_acc INTEGER, p_dat DATE )
return varchar2 is

/*

 Функция определения значения спец.параметра на дату (переделка со FSPEC)

 Версия 2.0 от 08/02/2012

 Уже не ищем в specparam_update - хорошая была хадумка, но отчетности не понравилось....
 Просто ищем в теперешних спецпараметрах. Если не найдено или NULL, то возвращаем NULL.


*/

  l_val varchar2(5)  := null ;
  l_sql varchar2(1000);

begin

  if p_val is not null then return p_val;
  else

      --- SQL для поиска любого спец.пар. ----------
   /*
  Версия 1.0 от 10/05/2011

 1) Сначала ищем в specparam_update
 2) если не найдено или NULL, то в specparam
 3) если не найдено или NULL, то возвращаем NULL

      l_sql :=
      'select ' || p_tag || ' from specparam_update u
        where u.acc = :p_acc
          and u.idupd =
                      (select max(idupd) from specparam_update
                        where ' || p_tag || ' is not NULL   and acc = u.acc
                          and fdat <= :p_dat)';

      begin
        execute immediate l_sql into l_val using p_acc, p_dat;
      exception when no_data_found then null;
      end;

      if l_val is null then  */
        l_sql := 'select ' || p_tag || ' from specparam where acc = :p_acc ';

        begin
          execute immediate l_sql into l_val using p_acc;
        exception when no_data_found then null;
        end;

      /*end if;*/

    return l_val;
 end if;

end f_get_specparam;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_specparam.sql =========*** En
 PROMPT ===================================================================================== 
 