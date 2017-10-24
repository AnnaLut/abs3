
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tarif_conv.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TARIF_CONV (
  kod_ INTEGER,           -- ��� ������
  kv_  INTEGER,           -- ������ ��������
  nls_ VARCHAR2,          -- ���.����� �����
  s_   NUMERIC   )        -- ����� ��������

------------------------------------------------------------------
--  ������ �.�. --
--
--  ������� ���� �������� � ����������, ����:
--
--    GL.P_ICURVAL(#(KVA), F_TARIF(122,#(KVA),#(NLSA),#(S)), SYSDATE )
--
--  �������� �������, ����:
--    -   ������ ������ �� ��������� � ������� ��������;
--    -   ����� ����� ��������� ����� SMIN,SMAX � �������� ������
--        �������� �� ��� �������.
--
--  ��������������� ������� ���� �������� ��:
--
--                    F_TARIF_CONV(122,#(KVA),#(NLSA),#(S))
--
------------------------------------------------------------------

RETURN NUMERIC IS

  nkv_  NUMERIC;  -- ���.������
  bkv_  NUMERIC;  -- ������� ������ ������
  so_   NUMERIC;  -- ����� �������� � ������� ������
  min_  NUMERIC;  -- ���������� ���������� ����� ��������
  max_  NUMERIC;  -- ����������� ���������� ����� ��������
  sk_   NUMERIC;  -- ��������� ����� ��������
  tip_  NUMBER;   -- ��� ������: 0 - �������, 1 - �����
  l_acc number;

BEGIN

  BEGIN
     -- ����� ���� ������� ������ � ��������������� ����:
     SELECT kv,   nvl(smin,0), nvl(smax,0)
       INTO bkv_,     min_,        max_      ---  bkv_ - ������� ������ ������
       FROM v_tarif
      WHERE kod = kod_ ;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     RETURN 0 ;
  END ;

  IF bkv_ <> kv_ and (min_ + max_)>0 then  -- ���.�������� <> ������� ���.

     if F_TARIF(kod_,kv_,nls_,S_,1)=min_  or
        F_TARIF(kod_,kv_,nls_,S_,1)=max_       then

        sk_:=GL.P_ICURVAL(bkv_, F_TARIF(kod_,kv_,nls_,S_, 1), SYSDATE);
                                                         ---
     else

        sk_:=GL.P_ICURVAL(kv_, F_TARIF(kod_,kv_,nls_,S_), SYSDATE);

     end if;

  ELSE

    sk_:=GL.P_ICURVAL(kv_, F_TARIF(kod_,kv_,nls_,S_), SYSDATE);

  END IF;


  RETURN sk_;

END F_TARIF_CONV ;
/
 show err;
 
PROMPT *** Create  grants  F_TARIF_CONV ***
grant EXECUTE                                                                on F_TARIF_CONV    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_TARIF_CONV    to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tarif_conv.sql =========*** End *
 PROMPT ===================================================================================== 
 