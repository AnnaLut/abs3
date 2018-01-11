

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_OB22NU.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_OB22NU ***

  CREATE OR REPLACE PROCEDURE BARS.P_OB22NU (p_dat1 date,  p_dat2 date ) is
l_vdat    date;   l_vob number ; l_tt char(3);  l_nazn varchar2(160);
l_prizn char(1)         ;  l_nlsn  varchar2(15)    ;
l_ob22  varchar2(2)     ;  l_nmsn  varchar2(70)    ;
l_nls2  varchar2(15);
l_nlsn2 varchar2(15);
l_prizn2 char(1);
l_ob22_2 varchar2(2) ;
/* процедура отбора данных для функции "Проводки в ПО по ОБ22"

   01-07-2014  nvv  Добавив обработку А/П (6204)
                    + patch_XXX.sql 01/07/2014
                    + v_ob22nu.vie  01/07/2014

   07-05-2010  qwa  Убрала хинты, так как в Житомире тормозило,
                    вместо них - псевдоним

   28-04-2010  qwa  Не выбирались правильно Р080 и поэтому неверно
                    определялись контрсчета (валовi)

   26-04-2010  qwa  Добавила хинты

   19-04-2010  qwa  Версия, в которой учитывается  наличие одинаковых
                    OB22 для одного R020_FA, добавили обработку P080
                    и признака sb_p0853.d_close
                    +nal_dec.apd от 19-04-2010
                    +patchw07.kf.nal

*/

  MODCODE   constant varchar2(3) := 'NAL';

begin

execute immediate ('truncate table tmp_ob22_funu');
execute immediate ('truncate table tmp_ob22nu');

for n in (select ACC, NLS, NMS, NBS, P080,  OB22, ACCN, NLSN, NMSN, NBSN,  NP080, NOB22, PRIZN, NMS8, APf
         from v_ob22nu)
loop
  begin
       insert into tmp_ob22nu (ACC, NLS, NMS, NBS, P080,  OB22, ACCN, NLSN, NMSN, NBSN,  NP080, NOB22, PRIZN, NMS8, AP)
         values  (n.ACC, n.NLS, n.NMS, n.NBS, n.P080,  n.OB22, n.ACCN, n.NLSN,
                n.NMSN, n.NBSN,  n.NP080, n.NOB22, n.PRIZN, n.NMS8, n.APF);

       exception when dup_val_on_index then
       bars_error.raise_nerror(MODCODE, 'NAL_DUPACCN',n.nls,n.nlsn,n.np080);
  end;
end loop;

commit;
-- чистый дебет и его корреспонденция
for d in (
with opp as (select * from opldok where fdat BETWEEN p_dat1 AND p_dat2)
select  o.ref,    o.acc accd, a.nls  nlsd,
                  ob.acc acck, ab.nls nlsk,  o.s,   o.txt,
                  o.fdat,  o.dk,  o.stmt,  o.otm , o.tt tto,
                  t1.nlsn nlsn_d, t1.nmsn,t1.ob22 ob22_d,t1.prizn prizn_d, t1.np080 p080_d,
                  t2.nlsn nlsn_k,         t2.ob22 ob22_k,t2.prizn prizn_k, t2.np080 p080_k,
                  p.vdat,p.vob,p.nazn,p.tt ttp
       from opp o,accounts a,(select * from tmp_ob22nu where ap = 3 or ap = 2) t1, (select * from tmp_ob22nu where ap = 3 or ap = 1) t2,
            oper p,
            opp ob, accounts ab
       where  exists( select  1
                        from opp
                       where ref=o.ref
                         and fdat between p_dat1 and p_dat2) -- именно так - иначе  096  не отбираются
                and  o.ref=p.ref      and o.ref=ob.ref   and o.stmt=ob.stmt
                and  o.dk=0           and ob.dk=1
                and  o.acc=a.acc      and ob.acc=ab.acc
                and  o.acc=t1.acc    and ob.acc=t2.acc(+)
                and  o.sos>=4  and o.tt not in ('ZG1','ZG2','ZG8','ZG9')
                and  BITAND (NVL (o.otm, 0), 1) = 0
                and  BITAND (NVL (o.otm, 0), 2) = 0)
