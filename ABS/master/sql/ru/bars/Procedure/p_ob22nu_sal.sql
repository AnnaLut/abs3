

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_OB22NU_SAL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_OB22NU_SAL ***

  CREATE OR REPLACE PROCEDURE BARS.P_OB22NU_SAL (p_dat1 date,  p_dat2 date ) is

/* процедура подготовки и отбора данных  для отчета 216 -  \BRS\SBM\NAL\1
   01-11-2011 qwa сделала с использованием врем таблицы tmp_ob22nu,
              почему-то в Тернополе очень тормозило
*/

  MODCODE   constant varchar2(3) := 'NAL';

begin

execute immediate ('truncate table tmp_ob22nu');

-- перенакопим последний день периода (пока)

bars_accm_sync.sync_snap('BALANCE', p_dat2);

for n in (
          select distinct ACCN, NLSN, NMSN, NBSN,  NP080, NOB22, PRIZN, NMS8
            from v_ob22nu_n
            union all
          select distinct ACCN, NLSN, NMSN, NBSN,  NP080, NOB22, PRIZN, NMS8
            from v_ob22nu80
            )
loop
  begin
       insert into tmp_ob22nu ( ACCN, NLSN, NMSN, NBSN,  NP080, NOB22, PRIZN,
         NMS8)
         values  ( n.ACCN, n.NLSN, n.NMSN,  n.NBSN,  n.NP080, n.NOB22, n.PRIZN,
         n.NMS8);
  end;
end loop;
commit;
end  P_OB22NU_SAL;
/
show err;

PROMPT *** Create  grants  P_OB22NU_SAL ***
grant EXECUTE                                                                on P_OB22NU_SAL    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_OB22NU_SAL    to NALOG;
grant EXECUTE                                                                on P_OB22NU_SAL    to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_OB22NU_SAL.sql =========*** End 
PROMPT ===================================================================================== 
