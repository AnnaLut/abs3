

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/N_REZ.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure N_REZ ***

  CREATE OR REPLACE PROCEDURE BARS.N_REZ (nPar_ INT, DAT_ date ) IS
/*
 22.05.2008 Sta Для возможности работы нескольких юзеров -
                переходим на врем.табл. TMP_REZ0
        Вместе : патч patchP25.sql + Bin\v_balans.apd + procedure N_REZ.sql
 02.11.2007 Sta Ускорение для текущего дня за счет
                работы только с ACCOUNTS для считывания остатков
                (Вместо ACCOUNTS + SALDOA )
                Для режима ОНЛАЙН за - это одно и то же .
*/

BEGIN
  delete from TMP_REZ0;
  insert into TMP_REZ0 select * from rez0;
  update TMP_rez0 set ost0=0,ost1=0,ost0f=0,ost1f=0;
--  update rez0 set ost0=0,ost1=0,ost0f=0,ost1f=0;
  delete from cck_analiz;
  --------------------------
  If DAT_ < gl.BD then
     -- для прощлых дней при накоплении в архив
     -- срез всех нужных счетов
     insert into cck_analiz (uv,kv,nbs)
     select acc,kv,nbs from accounts
     where  nbs in (select nbs from rezerv);

     FOR k in
        (SELECT ID,
                sum(decode(KV,980,OST,0)                      ) OST0,
                sum(decode(KV,980,0,gl.p_icurval(KV,OST,DAT_))) OST1
         FROM  (select r.ID, a.KV,
                       sum(decode(NVL(r.pap,3), 2,
                           DECODE(sign(a.ost),1,a.ost,0), 1,
                           DECODE(sign(a.ost),-1,a.ost,0), a.ost)) OST
                FROM  rezerv r,
                      (SELECT a.UV ACC, a.KV, (s.ostf-s.dos+s.kos) OST, a.NBS
                       FROM   cck_analiz a, saldoa s
                       WHERE  a.UV=s.acc AND (a.UV,s.fdat) =
                          (SELECT c.acc,max(c.fdat)  FROM   saldoa c
                           WHERE  a.uv=c.acc AND c.fdat<=DAT_  GROUP  BY c.acc)
                        ) a
                WHERE  a.nbs=r.nbs and a.ost<>0
                GROUP  BY r.id,a.kv)
         GROUP  BY id)
     LOOP
       UPDATE TMP_rez0
          set ost0=GREATEST(k.ost0/100,0),  ost1=GREATEST(k.ost1/100,0)
          where id=k.ID;
     END LOOP;

  elsIf  DAT_ = gl.BD then
     -- Для режима ОНЛАЙН (текущее состояние)
     -- срез всех нужных счетов с остатком
     insert into cck_analiz (uv,kv,nbs,ZAL)
     select acc,kv,nbs, ostc from   accounts
     where  ostc <>0 and nbs in (select nbs from rezerv);
     FOR k in
        (SELECT ID,
                sum(decode(KV,980,OST,0)                      ) OST0,
                sum(decode(KV,980,0,gl.p_icurval(KV,OST,DAT_))) OST1
         FROM  (select r.ID, a.KV,
                       sum(decode(NVL(r.pap,3), 2,
                           DECODE(sign(a.ZAL),1, a.ZAL,0), 1,
                           DECODE(sign(a.ZAL),-1,a.ZAL,0), a.ZAL)
                           ) OST
                FROM  rezerv r,cck_analiz a
                WHERE  a.nbs=r.nbs
                GROUP  BY r.id,a.kv)
         GROUP  BY id)
     LOOP
       UPDATE TMP_rez0
          set ost0=GREATEST(k.ost0/100,0),  ost1=GREATEST(k.ost1/100,0)
          where id=k.ID;
     END LOOP;

  end if;
  ------------------------
  -- присоединение филиалов
  if nPar_ = 0 then
     FOR k in
       ( SELECT r.ID,
                sum(decode(B.KV,980,B.S,0)) OST0,
                sum(decode(B.KV,980,0,B.S)) OST1
         FROM rezerv r,
             (select substr(r.parameter,1,1) PAP,
                     substr(r.parameter,3,4) NBS,
                     substr(r.parameter,7,3) KV,
                     sum(decode( substr(r.parameter,1,1),
                                 1, -r.value,
                                     r.value)) S
              from  rnbu_in_files f,
                    rnbu_in_inf_records r
              where r.file_id = f.file_id
                and substr(f.file_name,1,3)='#01'
                and f.mfo in
                   (select mfo from banks where mfou=gl.AMFO and mfo<>mfou)                       and substr(r.parameter,2,1)='0'
                and to_date(f.last_date,'ddmmyyyy') =
                   (select max(to_date(m.last_date,'ddmmyyyy'))
                    from rnbu_in_files m
                    where f.mfo=m.mfo and substr(m.file_name,1,3)='#01'
                    )
              group by substr(r.parameter,1,1),
                       substr(r.parameter,3,4),
                       substr(r.parameter,7,3)
             ) B
         WHERE B.NBS=r.nbs
         GROUP BY r.id
       )
     LOOP
        UPDATE TMP_rez0
           set ost0f=GREATEST(k.ost0/100,0), ost1f=GREATEST(k.ost1/100,0)
           where id=k.id;
     end LOOP;

  end if;

END N_rez;
 
/
show err;

PROMPT *** Create  grants  N_REZ ***
grant EXECUTE                                                                on N_REZ           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on N_REZ           to SALGL;
grant EXECUTE                                                                on N_REZ           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/N_REZ.sql =========*** End *** ===
PROMPT ===================================================================================== 
