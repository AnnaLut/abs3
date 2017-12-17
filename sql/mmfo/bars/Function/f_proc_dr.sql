/*
update cc_vidd set name ='��������� 1510 - ������� ��������,                      where vidd = 1510   ;
update cc_vidd set name ='��������� 1513 - �������������� ��������'              where vidd = 1512   ;
update cc_vidd set name ='��������� 1513 - ������������ ��������'                where vidd = 1515   ;
update cc_vidd set name ='��������� 1521 - ������� ��������'                      where vidd = 1521   ;
update cc_vidd set name ='����i�����  1522-������� �����i �� ������i��� ����'      where vidd = 1522   ;
update cc_vidd set name ='��������� 1524 - �������  ��������������'              where vidd = 1523   ;
update cc_vidd set name ='��������� 1524 - ������� ������������'                 where vidd = 1524   ;
update cc_vidd set name ='��������� 1610  - ������� ��������'                      where vidd = 1610   ;
update cc_vidd set name ='��������� 1613 - �������������� ��������'               where vidd = 1612   ;
update cc_vidd set name ='��������� 1613 - ������������  ��������'                where vidd = 1613   ;
update cc_vidd set name ='��������� 1621 - ������� ��������'                       where vidd = 1621   ;
update cc_vidd set name ='��������� 1622--������� �������i �� ������i��� ����'     where vidd = 1622   ;
update cc_vidd set name ='��������� 1623 - �������  ��������������'               where vidd = 1623   ;
update cc_vidd set name ='��������� 1623 - �������  ������������'                 where vidd = 1624   ;

commit;
*/

CREATE OR REPLACE FUNCTION BARS.F_PROC_DR
   (p_acc   INT,
    p_sour  INT       DEFAULT 4,      -- �������� ��������������
    p_type  INT       DEFAULT 0,      -- 1 = �� �����.���
    p_mode  VARCHAR2  DEFAULT NULL,   -- ��� ������
    p_nbs   VARCHAR2  DEFAULT NULL,   -- ��
    p_kv    INT       DEFAULT NULL)   -- ��� ������
RETURN INT

--17.12.2017 Sta + 2701
--15.12.2017 Sta ��������� ��� ��22 �� ���.7017

--29.11.2017 Sta ����� � accounts �� NLS (NLSALT) = ����� �� PROC_DR 
-- ============================================================================
--        ������� ������� ���������� ��� ���������� %%
--   �� ����������� "����� �������-�������� �� ���������� ���-���" (PROC_DR)
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
  nbs_  char(4); 
  ob22_ char(2);
 ---------------------------------------------

BEGIN

  -- 06.12.2017 ������. ��� ���� ��������, �� ��������� ������ � ������ ��22

  If p_NBS in ('1510','1512','1513','1521','1522','1524','1523','1610','1612','1613','1621','1623','1624',
               '2701' ) then
