
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_specparam.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_SPECPARAM ( p_tag varchar2, p_val varchar2, p_acc INTEGER, p_dat DATE )
return varchar2 is

/*

 ������� ����������� �������� ����.��������� �� ���� (��������� �� FSPEC)

 ������ 2.0 �� 08/02/2012

 ��� �� ���� � specparam_update - ������� ���� �������, �� ���������� �� �����������....
 ������ ���� � ���������� ��������������. ���� �� ������� ��� NULL, �� ���������� NULL.


*/

  l_val varchar2(5)  := null ;
  l_sql varchar2(1000);

begin

  if p_val is not null then return p_val;
  else

      --- SQL ��� ������ ������ ����.���. ----------
   /*
  ������ 1.0 �� 10/05/2011

 1) ������� ���� � specparam_update
 2) ���� �� ������� ��� NULL, �� � specparam
 3) ���� �� ������� ��� NULL, �� ���������� NULL

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
 