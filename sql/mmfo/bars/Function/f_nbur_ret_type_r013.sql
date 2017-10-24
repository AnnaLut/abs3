
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nbur_ret_type_r013.sql =========*
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NBUR_RET_TYPE_R013 
( p_fdat           in     date,      -- ca?oia aaoa
  p_nbs            in     varchar2,  -- aaeainiaee ?aooiie
  p_r013           in     varchar2   -- ia?aiao? R013
) return number
-- iiaa?oa? 1, yeui ai 30 ai?a (oa aey ?aooie?a ia ia?aoiaaieo a?anioe?a)
--          2, a?euoa 30 ai?a
is
  l_ret   NUMBER;
begin
    select (case when lower(txt) like '%i?ioyaii%30%ai%' then 1
              when lower(txt) like '%iiiaa%30%ai%' then 2
              else 1
            end)
    into l_ret
    from kl_r013
    where trim(prem) = 'EA' and
          r020 = p_nbs and
          r013 = p_r013 and
          (d_close IS NULL OR d_close >= p_fdat);

    return l_ret;
exception
    when no_data_found then
         return 1;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nbur_ret_type_r013.sql =========*
 PROMPT ===================================================================================== 
 