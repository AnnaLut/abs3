

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FD0_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FD0_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_FD0_NN (Dat_ DATE ,
                                      sheme_ varchar2 default 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #D0 для КБ (универсальная)
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 02.12.2011 (25.11.11,04.10.11,29.09.11,27.09.11,26.09.11,
%                           05.09.11,17.11.08,07.10.08,26.08.08,19.08.08)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
!!! для банков имеющих комплекс "Финансовый мониторинг"

02.12.2011 для определения branch_id_ добавил BEGIN .. EXCEPTION .. END
25.11.2011 для кодов 10,12, 32,34, 36, 33,35, 37 используем корректировки 
           выполненные в банке Петрокоммерц (большое спасибо Инге) 
27.10.2011 для кодов 10,12 в курсоре по кодам внутреннего мониторинга 
           добавлено условие "and op.mod_date is null" (модифицированные)
06.10.2011 в показатель 10 будем включать записи со STATUS<>3 было
           STATUS in (2,4) 
04.10.2011 будем включать записи с условием STATUS=0
29.09.2011 для кодов 10,12 изменил условие op.status > 0 на
           op.status in (2,4) согласно постанове 162
27.09.2011 при формировании кода DD='01' добавил условие
           op.mod_date is null (замечание Демарка)
           код DD='02' будет формироваться только при условии
           OPR_VID3='603'
           для формирования кодов 32,34,36 убрал условие
           r.status in (2,4) - файл запит?в
26.09.2011 изменил условие формирования кодов 32,34,36
           (вместо op.KL_DATE  будем использовать r.IN_DATE)
           и кода 78 (это сумма кодов 332...., 334...., 336....)
20.09.2011 изменил условие формирования кода 14 и добавил формирование
           кодов 15, 17, 18
05.09.2011 нов?е код? показателей з 01.09.2001
17.11.2008 добавляем тип клиента "5"-представительство(кроме 1,2,3,4)
           замечание Севастопольского ф-ла банка Петрокоммерц
07.10.2008 в случае отсутсвия кода "tobo" для счета код области
           формировался тот который был определен последним, а не
           код области головного банка (замечание банка Петрокоммерц)
26.08.2008 убрал комментарий для строки 91 (nbuc_ := nbuc1_) т.к.
           в некоторых банках не формируются показатели с данными и
           тогда формируем показатели с нулевыми значениями, и в этом
           случае переменная NBUC не определена
19.08.2008 формируется в разрезе кодов областей (территорий)
14.08.2008 с 01.09.2008 добавляются новые коды "11","91"
07.05.2008 изменено формирование кода "09"
           СЧИТАЕМ ОТВЕТЫ НЕ ЗАВИСИМО ОТ ДАТЫ ПРИХОДА ЗАПРОСА
           (замечание(предложение) ШЕВЧУК ОЛИ)
           (изменения протестированы в банке Петрокоммерц)
09.04.2008 для кода 08 (запросы) в табл. REQUEST поле IN_DATE берем TRUNC
           т.к. данные со временем и исключаем STATUS 2,4
           для кода 09 (ответы) в табл. REQUEST поле IN_DATE берем TRUNC
           т.к. данные со временем включаем STATUS 2,4 и связываем с табл.
           file_out и включаем из этой табл. только даты  отчетного периода
           (изменения протестированы в банке Петрокоммерц)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='D0';
typ_     number;
acc_     Number;
kv_      Number;
nls_     Varchar2(15);
nlsk_    Varchar2(15);
nlsk1_   Varchar2(15);
mfo_     Varchar2(12);
nbuc1_   Varchar2(12);
nbuc_    Varchar2(12);
tk_      Varchar2(1);
kol_     Number;
rnk_     Number;
okpo_    Varchar2(14);
data_    Date;
Dat1_    Date;
kodp_    Varchar2(10);
znap_    Varchar2(70);
userid_  Number;
ref_     number;
rez_     number;
branch_id_ Varchar2(15);
zzzzz_   varchar2(5);
dd_      varchar2(2);

-- процедура определения кода территории
PROCEDURE p_nbuc_ is
BEGIN

    BEGIN
       select acc
          INTO acc_
       from accounts
       where nls=trim(nls_)
         and kv=kv_;
    EXCEPTION WHEN NO_DATA_FOUND THEN
       acc_ := NULL;
    END;

    if acc_ is not null then
       IF typ_>0 THEN
          nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
       ELSE
          nbuc_ := nbuc1_;
       END IF;
    end if;
END;

-----------------------------------------------------------------------------
BEGIN
   execute immediate 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''.,''';
-------------------------------------------------------------------
   --SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
   userid_ := user_id;
   --DELETE FROM RNBU_TRACE WHERE userid = userid_;
   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
   mfo_:=F_OURMFO();
   Dat1_ := TRUNC(Dat_,'MM'); -- початок попереднього мiсяця

-- в январе 2006 года файл #D0 будет формироваться за целый год
-- в феврале только за месяц (нужно изменить переменную Dat1_)
-- откоментарить верхнюю строку и закоментарить нижнюю строку для Dat1_
--   Dat1_ := to_date('01-01-2005','dd-mm-yyyy'); -- початок 2005 року

   if Dat_ = to_date('31082011','ddmmyyyy') then
      Dat1_ := to_date('01012011','ddmmyyyy'); -- формуємо з початку 2011 року
   end if;

   -- параметры формирования файла
   p_proc_set(kodf_,sheme_,nbuc1_,typ_);

   nbuc_ := nbuc1_;

   BEGIN
      select id into branch_id_
      from finmon.bank
      where ust_mfo = (select val from params where par='MFO');
   EXCEPTION WHEN NO_DATA_FOUND THEN
      branch_id_ := null;     
   END;

   kol_:=0;

   -- код 01
   for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                    op.branch_id BRANCH_ID,
                    nvl(op.kl_date,op.kl_date_branch_id) DAT,
                    op.opr_sumg S,
                    p.cl_stp TK, p.doc_nm_r NDR, p.cl_id CL_ID
             from finmon.oper op, finmon.person_oper po, finmon.person p
             where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
           --    and op.mod_date is null
               and op.id=po.oper_id
               and op.status<>3
               and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
               and po.cl_type='1'
               and po.person_id=p.id
               and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
               and p.cl_stp in ('1','2','3','4','5') )
    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv);
          p_nbuc_;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '10100000'||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm)
                    VALUES
                    (k.nls, k.kv, k.dat, '30100000'||tk_, '1', nbuc_, k.cl_id);
          END IF;

          nbuc_ := nbuc1_;
   end loop;

   if dat_ <= to_date('30082011','ddmmyyyy') then
      -- код 02
      for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                       op.branch_id BRANCH_ID,
                       nvl(op.kl_date,op.kl_date_branch_id) DAT,
                       kl.d050 ZZZZZ, op.opr_sumg S,
                       p.cl_stp TK, p.doc_nm_r NDR
                from finmon.oper op, finmon.person_oper po, finmon.person p,
                     kl_d050 kl
                where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                  and op.mod_date is null
                  and op.status IN (2,4)
                  and op.id=po.oper_id
                  and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                  and po.cl_type='1'
                  and po.person_id=p.id
                  and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                  and p.cl_stp in ('1','2','3','4','5')
                  -----------------------------------------
                  and op.file_id is not null
                  and (op.opr_vid2=substr(kl.txt64,1,4) and substr(kl.d050,1,1)='2')
                UNION ALL
                  select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                         op.branch_id BRANCH_ID,
                         nvl(op.kl_date,op.kl_date_branch_id) DAT,
                         kl.d050 ZZZZZ, op.opr_sumg S,
                         p.cl_stp TK, p.doc_nm_r NDR
                  from finmon.oper op, finmon.person_oper po, finmon.person p,
                       kl_d050 kl
                  where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                    and op.mod_date is null
                    and op.file_id is not null
                    and op.id=po.oper_id
                    and op.status IN (2,4)
                    and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                    and po.cl_type='1'
                    and po.person_id=p.id
                    and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                    and p.cl_stp in ('1','2','3','4','5')
                    -----------------------------------------
                    and ((op.opr_vid2 is null or op.opr_vid2 = '0000') and
                          substr(op.opr_vid1,15,1) <> '2' and
                          op.opr_vid3 = substr(kl.txt64,1,3) and
                          substr(kl.d050,1,1) = '3') )

       loop

             tk_:=k.tk;

             if k.tk='2'  then
                tk_:='3';
             elsif k.tk='3'  then
                tk_:='2';
             elsif k.tk in ('4', '5')  then
                tk_:='1';
             end if;

             kol_:=0;

             nls_ := trim(k.nls);
             kv_  := trim(k.kv);
             p_nbuc_;

             IF (mfo_=300120 and k.branch_id=branch_id_) or
                (mfo_ not in (300120)) THEN

                zzzzz_ := k.zzzzz;

                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '102'||zzzzz_||tk_, to_char(k.s), nbuc_);
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '302'||zzzzz_||tk_, '1', nbuc_);
             END IF;

             nbuc_ := nbuc1_;
      end loop;
   end if;

   if dat_ > to_date('30082011','ddmmyyyy') then
      -- код 02
      for k in ( select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                         op.branch_id BRANCH_ID,
                         nvl(op.kl_date,op.kl_date_branch_id) DAT,
                         kl.d050 ZZZZZ, op.opr_sumg S,
                         p.cl_stp TK, p.doc_nm_r NDR
                  from finmon.oper op, finmon.person_oper po, finmon.person p,
                       kl_d050 kl
                  where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                    and op.mod_date is null
                    and op.file_id is not null
                    and op.id=po.oper_id
                    and op.status IN (2,4)
                    and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                    and po.cl_type='1'
                    and po.person_id=p.id
                    and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                    and p.cl_stp in ('1','2','3','4','5')
                    -----------------------------------------
                    and ((op.opr_vid2 is null or op.opr_vid2 = '0000') and
                          substr(op.opr_vid1,15,1) <> '2' and
                          op.opr_vid3 = substr(kl.txt64,1,3) and
                          substr(kl.d050,1,1) = '3' and
                          op.opr_vid3 = '603')
               )

       loop

             tk_:=k.tk;

             if k.tk='2'  then
                tk_:='3';
             elsif k.tk='3'  then
                tk_:='2';
             elsif k.tk in ('4', '5')  then
                tk_:='1';
             end if;

             kol_:=0;

             nls_ := trim(k.nls);
             kv_  := trim(k.kv);
             p_nbuc_;

             IF (mfo_=300120 and k.branch_id=branch_id_) or
                (mfo_ not in (300120)) THEN

                zzzzz_ := '00000';

                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '102'||zzzzz_||tk_, to_char(k.s), nbuc_);
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '302'||zzzzz_||tk_, '1', nbuc_);
             END IF;

             nbuc_ := nbuc1_;
      end loop;
   end if;

   if dat_ <= to_date('30082011','ddmmyyyy') then
      -- код 03
      for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                       op.branch_id BRANCH_ID,
                       nvl(op.kl_date,op.kl_date_branch_id) DAT,
                       op.opr_sumg S,
                       p.cl_stp TK, p.doc_nm_r NDR
                from finmon.oper op, finmon.person_oper po, finmon.person p  --,
                where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                  and op.file_id is not null
                  and op.status IN (2,4)
                  and op.terrorism is not null
                  and op.terrorism<>0
                  and op.id=po.oper_id
                  and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                  and po.cl_type='1'
                  and po.person_id=p.id
                  and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                  and p.cl_stp in ('1','2','3','4','5') )

          loop

                tk_:=k.tk;

                if k.tk='2'  then
                   tk_:='3';
                elsif k.tk='3'  then
                   tk_:='2';
                elsif k.tk in ('4', '5')  then
                   tk_:='1';
                end if;

                kol_:=0;

                nls_ := trim(k.nls);
                kv_  := trim(k.kv);
                p_nbuc_;

                IF (mfo_=300120 and k.branch_id=branch_id_) or
                   (mfo_ not in (300120)) THEN

                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '10300000'||tk_, to_char(k.s), nbuc_);
                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '30300000'||tk_, '1', nbuc_);
                END IF;

                nbuc_ := nbuc1_;
      end loop;

      -- код 04
      for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                       op.branch_id BRANCH_ID,
                       nvl(op.kl_date,op.kl_date_branch_id) DAT,
                       op.opr_sumg S,
                       p.cl_stp TK, p.doc_nm_r NDR
                from finmon.oper op, finmon.person_oper po, finmon.person p  --,
                where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                  and op.file_id is not null
                  and op.status IN (2,4)
                  and op.opr_vid2=''  -- ?????
                  and op.id=po.oper_id
                  and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                  and po.cl_type='1'
                  and po.person_id=p.id
                  and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                  and p.cl_stp in ('1','2','3','4','5') )

          loop

                tk_:=k.tk;

                if k.tk='2'  then
                   tk_:='3';
                elsif k.tk='3'  then
                   tk_:='2';
                elsif k.tk in ('4', '5')  then
                   tk_:='1';
                end if;

                kol_:=0;

                nls_ := trim(k.nls);
                kv_  := trim(k.kv);
                p_nbuc_;

                IF (mfo_=300120 and k.branch_id=branch_id_) or
                   (mfo_ not in (300120)) THEN

                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '10400000'||tk_, to_char(k.s), nbuc_);
                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '30400000'||tk_, '1', nbuc_);
                END IF;

                nbuc_ := nbuc1_;
      end loop;

      -- код 05
      for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                       op.branch_id BRANCH_ID,
                       nvl(op.kl_date,op.kl_date_branch_id) DAT,
                       op.opr_sumg S,
                       p.cl_stp TK, p.doc_nm_r NDR
                from finmon.oper op, finmon.person_oper po, finmon.person p  --,
                where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                  and op.file_id is not null
                  and op.status IN (2,4)
                  and (substr(op.opr_vid1,15,1)='2' and op.opr_vid3='900')
                  and op.id=po.oper_id
                  and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                  and po.cl_type='1'
                  and po.person_id=p.id
                  and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                  and p.cl_stp in ('1','2','3','4','5') )

          loop

                tk_:=k.tk;

                if k.tk='2'  then
                   tk_:='3';
                elsif k.tk='3'  then
                   tk_:='2';
                elsif k.tk in ('4', '5')  then
                   tk_:='1';
                end if;

                kol_:=0;

                nls_ := trim(k.nls);
                kv_  := trim(k.kv);
                p_nbuc_;

                IF (mfo_=300120 and k.branch_id=branch_id_) or
                   (mfo_ not in (300120)) THEN


                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '30500000'||tk_, '1', nbuc_);
                END IF;

                nbuc_ := nbuc1_;
      end loop;

      -- код 06
      for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                       op.branch_id BRANCH_ID,
                       nvl(op.kl_date,op.kl_date_branch_id) DAT,
                       op.opr_sumg S,
                       p.cl_stp TK, p.doc_nm_r NDR
                from finmon.oper op, finmon.person_oper po, finmon.person p  --,
                where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                  and op.status=-1
                  and op.id=po.oper_id
                  and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                  and po.cl_type='1'
                  and po.person_id=p.id
                  and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                  and p.cl_stp in ('1','2','3','4','5') )

          loop

                tk_:=k.tk;

                if k.tk='2'  then
                   tk_:='3';
                elsif k.tk='3'  then
                   tk_:='2';
                elsif k.tk in ('4', '5')  then
                   tk_:='1';
                end if;

                kol_:=0;

                nls_ := trim(k.nls);
                kv_  := trim(k.kv);
                p_nbuc_;

                IF (mfo_=300120 and k.branch_id=branch_id_) or
                   (mfo_ not in (300120)) THEN

                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '10600000'||tk_, to_char(k.s), nbuc_);
                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '30600000'||tk_, '1', nbuc_);
                END IF;

                nbuc_ := nbuc1_;
      end loop;
   else
      -- код 06 в разрезе D050 (ZZZZZ)
      for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                       op.branch_id BRANCH_ID,
                       nvl(op.kl_date,op.kl_date_branch_id) DAT,
                       kl.d050 ZZZZZ, op.opr_sumg S,
                       p.cl_stp TK, p.doc_nm_r NDR
                from finmon.oper op, finmon.person_oper po, finmon.person p,
                     kl_d050 kl
                where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                  and op.mod_date is null
                  and op.status=-1
                  and ((op.opr_vid2=substr(kl.txt64,1,4) and substr(kl.d050,1,1)='2') OR
                       ((op.opr_vid2 is null or op.opr_vid2='0000') and
                        substr(op.opr_vid1,15,1)<>'2' and
                        op.opr_vid3=substr(kl.txt64,1,3) and
                        substr(kl.d050,1,1)='3'))
                  and op.id=po.oper_id
                  and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                  and po.cl_type='1'
                  and po.person_id=p.id
                  and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                  and p.cl_stp in ('1','2','3','4','5') )

          loop

                tk_:=k.tk;

                if k.tk='2'  then
                   tk_:='3';
                elsif k.tk='3'  then
                   tk_:='2';
                elsif k.tk in ('4', '5')  then
                   tk_:='1';
                end if;

                kol_:=0;

                nls_ := trim(k.nls);
                kv_  := trim(k.kv);
                p_nbuc_;

                IF (mfo_=300120 and k.branch_id=branch_id_) or
                   (mfo_ not in (300120)) THEN

                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '106'||k.zzzzz||tk_, to_char(k.s), nbuc_);
                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '306'||k.zzzzz||tk_, '1', nbuc_);
             END IF;

             nbuc_ := nbuc1_;
      end loop;
   end if;

   -- код 07
   for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                    op.branch_id BRANCH_ID,
                    nvl(op.kl_date,op.kl_date_branch_id) DAT,
                    op.opr_sumg S,
                    p.cl_stp TK, p.doc_nm_r NDR
             from finmon.oper op, finmon.person_oper po, finmon.person p
             where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
               and op.mod_date is not null  --ing                                                    
               and op.id=po.oper_id
               and op.file_id is not null
               and op.opr_act =3 --ing
               and op.mod_id is not null --ing
               and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
               and po.cl_type='1'
               and po.person_id=p.id
               and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
               and p.cl_stp in ('1','2','3','4','5')  )

       loop

             tk_:=k.tk;

             if k.tk='2'  then
                tk_:='3';
             elsif k.tk='3'  then
                tk_:='2';
             elsif k.tk in ('4', '5')  then
                tk_:='1';
             end if;

             kol_:=0;

             nls_ := trim(k.nls);
             kv_  := trim(k.kv);
             p_nbuc_;

             IF (mfo_=300120 and k.branch_id=branch_id_) or
                (mfo_ not in (300120)) THEN

                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '10700000'||tk_, to_char(k.s), nbuc_);
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '30700000'||tk_, '1', nbuc_);
             END IF;

             nbuc_ := nbuc1_;
   end loop;

   if dat_ <= to_date('30082011','ddmmyyyy') then

      -- код 08
      for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                    op.branch_id BRANCH_ID,
                    nvl(op.kl_date,op.kl_date_branch_id) DAT,
                    op.opr_sumg S,
                    p.cl_stp TK, p.doc_nm_r NDR
             from finmon.oper op, finmon.person_oper po, finmon.person p,
                  finmon.request r
             where trunc(r.in_date)  between Dat1_ and Dat_
               and op.kl_id=r.kl_id
               and op.kl_date=r.kl_date
               and r.file_i_id is not null
               and op.status IN (2,4)
               and op.id=po.oper_id
               and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
               and po.cl_type='1'
               and po.person_id=p.id
               and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
               and p.cl_stp in ('1','2','3','4','5') )

       loop

             tk_:=k.tk;

             if k.tk='2'  then
                tk_:='3';
             elsif k.tk='3'  then
                tk_:='2';
             elsif k.tk in ('4', '5')  then
                tk_:='1';
             end if;

             kol_:=0;

             nls_ := trim(k.nls);
             kv_  := trim(k.kv);
             p_nbuc_;

             IF (mfo_=300120 and k.branch_id=branch_id_) or
                (mfo_ not in (300120)) THEN

                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '10800000'||tk_, to_char(k.s), nbuc_);
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '30800000'||tk_, '1', nbuc_);
             END IF;

             nbuc_ := nbuc1_;
      end loop;

      -- код 09
      for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                    op.branch_id BRANCH_ID,
                    nvl(op.kl_date,op.kl_date_branch_id) DAT,
                    op.opr_sumg S,
                    p.cl_stp TK, p.doc_nm_r NDR
             from finmon.oper op, finmon.person_oper po, finmon.person p,
                  finmon.request r, finmon.file_out f
             where op.kl_id=r.kl_id  -- СЧИТАЕМ ОТВЕТЫ НЕ ЗАВИСИМО ОТ ДАТЫ ПРИХОДА ЗАПРОСА - ШЕВЧУК ОЛЯ
               and f.id=r.dfile_id and trunc(f.out_date) between Dat1_ and Dat_
               and op.kl_date=r.kl_date
               and r.file_o_id is not null
               and r.status in (2,4)
               and op.status IN (2,4)
               and op.id=po.oper_id
               and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
               and po.cl_type='1'
               and po.person_id=p.id
               and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
               and p.cl_stp in ('1','2','3','4','5') )

       loop

             tk_:=k.tk;

             if k.tk='2'  then
                tk_:='3';
             elsif k.tk='3'  then
                tk_:='2';
             elsif k.tk in ('4', '5')  then
                tk_:='1';
             end if;

             kol_:=0;

             nls_ := trim(k.nls);
             kv_  := trim(k.kv);
             p_nbuc_;

             IF (mfo_=300120 and k.branch_id=branch_id_) or
                (mfo_ not in (300120)) THEN

                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '10900000'||tk_, to_char(k.s), nbuc_);
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '30900000'||tk_, '1', nbuc_);
             END IF;

             nbuc_ := nbuc1_;
      end loop;

      -- новые коды "11","91" действующие из 01.09.2008
      if dat_ >= to_date('01092008','ddmmyyyy') then

         -- код 11
         for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                       op.branch_id BRANCH_ID,
                       nvl(op.kl_date,op.kl_date_branch_id) DAT,
                       op.opr_sumg S,
                       p.cl_stp TK, p.doc_nm_r NDR
                from finmon.oper op, finmon.person_oper po, finmon.person p
                where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                  and op.id=po.oper_id
                  and op.status<>3
                  and op.dropped=1  -- операцiї анульованi з реєстру
                  and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                  and po.cl_type='1'
                  and po.person_id=p.id
                  and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                  and p.cl_stp in ('1','2','3','4','5') )
          loop

             tk_:=k.tk;

             if k.tk='2'  then
                tk_:='3';
             elsif k.tk='3'  then
                tk_:='2';
             elsif k.tk in ('4', '5')  then
                tk_:='1';
             end if;

             kol_:=0;

             nls_ := trim(k.nls);
             kv_  := trim(k.kv);
             p_nbuc_;

             IF (mfo_=300120 and k.branch_id=branch_id_) or
                (mfo_ not in (300120)) THEN

                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '11100000'||tk_, to_char(k.s), nbuc_);
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '31100000'||tk_, '1', nbuc_);
             END IF;

             nbuc_ := nbuc1_;
         end loop;

         -- код 91
         for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                       op.branch_id BRANCH_ID,
                       nvl(op.kl_date,op.kl_date_branch_id) DAT,
                       op.opr_sumg S,
                       p.cl_stp TK, p.doc_nm_r NDR
                from finmon.oper op, finmon.person_oper po, finmon.person p
                where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                  and op.id=po.oper_id
                  and op.status=4
                  and op.dropped=1  -- операцiї анульованi з реєстру
                  and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                  and po.cl_type='1'
                  and po.person_id=p.id
                  and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                  and p.cl_stp in ('1','2','3','4','5') )
          loop

             tk_:=k.tk;

             if k.tk='2'  then
                tk_:='3';
             elsif k.tk='3'  then
                tk_:='2';
             elsif k.tk in ('4', '5')  then
                tk_:='1';
             end if;

             kol_:=0;

             nls_ := trim(k.nls);
             kv_  := trim(k.kv);
             p_nbuc_;

             IF (mfo_=300120 and k.branch_id=branch_id_) or
                (mfo_ not in (300120)) THEN

                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '19100000'||tk_, to_char(k.s), nbuc_);
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '39100000'||tk_, '1', nbuc_);
             END IF;

             nbuc_ := nbuc1_;
         end loop;
      end if;
   end if;

if dat_ > to_date('30082011','ddmmyyyy') then
   -- код 10, 12
   for k in /*(select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID, DECODE(op.opr_nbu,0,'10','12') DD,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 kl.d050 ZZZZZ, op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR
          from finmon.oper op, finmon.person_oper po, finmon.person p,
               kl_d050 kl
          where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
            and op.mod_date is null
            --and op.file_id is not null
            and op.status in (2,4)  --> 0
            and (op.opr_vid2=substr(kl.txt64,1,4) and substr(kl.d050,1,1)='2')
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5')
          UNION ALL
          select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID, DECODE(op.opr_nbu,0,'10','12') DD,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 kl.d050 ZZZZZ, op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR
          from finmon.oper op, finmon.person_oper po, finmon.person p,
               kl_d050 kl
          where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
            and op.status in (2,4)  --> 0
            and ((op.opr_vid2 is null or op.opr_vid2='0000') and
                  substr(op.opr_vid1,15,1)<>'2' and
                  op.opr_vid3=substr(kl.txt64,1,3) and
                  substr(kl.d050,1,1)='3' --and
                  --op.opr_vid3 not in ('603','604','605','606')
                )
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )*/
-------------------------------------------------------------------------------------------
            (select     substr(trim(po.account),1,15)      NLS, 
                       op.opr_val                          KV,
                       op.branch_id                        BRANCH_ID, 
                       DECODE(op.opr_nbu,0,'10','12')      DD,
                       nvl(op.kl_date,op.kl_date_branch_id)DAT,
                       kl.d050                             ZZZZZ, 
                       op.opr_sumg                         S,
                       p.cl_stp                            TK, 
                       p.doc_nm_r                          NDR
            from       finmon.file_out                     fo,
                       finmon.oper                         op, 
                       finmon.person_oper                  po, 
                       finmon.person                       p,
                       kl_d050                             kl
            where      fo.id = op.file_id
            and        fo.in_date between Dat1_ and Dat_ -- ing 04/11/2011 Должны отображатся операции, по которым в отчётном месяце направлены ХА и по которым пришли ХВ с нулевыми кодами ошибок. (расхождение связано с тем, что в отчётном периоде операции могут быть внесены в реестр, а файлы по ним отправлены в следующем месяце или же файлы отправлены в последний день поздно вечером а ХВ пришли на следующий день (первый день следующего месяца). Такие операции должны отображатся в следующем месяце
            and        op.kl_date between Dat1_-30 and Dat_--ing -30 для того, чтобы учитывать запросы прошлого месяца, на которые возможно ответ пришел только в отчетном
            and        op.id=po.oper_id
            and        po.person_id=p.id
            and        op.file_id is not null
            and        fo.out_name like 'XA%'
            and        nvl(fo.err_code,'0') = '0000'
            and        op.mod_date is null
            and        op.status in (2,4)  --> 0
            and        (op.opr_vid2=substr(kl.txt64,1,4) 
            and        substr(kl.d050,1,1)='2')
            and        NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and        po.cl_type='1'
            and        NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and        p.cl_stp in ('1','2','3','4','5'))
            
    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv);
          p_nbuc_;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '1'||k.dd||k.zzzzz||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '3'||k.dd||k.zzzzz||tk_, '1', nbuc_);
          END IF;

          nbuc_ := nbuc1_;
   end loop;

end if;

-- код 13
if dat_ > to_date('30082011','ddmmyyyy') then

   for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR
          from finmon.oper op, finmon.person_oper po, finmon.person p
          where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
            and op.mod_date is null
            and op.status >= 0
            and ((op.terrorism is not null and op.terrorism <> 0) OR (op.opr_terror in (2,3)))
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv);
          p_nbuc_;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN


             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '11300000'||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '31300000'||tk_, '1', nbuc_);
          END IF;

          nbuc_ := nbuc1_;
   end loop;

end if;

if dat_ > to_date('30082011','ddmmyyyy') then

   -- код 14   (таблиця K_DFM10 - коди оперцацiй)
   for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 kl.d050 ZZZZZ, op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR
          from finmon.oper op, finmon.person_oper po, finmon.person p,
               kl_d050 kl
          where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
            and op.mod_date is null
            and op.status <> 3
            and op.opr_ozn in (4,5,6,7)  -- операцiї зипиненi
            and ((op.opr_vid2=substr(kl.txt64,1,4) and substr(kl.d050,1,1)='2') OR
                 ((op.opr_vid2 is null or op.opr_vid2='0000') and
                  substr(op.opr_vid1,15,1)<>'2' and
                  op.opr_vid3=substr(kl.txt64,1,3) and
                  substr(kl.d050,1,1)='3'))
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv);
          p_nbuc_;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '114'||k.zzzzz||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '314'||k.zzzzz||tk_, '1', nbuc_);
          END IF;

          nbuc_ := nbuc1_;
   end loop;
end if;

if dat_ > to_date('30082011','ddmmyyyy') then

   -- код 15   (таблиця K_DFM10 - коди оперцацiй)
   for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 kl.d050 ZZZZZ, op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR
          from finmon.oper op, finmon.person_oper po, finmon.person p,
               kl_d050 kl
          where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
            and op.mod_date is null
            and op.status <> 3
            and op.opr_ozn=2  -- операцiї не сдiйснена у звязку з неможливыстю проведення iдентифiкацiї
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv);
          p_nbuc_;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '115'||'00000'||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '315'||'00000'||tk_, '1', nbuc_);
          END IF;

          nbuc_ := nbuc1_;
   end loop;
end if;

if dat_ > to_date('30082011','ddmmyyyy') then

   -- код 17   (таблиця K_DFM10 - коди оперцацiй)
   for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 kl.d050 ZZZZZ, op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR
          from finmon.oper op, finmon.person_oper po, finmon.person p,
               kl_d050 kl
          where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
            and op.mod_date is null
            and op.status <> 3
            and ((op.opr_vid2=substr(kl.txt64,1,4) and substr(kl.d050,1,1)='2') OR
                 ((op.opr_vid2 is null or op.opr_vid2='0000') and
                   substr(op.opr_vid1,15,1)<>'2' and
                   op.opr_vid3=substr(kl.txt64,1,3) and
                   substr(kl.d050,1,1)='3'))
            and op.opr_ozn=5  -- операцiї зупинена у звязку з тим що м?стить ознаки передбачен? статтями 15,16
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv);
          p_nbuc_;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '117'||k.zzzzz||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '317'||k.zzzzz||tk_, '1', nbuc_);
          END IF;

          nbuc_ := nbuc1_;
   end loop;
end if;

if dat_ > to_date('30082011','ddmmyyyy') then

   -- код 18   (таблиця K_DFM10 - коди оперцацiй)
   for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR
          from finmon.oper op, finmon.person_oper po, finmon.person p
          where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
            and op.mod_date is null
            and op.status <> 3
            and op.opr_ozn=4  -- операцiї зупинена у звязку з тим що її учасниками або вигодоодержувачами є особи
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv);
          p_nbuc_;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '118'||'00000'||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '318'||'00000'||tk_, '1', nbuc_);
          END IF;

          nbuc_ := nbuc1_;
   end loop;
end if;

if dat_ > to_date('30082011','ddmmyyyy') then

   -- коди 20,21,23,24,25,26
   for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 r.ri_vid RI_VID, op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR, p.cl_id CL_ID
          from finmon.oper op, finmon.person_oper po, finmon.person p,
               finmon.decision r
          where trunc(r.in_date)  between Dat1_ and Dat_
            and op.mod_date is null
            and op.ri_numb=r.ri_numb
            and op.kl_date=r.kl_date
            and r.file_i_id is not null
            and op.status IN (2,4)
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv);
          p_nbuc_;

          if k.ri_vid=11 then
             dd_ := '20';
          elsif k.ri_vid='31' then
             dd_ := '21';
          elsif k.ri_vid='21' then
             dd_ := '23';
          elsif k.ri_vid='33' then
             dd_ := '24';
          elsif k.ri_vid='32' then
             dd_ := '25';
          else
             null;
          end if;


          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm)
                 VALUES
                 (k.nls, k.kv, k.dat, '1'||dd_||'00000'||tk_, to_char(k.s), nbuc_, k.cl_id);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm)
                 VALUES
                 (k.nls, k.kv, k.dat, '3'||dd_||'00000'||tk_, '1', nbuc_, k.cl_id);
          END IF;

          nbuc_ := nbuc1_;
   end loop;

end if;

if dat_ > to_date('30082011','ddmmyyyy') then
   -- код 32 34 
   for k in ( select          
              substr(trim(po.account),1,15)        NLS, 
              op.opr_val                           KV,
              /*op.branch_id*/ 1                   BRANCH_ID,
              nvl(op.kl_date,op.kl_date_branch_id) DAT,
              r.zap_type                           ZAP_TYPE, 
              op.opr_sumg                          S,
              p.cl_stp                             TK, 
              p.doc_nm_r                           NDR, 
              p.cl_id                              CL_ID 
            from  finmon.oper         op, 
                  finmon.person_oper  po, 
                  finmon.person       p,
                  finmon.request      r 
            where trunc(r.in_date) between Dat1_ and Dat_ -- запити 
              and r.kl_id=op.kl_id_branch_id -- op.kl_id=r.kl_id ing 04/11/2011 была связка по op.kl_id - не учитывается филиал
              and r.kl_date=op.kl_date_branch_id -- op.kl_date=r.kl_date ing 04/11/2011 была связка по op.kl_date - не учитывается филиал
              and op.id=po.oper_id
              and po.person_id=p.id
              and op.mod_date is null
              and r.file_o_id is not null
              and op.status IN (2,4)
              and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
              and po.cl_type='1'
              and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
              and p.cl_stp in ('1','2','3','4','5') 
           )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv); 
          p_nbuc_;

          if k.zap_type in (0,2) then
             dd_ := '32';
          elsif k.zap_type=1 then
             dd_ := '34';
          --elsif k.zap_type=2 then
          --   dd_ := '36';
          else
             null;
          end if;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm)
                 VALUES
                 (k.nls, k.kv, k.dat, '1'||dd_||'00000'||tk_, to_char(k.s), nbuc_, k.cl_id);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm)
                 VALUES
                 (k.nls, k.kv, k.dat, '3'||dd_||'00000'||tk_, '1', nbuc_, k.cl_id);
          END IF;

          nbuc_ := nbuc1_;
   end loop;

end if;

if dat_ > to_date('30082011','ddmmyyyy') then
   -- код 36 
   for k in /*(select substr(trim(r.id),1,15) NLS, 0 KV,
                 nvl(r.zap_date,r.in_date) DAT,
                 r.zap_type ZAP_TYPE, 0 S,
                 '2' TK, '0' NDR, '0' CL_ID 
          from  finmon.request r 
          where trunc(r.in_date)  between Dat1_ and Dat_ -- запити 
          and r.kl_id is null 
          and r.kl_date is null  )      */       --ing 04/11/2011 не считает количество файлов ХС, а какуют ФИГНЮ\
          (select distinct
                 fi.in_name NLS, 0 KV,
                 nvl(r.zap_date,r.in_date) DAT,
                 r.zap_type ZAP_TYPE, 0 S,
                 '2' TK, '0' NDR, '0' CL_ID 
          from  finmon.request r , 
                finmon.file_in fi
          where trunc(r.in_date)  between Dat1_ and Dat_ -- запити 
          and   r.file_i_id = fi.id         
          )     

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv); 
          p_nbuc_;

          dd_ := '36';

          --insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm)
          --    VALUES
          --    (k.nls, k.kv, k.dat, '1'||dd_||'00000'||tk_, to_char(k.s), nbuc1_, k.nls);   --ing 04/11/2011 код 136 не подается
          insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm)
              VALUES
              (k.nls, k.kv, k.dat, '3'||dd_||'00000'||tk_, '1', nbuc1_, k.nls);

          nbuc_ := nbuc1_;
   end loop;

end if;

if dat_ > to_date('30082011','ddmmyyyy') then

   -- код 29
   for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 r.zap_type ZAP_TYPE, op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR
          from finmon.oper op, finmon.person_oper po, finmon.person p,
               finmon.request r   --,
          where trunc(r.in_date)  between Dat1_ and Dat_
            and op.mod_date is null
            and op.dfile_id is not null
            and op.kl_id=r.kl_id
            and op.kl_date=r.kl_date
            and r.file_i_id is not null
            and r.zap_type  = 1
            and op.status IN (2,4)
            and op.opr_vid2=''  -- ?????
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv); 
          p_nbuc_;

          dd_ := '29';

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '1'||dd_||'00000'||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '3'||dd_||'00000'||tk_, '1', nbuc_);
          END IF;

          nbuc_ := nbuc1_;
  end loop;

  -- код 30
  for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 r.zap_type ZAP_TYPE, op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR
          from finmon.oper op, finmon.person_oper po, finmon.person p,
               finmon.request r   
          where trunc(r.in_date)  between Dat1_ and Dat_
            and op.mod_date is null
            and op.dfile_id is not null
            and op.kl_id=r.kl_id
            and op.kl_date=r.kl_date
            and r.file_i_id is not null
            and r.zap_type  = 1
            and op.status IN (2,4)
            and op.opr_vid2 <> ''  -- ?????
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv); 
          p_nbuc_;

          dd_ := '30';

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '1'||dd_||'00000'||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '3'||dd_||'00000'||tk_, '1', nbuc_);
          END IF;

          nbuc_ := nbuc1_;
   end loop;

end if;

/* невыдомо який признак "Выдстеження (моныторинг)"
if dat_ > to_date('30082011','ddmmyyyy') then

-- код 31
for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR, p.cl_id CL_ID
          from finmon.oper op, finmon.person_oper po, finmon.person p,
               finmon.request r   
          where trunc(r.in_date)  between Dat1_ and Dat_
            and op.kl_id=r.kl_id
            and op.kl_date=r.kl_date
            and r.file_i_id is not null
            and op.status IN (2,4)
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv); 
          p_nbuc_;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm)
                 VALUES
                 (k.nls, k.kv, k.dat, '33100000'||tk_, '1', nbuc_, k.cl_id);
          END IF;

          nbuc_ := nbuc1_;
   end loop;

end if;
*/

if dat_ > to_date('30082011','ddmmyyyy') then
   -- код 33, 35
   for k in ( select substr(trim(po.account),1,15)           NLS, 
                     op.opr_val                              KV,
                     /*op.branch_id*/ 1                      BRANCH_ID,
                     nvl(op.kl_date,op.kl_date_branch_id)    DAT,
                     r.zap_type                              ZAP_TYPE, 
                     op.opr_sumg                             S,
                     p.cl_stp                                TK, 
                     p.doc_nm_r                              NDR
              from   finmon.oper           op, 
                     finmon.person_oper    po, 
                     finmon.person         p,
                     finmon.request        r, 
                     finmon.file_out       f   
              where  op.kl_id_branch_id=r.kl_id -- СЧИТАЕМ ОТВЕТЫ НЕ ЗАВИСИМО ОТ ДАТЫ ПРИХОДА ЗАПРОСА - ШЕВЧУК ОЛЯ 
              --ing 04/11/2011 op.kl_id=r.kl_id не учитывает операций отделений
              and    op.mod_date is null
              and    f.id=r.dfile_id and trunc(f.out_date) between Dat1_ and Dat_
              and    op.kl_date_branch_id=r.kl_date 
              --ing 04/11/2011 op.kl_date=r.kl_date не учитывает операций отделений
              and    r.file_o_id is not null
              and    r.status in (2,4)
              and    op.status IN (2,4)
              and    op.id=po.oper_id
              and    NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
              and    po.cl_type='1'
              and    po.person_id=p.id
              and    NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
              and    p. cl_stp in ('1','2','3','4','5') 
            )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv); 
          p_nbuc_;

          if k.zap_type in (0,2) then
             dd_ := '33';
          elsif k.zap_type=1 then
             dd_ := '35';
          --elsif k.zap_type=2 then
          --   dd_ := '37';
          else
             null;
          end if;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '1'||dd_||'00000'||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '3'||dd_||'00000'||tk_, '1', nbuc_);
          END IF;

          nbuc_ := nbuc1_;
   end loop;

end if;

if dat_ > to_date('30082011','ddmmyyyy') then
   -- код 37
   for k in
        --(select substr(trim(r.id),1,15) NLS, 0 KV,
        --         nvl(r.zap_date,r.in_date) DAT,
        --         r.zap_type ZAP_TYPE, 0 S,
        --         '2' TK, '0' NDR, '0' CL_ID
        --  from  finmon.request r, finmon.file_out f   
        --  where trunc(f.out_date) between Dat1_ and Dat_
        --    and f.id=r.dfile_id
        --    and r.file_o_id is not null
        --    and r.status >= 0 )      --Инга -- не работает, отбирает ХЕ

          (select distinct f.out_name Nls, 0 kv, 
                 nvl(r.zap_date,r.in_date) DAT,
                 r.zap_type ZAP_TYPE, 0 S,
                 '2' TK, '0' NDR, '0' CL_ID
          from  finmon.request r, 
                finmon.file_out f   
          where trunc(f.out_date) between Dat1_ and Dat_
            and f.id=r.file_o_id
            and r.status >= 0
            and r.zap_type = 0 -- ing операции только по нашим клиентам
          )  
            

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv); 
          --p_nbuc_;

          dd_ := '37';

          --insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
          --    VALUES
          --    (k.nls, k.kv, k.dat, '1'||dd_||'00000'||tk_, to_char(k.s), nbuc1_);  --ing код 137 не подается, только 337 04/11/2011
          insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
              VALUES
              (k.nls, k.kv, k.dat, '3'||dd_||'00000'||tk_, '1', nbuc1_);

   end loop;

end if;

-- нов? коди 71-78
if dat_ > to_date('30082011','ddmmyyyy') then
   for k in (select distinct substr(kodp,2,2) DD, substr(kodp,9,1) TK, comm, nbuc
             from rnbu_trace 
             where kodp like '3%' 
               and substr(kodp,2,2) in ('20','21','23','24','27','31','32','34','36') )
      loop
         if k.dd = '20' then
            dd_ := '72';
         elsif k.dd='21' then
            dd_ := '73';
         elsif k.dd='23' then
            dd_ := '74';
         elsif k.dd='24' then
            dd_ := '75';
         elsif k.dd='31' then
            dd_ := '76';
         elsif k.dd='27' then
            dd_ := '77';
         elsif k.dd in ('32','34','36') then
            dd_ := '78';
         else
            null;
         end if;
   
         insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
             VALUES
             (k.comm, 0, dat_, '3'||dd_||'00000'||k.tk, '1', k.nbuc);
   
      end loop;
end if;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
INSERT INTO tmp_nbu (kodp, datf, kodf, nbuc, znap)
   SELECT kodp, Dat_, kodf_, nbuc, SUM(to_number(znap))
   FROM rnbu_trace
   WHERE userid=userid_
   GROUP BY kodp, Dat_, kodf_, nbuc;

--- временно наполняем нулевыми значениями все показатели
--- код DD='01'

select count(*) INTO kol_
from tmp_nbu
where kodf=kodf_ and datf=Dat_ and substr(kodp,2,7)='0100000';

if kol_=0 then
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('101000001',Dat_, kodf_, '0', nbuc_);
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('301000001',Dat_, kodf_, '0', nbuc_);
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('101000002',Dat_, kodf_, '0', nbuc_);
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('301000002',Dat_, kodf_, '0', nbuc_);
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('101000003',Dat_, kodf_, '0', nbuc_);
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('301000003',Dat_, kodf_, '0', nbuc_);
end if;

if dat_ <= to_date('30082011','ddmmyyyy') then 
   --- код DD='02'
   select count(*) INTO kol_   
   from tmp_nbu
   where kodf=kodf_ and datf=Dat_ and substr(kodp,2,2)='02';

   if kol_=0 then
   
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('102ZZZZZ1',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('302ZZZZZ1',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('102ZZZZZ2',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('302ZZZZZ2',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('102ZZZZZ3',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('302ZZZZZ3',Dat_, kodf_, '0', nbuc_);
   end if;
end if;

if dat_ > to_date('30082011','ddmmyyyy') then 
   --- код DD='02'
   select count(*) INTO kol_
   from tmp_nbu
   where kodf=kodf_ and datf=Dat_ and substr(kodp,2,2)='02';
   
   if kol_=0 then
   
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('102000001',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('302000001',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('102000002',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('302000002',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('102000003',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('302000003',Dat_, kodf_, '0', nbuc_);
   end if;
end if;


if dat_ <= to_date('30082011','ddmmyyyy') then
   --- код DD='03'

   select count(*) INTO kol_
   from tmp_nbu
   where kodf=kodf_ and datf=Dat_ and substr(kodp,2,7)='0300000';

   if kol_=0 then

      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('103000001',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('303000001',Dat_, kodf_, '0', nbuc_);
   
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('103000002',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('303000002',Dat_, kodf_, '0', nbuc_);
   
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('103000003',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('303000003',Dat_, kodf_, '0', nbuc_);
   end if;

   --- код DD='04'
   select count(*) INTO kol_
   from tmp_nbu
   where kodf=kodf_ and datf=Dat_ and substr(kodp,2,7)='0400000';

   if kol_=0 then

      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('104000001',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('304000001',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('104000002',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('304000002',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('104000003',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('304000003',Dat_, kodf_, '0', nbuc_);
   end if;

   --- код DD='05'
   select count(*) INTO kol_
   from tmp_nbu
   where kodf=kodf_ and datf=Dat_ and substr(kodp,2,7)='0500000';

   if kol_=0 then

      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('305000001',Dat_, kodf_, '0', nbuc_);
   
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('305000002',Dat_, kodf_, '0', nbuc_);
   
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('305000003',Dat_, kodf_, '0', nbuc_);
   end if;   -- б?ли до 31.08.2011
end if;
   
if dat_ <= to_date('30082011','ddmmyyyy') then
   --- код DD='06'
   select count(*) INTO kol_
   from tmp_nbu
   where kodf=kodf_ and datf=Dat_ and substr(kodp,2,7)='0600000';
   
   if kol_=0 then

      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('106000001',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('306000001',Dat_, kodf_, '0', nbuc_);
    
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('106000002',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('306000002',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('106000003',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('306000003',Dat_, kodf_, '0', nbuc_);
   end if;
end if;

--- код DD='07'
select count(*) INTO kol_
from tmp_nbu
where kodf=kodf_ and datf=Dat_ and substr(kodp,2,7)='0700000';

if kol_=0 then

   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('107000001',Dat_, kodf_, '0', nbuc_);
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('307000001',Dat_, kodf_, '0', nbuc_);
   
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('107000002',Dat_, kodf_, '0', nbuc_);
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('307000002',Dat_, kodf_, '0', nbuc_);
   
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('107000003',Dat_, kodf_, '0', nbuc_);
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('307000003',Dat_, kodf_, '0', nbuc_);
end if;

if dat_ <= to_date('30082011','ddmmyyyy') then
   --- код DD='08'
   select count(*) INTO kol_
   from tmp_nbu
   where kodf=kodf_ and datf=Dat_ and substr(kodp,2,7)='0800000';

   if kol_=0 then

      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('108000001',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('308000001',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('108000002',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('308000002',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('108000003',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('308000003',Dat_, kodf_, '0', nbuc_);
   end if;

   --- код DD='09'
   select count(*) INTO kol_
   from tmp_nbu
   where kodf=kodf_ and datf=Dat_ and substr(kodp,2,7)='0900000';

   if kol_=0 then

      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('109000001',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('309000001',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('109000002',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('309000002',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('109000003',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('309000003',Dat_, kodf_, '0', nbuc_);
   end if;
end if;  --были до 31.08.2011
----------------------------------------
END p_fd0_NN;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FD0_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
