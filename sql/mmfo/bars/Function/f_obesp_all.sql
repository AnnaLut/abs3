
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_obesp_all.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_OBESP_ALL (acc_ NUMBER, dat_ DATE) RETURN NUMBER IS
	---------------------------------------------------------------------------------------------------------
	-- ������ ����� ����������� � ��� �� ���� �� ��� �������� ����� --
	---------------------------------------------------------------------------------------------------------
	 SK_ NUMBER; -- suma 1 kredita   � ���
	 SZ_  NUMBER; -- suma zaloga ALL  � ���
	 R013_ CHAR(5);
	 OSTC_ZO_ NUMBER; --  ����� ����� ������ � ������ ��
BEGIN
  SZ_:=0;

-- ����� 1-�� ������� �� ���� DAT_ (� ��)
  BEGIN
    SELECT Gl.P_Icurval(a.kv, Rez.OSTC96( a.acc, DAT_), DAT_ ),
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
                   Rez.OSTC96( a.acc, DAT_) Ostc
            FROM CC_ACCP z, ACCOUNTS a
            WHERE Z.ACCS=ACC_ AND  Z.ACC=A.ACC
           )
  LOOP

    OSTC_ZO_ := Gl.P_Icurval(k.kv, K.Ostc , DAT_) ;

	sz_:=sz_+ostc_zo_;
  END LOOP;

   IF ABS(SK_) < ABS(sz_) THEN
	    sz_ := ABS(SK_);
   END IF;

  RETURN ABS(SZ_);
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_obesp_all.sql =========*** End **
 PROMPT ===================================================================================== 
 