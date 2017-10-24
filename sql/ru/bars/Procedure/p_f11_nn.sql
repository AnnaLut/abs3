

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F11_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F11_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F11_NN (Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :  Процедура формирование файла #11 для КБ
% COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     :  08/02/2017 (07/02/2017, 07/06/2016)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
08/02/2017 убрал блок выравнивания остатков по счетам резерва с файлом #02
07/02/2017 на 01.02.2017 вместо поля KAT в NBU23_REZ будем использовать
           поле S080 согласно постанове 351
07/06/2016 при пустом K150 выбираем значение 3(ФЛ) вместо 2(ЮЛ)
09/02/2016 для поля REZQ добавил NVL т.к. в некоторых РУ было NULL
20/01/2016 отменяем все условия для даты 31.12.2015
           будем формировать файл как было ранее
16/01/2016 добавлен блок для проводок по списанию со счетов резерва
15/01/2016 сумму резерва для даты 31.12.2015 выбираем из даты 01.12.2015
09/07/2015 для бал.счета 1509 счет резерва формируем 1592 если
           R011='1' иначе 1590
04/07/2014 для таблицы NBU23_REZ изменено условие отбра для кат.качества
           (вместо NLS, KV будем брать ACC)
12/03/2014 для бал.счетов 1508,1509 счет резерва формируем 1592 если
           это проценты для 1500 иначе 1590
07/02/2014 для банка Демарк выравнивание остатков по счетам резерва
           с файлом 02 выполняется по категории 1 и 2 (входят категории
           2,3,4,5)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='11';
sheme_   Varchar2(1):='G';
rnk_     number;
codc_    number;
typ_     number;
acc_     Number;
isp_     Number;
nbs_     Varchar2(4);
nbs_r013_ Varchar2(5);
nls_     Varchar2(15);
flag_    Number;
data_    date;
dat1_    Date;
dat2_    Date;
datp_    Date;
sn_      DECIMAL(24);
se_      DECIMAL(24);
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dos96_   DECIMAL(24);
Kos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kosq96_  DECIMAL(24);
cust_    SMALLINT;
dk_      char(1);
Kv_      Number;
kodp_    varchar2(12);
znap_    varchar2(30);
s080_    Varchar2(1);
kat23_   Varchar2(1);
r013_    Varchar2(1);
tk_      Varchar2(1);
tk1_     Varchar2(1);
k070_    Varchar2(5);
k074_    Varchar2(1);
k081_    Varchar2(1);
k041_    Varchar2(1);
userid_  Number;
nbuc1_   varchar2(30);
nbuc_    varchar2(30);
DatN_    date;
sql_acc_ varchar2(2000):='';
datz_        date := dat_ + 1;
sql_doda_ varchar2(200):='';
ret_     number;
rezid_   number;
mfo_    number;
mfou_   number;
comm_   varchar2(200):='';
branch_ accounts.tobo%TYPE;
nms_    accounts.nms%TYPE;

acco_       number;
acc2_       number;
nd_         number;
vidd_       number;
s180_       Varchar2(1);
k150_   VARCHAR2(1);
recid_  number;
r011_   Varchar2(1);
dat_izm1 date := to_date('30112012','ddmmyyyy');
dat_izm2 date := to_date('31012017','ddmmyyyy');

CURSOR SALDO IS
   SELECT s.rnk, c.codcagent, s.acc, s.nls, s.kv, s.fdat, s.nbs, a.isp,
          nvl(trim(cc.s080),'0'), NVL(trim(cc.r013),'0'), NVL(l.k041,'1'),
          s.ost, s.ostq, s.dos96, s.kos96, s.dosq96, s.kosq96, a.tobo, a.nms,
          DECODE(Trim(cc.s180), NULL, Fs180(a.acc, SUBSTR(a.nbs,1,1), dat_), cc.s180)
   FROM  otcn_saldo s, otcn_acc a, customer c, specparam cc,  kl_k040 l
   WHERE s.acc=a.acc       and
         s.rnk=c.rnk       and
         s.acc=cc.acc(+)   and
         NVL(c.country,804)=TO_NUMBER(l.k040(+))
         and s.acc not in (select r.acc from rnbu_trace r);

CURSOR BaseL IS
    SELECT kodp, nbuc, SUM (znap)
    FROM rnbu_trace
    GROUP BY kodp, nbuc;

FUNCTION f_k150 (p_acc1_ IN NUMBER)
      RETURN VARCHAR2
   IS
      k150_   VARCHAR2 (1)   := NULL;
      sql_      VARCHAR2 (200);
   BEGIN
      IF flag_ >= 1 THEN
         sql_ :=
               'select NVL(k150,''0'') '
            || 'from specparam '
            || 'where acc=:p_acc1_ ';

         EXECUTE IMMEDIATE sql_
                      INTO k150_
                     USING p_acc1_;

      END IF;

      RETURN k150_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN NULL;
   END;

-----------------------------------------------------------------------------
--- процедура формирования протокола
procedure p_ins(p_dat_ date, p_tp_ varchar2, p_rnk_ number,
                p_codc_ number, p_acc_ number,
                p_nls_ varchar2, p_nbs_ varchar2, p_kv_ smallint,
                p_isp_ number, p_s080_ varchar2,
                p_k041_ varchar2, p_znap_ varchar2, p_nbuc_ varchar2) IS
                kod_ varchar2(12);

v_nbs_ varchar2(4);

begin
   --- Юр.лица Банки,  Другие Юр.лица,  Физ. лица
   SELECT nvl(e.k070,'00000'), nvl(e.k074,'0'), nvl(f.k081,'0')
      INTO k070_, k074_, k081_
   FROM  customer b, kl_k080 f, kl_k070 e
   WHERE b.rnk=p_rnk_    AND
         b.fs=f.k080(+)  AND
         b.ise=e.k070(+) ;

   tk1_ := null;
   tk_ := '2';

   if k070_ in ('13110','13120','13131','13132') then
      tk_ := '1';
   end if;

   if k070_ in ('00000','14101','14201','14300','14410','14420','14430') then
      tk_ := '3';
   end if;

   if k070_ in ('12100','12201','12202','12203') then
      tk_ := '4';
   end if;

   -- нерезиденти суб'єкти господарювання
   if codc_ = 4 and k070_ = '20000' then
      tk_ := '2';
   end if;
   -- нерезиденти фiзособи
   if codc_ = 6 and k070_ = '20000' then
      tk_ := '3';
   end if;
   -- нерезиденти банки
   if codc_ = 2 and k070_ = '20000' then
      tk_ := '4';
   end if;


   if flag_ > 0 then
      tk1_ := F_K150(p_acc_);
   end if;

   if tk1_ is not null and tk1_<> '0' then
      tk_ := tk1_;
   end if;

   --- с 31.08.2007 вместо кода K081 будет формироваться код K074
   if dat_ >= to_date('28082007','ddmmyyyy') then
      kod_:= p_tp_ || p_nbs_ || p_s080_ || k074_ || p_k041_ || lpad(p_kv_,3,'0');
   else
      kod_:= p_tp_ || p_nbs_ || p_s080_ || k081_ || p_k041_ || lpad(p_kv_,3,'0');
   end if;

   --- с 31.08.2008 добавлен код K150 (тип контрагента)
   if dat_ >= to_date('20082008','ddmmyyyy') then
      kod_ := kod_ || tk_;
   end if;

   INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, isp, rnk, acc, comm, nbuc)
   VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, p_isp_, p_rnk_, p_acc_, substr(comm_,1,200), p_nbuc_);

   INSERT INTO otcn_history
            (kodf, datf, nls, kv, odate, kodp, znap, isp, rnk, acc)
   VALUES  (kodf_, dat_, p_nls_, p_kv_, p_dat_, kod_, p_znap_, p_isp_, p_rnk_, p_acc_);
