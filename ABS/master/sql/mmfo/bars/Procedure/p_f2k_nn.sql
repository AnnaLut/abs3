

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F2K_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F2K_NN ***

 CREATE OR REPLACE PROCEDURE BARS.P_F2K_NN (dat_ DATE ,
                                      sheme_ varchar2 default 'С')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирование файла #2K
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
%
% VERSION     : v.18.008     25.09.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: dat_ - отчетная дата
           sheme_ - схема формирования

   Структура показателя    DDD ZZZZZZZZZZ A NNNN

  1    DDD           код операции (список 3-х значных кодов)
  4    ZZZZZZZZZZ    код ЕДРПОУ/IНДРФО
 14    A             K021 признак идентификационного кода
 15    NNNN          условный номер строки в отчетном файле

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 25.09.2018  корректировка алгоритма обработки "второго" набора доп.параметров
 14.08.2018  обработка "второго" набора доп.параметров клиента с санкциями
 30.05.2018  DDD=270 -залишок коштiв на дату введення санкцiй (дата-1)
 16.03.2018  адрес клиента заполняется отдельным скриптом
 06.02.2018  обязательное заполнение кода DDD=310 при  отсутствии операций
 31.01.2018  отсекаем закрытых клиентов 
 10.01.2018  ограничение по отбору операций по типу оплаты SOS
 05.01.2018  добавлено формирование DDD=351
 04.01.2018  исключены операции по счетам КТ=65__
             формирование значений показателей в копейках
             новый список значений K021 (сегмент A)
 29.12.2017  уточнение в алгоритме отбора клиентов по доп.параметрам
 12.12.2017  условие на счета входящие в выборку только по дате закрытия
 05.12.2017  расширение OKPO до 10-ти знаков нулями
 28.11.2017  обработка "примiток" по счетам из доп.параметров
 06.11.2017  доработки по заявке cobummfo-5348
 01.11.2017  обработка ситуаций с незаполенной датой в параметре RNBOD
 02.10.2017  расширена длина переменной p_391
 21.08.2017  значение DDD=260 определяется по признаку блокировки счета
 14.06.2017  создание процедуры

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_       varchar2(2):='2K';
kodp_       varchar2(30);
znap_       varchar2(50);

userid_     number;
mfo_        number;
mfou_       number;
tobo_       accounts.tobo%TYPE;
nbuc_       accounts.tobo%TYPE;
nbuc1_      accounts.tobo%TYPE;

typ_        number;
dats_       date;

segm_z      varchar2(10);
segm_a      varchar2(1);
segm_n      varchar2(4);
nnnn_       number;
nnno_       number;
flag_acc_   number;
flag_opp_   number;

dat_rnbo_         date;
is_dat_exist_     number;

p_030          varchar2(70);
p_210          number;
p_260          varchar2(10);
p_310          varchar2(1);
p_330          varchar2(20);
p_340          varchar2(70);
p_350          varchar2(10);
p_351          varchar2(1);
p_360          varchar2(70);
p_391          varchar2(10);

 addr_         varchar2(200);
 ise_          varchar2(5);
 cod_c         integer;
 is_in_rnbu    integer;

--    операции DDD начинающиеся с 0..
procedure p_ins_0( p_rnk number, p_kodp varchar2,
                   p_nmk varchar2, p_adr varchar2, p_prim varchar2 )
   is
begin

--    010  найменування
       insert into rnbu_trace
                 ( rnk, kodp, znap )
          values ( p_rnk, '010'||p_kodp, p_nmk );

--    020  мiсцезнаходження
       insert into rnbu_trace
                 ( rnk, kodp, znap )
          values ( p_rnk, '020'||p_kodp, p_adr );

--    030  примiтка    
       if p_prim is not null  then

          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '030'||p_kodp, p_prim );

       end if;

end;

--    операции DDD начинающиеся с 1..
procedure p_ins_1( p_rnk number, p_kodp varchar2,
                   p_rnbor varchar2, p_rnbou varchar2, p_rnbos varchar2 )
   is
