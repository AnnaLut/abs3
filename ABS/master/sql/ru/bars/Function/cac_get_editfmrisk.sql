
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/cac_get_editfmrisk.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CAC_GET_EDITFMRISK (p_userid number) return number
is
  l_edit   number := 0;
  l_fmarms varchar2(100);
  l_count  number := 0;
begin
   begin
      l_fmarms := trim(getglobaloption('FM_ARMS'));
      if l_fmarms is not null then
         begin
            execute immediate
            'select count(*) from applist_staff ' ||
            ' where id = ' || to_char(p_userid) ||
            '   and codeapp in (' || l_fmarms || ')' ||
            '   and nvl(approve,0) = 1' into l_count;
         exception when others then l_count := 0;
         end;
         if l_count = 0 then
            l_edit := 0;
         else
            l_edit := 1;
         end if;
      end if;
   exception when no_data_found then
      l_edit := 0;
   end;
   return l_edit;
end;
/
 show err;
 
PROMPT *** Create  grants  CAC_GET_EDITFMRISK ***
grant EXECUTE                                                                on CAC_GET_EDITFMRISK to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CAC_GET_EDITFMRISK to CUST001;
grant EXECUTE                                                                on CAC_GET_EDITFMRISK to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/cac_get_editfmrisk.sql =========***
 PROMPT ===================================================================================== 
 