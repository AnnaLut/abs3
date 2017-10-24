
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_dr_num.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_DR_NUM 
                 ( ref_ NUMBER,         -- �������� ���������
                   tag_ VARCHAR2 )      -- ���.��������
--*===============================================================================+
--| ������� ���������� �������� �������� ���.��������� �� ������������� ��������� |
--| 02.2012 ��������� �.�.                                                        |
--*===============================================================================+
RETURN NUMBER IS
 Result_     NUMBER ;  -- ������������ ��������
 Value_     bars.operw.value%type;
BEGIN
  SELECT trim(substr(value,1,decode(instr(value,' '),0,100,instr(value,' '))))
    INTO Value_
    FROM operw
   WHERE ref=ref_
     AND upper(tag)=upper(tag_);
  Result_ := to_number(replace(Value_,',','.'),'999999999D99');
  RETURN Result_;
END f_get_dr_num;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_dr_num.sql =========*** End *
 PROMPT ===================================================================================== 
 