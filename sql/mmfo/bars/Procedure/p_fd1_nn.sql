

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FD1_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FD1_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_FD1_NN (Dat_ DATE ,
                                      sheme_ varchar2 default 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #D1 для КБ (универсальная)
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 24/11/2017 (03/02/2015)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
08.02.2013 для показателя кол-ва клиентов добавил DISTINCT
01.02.2013 в поле TOBO таблицы RNBU_TRACE формирования код TOBO счета а не
           код TOBO клиента
09.01.2013 для 2625 всегда тип клиента будет '3' ФЛ
03.10.2012 для определения кода территории убрал условие "sheme_ = 'G'"
05.03.2012 для формирования показатедя DD='40' банк.металлы включаем бал.
           счета 2610,2615,2630,2635,2651,2652 (код DD='20')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='D1';
acc_     number;
typ_     number;
mfo_     Varchar2(12);
nbuc1_   Varchar2(12);
nbuc_    Varchar2(12);
k040_    Varchar2(3);
k042_    Varchar2(1);
okpo_    Varchar2(14);
passp_   Number;
ser_     Varchar2(10);
numdoc_  Varchar2(20);
pdate_   Date;
organ_   Varchar2(50);
kol_     Number;
kol1_    Number;
rnk_     Number:=0;
dos_     Number;
kos_     Number;
nmk_     Varchar2(15);
rnk1_    Number:=0;
pr_id    Number:=0;
pr_af4   Number:=0;
pr_k042  Number:=0;
pr_utoch Number:=0;
n_np_    Number:=0;
dat_izm  Date := to_date('30062010','ddmmyyyy');
data_    Date;
Dat1_    Date;
Dat2_    Date;
Dat3_    Date;
userid_  Number;
rez_     Varchar2(1);
tk_      Varchar2(1);
d_       Varchar2(1):=null;
g_       Varchar2(1):=null;
k_tobo_  accounts.tobo%TYPE;
k_obl_   Varchar2(20);
dd_      Varchar2(2);
comm_    Varchar2(200);
pp_      Varchar2(2) := '00';

type t_otcn_log is table of number index by pls_integer;
table_otcn_log1_ t_otcn_log;
table_otcn_log2_ t_otcn_log;
table_otcn_log3_ t_otcn_log;
table_dos_ t_otcn_log;
table_kos_ t_otcn_log;

-----------------------------------------------------------------------------
FUNCTION f_tobo_rnk ( k_tobo_ IN Varchar2 )
  RETURN  Varchar2
IS
  kod_obl_   tobo.b040%TYPE;
  k_b040_    tobo.b040%TYPE;
  sql_       Varchar2(100);

BEGIN

   sql_ := 'select t.B040 ' ||
           'from tobo t ' ||
           'where trim(t.tobo)=trim(:k_tobo_)';

   BEGIN

      EXECUTE IMMEDIATE sql_ INTO k_b040_ USING k_tobo_;

      IF substr(k_b040_,9,1) = '0'
      THEN
         kod_obl_ := substr(k_b040_,4,2);
      ELSE
         IF substr(k_b040_,9,1) = '1'
         THEN
            kod_obl_ := substr(k_b040_,10,2);
         ELSE
            kod_obl_ := substr(k_b040_,15,2);
         END IF;
      END IF;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      kod_obl_ := null;
   END;

   RETURN kod_obl_;

END;

-----------------------------------------------------------------------------
BEGIN
   commit;

   EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';

   logger.info ('P_FD1_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
   -------------------------------------------------------------------

   userid_ := user_id;

   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
   EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_ACC';
   EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_SALDO';
   EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_FILE03';
-------------------------------------------------------------------
   Dat1_ := TRUNC(Dat_,'MM'); -- початок попереднього мiсяця

   if dat_ > dat_izm then  --to_date('30062010','ddmmyyyy')
      Dat3_ := Dat1_;   -- кiнець попереднього мiсяця
   else
      Dat3_ := add_months(Dat_, -3); -- кiнець попереднього кварталу
   end if;

   mfo_:=F_OURMFO();   -- МФО банка

   Dat2_ := TRUNC(Dat_ - 365); -- дата попереднього року

   -- параметры формирования файла
   p_proc_set(kodf_,sheme_,nbuc1_,typ_);

   nbuc_ := nbuc1_;

   insert /*+APPEND  */
   into otcn_acc(acc, nls, kv, nbs, rnk, daos, dapp,
        isp, nms, lim, pap, tip, vid, mdate, dazs, accc, tobo)
   select /*+PARALLEL(8) */
          a.acc,a.nls,a.kv,a.nbs,a.rnk,a.daos,a.dapp,
          0,null,0,0,null,0,null,a.dazs,0,a.tobo
   from accounts a
   where a.dapp is not null
     and a.dapp > Dat2_
     and a.nls NOT LIKE '8605%'
     and a.nls NOT LIKE '8625%'
     and ((a.nbs is not null and Dat_ <= dat_izm) OR
          (a.nbs is not null and a.nbs in (select distinct r020 from kl_f3_29 where kf='D1') and
           Dat_ > dat_izm)) ;

   insert /*+APPEND  */
   into otcn_saldo (odate, fdat, acc, nls, kv, nbs, rnk, ost, dos, kos)
   select /*+PARALLEL(8) */
          dat_, dat_, a.acc, s.nls, s.kv, s.nbs, s.rnk, sum(a.ostf),
          sum(case when s.nbs = '8021' and mfo_ = 353575  then a.dos else 0 end),
          sum(case when s.nbs = '8021' and mfo_ = 353575  then a.kos else 0 end)
   from saldoa a, accounts s
   where a.fdat between Dat3_ and Dat_
     and a.acc=s.acc
     and s.nls NOT LIKE '8605%'
     and s.nls NOT LIKE '8625%'
     and ((s.nbs is not null and Dat_ <= dat_izm) OR
          (s.nbs is not null and s.nbs in (select distinct r020 from kl_f3_29 where kf='D1') and
           Dat_ > dat_izm))
   group by dat_, dat_, a.acc, s.nls, s.kv, s.nbs, s.rnk ;

   insert /*+APPEND PARALLEL(8) */
   into TMP_FILE03(ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select *
   from (select accd,tt,ref,kv,nlsd,s,sq,fdat,nazn,acck,nlsk,isp
            from (SELECT p.userid isp, p.branch, p.mfoa, p.mfob, p.nam_a, p.nam_b, p.sos,
                           DECODE (o.tt, p.tt, p.nazn, DECODE (o.tt, 'PO3', p.nazn, t.NAME)) nazn,
                           o.tt, o.REF, o.sq/100 sq, o.fdat, o.stmt, o.txt,
                           (case when ad.nls like '3801%' then 0 else o.accd end) accd,
                           (case when ad.nls like '3801%' then decode(p.dk,1,p.nlsa,p.nlsb) else ad.nls end) nlsd,
                           (case when ad.nls like '3801%' then substr(decode(p.dk,1,p.nlsa,p.nlsb),1,4) else ad.nbs end) nbsd,
                           (case when ak.nls like '3801%' then 0 else o.acck end) acck,
                           (case when ak.nls like '3801%' then decode(p.dk,0,p.nlsa,p.nlsb) else ak.nls end) nlsk,
                           (case when ak.nls like '3801%' then substr(decode(p.dk,0,p.nlsa,p.nlsb),1,4) else ak.nbs end) nbsk,
                           (case when ad.nls like '3801%' or ak.nls like '3801%' then decode(p.kv, 980, p.kv2, p.kv) else ad.kv end) kv,
                           (case when ad.nls like '3801%' or ak.nls like '3801%' then decode(p.kv, 980, p.s2, p.s) else o.s end)/100 s
                    FROM oper p, accounts ad,   accounts ak,
                         (SELECT p.fdat, p.REF, p.stmt, p.tt, p.s, p.sq, p.txt,
                                 DECODE (p.dk,0,p.acc,z.acc) accd,
                                 DECODE (p.dk,1,p.acc,z.acc) acck
                          FROM opldok p, accounts a, opldok z
                          WHERE p.fdat between Dat1_ and Dat_ and
                             p.sos >= 4 and
                             p.acc = a.acc and
                             a.nbs in (select r020 from kl_f3_29 where kf='D1') and
                             p.ref = z.ref and
                             p.stmt = z.stmt and
                             p.dk <> z.dk) o, tts t
                    WHERE p.REF = o.REF AND o.accd = ad.acc
                      AND o.acck = ak.acc
                      and p.sos = 5
                      and t.tt = o.tt)
                      )
      where not ((substr(nlsd,1,4) in (select r020 from kl_f3_29 where kf='D1')) and
          (nlsk like '6%' or nlsk like '7%' or nlsk like '357%'))
         and
           not (substr(nlsd,1,4) in ('2630','2635') and nlsk like '2620%')
         and
           not (substr(nlsd,1,4) in ('2202','2203') and nlsk like '2625%')
         and
           not (nlsd like '2625%' and substr(nlsk,1,4) in ('2202','2203','2208'))
         and
           not (nlsd like '8625%' and nlsk like '2625%')
         and
           not (nlsd like '2650%' and nlsk like '2600%')
         and
           not ((nlsk like '260%' or nlsk like '265%') and exists
          (select o.ref from oper o where o.ref=ref and mfoa=mfob and id_a != id_b))
         and
           not (nlsd like '___8%' and
          substr(nlsk,1,4) in (select r020 from kl_f3_29 where kf='D1'))
         and
           not ((nlsd like '6%' or nlsd like '7%') and
           substr(nlsk,1,4) in (select r020 from kl_f3_29 where kf='D1'))
         and
           not tt in ('АСВ'); -- операції по розгортанню залишків з АСВО
   commit;

   logger.info ('P_FD1_NN: Etap 1 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

   update tmp_file03 a set
    a.accd=(select acc from accounts
            where nls=a.nlsd and kv=decode(substr(a.nlsd,1,1),'6',980,
                                    decode(substr(a.nlsd,1,1),'7',980,a.kv)))
    where (a.accd=0 or a.accd is NULL);

   update tmp_file03 a set
    a.acck=(select acc from accounts
            where nls=a.nlsk and kv=decode(substr(a.nlsk,1,1),'6',980,
                                    decode(substr(a.nlsk,1,1),'7',980,a.kv)))
    where (a.acck=0 or a.acck is NULL);

   if dat_ <= dat_izm then
       for k in (select rnk,count(*) co
                 from accounts
                 where daos <= Dat_
                  and (dazs is null or dazs > Dat_)
                 group by rnk )
       loop
          if k.rnk is not null then
             table_otcn_log1_(k.rnk):=k.co;
          end if;
       end loop;

       for k in (select rnk,count(*) co
                 from  otcn_acc
                 where (dazs is null or dazs > Dat_)
                   and nbs not in ('2903')
                 group by rnk )
       loop
          table_otcn_log2_(k.rnk):=k.co;
       end loop;
   end if;

   -- изменяем Kт обороты только  по счетам не в кореспонденции с 6,7 классами
   -- и не внутри раздела
   MERGE  /*+parallel(8)*/
    INTO OTCN_SALDO A
         USING (  SELECT  ACCK, NVL (SUM (S * 100), 0) KOS
                    FROM TMP_FILE03 t
                   WHERE FDAT BETWEEN dat3_ AND dat_
                GROUP BY ACCK) B
            ON (B.ACCK = A.ACC)
    WHEN MATCHED
    THEN
       UPDATE SET A.KOS = B.KOS
    WHEN NOT MATCHED
    THEN
       insert(acc, kos, odate, fdat) values (b.acck, b.kos, dat_, dat_);

   MERGE  /*+parallel(8)*/
    INTO OTCN_SALDO A
         USING (  SELECT  ACCD, NVL (SUM (S * 100), 0) DOS
                    FROM TMP_FILE03 t
                   WHERE FDAT BETWEEN dat3_ AND dat_
                GROUP BY ACCD) B
            ON (B.ACCD = A.ACC)
    WHEN MATCHED
    THEN
       UPDATE SET A.DOS = B.DOS
    WHEN NOT MATCHED
    THEN
       insert(acc, dos, odate, fdat) values (b.accd, b.dos, dat_, dat_);

   for k in (select acc,
                    sum(dos) dos,
                    sum(kos) kos,
                    count(*) co
             from otcn_saldo
             where NVL(dos,0)+NVL(kos,0) <> 0
             group by acc )
   loop
      table_otcn_log3_(k.acc):=k.co;
      table_dos_(k.acc):=k.dos;
      table_kos_(k.acc):=k.kos;
   end loop;

   logger.info ('P_FD1_NN: Etap 2 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- новая структура показателя c 01.08.2010
if dat_ > dat_izm then

   for k in (select c.rnk RNK, c.nmk NMK, a.acc, a.nbs, a.nls, a.kv,
                 decode(a.kv,980,1,2) R034,
                 c.date_on Dat,
                 decode(c.custtype,1,'4',2,'1',
                 decode(substr(trim(c.sed),1,2),'91','2','3')) TK,
                 c.okpo OKPO,
                 trim(c.tobo) tobo,
                 trim(a.tobo) tobo_a,
                 NVL(trim(p.r011),'0') R011,
                 NVL(trim(p.r013),'0') R013,
                 trim(kl.ddd) ddd
          from  customer c, accounts a, specparam p, kl_f3_29 kl  --cust_acc ca
          where c.codcagent < 7
            and c.rnk not in (select rnk from kf77 where rnk is not null)
            and c.date_on <= Dat_
            and a.rnk=c.rnk
            and a.daos <= Dat_   -- не включаем клиентов с закрытыми счетами
            and (a.dazs is null or a.dazs > Dat_)
            and a.nls NOT LIKE '8605%'
            and a.nls NOT LIKE '8625%'
            and a.nbs=kl.r020
            and kl.kf='D1'
            and (c.date_off is null or c.date_off > Dat_)
            and a.acc=p.acc(+)
          order by 1 )
      loop

      if k.tk not in ('0','4') then --k.tk != '4'
         comm_ := trim(k.tobo) || '  ' || k.nmk || ' ' || trim(k.okpo);
         dd_ := k.ddd;

         tk_ := k.tk;

         -- для банка Демарк карточки тип клиента ФЛ
         if mfo_ = 353575 and k.nbs = '8021' then
            tk_ := '3';
         end if;

      -- для банка СБ Кировоград по клиетам банк и бал.сч. 2620, 2630, 2635
      -- изменяет тип клиента на ФЛ
         if mfo_ = 323475 and k.nbs in ('2620','2625','2630','2635') and
            k.rnk in (90711,48278,32227,64121,95920,79975,32234,80025,32233,
                      48268,189,64118,32181,48232,64083,112004,112046,80012,
                      48228,32229,32225,16229,48238,32183,48242,112058,80029,
                      32227,16212,113090,16472,32235,32428,64354,80223,16503,
                      111977,111977,282635,282637,283309,284006,284007,284008,
                      284009,285347,285348,285349,287360,32408,285684,118711,
                      18898,95198,98275)
         then
            tk_ := '3';
         end if;

         if (k.nbs='2600' and k.r013='7') or (k.nbs='2620' and k.r013='1') or
            (k.nbs='2650' and k.r013='8') then
            dd_ := '20';
         end if;

         if k.kv in (959, 961, 962, 964) and dd_ in ('10','20') then
            dd_ := '40';
         end if;

         nbuc_ := nbuc1_;

         IF typ_ > 0 THEN
             nbuc_ := NVL(F_Codobl_Tobo(k.acc,typ_),nbuc1_);
         ELSE
             nbuc_ := NVL(nbuc1_,'0');
         END IF;

         IF nbuc_ IS NULL THEN
            nbuc_:='0';
         END IF;

         insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm, acc, tobo)
         VALUES
            (k.nls, k.kv, k.dat, '3'||'5'||dd_||tk_||k.r034, '1', nbuc_, k.rnk, comm_, k.acc, k.tobo_a);

         -- в тому числi рахунки з виплати зарплати, пенсiй та iншi соц.виплати
         if k.nbs = '2625' and dd_ = '30' and k.r011='1' then
            insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm, acc, tobo)
            VALUES
               -- 09/01/2013 тип клиеньа всегда '3'(заменил tk_ на '3')
               (k.nls, k.kv, k.dat, '3'||'5'||'31'||'3'||k.r034, '1', nbuc_, k.rnk, comm_, k.acc, k.tobo_a);
         end if;

         -- в тому числi рахунки з виплати зарплати, пенсiй та iншi соц.виплати
         -- для банка Демарк бал.счет 8021
         if mfo_ = 353575 and k.nbs = '8021' and dd_ = '30' then
            insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm, acc, tobo)
            VALUES
               (k.nls, k.kv, k.dat, '3'||'5'||'31'||tk_||k.r034, '1', nbuc_, k.rnk, comm_, k.acc, k.tobo_a);
         end if;

         if table_otcn_log3_.count()>0 and table_otcn_log3_.exists(k.acc) then
            insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm, acc, tobo)
            VALUES
               (k.nls, k.kv, k.dat, '3'||'7'||dd_||tk_||k.r034, '1', nbuc_, k.rnk,
                    comm_||' dos='||to_char(table_dos_(k.acc))||' kos='||to_char(table_kos_(k.acc)), k.acc, k.tobo_a);

             -- в тому числi рахунки з виплати зарплати, пенсiй та iншi соц.виплати
             if k.nbs = '2625' and dd_ = '30' and k.r011='1' then
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm, acc, tobo)
                VALUES
                   -- 09/01/2013 тип клиеньа всегда '3'(заменил tk_ на '3')
                   (k.nls, k.kv, k.dat, '3'||'7'||'31'||'3'||k.r034, '1', nbuc_, k.rnk,
                        comm_||' dos='||to_char(table_dos_(k.acc))||' kos='||to_char(table_kos_(k.acc)), k.acc, k.tobo_a);
             end if;

             -- в тому числi рахунки з виплати зарплати, пенсiй та iншi соц.виплати
             -- для банка Демарк бал.счет 8021
             if mfo_ = 353575 and k.nbs = '8021' and dd_ = '30' then
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm, acc, tobo)
                VALUES
                   (k.nls, k.kv, k.dat, '3'||'7'||'31'||tk_||k.r034, '1', nbuc_, k.rnk,
                        comm_||' dos='||to_char(table_dos_(k.acc))||' kos='||to_char(table_kos_(k.acc)), k.acc, k.tobo_a);
             end if;
         end if;

      end if;

      end loop;

