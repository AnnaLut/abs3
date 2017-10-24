
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/kl_params.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.KL_PARAMS 
is
  /*
  A typical usage of these boolean constants is

         $if KL_PARAMS.SBER $then
           --
         $else
           --
         $end
  */

  VERSION      constant pls_integer := 1;
  SBER         constant boolean     := TRUE;  -- OSC   - ��� ���������
  TREASURY     constant boolean     := FALSE; -- KAZ   - ��� ������������ (��� ����.��������, ������ ��.��� � ��.������)
  NADRA        constant boolean     := FALSE; -- NADRA - ��� ����� �����
  SIGN         constant boolean     := TRUE;  -- SIGN  - � �������� ���������� �������/������
  FINMON       constant boolean     := TRUE;  -- FM    - � �������� �������� ������������ ������� �� �������������� � ������ �����������
  RI           constant boolean     := TRUE;  -- RI    - � �������� ��������� �������� ������� ���������� (CUSTOMER_RI)
  CLV          constant boolean     := TRUE;  -- CLV   - � ������������ ����������

end KL_PARAMS;
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/kl_params.sql =========*** End *** =
 PROMPT ===================================================================================== 
 