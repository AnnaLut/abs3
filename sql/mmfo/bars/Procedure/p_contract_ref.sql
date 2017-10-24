

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CONTRACT_REF.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CONTRACT_REF ***

  CREATE OR REPLACE PROCEDURE BARS.P_CONTRACT_REF 
  (p_type   in  number,              -- тип контракта: 0 = экспорт, 1 = импорт
   p_date   in  date)                -- дата отбора платежей
IS
  -- процедура отбора платежей-претендентов на привязку к контрактам
  --
  -- version 9.1: manual = Y: для импорта отбираются платежи (26* -> 3900)
  -- version 9.0: оптимизация + возможность ручного импорта из oper-а при manual = Y
  -- version 8.0: установка блокировки при одновременном доступе
  --
  c_module   char(3)        := 'EIK';
  c_visaname char(8)        := 'VALKVISA';
  l_title    varchar2(60)   := 'p_contract_ref';
  l_baseval  tabval.kv%type := gl.baseval;
  l_impcart  tts.tt%type    := 'GO9';
  l_expcart  tts.tt%type    := 'GO8';
  l_manual   char(1);
  l_visagrp  groups.id%type;
  l_nextvisa oper.nextvisagrp%type;
  l_lockid   varchar2(128);
  l_lockreq  integer;
  l_cnt      number(38);
  l_invsum   number(38);
  l_vdate    date;