end if;

if dat_ <= dat_izm then

   for k in (select distinct substr(c.nmk,1,15) NMK, c.rnk RNK, c.date_on Dat,
                 decode(c.custtype,1,'4',2,'1',
                 decode(substr(trim(c.sed),1,2),'91','2','3')) TK,
                 decode(c.country,null,'1',804,'1','2') REZ,
                 nvl(l.k042,'9') k042,
                 'XXXXX' TAG, '0000000000' VALUE, c.okpo OKPO,
                 p.passp PASSP, p.ser SER, p.numdoc NUMDOC, p.organ ORGAN,
                 substr(trim(c.tobo),-12) tobo
          from  customer c, kl_k040 l, person p, --cust_acc ca
-- не включаем клиентов с закрытыми счетами
                (select distinct rnk from cust_acc
                 where acc in (select acc from accounts
                               where daos <= Dat_ and
                                     (dazs is null or dazs > Dat_))) ca
          where c.codcagent < 7
            and c.rnk=ca.rnk
            and c.rnk not in (select rnk from kf77 where rnk is not null)
            and c.date_on <= Dat_
            and c.rnk not in (select rnk from customerw
                              where tag in ('KODID','AF4','UPFO','OSN','UTOCH',
                                            'OSNN','COSN','COSNN','RISK'))
            and (c.date_off is null or c.date_off > Dat_)
            and NVL(lpad(to_char(c.country),3,'0'),'804')=l.k040(+)
            and c.rnk=p.rnk(+)
          UNION ALL
          select distinct substr(c.nmk,1,15) NMK, c.rnk RNK, c.date_on Dat,
                 decode(c.custtype,1,'4',2,'1',
                 decode(substr(trim(c.sed),1,2),'91','2','3')) TK,
                 decode(c.country,null,'1',804,'1','2') REZ,
                 nvl(l.k042,'9') k042,
                 d.tag TAG, NVL(substr(trim(d.value),1,10),'0000000000') VALUE,
                 c.okpo OKPO,
                 p.passp PASSP, p.ser SER, p.numdoc NUMDOC, p.organ ORGAN,
                 substr(trim(c.tobo),-12) tobo
          from  customer c, customerw d, kl_k040 l, person p, --cust_acc ca
-- не включаем клиентов с закрытыми счетами
                (select distinct rnk from cust_acc
                 where acc in (select acc from accounts
                               where daos <= Dat_ and
                                     (dazs is null or dazs > Dat_))) ca
          where c.codcagent < 7
            and c.rnk=ca.rnk
            and c.rnk not in (select rnk from kf77 where rnk is not null)
            and c.date_on <= Dat_
            and c.rnk=d.rnk
            and d.tag in ('KODID','AF4','UPFO','OSN','OSNN','COSN','COSNN',
                          'RISK','UTOCH')
            and (c.date_off is null or c.date_off > Dat_)
            and NVL(lpad(to_char(c.country),3,'0'),'804')=l.k040(+)
            and c.rnk=p.rnk(+)
          order by 2 )
      loop

          if rnk_=0 then
             rnk_:=k.rnk;
             nmk_:=k.nmk;
             k_tobo_:=k.tobo;
          end if;

          if rnk_<>0 and rnk_<>k.rnk then

             if dat_ > to_date('29082008','ddmmyyyy') then
                if trim(k_tobo_) is not null then
                   k_obl_ := f_tobo_rnk( k_tobo_ );
                   if k_obl_ is not null
                   then
                      nbuc_ := k_obl_;
                   end if;
                end if;
             end if;

             if pr_id=0 and d_ is null then
                d_:='2';  -- код iдентифiкацii (iдентиф. не завершена)

                if table_otcn_log1_.count()>0 and table_otcn_log1_.exists(rnk_) then
                   kol_:=table_otcn_log1_(rnk_);
                else
                   kol_:=0;
                end if;

                if kol_=0 then
                   d_:='3';
                end if;

                if mfo_ in (300175,322498) then
                   if table_otcn_log2_.count()>0 and table_otcn_log2_.exists(rnk_) then
                      kol1_:=table_otcn_log2_(rnk_);
                   else
                      kol1_:=0;
                   end if;

                   if k.dat<to_date('01062003','ddmmyyyy') and kol1_=0 then
                      d_:='3';
                   end if;

                   select count(acc) into kol_
                   from cust_acc
                   where rnk=rnk_
                     and acc in (select acc from accounts
                                   where (dazs is null or dazs > Dat_) and
                                         nbs='2903');  -- and kv=980);
                   if kol1_=0 and kol_<>0 then
                      d_:='3';
                   end if;
                end if;
             end if;


             if d_='1' and pr_utoch=1 then
                d_:='2';  -- iдентифiкацiя не завершена
             end if;
             -- для банков проверяем наличие только межбанковских счетов
             -- для банка Демарк
             if tk_='4' then
                 select count(*) INTO kol_
                 from accounts
                 where (dazs is null or dazs > Dat_)  and
                       nbs in ('1600') and
                       acc in (select acc from cust_acc where rnk=rnk_);
             end if;
             if dat_ <= to_date('29082008','ddmmyyyy') then
                if (tk_='4' and kol_<>0) or tk_<>'4' then
                  insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                     (nmk_, rnk_, data_, '3'||d_||g_||k042_||tk_||rez_, '1', nbuc_);
                end if;
             else
                if d_ ='4' then -- отказано в открытии счета
                   if (tk_='4' and kol_<>0) or tk_<>'4' then
                     insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                          VALUES
                       (nmk_, rnk_, data_, '3'||d_||'0'||'0'||tk_||rez_, '1', nbuc_);
                   end if;
                end if;
                if d_ in ('1','2','3') then -- идент.завершена
                   if (tk_='4' and kol_<>0) or tk_<>'4' then
                      insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                             VALUES
                         (nmk_, rnk_, data_, '3'||'5'||'0'||'0'||tk_||rez_, '1', nbuc_);

                      if table_otcn_log3_.count()>0 and table_otcn_log3_.exists(rnk_) then
                         kol_:=table_otcn_log3_(rnk_);
                      else
                         kol_:=0;
                      end if;

                      if kol_ = 0 then
                         insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                             VALUES
                         (nmk_, rnk_, data_, '3'||'6'||'0'||'0'||tk_||rez_, '1', nbuc_);
                      end if;
                   end if;
                end if;
             end if;

             rnk_:=k.rnk;
             nmk_:=k.nmk;
             k_tobo_:=k.tobo;
             pr_id :=0;  -- признак присутностi параметра KODID (код iдентиф.)
             pr_af4:=0;  -- признак присутностi параметра AF4 (код ризику)
             pr_k042:=0; -- признак приналежностi до офшорноi зони
             pr_utoch:=0;  -- признак уточнения информации
             d_:=null;
             g_:=null;
          end if;

          nbuc_ := nbuc1_;

          rez_:=k.rez;
          tk_:=k.tk;
          data_:=k.dat;
          kol_:=0;
          kol1_:=0;

          if pr_k042=0 then
             k042_:=k.k042;  -- код офшорноi зони
          end if;

          if pr_af4=0 and g_ is null then
             g_:='2';  -- код ризику AF4
          end if;

          if pr_id=0 and k.tk='3' and k.rez='1' and k.okpo is not null and
             k.passp is not null and (k.ser is not null or
                                      k.numdoc is not null or
                                      k.organ is not null) then
             d_:='1';
          end if;

          if pr_id=0 and k.tk='3' and k.rez='2' and  k.passp is not null and
                                      (k.ser is not null or
                                       k.numdoc is not null or
                                       k.organ is not null) then
             d_:='1';
          end if;

          if k.tag='KODID' then  --and trim(k.value) is not null then
             d_:=nvl(substr(trim(k.value),1,1),'0');
             pr_id:=1;  -- признак присутностi параметра iдентифiкацii (KODID)

             -- при вiдсутностi параметра KODID
             -- визначаємо чи немає дiлових стосункiв
             if d_='2' THEN
                select count(*) into kol_
                from cust_acc
                where rnk=rnk_
                  and acc in (select acc from accounts
                              where daos<=Dat_ and
                                    (dazs is null or dazs > Dat_));
                if kol_=0 then
                   d_:='3';
                end if;
             end if;

             if d_ in ('1','2') and mfo_ in (300175,322498) then
                select count(*) into kol1_
                from otcn_acc
                where rnk=rnk_
                  and (dazs is null or dazs > Dat_)
                  and nbs not in ('2903');

                if k.dat<to_date('01062003','ddmmyyyy') and kol1_=0 then
                   d_:='3';
                end if;

                select count(acc) into kol_
                from cust_acc
                where rnk=rnk_
                  and acc in (select acc from accounts
                                where (dazs is null or dazs > Dat_) and
                                      nbs='2903');  -- and kv=980);
                if kol1_=0 and kol_<>0 then
                   d_:='3';
                end if;
             end if;
          end if;

          if trim(k.tag)='UTOCH' and trim(k.value) is not null and
             trim(k.value)<>'0' then
             pr_utoch:=1;  -- iдентифiкацiя не завершена
          end if;

          IF trim(k.tag) in ('UPFO','COSN','COSNN') and
                  trim(k.value) is not null THEN
             k040_:=lpad(substr(trim(k.value),1,3),3,'0');
             BEGIN
                select nvl(k042,'9') into k042_
                from kl_k040 where k040=k040_;
                pr_k042:=1;
             EXCEPTION WHEN NO_DATA_FOUND THEN
                pr_k042:=0;
             END;
          END IF;

          if (trim(k.tag) in ('AF4','RISK') and substr(trim(k.value),1,3) in
             ('ВИС','вис','Вис','ВИС','вис','Вис','ВЫС','Выс','выс',
              'ВЕЛ','Вел','вел','H')) or
              (trim(k.tag) in ('AF4','RISK') and substr(trim(k.value),1,1)='1') then
             g_:='1';
             pr_af4:=1;
          end if;

          if k.tk='3' and k.rez='1' and (g_ is null or g_='0')  then
             g_:='2';
             k042_:='9';
          end if;

