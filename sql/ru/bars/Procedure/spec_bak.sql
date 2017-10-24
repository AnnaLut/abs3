

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SPEC_BAK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SPEC_BAK ***

  CREATE OR REPLACE PROCEDURE BARS.SPEC_BAK 
  ( ref_ NUMBER)  -- Reference number
IS
 -- 31-03-2010 ������. ������ � ����������� ���� ���.
 -- ������������ ������ ��� ���������� �� �������
 -- ������������ ��� ����������� ������ ��������� � �������������.

 SOS_ oper.SOS%type;
 TT_  oper.TT%type :='013';

BEGIN

  -- �������� SOS � OPER �� -2 (�����) �� +5 ��� ������������ ��������,
  -- ��������, ��� �������� �����
  begin
    SELECT sos into SOS_ FROM oper  WHERE ref = ref_ AND NVL(sos,0) <= 0
           FOR UPDATE OF SOS NOWAIT;
    update oper set sos=5 where ref=REF_;
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  END;

  -- �������� TT � OPLDOK �� BAK (�������) �� ���-�� ����������, �������� 013
  -- �.�. ���, ��������, � ���� ������� ��������.

  for k in (SELECT stmt, tt FROM opldok WHERE ref=ref_ AND tt = 'BAK'
             FOR UPDATE OF tt NOWAIT)
  loop
    update opldok set tt=TT_ where ref=REF_ and stmt=k.STMT;
  end loop;

  gl.bck( ref_, 9);

END SPEC_bak ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SPEC_BAK.sql =========*** End *** 
PROMPT ===================================================================================== 
