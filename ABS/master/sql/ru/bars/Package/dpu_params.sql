
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/dpu_params.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.DPU_PARAMS 
is
  /*
  A typical usage of these boolean constants is

         $if DPU_PARAMS.SBER $then
           --
         $else
           --
         $end
  */

  VERSION      constant pls_integer := 1;
  SBER         constant boolean     := TRUE;
  LINE8        constant boolean     := TRUE;
  HOLI         constant boolean     := FALSE; -- ����������� ���� ���������, ���� ���� ������ �� ��������
  IRR          constant boolean     := FALSE; -- ��������� ������

end DPU_PARAMS;
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/dpu_params.sql =========*** End *** 
 PROMPT ===================================================================================== 
 