
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/procedure/p_ob22nu_auto.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PROCEDURE BARS.P_OB22NU_AUTO (p_dat1 date,  p_dat2 date ) is
 l_prizn char(1) ;
 l_dat1 date;
 dat_tek DATE;
 l_kk    integer;       /* количество необработанных */
 l_grp   number;
 l_ks_a   varchar2(15);  /*контрсчет для активов*/
 l_ks_p   varchar2(15);  /*контрсчет для пасивов*/
 l_nms_ks_a  varchar2(70);  /* название контрсчета для акт.сч.НУ*/
 l_nms_ks_p  varchar2(70);  /* название контрсчета для пас.сч.НУ*/
/* процедура автоматической оплаты проводок ФУ в  НУ

01-07-2014   nvv  Добавив обработку А/П (6204)
                    + v_ob22nu.vie  01/07/2014

27-02-2014   qwa добавили к vob=96 также vob=99 (годовые)

14-07-2011   qwa обработаем также документы за предыдущий банк день,
                 если они введены "сегодня локальной банк датой"
22-06-2011   qwa добавила точку отката  " savepoint nal#ob22#autopay" ,
                 если нет возможности оплатить -пропускаем
                 процесс отплаты не останавливаем, так как работает на финише дня
21-06-2011   qwa корреспонденцию 3 класс с 7 платим тоже
                 (по заявке ГОУ ОБ)
26-04-2010   qwa Индекс на opldok и др. таблицы

 */

MODCODE   constant varchar2(3) := 'NAL';

begin
execute immediate 'truncate table tmp_ob22_funu_auto';
execute immediate 'truncate table tmp_ob22nu_auto';

Dat_tek:=GL.bdate; -- СОХРАНЕНИЕ ТЕК ДАТЫ

begin
 select p.val , a.nms
   into l_ks_a, l_nms_ks_a
   from params p,accounts a
  where p.par='NU_KS6' and a.nls=ltrim(rtrim(p.val));
 exception when no_data_found then null;    -------------------обработка ошибки
end;
begin
 select p.val , a.nms
  into  l_ks_p, l_nms_ks_p
  from params p,accounts a
 where p.par='NU_KS7' and a.nls=ltrim(rtrim(p.val));
 exception when no_data_found then null;    -------------------обработка ошибки
end;
begin
 select to_number(ltrim(rtrim(p.val)))
   into l_grp
   from params p
  where p.par='NU_CHCK' ;
 exception when no_data_found then null;    -------------------обработка ошибки
end;

-- связная таблица, запомним ее во временной
for n in (select ACC, NLS, NMS, NBS, P080,  OB22, ACCN, NLSN, NMSN, NBSN,  NP080, NOB22, PRIZN, NMS8, AP, APF
         from v_ob22nu)
loop
  begin
       insert into tmp_ob22nu_auto
               (ACC, NLS, NMS, NBS, P080,  OB22, ACCN, NLSN,
                NMSN, NBSN,  NP080, NOB22, PRIZN,
                NMS8,AP,KS)
         values  (n.ACC, n.NLS, n.NMS, n.NBS, n.P080,  n.OB22, n.ACCN, n.NLSN,
                n.NMSN, n.NBSN,  n.NP080, n.NOB22, n.PRIZN,
                n.NMS8,n.APF,decode(n.AP,'1',l_ks_a,'2',l_ks_p,l_ks_p));
       exception when dup_val_on_index then
       bars_error.raise_nerror(MODCODE, 'NAL_DUPACCN',n.nls,n.nlsn,n.np080);
  end;
end loop;
commit;
-- обработаем документы за предыдущий банк день, если они введены "сегодня локальной банк датой"
begin
   select max(fdat)
     into l_dat1
     from fdat
    where fdat<p_dat1;
   exception when no_data_found
             then l_dat1:=p_dat1;
end;
-- проводки ФУ - чистый дебет и его корреспонденция - соотв. проект проводок НУ
for d in ( select /*+ INDEX(o)  INDEX(ob) INDEX(t1) INDEX(t2)*/
      o.ref,      o.acc accd,   a.nls  nlsd,
      ob.acc acck, ab.nls nlsk,     o.s,               o.txt,
      o.fdat,      o.dk,            o.stmt,            o.otm ,               o.tt tto,
   t1.nlsn nlsn_d, t1.nmsn nmsn_d,  t1.ks ksn_d,       t1.ob22 ob22_d,   t1.prizn prizn_d,
   t2.nlsn nlsn_k, t2.nmsn nmsn_k , t2.ks ksn_k,       t2.ob22 ob22_k,   t2.prizn prizn_k,
    p.vdat,         p.vob,         p.nazn,             p.tt ttp
       from opldok o, accounts a,  (select * from tmp_ob22nu_auto where ap = 3 or ap = 2) t1,  (select * from tmp_ob22nu_auto where ap = 3 or ap = 1) t2,
            oper p,  opldok ob, accounts ab
       where   exists( select /*+ INDEX(opldok)*/
                           1 from opldok
                            where ref=o.ref and fdat between l_dat1 and p_dat2) -- именно так - иначе  096  не отбираются
                and  o.ref=p.ref      and o.ref=ob.ref   and o.stmt=ob.stmt
                and  o.dk=0           and ob.dk=1
                and  o.acc=a.acc      and ob.acc=ab.acc
                and  o.acc=t1.acc    and ob.acc=t2.acc(+)
                and  o.sos>=4  and o.tt not in ('ZG1','ZG2','ZG8','ZG9')
                and  BITAND (NVL (o.otm, 0), 1) = 0
                and  BITAND (NVL (o.otm, 0), 2) = 0
                and  o.tt<>'PO3' --and p.vob<>96
                and  a.nbs not in ('2066','2076','2086','2106',
                                    '2116','2126','2136','2206',
                                    '2236','2637')-- пока нет формального признака только кредитовые обороты - оставим в коде
--                and a.nbs  not in ('3400','3410','3500','3600','4500')    -- вся другая экзотика не 6 и 7 класс
--                and ab.nbs not in ('3400','3410','3500','3600','4500')    -- вся другая экзотика не 6 и 7 класс
        )
