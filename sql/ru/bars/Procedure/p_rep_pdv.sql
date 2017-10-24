

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REP_PDV.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REP_PDV ***

  CREATE OR REPLACE PROCEDURE BARS.P_REP_PDV 
          (p_dat    varchar2 )   IS
l_nazn   varchar2(160);
l_nlsb   varchar2(15);
l_namtt  varchar2(70);
l_id     number;
MODCODE   constant varchar2(3) := 'REP';
/*
  12.08.2011 qwa   Сделала описание допустимых корреспонденций
                   через справочник "Данi для в?дбору проводок по  ПДВ"
                   То есть после установки обновлений необходимо
                   доуточнить данный    справочник
  14.02.2011 qwa   Добавила данные Днепра (3622 и др.)

  13.12.2010 qwa   Убрала условие по счетам ДТ для 1,2 статей, и КТ для 3 статьи
                   (по просьбе Бойко А.М. Харьков)
  02.12.2010 qwa   Процедура отбора  проводок  для ПДВ (по постановке Харькова)
                   Выгрузка в Excel - ф-я в АРМе "Податковий обл_к ОБ"
                   в табл tmp_rep_provod добавила поля stmt, nms,nmsb,accd,acck

*/

begin
     execute immediate ' truncate table tmp_rep_provod';

     insert into tmp_rep_provod
            (TT, REF,  STMT, KV, ACCD, NLSA,  S, SQ,  ACCK, NLSB, NAZN, PDAT,   ISP)
      select TT, REF, STMT,  KV, ACCD, NLSD,  S, SQ,  ACCK, NLSK , substr(NAZN,1,160), FDAT,  0
                 from provodkin
                where fdat= to_date(p_dat,'dd-mm-yyyy');

     -- isp - статья сброс в 0
     -- получили все проводки
     -- теперь исключим то? что нам не нужно
     -- isp - номер статьи
     -- добавим названия счетов
for k in (select ref,stmt,accd,acck,a.nms nmsa, b.nms nmsb
                 from tmp_rep_provod,accounts a,accounts b
                where accd=a.acc and acck=b.acc  )
loop
        update tmp_rep_provod set nmsa=k.nmsa, nmsb=k.nmsb where ref=k.ref and stmt=k.stmt;
end loop;

 for k in (  select     p.ref,  p.stmt,  p.nlsa,   p.nlsb,
                      p.isp,  p.accd, p.acck,  i.ob22
             from     tmp_rep_provod p, specparam_int i
            where     p.isp=0  and  p.acck=i.acc(+)  )
 loop
    for z3 in
    (select nbs_dt,ob22_dt,nls_dt
            from rep_pdv
           where nn=3
    )
    loop
      if      z3.nbs_dt  is not null   -- nbs+ob22
          and z3.ob22_dt is not null
          and substr(k.nlsa,1,4)=z3.nbs_dt
          and k.ob22=z3.ob22_dt
      then
       update tmp_rep_provod set isp=3 where ref=k.ref and stmt=k.stmt;  -- только nbs
      elsif  z3.nbs_dt  is not null
         and z3.ob22_dt is     null
         and substr(k.nlsa,1,4)=z3.nbs_dt
      then
        update tmp_rep_provod set isp=3 where ref=k.ref and stmt=k.stmt;  -- только заданные nls
      elsif  z3.nbs_dt   is     null
         and z3.ob22_dt  is     null
         and z3.nls_dt   is not null
         and k.nlsa=z3.nls_dt
      then
        update tmp_rep_provod set isp=3 where ref=k.ref and stmt=k.stmt;
      end if;
    end loop;
 -- статья 2    --   только 3622 (аналитический)
    for z2 in (select nls_kt
               from rep_pdv
              where nn=2
               and nls_kt is not null)
    loop
        if k.nlsb=z2.nls_kt then
           update tmp_rep_provod set isp=2 where ref=k.ref and stmt=k.stmt;
        end if;
    end loop;
 end loop;
 -- статья 1
 for t in (select     p.ref,  p.stmt,  p.nlsa,   p.nlsb,
                      p.isp,  p.accd, p.acck,  i.ob22
             from     tmp_rep_provod p, specparam_int i
            where     p.isp=0  and  p.acck=i.acc(+) )
 loop
    for z1 in
    (select nbs_kt,ob22_kt,nls_kt
            from rep_pdv
           where nn=1
    )
    loop
      if      z1.nbs_kt  is not null   -- nbs+ob22
          and z1.ob22_kt is not null
          and substr(t.nlsb,1,4)=z1.nbs_kt
          and t.ob22=z1.ob22_kt
      then
       update tmp_rep_provod set isp=1 where ref=t.ref and stmt=t.stmt;  -- только nbs
      elsif  z1.nbs_kt  is not null
         and z1.ob22_kt is     null
         and substr(t.nlsb,1,4)=z1.nbs_kt
      then
        update tmp_rep_provod set isp=1 where ref=t.ref and stmt=t.stmt;  -- заданный nls
      elsif  z1.nbs_kt   is     null
         and z1.ob22_kt  is     null
         and z1.nls_kt   is not null
         and t.nlsb=z1.nls_kt
      then
        update tmp_rep_provod set isp=1 where ref=t.ref and stmt=t.stmt;
      end if;
    end loop;
 end loop;
commit;
end p_rep_pdv;
/
show err;

PROMPT *** Create  grants  P_REP_PDV ***
grant EXECUTE                                                                on P_REP_PDV       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_REP_PDV       to NALOG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REP_PDV.sql =========*** End ***
PROMPT ===================================================================================== 