end loop;

if pr_id=0 and d_ is null then
   d_:='2';  -- код iдентифiкацii (iдентиф. не завершена)
end if;

if pr_af4=0 and g_ is null then
   g_:='2';  -- код ризику AF4
end if;

if dat_ > to_date('29082008','ddmmyyyy') then
   if trim(k_tobo_) is not null then
      k_obl_ := f_tobo_rnk( k_tobo_ );
      if k_obl_ is not null
      then
         nbuc_ := k_obl_;
      end if;
   end if;
end if;

if dat_ <= to_date('29082008','ddmmyyyy') then
   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
          VALUES
      (nmk_, rnk_, data_, '3'||d_||g_||k042_||tk_||rez_, '1', nbuc_);
else
   if d_ ='4' then -- отказано в открытии счета
      insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
             VALUES
         (nmk_, rnk_, data_, '3'||d_||'0'||'0'||tk_||rez_, '1', nbuc_);
   end if;

   if d_  in ('1','2','3') then -- идент.завершена
      insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
             VALUES
         (nmk_, rnk_, data_, '3'||'5'||'0'||'0'||tk_||rez_, '1', nbuc_);

      select count(s.acc), sum(s.dos), sum(s.kos)
         into kol_, dos_, kos_
      from saldoa s, otcn_acc a
      where s.acc=a.acc
        and s.fdat between Dat3_ and Dat_
        and a.rnk=rnk_ ;

      if NVL(dos_,0) + NVL(kos_,0) = 0 then
         insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                VALUES
            (nmk_, rnk_, data_, '3'||'6'||'0'||'0'||tk_||rez_, '1', nbuc_);
      end if;
   end if;