loop
 --bars_audit.info('tmp_funu=DT=nlsn_d='||d.nlsn_d||'=prizn_d='||d.prizn_d||'=nlsn_k='||d.nlsn_k||'=prizn_k='||d.prizn_k );
 insert into tmp_ob22_funu_auto (
    PRIZN,     PRIZN_D,   ACCD,        NLSN_D,      OB22_D,
               PRIZN_K,   ACCK,        NLSN_K,      OB22_K,
    FDAT,      REF,       NLSD,        NLSK,        S,
    NAZN,
    NMSN_D,    NMSN_K,      VOB,       VDAT,        STMT,        OTM,
    KSN_D,     KSN_K)
    values
    (null,     d.prizn_d,  d.accd,    d.nlsn_d,    d.ob22_d,
               d.prizn_k,  d.acck,    d.nlsn_k,    d.ob22_k,
    d.fdat,    d.ref,      d.nlsd,    d.nlsk,        d.s,
    decode(d.tto,d.ttp,d.nazn,d.txt),
    d.nmsn_d,  d.nmsn_k,  d.vob,      d.vdat,    d.stmt,      d.otm,
    d.ksn_d ,  d.ksn_k);
end loop;
-- -- проводки ФУ - чистый кредит и его корреспонденция - соотв. проект проводок НУ
for k in ( select /*+ INDEX(o) INDEX(ob) INDEX(t1) INDEX(t2)*/ o.ref,      a.acc acck,      a.nls nlsk,
      ob.acc accd,  ab.nls nlsd,     o.s,           o.txt,
      o.fdat,      o.dk,            o.stmt,        o.otm ,         o.tt tto,
   t1.nlsn nlsn_k, t1.nmsn nmsn_k,  t1.ks ksn_k,   t1.ob22 ob22_k, t1.prizn prizn_k,
   t2.nlsn nlsn_d, t2.nmsn nmsn_d,  t2.ks ksn_d,   t2.ob22 ob22_d, t2.prizn prizn_d,
    p.vdat,        p.vob,          p.nazn,           p.tt ttp
       from opldok o,accounts a,(select * from tmp_ob22nu_auto where ap = 3 or ap = 1) t1,(select * from tmp_ob22nu_auto where ap = 3 or ap = 2) t2,
            oper p,  opldok ob, accounts ab
       where    exists( select  /*+ INDEX(opldok)*/  1
                   from opldok
                  where ref=o.ref and fdat between l_dat1 and p_dat2) -- именно так - иначе  096  не отбираются
           and  o.ref=p.ref   and o.ref=ob.ref   and o.stmt=ob.stmt
           and  o.dk=1        and ob.dk=0
           and  o.acc=a.acc   and ob.acc=ab.acc
           and  o.acc=t1.acc  and ob.acc=t2.acc(+)
           and  o.sos>=4  and o.tt not in ('ZG1','ZG2','ZG8','ZG9')
           and  BITAND (NVL (o.otm, 0), 1) = 0
           and  BITAND (NVL (o.otm, 0), 2) = 0
           and o.tt<>'PO3' --and p.vob<>96   ---- потом убрать, нужно для просчета начала апреля
           and not exists (select   /*+ INDEX(tmp_ob22_funu_auto)*/
                     1 from tmp_ob22_funu_auto where ref=o.ref and stmt =o.stmt)
           and  a.nbs not in ('2066','2076','2086','2106',
                                    '2116','2126','2136','2206',
                                    '2236','2636')-- пока нет формального признака только дебетовые обороты - оставим в коде
--           and a.nbs  not in ('3400','3410','3500','3600','4500')    -- вся другая экзотика не 6 и 7 класс
--           and ab.nbs not in ('3400','3410','3500','3600','4500')    -- вся другая экзотика не 6 и 7 класс
           )
