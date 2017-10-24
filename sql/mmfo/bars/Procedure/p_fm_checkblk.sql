PROMPT *** Create  procedure P_FM_CHECKBLK ***

create or replace procedure p_fm_checkblk
is
/* author: unknown
v. 1.0.1 19.07.2017
lypskykh 19.07.2017: добавил обход по mv_kf и актуализировал код операции; переписал for на ins..sel */

l_fm_blk params.val%type;
l_userid number;
begin

  bars_audit.info('p_fm_checkblk. Start');

  l_fm_blk:=getglobaloption('FM_BLK');

  for rec in (select kf from mv_kf)
  loop
    bc.go(rec.kf);
    l_userid := user_id;
    insert into finmon_que(ref, status, opr_vid1, opr_vid2, comm_vid2, opr_vid3, comm_vid3, monitor_mode, agent_id, rnk_a, rnk_b, comments)
    select unique ref, 'I', '99999999999999' || lastnum, '0000', null, '000', null, 0, l_userid, null, null, 'блокування ФМ'
               from (     -- opldok
                      select p.ref, case when p.mfoa = rec.kf then '9' else '8' end as lastnum
                        from oper p, opldok o, accounts a
                       where p.pdat between trunc(sysdate) and to_date(to_char(sysdate, 'dd.mm.yyyy')||' 23:59:59', 'dd.mm.yyyy hh24:mi:ss')
                         and p.ref = o.ref
                         and o.dk  = 0
                         and o.acc = a.acc
                         and ( a.nbs in ('2560', '2570', '2600', '2601', '2602',
                                         '2604', '2605', '2606', '2610', '2611', '2615', '2620', '2622',
                                         '2625', '2630', '2635', '2640', '2641', '2642', '2643', '2650',
                                         '2651', '2652', '2655')
                            or a.nbs = '2603' and a.kv = 980 )
                         and a.blkd = l_fm_blk
                         and not exists (select 1 from finmon_que where ref = p.ref)
                       union all
                          -- oper
                      select p.ref, case when p.mfoa = rec.kf then '9' else '8' end as lastnum
                        from oper p, accounts a
                       where p.pdat between trunc(sysdate) and to_date(to_char(sysdate, 'dd.mm.yyyy')||' 23:59:59', 'dd.mm.yyyy hh24:mi:ss')
                         and decode(p.dk,1,p.nlsa,p.nlsb) = a.nls
                         and decode(p.dk,1,p.kv,nvl(p.kv2,p.kv)) = a.kv
                         and decode(p.dk,1,p.mfoa,p.mfob) = '300465'
                         and ( a.nbs in ('2560', '2570', '2600', '2601', '2602',
                                         '2604', '2605', '2606', '2610', '2611', '2615', '2620', '2622',
                                         '2625', '2630', '2635', '2640', '2641', '2642', '2643', '2650',
                                         '2651', '2652', '2655')
                            or a.nbs = '2603' and a.kv = 980 )
                         and a.blkd = l_fm_blk
                         and not exists (select 1 from finmon_que where ref = p.ref) );
  end loop;

  bars_audit.info('p_fm_checkblk. Finish');

exception when others then
  bc.set_context;
  bars_audit.error('FM. job: error during execution procedure p_fm_checkblk: ' ||
                   dbms_utility.format_error_stack() || chr(10) ||
                   dbms_utility.format_error_backtrace());
end p_fm_checkblk;
/
show err;

PROMPT *** Create  grants  P_FM_CHECKBLK ***
grant EXECUTE                                                                on P_FM_CHECKBLK   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FM_CHECKBLK   to FINMON01;