end if;

end if;  -- до 30.07.2010


nbuc_ := nbuc1_;

   logger.info ('P_FD1_NN: Etap 3 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

if dat_ > dat_izm and mfo_ != 300120 then
-- обработка прийнятого DBF файла
   for k in (select c.nls, c.kv, c.dat_pd,
                    decode(c.kv,980,1,2) R034,
                    c.nmk NMK,
                    decode(c.rnk,NULL,c.n_pp,c.rnk) RNK,
                    c.z_date Dat,
                    trim(c.tk) TK,
                    trim(c.rizik) rizik,
                    NVL(c.id_kod,'99') OKPO,
                    NVL(trim(c.numdoc),'99') ND,
                    NVL(lpad(to_char(c.ko),2,'0'), nbuc1_) NBUC,
                    NVL(trim(kl.ddd),'30') ddd
             from  tmp_filed1 c, kl_f3_29 kl
             where c.z_date=Dat_
               and c.rnk is not null
               and substr(c.nls,1,4)=kl.r020
               and kl.kf='D1'
             order by c.id_kod)

      loop

          nbuc_ := k.nbuc;

          if k.okpo is null or trim(k.okpo) in ('000000000','0000000000','99999',
                                          '9999999999','999999999','99') then

             BEGIN
                select c.rnk
                   INTO rnk_
                from customer c
                where c.date_off is null
                  and c.date_on <= Dat_
                  and c.rnk in (select max(rnk) from person
                                where trim(numdoc)=trim(k.ND)
                                group by numdoc)
                  and c.codcagent in (1,3,5);
             EXCEPTION WHEN NO_DATA_FOUND THEN
                rnk_ := k.rnk;
             END;
          end if;

          if k.okpo is not null and trim(k.okpo) not in ('000000000','0000000000',
                                    '99999','9999999999','999999999','99') then

             BEGIN
                select c.rnk
                   INTO rnk_
                from customer c
                where c.date_off is null
                  and c.date_on <= Dat_
                  and c.rnk in (select max(rnk) from customer
                                where trim(okpo)=trim(k.okpo)
                                group by okpo)
                  and trim(c.okpo)=trim(k.okpo)
                  and c.codcagent in (1,3,5);
             EXCEPTION WHEN NO_DATA_FOUND THEN
                BEGIN
                   select c.rnk
                      INTO rnk_
                   from customer c
                   where c.date_off is null
                     and c.date_on <= Dat_
                     and c.rnk in (select max(rnk) from person
                                   where trim(numdoc)=trim(k.ND)
                                   group by numdoc)
                     and c.codcagent in (1,3,5);
                EXCEPTION WHEN NO_DATA_FOUND THEN
                   rnk_ := k.rnk;
                END;
             END;
          end if;

         if k.tk not in ('0','4') then --k.tk != '4'
            comm_ := k.nmk || ' код = ' || trim(k.okpo);
            dd_ := k.ddd;

            if k.kv in (959, 961, 962, 964) and dd_ = '10' then
               dd_ := '40';
            end if;

            insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm )
            VALUES
               (k.nls, k.kv, k.dat, '3'||'5'||dd_||k.tk||k.r034, '1', nbuc_, rnk_, comm_);

            if substr(k.nls,1,4) = '2625' and k.rizik = '1' then
               insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm )
               VALUES
                  (k.nls, k.kv, k.dat, '3'||'5'||'31'||k.tk||k.r034, '1', nbuc_, rnk_, comm_);
            end if;

            if k.dat_pd between trunc(Dat_,'MM') and Dat_  then
               insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm)
               VALUES
                  (k.nls, k.kv, k.dat, '3'||'7'||dd_||k.tk||k.r034, '1', nbuc_, rnk_, comm_);

                if substr(k.nls,1,4) = '2625' and k.rizik = '1' then
                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm )
                   VALUES
                      (k.nls, k.kv, k.dat, '3'||'7'||'31'||k.tk||k.r034, '1', nbuc_, rnk_, comm_);
                end if;
            end if;

      end if;

      end loop;

