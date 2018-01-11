
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/acc_params.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.ACC_PARAMS 
is
  /*
  A typical usage of these boolean constants is

    $if ACC_PARAMS.MMFO $then
      --
    $else
      --
    $end

  */

  VERSION      constant pls_integer := 3;
  SBER         constant boolean     := TRUE; -- ��������
  MMFO         constant boolean     := TRUE; -- �� ������ ���
  PROF         constant boolean     := TRUE;  -- � ��������� ������ �� �������
  CCK          constant boolean     := TRUE;  -- �������� ������ ��� ���������� ��������
  KOD_D6       constant boolean     := FALSE; -- � ��������� �� ���������� ��������� �� � ��.����. ������� �� ����������� KOD_D6
  CC_DEAL      constant boolean     := FALSE; -- ��� �������� �� ��������� ���� (cc_deal)
  DPT          constant boolean     := FALSE; -- ��� �������� �� ��������� ���� (dpt_dposit)
  E_DEAL       constant boolean     := FALSE; -- ��� �������� �� ��������� ���� (e_deal)
  MFOP         constant boolean     := FALSE; -- � ��������� ���������� ���� "��� ��� ����. �����"
  KAZ          constant boolean     := FALSE; -- ������������

end ACC_PARAMS;
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/acc_params.sql =========*** End *** 
 PROMPT ===================================================================================== 
 