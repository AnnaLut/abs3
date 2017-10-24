
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/uniq_v2l.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.UNIQ_V2L (p_vl varchar2_list) return varchar2_list
is
  l_vl  varchar2_list;
begin
  select cast(collect(column_value) AS varchar2_list)
  into   l_vl
  from   (select distinct *
          from   table(p_vl));
  return l_vl;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/uniq_v2l.sql =========*** End *** =
 PROMPT ===================================================================================== 
 