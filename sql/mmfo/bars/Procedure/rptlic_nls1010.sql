

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RPTLIC_NLS1010.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RPTLIC_NLS1010 ***

  CREATE OR REPLACE PROCEDURE BARS.RPTLIC_NLS1010 (
p_date1 date,
p_date2 date,
p_nls varchar2 ,-- default '%',
p_kv smallint ,-- default 0,
p_isp number default 0,
p_branch branch.branch%type default sys_context('bars_context','user_branch'),
p_inform smallint default 0)
as
s_fdate date;
begin
execute immediate 'truncate table tmp_lic';
execute immediate 'truncate table tmp_licM';
-- BARS.BARS_RPTLIC.VALIDATE_NLSMASK(p_mask);
  IF p_date1 = '' THEN
     SELECT fdat INTO s_fdate
       FROM (SELECT fdat, ROWNUM num
               FROM ( SELECT * FROM fdat
                       WHERE fdat <= p_date2
             ORDER BY fdat DESC))
             WHERE num = 30;
      insert into tmp_lic (acc, nls, kv, nms)
      select acc, nls, kv, nms
        from accounts
       where (dazs is null or dazs >= s_fdate)
         and nls like p_nls
         and (p_kv = 0 or kv = p_kv);
  ELSE
      insert into tmp_lic (acc, nls, kv, nms)
      select acc, nls, kv, nms
        from accounts
       where (dazs is null or dazs >= p_date1)
         and nls like p_nls
         and (p_kv = 0 or kv = p_kv);
   END IF;

-- LIC_DYNSQL
--
-- Формирование выписок по динамическому запросу из справочника REPVP_DYNSQL
--
-- p_date1 - дата с
-- p_date2 - дата по
-- p_inform - информационные сообщения (=1 - вносить, =0 - не вносить)
-- p_kv - (0-все)
-- p_mltval - вылютная (если =2, включает тогда и гривну с валютой)
-- p_valeqv - с эквивалентами
-- p_valrev - с переоценкой (revaluation)
-- p_sqlid - № динамич. запроса из справочника REPVP_DYNSQL
BARS_RPTLIC.LIC_SQLDYN(P_DATE1 =>p_date1,
P_DATE2 =>p_date2,
P_INFORM =>0,
P_KV =>p_kv,
P_MLTVAL =>2,
P_VALEQV =>1,
P_VALREV =>1,
P_SQLID =>2);
end;
/
show err;

PROMPT *** Create  grants  RPTLIC_NLS1010 ***
grant EXECUTE                                                                on RPTLIC_NLS1010  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RPTLIC_NLS1010.sql =========*** En
PROMPT ===================================================================================== 
