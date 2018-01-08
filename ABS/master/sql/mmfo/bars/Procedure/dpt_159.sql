

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DPT_159.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DPT_159 ***

  CREATE OR REPLACE PROCEDURE BARS.DPT_159 
 (p_dptid in v_dpt_159.dptid%type,
  p_tt    in tts.tt%type)
is
  type t_accrec is record (acc  accounts.acc%type,
                           nls  accounts.nls%type,
                           nms  accounts.nms%type);
  title       varchar2(60)     := 'dpt159:';
  l_mfo       banks.mfo%type   := gl.amfo;
  l_dat       date             := gl.bdate;
  l_dpt       v_dpt_159%rowtype;
  l_newvidd   dpt_vidd.vidd%type;
  l_intamount number(38);
  l_errflg    boolean;
  l_tmp       number;
  l_2620      t_accrec;
  l_2628      t_accrec;
  l_s180      specparam.s180%type := 1;
  l_s181      specparam.s181%type := 1;
  l_r011      specparam.r011%type := 1;
  l_r013      specparam.r013%type := 1;
  l_expaccid  number;
  l_dk        oper.dk%type     := 1;
  l_vob       oper.vob%type    := 6;
  l_userid    oper.userid%type := gl.auid;
  l_nazn      oper.nazn%type   := 'Перенесення коштів згідно Постанови № 227 від 26.06.2009';
  l_ref       oper.ref%type;
