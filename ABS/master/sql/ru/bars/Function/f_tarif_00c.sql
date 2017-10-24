
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tarif_00c.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TARIF_00C 
                 ( kod_  INTEGER,      -- ��� ������
                   kv_   INTEGER,      -- ������ ��������
                   nls_  VARCHAR2,     -- ���.����� �����
                   s_    NUMERIC )     -- ����� ��������
-----------------------------------------------------------------------------
--                        � � � � � � �:
--  ���� ����� ������ �� ���� � �������� "00�"  > 10 ��� EUR, �� ����
--  ����� �������� �� 1%, � 0.5%.  ��� ������ �� �������� �� "�����"
--  ������ 32.
--
--  �������� � K02 ������� �����  F_TARIF(32,...)  ��  F_TARIF_00C(32,...)
-----------------------------------------------------------------------------
RETURN NUMERIC IS
  sk_   numeric;  -- ��������� ����� ��������
  acc_  integer;
  bul_  boolean;

BEGIN

  Begin
     select a.ACC into acc_ from ACCOUNTS a, ACC_TARIF t where
       a.KV=kv_ and a.NLS=nls_ and a.ACC=t.ACC and t.KOD=32 ; -- ���� �� ���.������ 32
     bul_ := TRUE;

  EXCEPTION WHEN NO_DATA_FOUND then
     bul_ := FALSE;

     if p_ncurval(978,s_,gl.bd)>1000000 then
        sk_:=s_*0.005;
     else
        sk_:=f_tarif(kod_,kv_,nls_,s_);
     end if;

  End;

  if bul_ then
     sk_:=f_tarif(kod_,kv_,nls_,s_);
  end if;

  RETURN sk_;

END f_tarif_00C ;
/
 show err;
 
PROMPT *** Create  grants  F_TARIF_00C ***
grant EXECUTE                                                                on F_TARIF_00C     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_TARIF_00C     to PYOD001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tarif_00c.sql =========*** End **
 PROMPT ===================================================================================== 
 