end;
-----------------------------------------------------------------------------
BEGIN
commit;

EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
logger.info ('P_F11_NN: Begin ');
-------------------------------------------------------------------
userid_ := user_id;

EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';

DELETE FROM OTCN_HISTORY WHERE kodf=kodf_ and datf=dat_;
-------------------------------------------------------------------

mfo_ := f_ourmfo;

-- МФО "родителя"
BEGIN
   SELECT mfou
     INTO mfou_
     FROM BANKS
    WHERE mfo = mfo_;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      mfou_ := mfo_;
END;


if 300465 in (mfo_, mfou_) then
   sheme_ := 'C';
end if;

Dat1_  := TRUNC(add_months(Dat_,1),'MM');

-- до 30.11.2012 формировались показатели по счетам резерва 1590, 2400
if dat_ <= dat_izm1
then
   -- код пользователя, данные по расчету резерву которого использовались
   -- при формировании фонда
   -- если фонд не формировался = код текущего пользователя
   BEGIN
      SELECT userid
        INTO rezid_
        FROM rez_protocol
       WHERE dat = dat_;
   EXCEPTION
       when no_data_found then
            begin
                select p.id
                INTO rezid_
                from rez_form p
                where p.dat = dat_ and
                      p.DAT_FORM =  (select max(DAT_FORM)
                                     from rez_form
                                     where dat = dat_);

       exception
            when no_data_found then
                rezid_ := userid_;
                rez.rez_risk (rezid_, dat_);
       end;
   END;