end if;

   logger.info ('P_FD1_NN: Etap 4 for datf = '||to_char(dat_, 'dd/mm/yyyy'));


if dat_ > dat_izm and mfo_ = 300120 then
   rnk_ := 999999999 ;

-- обработка прийнятого DBF файла
   for k in (select '300120' nls, c.kv, c.rnk,
                    c.z_date Dat,
                    trim(c.tk) TK,
                    c.id_kod,
                    trim(c.rizik) rizik,
                    NVL(lpad(to_char(c.ko),2,'0'), nbuc1_) NBUC,
                    '30' ddd
             from  tmp_filed1 c
             where c.z_date=Dat_
               and c.rnk is not null)

      loop

          nbuc_ := k.nbuc;
          comm_ := 'банк 300120';

          dd_ := k.ddd;

          if k.id_kod = 1 then
             if k.rizik = '0' then
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm )
                VALUES
                (k.nls, k.kv, k.dat, '3'||'5'||dd_||k.tk||k.kv, k.rnk, nbuc_, rnk_, comm_);
             end if;

             if k.rizik = '1' then
--                dd_ := '31';
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm )
                VALUES
                (k.nls, k.kv, k.dat, '3'||'5'||'31'||k.tk||k.kv, k.rnk, nbuc_, rnk_, comm_);
             end if;
          end if;

          if k.id_kod = 2 then
             if k.rizik = '0' then
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm)
                VALUES
                   (k.nls, k.kv, k.dat, '3'||'7'||dd_||k.tk||k.kv, k.rnk, nbuc_, rnk_, comm_);
             end if;

             if k.rizik = '1' then
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm )
                VALUES
                (k.nls, k.kv, k.dat, '3'||'7'||'31'||k.tk||k.kv, k.rnk, nbuc_, rnk_, comm_);
             end if;

          end if;

      end loop;

