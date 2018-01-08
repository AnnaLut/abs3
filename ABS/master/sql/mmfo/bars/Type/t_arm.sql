
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_arm.sql =========*** Run *** ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_ARM force as object ( arm_code varchar2(4 char), name varchar2(140 char), application_type number(1), functions t_functions );
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_arm.sql =========*** End *** ========
 PROMPT ===================================================================================== 
 