--RE: 2701 (��������������) - �� ����������� ���� ��������, ������ ���� ��=7060 (��22=01)/

     If    p_nbs  in ('1510') then nbs_ := '6011'; if  p_kv = 980 then ob22_ := '01'; else ob22_:= '02'; End If ;  ---�������� ��������, �� ������� � ����� ������
     ElsIf p_nbs  in ('1512') then nbs_ := '6012'; if  p_kv = 980 then ob22_ := '01'; else ob22_:= '03'; End If ;  ---�������������� ������ (��������), �� ������� � 
     ElsIf p_nbs  in ('1513') then nbs_ := '6012'; if  p_kv = 980 then ob22_ := '01'; else ob22_:= '03'; End If ;  ---������������ ������ (��������), �� ������� � ��
     ElsIf p_nbs  in ('1521') then nbs_ := '6014'; if  p_kv = 980 then ob22_ := '01'; else ob22_:= '02'; End If ;  ---������� ��������, �� ����� ����� ������
     ElsIf p_nbs  in ('1522') then nbs_ := '6015'; if  p_kv = 980 then ob22_ := '01'; else ob22_:= '02'; End If ;  ---�������, �� ����� ����� ������ �� ���������� ����
     ElsIf p_nbs  in ('1524') then nbs_ := '6013'; if  p_kv = 980 then ob22_ := '01'; else ob22_:= '02'; End If ;  ---������������  �������, �� ����� ����� ������
     ElsIf p_nbs  in ('1523') then nbs_ := '6013'; if  p_kv = 980 then ob22_ := '03'; else ob22_:= '04'; End If ;  ---�������������� �������, �� ����� ����� ������
     ----------------------------------
     ElsIf p_nbs  in ('1610') then nbs_ := '7011'; if  p_kv = 980 then ob22_ := '01'; else ob22_:= '02'; End If ;  ---�������� �������� ����� �����
     ElsIf p_nbs  in ('1612') then nbs_ := '7012'; if  p_kv = 980 then ob22_ := '01'; else ob22_:= '02'; End If ;  ---������ (��������) ����� ����� �����ʲ
     ElsIf p_nbs  in ('1613') then nbs_ := '7012'; if  p_kv = 980 then ob22_ := '05'; else ob22_:= '06'; End If ;  ---������ (��������) ����� ����� ���ò
     ElsIf p_nbs  in ('1621') then nbs_ := '7014'; if  p_kv = 980 then ob22_ := '01'; else ob22_:= '02'; End If ;  ---������� ��������, �� ������� �� ����� �����
     ElsIf p_nbs  in ('1623') then nbs_ := '7017'; if  p_kv = 980 then ob22_ := '06'; else ob22_:= '05'; End If ;  ---�������, �� ����� ����� ������ �� ���������� ����
     ElsIf p_nbs  in ('1624') then nbs_ := '7017'; if  p_kv = 980 then ob22_ := '02'; else ob22_:= '01'; End If ;  ---������������  �������, �� ����� ����� ������
     ElsIf p_nbs  in ('2701') then nbs_ := '7060'; ob22_ := '03';
   end if;

     begin select acc into l_acc67  FROM accounts  WHERE nls = NBS_ob22(NBS_, OB22_) and kv = gl.baseval;
                  RETURN   l_acc67 ;
     EXCEPTION    WHEN NO_DATA_FOUND THEN   null;
     end;
 
  end if;

  -- ���.������
  BEGIN    SELECT to_number(val) INTO l_kvb FROM params WHERE par = 'BASEVAL';
  EXCEPTION    WHEN NO_DATA_FOUND THEN      -- erm := '9313 - No baseval found #';
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

    BEGIN  SELECT decode(l_kv, l_kvb,  decode(p_type, 0, g67, nvl(g67n,g67)),      decode(p_type, 0, v67, nvl(v67n,v67)))         INTO l_nls67      FROM proc_dr
           WHERE nbs = l_nbs AND sour = p_sour AND nvl(rezid,0) = l_code;
    EXCEPTION      WHEN NO_DATA_FOUND THEN
        BEGIN  SELECT decode(l_kv, l_kvb, decode(p_type, 0, g67, nvl(g67n,g67)),   decode(p_type, 0, v67, nvl(v67n,v67)))         INTO l_nls67        FROM proc_dr
               WHERE nbs = l_nbs AND sour = p_sour AND nvl(rezid,0) = 0;
        EXCEPTION      WHEN NO_DATA_FOUND THEN        RETURN NULL;
        END;
    END;

  END IF;

  BEGIN    SELECT acc INTO l_acc67 FROM accounts WHERE l_nls67 in (nls, NVL(nlsalt, nls) )  AND kv = l_kvb;
  EXCEPTION    WHEN NO_DATA_FOUND THEN      --erm := '9300 - No account found for nls = '||l_nls67||' !';
      --RAISE err;
      RETURN NULL;
  END;

  RETURN l_acc67;

END F_PROC_DR;
/