end if;


if dat_ <= dat_izm then
-- обработка прийнятого DBF файла
   for k in (select substr(c.nmk,1,15) NMK, decode(c.rnk,NULL,c.n_pp,c.rnk) RNK,
                 c.z_date Dat, trim(c.tk) TK, trim(c.rizik) RIZIK,
                 trim(c.kodi) KODID,
                 decode(c.country,null,'1',804,'1','2') REZ,
                 nvl(l.k042,'9') k042,
                 NVL(c.id_kod,'99') OKPO, NVL(trim(c.numdoc),'99') ND,
                 NVL(lpad(to_char(c.ko),2,'0'), nbuc1_) NBUC
          from  tmp_filed1 c, kl_k040 l
          where c.z_date=Dat_
            and c.rnk is not null
            and NVL(to_char(c.country),'804')=l.k040(+)
            order by c.id_kod)

          loop

          if dat_ > to_date('29082008','ddmmyyyy') then
             nbuc_ := k.nbuc;
          end if;

       if k.okpo is null or trim(k.okpo) in ('000000000','0000000000','99999',
                                       '9999999999','999999999','99') then

          BEGIN
             select c.rnk, NVL(substr(trim(w.value),1,1),'0')
                INTO rnk_, d_
                from customer c, customerw w
                where c.date_off is null
                  and c.date_on <= Dat_
                  and c.rnk in (select max(rnk) from person
                                where trim(numdoc)=trim(k.ND)
                                group by numdoc)
                  and c.codcagent in (1,3,5)
                  and c.rnk=w.rnk(+)
                  and w.tag(+)='KODID';

             if d_='0' and dat_ <= to_date('29082008','ddmmyyyy') then
                update rnbu_trace set kodp=substr(kodp,1,1)||k.kodid||
                                      substr(kodp,3,4)
                where kv=k.rnk;
             end if;

             if d_='0' and dat_ > to_date('29082008','ddmmyyyy') and k.kodid='1' then
                update rnbu_trace set kodp=substr(kodp,1,1)||'5'||
                                      substr(kodp,3,4)
                where kv=k.rnk;
             end if;

             if d_ in ('2','3') and k.kodid='1' and dat_ <= to_date('29082008','ddmmyyyy') then
                update rnbu_trace set kodp=substr(kodp,1,1)||k.kodid||
                                      substr(kodp,3,4)
                where kv=k.rnk;
             end if;

             if d_ in ('2','3') and k.kodid='1' and dat_ > to_date('29082008','ddmmyyyy') then
                update rnbu_trace set kodp=substr(kodp,1,1)||'5'||
                                      substr(kodp,3,4)
                where kv=k.rnk;
             end if;

          EXCEPTION WHEN NO_DATA_FOUND THEN
             if dat_ <= to_date('29082008','ddmmyyyy') then
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                   (k.nmk, k.rnk, k.dat, '3'||k.kodid||k.rizik||k.k042||k.tk||k.rez, '1', nbuc_);
             else
                if k.kodid='1' then
                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                          VALUES
                      (k.nmk, k.rnk, k.dat, '3'||'5'||'0'||'0'||k.tk||k.rez, '1', nbuc_);
                end if;
             end if;
          END;
       end if;

       if k.okpo is not null and trim(k.okpo) not in ('000000000','0000000000',
                                 '99999','9999999999','999999999','99') then

          BEGIN
             select c.rnk, NVL(substr(trim(w.value),1,1),'0')
                INTO rnk_, d_
                from customer c, customerw w
                where c.date_off is null
                  and c.date_on <= Dat_
                  and c.rnk in (select max(rnk) from customer
                                where trim(okpo)=trim(k.okpo)
                                group by okpo)
                  and trim(c.okpo)=trim(k.okpo)
                  and c.codcagent in (1,3,5)
                  and c.rnk=w.rnk(+)
                  and w.tag(+)='KODID';

             if d_='0' and dat_ <= to_date('29082008','ddmmyyyy') then
                update rnbu_trace set kodp=substr(kodp,1,1)||k.kodid||
                                      substr(kodp,3,4)
                where kv=k.rnk;
             end if;

             if d_='0' and dat_ > to_date('29082008','ddmmyyyy') and k.kodid='1' then
                update rnbu_trace set kodp=substr(kodp,1,1)||'5'||
                                      substr(kodp,3,4)
                where kv=k.rnk;
             end if;

             if d_ in ('2','3') and k.kodid='1' and dat_ <= to_date('29082008','ddmmyyyy') then
                update rnbu_trace set kodp=substr(kodp,1,1)||k.kodid||
                                      substr(kodp,3,4)
                where kv=k.rnk;
             end if;

             if d_ in ('2','3') and k.kodid='1' and dat_ > to_date('29082008','ddmmyyyy') then
                update rnbu_trace set kodp=substr(kodp,1,1)||'5'||
                                      substr(kodp,3,4)
                where kv=k.rnk;
             end if;

          EXCEPTION WHEN NO_DATA_FOUND THEN
             BEGIN
                select c.rnk, NVL(substr(trim(w.value),1,1),'0')
                INTO rnk_, d_
                from customer c, customerw w
                where c.date_off is null
                  and c.date_on <= Dat_
                  and c.rnk in (select max(rnk) from person
                                where trim(numdoc)=trim(k.ND)
                                group by numdoc)
                  and c.codcagent in (1,3,5)
                  and c.rnk=w.rnk(+)
                  and w.tag(+)='KODID';

                if d_='0' and dat_ <= to_date('29082008','ddmmyyyy') then
                   update rnbu_trace set kodp=substr(kodp,1,1)||k.kodid||
                                         substr(kodp,3,4)
                   where kv=k.rnk;
                end if;

                if d_='0' and dat_ > to_date('29082008','ddmmyyyy') and k.kodid='1' then
                   update rnbu_trace set kodp=substr(kodp,1,1)||'5'||
                                         substr(kodp,3,4)
                   where kv=k.rnk;
                end if;

                if d_ in ('2','3') and k.kodid='1' and dat_ <= to_date('29082008','ddmmyyyy') then
                   update rnbu_trace set kodp=substr(kodp,1,1)||k.kodid||
                                         substr(kodp,3,4)
                   where kv=k.rnk;
                end if;

                if d_ in ('2','3') and k.kodid='1' and dat_ > to_date('29082008','ddmmyyyy') then
                   update rnbu_trace set kodp=substr(kodp,1,1)||'5'||
                                         substr(kodp,3,4)
                   where kv=k.rnk;
                end if;

             EXCEPTION WHEN NO_DATA_FOUND THEN
                if dat_ <= to_date('29082008','ddmmyyyy') then
                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                          VALUES
                      (k.nmk, k.rnk, k.dat, '3'||k.kodid||k.rizik||k.k042||k.tk||k.rez, '1', nbuc_);
                else
                   if k.kodid in ('1','2','3') then
                      insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                             VALUES
                         (k.nmk, k.rnk, k.dat, '3'||'5'||'0'||'0'||k.tk||k.rez, '1', nbuc_);
                   end if;
                end if;
             END;
          END;
       end if;

   end loop;