begin

--    110  номер позицii
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '110'||p_kodp, p_rnbor );

--    120  номер указу
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '120'||p_kodp, 
                     (case when p_rnbou is null  then 'немае даних'
                          else p_rnbou end)
                    );

--    130  санкцiя
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '130'||p_kodp,
                     (case when p_rnbos is null  then 'немае даних'
                          else p_rnbos end)
                    );

end;

--    операции DDD начинающиеся с 2..
procedure p_ins_2( p_rnk number, p_kodp varchar2,
                   p_210 number, p_nls varchar2, p_kv number,
                   p_daos varchar2, p_dazs varchar2, 
                   p_260 varchar2, p_270 varchar2, p_280 varchar2 )
   is
begin

--    210  стан рахунку
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '210'||p_kodp, p_210 );

--    220  номер рахунку
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '220'||p_kodp, p_nls );

--    230  код валюти рахунку
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '230'||p_kodp, p_kv );

--    240  дата вiдкриття рахунку
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '240'||p_kodp, p_daos );

--    250  дата закриття рахунку
          if p_dazs is not null  then
            insert into rnbu_trace
                      ( rnk, kodp, znap )
               values ( p_rnk, '250'||p_kodp, p_dazs );
          end if;

--    260  стан застосування санкцiй
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '260'||p_kodp, p_260 );

--    270  залишок коштiв 1 -на дату введення санкцiй
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '270'||p_kodp, p_270 );

--    280  залишок коштiв 2 -на звiтну дату
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '280'||p_kodp, p_280 );

end;

--    операции DDD начинающиеся с 3..
procedure p_ins_3( p_rnk number, p_kodp varchar2,
                   p_310 varchar2, p_320 varchar2, p_330 varchar2,
                   p_340 varchar2, p_350 varchar2, p_351 varchar2, p_360 varchar2, 
                   p_ostf number, p_kv number, p_390 varchar2, p_391 varchar2 )
   is
begin

--    310  код виду фiнансовоi операцii
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '310'||p_kodp, p_310 );

--    320  дата спроби проведення фiнансовоi операцii
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '320'||p_kodp, p_320 );

--    330  номер рахунку отримувача/платника
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '330'||p_kodp, p_330 );
                                                
--    340  наiменування отримувача/платника
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '340'||p_kodp, p_340 );

--    350  код едрпоу/iпн отримувача/платника
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '350'||p_kodp, p_350 );

--    351  ознака iдентифікаційного коду
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '351'||p_kodp, p_351 );

--    360  наiменування банку отримувача/платника
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '360'||p_kodp, p_360 );

--    370  сума фiнансовоi операцii
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '370'||p_kodp, to_char(p_ostf) );

--    380  код валюти фiнансовоi операцii
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '380'||p_kodp, lpad(trim(to_char(p_kv)),3,'0') );

--    390  призначення платежу фiнансовоi операцii
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '390'||p_kodp, p_390 );

--    391  дii банку при спробi фiнансовоi операцii
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '391'||p_kodp, p_391 );

end;

BEGIN

