-- ======================================================================================
-- Author : KVA
-- Date   : 09.01.2018
-- ===================================== <Comments> =====================================
-- update column NDG in CC_DEAL_UPDATE
-- ======================================================================================

declare
  l_kf             varchar2(6);
begin --создание job-а
    --l_kf      := '304665';
    for lc_kf in (select kf from bars.mv_kf where kf = l_kf or l_kf = '' or l_kf is null)
    loop
        l_kf := lc_kf.kf;
        bars.bc.go(l_kf);

        update (select c.NDG c_NDG,
                       u.NDG u_NDG
                  from BARS.CC_DEAL c,
                       BARS.CC_DEAL_UPDATE u
                 where u.idupd in ( select max(u.idupd)
                                      from BARS.CC_DEAL_UPDATE u
                                     where u.nd = c.nd
                                       and u.kf = c.kf
                                     group by u.nd, u.kf)
                   and c.kf = u.kf
                   and c.nd = u.nd
                   and c.NDG is not null
                   and decode(c.NDG, u.NDG, 0, 1) = 1
               )
           set u_ndg = c_ndg;

        dbms_output.put_line (l_kf || ':  updated CC_DEAL_UPDATE "' || to_char(sql%rowcount) || '" record(s)' );
        commit;
    end loop;
end;
/


-- MERGE INTO BARS.CC_DEAL_UPDATE a
-- USING (select u.nd, u.kf, u.ndg, c.ndg c_ndg
--          from BARS.CC_DEAL_UPDATE u, BARS.CC_DEAL c
--         where u.idupd in ( select max(u.idupd) 
--                              from BARS.CC_DEAL_UPDATE u
--                             where u.nd = c.nd
--                               and u.kf = c.kf
--                             group by u.nd, u.kf)
--           and c.kf = u.kf
--           and c.nd = u.nd
--           and decode(c.ndg,  u.ndg,  0, 1) = 1
--       ) p
--    ON (p.nd=a.nd and p.kf = a.kf )
-- WHEN MATCHED THEN
-- UPDATE SET a.ndg = p.c_ndg;