loop
 --bars_audit.info('tmp_funu=KT=nlsn_d='||k.nlsn_d||'=prizn_d='||k.prizn_k||'=nlsn_k='||k.nlsn_d||'=prizn_k='||k.prizn_k );
 -- здесь выбираем данных больше чем нужно, может понадобиться для чего-либо
 insert into tmp_ob22_funu_auto (
    PRIZN,     PRIZN_D,   ACCD,        NLSN_D,      OB22_D,
               PRIZN_K,   ACCK,        NLSN_K,      OB22_K,
    FDAT,      REF,        NLSD,        NLSK,        S,           NAZN,
    NMSN_D,    NMSN_K,      VOB,        VDAT,        STMT,        OTM,
    KSN_D,     KSN_K)
    values
    (null,     k.prizn_d,  k.accd,   k.nlsn_d,   k.ob22_d,
               k.prizn_k,  k.acck,   k.nlsn_k,   k.ob22_k,
    k.fdat,    k.ref,      k.nlsd,   k.nlsk,      k.s,   decode(k.tto,k.ttp,k.nazn,k.txt),
    k.nmsn_d,  k.nmsn_k,  k.vob,     k.vdat,     k.stmt,      k.otm,
    k.ksn_d ,  k.ksn_k);
end loop;
commit;
-- сформируем общий признак обязательности (для экранной формы, для автооплаты не нужен!!!)
for p in (select /*+ INDEX(tmp_ob22_funu_auto)*/
                 ref,stmt,prizn_d,prizn_k
            from tmp_ob22_funu_auto )
loop
    if        nvl(p.prizn_d,'0')='1' or nvl(p.prizn_k,'0')='1'
              then     l_prizn:='1';
    elsif  NVL (p.prizn_d, '0') = '3' OR NVL (p.prizn_k, '0') = '3'
              then     l_prizn:='3';
    else l_prizn:=0;
    end if;
 --bars_audit.info('tmp_funu='||p.ref||'='||l_prizn );
   update    tmp_ob22_funu_auto set prizn=l_prizn
        where ref=p.ref and stmt=p.stmt;
end loop;
commit;
-- блок оплаты PO3(авто)----------
-- все дебеты ФУ платим наоборот в НУ (счет А - КТ, счет Б - ДТ)
-- все кредиты ФУ платим как есть     (счет А - ДТ, счет Б - КТ)
for t in (
       select /*+ INDEX(tmp_ob22_funu_auto)*/
              ref,       stmt,          s,
              vob,        decode(vob,96,vdat, 99,vdat, fdat) dat_pay,
              nlsn_d,  ksn_d , nlsn_k ,  ksn_k
       from  tmp_ob22_funu_auto
       where bitand(nvl(otm,0),1)   = 0
         and bitand(nvl(otm,0),2) = 0 )
loop
   savepoint nal#ob22#autopay;
   GL.bdate:=t.dat_pay;
   begin
    if  t.nlsn_d is not null  and  t.ksn_d is not null then
       gl.payv(1, t.ref,  t.dat_pay, 'PO3',0, 980, t.nlsn_d, t.S, 980, t.ksn_d ,t.S);
    end if;
    exception when others then
                               rollback to nal#ob22#autopay;
                               goto CONTIN;
   end;
   begin
    if  t.nlsn_k is not null  and  t.ksn_k is not null  then
       gl.payv(1, t.ref, t.dat_pay, 'PO3',1, 980, t.nlsn_k, t.S, 980, t.ksn_k ,t.S);
    end if;
    exception when others then
                  rollback to nal#ob22#autopay;
                  goto CONTIN;
   end;
   update opldok             set otm= bitand(nvl(otm,0),254)+1 where ref=t.ref  and stmt=t.stmt;
   update tmp_ob22_funu_auto  set otm= bitand(nvl(otm,0),254)+1 where ref=t.ref  and stmt=t.stmt;
-- проводка с t.stmt обработана, но возможно остались еще
-- проставим признак об оплате, если все проводки уже обработаны
   begin
    l_kk:=0;
    select  /*+ INDEX(o)  INDEX(s)*/
      count(*) into l_kk
      from  opldok o,tmp_ob22_funu_auto s
     where  o.ref=t.ref
       and  o.ref=s.ref
       and  o.stmt=s.stmt
       and bitand(nvl(o.otm,0),1) = 0   -- не оплачена в НУ
       and bitand(nvl(o.otm,0),2) = 0   -- не снята с визы в НУ
       and o.tt<>'PO3' ;
       exception when no_data_found then null;
   end;
   if l_kk=0 then
      insert into oper_visa (ref, dat, userid, groupid, status, passive)
                                    values (t.ref, SYSDATE, USER_ID, l_grp, 2, null) ;
   end if;
   commit;
   <<contin>> null;
end loop;
GL.bdate:=dat_tek;
end  P_OB22NU_AUTO ;
/
 show err;
 
PROMPT *** Create  grants  P_OB22NU_AUTO ***
grant EXECUTE                                                                on P_OB22NU_AUTO   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_OB22NU_AUTO   to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/procedure/p_ob22nu_auto.sql =========*** End
 PROMPT ===================================================================================== 
 