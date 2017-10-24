CREATE OR REPLACE PROCEDURE p_f73_NN (Dat_ DATE ,
 sheme_ varchar2 default 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирование файла #73 для КБ
% COPYRIGHT : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION : 16/06/2017 (22/12/2016)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
 sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 16.06.2017 внесены изменения которые были выполнены для ММФО 
% 02.08.2016 для Дт 1101,1102 Кт 3800 и назначение пл. "прийнято монети"
% или "прийнято з ГОУ" будет формироваться код "000"
% 19.05.2016 для операций конвертации будут коректно формироваться коды
% 270 и 370 
% 20.04.2016 добавил NOPARALLEL при наполнении табл. TMP_FILE03
% 29.03.2016 на 01.04.2016 будут включаться металлы 
% 23.10.2015 для проводок Дт 3800 Кт 100* анализируем дополнительно 
% назначение платежа
% 02.10.2014 для проводок Дт 100* Кт 3800 и D#73='342' (переводы ФЛ)
% формируем код 261 - покупка валюты т.к. переводы в валюте не 
% выплачивались а выплачивались в грн 
% документ вводился как NLSA 2809 NLSB 2909
% 13.08.2014 вместо VIEW PROVODKI будем использовать PROVODKI_OTC
% 06.05.2014 для операций сторнирования покупки/продажи валюты (оп. BAK)
% будем формировать код "000" вместо "261" или "361"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_ Varchar2(2):='73';
typ_ Number;
ref_ Number;
acc_ Number;
acck_ Number;
buf_ Number;
nls_ Varchar2(15);
nlsk_ Varchar2(15);
data_ Date;
kv_ Number;
prf_ Number;
dat1_ Date;
dig_ Number;
bsu_ Number;
sum1_ Number;
sum0_ Number;
sn_ DECIMAL(24) ;
kodp_ Varchar2(10);
znap_ Varchar2(30);
VVV Varchar2(3) ;
d020_ Varchar2(3) ;
d020_1 Varchar2(3) ;
d020_2 Varchar2(3) ;
a_ Varchar2(20);
b_ Varchar2(20);
mfo_ Number;
mfou_ number;
userid_ Number;
nbuc1_ Varchar2(12);
nbuc_ Varchar2(20);
nbuck_ Varchar2(20);
comm_ Varchar2(200);
sos_ Number;
tt_ Varchar2(3);
tt1_ Varchar2(3);
cnt_bak_ number;

CURSOR OPL_DOK IS
 select a.*, NVL(substr(nvl(w2.d020, w1.d020),1,3),'000') d020, w3.cnt_bak
 from (SELECT o.tt, o.ref, o.accd, o.nlsd, o.kv, o.fdat,
 o.s*100, o.nlsk, o.acck, o.nazn, p.sos
 FROM tmp_file03 o, oper p
 WHERE o.ref = p.ref ) a
 left outer join
 (select ref, tag, trim(substr(value,1,3)) d020
 from operw) w1
 on (a.ref = w1.ref and
 w1.tag = 'D#73')
 left outer join
 (select ref, tag, trim(substr(value,1,3)) d020
 from operw) w2
 on (a.ref = w2.ref and
 w2.tag = '73'||a.tt)
 left outer join
 (select ref, count(*) cnt_bak
 from tmp_file03
 where tt like 'BAK%'
 group by ref) w3
 on (a.ref = w3.ref);

-------------------------------------------------------------------
procedure p_ins(p_kodp_ varchar2, p_nls_ varchar2, p_nbuc_ varchar2) is
 l_kodp_ varchar2(10);
 l_znap_ varchar2(30);
begin
 l_kodp_ := p_kodp_ || lpad(kv_, 3,'0');
 l_znap_:= TO_CHAR(SN_) ;

 INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm, ref) VALUES
 (p_nls_, kv_, data_, l_kodp_, l_znap_, p_nbuc_, comm_, ref_);
end;
BEGIN
 commit;

 EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
 EXECUTE IMMEDIATE 'ALTER SESSION SET SORT_AREA_SIZE = 262144';
