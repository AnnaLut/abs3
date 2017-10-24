
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/glb_bankdate.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GLB_BANKDATE 
return date result_cache relies_on(params$global, params$base) is
  l_glbmfo   banks$base.mfo%type;
  l_bankdate date;
begin
  --
  -- возвращает банковскую дату головного банка
  --
  select val into l_glbmfo from params$global
  where par='GLB-MFO';
  select to_date(val,'MM/DD/YYYY') into l_bankdate from params$base
  where kf=l_glbmfo and par='BANKDATE';
  return l_bankdate;
end; 
/
 show err;
 
PROMPT *** Create  grants  GLB_BANKDATE ***
grant EXECUTE                                                                on GLB_BANKDATE    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GLB_BANKDATE    to START1;
grant EXECUTE                                                                on GLB_BANKDATE    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/glb_bankdate.sql =========*** End *
 PROMPT ===================================================================================== 
 