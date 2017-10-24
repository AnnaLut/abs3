
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_int_nazn.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_INT_NAZN 
    (p_type  CHAR,     -- ��� �����
     p_nlsM  VARCHAR2, -- �������� ����
     p_kvM   VARCHAR2, -- ������ ��������� �����
     p_nlsP  VARCHAR2, -- ���� ����������� %%
     p_kvP   VARCHAR2) -- ������ ����� ����������� %%
RETURN
  VARCHAR2
IS
  l_acc     NUMBER;
  l_nazn    VARCHAR2(160);
  l_nd      VARCHAR2(10);
  l_datd    VARCHAR2(10);
  l_nd_add  VARCHAR2(10);
  l_dat_add VARCHAR2(10);
  l_type    CHAR(3);
  l_nlsK    accounts.nls%type;
BEGIN

  IF p_type = 'SEB' THEN  /*  ������ �������� ��� SEB(AGIO)  */
    IF substr(p_nlsM,1,4) = '9129' THEN
      l_nazn := '���������� ���i�i� �� �������������� �i�i� �� ������� '
              ||p_nlsM||'/'||p_kvM||' �� ���i�� ';
    END IF;
    RETURN l_nazn;
  END IF;

  -- �������� ����������� ��� (�������� %DU)

  IF p_type = 'DPU' THEN

    BEGIN
      SELECT substr(g.nd,1,35), to_char(g.dat_z,'dd.MM.yyyy'),
             to_char(nvl(d.dpu_add,0)), to_char(d.dat_z,'dd.MM.yyyy')
        INTO l_nd, l_datD, l_nd_add, l_dat_add
        FROM dpt_u d, dpt_u g
       WHERE d.dpu_gen = g.dpu_id AND d.nls = p_nlsM AND d.kv = p_kvM;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        l_nazn := '%% �� ���. '||trim(p_nlsM)||' �� ���i��';
        RETURN l_nazn;
    END;

    IF l_nd_add <> '0' THEN
       l_nazn := '³������ ��i��� ���.����� �'||trim(l_nd_add)||
                 ' �i� '||l_dat_add||
                 ' �� ���.����� �'||trim(l_nd)||' �i� '||l_datd||
                 ' �� ���i��';
    ELSE
       l_nazn := '��������� ������� ��i��� �������� �'||trim(l_nd)||
                 ' �i� '||l_datd||' �� ���i��';
    END IF;

  -- ������� ����������� � ���������� ��� (�������� %CC)

  ELSIF p_type = 'CCK' THEN

    BEGIN
      SELECT substr(c.cc_id,1,20), to_char(c.sdate,'dd.MM.yyyy')
        INTO l_nd, l_datD
        FROM cc_deal c, nd_acc n, accounts a
       WHERE c.vidd < 1000  AND nvl(c.sos,0) <> 15
         AND c.nd = n.nd    AND n.acc = a.acc
         AND a.nls = p_nlsm AND a.kv = p_kvm;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        l_nazn := '%% �� ���. '||trim(p_nlsM)||' �� ���i��';
        RETURN l_nazn;
    END;

--  BEGIN
--    SELECT tip INTO l_type FROM accounts
--     WHERE nls = p_nlsp AND kv = to_number(p_kvp);
--  EXCEPTION
--    WHEN NO_DATA_FOUND THEN l_type := 'ODB';
--  END;

    IF substr(p_nlsp,1,4) = '3578' THEN
       l_type := 'SK0';
    ELSE
       l_type := 'ODB';
    END IF;

    l_nazn := ' ��i��� �������� �'||trim(l_nd)||' �i� '||l_datd||' �� ���i��';
    IF l_type = 'SK0' THEN
       l_nazn := '���������� ���i�i�'||l_nazn;
    ELSE
       l_nazn := '��������� �������'||l_nazn;
    END IF;

  -- ���������� ��������� �� ������������� �����

  ELSIF p_type = 'ACCC' THEN

    BEGIN
       SELECT p.nls INTO l_nlsK
         FROM accounts p, accounts a
        WHERE a.accc = p.acc AND a.nls = p_nlsM AND a.kv = p_kvM;
     EXCEPTION
       WHEN NO_DATA_FOUND THEN
         l_nazn := '%% �� ���. '||trim(p_nlsM)||' �� ���i��';
         RETURN l_nazn;
     END;

     l_nazn := '%% �� ���. '||trim(l_nlsK)||' ('||trim(p_nlsM)||') �� ���i��';

  -- �������� ��������
  ELSE

     l_nazn := '%% �� ���. '||trim(p_nlsM)||' �� ���i��';

  END IF;

  RETURN TRIM(l_nazn);
END;
/
 show err;
 
PROMPT *** Create  grants  F_INT_NAZN ***
grant EXECUTE                                                                on F_INT_NAZN      to BARS010;
grant EXECUTE                                                                on F_INT_NAZN      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_INT_NAZN      to RCC_DEAL;
grant EXECUTE                                                                on F_INT_NAZN      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_int_nazn.sql =========*** End ***
 PROMPT ===================================================================================== 
 