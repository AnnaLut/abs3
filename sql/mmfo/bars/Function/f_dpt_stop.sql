
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
--         ������� ������� ����-������ ��� �������� ��������
--                       � 13.00 (13/12/2007)
--        ����.�����
-- ======================================================================================
-- p_code = 0  - ����-������� �� ����� ���������� ������
-- p_code = 1  - c���-������� �� ���� ����������
-- p_code = 2  - ����-������� �� �����������  ����� ����������
-- p_code = 22 - ����-������� �� ������������ ����� ���������� (���.������)
-- p_code = 23 - ����-������� �� ������������ ����� ���������� (������.������)
-- p_code = 24 - ����-������� �� ������������ ����� ���������� (�� ���� ����)
-- p_code = 3  - ����-������� "����� �������� ����� ������� >= �����.�����"
-- p_code = 5  - ������� ������ = ���������� DPTKF*����� ���.%% (p_sum <- REF)
-- p_code = 6  - ��������� ������ ������
-- p_code = 7  - ������ ������ -������ �� ���������� ��������
-- p_code = 8  - ���� ������������ (������)
-- p_code = 17 - ����-������� �� ����������� ���������� �� ������
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
  l_is_bnal   dpt_depositw.value%type;
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
  -- ����-������� �� ����������� ����� ���������� ������(0)
  IF p_code = 0 THEN

     IF (l_sum0_min <= 0 OR l_sum0_min <= p_sum) THEN
        RETURN 0;
     ELSE
        -- ����������� ����� ��� ������ �������� = l_sum0_min/100
        bars_error.raise_error(c_modcode, 100,
                               trim(to_char(l_sum0_min/100,'9999999990D99')), l_lcv);
    END IF;

  -- ����-������� �� ����������� ����� ���������� (2)
  ELSIF p_code = 2 THEN

     IF (l_sum_min <= 0) OR (l_sum_min <= p_sum) THEN
        RETURN 0 ;
     ELSE
        -- ����������� ����� ��� ������ �������� = l_sum_min/100
        bars_error.raise_error(c_modcode, 100,
                               trim(to_char(l_sum_min/100, '9999999990D99'))||' '||p_sum, l_lcv);
     END IF;

  -- ����-������� �� ������������ ����� ���������� �� ���.������� (22)
  ELSIF p_code = 22 THEN

     IF (l_sum_max <= 0) THEN
        RETURN 0;
     ELSE

       -- ���-�� ������ ������� � ������� �������� ������
       SELECT floor(months_between(p_dat,l_dat1)) INTO l_cnt FROM dual;

       IF l_cnt = 0 THEN
          -- ���� ���������� ������
          SELECT nvl(min(fdat),l_dat1) INTO l_dat1
            FROM saldoa
           WHERE acc = l_acc AND kos > 0 AND fdat >= l_dat1;
          -- ����� ����� ���������� �� ������ ����� (�������.������)
          SELECT nvl(sum(kos),0) INTO l_sum
            FROM saldoa
           WHERE acc = l_acc
             AND fdat > l_dat1
             AND fdat <= p_dat;
       ELSE
         -- ����� ����� ���������� �� ��������� ����� (�������.������)
         SELECT nvl(sum(kos),0) INTO l_sum
           FROM saldoa
          WHERE acc = l_acc
            AND fdat >= add_months(l_dat1, l_cnt)
            AND fdat <= p_dat;
       END IF;

       IF p_sum + l_sum <= l_sum_max THEN
          RETURN 0;
       ELSE
          -- ������������ ����� ��� ������ �������� = (l_sum_max-l_sum)/100
        bars_error.raise_error(c_modcode, 101,
                               trim(to_char(greatest((l_sum_max-l_sum)/100,0),'9999999990D99')),
                               l_lcv);
       END IF;

     END IF;

  -- ����-������� �� ������������ ����� ���������� �� ��������� ������.����� (23)
  ELSIF p_code = 23 THEN

     IF (l_sum_max <= 0) THEN
        RETURN 0;
     ELSE
        -- ��������� ����������� ���� ����������� ������
        l_datx := last_day(add_months(p_dat, -1));

        IF l_datx < l_dat1 THEN
           -- ����� ��� ������ � ������� ������
           -- ���� ���������� ������ ������� �� �����
           SELECT nvl(min(fdat), l_dat1)
             INTO l_datx
             FROM saldoa
            WHERE acc = l_acc AND kos > 0 AND fdat >= l_dat1;
        END IF;

        -- ����� ����� ���������� �� ������� �����, ������� � 1-�� �����
        SELECT nvl(sum(kos),0) INTO l_sum
          FROM saldoa
         WHERE acc = l_acc
           AND fdat > l_datx
           AND fdat <= p_dat;

        IF p_sum + l_sum <= l_sum_max THEN
           RETURN 0;
        ELSE
           -- ������������ ����� ��� ������ �������� = (l_sumA_max - l_sum)/100
           bars_error.raise_error(c_modcode, 101,
                                  trim(to_char(greatest((l_sum_max - l_sum)/100, 0),'9999999990D99')),
                                  l_lcv);
        END IF;

     END IF;

  -- ����-������� �� ������������ ����� ���������� �� ���� ������ �������� ������ (24)
  ELSIF p_code = 24 THEN

     IF (l_sum_max <= 0) OR (l_dat2 IS NULL) OR (l_dat2 < p_dat) THEN
        RETURN 0;
     ELSE
        -- ���� ���������� ������ �� �����
        SELECT nvl(min(fdat), l_dat1)
          INTO l_dat1
          FROM saldoa
         WHERE acc = l_acc AND kos > 0 AND fdat >= l_dat1 AND fdat <= p_dat;

        -- ����� ����� ���������� �� ������ �������� ������
        SELECT nvl(sum(kos),0)
      INTO l_sum
          FROM saldoa
         WHERE acc = l_acc
           AND fdat > l_dat1
           AND fdat <= l_dat2;

        IF p_sum + l_sum <= l_sum_max THEN
           RETURN 0;
        ELSE
           -- ������������ ����� ��� ������ �������� = (l_sumA_max - l_sum)/100
           bars_error.raise_error(c_modcode, 101,
                                  trim(to_char(greatest((l_sum_max - l_sum)/100,0),'9999999990D99')),
                                  l_lcv);
        END IF;
     END IF;

  -- ����-������� �� ���� ����������(1)
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

     IF l_termadd > 0 THEN    -- �������.���������
        SELECT l_dat1
             + trunc(l_termadd * (add_months(l_dat1, l_termM) - l_dat1))
             + trunc(l_termadd * l_termD)
      INTO l_datx
          FROM dual;
     ELSIF l_termadd < 0 THEN -- ��������� ���� ������
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

     -- ��������
     IF p_dat <= l_datx THEN
        RETURN 0;
     ELSE
        -- ���� ���������� ����� ��� l_datx
        bars_error.raise_error(c_modcode, 102, to_char(l_datx,'dd/MM/yyyy'));
     END IF;

  -- ����� �������� ����� ������� ����� ������ >= �����.����� ��� ���� ������ (3)
  ELSIF p_code = 3 THEN

    IF fost (l_acc, p_dat) - p_sum < l_sum0_min THEN
       -- ��������!!!
       bars_error.raise_error('DPT', 126,
                              trim(to_char(l_sum0_min/100,'9999999990D99')), l_lcv);
    ELSE
       RETURN 0;
    END IF;

  -- ������� ������ = ���������� DPTKF*����� ���.%% (5)
  ELSIF p_code = 5 THEN

     -- ����� ����� ����������� ���������
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

     -- �������� ������������
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

  -- ��������� ������ ������ (6) (������ ��� ������� ���.�������� �� ������)
  ELSIF p_code = 6 THEN

     -- ���� �����
     IF l_dat2 <= p_dat THEN
        RETURN p_sum;
     ELSE

        -- %% � ����.���������� ���-�� �������� �� ������ �� ������
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

        --- ����� ���������� ������
        BEGIN
          SELECT nvl(s.kos,0) INTO l_sum0
            FROM saldoa s
           WHERE s.acc = l_acc
             AND s.fdat =
            (SELECT min(fdat) FROM saldoa WHERE acc = s.acc AND kos > 0);
    EXCEPTION
          WHEN NO_DATA_FOUND THEN RETURN 0;
        END;

        -- ����� � ���-�� ��.��������
        SELECT nvl(sum(s),0), nvl(count(ref),0)
          INTO l_sum, l_cnt2
          FROM opldok
         WHERE acc = l_acc AND sos > 0 and dk = 0;

        -- ����� ������ �� ������
        l_sum := l_sum0 * l_koef - l_sum;

        IF l_cnt * l_koef = 0 THEN
       -- �������� ����� ��������� ������ �� ������
           bars_error.raise_error(c_modcode, 103);
        ELSIF l_cnt <= l_cnt2 THEN
       -- ��������� ���������� ���-�� ��������� ������ �� ������
           bars_error.raise_error(c_modcode, 104);
        ELSIF l_sum <= 0 THEN
       -- �������� ����� ��������� ������ �� ������
           bars_error.raise_error(c_modcode, 105);
        ELSE
       RETURN trunc(least(p_sum, l_sum)/100, 0) * 100;
        END IF;

     END IF;


  -- ����-������� "���� ������������" (8)
  -- p_sum = 0 - �� �����������,
  -- p_sum = 1 - �� ������������

  ELSIF p_code = 8 THEN

     SELECT decode(nvl(p_sum, 0), 0, nvl(blkd,0), nvl(blkk,0))
       INTO l_koef
       FROM accounts
      WHERE acc = l_acc;

     -- ���� �� ������������
     IF l_koef = 0 THEN
        RETURN 0;
     ELSE
        IF nvl(p_sum,0) = 0 THEN
           -- ������� ����������� �� �����!
           bars_error.raise_error(c_modcode, 107, to_char(l_koef));
        ELSE
           -- ������� ����������� �� ������!
           bars_error.raise_error(c_modcode, 108, to_char(l_koef));
        END IF;
     END IF;

  -- ����-������� �� ����������� ���������� �� ������
  ELSIF p_code = 17 then
     begin

      -- 1.��������� ��������� ���� ���������, ���� ��� ����� = �������

      l_termadd := trunc(l_termadd,0);

      bars_audit.info(c_modcode || ' ������� �' || l_dptid ||
                         ' ����� ����������: ' || l_termadd ||
                         ' ������ ���� �: ' || l_dat1 || ' �����: ' ||
                         l_limit);

      --���������� ��� ������
      if nvl(l_termadd, 0) = 0 then
        bars_audit.info(c_modcode || '���������� ��� ������');
        return 0;
      end if;

      -- 2.��������� ��� ������, �������� �� �����������
      l_res := dpt_web.forbidden_amount(l_acc, p_sum);
      bars_audit.info(c_modcode || '��������� ��������� ����������: ' ||
                         l_res);
      if (l_res = 0) then
        bars_audit.info(c_modcode || '������� ���������: ' || l_res);
        null;
      elsif (l_res = 1) then
      bars_audit.info(c_modcode || '����� �� ��������� ����������: ' ||
                           l_res);
      bars_error.raise_error(c_modcode, 410,'����� �'||l_dptid||' �� ��������� ����������!');
      else
      bars_audit.info(c_modcode ||
                           'C��� ����������� �� ���������� ������� #' ||
                           to_char(l_acc) ||
                           ' ����� �� ��������� ���� ���������� ������ (' ||
                           to_char(l_res / 100) || ' / ' || p_kv || ')');
      bars_error.raise_error(c_modcode, 410,'C��� ����������� �� ���������� ������� #' ||
                           to_char(l_acc) ||
                           ' ����� �� ��������� ���� ���������� ������ (' ||
                           to_char(l_res / 100) || ' / ' || p_kv || ')');
      end if;

      -- 3.��������� ����� �� ��� ��������� � ��������� ������ �� ���� ������
      l_dat_start := l_dat1;
      l_dat_end   := add_months(l_dat1, l_termadd) - 1;

      bars_audit.info(c_modcode || '����� ��������� ���������� �������� �' ||
                         l_dptid || ' ' || l_dat_start || ' - ' ||
                         l_dat_end);

      if --��� ��, ��������� �����
      p_dat between l_dat_start and l_dat_end then
      bars_audit.info(c_modcode || '������� �' || l_dptid ||
                           ' ��������� ����� ');
      null;
      else
         bars_audit.info(c_modcode || '�� �������� �' || l_dptid ||
                           ' �������� ����� ����������! ����� ������� ���� ����������� �������� ' ||
                           to_char(l_termadd) || ' �c����.');
      -- ���������� ���� ����������
       bars_error.raise_error(c_modcode, 410,'�� �������� �' || l_dptid ||
                           ' �������� ����� ����������! ����� ������� ���� ����������� �������� ' ||
                           to_char(l_termadd) || ' �c����.');
      end if;

      -- 4.��������� ��������� ����  ������
      select floor(months_between(trunc(sysdate), (l_dat1)))
        into l_count_mm
        from dual;

       bars_audit.info(c_modcode ||
                         ' ʳ������ ������ ������ �� �������� �' ||
                         l_dptid || ' ' || l_count_mm);

      l_dat_s  := add_months(l_dat1, l_count_mm);
      l_dat_po := add_months(l_dat_s, 1) - 1;

      bars_audit.info(c_modcode || ' �������� ���� ��������� ����� ' ||
                         l_dat_s || ' - ' || l_dat_po);


      --5.��������� �� ���� ������ ����� ���������� �� ������
    if nvl(l_comproc, 0) = 0 then
     --��� �������������-�� ��������� ����� ���������� �������� 'DP5' � 'DPL
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
       --���� �������������-�� �� ��������� � ����� ���������� �������� 'DP5' � 'DPL'
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

       bars_audit.info(c_modcode || ' ���� ���������� ' || l_sum_month ||
                         ' �� �������� ����� ' || l_dat_s || ' - ' ||
                         l_dat_po);
       bars_audit.info(c_modcode || ' ���� ���������� ' || p_sum);
      -- ��������� ����� ����� � ����� ���������
      l_sum := l_sum_month + p_sum;

      --6.�������� ����� �������� � ���������� ������
      -- ���� ����� ����� �� ��������� ����� = ��������� �������� ��������, ���� ��� = ������ ��������� ��� ������� ���������
       bars_audit.info(c_modcode || ' �������� ����: ' || l_sum ||
                         ' ����� ��������: ' || l_limit);
      
      l_is_bnal := bars.dpt.f_dptw(l_dptid, 'NCASH');
        
      bars_audit.trace('1478 ������: ' || l_is_bnal);
        
      if (l_count_mm = 0) and (l_is_bnal ='1') then -- ������ ����� � ������
       if kost(l_acc,trunc(sysdate - 1)) = 0 then -- ��������� �����
        null;
       else
        if l_sum > l_limit * 2 then
          bars_audit.info(c_modcode || ' ���������� ���� ���� ' ||
                           to_char(l_limit) || ' �� ���� � ' ||
                           to_char(l_dat_s) || ' �� ' || to_char(l_dat_po));
          bars_error.raise_error(c_modcode, 410,' ���������� ���� ���� ' ||
                           to_char(l_limit) || ' �� ���� � ' ||
                           to_char(l_dat_s) || ' �� ' || to_char(l_dat_po));
         else
           return 0;                  
         end if;
        end if; 
      elsif l_sum > l_limit then
        bars_audit.info(c_modcode || ' ���������� ���� ���� ' ||
                           to_char(l_limit) || ' �� ���� � ' ||
                           to_char(l_dat_s) || ' �� ' || to_char(l_dat_po));
        bars_error.raise_error(c_modcode, 410,' ���������� ���� ���� ' ||
                           to_char(l_limit) || ' �� ���� � ' ||
                           to_char(l_dat_s) || ' �� ' || to_char(l_dat_po));
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