loop
 --bars_audit.info('tmp_funu=DT=nlsn_d='||d.nlsn_d||'=prizn_d='||d.prizn_d||'=nlsn_k='||d.nlsn_k||'=prizn_k='||d.prizn_k );
 insert into tmp_ob22_funu (
    PRIZN,     PRIZN_D,   ACCD,        NLSN_D,      OB22_D, P080_D,
               PRIZN_K,   ACCK,        NLSN_K,      OB22_K, P080_K,
    FDAT,      REF,       NLSD,        NLSK,        S,
    NAZN,
    NMSN,      VOB,       VDAT,        STMT,        OTM)
    values
    (null,     d.prizn_d,  d.accd,    d.nlsn_d,    d.ob22_d, d.p080_d ,
               d.prizn_k,  d.acck,    d.nlsn_k,    d.ob22_k, d.p080_k,
    d.fdat,    d.ref,      d.nlsd,    d.nlsk,        d.s,
    decode(d.tto,d.ttp,d.nazn,d.txt),
    d.nmsn,    d.vob,      d.vdat,    d.stmt,      d.otm);
end loop;
-- чистый кредит и его корреспонденция
for k in (
with opp as (select * from opldok where fdat BETWEEN p_dat1 AND p_dat2)
select o.ref, a.acc acck,  a.nls nlsk,
                  a.acc accd, ab.nls nlsd,
                  o.s,   o.txt,  o.fdat,  o.dk,  o.stmt,  o.otm ,o.tt tto,
                  t1.nlsn nlsn_k, t1.nmsn,t1.ob22 ob22_k,t1.prizn prizn_k, t1.np080 p080_k,
                  t2.nlsn nlsn_d,         t2.ob22 ob22_d,t2.prizn prizn_d, t2.np080 p080_d,
                  p.vdat,p.vob,p.nazn,p.tt ttp
       from opp o,accounts a,(select * from tmp_ob22nu where ap = 3 or ap = 1) t1,(select * from tmp_ob22nu where ap = 3 or ap = 2) t2,
            oper p,
            opp ob, accounts ab
       where  exists( select  1
                        from opp
                       where ref=o.ref
                         and fdat between p_dat1 and p_dat2)
                and  o.ref=p.ref   and o.ref=ob.ref   and o.stmt=ob.stmt
                and  o.dk=1        and ob.dk=0
                and  o.acc=a.acc   and ob.acc=ab.acc
                and  o.acc=t1.acc  and ob.acc=t2.acc(+)
                and  o.sos>=4  and o.tt not in ('ZG1','ZG2','ZG8','ZG9')
                and  BITAND (NVL (o.otm, 0), 1) = 0
                and  BITAND (NVL (o.otm, 0), 2) = 0
                and not exists (select /*+ INDEX(tmp_ob22_funu)*/ 1
                                  from tmp_ob22_funu
                                 where ref=o.ref
                                   and stmt =o.stmt))
loop
 --bars_audit.info('tmp_funu=KT=nlsn_d='||k.nlsn_d||'=prizn_d='||k.prizn_k||'=nlsn_k='||k.nlsn_d||'=prizn_k='||k.prizn_k );
 insert into tmp_ob22_funu (
    PRIZN,     PRIZN_D,   ACCD,        NLSN_D,      OB22_D, P080_D,
               PRIZN_K,   ACCK,        NLSN_K,      OB22_K, P080_K,
    FDAT,      REF,        NLSD,        NLSK,        S,           NAZN,
    NMSN,      VOB,        VDAT,        STMT,        OTM)
    values
    (null,     k.prizn_d,  k.accd,   k.nlsn_d,   k.ob22_d,   k.p080_d,
               k.prizn_k,  k.acck,   k.nlsn_k,   k.ob22_k,   k.p080_k,
    k.fdat,    k.ref,      k.nlsd,     k.nlsk,      k.s,       decode(k.tto,k.ttp,k.nazn,k.txt),
    k.nmsn,    k.vob,      k.vdat,     k.stmt,      k.otm);
end loop;
commit;
-- сформируем общий признак обязательности
for p in (select /*+ INDEX(tmp_ob22_funu)*/
                   ref,stmt,prizn_d,prizn_k
             from tmp_ob22_funu )
loop
    if        nvl(p.prizn_d,'0')='1' or nvl(p.prizn_k,'0')='1'
              then     l_prizn:='1';
    elsif  NVL (p.prizn_d, '0') = '3' OR NVL (p.prizn_k, '0') = '3'
              then     l_prizn:='3';
    else l_prizn:=0;
    end if;
 --bars_audit.info('tmp_funu='||p.ref||'='||l_prizn );
   update    tmp_ob22_funu set prizn=l_prizn
        where ref=p.ref and stmt=p.stmt;
end loop;
commit;
end  P_OB22NU;
/
show err;

PROMPT *** Create  grants  P_OB22NU ***
grant EXECUTE                                                                on P_OB22NU        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_OB22NU        to NALOG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_OB22NU.sql =========*** End *** 
PROMPT ===================================================================================== 
