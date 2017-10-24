

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DPT_CHARGE_INTEREST.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DPT_CHARGE_INTEREST ***

  CREATE OR REPLACE PROCEDURE BARS.DPT_CHARGE_INTEREST (p_dptid number, p_chargedamount out number
	,is_payoff number default null
)
is
  -- Донарахування при виплаті по завершенні по системну дату
    g_modcode                 constant  varchar2(3) := 'DPT';
    g_DptNotFound             constant err_codes.err_name%type := 'DPT_NOT_FOUND';
    l_err                     BOOLEAN;
    v_rc                      sys_refcursor;
    l_sdate                   constant date             := sysdate;
    l_genintid                constant int_accn.id%type := 1;
    l_freq                    dpt_deposit.freq%type;
    l_avans                   dpt_vidd.amr_metr%type;
    l_extend                  dpt_deposit.cnt_dubl%type;
    l_intpaydate              date;
	l_datend				  date;
	l_datbeg				  date;
	l_title					  varchar2(21) := 'dpt_charge_interest: ';
begin

  bars_audit.trace('%s вхідні параметри - p_dptid = %s, p_chargedamount = %s, is_payoff = %s.',
                   l_title, to_char(p_dptid), to_char(p_chargedamount), to_char(is_payoff));

  begin
    select decode(v.amr_metr, 0, 0, 1), d.dat_begin, d.dat_end, d.freq,decode(nvl(d.cnt_dubl, 0), 0, 0, 1)
      into l_avans, l_datbeg, l_datend, l_freq,l_extend
      from dpt_deposit  d,
           dpt_vidd     v,
           int_accn     i,
           accounts     a,
           tabval       t
     where d.vidd       = v.vidd
       and d.kv         = t.kv
       and d.acc        = i.acc
       and i.id         = l_genintid
       and i.acra       = a.acc
       and d.deposit_id = p_dptid;
  exception
    when no_data_found then
      bars_error.raise_nerror(g_modcode, g_DptNotFound, to_char(p_dptid));
  end;

  bars_audit.trace('%s дані по депозиту - l_avans = %s, l_datbeg = %s, l_datend = %s, l_freq = %s, l_extend = %s',
                   l_title, to_char(l_avans), to_char(l_datbeg,'dd/mm/yyyy'), to_char(l_datend,'dd/mm/yyyy'), to_char(l_freq), to_char(l_extend));

  if is_payoff = 1 then
	if l_datend is null then
		-- якщо вклад до запитання пролежав менше місяця - не донараховуємо
		if add_months(l_datbeg,1) <= sysdate then
			l_intpaydate := sysdate;
		else
			bars_audit.trace('%s вклад не пролежав місяця - тому донарахування немає.',
                   l_title);
			return;
		end if;
	else
		l_intpaydate := case when sysdate>=l_datend then l_datend else sysdate end;
	end if;
  else

  l_intpaydate := dpt.get_intpaydate (p_date    =>  l_sdate,
                                      p_datbeg  =>  l_datbeg,
                                      p_datend  =>  l_datend,
                                      p_freqid  =>  l_freq,
                                      p_advanc  =>  l_avans,
                                      p_extend  =>  l_extend);

  end if;

  bars_audit.trace('%s найближча дата виплати відсотків - l_intpaydate = %s.',
                   l_title, to_char(l_intpaydate,'dd/mm/yyyy'));

  -- додано через наявність вкладів з фрек = 360, по яких повертається дата кінець року.
  l_intpaydate := case when l_intpaydate>=bankdate then bankdate else l_intpaydate end;

  bars_audit.trace('%s найближча дата виплати відсотків (після обробки) - l_intpaydate = %s.',
                   l_title, to_char(l_intpaydate,'dd/mm/yyyy'));

  OPEN v_rc FOR
  SELECT bankdate, bars_context.extract_mfo(a.BRANCH), a.BRANCH,
  a.acc, 1, a.nls, a.kv,
  a.nbs, a.nms, t.lcv, a.daos,
  SUBSTR('Нарахування відсотків по договору №'
              	||trim(d.nd)
              	||' від '
               	||f_dat_lit(d.datz,'R'), 1, 160),
  NULL
  FROM ACCOUNTS a, DPT_DEPOSIT d, TABVAL t
  WHERE d.acc = a.acc
  AND t.kv = a.kv
  AND D.DEPOSIT_ID = p_dptid;

  bars_audit.trace('%s параметри донарахування - l_intpaydate-1 = %s.',
                   l_title, to_char(l_intpaydate-1,'dd/mm/yyyy'));

  p_make_int(v_rc,l_intpaydate-1,1,0,p_chargedamount,l_err);

   bars_audit.trace('%s після донарахування - p_chargedamount = %s.',
                   l_title, to_char(p_chargedamount));

  if l_err then
	  bars_audit.trace('%s сталася помилка донарахування',
					   l_title);
  end if;

  close v_rc;

end dpt_charge_interest;
/
show err;

PROMPT *** Create  grants  DPT_CHARGE_INTEREST ***
grant EXECUTE                                                                on DPT_CHARGE_INTEREST to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DPT_CHARGE_INTEREST.sql =========*
PROMPT ===================================================================================== 
