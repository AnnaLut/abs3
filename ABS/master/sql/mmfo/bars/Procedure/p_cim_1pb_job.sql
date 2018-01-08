

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CIM_1PB_JOB.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CIM_1PB_JOB ***

  CREATE OR REPLACE PROCEDURE BARS.P_CIM_1PB_JOB 
is 
  DateTimeInfo  VARCHAR2(20);
begin
  select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') into DateTimeInfo from dual;
  LOGGER.INFO( 'p_cim_1pb_job: Start at ' || dateTimeInfo );
  delete from cim_1pb_out_doc;
  insert into cim_1pb_out_doc (ref_ca, vdat, kv, s, mfoa, mfob, nlsa, nlsb, kod_n_ca)
    ( select o.ref, (select max(d.fdat) from opldok d where d.dk=1 and d.ref=o.ref ) as vdat, 
             o.kv, o.s, o.mfoa, o.mfob, o.nlsa, o.nlsb, w.value
        from oper o   
             left outer join operw w on w.tag='KOD_N' and w.ref=o.ref
       where o.dk=1 and o.sos=5             
             and o.nlsb in ( '29094100010000', '29097100020000', '29094000120000', '29092100030000', '29099100050000', '29099100060000', 
                             '29091100070000', '29097100220000', '29096100260000', '29099100100000', '29093100130000', '29099100140000', 
                             '29094100150000', '29090000160000', '29099100170000', '29097100040000', '29098100080000', '29090100180000', 
                             '29098100190000', '29094100200000', '29099100210000', '29098100240000', '29091100230000', '29090100250000' )
             and o.pdat<trunc(last_day(sysdate)+1) and o.pdat>=trunc(last_day(add_months(sysdate,-2))-5) );
  commit;           
  select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') into DateTimeInfo from dual;
  LOGGER.INFO( 'p_cim_1pb_job: End at ' || dateTimeInfo );
end p_cim_1pb_job;
/
show err;

PROMPT *** Create  grants  P_CIM_1PB_JOB ***
grant EXECUTE                                                                on P_CIM_1PB_JOB   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CIM_1PB_JOB.sql =========*** End
PROMPT ===================================================================================== 
