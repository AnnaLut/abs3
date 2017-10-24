

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_NU_STAT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_NU_STAT ***

  CREATE OR REPLACE PROCEDURE BARS.P_NU_STAT (
     p_p0 varchar2,   -- P080
     p_p1 varchar2,   -- ob22
     p_p2 varchar2,   -- ndoc
     p_p3 varchar2,   -- nls  счет ФУ
     p_p4 varchar2,   -- nlsn счет НУ
     p_p5 varchar2,   -- дата
     p_p6 varchar2,   -- (=1) викл рахунки ФО з 0 залишками
     p_p7 varchar2   -- (=1) викл рахунки ФО з accounts.vid=89
          ) is
l_vdat    date;   l_vob number ; l_tt char(3);  l_nazn varchar2(160);
l_prizn char(1)         ;  l_nlsn  varchar2(15)    ;
l_ob22  varchar2(2)     ;  l_nmsn  varchar2(70)    ;
l_nls2  varchar2(15);
l_nlsn2 varchar2(15);
l_prizn2 char(1);
l_ob22_2 varchar2(2) ;
/* процедура отбора данных для  выгрузки в Excel
   "состояние счетов и показателей декларации на дату"
   (Залишки ФО-ПО)                     \BRS\SBM\NAL\6\1

   13-01-2012 qwa Для выгрузки кода рядка добавила впереди обратный апостроф,
                  иначе выгружало в формате даты  многие значения
   21-10-2011 qwa Убрала валюту (так как пока не нужна, во вьюшке v_ob22_nu теперь нет валюты),
                  Основная доработка - переход на новые словари
                  sb_s0811 (вместо sb_s0806),
                  sb_ps811 (вместо sb_ps856)

   19-01-2011 qwa
        Оcтаток формируем без учета ZG (через fost_h_zg)
   04-11-2010 qwa
        1. Добавлены новые параметры
        p_p7 varchar2,   -- (=1) викл рахунки ФО з accounts.vid=89 (v_ob22nu_n.vidf=1)
        p_p8 varchar2    -- валюта

        p_p6 varchar2,   -- (=1) викл рахунки ФО з 0 залишками
           - если установлен параметр  p_p6='1' и остаток (на дату) по счету ФУ = 0
           - то поле счет и его название  заменим на null
           - то есть если все счета ФУ с 0 остатками - покажем только 8 класс
        Вместе с изменениями по
        ..\view\v_ob22nu_n.vie      - добавили код вал и vidf
        ..\table\tmp_ob22nu.sql     -    -"-
        ..\table\tmp_nu_stat.sql    -    -"-
        ..\SQL\REPORTS\_BRS_SBM_NAL_6_1.sql


   qwa  30-09-2010 запрос через процедуру формирования
        1. Добавлены параметры "Рахунок ПО", "Рахунок ФО"
        2. Добавлено поле в выборку
           "Залишок Р080"
           "БР ФО"
          "Знач_показника" (простого показника рядка додатка або декларац?ї)
        3. С таким набором полей наверное было бы точнее назвать
           "Стан декларац?ї та додатк?в"  Надо обсудить.


*/

  MODCODE   constant varchar2(3) := 'NAL';

begin
execute immediate ('truncate table tmp_ob22nu');
execute immediate ('truncate table tmp_nu_stat');

for n in (select ACC,  --KV,
                 NLS, NMS, NBS, P080,  OB22, ACCN, NLSN, NMSN, NBSN,  NP080, NOB22, PRIZN, NMS8
            from v_ob22nu_n
           where --kv   =  decode(p_p8,'%',kv,p_p8)  and   -- или указанная валюта или все
               vidf <> decode (p_p7,'1',1,89999)  -- 899999 константа для сравнения
         )
loop
  begin
       insert into tmp_ob22nu (ACC, NLS, NMS, NBS, P080,  OB22, ACCN, NLSN, NMSN, NBSN,  NP080, NOB22, PRIZN, NMS8)
         values  (n.ACC, n.NLS, n.NMS, n.NBS, n.P080,  n.OB22, n.ACCN, n.NLSN,
                n.NMSN, n.NBSN,  n.NP080, n.NOB22, n.PRIZN, n.NMS8);
       exception when dup_val_on_index then
       bars_error.raise_nerror(MODCODE, 'NAL_DUPACCN',n.nls,n.nlsn,n.np080);
  end;
end loop;

if p_p5 is null then l_vdat:=to_char(bankdate_g,'dd-mm-yyyy');
else l_vdat:=p_p5;
end if;

