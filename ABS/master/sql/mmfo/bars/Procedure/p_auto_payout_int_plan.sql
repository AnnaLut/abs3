

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_AUTO_PAYOUT_INT_PLAN.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_AUTO_PAYOUT_INT_PLAN ***

  CREATE OR REPLACE PROCEDURE BARS.P_AUTO_PAYOUT_INT_PLAN 
  (p_dptid   in  dpt_deposit.deposit_id%type,   -- идентификатор договора (0 - все)
   p_runid   in  dpt_jobs_jrnl.run_id%type,     -- № запуска автомат.задания
   p_branch  in  dpt_deposit.branch%type,       -- код подразделения
   p_bdate   in  fdat.fdat%type)                -- текущая банковская дата
is
  c_title    constant varchar2(60)  := 'dptweb.autopayintpl:';
  type       t_dptrec  is record ( dptid     dpt_deposit.deposit_id%type,
                                   plandate  date,
                                   comproc   dpt_vidd.comproc%type,
                                   min_add   dpt_vidd.limit%type
                                  );
  type       t_dptlist is table of t_dptrec;
  type       t_payrec  is record ( dptid     dpt_deposit.deposit_id%type,
                                   dptnum    dpt_deposit.nd%type,
                                   dptacc    accounts.acc%type,
                                   intacc    accounts.acc%type,
                                   curcode   accounts.kv%type,
                                   amntfact  accounts.ostc%type,
                                   amntplan  accounts.ostb%type,
                                   nazn      oper.nazn%type,
                                   custid    customer.rnk%type,
                                   custname  customer.nmk%type,
                                   mfoa      oper.mfoa%type,
                                   nlsa      oper.nlsa%type,
                                   namea     oper.nam_a%type,
                                   ida       oper.id_a%type,
                                   mfob      oper.mfob%type,
                                   nlsb      oper.nlsb%type,
                                   nameb     oper.nam_b%type,
                                   idb       oper.id_b%type);
  l_initdate date;
  l_plandate date;
  l_acrdat   date;
  l_tmpnum   number;
  l_dptlist  t_dptlist;
  l_payrec   t_payrec;
  l_apldat   date;
  l_ref      oper.ref%type;
  l_errflg   boolean;
  l_errmsg   varchar2(3000);
  g_errmsg_dim              constant number       := 3000;
g_errmsg                  varchar2(3000);
g_penaltymsgdim           constant number       := 3000;
  l_dptnls   accounts.nls%type;
  l_vidd     dpt_vidd.vidd%type;
  l_adds     number := 0; -- принадлежность счета выплаты к тому же договору
  l_tt       tts.tt%type;
  g_modcode                 constant  varchar2(3) := 'DPT';
    autocommit                constant  number      := 100;
    g_jobrunidnotfound        constant err_codes.err_name%type := 'JOB_RUNID_NOT_FOUND';
  ---
  -- internal function and procedure
  ---
  function check_nls4pay(p_nls  dpt_deposit.nls_p%type,
                         p_acc  dpt_deposit.acc%type) return boolean
  is
    l_nls  accounts.nls%type;
  begin
    select nls
      into l_nls
      from accounts
     where acc = p_acc;

    if (p_nls = l_nls)
    then return TRUE;
    else return FALSE;
    end if;
  end;
  ---
  function check_joinpay(p_deposit_id  dpt_deposit.deposit_id%type,
                         p_nlsb        dpt_deposit.nls_p%type) return boolean
  is
   l_adds int;
  begin
    BEGIN
       SELECT 1
         INTO l_adds
         FROM accounts a, dpt_deposit d
        WHERE d.acc = a.acc
          AND a.nls = p_nlsb
          AND d.deposit_id = p_deposit_id;
    EXCEPTION
       WHEN NO_DATA_FOUND
       THEN l_adds := -1;
    END;

    if (l_adds = 1)
    then return TRUE;
    else return FALSE;
    end if;
  end;
