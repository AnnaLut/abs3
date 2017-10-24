

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CCK_DELOIT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CCK_DELOIT ***

  CREATE OR REPLACE PROCEDURE BARS.P_CCK_DELOIT (  L_VIDD number, p_dat date) is
-- p_mode -  1 - Юл  11 - ФЛ  0 Все
--  p_dat - отчетная дата
l_dat31 date;
l_all_pawn varchar2(1500);
l_str varchar2 (2000);
begin

-- nov 22/07/2013 Убран контроль невозможности SS быть 9 классом

  If TO_NUMBER(GetGlobalOption('HAVETOBO')) = 2 and SYS_CONTEXT ('bars_context', 'user_branch') = '/' then
    EXECUTE IMMEDIATE 'begin bc.subst_mfo(f_ourmfo_g); end;';
  end if;

 l_dat31:=nvl(p_dat,round(gl.bd,'MM')-1);
-- Выбираем все залоги привязанные к КД и узнаем какие из них привязаны к нескольким КД и к каким КД
-- count(pwn.accz) OVER (partition by pwn.accz ORDER BY pwn.accz)  - узнаем кол-во КД
/*
delete from  TMP_DELOIT_REZ  where dat=l_dat31;
insert into  TMP_DELOIT_REZ
           ( DAT   ,USERID, ACCS, ACCZ, PAWN  , S   , SPRIV, PROC,  SALL, ND, KV)
select  max(pwn.DAT) ,max(pwn.USERID), max(pwn.accs), pwn.ACCZ, max(pwn.PAWN)  , max(pwn.S)   ,--max( pwn.SPRIV),
row_number () OVER (partition by pwn.accz order by pwn.accz) spriv,
count(pwn.accz) OVER (partition by pwn.accz ORDER BY pwn.accz) proc,
max( pwn.SALL), max(pwn.ND), max(pwn.KV)
from
(
    select l_dat31 dat , 1 userid      ,p.accs,p.acc accz, pa.pawn, null SPRIV, null  PROC , null  SALL  ,p_icurval(a.kv,rez1.ostc96(a.acc,l_dat31),l_dat31)/100 S ,
             --decode(p.nd,null,(select max(n.nd) from nd_acc n where n.acc=p.accs),p.nd) nd ,  a.kv
               (select max(n.nd) from nd_acc n where n.acc=p.accs) nd ,  a.kv
      from accounts a, cc_accp p, pawn_acc pa
    where rez1.ostc96(a.acc,l_dat31)!=0 and  a.acc=p.acc and (a.dazs is null or a.dazs>l_dat31) and pa.acc=p.acc
) pwn where pwn.nd is not null group by pwn.nd,pwn.ACCZ;

commit;
*/



--------------------------------------------------------------
-- ВЫбираем КД и их задолженности

delete from TMP_DELOIT_CCK where    L_VIDD= 1 and VIDD in ( 1, 2, 3, 4,14)
                                 or L_VIDD=11 and VIDD in (11,12,13)
                                 or L_VIDD= 0;

