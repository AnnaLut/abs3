
 
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

  VERSION      constant pls_integer := 2;
  SBER         constant boolean     := TRUE; -- Ощадбанк
  MMFO         constant boolean     := TRUE; -- БД мульти МФО
  LINE8        constant boolean     := TRUE;
  HOLI         constant boolean     := FALSE; -- перенесення дати закінчення, якщо вона випадає на вихідний
  IRR          constant boolean     := FALSE; -- ефективна ставка

end DPU_PARAMS;
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/dpu_params.sql =========*** End *** 
 PROMPT ===================================================================================== 
 