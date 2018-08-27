PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/script/ins_ree_tmp_COBUMMFO-9231.sql =========*** Run *** =
PROMPT ===================================================================================== 

-- ins_ree_tmp_COBUMMFO-9231
begin
  if trunc(sysdate) = to_date('27.08.2018','dd.mm.yyyy') then
    bars.bars_login.login_user(p_sessionid => sys_guid(),
                               p_userid    => 1,
                               p_hostname  => null,
                               p_appname   => null);
    bars.bc.home;

    for rec in (select * 
                from bars.accounts a 
                where nls in ('26003500435750','26047500435750') 
                      and not exists (select 1 from bars.ree_tmp t where t.nls = a.nls and t.kf = a.kf))
    loop
      if ( bars.bars_dpa.dpa_nbs(rec.nbs, rec.ob22) = 1 ) then 
        bars.bars_dpa.accounts_tax( p_acc  => rec.acc
                                  , p_daos => rec.daos
                                  , p_dazs => rec.dazs
                                  , p_kv   => rec.kv
                                  , p_nbs  => rec.nbs
                                  , p_nls  => rec.nls
                                  , p_ob22 => rec.ob22
                                  , p_pos  => rec.pos
                                  , p_vid  => rec.vid
                                  , p_rnk  => rec.rnk
                                  );
      end if;
    end loop;
  end if;
end;
/

commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/script/ins_ree_tmp_COBUMMFO-9231.sql =========*** End *** =
PROMPT ===================================================================================== 
