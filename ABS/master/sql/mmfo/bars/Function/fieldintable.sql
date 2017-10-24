
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fieldintable.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FIELDINTABLE (
  fld_  varchar2,
  tab_  varchar2
) return number -- ���������� 1 (���� ���� � �������) ��� 0 (���)
is
begin
  begin
    execute immediate 'select to_char('||fld_||')
                       from   '||tab_||'
                       where  rownum<2';
    return 1;
  exception when others then
    return 0;
  end;
end;
/
 show err;
 
PROMPT *** Create  grants  FIELDINTABLE ***
grant EXECUTE                                                                on FIELDINTABLE    to ABS_ADMIN;
grant EXECUTE                                                                on FIELDINTABLE    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fieldintable.sql =========*** End *
 PROMPT ===================================================================================== 
 