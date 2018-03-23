
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/finmon_is_public.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FINMON_IS_PUBLIC (p_name   IN VARCHAR2,
                                             p_rnk    IN NUMBER,
                                             p_mode   IN INT DEFAULT 0)
   RETURN NUMBER
IS
   l_public   INT;
   l_name     VARCHAR2(250);
BEGIN
 if  p_name is null
 then
  if p_rnk is not null
  then
      begin
          select nmk
          into l_name
          from customer
          where rnk = p_rnk;
          l_name := replace(replace(replace(replace(replace(replace(replace(replace(l_name,'/',''),'\',''),'*',''),'~',''),'!',''),'&',''),'?',''),' ','');
      exception when no_data_found then l_name := null;
      end;
  else
   l_public := 0;
  end if;
 else
    l_name := replace(replace(replace(replace(replace(replace(replace(replace(p_name,'/',''),'\',''),'*',''),'~',''),'!',''),'&',''),'?',''),' ','');
 end if;

 --BARS_AUDIT.INFO(l_name);

 if l_name is not null
 then
     begin
      select /*+ index(I_FMN_PUBLIC_RELS) */ case when p_mode = 0 then 1
                  when p_mode = 1 then id
             end
        into l_public
        from finmon_public_rels
       where fullname = upper(l_name)
         and (ADD_MONTHS(termin,36) >= bankdate or termin is null);
      exception when no_data_found then l_public := 0;
                when too_many_rows then l_public := 1;
     end;
 else l_public := 0;
 end if;

 return l_public;
end;
/
 show err;
 
PROMPT *** Create  grants  FINMON_IS_PUBLIC ***
grant EXECUTE                                                                on FINMON_IS_PUBLIC to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FINMON_IS_PUBLIC to CUST001;
grant EXECUTE                                                                on FINMON_IS_PUBLIC to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/finmon_is_public.sql =========*** E
 PROMPT ===================================================================================== 
 