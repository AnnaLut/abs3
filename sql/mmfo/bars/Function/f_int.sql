PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_int.sql =========*** Run **
PROMPT ===================================================================================== 

create or replace function f_int(
                                  p_acc_id      INTEGER  -- Account number
                                  , p_calc_mode SMALLINT -- Calc code
                                  , p_from_dt   DATE     -- From date
                                  , p_end_dt    DATE     -- To   date
                                  , p_bal       DECIMAL  DEFAULT NULL
                                  , p_mode      SMALLINT DEFAULT 0
                                ) return number
is
  l_result    number;
  l_calc_mode smallint;
begin
  --≈сли не задан код расчета, то получим его из счета
  BEGIN
    select id
      into
           l_calc_mode
    from   int_accn
    where  acc = p_acc_id
           and rownum=1;
  EXCEPTION
     WHEN NO_DATA_FOUND THEN
       l_calc_mode := 1;
  END;

  acrn_otc.p_int(
                  acc_ => p_acc_id
                  , id_ => l_calc_mode
                  , dt1_ => p_from_dt
                  , dt2_ => p_end_dt
                  , int_ => l_result
                  , ost_ => p_bal
                  , mode_ => 0
                );

  return l_result;
exception
  when others then
    return 0;
end f_int;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_int.sql =========*** End **
PROMPT ===================================================================================== 