-------------------------------------------------------------------
 logger.info ('BARS.P_F73_NN: Begin for '||to_char(dat_,'dd.mm.yyyy'));

 -------------------------------------------------------------------
 userid_ := user_id;

 EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
 EXECUTE IMMEDIATE 'TRUNCATE TABLE tmp_file03';
 -------------------------------------------------------------------
 mfo_:=F_OURMFO();

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

    Dat1_:= TRUNC(Dat_,'MM');

    -- с учетом предыдущих выходных
    Dat1_ := calc_pdat(Dat1_);

    ---дозаполнение символов "DDD" для банка "Киев"
    if mfou_ in (300465) --and mfo_ != mfou_ 
    then
       p_f73_ch(Dat1_, Dat1_ + 9);
       commit;
       p_f73_ch(Dat1_ + 10, Dat1_ + 19);
       commit;
       p_f73_ch(Dat1_ + 20, Dat_);
       commit;
    end if;

    -- определение начальных параметров
    p_proc_set(kodf_,sheme_,nbuc1_,typ_);

    insert /*+ APPEND */
    into tmp_file03 (fdat, tt, ref, accd, nlsd, kv, acck, nlsk, s, sq, nazn)
    select fdat, tt, ref, accd, nlsd, kv, acck, nlsk, s, sq, nazn
    from provodki_otc p
    where kv != 980
      and ( (nlsd like '100%' and
             nlsd not like '1007%' and
             nlsk not like '1007%')                or
            (nlsk like '100%' and
             nlsk not like '1007%' and
             nlsd not like '1007%')                or
            (nlsd like '110%' and
             nlsd not like '1107%' and
             nlsk not like '1107%')                or
            (nlsk like '110%' and
             nlsk not like '1107%' and
             nlsd not like '1107%')
          ) 
      and not (nlsd like '100%' and nlsk like '100%')         
      and not (nlsd like '110%' and nlsk like '110%')         
      and fdat between Dat1_ and Dat_ ;
    commit;

    -----------------------------------------------------------------------------
    OPEN OPL_DOK;
    LOOP
       FETCH OPL_DOK INTO tt_, ref_, acc_, nls_, kv_, data_, sn_, nlsk_, acck_,
                          comm_, sos_, d020_, cnt_bak_ ;
       EXIT WHEN OPL_DOK%NOTFOUND;

        if sos_ = 5 then

           if d020_<>'000' then
              begin
                 buf_ := to_number(d020_);
              exception when others then
                 if sqlcode=-6502 then
                    raise_application_error(-20001,'Помилка: введений D020 не числове значення (ref='||ref_||', d020='''||d020_||''')');
                 else
                    raise_application_error(-20002,'Помилка: '||sqlerrm);
                 end if;
              end;
           end if;

           prf_:=0;
           tt1_ := null;

           if typ_>0 then
              nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
              nbuck_ := nvl(f_codobl_tobo(acck_,typ_),nbuc1_);
           else
              nbuc_ := nbuc1_;
              nbuck_ := nbuc1_;
           end if;

        -------------------------------------------------------------------------------
        --- 05.07.2003 изменение кодов 250 на коды 261, 262, 263
        --- для новых правил формирования
           IF sn_>0 and substr(nls_,1,4)='1002' and substr(nlsk_,1,4) in
              ('2620','2630','2635') and d020_='232' and mfo_=322498 THEN
              d020_:='231';
           END IF;

           IF sn_>0 and 
              substr(nls_,1,4) in ('2620','2630','2635') and
               (substr(nlsk_,1,4)='1002' and 
                d020_='342' and mfo_=322498 
                    or
                nlsk_ like '100%' and 
                d020_ <> '341'    and 
                lower(comm_) like '%поверн%')
           THEN
              d020_:='341';
           END IF;

           IF mfo_ = 300465 and sn_ > 0 and 
              substr(nls_,1,4) in ('2620','2630','2635') and
              nlsk_ like '100%' and 
              d020_ <> '342'    and 
              (lower(comm_) like '%claim%' or lower(comm_) like '%переказ%')
           THEN
              d020_:='342';
           END IF;
           
           IF sn_>0 and (substr(nls_,1,4)='1001' and substr(nlsk_,1,4)='3800') and
                 d020_='250' THEN
              p_ins('261', nls_, nbuc_);

              prf_:=1;
           END IF;

           IF sn_>0 and (substr(nls_,1,4)='1002' and substr(nlsk_,1,4)='3800') and
              d020_ in ('250','262') THEN
              p_ins('261', nls_, nbuc_);

              prf_:=1;
           END IF;

           IF sn_>0 and (substr(nls_,1,4)='1003' and substr(nlsk_,1,4)='3800') and
                 d020_='250' THEN
              p_ins('262', nls_, nbuc_);

              prf_:=1;
           END IF;
        -------------------------------------------------------------------------------
           IF sn_>0 and (substr(nls_,1,4) in ('1001','1002','1101','1102') and
              substr(nlsk_,1,4)='3800') and d020_='000'
           THEN
              if nvl(cnt_bak_, 0) > 0 then
                 tt1_ := 'BAK';
              else
                 tt1_ := null;
              END if;

              if (tt_ = 'BAK' or tt1_ = 'BAK') OR 
                 (kv_ in (959,961,962,964) and ( lower(comm_) like '%отримано%' OR
                                                 lower(comm_) like '%прийнято монети%' OR
                                                 lower(comm_) like '%прийнято з гоу%'  OR
                                                 lower(comm_) like '%прийом%оу%'
                                               )
                 ) or
                 tt_ = 'TIK'
              then
                 p_ins('000', nls_, nbuc_);
                 prf_:=1;
              else
                 p_ins('261', nls_, nbuc_);
                 prf_:=1;
              end if;
           END IF;

           IF sn_>0 and (substr(nls_,1,4)='1003' and substr(nlsk_,1,4)='3800') and
              d020_='000' THEN
              p_ins('262', nls_, nbuc_);
              prf_:=1;
           END IF;
        -------------------------------------------------------------------------------
        --- 05.07.2003 изменение кодов 350 на коды 361, 362, 363
        --- для новых правил формирования
           IF sn_>0 and (substr(nls_,1,4)='3800' and substr(nlsk_,1,4) in ('1001','1002')) and
              d020_='350' THEN
              p_ins('361', nls_, nbuc_);
              prf_:=1;
           END IF;

           IF sn_>0 and (substr(nls_,1,4)='3800' and substr(nlsk_,1,4)='1003') and
              d020_='350' THEN
              p_ins('362', nls_, nbuc_);
              prf_:=1;
           END IF;
        -------------------------------------------------------------------------------
           IF sn_>0 and (substr(nls_,1,4)='3800' and
              substr(nlsk_,1,4) in ('1001','1002','1101','1102')) and
              LOWER(comm_) not like 'вида%' and LOWER(comm_) not like 'переда%' and
              d020_='000'
           THEN
              if nvl(cnt_bak_, 0) > 0 then
                 tt1_ := 'BAK';
              else
                 tt1_ := null;
              END if;

              if tt_ = 'BAK' or tt1_ = 'BAK' then
                 p_ins('000', nls_, nbuc_);
                 prf_:=1;
              else
                 p_ins('361', nls_, nbuc_);
                 prf_:=1;
              end if;
           END IF;

           IF sn_>0 and (substr(nls_,1,4)='3800' and 
              substr(nlsk_,1,4) in ('1001','1002','1101','1102')) and
              ( LOWER(comm_) like 'видан%' or 
                LOWER(comm_) like 'передан%' or 
                LOWER(comm_) like 'видача%' or
                lower(comm_) like '%врегул%' or
                lower(comm_) like '%відправ%'               
              ) 
           THEN
              p_ins('000', nls_, nbuc_);
              prf_:=1;
           END IF;
           
--!!! Поки закоментарила, бо не зрозуміло чи ці суми включати(за 30,11,2016 - включені?)

--           IF sn_>0 and (substr(nls_,1,4)='2909' and 
--              substr(nlsk_,1,4) in ('1001','1002')) and
--              LOWER(comm_) like '%виплата%готівки%платіж%банкноти%'  
--           THEN
--              p_ins('000', nls_, nbuc_);
--              prf_:=1;
--           END IF;
--           
           IF sn_>0 and (substr(nls_,1,4)='3907' and 
              substr(nlsk_,1,4) in ('1001','1002')) and
              tt_ = '189' and
              LOWER(comm_) like '%підкріпл%'  
           THEN
              p_ins('000', nls_, nbuc_);
              prf_:=1;
           END IF;
           
                      IF sn_>0 and (substr(nls_,1,4)='3800' and substr(nlsk_,1,4)='1003') and
              d020_='000' THEN
              p_ins('362', nls_, nbuc_);
              prf_:=1;
           END IF;

           IF sn_>0 and d020_='000' and prf_=0 and (substr(nls_,1,3) in ('100','110') and
              (substr(nlsk_,1,4)<>'3800' and substr(nlsk_,1,4) not in ('1007','1107'))) THEN
              IF d020_<>'280' and d020_<>'380' THEN
                 p_ins(d020_, nlsk_, nbuc_);
                 prf_:=1;
              END IF;
           END IF;

           IF sn_>0 and d020_='000' and prf_=0 and ((substr(nls_,1,4)<>'3800' and
              substr(nls_,1,4) not in ('1007','1107')) and substr(nlsk_,1,3) in ('100','110')) THEN
              IF d020_<>'280' and d020_<>'380' THEN
                 p_ins(d020_, nls_, nbuc_);
                 prf_:=1;
              END IF;
           END IF;

           IF SN_>0 and prf_=0 THEN
              IF substr(nls_,1,3) in ('100','110') and to_number(d020_) < 300 THEN
                 IF d020_<>'280' THEN
                    p_ins(d020_, nlsk_, nbuc_);
                 END IF;
              END IF;

              IF substr(nlsk_,1,3) in ('100','110') and to_number(d020_) > 300 THEN
                 IF d020_<>'380' THEN
                    p_ins(d020_, nls_, nbuck_);
                 END IF;
              END IF;

              IF substr(nls_,1,3) in ('100','110') and to_number(d020_) > 300  THEN

                 if substr(nlsk_,1,4)='3800' and d020_ in ('361','362','363','370') then
                    d020_:=to_char(to_number(d020_)-100);
                 end if;

                 IF mfo_=300465 and d020_='310' THEN
                    d020_:= '270';
                 END IF ;

                 if to_number(d020_) > 300 and d020_ <> '342' then
                    d020_:='200';
                 end if;

                 if substr(nlsk_,1,4) = '3800' and d020_ = '342' then
                    d020_:='261';
                 end if;

                 IF d020_<>'280' and d020_<>'380' THEN
                    p_ins(d020_, nlsk_, nbuck_);
                 END IF;
              END IF ;

              IF substr(nlsk_,1,3) in ('100','110') and to_number(d020_) < 300  THEN
                 IF d020_<>'280' THEN
                    if substr(nls_,1,4)='3800' and d020_ in ('261','262','263','270') then
                       d020_:=to_char(to_number(d020_)+100);
                    end if;
                    if to_number(d020_)<300 then
                       d020_:='300';
                    end if;

                    p_ins(d020_, nls_, nbuck_);
                 END IF;
              END IF ;

           END IF;
        end if;
    END LOOP;
    CLOSE OPL_DOK;
    ---------------------------------------------------
    DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
    ---------------------------------------------------
    INSERT INTO TMP_NBU
        (kodf, datf, kodp, znap, nbuc)
    SELECT kodf_, Dat_, kodp, SUM (znap), nbuc
    FROM RNBU_TRACE
    where kodp not like '_00%'
    GROUP BY kodp, nbuc;

--    INSERT INTO tmp_nbu (nbuc, kodf, datf, kodp, znap)
--    select nbuc1_, kodf_, dat_, ddd || '000', r020
--    from kl_f3_29
--    where kf = kodf_ and
--        to_number(r020)<>0
--    order by ddd;

    -----------------------------------------------------------------------------
    p_ch_file73(kodf_,Dat_,userid_);
    -----------------------------------------------------------------------------
    logger.info ('P_F73_NN: End for '||to_char(dat_,'dd.mm.yyyy'));
END p_f73_NN;
/

