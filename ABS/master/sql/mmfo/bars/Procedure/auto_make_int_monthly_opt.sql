

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/AUTO_MAKE_INT_MONTHLY_OPT.sql ====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure AUTO_MAKE_INT_MONTHLY_OPT ***

  CREATE OR REPLACE PROCEDURE BARS.AUTO_MAKE_INT_MONTHLY_OPT 
  (p_dptid   IN  dpt_deposit.deposit_id%type,                -- идентификатор договора (0 - все)
   p_runid   IN  dpt_jobs_jrnl.run_id%type,                  -- є запуска автомат.задани€
   p_branch  IN  dpt_deposit.branch%type,                    -- код подразделени€
   p_bdate   IN  fdat.fdat%type,                             -- текуща€ банковска€ дата
   p_mode    IN  number)                                     -- режим запуска функции
is
  title       constant varchar2(60) := 'dptweb.automakeintmnth:';
  l_method    number;
  l_valdate   date;
  l_acrdate   date;
  l_tmp       number;
  l_error     boolean;
  l_cursor    integer;
  l_tmpnum    integer;
  int_statement long;
  
  procedure igen_intstatement
  (p_method    in  number,
   p_dptid     in  number,
   p_statement out long)
is
  title      varchar2(60)     := 'dptweb.igenintstmt:';
  nlchr      constant char(2) := chr(13)||chr(10);
  l_subquery varchar2(4000);
  l_clause   varchar2(4000);
begin
   GL.BDATE:= DATE'2017-05-31';
  bars_audit.trace('%s entry, p_method=>%s, p_dptid=>%s', title, to_char(p_method), to_char(p_dptid));

  l_subquery := '(select deposit_id, nd, datz, rnk, acc, vidd, branch '||nlchr
              ||'   from dpt_deposit '||nlchr
              ||case when p_method = 10 then '' -- безусловно по всем депозитам
                else case when p_method = 0  then '  where branch = :p_branch '||nlchr
                          when p_method = 1  then '  where dat_end is not null  and branch = :p_branch '||nlchr
                          when p_method = 2  then '  where dat_end is null and branch = :p_branch '||nlchr
                          when p_method = 9  then '  where dat_end is not null and dat_end between :p_dat1 and :p_dat2 '||nlchr
                     end
                   ||case when p_method != 0 then '    and rownum <= rownum + 1 '||nlchr  end
                   ||case when p_dptid > 0   then '    and deposit_id = :p_dptid '||nlchr end
                end
              ||')'||nlchr;

  l_clause := case when p_method = 9 then     '   and d.branch = :p_branch '||nlchr else ' ' end;

  p_statement := 'insert into int_queue '||nlchr
               ||'   (kf, branch, deal_id, deal_num, deal_dat, cust_id, int_id, '||nlchr
               ||'    acc_id, acc_num, acc_cur, acc_nbs, acc_name, acc_iso, '||nlchr
               ||'    acc_open, acc_amount, int_details, int_tt, mod_code) '||nlchr
               ||'select '||nlchr
               ||case when p_method = 10 then '' else '/*+ ORDERED INDEX(a) INDEX(i)*/ '||nlchr end
               ||'       a.kf, a.branch, d.deposit_id, d.nd, d.datz, d.rnk, i.id, '||nlchr
               ||'       a.acc, a.nls, a.kv, a.nbs, substr(a.nms, 1, 38), t.lcv, '||nlchr
               ||'       a.daos, null, null, nvl(i.tt, ''%%1''), ''DPT'' '||nlchr
               ||'  from '||l_subquery||' d, '||nlchr
               ||'       accounts   a, '||nlchr
               ||'       int_accn   i, '||nlchr
               ||'       tabval$global t, '||nlchr
               ||'       dpt_vidd   v  '||nlchr
               ||' where d.acc        = a.acc '||nlchr
               ||'   and d.acc        = i.acc '||nlchr
               ||'   and i.id         in (1, decode(v.amr_metr, 0, 1, 3)) '||nlchr
               ||'   and a.kv         = t.kv '||nlchr
               ||'   and d.vidd       = v.vidd '||nlchr
               -- в≥дс≥каЇм вклади "до запитанн€"
               ||'   and v.vidd not in (103, 104, 106, 107, 108, 300) '||nlchr
               ||'   and (   (i.acr_dat is null) '||nlchr
               ||'        or (i.acr_dat < :p_acrdat and i.stp_dat is null) '||nlchr
               ||'        or (i.acr_dat < :p_acrdat and i.stp_dat > i.acr_dat)) '||nlchr
               ||l_clause
               ||' union all '||nlchr
               ||'select '||nlchr
               ||case when p_method = 10 then '' else '/*+ ORDERED INDEX(a) INDEX(i)*/ '||nlchr end
               ||'       b.kf, b.branch, d.deposit_id, d.nd, d.datz, d.rnk, m.id, '||nlchr
               ||'       b.acc, b.nls, b.kv, b.nbs, substr(b.nms, 1, 38), t.lcv, '||nlchr
               ||'       b.daos, null, null, nvl(m.tt, ''%%1''), ''DPT'' '||nlchr
               ||'  from '||l_subquery||' d, '||nlchr
               ||'       int_accn    i, '||nlchr
               ||'       accounts    b, '||nlchr
               ||'       int_accn    m, '||nlchr
               ||'       tabval$global t, '||nlchr
               ||'       dpt_vidd    v  '||nlchr
               ||' where d.acc       = i.acc '||nlchr
               ||'   and i.id        = 1     '||nlchr
               ||'   and i.acrb      = b.acc '||nlchr
               ||'   and b.acc       = m.acc '||nlchr
               ||'   and m.id        = 0     '||nlchr
               ||'   and b.kv        = t.kv  '||nlchr
               ||'   and v.amr_metr  = 4     '||nlchr
               ||'   and d.vidd      = v.vidd '||nlchr
               ||'   and ((m.acr_dat is null) or (m.acr_dat < :p_acrdat and m.acr_dat < m.stp_dat)) '||nlchr
               ||l_clause