insert into TMP_DELOIT_CCK
SELECT  l_dat31,
        c.branch,
        c.vidd,
        c.nd ,
        c.cc_id,
        c.rnk,
        d.nmk,
        d.okpo,
        a8.kv,
        c.sdate,
        c.wdate,
        acrN.FPROCN (a8.ACC, 0, '') ir,
        nvl(ss.s_s,0)   SS,
        nvl(sd.s_s,0)   SDI,
        nvl(sn.s_s,0)   SN,
        nvl(cr9.s_s,0) CR9,
        nvl(to_date(cck_app.get_nd_txt(c.nd,'DATSP'),'dd/mm/yyyy'),F_GET_CCK_SPDAT(sysdate,c.nd,0)) DAT_SP,
        nvl(to_date(cck_app.get_nd_txt(c.nd,'DASPN'),'dd/mm/yyyy'),F_GET_CCK_SPDAT(sysdate,c.nd,1)) DAT_SPN,
        c.fin23,
        c.obs23,
        c.kat23,
        a8.dazs,
        null
   FROM (select n.nd, sum(gl.p_icurval(a.kv,ABS(rez1.ostc96(a.acc,l_dat31)),l_dat31)/100) s_s
            from nd_acc n, accounts a
           where n.acc = a.acc
             and a.tip  in ('SS', 'SP')
           group by n.nd) ss,
      (select n.nd, sum(gl.p_icurval(a.kv,ABS(rez1.ostc96(a.acc,l_dat31)),l_dat31)/100) s_s
            from nd_acc n, accounts a
           where n.acc = a.acc
             and a.tip = 'SDI'
           group by n.nd) sd,
         (select n.nd, sum(gl.p_icurval(a.kv,ABS(rez1.ostc96(a.acc,l_dat31)),l_dat31)/100) s_s
            from nd_acc n, accounts a
          where n.acc = a.acc
             and a.tip in ('SN ','SNO','SPN') and a.NBS  not like '8%'
           group by n.nd) sn,
         (select n.nd, sum(gl.p_icurval(a.kv,ABS(rez1.ostc96(a.acc,l_dat31)),l_dat31)/100) s_s
            from nd_acc n, accounts a
          where n.acc = a.acc
             and a.tip in ('CR9') and a.NBS like '9%'
           group by n.nd) CR9,
         cc_deal c,
         customer d,
         nd_acc n8,
         accounts a8
   WHERE ( L_VIDD= 1 and c.VIDD in ( 1, 2, 3)  or L_VIDD=11 and c.VIDD in (11,12,13) or  L_VIDD= 0 )
     AND c.sos >= 10 and c.nd=n8.nd and n8.acc=a8.acc and a8.tip='LIM'
     AND c.nd = ss.nd(+)
     AND c.nd = sd.nd(+)
     AND c.nd = sn.nd(+)
     AND c.nd = cr9.nd(+)
     AND c.rnk = d.rnk
     AND (a8.dazs is null or a8.dazs>gl.bd-31)
 union all
SELECT  l_dat31,
        a.branch,
        c.vidd,
        c.nd ,
        c.ndoc,
        a.rnk,
        d.nmk,
        d.okpo,
        a.kv,
        c.datd,
        c.datd2,
        acrN.FPROCN (a.ACC, 0, '') ir,
        abs(gl.p_icurval(a.kv,ABS(least(rez1.ostc96(a.acc,l_dat31),0)),l_dat31)/100)+
         abs(gl.p_icurval(a.kv,ABS(least(nvl(rez1.ostc96(c.acc_2067,l_dat31),0),0)),l_dat31)/100)   SS,
        0   SDI,
        nvl(gl.p_icurval(a.kv,ABS(rez1.ostc96(i_sn.acra,l_dat31)),l_dat31)/100,0) +
         nvl(gl.p_icurval(a.kv,ABS(nvl(rez1.ostc96(c.acc_2069,l_dat31),0)),l_dat31)/100,0) SN,
        nvl(gl.p_icurval(a.kv,ABS(rez1.ostc96(c.acc_9129   ,l_dat31)),l_dat31)/100,0) CR9,
        F_GET_OVR_SPDAT(sysdate,c.nd,0) DAT_SP,
        F_GET_OVR_SPDAT(sysdate,c.nd,1) DAT_SPN,
        c.fin23,
        c.obs23,
        c.kat23,
        a.dazs,
        (select c.acc from cc_accp p where p.accs=c.acc and rownum=1) acc  -- По КП делается аналогично  отдельным блоком ниже
   from acc_over c, accounts a, acc_over c1, customer d,
         (select i_sn.acra, c.acc
            from acc_over c ,int_accn i_sn  where c.acc=i_sn.acc(+) and i_sn.id(+)=0 and c.sos is null
         )  i_sn
   where c.acc=a.acc and c.sos is null
         and c.acc=c1.acc(+) and c1.sos(+)=1
         and a.rnk=d.rnk  and i_sn.acc(+)=c.acc
         and ( L_VIDD= 1 and c.VIDD in ( 4, 14)  or  L_VIDD= 0 );



  -- ищем любой счет по КД к которому привязано обеспечение   (Только по КП)
  update TMP_DELOIT_CCK  d
         set d.acc= (select n.acc
                       from nd_acc n, accounts a , cc_deal c
                      where n.nd=d.nd and n.acc=a.acc and rownum=1 and (a.dazs is null or a.dazs>l_dat31)
                            and a.tip in ('SS ','SP ','SN ','SPN') and n.nd=c.nd
                            and exists (select 1 from cc_accp p where p.accs=n.acc))
         where d.dat=l_dat31 and ( L_VIDD= 1 and d.VIDD in ( 1, 2, 3)  or L_VIDD=11 and d.VIDD in (11,12,13) or  L_VIDD= 0 );



