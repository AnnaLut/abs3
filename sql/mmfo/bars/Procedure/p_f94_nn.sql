

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F94_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F94_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F94_NN (Dat_ DATE ,
          sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	#94 for KB
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 13/11/2014 (04/08/2014)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
04.07.2013 для переменной comm_ выбираем только 200 символов
28.05.2013 внес изменения которые соответствуют условиям как в файле @12
           для символов 32, 39, 61, 66 (проверено в Крыму)
07.11.2011 внес изменения выполненные в процедуре P_F12_nn
           30.10.2011 в поле комментарий добавил сообщение о замене СК
                      (Вирко добавляла 07.06.2011)
           05.10.2011 для проводок Дт 1001,1002,1003,1004
                      Кт 1001,1002,1003,1004
                      вместо DK из OPER будем выбирать DK из OPLDOK
27.12.2010 изменил некоторые условия для операций покупки/продажи
           валюты и их возвращения.
           Будем изменять симв.кассплана для операций продажи (AA4,AA6)
           на 32 если TT(OPER)=TT(OPLDOK) и на 61 если код операции 'BAK'.
           Будем изменять симв.кассплана для операций покупки (AA3,AA5)
           на 61 если TT(OPER)=TT(OPLDOK) и на 32 если код операции 'BAK'.
14.12.2010  внесены все изменения выполненные в процедуре P_F12_nn
            начиная с 08.07.2010
08.12.2010  для блока "IF o_tt_ in ('AA3','AA4','AA5','AA6') then "
            вместо переменной "o_tt_" - код операции из OPER была
            переменная "tt_" - код операции из OPLDOK
            (исправлено замечание Ровно СБ)
07.12.2010  по настоянию Департамента СБЕРбанка разделили операции TOC и TOP,
            поэтому возникли проблемы заполнения СК для дочерней операции TOP
            (раньше символ был зашит в эту операцию)
26.11.2010  изменения для валютообменных операций (сторно операции)
            для операции "BAK' присваиваем символ 61 если SK=30 или
            символ 32 если SK=56 (так сделано и проверено в P_F12sb)
01.11.2010  выполнялись изменения символа не для всех указанных операций
            Исправлено.
21.10.2010  для операций покупки/продажи валюты и их возвращения будем
            изменять символ кассплана с 30 на 32 и с 56 на 61
            операции AA3, AA4, AA5, AA6
08.07.2010  в протокол формирования для курсора OPERA добавлено заполнение
            полей REF и COMM(назначение платежа)
26.08.2009  добавил блок наполнения внебалансовых символов из KL_D010
            при отсутствии их в TMP_NBU.
18.04.2008  изменил курсор OPERA как в файле #13.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_  	 varchar2(2):='94';
   nbuc_   varchar2(20);
   nbuc1_   varchar2(20);
   typ_ number;
   acc_ 	 number;
   nls_     varchar2(15);
   nls1_    varchar2(15);
   nlsd_    varchar2(15);
   nlsk_    varchar2(15);
   data_    date;
   dat1_    date;
   dat2_    date;
   kv_      SMALLINT;
   kod_o    Varchar2(4);
   kodp_    varchar2(10);
   znap_    varchar2(30);
   sk_      SMALLINT;
   tt_      Varchar2(3);  -- з OPLDOK
   tt_pr    varchar2(3);
   o_tt_    Varchar2(3);  -- з OPER
   t_sk_    SMALLINT;     -- з TTS
   sk_o_    SMALLINT;  -- з OPER
   sk1_     SMALLINT;
   sk2_     SMALLINT;
   s_       DECIMAL(24);
   ref_     Number;
   flag_    NUMBER;
   nbu_     SMALLINT;
   userid_ Number;
   kol_sk_ number :=0;
   dk_      NUMBER;
   dk1_     NUMBER;
   nazn_    Varchar2(160);
   comm_    rnbu_trace.comm%TYPE;
   stmt_    Number;
   pr_bak   Number;
   pr_doch  Number;
   mfo_     number;
   mfou_    Number;
   sql_     VARCHAR2(1000):=NULL;
   nlso_    varchar2(15);
   tto_     varchar2(3);
   nazno_   varchar2(1000);
   wsk_     SMALLINT;
   cnt_bak_ number;

   TYPE ref_type_curs IS REF CURSOR;

   saldo        ref_type_curs;
   cursor_sql   varchar2(20000);

   type rec_type is record
        (acc_   number,
         nls1_  varchar2(15),
         nls_   varchar2(15),
         kv_    integer,
         dk_    number,
         data_  date,
         ref_   number,
         stmt_  number,
         nazn_  varchar2(1000),
         sk_    SMALLINT,
         t_sk_  SMALLINT,
         dk1_   number,
         tt_    varchar2(3),
         o_tt_  varchar2(3),
         sk_o_  SMALLINT,
         s_     DECIMAL(24),
         pr_doch  Number,
         nlso_   varchar2(15),
         tto_    varchar2(3),
         nazno_  varchar2(1000),
         wsk_    SMALLINT,
         cnt_bak_ number);

   TYPE rec_t IS TABLE OF rec_type;
   l_rec_t      rec_t := rec_t();

   TYPE rnbu_trace_t IS TABLE OF rnbu_trace%rowtype;
   l_rnbu_trace rnbu_trace_t := rnbu_trace_t();

    procedure p_add_rec(p_recid rnbu_trace.recid%type, p_userid rnbu_trace.userid%type, p_nls rnbu_trace.nls%type,
                        p_kv rnbu_trace.kv%type, p_odate rnbu_trace.odate%type, p_kodp rnbu_trace.kodp%type,
                        p_znap rnbu_trace.znap%type, p_nbuc rnbu_trace.nbuc%type, p_acc rnbu_trace.acc%type,
                        p_ref rnbu_trace.ref%type, p_comm rnbu_trace.comm%type)
    is
        lr_rnbu_trace rnbu_trace%rowtype;
    begin
       lr_rnbu_trace.RECID := p_recid;
       lr_rnbu_trace.USERID := p_userid;
       lr_rnbu_trace.NLS := p_nls;
       lr_rnbu_trace.KV := p_kv;
       lr_rnbu_trace.ODATE := p_odate;
       lr_rnbu_trace.KODP := p_kodp;
       lr_rnbu_trace.ZNAP := p_znap;
       lr_rnbu_trace.NBUC := p_nbuc;
       lr_rnbu_trace.ISP := null;
       lr_rnbu_trace.RNK := null;
       lr_rnbu_trace.ACC := p_acc;
       lr_rnbu_trace.REF := p_ref;
       lr_rnbu_trace.COMM := p_comm;
       lr_rnbu_trace.ND := null;
       lr_rnbu_trace.MDATE := null;
       lr_rnbu_trace.TOBO := null;

       l_rnbu_trace.Extend;
       l_rnbu_trace(l_rnbu_trace.last) := lr_rnbu_trace;

       if l_rnbu_trace.COUNT >= 100000 then
          FORALL i IN 1 .. l_rnbu_trace.COUNT
               insert /*+ append */ into rnbu_trace values l_rnbu_trace(i);

          l_rnbu_trace.delete;
       end if;
    end;
BEGIN
    commit;

    EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
    -------------------------------------------------------------------
    logger.info ('P_F94_NN: Begin for '||to_char(dat_,'dd.mm.yyyy'));
    -------------------------------------------------------------------
    userid_ := user_id;
    EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
    -------------------------------------------------------------------
    mfo_ := F_OURMFO();

    BEGIN
      SELECT NVL(trim(mfou), mfo_)
        INTO mfou_
      FROM BANKS
      WHERE mfo = mfo_;
    EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
    END;

    Dat1_ := TRUNC(Dat_, 'MM');
    Dat2_ := TRUNC(Dat_ + 5);

    -- определение наличия табл. OTCN_F13_ZBSK
    SELECT COUNT(*) INTO flag_
    FROM ALL_TABLES
    WHERE owner='BARS' AND table_name = 'OTCN_F13_ZBSK' ;

    nbu_:= IsNBUBank();

    select count(*) into kol_sk_
    from op_rules
    where trim(tag) in ('SK_P','SK_V');

    -- определение начальных параметров
    p_proc_set(kodf_,sheme_,nbuc1_,typ_);

    cursor_sql := 'select
                       s.acc,
                       s.nls,
                       s.pnlsa,
                       s.pkv,
                       s.pdk,
                       s.fdat,
                       s.REF,
                       s.stmt,
                       s.nazn,
                       NVL (DECODE (s.tt, s.ptt, s.psk, t.sk),
                            NVL(TO_NUMBER (SUBSTR (w.VALUE, 1, 2)),0)) sk,
                       t.sk,
                       s.dk,
                       s.tt,
                       s.ptt,
                       s.psk,
                       s.s,
                       DECODE (s.tt, s.ptt, 0, 1) pr,
                       o.nls nlso, o.tt tto, o.nazn nazno,
                       nvl(TO_NUMBER(SUBSTR(w.value,1,2)),0) wsk,
                       nvl(r.cnt_bak, 0) cnt_bak
                from (select *
                      from opl_otc a
                      where fdat between :dat1_ and :dat2_ and
                          tip=''KAS'' AND
                          substr(nls,1,4) in (''1001'',''1002'',''1003'',''1004'') AND
                          kv=980 and
                          psos = 5) s
                join opl_acc o
                on (s.ref = o.ref and
                    s.fdat= o.fdat and
                    s.kv  = 980 and
                    s.stmt= o.stmt and
                    s.dk <> o.dk and
                    s.s = o.s)
                join tts t
                on (s.tt = t.tt)
                left outer join operw w
                on (s.ref = w.ref and
                    w.tag = ''SK'')
                left outer join (select ref, count(*) cnt_bak from opldok where tt = ''BAK'' group by ref) r
                on (s.ref = r.ref)' ;

   OPEN saldo FOR cursor_sql USING Dat1_, Dat_;
   LOOP
       FETCH saldo BULK COLLECT INTO l_rec_t LIMIT 100000;
       EXIT WHEN l_rec_t.count = 0;

       for i in 1..l_rec_t.count loop
           acc_    :=     l_rec_t(i).acc_;
           nls1_   :=     l_rec_t(i).nls1_;
           nls_    :=     l_rec_t(i).nls_;
           kv_     :=     l_rec_t(i).kv_;
           dk_     :=     l_rec_t(i).dk_;
           data_   :=     l_rec_t(i).data_;
           ref_    :=     l_rec_t(i).ref_;
           stmt_   :=     l_rec_t(i).stmt_;
           nazn_   :=     l_rec_t(i).nazn_;
           sk_     :=     l_rec_t(i).sk_;
           t_sk_   :=     l_rec_t(i).t_sk_;
           dk1_    :=     l_rec_t(i).dk1_;
           tt_     :=     l_rec_t(i).tt_;
           o_tt_   :=     l_rec_t(i).o_tt_;
           sk_o_   :=     l_rec_t(i).sk_o_;
           s_      :=     l_rec_t(i).s_;
           pr_doch :=     l_rec_t(i).pr_doch;
           nlso_   :=     l_rec_t(i).nlso_;
           tto_    :=     l_rec_t(i).tto_;
           nazno_  :=     l_rec_t(i).nazno_;
           wsk_    :=     l_rec_t(i).wsk_;
           cnt_bak_ :=   l_rec_t(i).cnt_bak_;

           comm_ := '';

           tt_pr := tto_;
           nazn_ := substr(nazno_, 1, 100);

           if dk_ = 0 then
              nlsd_ := nls1_;
              nlsk_ := nlso_;
           else
              nlsd_ := nlso_;
              nlsk_ := nls1_;
           end if;

           comm_ := comm_ || ' Дт рах. = ' || nlsd_ || ' Кт рах. = ' || nlsk_ || '  ' || nazn_;

           IF typ_>0 THEN
              nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
           ELSE
              nbuc_ := nbuc1_;
           END IF;

           -- по настоянию Департамента СБЕРбанка разделили операции TOC и TOP, поэтому возникли проблемы
           -- заполнения СК для дочерней операции TOP (раньше символ был зашит в эту операцию)
           IF sk_ = 0 AND tt_ in ('TOC', 'TCC') and pr_doch = 1 then
              comm_ := substr('!!! авт. замена ' || sk_  ||' на '|| sk_o_  ||' '|| comm_,1,200);
              sk_ := sk_o_;
           end if;

        -- для банка УПБ и ОПЕРУ СБ в кассовых операциях по 980 и типов проводок
        --  Дт 1001-1004 Кт 1001-1004 имеется два доп.реквизита символов кассплана
        -- символ кассплана SK_P (приход) и SK_V (расход)
        -- для всех банков !!! если имеются доп.реквизиты SK_P, SK_V в операциях
           IF kol_sk_ > 0 THEN
              sk2_:=sk_;

              if tt_ = o_tt_ then        -- основна операцiя
              -- все одно прiоритет доп.реквiзитiв SK_P, SK_V
                 begin
                    select to_number(substr(value,1,2)) into sk1_
                    from operw
                    where ref=ref_ and
                          trim(tag)=DECODE(dk1_,0,'SK_P','SK_V');
                 exception when others then
                    sk1_:=0;
                 end;
                 if sk1_ is not NULL and sk1_<>0 then
                    sk2_:=sk1_;
                 else
                    NULL;
                 end if;
              else                          -- зв'язана операцiя
                 sk2_:=t_sk_;               -- ! прiоритет СКП з карточки зв'язаної операцiї?
                 if sk2_ is NULL then
                    begin
                       sk2_ := wsk_;
                    exception when others then
                       sk2_:=0;
                    end;
                 end if;
              end if;
              sk_:=sk2_;
              if sk2_ is NULL then
                 sk_:=0;
              end if;
           ELSE
              IF sk_ IS NULL THEN
                 sk_ := wsk_;
              END IF ;

              -- для проводок вида Дт 1001  Кт 1001,1002,1003,1004 или
              -- Дт 1001,1002,1003,1004  Кт 1001
              IF substr(nls_,1,4) in ('1001','1002','1003','1004') and--nls_=nls1_ and
                 dk_=1 and  dk1_=1 and sk_=39 and tt_ = 'МГР' THEN
                 comm_ := substr('!!! авт. замена ' || sk_  ||' на 66 '|| comm_,1,200);
                 sk_:=66;
              END IF;

              IF substr(nls_,1,4) in ('1001','1002','1003','1004') and substr(nls1_,1,4) in ('1001','1002','1003','1004') and
                 dk_=1 and sk_=66 THEN
                 comm_ := substr('!!! авт. замена ' || sk_  ||' на 39 '|| comm_,1,200);
                 sk_:='39';
              END IF;

              IF substr(nls_,1,4) in ('1001','1002','1003','1004') and substr(nls1_,1,4) in ('1001','1002','1003','1004') and
                 dk1_=1 and sk_=39 and tt_ != 'МГР' THEN
                 comm_ := substr('!!! авт. замена ' || sk_  ||' на 66 '|| comm_,1,200);
                 sk_:=66;
              END IF;

              IF substr(nls_,1,4) in ('1001','1002','1003','1004') and nls_=nls1_ and
                 dk_=0 and sk_=39 THEN
                 sk_:='66';
              END IF;
           END IF;

           IF o_tt_ in ('025','K33','045','046','A22','150','151','AA3','AA4','AA5','AA6','AA7','AA8') then
              pr_bak := cnt_bak_;

              if o_tt_ in ('025','K33','045','046','A22','150','AA4','AA6','AA8') and pr_bak != 0 and sk_o_ < 40 then
                 if o_tt_ = tt_pr then
                    comm_ := substr('!!! авт. замена ' || sk_o_  ||' на 32 '|| comm_,1,200);
                    sk_ := 32;
                 end if;
                 if o_tt_ != tt_pr and tt_pr = 'BAK' and nlsk_ like '100%' and sk_o_ < 40 then
                    comm_ := substr('!!! авт. замена ' || sk_o_  ||' на 61 '|| comm_,1,200);
                    sk_ := 61;
                 end if;
              end if;
              if o_tt_ in ('151','AA3','AA5','AA7') and pr_bak != 0 and sk_o_  > 39 then
                 if o_tt_ = tt_pr then
                    comm_ := substr('!!! авт. замена ' || sk_o_  ||' на 61 '|| comm_,1,200);
                    sk_ := 61;
                 end if;
                 if o_tt_ != tt_pr and tt_pr = 'BAK' and nlsd_ like '100%' and sk_o_ > 39 then
                    comm_ := substr('!!! авт. замена ' || sk_o_  ||' на 32 '|| comm_,1,200);
                    sk_ := 32;
                 end if;
              end if;
           END IF;

           -- по настоянию Департамента СБЕРбанка разделили операции TOC и TOP, поэтому возникли проблемы
           -- заполнения СК для дочерней операции TOP (раньше символ был зашит в эту операцию)
           IF mfou_ = 300465 and sk_ = 0 AND tt_ = 'TOP' and pr_doch = 1 then
              sk_ := 2;
           end if;

           IF s_<>0 THEN
              kodp_:= LPAD(TO_CHAR(sk_),2,'0');
              znap_:= TO_CHAR(s_) ;

              p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp_, znap_,
                        nbuc_, acc_, ref_, comm_);
           END IF;
       end loop;

       l_rec_t.delete;
   END LOOP;

   CLOSE saldo;

   FORALL i IN 1 .. l_rnbu_trace.COUNT
       insert /*+ append */  into rnbu_trace values l_rnbu_trace(i);

    logger.info ('P_F94_NN: End etap 1 for '||to_char(dat_,'dd.mm.yyyy'));

    INSERT /*+ append */ INTO RNBU_TRACE (acc, nls, kv, odate, kodp, znap, nbuc)
    SELECT  o.acc, o.nls, o.kv, sa.FDAT,
            (case when nbu_ = 1 then '34' else '35' end) kodp,
            to_char(abs(sa.ostf-sa.dos+sa.kos)) s,
            (case when typ_>0
                  then NVL(F_Codobl_Tobo(sa.acc, typ_), nbuc1_)
                  else nbuc1_
            end) nbuc
    FROM SALDOA sa, ACCOUNTS o
    WHERE o.tip='KAS'    AND
         o.nbs in ('1001','1002','1003','1004') AND
         o.kv=980       AND
         o.acc=sa.acc   AND
         sa.FDAT  IN ( SELECT MAX ( bb.FDAT )
                  FROM  SALDOA bb
                  WHERE o.acc = bb.acc AND bb.FDAT  < Dat1_) and
         sa.ostf-sa.dos+sa.kos <> 0;

    logger.info ('P_F94_NN: End etap 2 for '||to_char(dat_,'dd.mm.yyyy'));

    INSERT /*+ append */ INTO RNBU_TRACE (acc, nls, kv, odate, kodp, znap, nbuc)
    SELECT  o.acc, o.nls, o.kv, sa.FDAT,
            (case when nbu_ = 1 then '69' else '70' end) kodp,
            to_char(abs(sa.ostf-sa.dos+sa.kos)) s,
            (case when typ_>0
                  then NVL(F_Codobl_Tobo(sa.acc, typ_), nbuc1_)
                  else nbuc1_
            end) nbuc
    FROM SALDOA sa, ACCOUNTS o
    WHERE o.tip='KAS'    AND
         o.nbs in ('1001','1002','1003','1004') AND
         o.kv=980       AND
         o.acc=sa.acc   AND
         sa.FDAT  IN ( SELECT MAX ( bb.FDAT )
                  FROM  SALDOA bb
                  WHERE o.acc = bb.acc AND bb.FDAT  <= Dat_) and
         sa.ostf-sa.dos+sa.kos <> 0;

    logger.info ('P_F94_NN: End etap 3 for '||to_char(dat_,'dd.mm.yyyy'));

    -- формирование внебалансовых символов из табл. OTCN_F13_ZBSK
    IF flag_ > 0 THEN
       sql_ := 'INSERT /*+ APPEND */ INTO RNBU_TRACE (recid, userid, nls, kv, odate, kodp, znap, nbuc, ref)
                select s_rnbu_record.nextval, user_id, nls, kv, odate, kodp, znap,
                       (case when :typ_>0
                              then NVL(F_Codobl_Tobo(acc, :typ_), :nbuc1_)
                              else :nbuc1_
                        end) nbuc, ref
                from (
                    SELECT (case when substr(nlsd,1,2) = ''26'' then accd else acck end) ACC,
                           (case when substr(nlsd,1,2) = ''26'' then nlsd else nlsk end) NLS,
                           kv KV, fdat odate, to_char(NVL(SK_ZB,0)) KODP, to_char(s) ZNAP, ref
                    FROM  otcn_f13_zbsk z
                    WHERE NVL(sk_zb,0) > 0 AND
                          fdat BETWEEN :Dat1_ AND :Dat_) a ';

       execute immediate sql_ USING typ_, typ_, nbuc1_, nbuc1_, Dat1_, Dat_;
       commit;
    END IF;

    logger.info ('P_F94_NN: End etap 4 for '||to_char(dat_,'dd.mm.yyyy'));

    ---------------------------------------------------
    DELETE FROM tmp_nbu where datf=Dat_ and kodf=kodf_ ;
    ---------------------------------------------------
    INSERT INTO TMP_NBU
        (kodf, datf, kodp, znap, nbuc)
    SELECT kodf_, Dat_, kodp, SUM (znap), nbuc
    FROM RNBU_TRACE
    GROUP BY kodp, nbuc;

    --- недостающие позабалансовые символа
    INSERT INTO TMP_NBU (kodf, datf, kodp, znap, nbuc)
    SELECT kodf_, Dat_, d010, '0', nbuc1_
          FROM KL_D010
          WHERE f_13='1' AND
                TO_NUMBER(d010)>73 AND
                d_close IS NULL AND
                d010 NOT IN (SELECT kodp
                             FROM TMP_NBU
                             WHERE kodf=kodf_ AND
                                   datf=Dat_);

    logger.info ('P_F94_NN: End for '||to_char(dat_,'dd.mm.yyyy'));
    ----------------------------------------
END p_f94_NN;
/
show err;

PROMPT *** Create  grants  P_F94_NN ***
grant EXECUTE                                                                on P_F94_NN        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F94_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
