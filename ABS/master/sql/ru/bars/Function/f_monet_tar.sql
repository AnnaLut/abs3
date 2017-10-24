
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_monet_tar.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_MONET_TAR 
(tar_ INTEGER,
m_1 integer default 0 ,
m_2 integer default 0,
m_5 integer default 0,
m_10 integer default 0,
m_25 integer default 0,
m_50 integer default 0)
return numeric
is
s_ numeric default 0;
s1_ numeric default 0;
s2_ numeric default 0;
s5_ numeric default 0;
s10_ numeric default 0;
s25_ numeric default 0;
s50_ numeric default 0;
begin
            begin
                       select trim(sum_tarif) into s1_ from tarif_scale
                       where sum_limit=1
                       and kod=tar_;
            end;
            begin
                   select trim(sum_tarif) into s2_ from tarif_scale
                   where sum_limit=2
                   and kod=tar_;
            end;
            begin
                   select trim(sum_tarif) into s5_ from tarif_scale
                   where sum_limit=5
                   and kod=tar_;
            end;
            begin
                   select trim(sum_tarif) into s10_ from tarif_scale
                   where sum_limit=10
                   and kod=tar_;
            end;
            begin
                   select trim(sum_tarif) into s25_ from tarif_scale
                   where sum_limit=25
                   and kod=tar_;
            end;
            begin
                   select trim(sum_tarif) into s50_ from tarif_scale
                   where sum_limit=50
                   and kod=tar_;
            end;
                                     select
                (trim(s1_)/1000*trim(m_1))+
                (trim(s2_)/1000*trim(m_2))+
                (trim(s5_)/1000*trim(m_5))+
                (trim(s10_)/1000*trim(m_10))+
                (trim(s25_)/1000*trim(m_25))+
                (trim(s50_)/1000*trim(m_50))
                into s_ from dual;
    return s_;
end  f_monet_tar;
/
 show err;
 
PROMPT *** Create  grants  F_MONET_TAR ***
grant EXECUTE                                                                on F_MONET_TAR     to ABS_ADMIN;
grant EXECUTE                                                                on F_MONET_TAR     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_MONET_TAR     to START1;
grant EXECUTE                                                                on F_MONET_TAR     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_monet_tar.sql =========*** End **
 PROMPT ===================================================================================== 
 