BEGIN

  l_title := l_title||' ('||to_char(p_type)||', '||to_char(p_date,'dd.mm.yy')||'): ';

  bars_audit.trace('%s запуск', l_title);

  BEGIN
    SELECT substr(val, 1, 1) INTO l_manual FROM birja WHERE par = 'EIK_HAND';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      l_manual := 'N';
  END;
  bars_audit.trace('%s признак ручного импорта платежей = %s', l_title, l_manual);

  IF p_type = 1 THEN

    -- группа доступа "вал.контроль"
    BEGIN
      SELECT idchk INTO l_visagrp
        FROM chklist
       WHERE idchk = (SELECT to_number(val) FROM params WHERE par = c_visaname);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        bars_error.raise_error(c_module, 1);
      WHEN INVALID_NUMBER THEN
        bars_error.raise_error(c_module, 2);
    END;
    bars_audit.trace('%s группа вал.контроля = %s', l_title, to_char(l_visagrp));

    l_nextvisa := lpad(chk.to_hex(l_visagrp), 2, '0');

    -- создание пользовательской блокировки с именем BARS_P_CONTRACT_REF
    dbms_lock.allocate_unique      (lockname          => 'BARS_P_CONTRACT_REF_IMP',
                                    lockhandle        => l_lockid,
                                    expiration_secs   => 3600);
    -- установка пользовательской блокировки с именем BARS_P_CONTRACT_REF_IMP
    l_lockreq := dbms_lock.request (lockhandle        => l_lockid,
                                    lockmode          => dbms_lock.x_mode,  --exclusive
                                    timeout           => 60,
                                    release_on_commit => FALSE);

    IF l_lockreq = 0 THEN

       bars_audit.trace('%s установлена блокировка <BARS_P_CONTRACT_REF_IMP>', l_title);

       FOR imp IN
          (SELECT p.ref, p.kv, p.s, p.vdat, a.acc, a.nls, a.rnk, p.nlsb, p.nazn
             FROM oper p, accounts a
            WHERE p.vdat >= p_date
              AND p.sos >= 0
              AND p.tt <> l_impcart
              AND p.dk = 1
              AND p.nextvisagrp = l_nextvisa
              AND a.kv = p.kv
              AND a.nls = decode(p.dk, 1, p.nlsa, p.nlsb)
              AND a.nbs LIKE '26%'
            UNION
           SELECT o2.ref, o2.kv, o2.s, o2.vdat, a.acc, a.nls, a.rnk, o2.nlsb, o2.nazn
             FROM oper o1, nlk_ref n, oper o2, accounts a
            WHERE o2.vdat >= p_date
              AND o1.ref = n.ref1
              AND o2.ref = n.ref2
              AND o2.tt = l_impcart
              AND o2.sos >= 0
              AND o1.dk = 1
              AND o2.nextvisagrp = l_nextvisa
              AND a.kv = o2.kv
              AND a.nls = o1.nlsa
              AND a.nbs LIKE '26%'
            UNION
           SELECT o.ref, o.kv, o.s, o.vdat, a.acc, a.nls, a.rnk, o.nlsb, o.nazn
             FROM oper o, accounts a
            WHERE o.vdat = p_date
              AND o.sos = 5
              AND o.dk = 1
              AND o.kv != l_baseval
              AND a.kv = o.kv
              AND a.nls = o.nlsa
              AND a.nbs LIKE '26%'
              AND substr(o.nlsb, 1, 4) IN ('1919', '3900')
              AND l_manual = 'Y'
            ORDER BY 1)
       LOOP

         bars_audit.trace('%s РНК = %s, REF = %s, %s -> %s, %s (%s)',
                          l_title, to_char(imp.rnk), to_char(imp.ref),
                          imp.nls, imp.nlsb, to_char(imp.s), to_char(imp.kv));

         SELECT count(*) INTO l_cnt FROM contract_p WHERE ref = imp.ref;
         bars_audit.trace('%s признак отбора в неразобр.платежи = %s', l_title, to_char(l_cnt));

         IF l_cnt = 0 THEN

            -- дата списания с клиентского счета
           SELECT min(fdat) INTO l_vdate FROM opldok WHERE ref = imp.ref AND acc = imp.acc;

           l_vdate := NVL(l_vdate, imp.vdat);
           bars_audit.trace('%s дата списания = %s', l_title, to_char(l_vdate,'dd/mm/yyyy'));

           -- сумма списания (без комиссии)
           SELECT /*+ INDEX (k XAK_REF_OPLDOK) INDEX( a XPK_ACCOUNTS) */
                  sum(decode(k.dk, 1, 1, -1) * k.s)
             INTO l_invsum
             FROM accounts a, opldok k
            WHERE a.acc = k.acc
              AND k.ref = imp.ref
              AND a.kv  = imp.kv
              AND a.nls = imp.nlsb
              AND k.tt  <> l_impcart;

           l_invsum := NVL(l_invsum, imp.s);
           bars_audit.trace('%s сумма списания = %s', l_title, to_char(l_invsum));

           BEGIN
             INSERT INTO contract_p
               (idp, ref, s, kv, fdat, rnk, acc, impexp, details)
             VALUES
               (0, imp.ref, l_invsum, imp.kv, l_vdate, imp.rnk, imp.acc, p_type, imp.nazn);
           EXCEPTION
             WHEN OTHERS THEN
               bars_audit.error (l_title||' ошибка при отборе платежа № '||to_char(imp.ref)
                                        ||': '||substr(sqlerrm, 1, 3000));
           END;

         END IF; -- l_cnt = 0

       END LOOP; -- imp

       COMMIT;
       bars_audit.trace('%s отбор документов выполнен', l_title);

       -- снятие пользовательской блокировки с именем BARS_P_CONTRACT_REF_IMP
       l_lockreq  := dbms_lock.release (lockhandle => l_lockid);
       IF l_lockreq = 0 THEN
          bars_audit.trace('%s снята блокировка <BARS_P_CONTRACT_REF_IMP>', l_title);
       END IF;

    END IF;  -- (блокировка установлена)

  ELSE

    -- создание пользовательской блокировки с именем BARS_P_CONTRACT_REF_EXP
    dbms_lock.allocate_unique      (lockname          => 'BARS_P_CONTRACT_REF_EXP',
                                    lockhandle        => l_lockid,
                                    expiration_secs   => 3600);
    -- установка пользовательской блокировки с именем BARS_P_CONTRACT_REF_EXP
    l_lockreq := dbms_lock.request (lockhandle        => l_lockid,
                                    lockmode          => dbms_lock.x_mode,-- exclusive
                                    timeout           => 60,
                                    release_on_commit => FALSE);

    IF l_lockreq = 0 THEN

       bars_audit.trace('%s установлена блокировка <BARS_P_CONTRACT_REF_EXP>', l_title);

       FOR exp IN
          (SELECT p2600.ref REF, p2603.s S, p2603.nazn NAZN,
                  p2600.vdat VDAT, c.rnk RNK, p2600.kv KV, a.acc
             FROM accounts a, oper p2603, zay_debt z, oper p2600, cust_acc c
            WHERE z.ref = p2603.ref
              AND p2603.sos = 5
              AND z.refd = p2600.ref
              AND p2600.sos = 5
              AND a.nbs LIKE '26%'
              AND a.kv = p2600.kv
              AND a.acc = c.acc
              AND p2600.vdat = p_date
              AND a.nls = decode(p2600.dk, 0, p2600.nlsa, p2600.nlsb)
            UNION
           SELECT o2.ref, o2.s, o2.nazn, o2.vdat, c.rnk, o2.kv, a.acc
             FROM nlk_ref n, oper o1, oper o2, accounts a, cust_acc c
            WHERE o2.vdat = p_date
              AND n.ref1 = o1.ref
              AND n.ref2 = o2.ref
              AND o2.tt = l_expcart
              AND o2.nlsb = a.nls
              AND o2.kv = a.kv
              AND a.acc = c.acc
              AND o2.sos >= 0
            UNION
           SELECT p.ref, p.s, p.nazn, p.vdat, c.rnk, p.kv, a.acc
             FROM oper p, accounts a, cust_acc c
            WHERE p.vdat = p_date
              AND p.sos > 0
              AND substr(p.nlsa, 1, 4) IN ('2603', '1500')
              AND substr(p.nlsb, 1, 4) IN ('2600', '2650')
              AND p.nlsb = a.nls
              AND p.kv = a.kv
              AND a.acc = c.acc
              AND l_manual = 'Y'
            ORDER BY 1)
       LOOP

         bars_audit.trace('%s РНК = %s, ref(2603->2600) = %s на %s (%s)',
                           l_title, to_char(exp.rnk), to_char(exp.ref),
                           to_char(exp.s), to_char(exp.kv));

         SELECT count(*) INTO l_cnt FROM contract_p WHERE ref = exp.ref;
         bars_audit.trace('%s признак отбора в неразобр.платежи = %s', l_title, to_char(l_cnt));

         IF l_cnt = 0 THEN

           BEGIN
             INSERT INTO contract_p
                (idp, ref, s, kv, fdat, acc, rnk, impexp, details)
             VALUES
                (0, exp.ref, exp.s, exp.kv, exp.vdat, exp.acc, exp.rnk, p_type, exp.nazn);
           EXCEPTION
              WHEN OTHERS THEN
                bars_audit.error (l_title||' ошибка при отборе платежа № '||to_char(exp.ref)
                                         ||': '||substr(sqlerrm, 1, 3000));
           END;

         END IF; -- l_cnt = 0

       END LOOP; -- exp

       COMMIT;
       bars_audit.trace('%s отбор документов выполнен', l_title);

         -- снятие пользовательской блокировки с именем BARS_P_CONTRACT_REF_EXP
       l_lockreq  := dbms_lock.release (lockhandle => l_lockid);
       IF l_lockreq = 0 THEN
          bars_audit.trace('%s снята блокировка <BARS_P_CONTRACT_REF_EXP>', l_title);
       END IF;

    END IF;  --lock

  END IF;  --импорт/ экспорт

END p_contract_ref;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CONTRACT_REF.sql =========*** En
PROMPT ===================================================================================== 
