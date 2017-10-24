
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_rez_specparam.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_REZ_SPECPARAM ( p_tag varchar2, p_acc INTEGER, p_dat DATE, p_user INTEGER )
return varchar2 is

/*

 Функция определения значения спец.параметра на дату из резервов!!!!!

 Версия 1.0 от 23/05/2011

*/

  l_val varchar2(3)  := null ;
  l_sql varchar2(1000);

begin

  --- SQL для поиска любого спец.пар. ----------
  l_sql :=
  'select ' || p_tag || ' from tmp_rez_params
    where acc = :p_acc
      and dat = :p_dat  and id = :p_user' ;

  begin
    execute immediate l_sql into l_val using p_acc, p_dat, p_user;
  exception when no_data_found then null;
  end;

 return l_val;

end f_get_rez_specparam;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_rez_specparam.sql =========**
 PROMPT ===================================================================================== 
 