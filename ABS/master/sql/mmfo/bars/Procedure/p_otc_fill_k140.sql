

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_OTC_FILL_K140.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_OTC_FILL_K140 ***

  CREATE OR REPLACE PROCEDURE BARS.P_OTC_FILL_K140 (p_dat in date) is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура заповнення параметру Л140 для контрагента
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 2009.  All Rights Reserved.
% VERSION     :    07/07/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   параметры:     p_dat - дата початку звітного року чи календарна
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    k140_    varchar2(1);
    kurs_    Number;
    rate_o_  Number;
    kol_day_ Number;
    dat_     date ;
    dat1_    date;
    dat2_    date;
begin
   dat_  := trunc(p_dat, 'yyyy');
    
   dat1_ := add_months(p_dat, -12);
   dat2_ := p_dat - 1;
   
   for k in (select kf from MV_KF) loop
       bc.subst_mfo(k.kf);
       
       select sum(rate_o / 100), count(*), round(sum(rate_o / 100) / count(*), 4) 
          into rate_o_, kol_day_, kurs_
       from ( select distinct vdate, rate_o
              from cur_rates$base
              where vdate between dat1_ and dat2_
                and kv = 978); 

       for k in ( select c.rnk rnk, c.okpo okpo, f.kod kod, 
                         round (f.s * 100000 / kurs_, 0) s 
                  from customer c, FIN_RNK f 
                  where f.fdat = p_dat
                    and f.kod = '2000'
                    and to_number(trim(c.okpo)) = to_number(trim(f.okpo))
                    and to_number(trim(c.okpo)) <> 0
                    and f.s is not null    
                )
          loop
             if k.s between 5000000001 and 9999999999900
             then
                k140_ := '1';
             elsif k.s between  1000000000 and 5000000000
             then
                k140_ := '2';
             elsif k.s between  200000001 and 1000000000
             then
                k140_ := '3';
             elsif k.s between  50000001 and 200000000
             then
                k140_ := '4';
             elsif k.s between  5000001 and 50000000
             then
                k140_ := '5';
             elsif k.s between  1 and 5000000
             then
                k140_ := '6';
             else
                k140_ := '9';
             end if;

             update customerw c1 set c1.value = k140_, c1.isp = 0  
             where c1.rnk = k.rnk
               and c1.tag ='K140' 
               and c1.isp = 0;

             IF SQL%ROWCOUNT = 0 THEN
                INSERT INTO customerw (rnk, tag, value, isp) 
                values (k.rnk, 'K140', k140_, 0);
             END IF;

          end loop;
          
        commit;   
   end loop;
   
   bc.home;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_OTC_FILL_K140.sql =========*** E
PROMPT ===================================================================================== 
