

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_A7.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_A7 ***

  CREATE OR REPLACE PROCEDURE BARS.CP_A7 (p_dat date, p_reg int default 0) is
--  v. 11/01-10
--  ãğàô³ê ÷àñòêîâèõ ïîãàøåíü ïî ğàõóíêàõ ÖÏ
begin
   if p_reg=9 then
   delete from otcn_lim_sb where acc in
          (select acc from accounts where nbs is NULL
           and substr(nls,1,4) in ('1410','1413','1414','3112','3113','3114'));
   end if;
for c in
(select acc, dat_roz, sumb, r, ar.ref
from cp_arch ar, oper o
where o.ref=ar.ref and o.sos>0
       and p_dat < dat_roz and op < 0
order by acc, ar.ref)
loop
begin
insert into otcn_lim_sb (acc,fdat,lim) values (c.acc,c.dat_roz,c.sumb);
exception when others then NULL;
logger.info('CP_A7 íå äîáàâëåíî acc='||c.acc||' '||c.dat_roz);
end;
end loop;
--commit;
end;
/
show err;

PROMPT *** Create  grants  CP_A7 ***
grant EXECUTE                                                                on CP_A7           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CP_A7           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_A7.sql =========*** End *** ===
PROMPT ===================================================================================== 
