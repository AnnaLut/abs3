

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RPTLIC_NLS_3052.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RPTLIC_NLS_3052 ***

  CREATE OR REPLACE PROCEDURE BARS.RPTLIC_NLS_3052 (p_date1   date,
                                                  p_date2   date)
as
begin


execute immediate 'truncate table tmp_lic';
execute immediate 'truncate table tmp_licM';



     -- BARS.BARS_RPTLIC.VALIDATE_NLSMASK(p_mask);

     insert into  tmp_lic (acc, nls, kv, nms)
     select acc, nls, kv, nms
       from accounts
      where (dazs is null or dazs >= p_date2) and  nbs in (select nbs from lic_nbs_dksu)
           ;



    --  LIC_DYNSQL
    --
    --   Формирование выписок по динамическому запросу из справочника REPVP_DYNSQL
    --
    --   p_date1   -  дата с
    --   p_date2   -  дата по
    --   p_inform  -  информационные сообщения (=1 - вносить, =0 - не вносить)
    --   p_kv      -  (0-все)
    --   p_mltval  -  вылютная (если =2, включает тогда и гривну с валютой)
    --   p_valeqv  -  с эквивалентами
    --   p_valrev  -  с переоценкой (revaluation)
    --   p_sqlid   -  № динамич. запроса    из справочника REPVP_DYNSQL

     BARS_RPTLIC.LIC_SQLDYN(P_DATE1   =>p_date1,
                            P_DATE2   =>p_date2,
                            P_INFORM  =>0,
                            P_KV      =>0,
                            P_MLTVAL  =>2,
                            P_VALEQV  =>1,
                            P_VALREV  =>1,
                            P_SQLID   =>2);


end;
/
show err;

PROMPT *** Create  grants  RPTLIC_NLS_3052 ***
grant EXECUTE                                                                on RPTLIC_NLS_3052 to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on RPTLIC_NLS_3052 to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RPTLIC_NLS_3052.sql =========*** E
PROMPT ===================================================================================== 