end if;


   logger.info ('P_FD1_NN: Etap 5 for datf = '||to_char(dat_, 'dd/mm/yyyy'));
---------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
if dat_ <= dat_izm then
   INSERT INTO tmp_nbu (kodp, datf, kodf, nbuc, znap)
      SELECT kodp, Dat_, kodf_, nbuc, SUM(to_number(znap))
      FROM rnbu_trace
      WHERE userid=userid_
      GROUP BY kodp, Dat_, kodf_, nbuc;
end if;

if dat_ > dat_izm then
   INSERT INTO tmp_nbu (kodp, datf, kodf, nbuc, znap)
   select kodp, dat_, kodf_, nbuc, to_char(sum(znap))
   from (select kodp, rnk, nbuc, count(*) znap
            from ( select distinct kodp, rnk, nbuc
                      from rnbu_trace
                      where userid=userid_
                          and rnk != 999999999
                          and nls != '300120'
                     )
         group by kodp, rnk, nbuc)
   group by kodp, dat_, kodf_, nbuc;
end if;

if dat_ > dat_izm and mfo_ = 300120 then
   for k in (select kodp, nbuc, znap
             from rnbu_trace
             where rnk = 999999999
               and nls = '300120' )

      loop
         update tmp_nbu set znap=to_char(to_number(znap)+to_number(k.znap))
         where kodf = kodf_
           and datf = dat_
           and kodp = k.kodp
           and nbuc = k.nbuc;

         IF SQL%ROWCOUNT = 0 THEN
            insert into tmp_nbu (kodp, datf, kodf, nbuc, znap) values
                                (k.kodp, dat_, kodf_, k.nbuc, k.znap);
         END IF;

      end loop;
end if;

logger.info ('P_FD1_NN: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
----------------------------------------
END p_fd1_NN;
/
show err;

PROMPT *** Create  grants  P_FD1_NN ***
grant EXECUTE                                                                on P_FD1_NN        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FD1_NN        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FD1_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
