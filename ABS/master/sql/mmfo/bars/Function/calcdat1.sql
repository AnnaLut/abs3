
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/calcdat1.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CALCDAT1 
( dat1_  date
) return date
is
  rdate_  date;
  nd_     number := 0;
  count_  number;
begin

   select count(*)
     into count_
     from holiday
    where holiday=dat1_ and kv=980;

   if count_ = 0 
   then
     return dat1_;
   else
     
     rdate_ := dat1_;
     
     loop
       
       rdate_ := rdate_-1;

       select count(*)
         into count_
         from holiday
        where holiday=rdate_
          and kv=980;

     exit when count_=0;
       nd_ := nd_+1;
     end loop;

     return dat1_-nd_-1;
     
   end if;

end CALCDAT1;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/calcdat1.sql =========*** End *** =
 PROMPT ===================================================================================== 
 