@params.sql

set verify off
set echo off
set serveroutput on size 1000000
spool log\update_customer(&&dbname-&&1).log
set lines 3000
set SQLBL on
set timing on

prompt...
prompt ...
prompt ... loading params
prompt ...
@params.sql
whenever sqlerror exit
prompt ...
prompt ... connecting as bars 
prompt ...
conn bars@&&dbname/&&bars_pass
whenever sqlerror continue

prompt ================ update customer for &&1 ===============

begin
    for z in (select kf from mv_kf where kf = '&&1')
    loop
      bc.subst_mfo(z.kf);
      
      dbms_output.put_line(' MFO = ' || z.kf);
      
      for k in ( select rnk 
                 from customer 
                 where ise in ('12211', '12212', '12213', '12501',
                    '12502', '12503', '12301', '12302', '12303',  
                    '12401', '12402', '12403', '20000')  and
					date_off is null
               )
      loop
         update customer 
         set ved = (case ved when '99999' then '00000' else ved end),
			 ise=
            (case ise 
                when '12211' then '12201'
                when '12212' then '12202'
                when '12213' then '12203'   
                when '12501' then '12801'
                when '12502' then '12802'
                when '12503' then '12803'   
                when '12301' then '12501'
                when '12302' then '12502'
                when '12303' then '12503'   
                when '12401' then '12601'
                when '12402' then '12602'
                when '12403' then '12603'   
                when '20000' then (case when codcagent = 6 then '20008' 
                                        else ise 
                                   end)
                else ise 
            end) 
         where rnk = k.rnk;
         
         commit;
      end loop;
      
      commit;
   end loop;
   
   bc.home;
end;
/

spool off
quit