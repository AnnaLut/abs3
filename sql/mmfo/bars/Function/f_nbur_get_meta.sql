
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nbur_get_meta.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NBUR_GET_META (p_ref in number, 
                                           p_fdat in date, 
                                           p_rnk in number, 
                                           p_sum in number,
                                           p_kv in number) return number deterministic 
is
   l_meta  number;
begin
    select max(meta)
    into l_meta
    from ZAYAVKA z
    where (z.vdate = p_fdat  and
           z.s2 = p_sum and
           z.kv2 = p_kv and
           z.rnk  = p_rnk
           or
           p_ref in (z.ref, z.ref_sps)
           )
           and z.dk = 2;
           
   return l_meta;                          
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nbur_get_meta.sql =========*** En
 PROMPT ===================================================================================== 
 