end if;

-- определение наличия поля K150 т.SPECPARAM
   SELECT COUNT (*)
     INTO flag_
     FROM all_tab_columns
    WHERE owner = 'BARS'
      AND table_name = 'SPECPARAM'
      AND column_name = 'K150';

-- определение начальных параметров (код области или МФО или подразделение)
P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);

if Dat_ = to_date('29122012','ddmmyyyy') then
   datz_ := datz_ + 1;
end if;

sql_acc_ := 'select r020 from kod_r020 where trim(prem)=''КБ'' and a010=''11''
                                         and (d_close is null or
                                              d_close > to_date('''||to_char(datz_,'ddmmyyyy')||''',''ddmmyyyy'')) ';

ret_ := f_pop_otcn(Dat_, 2, sql_acc_);

DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
-----------------------------------------------------------------------------
if 356226  not in  (mfo_, mfou_) and GetGlobalOption('OB22') <> '1' then
   --за эту дату считался резерв
   if rezid_ is not null then
     --резервный фонд
     for rr in
         (select * from (
          select  a.nls, a.acc, a.nbs,a.isp,
                  c.codcagent, nvl(k.k041,0) k041,
                  decode(nvl(sz1,-1), -1, szq, gl.p_icurval (r.kv, sz1, dat_)) se,
                  r.rnk, r.kv, r.s080, r.acc r_acc
           from tmp_rez_risk r
                join customer c on r.rnk = c.rnk
                left join kl_k040 k on r.country = k.k040
                left join accounts a on a.nls = rez_utl.F_GET_FOND(r.s080, r.custtype, r.idr,rez.id_specrez(r.wdate, r.istval, r.kv, r.idr, r.custtype), r.rz)
                                   and a.kv = r.kv
           where dat = Dat_ and id = rezid_
                 and nvl(a.nbs,'1111') like '1%'
           ) where se <> 0)
      loop
          IF typ_>0 THEN
             nbuc_ := NVL(F_Codobl_Tobo_New(rr.acc,dat_,typ_),nbuc1_);
          ELSE
             nbuc_ := nbuc1_;
          END IF;

          p_ins(dat_, 2, rr.rnk, rr.codcagent, rr.acc, rr.nls, nvl(rr.nbs,'0000'), rr.kv, rr.isp, rr.s080, rr.k041, TO_CHAR(ABS(rr.se)), nbuc_);
      end loop;

      --ошибки округления
      insert into tmp_nbu (kodf, datf, kodp, znap, nbuc)
      select kodf_, Dat_, kodp, -sum(sm)+sum( decode(t.kv, 980 ,s.ost-s.dos96+s.kos96,s.ostq-s.dosq96+s.kosq96  )) rest,
            nbuc_
      from
       (
           select t.acc, t.kv, substr(t.kodp,1,6)||'00'||substr(t.kodp,9,3)||'0' kodp, sum(znap) sm
           from rnbu_trace t
           group by t.acc, t.kv,substr(t.kodp,1,6)||'00'||substr(t.kodp,9,3)||'0'
       ) t
       left join otcn_saldo s on s.acc = t.acc
       group by kodp
       having sum(sm)-sum( decode(t.kv, 980 ,s.ost-s.dos96+s.kos96,s.ostq-s.dosq96+s.kosq96  )) <> 0;
   end if;
