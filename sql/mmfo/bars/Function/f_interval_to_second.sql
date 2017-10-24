
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_interval_to_second.sql =========*
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_INTERVAL_TO_SECOND 
(
int_DURATION interval day to second
)
return number
is
nSECOND number;
begin
nSECOND := to_number(extract(second from int_DURATION)) +
           to_number(extract(minute from int_DURATION)) * 60 +
           to_number(extract(hour from int_DURATION)) * 60 * 60 +
           to_number(extract(day from int_DURATION)) * 60 * 60* 24;
return(nSECOND);
end F_INTERVAL_TO_SECOND;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_interval_to_second.sql =========*
 PROMPT ===================================================================================== 
 