begin

  bars_audit.trace('%s entry, dptid=>%s, tt=>%s', title, to_char(p_dptid), p_tt);

  begin
    select * into l_dpt from v_dpt_159 where dptid = p_dptid;
  exception
    when no_data_found then
      raise_application_error(-20013, 'Не найден вклад № '||to_char(p_dptid), true);
  end;
  bars_audit.trace('%s deposit № %s %s', title, l_dpt.dptnum, to_char(l_dpt.dptdat,'dd.mm.yyyy'));

  if sys_context('bars_context','user_branch') != l_dpt.branch then
     bars_context.subst_branch(l_dpt.branch);
  end if;

  if l_dpt.depsal_fact != l_dpt.depsal_plan then
     raise_application_error(-20013, 'Найдены незавизир.док-ты по деп.счету вклада № '||to_char(p_dptid), true);
  end if;
  if l_dpt.intsal_fact != l_dpt.intsal_plan then
     raise_application_error(-20013, 'Найдены незавизир.док-ты по проц.счету вклада № '||to_char(p_dptid), true);
  end if;
  bars_audit.trace('%s deposit amount = %s, interest amount = %s', title,
                   to_char(l_dpt.depsal_fact), to_char(l_dpt.intsal_fact));

  -- поиск нового вида вклада
  begin
    select new.vidd
      into l_newvidd
      from dpt_vidd old,
           dpt_vidd new
     where old.vidd     = l_dpt.typeid
       and old.type_cod = new.type_cod
       and old.kv       = new.kv
       and old.freq_k   = new.freq_k
       and ((old.bsd in ('2630', '2635') and newnbs.g_state = 0) or (old.bsd in ('2630') and newnbs.g_state = 1))
       and new.bsd      = '2620';
  exception
    when no_data_found then
      raise_application_error(-20013, 'Не найден новый вид вклада для вклада № '||to_char(p_dptid), true);
  end;
  bars_audit.trace('%s vidd (old,new) = (%s,%s)', title, to_char(l_dpt.typeid), to_char(l_newvidd));

  -- I. доначисление процентов по текущий день включит.
  begin
    insert into int_queue
           (kf, branch, deal_id, deal_num, deal_dat, cust_id,
            int_id, acc_id, acc_num, acc_cur, acc_nbs, acc_name,
            acc_iso, acc_open, acc_amount, int_details, int_tt, mod_code)
    values (l_mfo, l_dpt.branch, l_dpt.dptid, l_dpt.dptnum, l_dpt.dptdat, l_dpt.custid,
            1, l_dpt.depaccid, l_dpt.depaccnum, l_dpt.curid,
            substr(l_dpt.depaccnum, 1, 4), substr(l_dpt.depaccname, 1, 38),
            l_dpt.curcode, l_dpt.datbeg, null,  null, '%%1', 'DPT');
    make_int (p_dat2       => l_dat,
              p_runmode    => 1,
              p_runid      => 0,
              p_intamount  => l_intamount,
              p_errflg     => l_errflg);
    if l_errflg then
       raise_application_error(-20013, 'Ошибка начисления % по вкладу № '||to_char(p_dptid)||': '||sqlerrm, true);
    end if;
  exception
    when others then
      raise_application_error(-20013, 'Ошибка начисления % по вкладу № '||to_char(p_dptid)||': '||sqlerrm, true);
  end;
  bars_audit.trace('%s intamount = %s %s', title, to_char(l_intamount), l_dpt.curcode);

  -- II. открытие счетов
  l_2620.acc := null;
  l_2620.nls := substr(vkrzn(substr(l_mfo, 1, 5), '2620'||'0'||substr(l_dpt.depaccnum, 6, 9)), 1, 14);
  l_2620.nms := substr(l_dpt.depaccname, 1, 70);

  l_2628.nls := null;
  l_2628.nls := substr(vkrzn(substr(l_mfo, 1, 5), '2628'||'0'||substr(l_dpt.intaccnum, 6, 9)), 1, 14);
  l_2628.nms := substr(l_dpt.intaccname, 1, 70);

  begin
    op_reg(99, 0, 0, l_dpt.depgrp, l_tmp, l_dpt.custid, l_2620.nls, l_dpt.curid,
           l_2620.nms, l_dpt.deptype, l_dpt.depisp, l_2620.acc);
  exception
    when others then
      raise_application_error(-20013, 'Ошибка открытия счета '||l_2620.nls
                                    ||' по вкладу № '||to_char(p_dptid)
                                    ||': '||sqlerrm, true);
  end;
  bars_audit.trace('%s deposit account %s (%s) succ.opened', title, l_2620.nls, to_char(l_2620.acc));

  begin
    op_reg(99, 0, 0, l_dpt.depgrp, l_tmp, l_dpt.custid, l_2628.nls, l_dpt.curid,
           l_2628.nms, l_dpt.inttype, l_dpt.intisp, l_2628.acc);
  exception
    when others then
      raise_application_error(-20013, 'Ошибка открытия счета '||l_2628.nls
                                    ||' по вкладу № '||to_char(p_dptid)
                                    ||': '||sqlerrm, true);
  end;
  bars_audit.trace('%s percent account %s (%s) succ.opened', title, l_2628.nls, to_char(l_2628.acc));

  -- заполнение спецпараметров
  begin
    insert into specparam (acc, s180, s181, r013) values (l_2620.acc, l_s180, l_s181, l_r013);
    insert into specparam (acc, s180, s181, r011) values (l_2628.acc, l_s180, l_s181, l_r011);
    insert into specparam_int (acc, ob22)
    select l_2620.acc, substr(val, 1, 2) from dpt_vidd_params where vidd = l_newvidd and tag = 'DPT_OB22';
    insert into specparam_int (acc, ob22)
    select l_2628.acc, substr(val, 1, 2) from dpt_vidd_params where vidd = l_newvidd and tag = 'INT_OB22';
  exception
    when others then
      raise_application_error(-20013, 'Ошибка заполнения спецпараметров по вкладу № '||to_char(p_dptid)
                                    ||': '||sqlerrm, true);
  end;
  bars_audit.trace('%s specparams succ.inserted for deposit № %s', title, to_char(p_dptid));

  -- счет процентных расходов
  begin
    l_expaccid := dpt.get_expenseacc (p_dptype  => l_newvidd,
                                      p_balacc  => '2620',
                                      p_curcode => l_dpt.curid,
                                      p_branch  => l_dpt.branch,
                                      p_penalty => 0);
  exception
    when others then
      raise_application_error(-20013, 'Не найден счет проц.расходов для вклада № '||to_char(p_dptid)
                                    ||'(вид вклада '||to_char(l_newvidd)||'): '||sqlerrm, true);
  end;
  bars_audit.trace('%s expense account = %s', title, to_char(l_expaccid));

  -- процентная карточка
  begin
    insert into int_accn
      (acc, id, acra, acrb, metr, basem, basey, freq, io, acr_dat, stp_dat, tt)
    select l_2620.acc, 1, l_2628.acc, l_expaccid, i.metr, i.basem,  i.basey, i.freq, i.io, null, i.stp_dat, i.tt
      from int_accn i
     where i.acc = l_dpt.depaccid and i.id = 1;
    insert into int_ratn (acc, id, bdat, ir, op, br)
    select l_2620.acc, 1, i.bdat, i.ir, i.op, i.br
      from int_ratn i
     where i.acc = l_dpt.depaccid and id = 1;
  exception
    when others then
      raise_application_error(-20013, 'Ошибка открытия проц.карточки по вкладу № '||to_char(p_dptid)||': '||sqlerrm, true);
  end;
  bars_audit.trace('%s interest card succ.inserted for deposit № %s', title, to_char(p_dptid));

  -- III. перенос депозита и процентов
  if l_dpt.depsal_fact > 0 then
     begin
       gl.ref (l_ref);
       insert into oper
             (ref, tt, vob, nd, dk, pdat, vdat, datd, userid, nazn,
              id_a, nam_a, mfoa, nlsa, kv,  s,
              id_b, nam_b, mfob, nlsb, kv2, s2)
       values
             (l_ref, p_tt, l_vob, to_char(l_ref), l_dk,
              sysdate, l_dat, l_dat, l_userid, l_nazn,
              l_dpt.custcode, substr(l_dpt.depaccname,1,38), l_mfo, l_dpt.depaccnum, l_dpt.curid, l_dpt.depsal_fact,
              l_dpt.custcode, substr(l_2620.nms,      1,38), l_mfo, l_2620.nls,      l_dpt.curid, l_dpt.depsal_fact);
       paytt (null, l_ref, l_dat, p_tt, l_dk,
              l_dpt.curid,  l_dpt.depaccnum, l_dpt.depsal_fact,
              l_dpt.curid,  l_2620.nls,      l_dpt.depsal_fact);
     exception
       when others then
         raise_application_error(-20013, 'Ошибка переноса депозита для вклада № '||to_char(p_dptid)||': '||sqlerrm, true);
     end;
     bars_audit.trace('%s ref(dep) = %s', title, to_char(l_ref));
  end if;

  --l_dpt.intsal_fact := l_dpt.intsal_fact + nvl(l_intamount, 0);
  select ostb
    into l_dpt.intsal_fact
    from accounts
   where acc = l_dpt.intaccid;
  bars_audit.trace('%s current interest amount = %s', title, to_char(l_dpt.intsal_fact));

  if l_dpt.intsal_fact > 0 then
     begin
       gl.ref (l_ref);
       insert into oper
             (ref, tt, vob, nd, dk, pdat, vdat, datd, userid, nazn,
              id_a, nam_a, mfoa, nlsa, kv,  s,
              id_b, nam_b, mfob, nlsb, kv2, s2)
       values
             (l_ref, p_tt, l_vob, to_char(l_ref), l_dk,
              sysdate, l_dat, l_dat, l_userid, l_nazn,
              l_dpt.custcode, substr(l_dpt.intaccname,1,38), l_mfo, l_dpt.intaccnum, l_dpt.curid, l_dpt.intsal_fact,
              l_dpt.custcode, substr(l_2628.nms,      1,38), l_mfo, l_2628.nls,      l_dpt.curid, l_dpt.intsal_fact);
       paytt (null, l_ref, l_dat, p_tt, l_dk,
              l_dpt.curid,  l_dpt.intaccnum, l_dpt.intsal_fact,
              l_dpt.curid,  l_2628.nls,      l_dpt.intsal_fact);
     exception
       when others then
         raise_application_error(-20013, 'Ошибка переноса процентов для вклада № '||to_char(p_dptid)||': '||sqlerrm, true);
     end;
     bars_audit.trace('%s ref(int) = %s', title, to_char(l_ref));
  end if;

  -- IV. изменение счета для вклада
  update dpt_deposit set acc = l_2620.acc, vidd = l_newvidd where deposit_id = p_dptid;
  bars_audit.trace('%s acc+vidd succ.updated for deposit № %s', title, to_char(p_dptid));

  -- V. закрытие счетов
  update accounts set dazs = dat_next_u (l_dat, 1) where acc = l_dpt.depaccid;
  update accounts set dazs = dat_next_u (l_dat, 1) where acc = l_dpt.intaccid;
  bars_audit.trace('%s old accounts succ.closed for deposit № %s', title, to_char(p_dptid));

  bars_audit.trace('%s exit, deposit № %s succ.processed', title, to_char(p_dptid));

  bars_context.set_context;

exception
  when others then
    rollback;
    bars_context.set_context;
    bars_audit.error('Ошибка переноса вклада № '|| to_char(p_dptid)||' на вклад до востребования: '||sqlerrm);
    raise_application_error(-20013, 'Ошибка переноса вклада № '||to_char(p_dptid)||': '||sqlerrm, true);
end dpt_159;
 
/
show err;

PROMPT *** Create  grants  DPT_159 ***
grant EXECUTE                                                                on DPT_159         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DPT_159         to DPT_ADMIN;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DPT_159.sql =========*** End *** =
PROMPT ===================================================================================== 
