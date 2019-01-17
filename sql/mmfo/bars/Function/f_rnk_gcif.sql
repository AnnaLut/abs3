CREATE OR REPLACE FUNCTION BARS.F_RNK_gcif (p_okpo varchar2, p_rnk number) return varchar2 is

l_okpo  varchar2(30);

begin
   l_okpo := p_okpo;
   if l_okpo is null THEN
      begin
         select trim(okpo) into l_okpo from customer  where  rnk = p_rnk;
      EXCEPTION  WHEN NO_DATA_FOUND  THEN  l_okpo := p_okpo;
      END;
   end if;
   if l_okpo is null or l_okpo like '00000%' THEN
      begin
         select trim(gcif) into l_okpo from ebkc_gcif  where  rnk = p_rnk;
      EXCEPTION  WHEN NO_DATA_FOUND  THEN  l_okpo := null;
      END;
   end  if;
   return(nvl(l_okpo,sys_context('bars_context','user_mfo')||'-'||p_rnk));
end;
/
 show err;
 
PROMPT *** Create  grants  F_RNK_gcif  ***
grant EXECUTE                                                                on F_RNK_gcif        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_RNK_gcif        to START1;
