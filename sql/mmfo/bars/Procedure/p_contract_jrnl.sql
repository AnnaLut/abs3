

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CONTRACT_JRNL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CONTRACT_JRNL ***

  CREATE OR REPLACE PROCEDURE BARS.P_CONTRACT_JRNL 
  (p_contractype  in  contracts_journal.impexp%type,
   p_date         in  contracts_journal.dat%type)
IS
  l_title       varchar2(60);
  l_cnt_bind_td number;
  l_cnt_bind_pl number;
  l_injrnl      number(1);
  l_plrow       contract_p%rowtype;
  l_tdrow       tamozhdoc%rowtype;
  l_rstrow      tamozhdoc_reestr%rowtype;
  -- version 5.0: ����������� (���������� �� ������ �������) + �����������.
  -- version 4.0: � ������� �� �������� ����������� ��������.
  -- version 3.0: � ������� ������������ �������� �� ����� ��* �� � ����� �� ���.
  -- version 2.0: �������� ��������� "����������� ����".
BEGIN

  l_title := 'p_contract_jrnl ('||to_char(p_contractype)||', '||to_char(p_date,'dd.mm.yy')||'): ';

  bars_audit.trace('%s ������', l_title);

  IF p_date <> bankdate THEN
     bars_audit.trace('%s �������� ���� �� ����� ������� ��������� -> �����', l_title);
     RETURN;
  ELSE
     bars_audit.trace('%s ������� ������� ��� �������������� ����������', l_title);
     DELETE FROM contracts_journal WHERE dat = p_date AND impexp = p_contractype;
  END IF;

  -- =========================== � � � � � � ====================================
  IF p_contractype = 1 THEN

     -- ������� �� ��������� ����������
     FOR impP IN
        (SELECT n.dat DAT, n.userid USERID, n.pid PID, tc.impexp IMPEXP,
                tc.rnk RNK, tc.name NAME, tc.dateopen DATEOPEN, tc.s S, tc.kv KV,
                tc.benefcountry BENEFCOUNTRY, tc.benefname BENEFNAME,
                tc.control_days CONTROL_DAYS, tc.continued CONTINUED,
                p.id ID, p.idp IDP, p.fdat DAT_PL, p.s SUM_PL,
                nvl(p.kurs, 1) KURS_PL, p.kv KV_PL
           FROM contracts_journalN n, top_contracts tc, contract_p p
          WHERE n.pid = tc.pid
            AND n.idp = p.idp
            AND nvl(n.action_id, 0) >= 0
            AND n.idt IS NULL
            AND n.dat = p_date
            AND n.impexp = p_contractype
          ORDER BY n.pid, n.idp)
     LOOP

       bars_audit.trace('%s �������� � %s, ������ � %s', l_title,
                        to_char(impP.pid), to_char(impP.idp));

       l_cnt_bind_td := 0;

       -- ����� ���������� ����������, ����������� � ���������� ������� �������
       FOR binded_td IN
          (SELECT t.idt, t.name, t.datedoc, round(t.s/t.kurs) s_td,
                  t.kurs, tr.name namer, tr.dater
             FROM tamozhdoc t, tamozhdoc_reestr tr
            WHERE t.pid = impP.pid
              AND t.id  = impP.id
              AND t.idr = tr.idr(+)
            ORDER BY 1)
       LOOP

         bars_audit.trace('%s �������� � %s, ������ � %s + �� = %s', l_title,
                          to_char(impP.pid), to_char(impP.idp), to_char(binded_td.idt));

         -- ���� � 1: �������� ������� ������, � ��� ����������� � ���� ���������� ����������
         INSERT INTO contracts_journal
          (dat, userid, action_id, impexp, pid, rnk, name, dateopen,
           s, kv, benefcountry, benefname, continued, control_days,
           idt, name_td, dat_td, sum_td, kurs_td, name_rstr, dat_rstr,
           idp, dat_pl, sum_pl, kurs_pl, kv_pl)
         VALUES
          (p_date, impP.userid, 1, impP.impexp, impP.pid, impP.rnk, impP.name, impP.dateopen,
           impP.s, impP.kv, impP.benefcountry, impP.benefname, impP.continued, impP.control_days,
           binded_td.idt, binded_td.name, binded_td.datedoc, binded_td.s_td, binded_td.kurs,
           binded_td.namer, binded_td.dater,
           impP.idp, impP.dat_pl, impP.sum_pl, impP.kurs_pl, impP.kv_pl);

         l_cnt_bind_td := l_cnt_bind_td + 1;

       END LOOP; -- binded_td

       IF l_cnt_bind_td = 0 THEN

         bars_audit.trace('%s �������� � %s, ������ � %s - �����', l_title,
                          to_char(impP.pid), to_char(impP.idp));

         --���� � 2: �������� ������� ������, ��� ������� �� ��������� ���������� ����������
         INSERT INTO contracts_journal
          (dat, userid, action_id, impexp, pid, rnk, name, dateopen,
           s, kv,  benefcountry, benefname, continued, control_days,
           idp, dat_pl, sum_pl, kurs_pl, kv_pl)
         VALUES
          (p_date, impP.userid, 2, impP.impexp, impP.pid, impP.rnk, impP.name, impP.dateopen,
           impP.s, impP.kv, impP.benefcountry, impP.benefname, impP.continued, impP.control_days,
           impP.idp, impP.dat_pl, impP.sum_pl, impP.kurs_pl, impP.kv_pl);

       END IF;

     END LOOP; -- impP

     -- ���������� ��������� �� ��������� ����������
     FOR impT IN
        (SELECT n.dat DAT, n.userid USERID, n.pid PID, tc.impexp IMPEXP,
                tc.rnk RNK, tc.name NAME, tc.dateopen DATEOPEN, tc.s S, tc.kv KV,
                tc.benefcountry BENEFCOUNTRY, tc.benefname BENEFNAME,
                tc.control_days CONTROL_DAYS, tc.continued CONTINUED,
                t.id ID, t.idt IDT, t.name NAME_TD, t.datedoc DATE_TD,
                round(t.s/t.kurs) SUM_TD, t.kurs KURS_TD, tr.name NAME_R, tr.dater DATER
           FROM contracts_journalN n, top_contracts tc, tamozhdoc t, tamozhdoc_reestr tr
          WHERE n.pid = tc.pid
            AND n.idt = t.idt
            AND t.idr = tr.idr(+)
            AND nvl(n.action_id,0) >= 0
            AND n.idp IS NULL
            AND n.dat = p_date
            AND n.impexp = p_contractype
          ORDER BY n.pid, n.idt)
     LOOP

       bars_audit.trace('%s �������� � %s, �� � %s', l_title,
                        to_char(impT.pid), to_char(impT.idt));

       -- ����� ���������� � ���������� ���������� �������-��������
       BEGIN
         SELECT * INTO l_plrow
           FROM contract_p
          WHERE pid = impT.pid AND id = impT.id;
         -- �������� ������, �������� ��� "��������"
         SELECT count(*) INTO l_injrnl
           FROM contracts_journalN
          WHERE idp = l_plrow.idp
            AND dat = p_date
            AND impexp = p_contractype
            AND nvl(action_id,0) >= 0;
       EXCEPTION
         WHEN NO_DATA_FOUND THEN
           l_injrnl    := 0;
           l_plrow.idp := 0;
       END;

       IF (l_plrow.idp <> 0 AND l_injrnl = 0) THEN

         bars_audit.trace('%s �������� � %s, �� � %s + ������ �� = %s', l_title,
                          to_char(impT.pid), to_char(impT.idt), to_char(l_plrow.idp));

         -- ���� � 3: ��������� ������� ���������� ���������� � ������ ������-��������
         INSERT INTO contracts_journal
          (dat, userid, action_id, impexp, pid, rnk, name, dateopen,
           s, kv, benefcountry, benefname, continued, control_days,
           idt, name_td, dat_td, sum_td, kurs_td, name_rstr, dat_rstr,
           idp, dat_pl, sum_pl, kurs_pl, kv_pl)
         VALUES
          (p_date, impT.userid, 3, impT.impexp, impT.pid, impT.rnk, impT.name, impT.dateopen,
           impT.s, impT.kv, impT.benefcountry, impT.benefname, impT.continued, impT.control_days,
           impT.idt, impT.name_td, impT.date_td, impT.sum_td, impT.kurs_td, impT.name_r, impT.dater,
           l_plrow.idp, l_plrow.fdat, l_plrow.s, l_plrow.kurs, l_plrow.kv);

       ELSIF (l_plrow.idp <> 0 AND l_injrnl != 0) THEN

          -- ������-�������� ���� � �� ������ �������  => �� ��� ��������� � ����� � 1
          bars_audit.trace('%s �������� � %s, �� � %s + ������ �� = %s', l_title,
                           to_char(impT.pid), to_char(impT.idt), to_char(l_plrow.idp));

       ELSE

          bars_audit.trace('%s �������� � %s, �� � %s - �����', l_title,
                        to_char(impT.pid), to_char(impT.idt));

          -- ���� � 4: ��������� ���������� ���������� ��� �������
          INSERT INTO contracts_journal
           (dat, userid, action_id, impexp, pid, rnk, name, dateopen,
            s, kv, benefcountry, benefname, continued, control_days,
            idt, name_td, dat_td, sum_td, kurs_td, name_rstr, dat_rstr)
          VALUES
           (p_date, impT.userid, 4, impT.impexp, impT.pid, impT.rnk, impT.name, impT.dateopen,
            impT.s, impT.kv, impT.benefcountry, impT.benefname, impT.continued, impT.control_days,
            impT.idt, impT.name_td, impT.date_td, impT.sum_td, impT.kurs_td, impT.name_r, impT.dater);

       END IF;

     END LOOP; --impT

     -- ���������� ��������� �� ��������� ���������� (�� ����� MC*)
     FOR mcT IN
        (SELECT n.dat DAT, n.userid USERID, n.pid PID, t.impexp IMPEXP,
                t.rnk RNK, substr(TranslateDos2Win(c.doc),1,50) NAME,
                trunc(c.sdate) DATEOPEN, t.kv KV,
                to_number(c.f_country) BENEFCOUNTRY,
                substr(TranslateDos2Win(c.s_name),1,50) BENEFNAME,
                90 CONTROL_DAYS, '' CONTINUED,
                t.idt IDT, t.name NAME_TD, t.datedoc DAT_TD, round(t.s/t.kurs) S_TD,
                t.kurs KURS_TD, tr.name NAME_R, tr.dater DAT_R
           FROM contracts_journalN n, tamozhdoc t, customs_decl c, tamozhdoc_reestr tr
          WHERE n.idt = t.idt
            AND t.idt = c.idt
            AND t.idr = tr.idr(+)
            AND n.pid IS NULL
            AND nvl(n.action_id,0) >= 0
            AND n.dat = p_date
            AND n.impexp = p_contractype
          ORDER BY n.idt)
     LOOP

        bars_audit.trace('%s �����.�� � %s (�� MC*) - ��� ���������', l_title, to_char(mcT.idt));

        -- ���� � 5: ��������� �� (�� ����� MC*) ��� ���������
        INSERT INTO contracts_journal
          (dat, userid, action_id, impexp, pid, rnk, name, dateopen, kv,
           benefcountry, benefname, continued, control_days,
           idt, name_td, dat_td, sum_td, kurs_td, name_rstr, dat_rstr)
        VALUES
          (p_date, mcT.userid, 5, mcT.impexp, mcT.pid, mcT.rnk,
           mcT.name, mcT.dateopen, mcT.kv,
           mcT.benefcountry, mcT.benefname, mcT.continued, mcT.control_days,
           mcT.idt, mcT.name_td, mcT.dat_td, mcT.s_td, mcT.kurs_td, mcT.name_r, mcT.dat_r);

     END LOOP; -- mcT

  --========================== � � � � � � � ====================================
  ELSE

   -- ���������� ��������� �� ���������� ����������
   FOR expT IN
      (SELECT n.dat DAT, n.userid USERID, n.pid PID, tc.impexp IMPEXP,
              tc.rnk RNK, tc.name NAME, tc.dateopen DATEOPEN, tc.s S, tc.kv KV,
              tc.benefcountry BENEFCOUNTRY, tc.benefname BENEFNAME,
              tc.control_days CONTROL_DAYS, tc.continued CONTINUED,
              t.id ID, t.idt IDT, t.name NAME_TD, t.datedoc DATE_TD,
              t.s SUM_TD, t.kurs KURS_TD, tr.name NAMER, tr.dater DATER
         FROM contracts_journalN n, top_contracts tc, tamozhdoc t, tamozhdoc_reestr tr
        WHERE n.pid = tc.pid
          AND n.idt = t.idt
          AND t.idr = tr.idr(+)
          AND nvl(n.action_id,0) >= 0
          AND n.idp IS NULL
          AND n.dat = p_date
          AND n.impexp = p_contractype
        ORDER BY n.pid, n.idt)
   LOOP

     bars_audit.trace('%s �������� � %s, �� � %s', l_title,
                      to_char(expT.pid), to_char(expT.idt));

     l_cnt_bind_pl := 0;

     -- ����� ��������, ����������� � ��������� ������� ���������� ����������
     FOR binded_pl IN
        (SELECT p.idp, p.fdat, p.kurs, p.kv, (p.s + nvl(p.komiss,0)) * p.kurs sum_pl
           FROM contracts c, contract_p p
          WHERE p.pid = expT.pid
            AND p.id = expT.id
          ORDER BY 1)
     LOOP
       bars_audit.trace('%s �������� � %s, �� � %s + �� � %s', l_title,
                      to_char(expT.pid), to_char(expT.idt), to_char(binded_pl.idp));

       -- ���� � 1: ��������� ������� ���������� ���������� � ��� ����������� � ��� �������
       INSERT INTO contracts_journal
        (dat, userid, action_id, impexp, pid, rnk, name, dateopen,
         s, kv, benefcountry, benefname, continued, control_days,
         idt, name_td, dat_td, sum_td, kurs_td, name_rstr, dat_rstr,
         idp, dat_pl, sum_pl, kurs_pl, kv_pl)
       VALUES
        (p_date, expT.userid, 1, expT.impexp, expT.pid, expT.rnk, expT.name, expT.dateopen,
         expT.s, expT.kv, expT.benefcountry, expT.benefname, expT.continued, expT.control_days,
         expT.idt, expT.name_td, expT.date_td, expT.sum_td, expT.kurs_td, expT.namer, expT.dater,
         binded_pl.idp, binded_pl.fdat, binded_pl.sum_pl, binded_pl.kurs, binded_pl.kv);

       l_cnt_bind_pl := l_cnt_bind_pl + 1;

     END LOOP; -- binded_pl

     IF l_cnt_bind_pl = 0 THEN

        bars_audit.trace('%s �������� � %s, �� � %s - �����', l_title,
                      to_char(expT.pid), to_char(expT.idt));

        -- ���� � 2: ��������� ������� ���������� ����������, ��� ������� �� ��������� �������
        INSERT INTO contracts_journal
         (dat, userid, action_id, impexp, pid, rnk, name, dateopen,
          s, kv, benefcountry, benefname, continued, control_days,
          idt, name_td, dat_td, sum_td, kurs_td, name_rstr, dat_rstr)
        VALUES
         (p_date, expT.userid, 2, expT.impexp, expT.pid, expT.rnk, expT.name, expT.dateopen,
          expT.s, expT.kv, expT.benefcountry, expT.benefname, expT.continued, expT.control_days,
          expT.idt, expT.name_td, expT.date_td, expT.sum_td, expT.kurs_td, expT.namer, expT.dater);

     END IF;

   END LOOP;  -- expT

   -- ���������� ��������� �� ���������� ���������� (�� ����� MC*)
   FOR mcT IN
      (SELECT n.dat DAT, n.userid USERID, n.pid PID, t.impexp IMPEXP,
              t.rnk RNK, substr(TranslateDos2Win(c.doc),1,50) NAME,
              trunc(c.sdate) DATEOPEN, t.kv KV,
              to_number(c.f_country) BENEFCOUNTRY,
              substr(TranslateDos2Win(c.r_name),1,50) BENEFNAME,
              90 CONTROL_DAYS, '' CONTINUED,
              t.idt IDT, t.name NAME_TD, t.datedoc DAT_TD, t.s S_TD,
              t.kurs KURS_TD, tr.name NAME_R, tr.dater DAT_R
         FROM contracts_journalN n, tamozhdoc t, customs_decl c, tamozhdoc_reestr tr
        WHERE n.idt = t.idt
          AND t.idt = c.idt
          AND t.idr = tr.idr(+)
          AND n.pid IS NULL
          AND nvl(n.action_id, 0) >= 0
          AND n.dat = p_date
          AND n.impexp = p_contractype
        ORDER BY n.idt)
   LOOP

     -- ���� � 3: ��������� ��  ��� ���������
     bars_audit.trace('%s �����.�� � %s (�� MC*) - ��� ���������', l_title, to_char(mcT.idt));

     INSERT INTO contracts_journal
      (dat, userid, action_id, impexp, pid, rnk, name, dateopen,
       kv, benefcountry, benefname, continued, control_days,
       idt, name_td, dat_td, sum_td, kurs_td, name_rstr, dat_rstr)
     VALUES
      (p_date, mcT.userid, 3, mcT.impexp, mcT.pid, mcT.rnk, mcT.name, mcT.dateopen,
       mcT.kv, mcT.benefcountry, mcT.benefname, mcT.continued, mcT.control_days,
       mcT.idt, mcT.name_td, mcT.dat_td, mcT.s_td, mcT.kurs_td, mcT.name_r, mcT.dat_r);

   END LOOP; -- mcT

   -- ������� �� ���������� ����������
   FOR expP IN
      (SELECT n.dat DAT, n.userid USERID, n.pid PID, tc.impexp IMPEXP,
              tc.rnk RNK, tc.name NAME, tc.dateopen DATEOPEN, tc.s S, tc.kv KV,
              tc.benefcountry BENEFCOUNTRY, tc.benefname BENEFNAME,
              tc.continued CONTINUED, tc.control_days CONTROL_DAYS,
              p.id, p.idp, p.fdat, (p.s + nvl(p.komiss,0))*p.kurs SUM_PL,
              nvl(p.kurs, 1) kurs, p.kv kv_pl
         FROM contracts_journalN n, top_contracts tc, contract_p p
        WHERE n.pid = tc.pid
          AND n.idp = p.idp
          AND nvl(n.action_id,0) >= 0
          AND n.idt IS NULL
          AND n.dat = p_date
          AND n.impexp = p_contractype
        ORDER BY n.pid, n.idp)
   LOOP

     bars_audit.trace('%s �������� � %s, �� � %s', l_title,
                        to_char(expP.pid), to_char(expP.idp));

     -- ����� ��������� � �������� ���������� ����������-������������
     BEGIN
       SELECT * INTO l_tdrow
         FROM tamozhdoc
        WHERE pid = expP.pid AND id = expP.id;
       -- ������������ ������, �������� �� "��������"
       SELECT count(*) INTO l_injrnl
         FROM contracts_journalN
        WHERE idt = l_tdrow.idt
          AND dat = p_date
          AND impexp = p_contractype
          AND nvl(action_id, 0) >= 0;
     EXCEPTION
       WHEN NO_DATA_FOUND THEN
         l_injrnl    := 0;
         l_tdrow.idt := 0;
     END;

     IF (l_tdrow.idt <> 0 AND l_injrnl = 0) THEN

       bars_audit.trace('%s �������� � %s, �� � %s + ������ �� = %s', l_title,
                        to_char(expP.pid), to_char(expP.idp), to_char(l_tdrow.idt));

       -- ����� � ���� ������� ��� ���������� ����������
       BEGIN
         SELECT * INTO l_rstrow FROM tamozhdoc_reestr WHERE idr = l_tdrow.idr;
       EXCEPTION
         WHEN NO_DATA_FOUND THEN
         l_rstrow.name := null; l_rstrow.dater := null;
       END;

       -- ���� � 4: ��������� ������� ������ � ��� ������ ���������� ����������-������������
       INSERT INTO contracts_journal
        (dat, userid, action_id, impexp, pid, rnk, name, dateopen,
         s, kv, benefcountry, benefname, continued, control_days,
         idt, name_td, dat_td, sum_td, kurs_td, name_rstr, dat_rstr,
         idp, dat_pl, sum_pl, kurs_pl, kv_pl)
       VALUES
        (p_date, expP.userid, 4, expP.impexp, expP.pid, expP.rnk, expP.name, expP.dateopen,
         expP.s, expP.kv, expP.benefcountry, expP.benefname, expP.continued, expP.control_days,
         l_tdrow.idt, l_tdrow.name, l_tdrow.datedoc, l_tdrow.s, l_tdrow.kurs,
         l_rstrow.name, l_rstrow.dater,
         expP.idp, expP.fdat, expP.sum_pl, expP.kurs, expP.kv_pl);

     ELSIF (l_tdrow.idt <> 0 AND l_injrnl != 0) THEN

       -- ���������� ����������-������������ ���� � ��� ������ ������� => ��� ��� ��������� � ����� � 1
       bars_audit.trace('%s �������� � %s, �� � %s + ������ �� = %s', l_title,
                        to_char(expP.pid), to_char(expP.idp), to_char(l_tdrow.idt));

     ELSE

       bars_audit.trace('%s �������� � %s, �� � %s - �����', l_title,
                        to_char(expP.pid), to_char(expP.idp));

       -- ���� � 5: ��������� ������ ��� ���������� ����������
       INSERT INTO contracts_journal
        (dat, userid, action_id, impexp, pid, rnk, name, dateopen,
         s, kv, benefcountry, benefname, continued, control_days,
         idp, dat_pl, sum_pl, kurs_pl, kv_pl)
       VALUES
        (p_date, expP.userid, 5, expP.impexp, expP.pid, expP.rnk, expP.name, expP.dateopen,
         expP.s, expP.kv, expP.benefcountry, expP.benefname, expP.continued, expP.control_days,
         expP.idp, expP.fdat, expP.sum_pl, expP.kurs, expP.kv_pl);

     END IF;

    END LOOP; -- expP

 END IF;

END  p_contract_jrnl;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CONTRACT_JRNL.sql =========*** E
PROMPT ===================================================================================== 
