
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_dpt_stop.sql =========*** Run ***
 PROMPT ===================================================================================== 


CREATE OR REPLACE FUNCTION f_dpt_stop
 ( p_code  INT,
   p_kv    INT,
   p_nls   VARCHAR2,
   p_sum   NUMBER,
   p_dat   DATE
 )
   RETURN NUMBER
IS
--         ‘ункци€ расчета стоп-правил дл€ вкладных операций
--                       є 13.00 (13/12/2007)
--        комм.банки
-- ======================================================================================
-- p_code = 0  - стоп-правило на сумму первичного взноса
-- p_code = 1  - cтоп-правило на срок пополнени€
-- p_code = 2  - стоп-правило на ћ»Ќ»ћјЋ№Ќ”ё  сумму пополнени€
-- p_code = 22 - стоп-правило на ћј —»ћјЋ№Ќ”ё сумму пополнени€ (инд.график)
-- p_code = 23 - стоп-правило на ћј —»ћјЋ№Ќ”ё сумму пополнени€ (календ.график)
-- p_code = 24 - стоп-правило на ћј —»ћјЋ№Ќ”ё сумму пополнени€ (за весь срок)
-- p_code = 3  - стоп-правило "сумма депозита после выплаты >= миним.суммы"
-- p_code = 5  - выплата премии = конфициент DPTKF*сумму нач.%% (p_sum <- REF)
-- p_code = 6  - частичное сн€тие вклада
-- p_code = 7  - сн€тие вклада -залога по кредитному договору
-- p_code = 8  - счет заблокирован (ƒ≈ћј– )
-- p_code = 17 - стоп-правило на ограничение пополнени€ за период
-- ======================================================================================
  c_modcode constant char(3) := 'DPT';
  l_dptid    dpt_deposit.deposit_id%type;
  l_acc      dpt_deposit.acc%type;
  l_rnk      dpt_deposit.rnk%type;
  l_dat1     dpt_deposit.dat_begin%type;
  l_dat2     dpt_deposit.dat_end%type;
  l_vidd     dpt_vidd.vidd%type;
  l_termM    dpt_vidd.duration%type;
  l_termD    dpt_vidd.duration_days%type;
  l_sum0_min dpt_vidd.min_summ%type;
  l_sum_min  dpt_vidd.limit%type;
  l_sum_max  dpt_vidd.max_limit%type;
  l_lcv      tabval.lcv%type;
  l_sum0     number;
  l_sum      number;
  l_koef     number;
  l_cnt      number;
  l_cnt2     number;
  l_termadd  number;
  l_datx     date;
  ------------------------------------------
  l_nd_crd   varchar2(100);
  l_toboA    accounts.tobo%type;
  l_toboU    tobo.tobo%type;
  l_toboV    tobo.tobo%type;
  l_ins      customer.prinsider%type;
  l_type     accounts.tip%type;
  l_nls      accounts.nls%type;
  --------------------------------------

  l_termadd1 number(5);
  l_limit     dpt_deposit.limit%type;
  l_res       number(10);
  l_count_mm  number(5);
  l_dat_start date;
  l_dat_end   date;
  l_dat_s     date;
  l_dat_po    date;
  l_sum_month oper.s%type;
  l_comproc   dpt_vidd.comproc%type;
  l_is_bnal   number;
  --------------------------------------