EXECUTE IMMEDIATE 'alter session set NLS_NUMERIC_CHARACTERS = ''.,'' ';
-------------------------------------------------------------------
logger.info ('P_F2K_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
-------------------------------------------------------------------
userid_ := user_id;
DELETE FROM RNBU_TRACE WHERE userid = userid_;
-------------------------------------------------------------------
   mfo_ := F_OURMFO();

-- МФО "родителя"
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

   p_proc_set(kodf_,sheme_,nbuc1_,typ_);

   nnnn_ :=0;
   nnno_ := nnnn_;

   dats_ := trunc(dat_, 'mm');
   
   for k in ( select c.okpo, c.codcagent, c.ise,
                             c.nmk, c.adr, c.rnk, c.country,
                             re.rnbor, re.rnbou,
                             re.rnbos, re.rnbod
                from customer c,
                     ( select *
                         from ( select u.rnk, u.tag, substr(trim(u.value),1,20) value
                                  from customerw u
                                 where exists (select 1 from customerw p
                                                where p.tag like 'RNBOS'
                                                  and regexp_instr(p.value,'01|02|03|04|05|99') >0
                                                  and p.rnk=u.rnk) 
                                   and tag in ('RNBOR', 'RNBOU', 'RNBOS', 'RNBOD')
                              ) pivot
                              ( max(trim(value))
                                for tag in ('RNBOR' as RNBOR, 'RNBOU' as RNBOU,
                                            'RNBOS' as RNBOS, 'RNBOD' as RNBOD)
                              )
                     ) re
               where c.rnk = re.rnk
                 and c.date_off is null
                 and trim(re.rnbor) is not null
               order by c.okpo
            )
   loop
       if     k.ise like '13%'             then    segm_a :='G';
       elsif  k.ise in ('ZZZZZ','YYYYY')   then    segm_a :='D';
       elsif  k.codcagent =5               then    segm_a :='2';
       elsif  k.codcagent =6 and k.country ='900'
                                           then    segm_a :='2';
       else
             segm_a := '1';
       end if;
       segm_z := lpad(trim(k.okpo),10,'0');

       begin
--         addr_ := f_get_adr(k.rnk,2);
select
     address||', '||decode(locality_type,1,'м.',3,'c.',2,'смт.',5, 'ст.',4, 'хут.',null )||decode(locality,null,null,(locality||', '))||decode(domain,null,null,(domain||', '))||C.NAME||', '||zip
     into addr_
 from customer_address a, country c
 where
     a.rnk=k.rnk
     and a.type_id=2
     and c.country=a.country;

       exception
         when others  then
            begin
--               addr_ := f_get_adr(k.rnk,1);
select
     address||', '||decode(locality_type,1,'м.',3,'c.',2,'смт.',5, 'ст.',4, 'хут.',null )||decode(locality,null,null,(locality||', '))||decode(domain,null,null,(domain||', '))||C.NAME||', '||zip
     into addr_
 from customer_address a, country c
 where
     a.rnk=k.rnk
     and a.type_id=1
     and c.country=a.country;

            exception
               when others  then  addr_ :=k.adr;
            end;
       end;

--       addr_ := nvl(f_get_adr(k.rnk),k.adr);

       is_dat_exist_ := 0;
       begin
         dat_rnbo_ := to_date(k.rnbod,'dd/mm/yyyy');
         is_dat_exist_ := 1;
       exception
           when others  then
              begin
                dat_rnbo_ := to_date(k.rnbod,'dd.mm.yyyy');
                is_dat_exist_ := 1;
              exception
                  when others  then
                           dat_rnbo_ :=dat_;
              end;
       end;
       
--  правильная дата в dat_rnbo_ 
    if is_dat_exist_ =1  then

       flag_acc_ := 0;
       flag_opp_ := 0;

       -----------------------------------------------------------
       for u in ( select a.acc, a.kv, a.nbs, a.nls, a.daos, a.dazs,
                         to_char(a.daos,'ddmmyyyy') c_daos,
                         decode(a.dazs,null,null,to_char(a.dazs,'ddmmyyyy') ) c_dazs,
                         to_char( (case when round( gl.p_icurval (a.kv, fost(a.acc,dat_rnbo_-1), dat_) ) <0 then 0
                                        else round( gl.p_icurval (a.kv, fost(a.acc,dat_rnbo_-1), dat_) )
                                    end) )  p_270,
                         to_char( (case when round(fostq(a.acc,dat_)) <0 then 0
                                        else round(fostq(a.acc,dat_))
                                    end) )  p_280,
                         nvl(a.blkd,0)+nvl(a.blkk,0) acc_blk
                    from accounts a
                   where a.rnk = k.rnk 
                     and a.nbs in (
            '2512', '2513', '2520', '2523', '2525', '2530', '2541', '2542',
            '2544', '2545', '2546', '2550', '2551', '2553', '2555', '2556',
            '2560', '2561', '2562', '2565', '2600', '2604', '2605', '2610',
            '2615', '2620', '2625', '2630', '2635', '2650', '2651', '2652',
            '2655', '3320', '3330', '3340' )
                     and ( a.dazs is null
                        or a.dazs is not null and
                           a.dazs > dat_rnbo_ )
                )
       loop
          flag_acc_ := 1;
          
          p_210 := 1;
          if u.dazs is not null and u.dazs<dat_  then
              p_210 :=2;
          end if;

          p_260 := '';
          if u.acc_blk !=0  then
             p_260 := '02';
          else
             p_260 := '99';
          end if;

--   поиск "примiток" по счету из доп.параметров
          begin

            select substr(trim(value),1,70)   into p_030
              from accountsw
             where kf =mfo_
               and tag ='#2K_PRIM'
               and acc =u.acc;

          exception
             when others  then  p_030 :='';
          end;

          flag_opp_ := 0;
          ------------------------------------------------------
          for v in ( select to_char(p.pdat,'ddmmyyyy') pdat,
                            p.mfoa, r1.nb namb_a, r1.k040 k040b_a,
                            p.accd, p.nlsa nlsd, p.nam_a, p.id_a okpo_a,
                            p.mfob, r2.nb namb_b, r2.k040 k040b_b,
                            p.acck, p.nlsb nlsk, p.nam_b, p.id_b okpo_b,
                            p.kv, 100*p.s ostf, 100*p.sq ostq, p.ref, p.nazn
                       from rcukru r1, rcukru r2,
                            ( SELECT p.userid isp, p.branch, p.mfoa, p.mfob, p.nam_a, p.nam_b, p.sos soso,
                                     DECODE (o.tt, p.tt, p.nazn, DECODE (o.tt, 'PO3', p.nazn, t.NAME)) nazn,
                                     o.tt, o.REF, ad.kv,
                                     o.s / 100 s,  o.sq / 100 sq, o.fdat, o.stmt, o.txt,
                                     o.accd, ad.nls nlsd, ad.NBS nbsd, ad.branch branch_a, ad.rnk rnkd, ad.ob22 ob22d,
                                     o.acck, ak.nls nlsk, ak.NBS nbsk, ak.branch branch_b, ak.rnk rnkk, ak.ob22 ob22k,
                                     p.vob, p.nlsa, p.nlsb, p.kv kv_o, p.kv2 kv2_o, p.dk dk_o,
                                     p.pdat, p.datd pdatd, p.nazn pnazn, p.tt ptt, p.s ps, p.id_a, p.id_b
                                FROM oper p,
                                     tts t,
                                     accounts ad, accounts ak,
                                     (SELECT o1.fdat, o1.REF, o1.stmt, o1.tt, o1.s,
                                             o1.sq, o1.txt,
                                             (case when o1.dk = 0 then o1.acc else o2.acc end) accd, 
                                             (case when o1.dk = 1 then o1.acc else o2.acc end) acck
                                      FROM opldok o1
                                      JOIN opldok o2
                                          ON (    o1.KF  = o2.kf
                                              AND o1.REF = o2.REF
                                              AND o1.stmt= o2.stmt
                                              AND o1.dk <> o2.dk)
                                      WHERE o1.fdat between dats_ and dat_ AND
                                            o1.acc = u.acc 
                                       ) o
                               WHERE p.REF = o.REF
                                 and p.sos <0
                                 AND t.tt = o.tt
                                 AND o.accd = ad.acc
                                 AND o.acck = ak.acc
                                 and nvl(ak.nbs,substr(ak.nls,1,4)) not like '65%'
                            ) p
                      where p.mfoa = r1.mfo
                        and p.mfob = r2.mfo
                   )
          loop
             flag_opp_ := 1;
             
             if u.acc = v.accd  then
                p_310 :='1';
                p_330 := v.nlsk;
                p_340 := substr(trim(v.nam_b),1,70);
                p_350 := lpad(v.okpo_b,10,'0');
                p_351 := '1';
                p_360 := substr(trim(v.namb_b),1,70);

                begin
                    select ise, codcagent  into ise_, cod_c
                      from customer
                     where okpo = v.okpo_b;

                    if     ise_ like '13%'             then    p_351 :='G';
                    elsif  ise_ in ('ZZZZZ','YYYYY')   then    p_351 :='D';
                    elsif  cod_c =5
                       and regexp_instr(v.okpo_b,'[^[:digit:]]')=0
                                                       then    p_351 :='2';
                    elsif  cod_c =5                    then    p_351 :='6';
                    else
                         p_351 := '1';
                    end if;
                exception
                   when others  then
                     if    length(trim(v.okpo_b))=10
                       and regexp_instr(v.okpo_b,'[^[:digit:]]')=0
                                                       then    p_351 :='2';
                     elsif length(trim(v.okpo_b))=10
                                                       then    p_351 :='6';
                     else
                         p_351 := '1';
                     end if;
                end;

             else
                p_310 :='2';
                p_330 := v.nlsd;
                p_340 := substr(trim(v.nam_a),1,70);
                p_350 := lpad(v.okpo_a,10,'0');
                p_351 := '1';
                p_360 := substr(trim(v.namb_a),1,70);

                begin
                    select ise, codcagent  into ise_, cod_c
                      from customer
                     where okpo = v.okpo_a;

                    if     ise_ like '13%'             then    p_351 :='G';
                    elsif  ise_ in ('ZZZZZ','YYYYY')   then    p_351 :='D';
                    elsif  cod_c =5
                       and regexp_instr(v.okpo_a,'[^[:digit:]]')=0
                                                       then    p_351 :='2';
                    elsif  cod_c =5                    then    p_351 :='6';
                    else
                         p_351 := '1';
                    end if;
                exception
                   when others  then
                     if    length(trim(v.okpo_a))=10
                       and regexp_instr(v.okpo_a,'[^[:digit:]]')=0
                                                       then    p_351 :='2';
                     elsif length(trim(v.okpo_a))=10
                                                       then    p_351 :='6';
                     else
                         p_351 := '1';
                     end if;
                end;

             end if;
             
             p_391 := p_260;

             nnnn_ :=nnnn_+1;

             segm_n := lpad(to_char(nnnn_),4,'0');
             kodp_ := segm_z||segm_a||segm_n;

             p_ins_0( k.rnk, kodp_, k.nmk, addr_, p_030 );
   
             p_ins_1( k.rnk, kodp_, k.rnbor, k.rnbou, k.rnbos );

             p_ins_2( k.rnk, kodp_, p_210, u.nls, u.kv,
                      u.c_daos, u.c_dazs,
                      p_260, u.p_270, u.p_280 );

             p_ins_3( k.rnk, kodp_, p_310, v.pdat, p_330, p_340,
                      p_350, p_351, p_360, v.ostq, v.kv, substr(v.nazn,1,70), p_391 );

          end loop;                --цикл по операциям

          if flag_opp_ = 0  then             --нет операций
             nnnn_ :=nnnn_+1;
             nnno_ :=nnnn_;

             segm_n := lpad(to_char(nnnn_),4,'0');
             kodp_ := segm_z||segm_a||segm_n;

             p_ins_0( k.rnk, kodp_, k.nmk, addr_, p_030 );
   
             p_ins_1( k.rnk, kodp_, k.rnbor, k.rnbou, k.rnbos );

             p_ins_2( k.rnk, kodp_, p_210, u.nls, u.kv,
                      u.c_daos, u.c_dazs,
                      p_260, u.p_270, u.p_280 );

--    310  код виду фiнансовоi операцii
             insert into rnbu_trace
                       ( rnk, kodp, znap )
                values ( k.rnk, '310'||kodp_, '5' );
--    380  код валюти фiнансовоi операцii при вiдсутностi операцiй
             insert into rnbu_trace
                       ( rnk, kodp, znap )
                values ( k.rnk, '380'||kodp_, '000' );

          end if;
       end loop;                   --цикл по счетам

       if flag_acc_ = 0 then             --нет счетов

--  возможно наличие нескольких rnk для клиента (одинаковое ОКПО -segm_a)
--  при формировании только клиентских показателей проверям не было ли уже такого ОКПО 
          is_in_rnbu := 0;
          select count(*)  into is_in_rnbu
            from rnbu_trace
           where substr(kodp,4,10) = segm_z;

          if is_in_rnbu =0  then
            nnnn_ :=nnnn_+1;
            nnno_ :=nnnn_;

            segm_n := lpad(to_char(nnnn_),4,'0');
            kodp_ := segm_z||segm_a||segm_n;

            p_ins_0( k.rnk, kodp_, k.nmk, addr_, p_030 );
    
            p_ins_1( k.rnk, kodp_, k.rnbor, k.rnbou, k.rnbos );
          end if;

       end if;

   end if;

   end loop;                       --цикл по клиентам

--    обработка "второго" набора доп.параметров клиента с санкциями
   for k in ( select c.okpo, c.codcagent, c.ise,
                             c.nmk, c.adr, c.rnk, c.country,
                             re.rnbor, re.rnbou,
                             re.rnbos, re.rnbod
                from customer c,
                     ( select *
                         from ( select u.rnk, u.tag, substr(trim(u.value),1,20) value
                                  from customerw u
                                 where exists (select 1 from customerw p
                                                where p.tag like 'RNB1S'
                                                  and regexp_instr(p.value,'01|02|03|04|05|99') >0
                                                  and p.rnk=u.rnk) 
                                   and tag in ('RNB1R', 'RNB1U', 'RNB1S', 'RNB1D')
                              ) pivot
                              ( max(trim(value))
                                for tag in ('RNB1R' as RNBOR, 'RNB1U' as RNBOU,
                                            'RNB1S' as RNBOS, 'RNB1D' as RNBOD)
                              )
                     ) re
               where c.rnk = re.rnk
                 and c.date_off is null
                 and trim(re.rnbor) is not null
               order by c.okpo
            )
   loop

       for u1 in ( select rnk, substr(kodp,15,4) nnnn
                     from rnbu_trace
                    group by rnk, substr(kodp,15,4)
       ) loop

           nnnn_ := nnnn_+1;
           segm_n := lpad(to_char(nnnn_),4,'0');

           for u in (select * from rnbu_trace
                      where rnk =k.rnk
                        and substr(kodp,15,4) =u1.nnnn
           ) loop

               if    substr(u.kodp,1,3) ='110'  then
--    110  номер позицii
                   insert into rnbu_trace
                             ( rnk, kodp, znap )
                      values ( k.rnk, substr(u.kodp,1,14)||segm_n,
                               (case when k.rnbor is null  then 'немае даних'
                                       else k.rnbor end) );

               elsif substr(u.kodp,1,3) ='120'  then
--    120  номер указу
                  insert into rnbu_trace
                            ( rnk, kodp, znap )
                     values ( k.rnk, substr(u.kodp,1,14)||segm_n, 
                             (case when k.rnbou is null  then 'немае даних'
                                     else k.rnbou end) );

               elsif substr(u.kodp,1,3) ='130'  then
--    130  санкцiя
                  insert into rnbu_trace
                            ( rnk, kodp, znap )
                     values ( k.rnk, substr(u.kodp,1,14)||segm_n,
                             (case when k.rnbos is null  then 'немае даних'
                                     else k.rnbos end) );

               else
                   insert into rnbu_trace
                             ( rnk, kodp, znap )
                      values ( k.rnk, substr(u.kodp,1,14)||segm_n, u.znap );
               end if;

           end loop;

       end loop;

   end loop;
------------------------------------------------------
   DELETE FROM tmp_nbu
    where kodf=kodf_ and datf=dat_;

   INSERT INTO tmp_nbu
             ( kodf, datf, kodp, znap )
        select kodf_, dat_, kodp, znap
          from rnbu_trace;

   logger.info ('P_F2K_NN: END ');

END P_F2K_NN;
/
show err;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F2K_NN.sql =========*** End ***
PROMPT ===================================================================================== 
