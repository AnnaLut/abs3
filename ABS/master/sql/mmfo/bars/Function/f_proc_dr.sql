
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_proc_dr.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_PROC_DR 
   (p_acc   INT,
    p_sour  INT       DEFAULT 4,      -- �������� ��������������
    p_type  INT       DEFAULT 0,      -- 1 = �� �����.���
    p_mode  VARCHAR2  DEFAULT NULL,   -- ��� ������
    p_nbs   VARCHAR2  DEFAULT NULL,   -- ��
    p_kv    INT       DEFAULT NULL)   -- ��� ������
RETURN INT
-- ============================================================================
--        ������� ������� ���������� ��� ���������� %%
--   �� ����������� "����� �������-�������� �� ���������� ���-���" (PROC_DR)
--
--                      ���� "�������"
--
-- 1. ��� ������, ������������ �� ����, ��������� ������� �� PROC_DR rezid=tobo
-- 2. ��� ������ "������ ���������" (p_mode='DPT') ���� �������� ������� ��
--    ��������� ���� ������ (p_type = dpt_vidd.vidd)
-- 3. ���� ��� �������� � REZID <> 0 ���� �������-�������� �� ������ � ���-��,
--    ������� ���������� ���� (rezid = 0).
-- 4. ��������� ����� ��� ������ ����.
-- ============================================================================
IS
  l_kvb    INT;
  l_kv     INT;
  l_nbs    CHAR(4);
  l_rnk    NUMBER;
  l_branch VARCHAR2(30);
  l_notax   INT;
  l_code   INT;
  l_acc67  INT;
  l_nls67  VARCHAR2(14);
 ---------------------------------------------

BEGIN

  -- ���.������
  BEGIN
    SELECT to_number(val) INTO l_kvb FROM params WHERE par = 'BASEVAL';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- erm := '9313 - No baseval found #';
      bars_error.raise_nerror('SVC', 'BASEVAL_NOT_FOUND');
  END;

  l_code  := 0;

  IF p_mode = 'MKD' THEN
    l_rnk := p_acc;
    l_nbs := p_nbs;
    l_kv  := p_kv;
    l_notax:=0;
    BEGIN
    SELECT nvl(to_number(mfo),0) INTO l_code FROM custbank WHERE rnk=l_rnk;
                                  -- ���� ������, �� ��� ��� - �� l_code:=0
    EXCEPTION
      WHEN NO_DATA_FOUND THEN l_code := 0;
    END;
--  ��������������� ���� �� �������� �������-����������� �������
--  ��������� � ���
    BEGIN
      SELECT nvl(to_number(ltrim(rtrim(value))),0)
        INTO l_notax
        FROM customerw
       WHERE rnk = l_rnk AND tag = 'NOTAX';
     EXCEPTION
      WHEN NO_DATA_FOUND  THEN   l_notax := 0;
      WHEN INVALID_NUMBER THEN   l_notax := 0;
    END;
    if l_code=0 and l_notax<>0 then
       l_code:=l_notax;   -- ������������� ��� ��� PROC_DR
    end if;
--------------����� M�������������-------------
  
  
  /*IF p_mode = 'MKD' THEN
    l_rnk := p_acc;
    l_nbs := p_nbs;
    l_kv  := p_kv;
    BEGIN
      SELECT to_number(mfo) INTO l_code FROM custbank WHERE rnk=l_rnk;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN l_code := 0;
    END;*/
  ELSE
    -- ��������� �����
    BEGIN
      SELECT a.nbs, a.kv, c.rnk,
             a.branch
        INTO l_nbs, l_kv, l_rnk, l_branch
        FROM accounts a, cust_acc c
       WHERE a.acc = c.acc AND a.acc = p_acc;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        -- erm := '9300 - No account found #'||' ('||p_acc||')';
        bars_error.raise_nerror('SVC', 'ACC_NOT_FOUND', p_acc);
    END;
  END IF;

  -------------- ������ ��������� ---------------------
  IF p_mode = 'DPT' THEN

     BEGIN
       SELECT decode(l_kv, l_kvb, g67, v67)
         INTO l_nls67
         FROM proc_dr
        WHERE nbs = l_nbs
          AND sour = p_sour
          AND nvl(rezid,0) = p_type
          AND branch = sys_context('bars_context','user_branch');
     EXCEPTION
       WHEN NO_DATA_FOUND THEN
         BEGIN
           SELECT decode(l_kv, l_kvb, g67, v67)
             INTO l_nls67
             FROM proc_dr
            WHERE nbs = l_nbs
              AND sour = p_sour
              AND nvl(rezid,0) = 0
              AND branch = sys_context('bars_context','user_branch');
         EXCEPTION
           WHEN NO_DATA_FOUND THEN l_nls67 := '-1';
         END;
     END;
------------------ ��� �������� (p_mode IS NULL) ------------------------------
  ELSE
    BEGIN
      SELECT decode(l_kv, l_kvb,
                    decode(p_type, 0, g67, nvl(g67n,g67)),
                    decode(p_type, 0, v67, nvl(v67n,v67)))
        INTO l_nls67
        FROM proc_dr
       WHERE nbs = l_nbs AND sour = p_sour AND nvl(rezid,0) = l_code;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          SELECT decode(l_kv, l_kvb,
                        decode(p_type, 0, g67, nvl(g67n,g67)),
                        decode(p_type, 0, v67, nvl(v67n,v67)))
            INTO l_nls67
            FROM proc_dr
           WHERE nbs = l_nbs AND sour = p_sour AND nvl(rezid,0) = 0;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            --erm := '9300 - No account found for (nbs,sour)g = '||'('||l_nbs||','||p_sour||')';
            --RAISE err;
            RETURN NULL;
        END;
    END;

  END IF;

  BEGIN
    SELECT acc INTO l_acc67 FROM accounts WHERE nls = l_nls67 AND kv = l_kvb;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      --erm := '9300 - No account found for nls = '||l_nls67||' !';
      --RAISE err;
      RETURN NULL;
  END;

  RETURN l_acc67;

END F_PROC_DR;
/
 show err;
 
PROMPT *** Create  grants  F_PROC_DR ***
grant EXECUTE                                                                on F_PROC_DR       to ABS_ADMIN;
grant EXECUTE                                                                on F_PROC_DR       to BARS010;
grant EXECUTE                                                                on F_PROC_DR       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_PROC_DR       to CUST001;
grant EXECUTE                                                                on F_PROC_DR       to DPT_ROLE;
grant EXECUTE                                                                on F_PROC_DR       to FOREX;
grant EXECUTE                                                                on F_PROC_DR       to RCC_DEAL;
grant EXECUTE                                                                on F_PROC_DR       to WR_ACRINT;
grant EXECUTE                                                                on F_PROC_DR       to WR_ALL_RIGHTS;
grant EXECUTE                                                                on F_PROC_DR       to WR_VIEWACC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_proc_dr.sql =========*** End *** 
 PROMPT ===================================================================================== 
 