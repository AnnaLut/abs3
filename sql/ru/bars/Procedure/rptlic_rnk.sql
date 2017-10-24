

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RPTLIC_RNK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RPTLIC_RNK ***

  CREATE OR REPLACE PROCEDURE BARS.RPTLIC_RNK (  p_date1   date,
                                             p_date2   date,
                                             p_mask    number              default 0,
                                             p_kv      smallint            default 0,
                                             p_isp     number              default 0,
                                             p_branch  branch.branch%type  default sys_context('bars_context','user_branch'),
                                             p_inform  smallint            default 1)
as
begin


execute immediate 'truncate table tmp_lic';
execute immediate 'truncate table tmp_licM';





     insert into  tmp_lic (acc, nls, kv, nms)
     select acc, nls, kv, nms
       from accounts
      where nbs is not null
        and rnk like p_mask
        and (dazs is null or dazs >= p_date1)
        and kv = (case when p_kv = 0 then kv
                      when p_kv = 980 then 980
                      else p_kv end) ;


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
                            P_KV      =>p_kv,
                            P_MLTVAL  =>2,
                            P_VALEQV  =>1,
                            P_VALREV  =>1,
                            P_SQLID   =>3);


end;
/
show err;

PROMPT *** Create  grants  RPTLIC_RNK ***
grant EXECUTE                                                                on RPTLIC_RNK      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on RPTLIC_RNK      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RPTLIC_RNK.sql =========*** End **
PROMPT ===================================================================================== 
