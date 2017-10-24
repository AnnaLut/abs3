
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ourokpo.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_OUROKPO 
return varchar2
is
n_okpo varchar2(14);
begin
n_okpo:='';
select val into n_okpo from params where par = 'OKPO';
return n_okpo;
end f_ourokpo;
/
 show err;
 
PROMPT *** Create  grants  F_OUROKPO ***
grant EXECUTE                                                                on F_OUROKPO       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_OUROKPO       to START1;
grant EXECUTE                                                                on F_OUROKPO       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ourokpo.sql =========*** End *** 
 PROMPT ===================================================================================== 
 