BEGIN

  BEGIN
    SELECT d.deposit_id, d.acc, d.rnk, d.dat_begin, d.dat_end, nvl(a.tobo,'0'),
           v.vidd, nvl(v.duration,0), nvl(v.duration_days,0), t.lcv,
           nvl(v.min_summ,0)*100, nvl(v.limit,0)*100, nvl(v.max_limit,0)*100, d.limit, v.comproc, v.term_add
      INTO l_dptid, l_acc, l_rnk, l_dat1, l_dat2,
           l_toboA, l_vidd, l_termM, l_termD, l_lcv,
           l_sum0_min, l_sum_min, l_sum_max, l_limit,  l_comproc, l_termadd
      FROM dpt_deposit d, accounts a, dpt_vidd v, tabval t
     WHERE d.acc = a.acc
       AND d.vidd = v.vidd
       AND t.kv = a.kv
       AND a.nls = p_nls
       AND a.kv = p_kv ;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN 0;
  END;
       bars_audit.info('DPT_F_STOP p_sum = '||p_sum);
  -- —топ-правило на ћ»Ќ»ћјЋ№Ќ”ё сумму первичного взноса(0)
  IF p_code = 0 THEN

     IF (l_sum0_min <= 0 OR l_sum0_min <= p_sum) THEN
        RETURN 0;
     ELSE
        -- минимальна€ сумма дл€ данной операции = l_sum0_min/100
        bars_error.raise_error(c_modcode, 100,
                               trim(to_char(l_sum0_min/100,'9999999990D99')), l_lcv);
    END IF;

  -- —топ-правило на ћ»Ќ»ћјЋ№Ќ”ё сумму пополнени€ (2)
  ELSIF p_code = 2 THEN

     IF (l_sum_min <= 0) OR (l_sum_min <= p_sum) THEN
        RETURN 0 ;
     ELSE
        -- минимальна€ сумма дл€ данной операции = l_sum_min/100
        bars_error.raise_error(c_modcode, 100,
                               trim(to_char(l_sum_min/100, '9999999990D99'))||' '||p_sum, l_lcv);
     END IF;

  -- —топ-правило на ћј —»ћјЋ№Ќ”ё сумму пополнени€ по инд.графику (22)
  ELSIF p_code = 22 THEN

     IF (l_sum_max <= 0) THEN
        RETURN 0;
     ELSE

       -- кол-во полных мес€цев с момента открыти€ вклада
       SELECT floor(months_between(p_dat,l_dat1)) INTO l_cnt FROM dual;

       IF l_cnt = 0 THEN
          -- дата первичного взноса
          SELECT nvl(min(fdat),l_dat1) INTO l_dat1
            FROM saldoa
           WHERE acc = l_acc AND kos > 0 AND fdat >= l_dat1;
          -- ќбща€ сумма пополнений за первый мес€ц (индивид.график)
          SELECT nvl(sum(kos),0) INTO l_sum
            FROM saldoa
           WHERE acc = l_acc
             AND fdat > l_dat1
             AND fdat <= p_dat;
       ELSE
         -- ќбща€ сумма пополнений за последний мес€ц (индивид.график)
         SELECT nvl(sum(kos),0) INTO l_sum
           FROM saldoa
          WHERE acc = l_acc
            AND fdat >= add_months(l_dat1, l_cnt)
            AND fdat <= p_dat;
       END IF;

       IF p_sum + l_sum <= l_sum_max THEN
          RETURN 0;
       ELSE
          -- максимальна€ сумма дл€ данной операции = (l_sum_max-l_sum)/100
        bars_error.raise_error(c_modcode, 101,
                               trim(to_char(greatest((l_sum_max-l_sum)/100,0),'9999999990D99')),
                               l_lcv);
       END IF;

     END IF;

  -- стоп-правило на ћј —»ћјЋ№Ќ”ё сумму пополнени€ за последний календ.мес€ц (23)
  ELSIF p_code = 23 THEN

     IF (l_sum_max <= 0) THEN
        RETURN 0;
     ELSE
        -- последний календарный день предыдущего мес€ца
        l_datx := last_day(add_months(p_dat, -1));

        IF l_datx < l_dat1 THEN
           -- вклад был открыт в текущем мес€це
           -- дата первичного взноса средств на вклад
           SELECT nvl(min(fdat), l_dat1)
             INTO l_datx
             FROM saldoa
            WHERE acc = l_acc AND kos > 0 AND fdat >= l_dat1;
        END IF;

        -- обща€ сумма пополнений за текущий мес€ц, начина€ с 1-го числа
        SELECT nvl(sum(kos),0) INTO l_sum
          FROM saldoa
         WHERE acc = l_acc
           AND fdat > l_datx
           AND fdat <= p_dat;

        IF p_sum + l_sum <= l_sum_max THEN
           RETURN 0;
        ELSE
           -- ћаксимальна€ сумма дл€ данной операции = (l_sumA_max - l_sum)/100
           bars_error.raise_error(c_modcode, 101,
                                  trim(to_char(greatest((l_sum_max - l_sum)/100, 0),'9999999990D99')),
                                  l_lcv);
        END IF;

     END IF;

  -- стоп-правило на ћј —»ћјЋ№Ќ”ё сумму пополнени€ за весь период действи€ вклада (24)
  ELSIF p_code = 24 THEN

     IF (l_sum_max <= 0) OR (l_dat2 IS NULL) OR (l_dat2 < p_dat) THEN
        RETURN 0;
     ELSE
        -- дата первичного взноса на вклад
        SELECT nvl(min(fdat), l_dat1)
          INTO l_dat1
          FROM saldoa
         WHERE acc = l_acc AND kos > 0 AND fdat >= l_dat1 AND fdat <= p_dat;

        -- обща€ сумма пополнений за период действи€ вклада
        SELECT nvl(sum(kos),0)
      INTO l_sum
          FROM saldoa
         WHERE acc = l_acc
           AND fdat > l_dat1
           AND fdat <= l_dat2;

        IF p_sum + l_sum <= l_sum_max THEN
           RETURN 0;
        ELSE
           -- ћаксимальна€ сумма дл€ данной операции = (l_sumA_max - l_sum)/100
           bars_error.raise_error(c_modcode, 101,
                                  trim(to_char(greatest((l_sum_max - l_sum)/100,0),'9999999990D99')),
                                  l_lcv);
        END IF;
     END IF;

  -- —топ-правило на срок пополнени€(1)
  ELSIF p_code = 1 THEN

     BEGIN
       SELECT to_number(value)
         INTO l_termadd
         FROM dpt_depositw
        WHERE  tag = 'TRMAD' and dpt_id = l_dptid;
     EXCEPTION
       WHEN NO_DATA_FOUND  THEN l_termadd := -1;
       WHEN INVALID_NUMBER THEN l_termadd := -1;
     END;

     IF l_termadd > 0 THEN    -- индивид.настройки
        SELECT l_dat1
             + trunc(l_termadd * (add_months(l_dat1, l_termM) - l_dat1))
             + trunc(l_termadd * l_termD)
      INTO l_datx
          FROM dual;
     ELSIF l_termadd < 0 THEN -- настройка вида вклада
        BEGIN
          SELECT term_add INTO l_termadd
            FROM dpt_vidd
           WHERE vidd = l_vidd AND nvl(term_add,0) <> 0;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN RETURN 0;
        END;

        SELECT add_months(l_dat1, trunc(l_termadd,0))
             + trunc(mod(l_termadd,1)*100)
          INTO l_datx
          FROM dual;
     ELSE
       RETURN 0;
     END IF;

     -- проверка
     IF p_dat <= l_datx THEN
        RETURN 0;
     ELSE
        -- срок пополнени€ истек еще l_datx
        bars_error.raise_error(c_modcode, 102, to_char(l_datx,'dd/MM/yyyy'));
     END IF;

  -- сумма депозита после выплаты части вклада >= миним.суммы дл€ вида вклада (3)
  ELSIF p_code = 3 THEN

    IF fost (l_acc, p_dat) - p_sum < l_sum0_min THEN
       -- дописать!!!
       bars_error.raise_error('DPT', 126,
                              trim(to_char(l_sum0_min/100,'9999999990D99')), l_lcv);
    ELSE
       RETURN 0;
    END IF;

  -- ¬ыплата ѕ–≈ћ»» = конфициент DPTKF*сумму нач.%% (5)
  ELSIF p_code = 5 THEN

     -- обща€ сумма начисленных процентов
     BEGIN
      SELECT nvl(fkos(i.acra, l_dat1, p_dat), 0)
        INTO l_sum
        FROM dpt_deposit d, int_accn i
       WHERE d.acc = i.acc
         AND i.id = 1
         AND d.dat_end <= p_dat;
     EXCEPTION
       WHEN NO_DATA_FOUND THEN RETURN 0;
     END;

     -- значение коэфиициента
     BEGIN
       SELECT to_number(value)
         INTO l_koef
         FROM operw
        WHERE ref = p_sum AND tag = 'DPTKF';
     EXCEPTION
       WHEN NO_DATA_FOUND THEN RETURN 0;
     END;

     l_sum := l_sum * l_koef;

     RETURN l_sum;

  -- „астичное сн€тие вклада (6) (только при наличии инд.настроек по вкладу)
  ELSIF p_code = 6 THEN

     -- срок истек
     IF l_dat2 <= p_dat THEN
        RETURN p_sum;
     ELSE

        -- %% и макс.допустимое кол-во операций по сн€тию со вклада
        BEGIN
          SELECT nvl(to_number(wdprc), 0)/100, nvl(to_number(wdcnt), 0)
            INTO l_koef, l_cnt
            FROM (SELECT max(decode(tag,'WDPRC', value, '')) WDPRC,
                         max(decode(tag,'WDCNT', value, ''))  WDCNT
                    FROM dpt_depositw
                   WHERE dpt_id = l_dptid AND tag IN ('WDPRC', 'WDCNT'));
        EXCEPTION
          WHEN NO_DATA_FOUND THEN RETURN 0;
        END;

        --- сумма первичного взноса
        BEGIN
          SELECT nvl(s.kos,0) INTO l_sum0
            FROM saldoa s
           WHERE s.acc = l_acc
             AND s.fdat =
            (SELECT min(fdat) FROM saldoa WHERE acc = s.acc AND kos > 0);
    EXCEPTION
          WHEN NO_DATA_FOUND THEN RETURN 0;
        END;

        -- сумма и кол-во ƒт.оборотов
        SELECT nvl(sum(s),0), nvl(count(ref),0)
          INTO l_sum, l_cnt2
          FROM opldok
         WHERE acc = l_acc AND sos > 0 and dk = 0;

        -- Ћимит сн€ти€ со вклада
        l_sum := l_sum0 * l_koef - l_sum;

        IF l_cnt * l_koef = 0 THEN
       -- исчерпан лимит частичных сн€тий со вклада
           bars_error.raise_error(c_modcode, 103);
        ELSIF l_cnt <= l_cnt2 THEN
       -- превышено допустимое кол-во частичных сн€тий со вклада
           bars_error.raise_error(c_modcode, 104);
        ELSIF l_sum <= 0 THEN
       -- исчерпан лимит частичных сн€тий со вклада
           bars_error.raise_error(c_modcode, 105);
        ELSE
       RETURN trunc(least(p_sum, l_sum)/100, 0) * 100;
        END IF;

     END IF;


  -- —топ-правило "—чет заблокирован" (8)
  -- p_sum = 0 - на дебетование,
  -- p_sum = 1 - на кредитование

  ELSIF p_code = 8 THEN

     SELECT decode(nvl(p_sum, 0), 0, nvl(blkd,0), nvl(blkk,0))
       INTO l_koef
       FROM accounts
      WHERE acc = l_acc;

     -- —чет не заблокирован
     IF l_koef = 0 THEN
        RETURN 0;
     ELSE
        IF nvl(p_sum,0) = 0 THEN
           -- рахунок заблоковано на дебет!
           bars_error.raise_error(c_modcode, 107, to_char(l_koef));
        ELSE
           -- рахунок заблоковано на кредит!
           bars_error.raise_error(c_modcode, 108, to_char(l_koef));
        END IF;
     END IF;

  -- стоп-правило на ограничение пополнени€ за период
  ELSIF p_code = 17 then
     begin

      -- 1.вычисл€ем возможный срок пополени€, если без срока = выходим

      l_termadd := trunc(l_termadd,0);

      bars_audit.info(c_modcode || ' ƒепозит є' || l_dptid ||
                         ' “ерм≥н поповненн€: ' || l_termadd ||
                         ' м≥с€ц≥в ƒата —: ' || l_dat1 || ' —умма: ' ||
                         l_limit);

      --безсрочный вид вклада
      if nvl(l_termadd, 0) = 0 then
        bars_audit.info(c_modcode || 'безсрочный вид вклада');
        return 0;
      end if;

      -- 2.вычислить вид вклада, €вл€етс€ он пополн€емым
      l_res := dpt_web.forbidden_amount(l_acc, p_sum);
      bars_audit.info(c_modcode || '–езультат можливост≥ поповненн€: ' ||
                         l_res);
      if (l_res = 0) then
        bars_audit.info(c_modcode || 'ћожливо поповнити: ' || l_res);
        null;
      elsif (l_res = 1) then
      bars_audit.info(c_modcode || '¬клад не передбачаЇ поповненн€: ' ||
                           l_res);
      bars_error.raise_error(c_modcode, 410,'¬клад є'||l_dptid||' не передбачаЇ поповненн€!');
      else
      bars_audit.info(c_modcode ||
                           'Cума зарахуванн€ на депозитний рахунок #' ||
                           to_char(l_acc) ||
                           ' менша за м≥н≥мальну суму поповненн€ вкладу (' ||
                           to_char(l_res / 100) || ' / ' || p_kv || ')');
      bars_error.raise_error(c_modcode, 410,'Cума зарахуванн€ на депозитний рахунок #' ||
                           to_char(l_acc) ||
                           ' менша за м≥н≥мальну суму поповненн€ вкладу (' ||
                           to_char(l_res / 100) || ' / ' || p_kv || ')');
      end if;

      -- 3.проверить можно ли его пополнить в указанных сроках на виде вклада
      l_dat_start := l_dat1;
      l_dat_end   := add_months(l_dat1, l_termadd) - 1;

      bars_audit.info(c_modcode || 'ѕер≥од можливого поповненн€ ƒепозиту є' ||
                         l_dptid || ' ' || l_dat_start || ' - ' ||
                         l_dat_end);

      if --¬се ќ , пополн€ть можно
      p_dat between l_dat_start and l_dat_end then
      bars_audit.info(c_modcode || 'ƒепозит є' || l_dptid ||
                           ' пополн€ть можно ');
      null;
      else
         bars_audit.info(c_modcode || 'ѕо ƒепозиту є' || l_dptid ||
                           ' зак≥чивс€ терм≥н поповненн€! ¬клад можливо було поповнювати прот€гом ' ||
                           to_char(l_termadd) || ' м≥c€ц≥в.');
      -- «акончилс€ срок пополнени€
       bars_error.raise_error(c_modcode, 410,'ѕо ƒепозиту є' || l_dptid ||
                           ' зак≥чивс€ терм≥н поповненн€! ¬клад можливо було поповнювати прот€гом ' ||
                           to_char(l_termadd) || ' м≥c€ц≥в.');
      end if;

      -- 4.вычислить граничные даты  мес€ца
      select floor(months_between(trunc(sysdate), (l_dat1)))
        into l_count_mm
        from dual;

       bars_audit.info(c_modcode ||
                         '  ≥льк≥сть повних м≥с€ц≥в по ƒепозиту є' ||
                         l_dptid || ' ' || l_count_mm);

      l_dat_s  := add_months(l_dat1, l_count_mm);
      l_dat_po := add_months(l_dat_s, 1) - 1;

      bars_audit.info(c_modcode || ' √раничн≥ дати поточного м≥с€ц€ ' ||
                         l_dat_s || ' - ' || l_dat_po);


      --5.вычислить за этот период сумму пополнений по вкладу
    if nvl(l_comproc, 0) = 0 then
     --нет капитализации-то учитываем сумму пополнени€ операций 'DP5' и 'DPL
    select nvl(sum(o.s), 0)
      into l_sum_month
      from dpt_payments p, oper o
     where p.ref = o.ref
       and p.dpt_id = l_dptid
       and o.sos >= 0
       and o.tt in ('PKD', 'OW4', 'PK!', '215', '015', '515', '013', 'R01', 'DP0', 'DP2', 'DP5', 'DPD', 'DPI', 'DPL', 'W2D', 'DBF', 'ALT',
        '24', '190', '191', '901', 'BAK', 'I00', 'IB1', 'IB1', 'OW1', 'OW5', 'SMO', 'ST2', 'PS1', 'ZMO')
       and o.pdat between l_dat_s and l_dat_po;

     else
       --есть капитализаци€-то не учитываем в сумму пополнени€ операций 'DP5' и 'DPL'
         select nvl(sum(o.s), 0)
      into l_sum_month
      from dpt_payments p, oper o
     where p.ref = o.ref
       and p.dpt_id = l_dptid
       and o.sos >=0
       and o.tt in ('PKD', 'OW4', 'PK!', '215', '015', '515', '013', 'R01', 'DP0', 'DP2', 'DPD', 'DPI', 'W2D', 'DBF', 'ALT',
                   '24', '190', '191', '901', 'BAK', 'I00', 'IB1', 'IB1', 'OW1', 'OW5', 'SMO', 'ST2', 'PS1', 'ZMO')
       and o.pdat between l_dat_s and l_dat_po;

    end if;

       bars_audit.info(c_modcode || ' —ума поповненн€ ' || l_sum_month ||
                         ' за поточний м≥с€ць ' || l_dat_s || ' - ' ||
                         l_dat_po);
       bars_audit.info(c_modcode || ' —ума поповненн€ ' || p_sum);
      -- прибавить общую сумму к сумме документу
      l_sum := l_sum_month + p_sum;

      --6.сравнить лимит депозита с полученной суммой
      -- если обща€ сумма не превышает лимит = позвол€ем вставить документ, если нет = выдаем сообщение при вставке документа
       bars_audit.info(c_modcode || ' «агальна сума: ' || l_sum ||
                         ' —умма депозиту: ' || l_limit);
      
      select count(*)
      into l_is_bnal
      from bars.dpt_depositw dw
      where dw.dpt_id = l_dptid
        and dw.tag = 'NCASH'
        and dw.value = 1;
        
      bars_audit.trace('1478 безнал: ' || l_is_bnal);
        
      if (l_count_mm = 0) and (l_is_bnal > 0) then -- первый мес€ц и безнал
       if kost(l_acc,trunc(sysdate - 1)) = 0 then -- первичный взнос
        null;
       else 
        if l_sum > l_limit * 2 then
          bars_audit.info(c_modcode || ' ѕеревищено суму л≥м≥ту ' ||
                           to_char(l_limit) || ' за м≥сць з ' ||
                           to_char(l_dat_s) || ' по ' || to_char(l_dat_po));
          bars_error.raise_error(c_modcode, 410,' ѕеревищено суму л≥м≥ту ' ||
                           to_char(l_limit) || ' за м≥сць з ' ||
                           to_char(l_dat_s) || ' по ' || to_char(l_dat_po));
         else
           return 0;                  
         end if;
       end if;  
      elsif l_sum > l_limit then
        bars_audit.info(c_modcode || ' ѕеревищено суму л≥м≥ту ' ||
                           to_char(l_limit) || ' за м≥сць з ' ||
                           to_char(l_dat_s) || ' по ' || to_char(l_dat_po));
        bars_error.raise_error(c_modcode, 410,' ѕеревищено суму л≥м≥ту ' ||
                           to_char(l_limit) || ' за м≥сць з ' ||
                           to_char(l_dat_s) || ' по ' || to_char(l_dat_po));
      else
       return 0;
      end if;

    end;

------------------------------------------------------------------------------
  ELSE
    RETURN 0;
  END IF;

  RETURN 0 ;

END f_dpt_stop ;

/
 show err;
 
PROMPT *** Create  grants  F_DPT_STOP ***
grant EXECUTE                                                                on F_DPT_STOP      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_DPT_STOP      to DPT_ROLE;
grant EXECUTE                                                                on F_DPT_STOP      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_dpt_stop.sql =========*** End ***
 PROMPT =====================================================================================