end if;
----------------------------------------------------------------------------
OPEN SALDO;
LOOP
   FETCH SALDO INTO rnk_, codc_, acc_, nls_, Kv_, data_, nbs_, isp_, s080_,
                    r013_, k041_, Ostn_, Ostq_, Dos96_, Kos96_, Dosq96_, Kosq96_, branch_,
                    nms_, s180_ ;
   EXIT WHEN SALDO%NOTFOUND;

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo_New(acc_,dat_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF ((nbs_ in ('1600','2600','2605','2620','2625','2650','2655') and Ostn_<0) or
       (nbs_ not in ('1600','2600','2605','2620','2625','2650','2655') and ABS(Ostn_)>=0)) THEN

      IF kv_ <> 980 THEN
         se_:=Ostq_-Dosq96_+Kosq96_;
      ELSE
         se_:=Ostn_-Dos96_+Kos96_;
      END IF;

      comm_ := branch_ || '  ' || nms_;

      IF (Dat_ <= dat_izm1 and not (nbs_ in ('1590','2400') and r013_='3')) OR
         (Dat_ > dat_izm1 and nbs_ not in ('1590','1592','2400','2401','3690'))
      then
         IF se_<>0 THEN
            dk_:=IIF_N(se_,0,'1','2','2');

            acc2_ := null;
            nd_ := null;

            if nbs_ in ('2600', '2607', '2620', '2627') then --овердрафты
              IF nbs_ in ('2607','2627')
              THEN
                 BEGIN
                    SELECT i.acc
                       INTO acco_
                    FROM int_accn i, accounts a
                    WHERE i.acra = acc_
                      AND ID = 0
                      AND i.acc = a.acc
                      AND a.nbs LIKE SUBSTR (nbs_, 1, 3) || '%'
                      AND a.nbs <> nbs_;
                 EXCEPTION
                    WHEN NO_DATA_FOUND
                    THEN
                       acco_ := NULL;
                 END;
              else
                 acco_ := acc_;
              END IF;

              begin
                select nd
                into nd_
                from acc_over
                where acco = acco_ and
                      NVL (sos, 0) <> 1;
              exception
                when NO_DATA_FOUND THEN
                  begin
                    select nd
                    into nd_
                    from acc_over_archive
                    where acco = acco_
                      and NVL (sos, 0) <> 1
                      and rownum = 1
                    order by nd desc;
                  exception
                    when NO_DATA_FOUND THEN
                      nd_ := NULL;
                  END;
              END;
            elsif nbs_ like '1%' then -- межбанк
               BEGIN
                  SELECT n.nd, c.vidd
                     INTO nd_, vidd_
                  FROM nd_acc n, cc_deal c
                  WHERE n.acc = acc_
                    AND n.nd = c.nd
                   AND (c.sdate, c.nd) = (SELECT MAX (p.sdate), MAX (p.nd)
                                          FROM nd_acc a, cc_deal p
                                          WHERE a.acc = acc_
                                            AND a.nd = p.nd
                                            AND dat_ between p.sdate and p.wdate);
               EXCEPTION WHEN NO_DATA_FOUND THEN
                   BEGIN
                      SELECT n.nd, c.vidd
                         INTO nd_, vidd_
                      FROM nd_acc n, cc_deal c
                      WHERE n.acc = acc_
                        AND n.nd = c.nd
                       AND (c.sdate, c.nd) = (SELECT MAX (p.sdate), MAX (p.nd)
                                              FROM nd_acc a, cc_deal p
                                              WHERE a.acc = acc_
                                                AND a.nd = p.nd);
                   EXCEPTION WHEN NO_DATA_FOUND THEN
                      nd_ := NULL;
                      vidd_ := NULL;
                   END;
               end;
            else -- все остальные
               BEGIN
                  SELECT n.nd, c.vidd
                     INTO nd_, vidd_
                  FROM nd_acc n, cc_deal c
                  WHERE n.acc = acc_
                    AND n.nd = c.nd
                   AND (c.sdate, c.nd) = (SELECT MAX (p.sdate), MAX (p.nd)
                                          FROM nd_acc a, cc_deal p
                                          WHERE a.acc = acc_
                                            AND a.nd = p.nd
                                            AND p.sdate <= dat_);
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  nd_ := NULL;
                  vidd_ := NULL;
               END;

            end if;

            P_GET_S080_S180(dat_, mfou_, acc_, nls_, kv_, acc2_, nd_, vidd_, rezid_, comm_, s080_, s180_);

            if Dat_ > dat_izm1 and Dat_ < dat_izm2
            then
               BEGIN
                  select NVL(trim(nb.kat),'0')
                     into s080_
                  from nbu23_rez nb
                  where nb.fdat = dat1_
                    and nb.acc = acc_
                    and rownum = 1;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                 null;
               END;
            end if;

            if Dat_ >= dat_izm2
            then
               BEGIN
                  select NVL(trim(nb.s080),'0')
                     into s080_
                  from nbu23_rez nb
                  where nb.fdat = dat1_
                    and nb.acc = acc_
                    and rownum = 1;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                 null;
               END;
            end if;

            p_ins(data_, dk_, rnk_, codc_, acc_, nls_, nbs_, kv_, isp_, s080_, k041_, TO_CHAR(ABS(se_)), nbuc_);
         END IF;
      END IF;

   END IF;
END LOOP;
CLOSE SALDO;
----------------------------------------------------------------------------------------------------------------
if Dat_ >= dat_izm1
then

    datp_ := trunc (Dat_, 'MM');
    --if dat_ = to_date('31122015','ddmmyyyy') then
    --   dat1_ := trunc (Dat_, 'MM');
    --end if;

    for k in (select nb.acc, nb.rnk, nb.nbs, nb.nls, nb.kv, nb.nd, nb.id,
              NVL(trim(nb.kat),'0') kat,
              NVL(trim(nb.s080),'0') s080,
                     NVL(trim(nb.dd),'2') dd,
                     --DECODE(Dat_, to_date('31122015','ddmmyyyy'),
                     --          GL.P_ICURVAL(nb.kv, nb.rez*100, Dat_),
                     --          round(nb.rezq*100,0)) rezq,
                     NVL(round(nb.rezq*100,0), 0) rezq,
                     NVL(nb.ddd,'000') DDD, NVL(nb.s250,'0') s250,
                     NVL(l.k041,'1') k041, c.codcagent, c.ise
              from nbu23_rez nb, customer c, kl_k040 l
              where nb.fdat = dat1_
                and nb.ddd not like '21%'
                and nb.ddd not like '31%'
                and nb.nbs not like '3548%'
                and nb.rezq <> 0
                and nb.rnk = c.rnk
                and NVL(c.country,804) = TO_NUMBER(l.k040(+))
             )
    loop

       IF typ_>0 THEN
          nbuc_ := NVL(F_Codobl_Tobo_New(k.acc,dat_,typ_),nbuc1_);
       ELSE
          nbuc_ := nbuc1_;
       END IF;

       comm_ := 'ID='||k.id||' RNK='||k.rnk||' ND='||k.nd||' DDD='||k.ddd;

       for z in ( select t.nls, t.r013, t.s080, t.id, t.kv,
                  NVL(s.ob22, '00') OB22, c.custtype, t.accr
                  from v_tmp_rez_risk_c5 t, customer c, specparam_int s
                  where t.dat = dat1_
                    and t.id not like 'NLO%'
                    and t.rnk = c.rnk
                    and t.acc = s.acc(+)
                    and t.acc = k.acc
                )

          loop

             nbs_r013_ := f_ret_nbsr_rez(z.nls, z.r013, z.s080, z.id, z.kv, z.ob22, z.custtype, z.accr);
       end loop;

       nbs_ := substr(nbs_r013_, 1, 4);

       if k.ddd in ('111','112','113','114','115')
       then

          if k.ise in ('11001','12201','12401','12501')
          then
             k074_ := '1';
          else
             k074_ := '2';
          end if;
          k150_ := '4';
       elsif k.ddd in ('121') or (k.ddd in ('124','125') and k.dd = '1') then
          if k.dd =  1 then
             k074_ := '1';
             k150_ := '1';
          else
             if k.ise in ('11001','12201','12401','12501')
             then
                k074_ := '1';
             else
                k074_ := '2';
             end if;
             k150_ := '2';
          end if;
       elsif k.ddd in ('122') or (k.ddd in ('124','125') and k.dd = '2') then
          if k.dd =  1 then
             k074_ := '1';
          else
             if k.ise in ('11001','12201','12401','12501')
             then
                k074_ := '1';
             else
                k074_ := '2';
             end if;
          end if;
          k150_ := '2';
       elsif k.ddd in ('123') or (k.ddd in ('124','125') and k.dd = '3')then
          if k.ise in ('11001','12201','12401','12501')
          then
             k074_ := '1';
          else
             k074_ := '2';
          end if;
          k150_ := '3';
       else
         null;
       end if;

       if Dat_ < dat_izm2
       then
          kodp_:= '2' || nbs_ || k.kat || k074_ || k.k041 || lpad(to_char(k.kv),3,'0') || k150_;
       else
          kodp_:= '2' || nbs_ || k.s080 || k074_ || k.k041 || lpad(to_char(k.kv),3,'0') || k150_;
       end if;
       znap_:= TO_CHAR(ABS(k.rezq));

       INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, acc, rnk, nd, comm)
       VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, k.acc, k.rnk, k.nd, comm_);

    end loop;
