 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** = Scripts /Sql/BARS/function/f_zvt_get_struct_name.sql =*** Run *** ====
 PROMPT ===================================================================================== 
 
create or replace function f_zvt_get_struct_name(l_sector varchar2, l_team varchar2, l_division varchar2, l_department varchar2) return varchar2 is
  FunctionResult varchar2(255);
begin
  select name into FunctionResult from (select replace(to_char(nvl(department_id,'00'),'09'),' ','')||'000000' as code, name  from zvt_department dep
union all
select '00'||replace(to_char(nvl(div.division_id,'00'),'09'),' ','')||'0000' as code, name  from zvt_division div
union all
select '0000'||replace(to_char(nvl(t.team_id,'00'),'09'),' ','')||'00' as code, name  from zvt_team t
union all
select '000000'||replace(to_char(nvl(s.sector_id,'00'),'09'),' ','') as code, name  from zvt_sector s 
union all
select '99999999' code, 'Всі структурні підрозділи' as name from dual
order by code ) tab
where (case when l_sector != '%' and code = '000000'||replace(to_char(l_sector,'09'),' ','')
            then 1
            when l_team != '%' and code = '0000'||replace(to_char(l_team,'09'),' ','')||'00'
            then 1
            when l_division != '%' and code = '00'||replace(to_char(l_division,'09'),' ','')||'0000'
            then 1
            when l_department != '%' and code = replace(to_char(l_department,'09'),' ','')||'000000'
            then 1
            else 0
            end =1
        or code = '99999999') and rownum = 1;
  return(FunctionResult);
end f_zvt_get_struct_name;
/
grant execute on BARS.f_zvt_get_struct_name to BARS_ACCESS_DEFROLE;
grant execute on BARS.f_zvt_get_struct_name to WR_REFREAD;

 show err;

