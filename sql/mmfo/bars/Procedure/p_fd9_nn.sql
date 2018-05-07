CREATE OR REPLACE PROCEDURE BARS.p_fd9_NN (Dat_ DATE ,
                                      sheme_ varchar2 default 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #D9 для КБ (универсальная)
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 04/05/2018 (16/04/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
04.05.2018 - не будут формироваться дубликати показателя 010
16.04.2018 - изменено формирование кода ОКПО(K020) и кода K021
01.03.2018 - для контрагента или учасника - Кабинет Министров Украины
             параметр K021 будет формироваться как "9"
02.02.2018 - для расшфровки участников ЮЛ убрано условие 
             что только неинсайдеры  (  and NVL(c.prinsider,99) = 99  )
31.01.2018 - змінено формування частини показника ЗЗЗЗЗЗЗЗЗЗ для 
             нерезидентів
25.01.2018 - змінено формування кодів ZZZZZZZZZZ і ЗЗЗЗЗЗЗЗЗЗ а також
             код K021
13.10.2017 - якщо код ОКПО сформований як серія и номер паспорта тоді  
             K021 будемо заповнювати значенням '9' 
13.09.2017 - для ОКРО учасника у якого значення похоже на "D00000000_" 
             K021 будемо заповнювати значенням '9'
18.08.2017 - если для клиентов участников органов государственной власти
             (ISE=13110,13120,13131,13132) и поле OKPO_U имеет значение
             '00000000' или '000000000' или '0000000000' или '99999' или 
             '999999999' или '9999999999' 
             то тогда для таких клиентов будет заполнено "D"||<номер п/п>
14.08.2017 - для органів державної влади параметр K021 будемо заповнювати
             значенням '9'
10.11.2016 - для ФЛ включаются только контрагенты неинсайдеры
17.05.2016 - для участников ФЛ нерезидентов и при пустом заполнении поля
             серия паспорта будет формироваться IN || <условный код>
13.05.2106 - при отборе связанных лиц для ЮЛ будет отбираться
             ID_REL in (1,4) для ФЛ ID_REL in (5,12)
21.04.2016 - для расшифровки показателя 040 для ФЛ из CUST_BUN выбираем
             данные по условию RNKA=RNK  и не выбираем по RNKB
             (замечание Киевгорода - Грунич Виктории Борисовны)
19.04.2016 - для ФЛ изменен алгоритм отбора связанных лиц
13.04/2016 - для показателей 010, 019 вместо части кода показателя "Б"
             будет формироваться значение '9'.
18.03.2016 - на 01.04.2016 будет формироваться новая часть показателя
             "ознака ідентифікаційного коду" (параметр K021 из KOD_K021)
07.09.2015 - если для клиентов участников органов государственной власти
             (ISE=13110,13120,13131,13132) поле OKPO_U не начинается из "D"
             то тогда для таких клиентов будет заполнено "D"||<номер п/п>
07.07.2015 - для KL_K070 добавлено условие "D_CLOSE is null"
17.06.2015 - несущественные изменения
10.06.2015 - для ФЛ нерезидентов участников формировался код IN вместо CC
08.06.2015 - для клиентов участников органов государственной власти
             (ISE=13110,13120,13131,13132) будем формировать код ОКПО
             из поля OKPO_U (для некоторых клиентов будет заполнено
                           "D"||<номер п/п> )
03.06.2015 - для клиентов участников органов государственной власти
             (ISE=13110,13120,13131,13132) будем формировать код ОКПО как
             "D"||<номер п/п>
29.04.2015 - для серии и номера документа учасника выбираем реальное
             значение (добавлена функция trim)
30.10.2014 - для клиентов органов государственной власти (ISE=13110,13120,
             13131,13132) будем формировать код ОКПО как "D"||<номер п/п>
24.10.2014 - для банка резидента показатель 010 формируем значением поля NB
             из RCUKRU и для нерезидентов значением поля NAME из RC_BNK
18.02.2014 - для клиентов ФЛ выбираем MAX из кодов ID_REL in (5,12)
04.10.2013 - для клиентов ФЛ исключил код ID_REL=12 (повязана особа)
             т.к. заполняются одни и те же данные как по коду 01 или 04
             а также и по коду 12 (осталось только ID_REL=5)
             (в некоторых банках сформировались дубли показателей)
16.09.2013 - на 01.10.2013 исключается формирование показателя 221
11.02.2013 - показатели 212, 213 формируются по шаблону 9990D0000
             (с 4-я знаками после точки)
11.10.2012 - в некоторых случаях неправильно определялся тип контрагента
05.09.2012 - для ЮЛ параметр K074_ всегда формировали значение 2.
             Исправлено. Возможны значения 1 или 2.
07.08.2012 - переменную K074_ будем заполнять значением "0" если значение
             K074 в KL_K070 пустое (показатель 221 )
             для ФЛ  и нерезидентов значение K074='0'
24.02.2011 - для контрагентов банков нерезидентов не формируем показатель
             "019"
25.01.2011 - для банка резидента код ОКПО формируем значением поля GLB
             из RCUKRU и для нерезидентов значением поля B010 из RC_BNK
             (у нас поле B010 имеется в CUSTBANK поле ALT_BIC)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_     varchar2(2) := 'D9';
typ_      number;
acc_      Number;
kv_       Number;
ost_      Number;
sum_proc  Number := 20;
mfo_      Varchar2(12);
mfou_     Number;
nbuc1_    Varchar2(12);
nbuc_     Varchar2(12);
nbuc2_    Varchar2(12);
kol_      Number:=0;
kol1_     Number:=0;
kol2_     Number:=0;
kol3_     Number:=0;
rnk_      Number:=0;
rnka_     Number;
rnka_k    Number:=0;
cust_     Number;
codc_     Number;
okpo_     Varchar2(14);
okpo_k    Varchar2(14);
okpo_u    Varchar2(14);
k021_k    Varchar2(1);
k021_u    Varchar2(1);
nmk_      Varchar2(70);
nmk_u_    Varchar2(70);
k040_     Varchar2(3);
obl_      Number;
ser_      Varchar2(15);
numdoc_   Varchar2(20);
ser_k     Varchar2(10);
numdoc_k  Varchar2(20);
fs_       Varchar2(2);
ise_      Varchar2(5);
ved_      Varchar2(5);
k074_     Varchar2(1);
k081_     Varchar2(1);
k110_     Varchar2(5);
k111_     Varchar2(2);
vaga1_    Number(6,2);
vaga2_    Number(6,2);
data_     Date;
kodp_     Varchar2(35);
znap_     Varchar2(70);
userid_   Number;
dd_       varchar2(2);
tk_       Varchar2(1);
cust_type number;
glb_      number;
dat_izm1     date := to_date('31/08/2013','dd/mm/yyyy');
is_foreign_bank     number;
pr_kl_    number;
-----------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
   userid_ := user_id;
   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
   mfo_ := F_Ourmfo();

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

   -- параметры формирования файла
   p_proc_set(kodf_,sheme_,nbuc1_,typ_);

   nbuc2_ := nbuc1_;

   IF nbuc2_ IS NULL THEN
      nbuc2_ := '0';
   END IF;

   -- общий процент участия изменяется с 20% на 10%
   if Dat_ >= to_date('29082008','ddmmyyyy') then
      sum_proc := 10;
   end if;

    for k in (select c.rnk RNK, NVL(c.okpo,'0000000000') OKPO,
                     c.codcagent CODC, c.nmk NMK, NVL(c.ise,'00000') ISE,
                     b.name NMK_U, NVL(trim(b.okpo_u),'0000000000') OKPO_U,
                     nvl(b.custtype_u, '2') TK, -- 1 - юрлицо, 2 - физлицо
                     b.country_u K040,
                     nvl(TO_CHAR (k.KO), b.region_u) OBL,
                     c.date_on DAT,
                     NVL(b.rnkb,0) RNKA, b.rnka RNKB,
                     b.notes NOTES, b.vaga1 VAGA1, b.vaga2 VAGA2,
                     NVL(b.ved_u,'     ') VED_U, NVL(b.fs_u,'00') FS_U,
                     NVL(b.ise_u,'00000') ISE_U,
                     DECODE(b.country_u,804,1,2) REZ,
                     NVL(trim(b.doc_serial),'') SER, NVL(b.doc_number,'000000') NUMDOC,
                     'XXXXX' TAG, '0' VALUE
              from  customer c, cust_bun b, kodobl_reg k
              where c.rnk in (select distinct rnk
                              from otcn_f71_history
                              where datf = Dat_
                                and rnk is not null
                                and p040 <> 0 )
                and b.region_u = to_char(k.C_REG(+))
                and c.rnk = b.rnka
                and c.rnk <> 94809201
                and c.custtype in (1, 2)
                and ( (b.id_rel in (select min(id_rel)
                                    from cust_bun
                                    where rnka = b.rnka
                                      and id_rel in (1, 4)
                                    group by rnka, rnkb, okpo_u, doc_number)
                          and nvl(b.VAGA1, 0) + nvl(b.VAGA2, 0) >= sum_proc) )
                and nvl(b.edate, Dat_) >= Dat_
                and nvl(b.bdate, Dat_) <= Dat_
                and (c.date_off is null or c.date_off > Dat_)
              UNION
              select c.rnk RNK, NVL(c.okpo,'0000000000') OKPO,
                     c.codcagent CODC, c.nmk NMK, NVL(c.ise,'00000') ISE,
                     b.name NMK_U, NVL(trim(b.okpo_u),'0000000000') OKPO_U,
                     b.custtype_u TK, -- 1 - юрлицо, 2 - физлицо
                     b.country_u K040, nvl(TO_CHAR (k.KO), b.region_u) OBL,
                     c.date_on DAT,
                     NVL(b.rnkb,0) RNKA, b.rnka RNKB,
                     b.notes NOTES, b.vaga1 VAGA1, b.vaga2 VAGA2,
                     NVL(b.ved_u,'     ') VED_U, NVL(b.fs_u,'00') FS_U,
                     NVL(b.ise_u,'00000') ISE_U,
                     DECODE(b.country_u,804,1,2) REZ,
                     NVL(trim(b.doc_serial),'') SER, NVL(trim(b.doc_number),'000000') NUMDOC,
                     'XXXXX' TAG, '0' VALUE
              from  customer c, cust_bun b, kodobl_reg k
              where c.rnk in (select distinct rnk
                              from otcn_f71_history
                              where datf = Dat_
                                and rnk is not null
                                and p040 <> 0 )
                and NVL(c.prinsider,99) = 99
                and b.region_u = to_char(k.C_REG(+))
                and c.rnk = b.rnka
                and c.rnk <> 94809201
                and c.custtype = 3
                and b.id_rel in (select max(id_rel)
                                 from cust_bun
                                 where rnka = b.rnka
                                   and id_rel in (5, 12)
                                 group by rnka, rnkb, okpo_u, doc_number)
                and nvl(b.edate, Dat_) >= Dat_
                and nvl(b.bdate, Dat_) <= Dat_
                and (c.date_off is null or c.date_off > Dat_) )

   loop
       nbuc_ := NVL(nbuc1_,'0');

       IF nbuc_ IS NULL THEN
          nbuc_ := '0';
       END IF;

       cust_type := null;
       k040_ := k.k040;
       ser_ := k.ser;
       numdoc_ := k.numdoc;
       nmk_ := k.nmk;
       nmk_u_ := k.nmk_u;
       okpo_u := k.okpo_u;
       okpo_ := '0000000000';

       rnka_ := k.rnka;

       if trim(k.rnka) is null OR k.rnka = 0 then
          rnka_k := rnka_k+1;
          rnka_ := rnka_k;
       end if;

       -- визначаємо чи є учасник клієнтом банку
       BEGIN
          select 1
             into pr_kl_
          from customer 
          where rnk = k.rnka;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          pr_kl_ := 0;
       END;

       BEGIN
          select NVL(k081,' ')
             into k081_
          from kl_k080
          where k080 = k.fs_u;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          k081_ := ' ';
       END;

       BEGIN
          select NVL(k074,'0')
             into k074_
          from kl_k070
          where k070 = k.ise_u
            and d_open <= dat_
            and (d_close is null or d_close > dat_);
       EXCEPTION WHEN NO_DATA_FOUND THEN
          k074_ := '0';
       END;

       -- для банк?в резидент?в
       IF k.codc = 1 then
          BEGIN
             select NVL(rc.glb,0), NVL(rc.nb, nmk_)
                into glb_, nmk_
             from custbank cb, rcukru rc
             where cb.rnk = k.rnk
               and cb.mfo = rc.mfo;

             okpo_k := LPAD( TO_CHAR(glb_), 10, '0');
          EXCEPTION WHEN NO_DATA_FOUND THEN
             okpo_k := '0000000000';  --null;
          END;
          k021_k := '3';
       END IF;

       -- для банк?в нерезидент?в
       IF k.codc = 2 then
          BEGIN
             select NVL(cb.alt_bic,0), NVL(rc.name, nmk_)
                into glb_, nmk_
             from custbank cb, rc_bnk rc
             where cb.rnk = k.rnk
               and trim(cb.alt_bic) = rc.b010;

             okpo_k := LPAD( TO_CHAR(glb_), 10, '0');
          EXCEPTION WHEN NO_DATA_FOUND THEN
             okpo_k := '0000000000'; 
          END;
          k021_k := '4';
       END IF;

       -- для ЮЛ резидентов
       if k.codc = 3 
       then
          -- наличие ИНН(ОКПО)
          if nvl(ltrim(trim(k.okpo), '0'), 'Z') <> 'Z' AND 
             nvl(ltrim(trim(k.okpo), '9'), 'Z') <> 'Z'  
          then
             okpo_k := LPAD (trim(k.okpo), 10, '0');
             k021_k := '1';
             if k.ise in ('13110','13120','13131','13132') then
                k021_k := 'G';
             end if;
          end if;
          -- отсутствие ИНН(ОКПО)
          if nvl(ltrim(trim(k.okpo), '0'), 'Z') = 'Z' OR 
             nvl(ltrim(trim(k.okpo), '9'), 'Z') = 'Z'  
          then
             okpo_k := LPAD (trim(k.rnk), 10, '0');
             k021_k := 'E';
          end if;
       end if;

       -- для ЮЛ нерезидентов
       if k.codc = 4 
       then
          -- наличие ИНН(ОКПО)
          if nvl(ltrim(trim(k.okpo), '0'), 'Z') <> 'Z' AND 
             nvl(ltrim(trim(k.okpo), '9'), 'Z') <> 'Z'  
          then
             okpo_k := LPAD (trim(k.okpo), 10, '0');
             k021_k := '1';
          end if;
          -- отсутствие ИНН(ОКПО)
          if nvl(ltrim(trim(k.okpo), '0'), 'Z') = 'Z' OR 
             nvl(ltrim(trim(k.okpo), '9'), 'Z') = 'Z'  
          then
             okpo_k := 'I' || LPAD (trim(k.rnk), 9, '0');
             k021_k := '9';
          end if;
       end if;

       -- для ФО резидент?в
       IF k.codc = 5 
       then
          -- наличие ИНН(ОКПО)
          if nvl(ltrim(trim(k.okpo), '0'), 'Z') <> 'Z' AND 
             nvl(ltrim(trim(k.okpo), '9'), 'Z') <> 'Z'  
          then
             okpo_k := LPAD (trim(k.okpo), 10, '0');
             k021_k := '2';
          end if;

          -- отсутствие ИНН(ОКПО)
          if nvl(ltrim(trim(k.okpo), '0'), 'Z') = 'Z' OR 
             nvl(ltrim(trim(k.okpo), '9'), 'Z') = 'Z'  
          then
             BEGIN
                select NVL(replace(trim(ser),' ',''),''), NVL(numdoc,'000000')
                   into ser_k, numdoc_k
                from person
                where rnk = k.rnk;

                okpo_k := lpad(substr(ser_k||numdoc_k, 1, 10), 10, '0');
                k021_k := '6';
             EXCEPTION WHEN NO_DATA_FOUND THEN
                okpo_k := lpad(k.rnk, 10, '0');
                k021_k := '9';
             END;
          end if; 
       end if;

       -- для ФО нерезидент?в
       IF k.codc = 6 
       then
          -- наличие ИНН(ОКПО)
          if nvl(ltrim(trim(k.okpo), '0'), 'Z') <> 'Z' AND 
             nvl(ltrim(trim(k.okpo), '9'), 'Z') <> 'Z'  
          then
             okpo_k := LPAD (trim(k.okpo), 10, '0');
             k021_k := '2';
          end if;

          -- отсутствие ИНН(ОКПО)
          if nvl(ltrim(trim(k.okpo), '0'), 'Z') = 'Z' OR 
             nvl(ltrim(trim(k.okpo), '9'), 'Z') = 'Z'  
          then
             BEGIN
                select NVL(replace(trim(ser),' ',''),''), NVL(numdoc,'000000')
                   into ser_k, numdoc_k
                from person
                where rnk = k.rnk;

                okpo_k := 'I' || lpad(substr(ser_k||numdoc_k, 1, 10), 9, '0');
                k021_k := 'B';
             EXCEPTION WHEN NO_DATA_FOUND THEN
                okpo_k := 'I' || lpad(TO_CHAR(k.rnk), 9, '0');
                k021_k := '9';
             END;
          end if; 
       end if;

       -- учасник ЮО
       if k.tk in (1, 3) 
       then
          -- наличие ИНН(ОКПО)
          if  nvl(ltrim(trim(k.okpo_u), '0'), 'Z') <> 'Z' and
              nvl(ltrim(trim(k.okpo_u), '9'), 'Z') <> 'Z'
          then
             if k040_ <> '804' then
                select count(*)
                into is_foreign_bank
                from rc_bnk
                where b010 = trim(k.okpo_u);
             
                if is_foreign_bank <> 0 then
                   okpo_ := lpad(substr(NVL(trim(okpo_u),'0'), 1, 10), 10, '0');
                   k021_u := '4';
                else
                   okpo_ := 'I' || lpad(substr(NVL(trim(okpo_u),'0'), 1, 8), 9, '0');
                   k021_u := '8';
                end if;
             else
                okpo_ := substr(lpad(trim(k.okpo_u), 10, '0'), 1, 10);
                k021_u := '1';
                -- органи державної влади
                if k.ise_u in ('13110','13120','13131','13132') then
                   k021_u := 'G';
                end if;
             end if;
          end if;

          -- отсутствие ИНН(ОКПО)
          if  nvl(ltrim(trim(k.okpo_u), '0'), 'Z') = 'Z' or
              nvl(ltrim(trim(k.okpo_u), '9'), 'Z') = 'Z'
          then
             if k040_ = '804' then
                if pr_kl_ = 1 
                then
                   okpo_ := lpad(to_char(k.rnka), 10, '0');
                   k021_u := '9';
                else
                   okpo_ := lpad(to_char(k.rnka), 10, '0');
                   k021_u := 'E';
                end if;
             else
                if pr_kl_ = 1 
                then
                   okpo_ := 'I' || lpad(to_char(k.rnka), 9, '0');
                   k021_u := 'C';
                else
                   okpo_ := 'I' || lpad(to_char(k.rnka), 9, '0');
                   k021_u := '9';
                end if;
             end if;
          end if; 
       end if; 

       -- учасник ФО
       if k.tk = 2 
       then
          -- наличие ИНН(ОКПО) 
          if  nvl(ltrim(trim(k.okpo_u), '0'), 'Z') <> 'Z' and
              nvl(ltrim(trim(k.okpo_u), '9'), 'Z') <> 'Z'
          then
             if k040_ <> '804' then
                okpo_ := 'I' || lpad(substr(NVL(trim(okpo_u),'0'), 1, 8), 9, '0');
                k021_u := '7';
             else
                okpo_ := substr(lpad(trim(k.okpo_u), 10, '0'), 1, 10);
                k021_u := '2';
             end if;
          end if;

          -- отсутствие ИНН(ОКПО)
          if  nvl(ltrim(trim(k.okpo_u), '0'), 'Z') = 'Z' or
              nvl(ltrim(trim(k.okpo_u), '9'), 'Z') = 'Z'
          then
             if k040_ = '804' then
                if pr_kl_ = 1 
                then
                   okpo_ := lpad(substr(ser_ || numdoc_, 1, 10), 10, '0');
                   okpo_u := ser_ || numdoc_;
                   k021_u := '6';
                else              
                   okpo_ := lpad(to_char(k.rnka), 10, '0');
                   k021_u := 'E';
                end if;
             else
                if pr_kl_ = 1 
                then
                   okpo_ := 'I' || lpad(to_char(k.rnka), 9, '0');
                   k021_u := '8';
                else
                   okpo_ := 'I' || lpad(to_char(k.rnka), 9, '0');
                   k021_u := '9';
                end if;
             end if;
          end if;
       end if;

       if lower(k.nmk) like '%каб_нет%м_н_стр_в%'
       then
          k021_k := 'E';
       end if;

       if lower(k.nmk_u) like '%каб_нет%м_н_стр_в%'
       then
          k021_u := 'E';
       end if;

       if cust_type is not null then
          cust_ := cust_type;
       end if;

       if k.tk = 1 then
          cust_ := 2;
       else
          cust_ := 1;
       end if;

       if k040_ <> '804' or cust_ = 1 then
          k074_ := '0';
       end if;

-- код 010
      kodp_ := '010'||lpad(okpo_k,10,'0')||'0000000000'||k021_k||'9'||'000000'||lpad(to_char(k.rnkb),4,'0');
      znap_ := nmk_;  --k.nmk;

      insert into bars.rnbu_trace
      (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
      ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);

-- код 205
      kodp_ := '205'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
               lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
      znap_:=nmk_u_;

      insert into bars.rnbu_trace
      (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
      ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);

-- код 206
      kodp_ := '206'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
      	       lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
      znap_ := to_char(cust_);

      insert into bars.rnbu_trace
      (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
      ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);

-- код 250
      kodp_ := '250'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
               lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
      znap_ := lpad(k040_,3,'0');

      insert into bars.rnbu_trace
      (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
      ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);

-- код 255
      kodp_ := '255'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
               lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
      if k040_ != '804' then
         znap_ := '00';
      else
         znap_ := to_char(k.obl);
      end if;

      insert into bars.rnbu_trace
      (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
      ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);

      if dat_ < to_date('31082007','ddmmyyyy') then
         -- код 220
         kodp_ := '220'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
                  lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
         znap_ := k081_;
      else
         -- код 221
         kodp_ := '221'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
                  lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
         znap_ := k074_;
      end if;
      -- исключается на 01.10.2013
      if dat_ < dat_izm1 then
         insert into bars.rnbu_trace
         (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
         ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);
      end if;

-- код 225
      kodp_ := '225'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
               lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
      znap_ := k.ved_u;

      insert into bars.rnbu_trace
      (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
      ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);

-- код 212
      kodp_ := '212'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
               lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
      if k.vaga1 = 0 then
         znap_ := to_char(k.vaga1);
      else
         znap_ := trim(to_char(k.vaga1,'9990D0000'));
      end if;

      if trim(znap_) is not null then
         insert into bars.rnbu_trace
         (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
         ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);
      end if;

-- код 213
      kodp_ := '213'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
               lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
      if k.vaga2 = 0 then
         znap_ := to_char(k.vaga2);
      else
         znap_ := trim(to_char(k.vaga2,'9990D0000'));
      end if;

      if trim(znap_) is not null then
         insert into bars.rnbu_trace
         (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
         ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);
      end if;

      if k.codc in (4,6) and 
         nvl(ltrim(trim(k.okpo), '0'), 'Z') <> 'Z' and
         nvl(ltrim(trim(k.okpo), '9'), 'Z') <> 'Z' and
         length(trim(k.okpo))>8 
      then

         kodp_ := '019'||lpad(okpo_k,10,'0')||'0000000000'||k021_k||'9'||'000000'||lpad(to_char(k.rnkb),4,'0');
         znap_ := trim(k.okpo);

         insert into bars.rnbu_trace
         (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
         ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);

      end if;

      if k040_<>'804' and length(trim(okpo_u))>8 then

         kodp_ := '219'||lpad(okpo_k,10,'0')||lpad(okpo_,10,'0')||k021_k||k021_u||
      		  lpad(to_char(rnka_),6,'0')||lpad(to_char(k.rnkb),4,'0');
         znap_ := trim(okpo_u);

         insert into bars.rnbu_trace
         (nls, kv, odate, kodp, znap, nbuc, rnk) VALUES
         ('00000', 980, k.dat, kodp_, znap_, nbuc_, k.rnk);

      end if;
   end loop;
  ---------------------------------------------------
   DELETE FROM tmp_nbu where kodf = kodf_ and datf = dat_;
   ---------------------------------------------------
   for k in (select kodp, znap, nbuc from rnbu_trace)
   loop
       select count(*) into kol1_
       from tmp_nbu
       where kodf = kodf_ and
             datf = dat_ and
            substr(kodp,1,25) = substr(k.kodp,1,25);

       if kol1_ = 0 then
          INSERT INTO tmp_nbu (kodp, datf, kodf, nbuc, znap) VALUES
                              (k.kodp, dat_, kodf_, k.nbuc, k.znap);
       end if;
   end loop;
  ----------------------------------------
END p_fd9_NN;
/