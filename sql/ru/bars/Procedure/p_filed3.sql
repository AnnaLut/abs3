-- консолидация для файлу #D3
-- если значение показателя 20NNN меньше равно 1000.00 $ 
-- то выполняем консолидацию
CREATE OR REPLACE PROCEDURE BARS.p_filed3 (Dat_ DATE )  IS
kurs1_ number;

BEGIN
-------------------------------------------------------------------
   EXECUTE IMMEDIATE 'TRUNCATE TABLE V_BANKS_REPORT91';
-------------------------------------------------------------------
kurs1_ := f_ret_kurs (840, dat_);

-- сумма показателя 20NNN >= 1000.00 $ (сумма в документа) 
   INSERT INTO v_banks_report91         
         (nbuc, kodf, datf, kodp, znap) 
   select nbuc, kodf, datf, kodp, znap 
   from v_banks_report 
   where (kodf, datf, substr(kodp,3,3) ) in
   ( select t1.kodf, t1.datf, substr(t1.kodp,3,3) NNN 
     from v_banks_report t1, v_banks_report t2 
     where t1.kodf = 'D3' 
       and t1.datf = Dat_
       and substr(t1.kodp,1,2) = '20'
       and t2.kodf = t1.kodf
       and t2.datf = t1.datf 
       and substr(t1.kodp,3,3) = substr(t2.kodp,3,3)
       and substr(t2.kodp,1,2) = '10'
       and ROUND (GL.P_ICURVAL(t2.znap, t1.znap*100, Dat_) / kurs1_, 0) > 100000
   )
   order by substr(kodp,3,3), substr(kodp,1,2);

-- консолидация сумм если 
-- сумма показателя 20NNN  <  1000.00 $ (сумма в документа) 
for k in (select max(nbuc) NBUC, min(custtype) CUSTTYPE, max(NNN) NNN, 
                 kv KV, sum(sum_p) SUMP, count(*) REC
           from (select a1.nbuc, substr(a1.kodp,3,3) NNN, a1.znap OKPO, 
                        a2.znap kv, a3.znap sum_p, 
                        decode(c.custtype,1,'1',2,'2',2) custtype 
                 from v_banks_report a1, v_banks_report a2, v_banks_report a3, 
                      (select distinct custtype, okpo 
                       from customer  
                       where date_off is null) c 
                 where (a1.kodf, a1.datf, substr(a1.kodp,3,3)) in 
                           (select t1.kodf, t1.datf, substr(t1.kodp,3,3) NNN 
                            from v_banks_report t1, v_banks_report t2 
                            where t1.kodf = 'D3' 
                              and t1.datf = Dat_
                              and substr(t1.kodp,1,2) = '20'
                              and t2.kodf = t1.kodf
                              and t2.datf = t1.datf 
                              and substr(t1.kodp,3,3) = substr(t2.kodp,3,3)
                              and substr(t2.kodp,1,2) = '10'
                              and ROUND (GL.P_ICURVAL(t2.znap, t1.znap*100, Dat_) / kurs1_, 0) <= 100000
                           )
                   and substr(a1.kodp,1,2) = '31'
                   and a2.kodf = a1.kodf
                   and a2.datf = a1.datf
                   and substr(a2.kodp,1,2) = '10'
                   and a3.kodf = a2.kodf
                   and a3.datf = a2.datf
                   and substr(a3.kodp,1,2) = '20'
                   and substr(a2.kodp,3,3) = substr(a1.kodp,3,3)
                   and substr(a3.kodp,3,3) = substr(a2.kodp,3,3)
                   and trim(a1.znap) = trim(c.okpo(+))
                 order by substr(a1.kodp,3,3), substr(a1.kodp,1,2)
            ) 
          group by custtype, kv
          order by 5 desc
         )

   loop

      if k.rec = 1 
      then
         -- 1 запись
            INSERT INTO v_banks_report91         
                  (nbuc, kodf, datf, kodp, znap) 
            select nbuc, kodf, datf, kodp, znap 
            from v_banks_report 
            where kodf = 'D3'
              and datf = Dat_
              and substr(kodp,3,3) = k.nnn 
            order by substr(kodp,3,3), substr(kodp,1,2);
      else
         -- больше 1 зиписи
         INSERT INTO v_banks_report91         
               (nbuc, kodf, datf, kodp, znap) 
         VALUES
               (k.nbuc, 'D3', Dat_, '10' || k.NNN, k.KV); 

         INSERT INTO v_banks_report91         
               (nbuc, kodf, datf, kodp, znap) 
         VALUES
               (k.nbuc, 'D3', Dat_, '31' || k.NNN, decode(k.CUSTTYPE, '1', '006', '0')); 

         INSERT INTO v_banks_report91         
               (nbuc, kodf, datf, kodp, znap) 
         VALUES
               (k.nbuc, 'D3', Dat_, '20' || k.NNN, k.SUMP); 

         INSERT INTO v_banks_report91         
               (nbuc, kodf, datf, kodp, znap) 
         VALUES
               (k.nbuc, 'D3', Dat_, '35' || k.NNN, '0'); 

         INSERT INTO v_banks_report91         
               (nbuc, kodf, datf, kodp, znap) 
         VALUES
               (k.nbuc, 'D3', Dat_, '42' || k.NNN, '01'); 

         INSERT INTO v_banks_report91         
               (nbuc, kodf, datf, kodp, znap) 
         VALUES
               (k.nbuc, 'D3', Dat_, '40' || k.NNN, '00');

         INSERT INTO v_banks_report91         
               (nbuc, kodf, datf, kodp, znap) 
         VALUES
               (k.nbuc, 'D3', Dat_, '99' || k.NNN, 'Консолідований'); 
 
      end if;

   end loop;
-------------------------------------------------------------------------
END p_filed3;
/

begin
    execute immediate 'DROP PUBLIC SYNONYM p_filed3';
exception
    when others then null;
end;
/    

create public synonym p_filed3 for bars.p_filed3;
grant execute on p_filed3 to rpbn002;
/
