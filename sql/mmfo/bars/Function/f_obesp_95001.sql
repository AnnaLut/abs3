
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_obesp_95001.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_OBESP_95001 (acc_ NUMBER, dat_ DATE, tp_ in number default 1) RETURN NUMBER IS
    ---------------------------------------------------------------------------------------------------------
    -- VERSION     :   20.12.2006
    ---------------------------------------------------------------------------------------------------------
    -- ������ ����� ����������� � ��� �� ���� �� ��� �������� ����� --
    ---------------------------------------------------------------------------------------------------------
    -- tp_ = 1 - ���������� ����� ������, ���. �� ������ �������
    -- tp_ = 2 - ���������� ��� ����� ������ �� ������� �����
    ---------------------------------------------------------------------------------------------------------
     SK_     NUMBER; -- suma 1 kredita   � ���
     SK_ALL_ NUMBER; -- suma 1 kredita   � ���
     SZ_     NUMBER; -- suma zaloga ALL  � ���
     R013_   CHAR(5);
     OSTC_ZO_ NUMBER; --  ����� ����� ������ � ������ ��
BEGIN
  SZ_:=0;

-- ����� 1-�� ������� �� ���� DAT_ (� ��)
  BEGIN
    SELECT Gl.P_Icurval(a.kv, Fost( a.acc, DAT_), DAT_ ),
           a.NBS||DECODE (NVL(P.R013,'1'),'9','9','1')
    INTO  SK_, R013_
    FROM ACCOUNTS a,  SPECPARAM P
    WHERE a.acc=P.acc (+) AND  a.ACC=ACC_ ;

    IF R013_='91299' OR SK_ >0 THEN  -- �� ������������� ��� ������
       SK_:=0;
    END IF;

  EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0;
  END ;

--��������� ��� �������� ������ �� ���� ������ � ��
  FOR K IN (SELECT Z.ACC, a.KV,
                             NVL(Fost( a.acc, DAT_), 0) Ostc
            FROM CC_ACCP z, ACCOUNTS a, SPECPARAM P
            WHERE Z.ACCS=ACC_ AND
                  Z.ACC=A.ACC AND
                  a.NBS = '9500' AND
                  a.acc=P.acc (+) AND
                  NVL(P.R013,'0')='1'
           )
  LOOP
    OSTC_ZO_ := Gl.P_Icurval(k.kv, K.Ostc , DAT_);

    SELECT SUM(Gl.P_Icurval(a.kv, Fost( a.acc, DAT_), DAT_ ))
    INTO  SK_ALL_
    FROM CC_ACCP z, ACCOUNTS a,  SPECPARAM P
    WHERE z.acc = k.acc and
          z.ACCS = a.acc and
          a.acc=P.acc (+) AND
          a.NBS||DECODE (NVL(P.R013,'1'),'9','9','1') <> '91299';

    if ABS(SK_) < ABS(SK_ALL_) then
       ostc_zo_ := (SK_ / SK_ALL_) * ostc_zo_;
    end if;

    sz_:=sz_+ostc_zo_;
  END LOOP;

  if tp_=1 then
     IF ABS(SK_) < ABS(sz_) THEN
        sz_ := ABS(SK_);
     END IF;
  end if;

  RETURN ABS(SZ_);
END;
/
 show err;
 
PROMPT *** Create  grants  F_OBESP_95001 ***
grant EXECUTE                                                                on F_OBESP_95001   to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_obesp_95001.sql =========*** End 
 PROMPT ===================================================================================== 
 