insert into tmp_nu_stat (
                     NDOC    ,
                     NNDOC,
                     NPP     ,
                     NROW    ,
                     S_NPP   ,
                     P080    ,
                     S_P080  ,
                     NBSF    ,
                     NLSN    ,
                     NMSN    ,
                     S_N     ,
                     NLSF    ,
                     NMSF    ,
                     S_F     ,
                     NBSN    ,
                     NOB22   ,
                     ACCN)
select s.ndoc,
       s.nndoc,
       '`'||s.npp,
       s.nrow,
       0,
       v.np080,
       0,
       v.nbs,
       v.nlsn,
       substr(v.nmsn,1,40),
       n.ss,
       v.nls,
       substr(v.nms,1,40),
       f.ss,
       v.nbsn,
       v.ob22,
       v.accn
 from   tmp_ob22nu v, SB_S0811 s, SB_PS811 p,
       (select distinct accn, fost_h(accn,  to_date(l_vdat,'dd-mm-yyyy')) ss  from tmp_ob22nu) n ,
       (select distinct acc,  fost_h_zg(acc,   to_date(l_vdat,'dd-mm-yyyy')) ss  from tmp_ob22nu) f
 where   v.ob22   = decode(p_p1,  '%',  v.ob22 ,  p_p1)
    and  v.np080  = decode(p_p0,  '%',   v.np080  ,p_p0)
    and  v.nls   like  decode(p_p3,  '%',   v.nls||'%'  ,p_p3)
    and  v.nlsn  like  decode(p_p4,  '%',   v.nlsn||'%'  ,p_p4)
    and  s.ndoc   = decode(p_p2,  '%',   s.ndoc  ,p_p2)
    and  s.s080 = p.s080
    and  p.p080  = v.np080
    and  n.accn  = v.accn
    and  f.acc   = v.acc;


insert into  tmp_nu_stat (
                     NDOC    ,
                     NNDOC,
                     NROW    ,
                     NPP     ,
                     S_NPP   ,
                     P080    ,
                     S_P080  ,
                     NBSF    ,
                     NLSN    ,
                     NMSN    ,
                     S_N     ,
                     NLSF    ,
                     NMSF    ,
                     S_F     ,
                     NBSN,
                     NOB22,
                     ACCN)
select s.ndoc,
       s.nndoc,
       s.nrow ,
       '`'||s.npp,
       0,
       v.np080 ,
       0,
       null,
       v.nlsn ,
       substr(v.nmsn,1,40) ,
       n.ss,
       null ,
       null ,
       null ,
       v.nbsn,
       v.nob22,
       v.accn
 from   v_ob22nu80 v, SB_S0811 S, SB_PS811 P ,
 (select distinct accn, fost_h(accn,  to_date(l_vdat,'dd-mm-yyyy')) ss  from v_ob22nu80) n
 where   v.nob22    = decode(p_p1,  '%',   v.nob22 ,  p_p1)
    and  v.np080    = decode(p_p0,  '%',   v.np080  , p_p0)
    and  v.nlsn like  decode(p_p4,  '%',   v.nlsn||'%'  ,p_p4)
    and  s.ndoc      = decode(p_p2,  '%',   s.ndoc  ,p_p2)
    and  s.s080 = p.s080
    and  p.p080 = v.np080
    and n.accn  = v.accn;

for k in ( select sum(n.ss) s ,n.p080
             from (select distinct accn,s_n ss ,p080
                     from tmp_nu_stat) n
                   group by n.p080
          )
loop
   update tmp_nu_stat
      set s_p080 = k.s
    where p080 = k.p080;
end loop;

for k in (  select   sum(n.ss) s,n.ndoc, n.npp
               from  (select distinct accn,s_n ss, ndoc, npp
                     from tmp_nu_stat) n
                     group by n.ndoc,n.npp)
loop
   update tmp_nu_stat
      set s_npp = k.s
    where ndoc  = k.ndoc
      and npp   = k.npp ;
end loop;
-- если установлен параметр  p_p6='1' и остаток (на дату) по счету ФУ = 0
-- то поле счет и его название  заменим на null
-- то есть если все счета ФУ с 0 остатками - покажем только 8 класс

if  p_p6='1'   then
    for k in (select   nlsn, nlsf, p080, nob22, s_npp, s_p080, s_n, s_f
                from   tmp_nu_stat
               where   s_f=0
              )
    loop
        update tmp_nu_stat
           set nlsf=null, nmsf=null
         where nlsn    = k.nlsn
           and nlsf    = k.nlsf
           and p080  = k.p080
           and nob22 = k.nob22
           and s_f   = k.s_f;
    end loop;
end if;
commit;
end  p_nu_stat;
/
show err;

PROMPT *** Create  grants  P_NU_STAT ***
grant EXECUTE                                                                on P_NU_STAT       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_NU_STAT       to NALOG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_NU_STAT.sql =========*** End ***
PROMPT ===================================================================================== 
