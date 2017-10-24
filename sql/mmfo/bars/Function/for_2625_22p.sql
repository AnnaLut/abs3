
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/for_2625_22p.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOR_2625_22P (p_ref1 nlk_ref.ref1%TYPE)
  return number is

  FL_ int; -- = 1 выплата НА карточки (2 = что-то другое ?)

begin
  begin
     select decode(substr(nazn,1,1),'W',1,2) into FL_ from oper where ref=p_ref1;
  EXCEPTION WHEN NO_DATA_FOUND THEN FL_ := null;
  end;
  return FL_;

end for_2625_22p;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/for_2625_22p.sql =========*** End *
 PROMPT ===================================================================================== 
 