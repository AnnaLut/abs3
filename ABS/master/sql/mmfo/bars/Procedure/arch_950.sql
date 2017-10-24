

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ARCH_950.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ARCH_950 ***

  CREATE OR REPLACE PROCEDURE BARS.ARCH_950 
is
 TYPE sw_950_Set IS TABLE OF sw_950%ROWTYPE;
 collection sw_950_Set; -- Набор рядов таблицы sw_950.
begin
  bc.subst_mfo(f_ourmfo_g);
 select s.* BULK COLLECT into collection from sw_journal j, sw_950 s
  where j.swref=s.swref
   and trunc(sysdate)-trunc(date_in)>21;

   for i in 1.. collection.COUNT loop
     begin
      savepoint sp_start;

       insert into sw_950_arch(SWREF,
                               NOSTRO_ACC,
                               NUM,
                               STMT_DATE,
                               OBAL,
                               CBAL,
                               ADD_INFO,
                               DONE,
                               STMT_BDATE,
                               KV,
                               KF)
                       values(collection(i).SWREF,
                              collection(i).NOSTRO_ACC,
                              collection(i).NUM,
                              collection(i).STMT_DATE,
                              collection(i).OBAL,
                              collection(i).CBAL,
                              collection(i).ADD_INFO,
                              collection(i).DONE,
                              collection(i).STMT_BDATE,
                              collection(i).KV,
                              collection(i).KF);
            delete from sw_950 where swref=collection(i).swref;

            exception when others then
                rollback to sp_start;
      end;
   end loop;

end arch_950;
/
show err;

PROMPT *** Create  grants  ARCH_950 ***
grant EXECUTE                                                                on ARCH_950        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ARCH_950        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ARCH_950.sql =========*** End *** 
PROMPT ===================================================================================== 