commit;


-- Связь договор к счету обеспечения (договор обеспечения)
-- PROC - к скольким КД привязано обеспечение

delete from  TMP_DELOIT_REZ  where dat=l_dat31;

insert into  TMP_DELOIT_REZ
           ( DAT   ,USERID, ACCS, ACCZ, PAWN  , S   , SPRIV, PROC,  SALL, ND, KV)
    select l_dat31 dat , 1 userid ,p.accs,p.acc accz, pa.pawn, p_icurval(a.kv,rez1.ostc96(a.acc,l_dat31),l_dat31)/100 S,1 SPRIV, count(p.acc) OVER (partition by p.acc )   PROC ,
              null  SALL  ,  d.nd ,  a.kv
      from accounts a, cc_accp p, pawn_acc pa, TMP_DELOIT_CCK d
    where rez1.ostc96(a.acc,l_dat31)!=0 and  a.acc=p.acc and (a.dazs is null or a.dazs>l_dat31) and pa.acc=p.acc
          and d.dat=l_dat31 and p.accs=d.acc
          and ( L_VIDD= 1 and d.VIDD in ( 1, 2, 3 , 4, 14)  or L_VIDD=11 and d.VIDD in (11,12,13) or  L_VIDD= 0 );


commit;



  -- Пропорционально задолженности разделяем обеспечение
 for i in (select r.accz,r.nd,r.spriv, (select sum(d.ss+d.sn) from TMP_DELOIT_CCK d where d.nd=r.nd and d.dat=r.dat) ostc_nd,
                      (select sum(d.ss+d.sn) from TMP_DELOIT_CCK d, TMP_DELOIT_REZ rr where rr.accz=r.accz and d.nd=rr.nd and rr.dat=r.dat) all_ostc
                      from TMP_DELOIT_REZ r where r.proc>1 and dat=l_dat31
           )
 loop
  begin
  if i.all_ostc=0 and i.spriv=1 then
     null;
  elsif  i.all_ostc=0 then
    update TMP_DELOIT_REZ t set t.sall=0 where t.nd=i.nd and t.accz=i.accz and t.dat=l_dat31;
  else
    update TMP_DELOIT_REZ t set t.sall=round(t.s*i.ostc_nd/i.all_ostc,2) where t.nd=i.nd and t.accz=i.accz and t.dat=l_dat31;
  end if;
  exception when ZERO_DIVIDE  then
  RAISE_APPLICATION_ERROR (-20001,'Деление на ноль по обеспечению accz='||i.accz);
  end;
 end loop;
 commit;

  -- Разворачиваем обеспечение в строку
 begin
  EXECUTE IMMEDIATE 'drop table TMP_DELOIT_PAWN';
 exception when others then
 dbms_output.put_line (sqlcode);
  if SQLCODE=-942 then null;
  else raise; end if;
 end;

 select distinct concatstr( to_char(pawn_23)||' as P_'||to_char(pawn_23)) into l_all_pawn from  TMP_DELOIT_REZ t, cc_pawn c where t.pawn(+)=c.pawn order by c.pawn_23;
 commit;


 l_str:= 'CREATE TABLE TMP_DELOIT_PAWN as
                    select * from
                    (
                    select nd,pawn_23, s, sall from (
                    select t.nd,c.pawn_23,sum(t.s) s ,sum(t.sall)sall from TMP_DELOIT_REZ t, cc_pawn c
                     where t.dat =to_date('''||to_char(l_dat31,'dd/mm/yyyy')||''',''dd/mm/yyyy'')
                           and t.pawn=c.pawn group by t.nd,c.pawn_23 )
                    )
                    PIVOT ( sum(abs(nvl(sall,s)))  FOR pawn_23 in  ('|| l_all_pawn ||' ))';

  dbms_output.put_line (l_str);
  EXECUTE IMMEDIATE l_str ;
  EXECUTE IMMEDIATE 'grant select on TMP_DELOIT_PAWN to rcc_deal';
 commit;
end;
/
show err;

PROMPT *** Create  grants  P_CCK_DELOIT ***
grant EXECUTE                                                                on P_CCK_DELOIT    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_CCK_DELOIT    to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CCK_DELOIT.sql =========*** End 
PROMPT ===================================================================================== 
