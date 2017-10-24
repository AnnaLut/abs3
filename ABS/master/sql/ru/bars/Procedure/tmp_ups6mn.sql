

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/TMP_UPS6MN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure TMP_UPS6MN ***

  CREATE OR REPLACE PROCEDURE BARS.TMP_UPS6MN 
  (p_nls_fil  IN varchar2,
   p_kv       IN number  ,
   p_nls_bars IN varchar2,
   p_filial   IN varchar2)
is
begin
  update s6_migrnls
  set    nls_bars=p_nls_bars
  where  nls_fil=p_nls_fil and
         kv=p_kv           and
         filial=p_filial;
  if sql%rowcount=0 then
    insert
    into   s6_migrnls (nls_fil ,
                       kv      ,
                       nls_bars,
                       filial)
               values (p_nls_fil ,
                       p_kv      ,
                       p_nls_bars,
                       p_filial);
  end if;
  commit;
end tmp_ups6mn;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/TMP_UPS6MN.sql =========*** End **
PROMPT ===================================================================================== 