end if;

   /*
   -- блок для формирования разницы остатков по счетам 1590,1592,2400,2401,3590
   for k in (select a.nbs, a.kv, nvl(l.k041,'1') K041,
               DECODE(mfo_, 353575, DECODE(NVL(s.s080,'0'),'1','1','3'), NVL(s.s080,'0')) S080,
               NVL(s.k150,'3') K150,
               sum(a.Ost) Ostn, sum(a.Ostq) Ostq,
               sum(a.Dos96) dos96, sum(a.Kos96) Kos96,
               sum(a.Dosq96) Dosq96, sum(a.Kosq96) kosq96
        from otcn_saldo a, customer c, kl_k040 l, specparam s
        where a.nbs in ('1590','1592','2400','2401','3690')
          and a.rnk = c.rnk
          and a.acc = s.acc(+)
          and (a.Ost-a.Dos96+a.Kos96 <> 0  or a.Ostq-a.Dosq96+a.Kosq96<>0)
          and NVL(lpad(to_char(c.country),3,'0'),'804')=l.k040(+)
          --and NVL(s.s080,'0') <> '5'
        group by a.nbs, a.kv, nvl(l.k041,'1'),
              DECODE(mfo_, 353575, DECODE(NVL(s.s080,'0'),'1','1','3'), NVL(s.s080,'0')),
              NVL(s.k150,'3')
        order by 1,2)
   loop

      IF k.kv <> 980 THEN
         se_:=k.Ostq - k.Dosq96 + k.Kosq96;
      ELSE
         se_:=k.Ostn - k.Dos96 + k.Kos96;
      END IF;

      BEGIN
         select NVL(sum(to_number(r.znap)),0)
            into sn_
         from rnbu_trace r
         where r.kodp like '2' || k.nbs || k.s080 || '_' || k.k041 || k.kv || k.k150 || '%';
      EXCEPTION WHEN NO_DATA_FOUND THEN
         select NVL(sum(to_number(r.znap)),0)
            into sn_
         from rnbu_trace r
         where r.kodp like '2' || k.nbs || k.s080 || '_' || k.k041 || k.kv || '_' || '%';
      END;

      -- формируем разницу остатков
      if se_ <> sn_ and ABS(se_ - sn_) <= 100 then
         znap_ := to_char(se_ - sn_);
         comm_ := 'Рiзниця залишкiв по бал.рах. ' || k.nbs || ' валюта = ' ||
                  lpad(to_char(k.kv),3,'0') || ' група країн = ' || to_char(k.k041) ||
                  ' залишок по балансу = ' ||to_char(ABS(se_)) ||
                  ' сума в файлi =  ' || to_char(sn_);

         if mfo_ = 353575 then
            BEGIN
               select r.recid
                  INTO recid_
               from rnbu_trace r
               where r.kodp like '2' || k.nbs || k.s080 || '_' || '1' || k.kv || '_' || '%'
                 and rownum=1;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               recid_ := null;
               kodp_:= '2' || k.nbs || '3' || '2'|| '1' ||
                       LPAD(k.kv,3,'0') || '2';
               nbuc_ := nbuc1_;
            END;
         else
            BEGIN
               select r.recid
                  INTO recid_
               from rnbu_trace r
               where r.kodp like '2' || k.nbs || k.s080 || '_' || k.k041 || k.kv || '_' || '%'
                 and rownum=1;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               recid_ := null;
               kodp_:= '2' || k.nbs || '3' || '2'|| k.k041||
                       LPAD(k.kv,3,'0') || '2';
               nbuc_ := nbuc1_;
            END;
         end if;

         if recid_ is not null then
            select kodp
               into kodp_
            from rnbu_trace
            where recid = recid_;
         end if;

         INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, nbuc, comm)
         VALUES
            (k.nbs, k.kv, dat_, kodp_, znap_, nbuc_, comm_);
      end if;
   end loop;
   */
----------------------------------------------------------------------------------------------------------------
insert into tmp_nbu (kodf, datf, kodp, nbuc, znap)
SELECT kodf_, Dat_, kodp, nbuc, SUM (znap)
    FROM rnbu_trace
    GROUP BY kodp, nbuc;
----------------------------------------
logger.info ('P_F11_NN: End ');

END p_f11_nn;
/
show err;

PROMPT *** Create  grants  P_F11_NN ***
grant EXECUTE                                                                on P_F11_NN        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F11_NN        to RPBN002;
grant EXECUTE                                                                on P_F11_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F11_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