;

end igen_intstatement;
begin

  -- ѕроцедура auto_make_int_monthly_opt пока заточена только под ќщадбанк

  bars_audit.trace('%s branch=>%s, bdate=>%s, runid=>%s, dptid=>%s, mode=>%s',
                   title, p_branch, to_char(p_bdate,'dd.mm.yyyy'),
                   to_char(p_runid), to_char(p_dptid), to_char(p_mode));

 

  -- дл€ ќщадбанка(SBER) граничной датой начислени€ %% €вл€етс€ последн€€ календарна€ дата мес€ца
  -- вне зависимости срочный это вклад или до востребовани€
  -- поэтому начисление выполн€ем за один проход

  -- расчет даты выполн€ени€ и граничной даты начислени€ процентов в конце мес€ца
  dpt_web.get_mnthintdates (p_bnkdate  => p_bdate,    -- текуща€ банк.дата
                    p_isfixed  => 'Y',        -- признак срочного вклада (Y-срочный, N-до востреб.)
                    p_valdate  => l_valdate,  -- дата выполнени€ начислени€
                    p_acrdate  => l_acrdate,  -- гранична€ дата начислени€
                    p_mode     => p_mode);    -- режим запуска функции

  

  l_method := 10; -- специальный метод начислени€ %% по всему массиву депозитов
  --
  igen_intstatement (l_method, p_dptid, int_statement);
  --
  if logger.trace_enabled()
  then
    logger.trace('%s int_statement: %s', title, substr(int_statement, 1, 3000));
  end if;
  --
  l_cursor := dbms_sql.open_cursor;
  begin
    dbms_sql.parse(l_cursor, int_statement, dbms_sql.native);
    dbms_sql.bind_variable(l_cursor, 'p_acrdat', l_acrdate);
    l_tmpnum := dbms_sql.execute(l_cursor);
    dbms_sql.close_cursor(l_cursor);
  exception
    when others then
      dbms_sql.close_cursor(l_cursor);
      raise;
  end;
  --
  if logger.trace_enabled()
  then
    logger.trace('%s завершено выполнение выражени€ int_statement', title);
  end if;
  --
  make_int (p_dat2      => l_acrdate,
            p_runmode   => 1,
            p_runid     => p_runid,
            p_intamount => l_tmp,
            p_errflg    => l_error);
  commit;

end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/AUTO_MAKE_INT_MONTHLY_OPT.sql ====
PROMPT ===================================================================================== 
