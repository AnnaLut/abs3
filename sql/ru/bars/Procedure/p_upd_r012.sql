

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_UPD_R012.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_UPD_R012 ***

  CREATE OR REPLACE PROCEDURE BARS.P_UPD_R012 (kodf_ in varchar2 default 'A7',
                                            mfou_ in number default null) as
begin
    for k in (select a.acc, b.r012, a.t020, a.nbs, sacc
             from (
                  select a.acc, nbs, ost, decode(sign(ost),-1,1,2) t020, s.r012, s.acc sacc
                  from otcn_saldo a, specparam s
                  where nvl(a.nbs, substr(nls,1,4)) in (select r020
                                from kod_r020
                                where trim(prem) = 'สม' and
                                    a010 = kodf_ and
                                    d_close is null) and
                        a.acc = s.acc(+) ) a, spr_r020_r012 b
              where a.ost <>0 and
                    a.nbs = b.r020 and
                    (a.t020 = b.t020 or b.t020 = '3') and
                    trim(b.r012) is not null and
                    (a.r012 is null or
                     a.r012 is not null and a.r012 <> b.r012)
                    )
    loop
        if mfou_ is not null and mfou_ = 300120 and k.nbs = '2625' then
           null;
        else
            if k.sacc is null then
               begin
                   insert into specparam(acc, r012)
                   values(k.acc, k.r012);
               exception
                   when others then
                       update specparam
                       set r012 = k.r012
                       where acc = k.acc;
               end;
            else
               update specparam
               set r012 = k.r012
               where acc = k.acc;
            end if;
            commit;
        end if;
    end loop;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_UPD_R012.sql =========*** End **
PROMPT ===================================================================================== 
