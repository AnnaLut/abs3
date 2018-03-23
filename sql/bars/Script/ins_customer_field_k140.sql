Prompt INSERT INTO CUSTOMER_FIELD TAG LIKE 'K140';
BEGIN
suda;
Insert into BARS.CUSTOMER_FIELD
   (TAG, NAME, B, U, F, TABNAME, TYPE, OPT, TABCOLUMN_CHECK, CODE, NOT_TO_EDIT)
 Values
   ('K140', 'код розміру суб''єкта господарювання (K140)', 1, 1, 1, 
    'KL_K140', 'S', 1, 'K140', 
    'OTHERS', 0);
COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/

Prompt INSERT OR UPDATE CUSTOMERW TAG='K140';
declare

k140_    varchar2(1);
kurs_    Number;
rate_o_  Number;
kol_day_ Number;

begin

   bc.subst_mfo (f_ourmfo_g());

   tuda;

   delete from customerw where tag like 'K140%' and isp = 20094;

   select sum(rate_o / 100), count(*), round(sum(rate_o / 100) / count(*), 4) 
      into rate_o_, kol_day_, kurs_
   from ( select distinct vdate, rate_o
          from cur_rates$base
          where vdate between to_date('01012016','ddmmyyyy') and 
                              to_date('31122016','ddmmyyyy')
            and kv = 978); 

   for k in ( select c.rnk rnk, c.okpo okpo, f.kod kod, 
                     round (f.s * 100000 / kurs_, 0) s 
              from customer c, FIN_RNK f 
              where f.fdat = to_date('01012017','ddmmyyyy')
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

         update customerw c1 set c1.value = k140_  
         where c1.rnk = k.rnk
           and c1.tag ='K140' 
           and c1.isp = 0;

         IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO customerw (rnk, tag, value, isp) 
            values (k.rnk, 'K140', k140_, 0);
         END IF;

      end loop;

   commit;   
end;
/