begin

  bars_audit.trace('%s entry with {%s, %s, %s, %s)', c_title, to_char(p_dptid),
                   to_char(p_runid), p_branch, to_char(p_bdate, 'dd.mm.yyyy'));

  if (nvl(p_runid, 0) = 0 and p_dptid = 0) then
      bars_error.raise_nerror(g_modcode, g_jobrunidnotfound);
  end if;

  if p_dptid = 0 then
     bars_audit.info(bars_msg.get_msg (g_modcode, 'AUTOPAYOUTINTPL_ENTRY', p_branch));
  end if;

  l_initdate := dat_next_u (p_bdate, -1) + 1;
  bars_audit.trace('%s plandate''s range: %s - %s', c_title,
                                                    to_char(l_initdate, 'dd.mm.yyyy'),
                                                    to_char(p_bdate,    'dd.mm.yyyy'));

  l_plandate := l_initdate;

  while l_plandate <= p_bdate
  loop

      bars_audit.trace('%s processing plandate %s...', c_title, to_char(l_plandate, 'dd.mm.yyyy'));

      l_acrdat := l_plandate - 1;

      -- начисление %% по план.дату минус 1 день
      insert into int_queue
            (kf, branch, deal_id, deal_num, deal_dat, cust_id, int_id,
             acc_id, acc_num, acc_cur, acc_nbs, acc_name, acc_iso,
             acc_open, acc_amount, int_details, int_tt, mod_code)
      select /*+ ORDERED INDEX(a) INDEX(i)*/
             a.kf, a.branch, d.deposit_id, d.nd, d.datz, d.rnk, i.id,
             a.acc, a.nls, a.kv, a.nbs, substr(a.nms, 1, 38), t.lcv,
             a.daos, null, null, nvl(i.tt, '%%1'), 'DPT'
        from dpt_deposit d,
             accounts    a,
             int_accn    i,
             tabval      t,
             dpt_vidd    v
       where d.acc       = a.acc
         and d.acc       = i.acc
         and i.id        = 1
         and a.kv        = t.kv
         and d.vidd      = v.vidd
         and d.branch    = p_branch
         and (   p_dptid = 0
              or p_dptid = d.deposit_id )
         and (   (i.acr_dat is null)
              or (i.acr_dat < l_acrdat and i.stp_dat is null)
              or (i.acr_dat < l_acrdat and i.stp_dat > i.acr_dat))
         and dpt.get_intpaydate (p_bdate,
                                 d.dat_begin,
                                 d.dat_end,
                                 d.freq,
                                 decode(v.amr_metr, 0, 0, 1),
                                 decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                 1) = l_plandate;

      bars_audit.trace('%s make_int for %s...', c_title, p_branch);

      make_int (p_dat2      => l_acrdat,
                p_runmode   => 1,
                p_runid     => 0,
                p_intamount => l_tmpnum,
                p_errflg    => l_errflg);

      bars_audit.trace('%s make_int for %s completed.', c_title, p_branch);

      l_plandate := l_plandate + 1;

  end loop;

  -- отбор всех вкладов, для которых наступил день плановой выплаты процентов
  select deposit_id, plandate, comproc, limit
    bulk collect
    into l_dptlist
    from
        (select d.deposit_id, dpt.get_intpaydate (p_bdate,
                                                  d.dat_begin,
                                                  d.dat_end,
                                                  d.freq,
                                                  decode(v.amr_metr, 0, 0, 1),
                                                  decode(nvl(d.cnt_dubl, 0), 0, 0, 1), 1) plandate,
                v.comproc, v.limit
           from dpt_deposit d,
                dpt_vidd    v
          where d.vidd   = v.vidd
            and d.branch = p_branch
            and p_dptid  = 0           -- депозитный портфель
            and d.mfo_p is not null
            and d.nls_p is not null
            and dpt.get_intpaydate (p_bdate,
                                    d.dat_begin,
                                    d.dat_end,
                                    d.freq,
                                    decode(v.amr_metr, 0, 0, 1),
                                    decode(nvl(d.cnt_dubl, 0), 0, 0, 1), 1)
                between l_initdate and p_bdate
          union all
         select d.deposit_id, dpt.get_intpaydate (p_bdate,
                                                  d.dat_begin,
                                                  d.dat_end,
                                                  d.freq,
                                                  decode(v.amr_metr, 0, 0, 1),
                                                  decode(nvl(d.cnt_dubl, 0), 0, 0, 1), 1) plandate,
                v.comproc, v.limit
           from dpt_deposit d, dpt_vidd v
          where d.vidd       = v.vidd
            and d.branch     = p_branch
            and p_dptid     != 0
            and d.deposit_id = p_dptid    -- депозитный договор
            and d.mfo_p is not null
            and d.nls_p is not null
            and dpt.get_intpaydate (p_bdate,
                                    d.dat_begin,
                                    d.dat_end,
                                    d.freq,
                                    decode(v.amr_metr, 0, 0, 1),
                                    decode(nvl(d.cnt_dubl, 0), 0, 0, 1), 1)
                between l_initdate and p_bdate);

  bars_audit.trace('%s amount of intpay-deposits = %s', c_title, to_char(l_dptlist.count));

  -- безначичная выплата процентов (+ oper_ext)
  l_tmpnum := 0;

  for i in 1..l_dptlist.count
  loop

    l_errflg := false;
    l_errmsg := null;
    l_ref    := null;

    savepoint sp_payout;

    begin
      select d.deposit_id, d.nd, d.acc,
             p.acc, p.kv, p.ostc, p.ostb,
             null,
             c.rnk, substr(c.nmk, 1, 38),
             p.kf,    p.nls,   substr(p.nms,    1, 38), c.okpo,
             d.mfo_p, d.nls_p, substr(d.name_p, 1, 38), nvl(d.okpo_p, c.okpo)
        into l_payrec
        from dpt_deposit d,
             accounts    p,
             customer    c,
             int_accn    i
       where d.acc  = i.acc
         and i.acra = p.acc
         and i.id   = 1
         and d.rnk  = c.rnk
         and p.ostc > 0
         and d.deposit_id = l_dptlist(i).dptid;

        bars_audit.trace( '%s processing deposit № %s...', c_title, to_char(l_dptlist(i).dptid) );

        -- міняєм призначення платежу якщо виплата %% - це капіталізація
        If (l_dptlist(i).comproc = 1)
        Then  -- перевіряємо чи не було змінено рах. виплати %%
          If (check_nls4pay(l_payrec.nlsB, l_payrec.dptacc ))
          then
            l_payrec.nazn := SubStr('Капіталізація нарахованих відсотків по договору № '||dpt_web.f_nazn('U', l_payrec.dptid), 1, 160);
          End If;
        Else
          -- якщо мін. сума поповнення більша нуля то вклад з поповненням  і це виплата на депозитний рахунок, а НЕ КАПІТАЛІЗАЦІЯ
           If (l_dptlist(i).min_add > 0) Then
                -- якщо сума %% менша за мін. суму поповнення
              If (l_payrec.amntfact < l_dptlist(i).min_add)
                Then
                  l_errflg := true;
                  -- сума поповнення %s менша за мінімально допустиму %s для вкладу № %s
                  l_errmsg := substr( bars_msg.get_msg( g_modcode,
                                                        'AUTOPAYOUTINTPL_INVALID_MINADD',
                                                        to_char(l_payrec.amntfact/100 ),
                                                        to_char( l_dptlist(i).min_add ),
                                                                      l_payrec.dptnum ), 1, g_errmsg_dim );
                  l_payrec.amntfact := 0;
                  rollback to sp_payout;
                    BEGIN
                       SELECT d.vidd
                         INTO l_vidd
                         FROM dpt_deposit d, dpt_vidd dv
                        WHERE d.deposit_id = l_payrec.dptid
                          AND dv.vidd = d.vidd
                          AND dv.type_id IN (7, 10, 16);
                    EXCEPTION
                       WHEN NO_DATA_FOUND
                       THEN l_vidd := -1;
                    END;

                  -- якщо депозит без поповнення та рах.виплати %% = рах.вкладу - капіталіз. згідно пакету "ЕКСКЛЮЗИВ"
                  if  l_vidd > 0 and (l_payrec.amntfact >= l_dptlist(i).min_add) and check_joinpay(l_payrec.dptid, l_payrec.nlsb)
                  then
                    l_payrec.nazn := SubStr('Поповнення вкладу по договору № '||dpt_web.f_nazn('U', l_payrec.dptid), 1, 160);
                  end if;
              End If;

           Else   -- якщо мін. сума поповнення нуль или пусто
              If (check_nls4pay(l_payrec.nlsB, l_payrec.dptacc ))
              Then
                    BEGIN
                       SELECT d.vidd
                         INTO l_vidd
                         FROM dpt_deposit d, dpt_vidd dv
                        WHERE d.deposit_id = l_payrec.dptid
                          AND dv.vidd = d.vidd
                          AND dv.type_id IN (7, 10, 16);
                    EXCEPTION
                       WHEN NO_DATA_FOUND
                       THEN l_vidd := -1;
                    END;

                  -- якщо депозит без поповнення та рах.виплати %% = рах.вкладу - капіталіз. згідно пакету "ЕКСКЛЮЗИВ"
                  if  l_vidd > 0 and check_joinpay(l_payrec.dptid, l_payrec.nlsb)
                  then
                    l_payrec.nazn := SubStr('Поповнення вкладу по договору № '||dpt_web.f_nazn('U', l_payrec.dptid), 1, 160);
                  end if;
              End If;
           End If;
        End If;

        if (l_payrec.amntfact != l_payrec.amntplan) then

          l_errflg := true;

          -- наличие незавизир.документов на счете %s/%s для вклада № %s
          l_errmsg := substr( bars_msg.get_msg( g_modcode,
                                                'AUTOPAYOUTINTPL_INVALID_SALDO',
                                                l_payrec.nlsa,
                                                to_char(l_payrec.curcode),
                                                l_payrec.dptnum), 1, g_errmsg_dim );
          rollback to sp_payout;

        else

           begin
             select apl_dat
               into l_apldat
               from int_accn
              where acc = l_payrec.dptacc
                and id  = 1
                for update of apl_dat nowait;
           exception
             when others then
               l_errflg := true;
               -- ошибка блокировки %-ной карточки по деп.счету вклада № %s: %s
               l_errmsg := substr(bars_msg.get_msg(g_modcode,
                                                   'AUTOPAYOUTINTPL_LOCK_FAILED',
                                                   l_payrec.dptnum,
                                                   sqlerrm), 1, g_errmsg_dim);
               rollback to sp_payout;
           end;

           dpt_web.paydoc (p_dptid    => l_payrec.dptid,    p_vdat    => gl.bdate,
                   p_brancha  => p_branch,          p_branchb => null,
                   p_nlsa     => l_payrec.nlsa,     p_nlsb    => l_payrec.nlsb,
                   p_mfoa     => l_payrec.mfoa,     p_mfob    => l_payrec.mfob,
                   p_nama     => l_payrec.namea,    p_namb    => l_payrec.nameb,
                   p_ida      => l_payrec.ida,      p_idb     => l_payrec.idb,
                   p_kva      => l_payrec.curcode,  p_kvb     => l_payrec.curcode,
                   p_sa       => l_payrec.amntfact, p_sb      => l_payrec.amntfact,
                   p_nmk      => l_payrec.custname, p_userid  => null,
                   p_tt       => null,              p_vob     => null,
                   p_dk       => 1,                 p_sk      => null,
                   p_type     => 4,                 p_ref     => l_ref,
                   p_nazn     => l_payrec.nazn,
                   p_err_flag => l_errflg,
                   p_err_msg  => l_errmsg);

           bars_audit.trace('%s docref (%s->%s %s) = %s', c_title,
                                                          l_payrec.nlsa,
                                                          l_payrec.nlsb,
                                                          to_char(l_payrec.amntfact),
                                                          to_char(l_payrec.curcode),
                                                          to_char(l_ref));
           if (l_ref is Not Null) And (l_dptlist(i).plandate != p_bdate) then

              begin
                insert into OPER_EXT
                 (ref, kf, pay_bankdate, pay_caldate)
               values
                 (l_ref, l_payrec.mfoa, p_bdate, l_dptlist(i).plandate);
              exception when DUP_VAL_ON_INDEX then null;
              end;

              bars_audit.trace( '%s pay(bnk/sys)dat = %s/%s for ref %s', c_title,
                                to_char(p_bdate, 'dd.mm.yyyy'),
                                to_char(l_dptlist(i).plandate, 'dd.mm.yyyy'),
                                to_char(l_ref) );
           end if;
        end if;

        -- протоколирование
        if p_runid > 0 then
           dpt_jobs_audit.p_save2log (p_runid      => p_runid,
                                      p_dptid      => l_payrec.dptid,
                                      p_dealnum    => l_payrec.dptnum,
                                      p_branch     => p_branch,
                                      p_ref        => l_ref,
                                      p_rnk        => l_payrec.custid,
                                      p_nls        => l_payrec.nlsa,
                                      p_kv         => l_payrec.curcode,
                                      p_dptsum     => null,
                                      p_intsum     => l_payrec.amntfact,
                                      p_status     => (case when l_errflg then -1 else 1 end),
                                      p_errmsg     => l_errmsg,
                                      p_contractid => null);
        end if;

        if l_errflg then

           if (p_runid > 0) then
              -- ошибка выплаты процентов по вкладу № %s: %s
              bars_audit.error(bars_msg.get_msg(g_modcode,
                                               'AUTOPAYOUTINTPL_DOCPAY_FAILED',
                                               l_payrec.dptnum, l_errmsg));
           else
              bars_error.raise_nerror(g_modcode, 'PAYOUT_ERR', c_title||l_errmsg);
           end if;

           rollback to sp_payout;

        else
          update int_accn
             set apl_dat = p_bdate
           where acc = l_payrec.dptacc
             and id = 1;

          l_tmpnum := l_tmpnum + 1;

          if (p_runid > 0 and l_tmpnum >= autocommit) then
            bars_audit.trace('%s intermediate commit (%s dep. processed)', c_title, to_char(l_tmpnum));
            commit;
            l_tmpnum := 0;
          end if;

          if ( EBP.GET_ARCHIVE_DOCID( l_payrec.dptid ) > 0 )
          then
            -- відправка SMS повідомлення про виплату відсотків
               /* send_sms( l_payrec.custid, 'Po depozytu N'|| to_char(l_payrec.dptid) ||' vyplacheno protsenty u sumi '||
                      Amount2Str(l_payrec.amntfact, l_payrec.curcode) || ' na kartkovyy rakhunok '|| substr(l_payrec.nlsb,1,4)||'****'||substr(l_payrec.nlsb,-4) ||'.' );
              */-- прибрана відправка. Відправка СМС через відповідний шаблон
             null;
          end if;

        end if;

      exception
        when no_data_found then
          bars_audit.trace('%s nothing to pay for deposit № %s', c_title, to_char(l_dptlist(i).dptid));
      end;

  end loop; -- l_dptlist

  if p_dptid = 0 then
     bars_audit.info(bars_msg.get_msg (g_modcode, 'AUTOPAYOUTINTPL_DONE', p_branch));
     commit;
  end if;

end p_auto_payout_int_plan;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_AUTO_PAYOUT_INT_PLAN.sql =======
PROMPT ===================================================================================== 
