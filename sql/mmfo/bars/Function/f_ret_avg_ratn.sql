
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ret_avg_ratn.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_RET_AVG_RATN (p_acc_ in number,
                                          p_id_ in number,
                                          p_dat_ in date,
                                          p_mdate_ in date,
                                          p_ratn_ in number) return number
-- version 09/09/2013
is
    avg_ratn_ number;
begin
    select nvl(sum((ndat - bdat)*ir)/sum(ndat - bdat), p_ratn_)
    into avg_ratn_
    from (select bdat, nvl(lead(bdat) over (partition by acc order by bdat), p_mdate_) ndat, ir
            from (select p_acc_ acc, p_dat_ bdat, p_ratn_ ir
                  from dual
                    union
                  select acc, bdat, acrn_otc.fprocn(acc, p_id_, bdat) ir
                  from int_ratn
                  where acc = p_acc_ and
                        id = p_id_ and
                        bdat between p_dat_ and p_mdate_ - 1
                  )
         )
    having sum(ndat - bdat)<>0;

    return avg_ratn_;
exception
    when no_data_found then
         return p_ratn_;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ret_avg_ratn.sql =========*** End
 PROMPT ===================================================================================== 
 