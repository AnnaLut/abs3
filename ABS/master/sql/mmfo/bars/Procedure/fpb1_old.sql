

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FPB1_OLD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FPB1_OLD ***

  CREATE OR REPLACE PROCEDURE BARS.FPB1_OLD (BAKOD1_ varchar2, GGGGMM varchar2 ) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования файла PB_1 (табл. PB_1)
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 20/11/2015 (18/11/2015, 01/10/2015, 23/09/2015)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--             ПРОЦЕДУРА ВЫПОЛНЕНА ПОД НОВЫЕ КОДЫ КЛ-РА BOPCODE
--             КОТОРЫЕ БЫЛИ ПЕРЕДАНЫ ИЗ ДЕПАРТАМЕНТА 18.07.2011            
--             для Укрпошты должны быть добавлены новые коды 8446022,8446023
--             вместо 8446014, 8446015

--20.11.2015   для декларирования ПОСЛУГ в сумме 20 000 00 $ и больше
--             добавлен весь перечень 4-х значных кодов назначения
--             (замечание ГОУ СБ)
--18.11.2015   дополнительно для декларирования будем использовать таблицу 
--             CIM_1PB_RU_DOC 
--01.10.2015   добавлено заполнение KOD_N = 8445002 для проводок 
--             Дт 1002 Кт 1911 (OB22='00','01') (отримання підкріплення) 
--             добавлено заполнение KOD_N = 8446008 для проводок 
--             Дт 2600,2604 Кт 100* (видача ЧЕКУ) 
--             добавлены переводы Золота корона 2809(OB22=36), 2909(OB22=79)
--23.09.2015   добавлено заполнение KOD_N = 8446002 для проводок 
--             Дт 2909 (OB22='12') Кт 100* (видача недоплати) 
--06.01.2015   добавлено оброботку доп.параметра "F1" откуда определяем 
--             код страны
--12.02.2014   добавлено заполнение нового перевода Анелик 
--             2809(35), 2909(76)            
--05.02.2014   в операциях M37,MMV,CN3,CN4 кроме доп.реквизитов D_1PB, D_REF 
--             будем обрабатывать доп.реквизиты DATT (дата перевода), 
--             REFT (референс перевода) т.к. в некотрых РУ для операций 
--             CN3, CN4 существуют эти доп.реквизиты
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
 nn_     int;
 dat1_   date;
 dat2_   date;

 S1_     number;
 S2_     number;
 S3_     number;
 S4_     number;

 BANK_   char(4);
 KOD7_   varchar2(7);
 kod1_   varchar2(7);

 COUN_   char(3);
 kod_g_  Varchar2(3);
 kod_g_pb1  Varchar2(3);
 SQ_     number;
 OPER_   varchar2(110);
 OPER_99 varchar2 (110);
 S840_   number;
 DEN_    int;
 MEC_    int;
 GOD_    int;
 KOD_    char(4);
 KOD2_   char(4);

 KL_     char(2);

 asp_K_  varchar2(14);
 asp_N_  varchar2(38);
 asp_S_  char(1);

 DECL_   varchar2(110);
 sm_     char(1);
 sNBSk_  char(2);
 ACC_    int;
 mfo_g   number;
 mfou_   number;
 kor_    varchar2(4);
 ob22_   varchar2(2);
 nlsd_   varchar2(3);
 rezid_  number;
 rezid_o varchar2(1); 

 tt_     varchar2(3);
 tt1_    varchar2(3);
 nlsd1_  varchar2(15);
 accd1_  number;
 nlsk1_  varchar2(15);
 acck1_  number;
 pr_ob75 number;
 dat_m37 date;
 dat_mmv date;
 ref_m37 number;
 ref_mmv number; 
 bank_pb1  varchar2 (4);
 
BEGIN
   commit;

   EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
   -------------------------------------------------------------------
   logger.info ('FPB1: Begin for '||BAKOD1_ || ' ' || GGGGMM);
   -------------------------------------------------------------------
   
   -- свой МФО
   mfo_g := f_ourmfo ();

-- МФО "родителя"
   BEGIN
      SELECT mfou
        INTO mfou_
      FROM BANKS
     WHERE mfo = mfo_g;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
      mfou_ := mfo_g;
   END;

   SELECT min(fdat), max(fdat)  
      INTO Dat1_, Dat2_ 
   FROM fdat
   WHERE  to_char(fdat,'YYYYMM')= GGGGMM;

   IF mfou_ = 300465 and mfou_ != mfo_g THEN    --322498 THEN 
      nlsd_ := '100';

      for k in (select p.ref ref
                  from provodki_otc p 
                  where p.fdat BETWEEN Dat1_ and Dat2_ 
                    and p.kv<>980 
                    and (p.nlsd LIKE nlsd_||'%' OR p.nlsk LIKE nlsd_||'%') )
       loop
          BEGIN
             insert into operw (ref, tag, value) values 
                               (k.ref, 'KOD_N', '0000000');
          EXCEPTION WHEN OTHERS THEN 
             NULL;
          END;

          kod_g_ := null;
          kod_g_pb1 := null;

          for z in (select * from operw where ref=k.ref)
          loop
            -- с 01.08.2012 добавляется код страны отправителя или получателя перевода
            if z.tag like 'n%' and substr(trim(z.value),1,1) in ('O','P','О','П') then
               kod_g_ := substr(trim(z.value),2,3);
            end if;
                
            if kod_g_ is null and z.tag like 'n%' and substr(trim(z.value),1,1) not in ('O','P','О','П') then
               kod_g_ := substr(trim(z.value),1,3);
            end if;

            if kod_g_ is null and z.tag like 'D6#70%' and substr(trim(z.value),1,1) in ('O','P','О','П') then
               kod_g_ := substr(trim(z.value),2,3);
            end if;

            if kod_g_ is null and z.tag like 'D6#70%' and substr(trim(z.value),1,1) not in ('O','P','О','П') then
               kod_g_ := substr(trim(z.value),1,3);
            end if;

            if kod_g_ is null and z.tag like 'D6#E2%' and substr(trim(z.value),1,1) in ('O','P','О','П') then
               kod_g_ := substr(trim(z.value),2,3);
            end if;

            if kod_g_ is null and z.tag like 'D6#E2%' and substr(trim(z.value),1,1) not in ('O','P','О','П') then
               kod_g_ := substr(trim(z.value),1,3);
            end if;

            if kod_g_ is null and z.tag like 'D1#E9%' and substr(trim(z.value),1,1) in ('O','P','О','П') then
               kod_g_ := substr(trim(z.value),2,3);
            end if;

            if kod_g_ is null and z.tag like 'D1#E9%' and substr(trim(z.value),1,1) not in ('O','P','О','П') then
               kod_g_ := substr(trim(z.value),1,3);
            end if;

            if kod_g_ is null and z.tag like 'F1%' then
               kod_g_ := substr(trim(z.value),8,3);
            end if;

            if kod_g_ is null and z.tag='KOD_G' 
            then    
               kod_g_pb1 := substr(trim(z.value),1,3);
            end if;
          end loop;

          if kod_g_ is null and kod_g_pb1 is not null then 
            kod_g_ := kod_g_pb1;
          end if;
          
          BEGIN
             insert into operw (ref, tag, value) values 
                              (k.ref, 'KOD_G', kod_g_);
          EXCEPTION WHEN OTHERS THEN 
             update operw a set a.value=kod_g_ 
             where a.tag='KOD_G' 
               and a.ref=k.ref;
          END;

          BEGIN
             insert into operw (ref, tag, value) values 
                               (k.ref, 'KOD_B', '000');
          EXCEPTION WHEN OTHERS THEN 
             NULL;
          END;

          update operw a set a.value='804' 
          where a.tag='KOD_G' 
            and (trim(a.value) is null OR trim(a.value)='000') 
            and a.ref=k.ref;

          update operw a set a.value='4' 
          where a.tag='KOD_B' 
            and (trim(a.value) is null OR trim(a.value)='000' OR trim(a.value)='25') 
            and a.ref=k.ref;
       end loop;

       for k in (select p.pdat pdat, p.fdat fdat, p.ref ref, p.tt tt, 
                         p.accd accd, p.nam_a name_a, p.nlsd nlsd, 
                         p.kv kv, p.acck acck, p.nam_b name_b, p.nlsk nlsk, 
                         p.nazn nazn, p.ptt tt1
                   from provodki_otc p
                   where p.fdat BETWEEN Dat1_ and Dat2_ 
                     and p.kv<>980 
                     and (p.nlsd LIKE nlsd_||'%' OR p.nlsk LIKE nlsd_||'%')
                   order by 1,2,3
                 )
       loop
          begin 
             select substr(trim(value),1,1) 
                into rezid_o 
             from operw 
             where ref=k.ref 
               and tag like 'REZID%';
          EXCEPTION WHEN NO_DATA_FOUND THEN
             rezid_o := '1';
          end;
     
          rezid_ := 1;

          if k.nlsd not like '100%' then
             BEGIN
                select NVL(trim(i.ob22),'00'), 2-mod(c.codcagent,2) 
                   into ob22_, rezid_ 
                from specparam_int i, accounts a, customer c
                where i.acc=k.accd 
                  and i.acc=a.acc 
                  and a.rnk=c.rnk;
             EXCEPTION WHEN NO_DATA_FOUND THEN
                ob22_ := '00';
                rezid_ := 1;
             END;
          else
             BEGIN 
                select NVL(trim(i.ob22),'00'), 2-mod(c.codcagent,2) 
                   into ob22_, rezid_  
                from specparam_int i, accounts a, customer c 
                where i.acc=k.acck
                  and i.acc=a.acc 
                  and a.rnk=c.rnk;
             EXCEPTION WHEN NO_DATA_FOUND THEN
                ob22_ := '00';
                rezid_ := 1;
             END;
          end if;

          nlsd1_ := k.nlsd;
          nlsk1_ := k.nlsk;
          tt_ := null;
          pr_ob75 := 0;
          -- 02.01.2013 по счету 2909 и OB22='75' будем формировать код 8428001 
          -- кошти для виплати за системними переказами фiзичних осiб в iноземнiй валютi
          if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and ob22_ in ('75') then 
             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;     

          -- видано на вiдрядження
          if k.nlsd LIKE '2600%' 
             and k.name_a not like '%'||UPPER('Укрпошт')||'%'
             and k.name_a not like '%УДППЗ%' 
             and k.nlsk LIKE '100%' 
             and UPPER(k.nazn) not like '%'||UPPER('Укрпошт')||'%' then

             update operw a set a.value='2312002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value) = '0000000')  --<>'2312002') 
               and a.ref=k.ref;
          end if;

          -- повернення вiдрядження
          if k.nlsd LIKE '100%' 
             and k.nlsk LIKE '2600%' 
             and k.name_b not like '%'||UPPER('Укрпошт')||'%'
             and k.name_b not like '%УДППЗ%'
             and UPPER(k.nazn) not like '%'||UPPER('Укрпошт')||'%' then

             update operw a set a.value='2312003' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value) = '0000000')  --<>'2312003') 
               and a.ref=k.ref;
          end if;

          -- видано з рах.юр.осiб (Укрпошта)
          if k.nlsd LIKE '2600%' and
             k.nlsk LIKE '100%' and
             (k.name_a like '%'||UPPER('Укрпошт')||'%' OR 
              k.name_a like '%УДППЗ%' OR 
              UPPER(k.nazn) like '%'||UPPER('Укрпошт')||'%') 
          then

             update operw a set a.value='8446023' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value) = '0000000')  --<>'8446023') 
               and a.ref=k.ref;
          end if;

          -- прийнято на рах.юр.осiб (Укрпошта)
          if k.nlsd LIKE '100%' 
             and k.nlsk LIKE '2600%' 
             and (k.name_b like '%'||UPPER('Укрпошт')||'%' OR k.name_b like UPPER('Укрпошт')||'%' OR
                  UPPER(k.nazn) like '%'||UPPER('Укрпошт')||'%') then

             update operw a set a.value='8446022' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446022') 
               and a.ref=k.ref;
          end if;

          -- видано підкріплень (Укрпошта)
          if k.nlsd LIKE '2600%' and
             k.nlsk LIKE '100%' and
             ( k.name_a like '%'||UPPER('Укрпошт')||'%' OR 
               k.name_a like '%УДППЗ%' OR 
               LOWER(k.nazn) like '%видача п_дкр_плень п_дприємствами поштового%' 
             )
          then

             update operw a set a.value='8446018' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value) = '0000000')  --<>'8446018') 
               and a.ref=k.ref;
          end if;

          -- видача по чеку інвалюти
          if substr(k.nlsd,1,4) in ('2600','2604') and
             k.nlsk LIKE '100%' and
             k.tt in ('065','067','00H','00F')
          then

             update operw a set a.value='8446008' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446008') 
               and a.ref=k.ref;

             update operw a set a.value='804' 
             where a.tag='KOD_G' 
               and (trim(a.value) is null OR trim(a.value)<>'804') 
               and a.ref=k.ref;

             update operw a set a.value='4' 
             where a.tag='KOD_B' 
               and (trim(a.value) is null OR trim(a.value)<>'4') 
               and a.ref=k.ref;

          end if;

          -- прийнято на рах.юр.осiб 
          if k.nlsd LIKE '100%' and 
             substr(k.nlsk,1,4) in ('2600','2603','2604') and 
             LOWER(k.nazn) like '%внесення гот_вки на рахунки юо%' 
          then

             update operw a set a.value='8446017' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value) <> '8446017')   
               and a.ref=k.ref;
          end if;

          -- купiвля валюти
          if k.nlsd LIKE '100%' and k.nlsk LIKE '3800%' and 
             ob22_ in ('07','10') and k.tt=k.tt1 then

             update operw a set a.value='2343001' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'2343001') 
               and a.ref=k.ref;
          end if;

          -- Викуп нерозмiнного залишку
          if k.nlsd LIKE '100%' and k.nlsk LIKE '3800%' and ob22_='03' and k.tt=k.tt1 
             and (LOWER(k.nazn) like '%викуп нер_зм_нного залишку%' OR
                  LOWER(k.nazn) like '%викуп нер_зм_нно_ частини%') 
          then
        
             update operw a set a.value='2343001' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'2343001') 
               and a.ref=k.ref;
          end if;

          -- Оприбуткування надлишків
          if k.nlsd LIKE '100%' and k.nlsk LIKE '3800%' and ob22_='03' 
             and k.tt=k.tt1 
             and LOWER(k.nazn) like '%оприбуткування надлишк_в%' 
          then
        
             update operw a set a.value='8446012' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446012') 
               and a.ref=k.ref;
          end if;

          -- видано з рах. нерезидентiв 
          if k.nlsd LIKE '2620%' and k.nlsk LIKE '100%' and ob22_='05' then

             update operw a set a.value='8427002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8427002') 
               and a.ref=k.ref;
          end if;

          -- прийнято на з рах. нерезидентiв 
          if k.nlsd LIKE '100%' and k.nlsk LIKE '2620%' and ob22_='05' then

             update operw a set a.value='8427001' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8427001') 
               and a.ref=k.ref;
          end if;

          -- iншi казначейськi зобовязання 
          if k.nlsd LIKE '100%' and k.nlsk LIKE '2901%' and ob22_='13' then

             update operw a set a.value='8446022' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446022') 
               and a.ref=k.ref;

          end if;

          -- виплачено iншi казначейськi зобовязання 
          if k.nlsd LIKE '2901%' and ob22_='13' and k.nlsk LIKE '100%' then

             update operw a set a.value='8446023' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446023') 
               and a.ref=k.ref;

          end if;

          -- виплачено iншi казначейськi зобовязання 
          if k.nlsd LIKE '2801%' and ob22_ in ('02','03','04') and k.nlsk LIKE '100%' then

             update operw a set a.value='8446023' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446023') 
               and a.ref=k.ref;

          end if;
                     
          -- прийнято готiвку за переказом WU
          if k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and ob22_='27' then 

             update operw a set a.value='8428001' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428001') 
               and a.ref=k.ref;
          end if;

          -- видано готiвку за переказом WU
          if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and ob22_='27' then 

             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;

          -- видано готiвку за переказом WU
          if nlsd1_ LIKE '2809%' and nlsk1_ LIKE '100%' and 
             ob22_='15' and (k.tt=k.tt1 or tt_ is not null) then 

             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
              and a.ref=k.ref;
          end if;
                    
          -- прийнято готiвку за переказом BLIZKO
          if k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and ob22_='58' then 
             update operw a set a.value='8428001'  --'8428006' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428001') 
               and a.ref=k.ref;
          end if;

          -- видано готiвку за звичайним переказом BLIZKO
          if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and ob22_='58' then 
             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;

          -- видано готiвку за переказом BLIZKO
          if nlsd1_ LIKE '2809%' and nlsk1_ LIKE '100%' and 
             ob22_='23' and (k.tt=k.tt1 or tt_ is not  null) then 

             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;

          -- прийнято готiвку за переказом MIGOM
          if k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and ob22_='40' then 
             update operw a set a.value='8428001'  --'8428005' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428001') 
               and a.ref=k.ref;
          end if;

          -- видано готiвку за переказом MIGOM
          if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and 
             ob22_='40' then 

             update operw a set a.value='8428002'  --'8428004' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;

          -- прийнято готiвку за переказом Xpress Money (XM)
          if k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and ob22_='41' then 
             update operw a set a.value='8428001' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428001') 
               and a.ref=k.ref;
          end if;

          -- видано готiвку за переказом Xpress Money (XM)
          if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and 
             ob22_='41' then 

             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;

          -- прийнято готывку за перказом MIGOM
          if k.nlsd LIKE '100%' and k.nlsk LIKE '2809%' and 
             ob22_='17' and k.tt=k.tt1 then 

             update operw a set a.value='8428001' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428001') 
               and a.ref=k.ref;
          end if;
         
          -- видано готівку за переказом MIGOM
          if nlsd1_ LIKE '2809%' and nlsk1_ LIKE '100%' and 
             ob22_='17' and (k.tt=k.tt1 or tt_ is not null) then 

             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;

          -- прийнято готiвку за переказом TRAVELEX(COINSTAR)
          if k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and ob22_='46' then 
             update operw a set a.value='8428001' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428001') 
               and a.ref=k.ref;
          end if;

          -- видано готiвку за переказом TRAVELEX(COINSTAR)
          if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and ob22_='46' then 
             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;
                     
          -- видано готiвку за переказом TRAVELEX(COINSTAR)
          if nlsd1_ LIKE '2809%' and nlsk1_ LIKE '100%' and 
             ob22_='20' and (k.tt=k.tt1 or tt_ is not null) then 

             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;

          -- видано готiвку за переказом Xpress Money (XM)
          if nlsd1_ LIKE '2809%' and nlsk1_ LIKE '100%' and 
             ob22_='18' and (k.tt=k.tt1 or tt_ is not null) then 

             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;

          -- видано готiвку за переказом INTER EXPRES
          if nlsd1_ LIKE '2809%' and nlsk1_ LIKE '100%' and 
             ob22_='19' and (k.tt=k.tt1 or tt_ is not null) then 

             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;
                    
          -- видано готiвку за переказом Money Gram
          if nlsd1_ LIKE '2809%' and nlsk1_ LIKE '100%' and 
             ob22_='30' and (k.tt=k.tt1 or tt_ is not null) then 

             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;

          -- видано готiвку за переказом Лидер+Хазри+ИНТЕЛЄКСПРЕСС+Глобал Мані
          -- 12.02.2014 видано готiвку за переказом Анелик OB22='35'
          if nlsd1_ LIKE '2809%' and nlsk1_ LIKE '100%' and 
             ob22_ in ('32','33','34','31','35') and (k.tt=k.tt1 or tt_ is not null) then 

             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if; 

          -- прийнято готiвку за переказом Лидер+Хазри+ИНТЕЛЄКСПРЕСС+RIA+Глобал Мані
          -- 12.02.2014 прийнято готiвку за переказом Анелик OB22='35'
          -- 01.10.2015 прийнято готiвку за переказом Золота корона OB22='36'
          if k.nlsd LIKE '100%' and k.nlsk LIKE '2809%' and 
             ob22_ in ('32','33','34','28','31','35','36') and k.tt=k.tt1 then 

             update operw a set a.value='8428001' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428001') 
               and a.ref=k.ref;
          end if; 

          -- видано готiвку за переказом RIA
          if nlsd1_ LIKE '2809%' and nlsk1_ LIKE '100%' and 
             ob22_='28' and (k.tt=k.tt1 or tt_ is not null) then 

             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;
          
          -- видано готiвку за переказом INTER EXPRES
          if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and 
             ob22_='42' and k.tt=k.tt1 then 

             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;
                      
          -- видано готiвку за переказом VIGO
          if nlsd1_ LIKE '2809%' and nlsk1_ LIKE '100%' and 
             ob22_='16' and (k.tt=k.tt1 or tt_ is not null) then 

             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;

          -- прийнято готiвку за переказом INTER EXPRES
          if k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and 
             ob22_='42' and k.tt=k.tt1 then 

             update operw a set a.value='8428001' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428001') 
               and a.ref=k.ref;
          end if;

          -- прийнято готiвку за переказом Швидка копiйка+Контакт
          if k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and ob22_ in ('60','64') then 
             update operw a set a.value='8428001' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428001') 
               and a.ref=k.ref;
          end if;

          -- прийнято готiвку за переказом UNISTREAM, Золота корона (OB22=79)
          if k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and 
             ob22_ in ('69','79') 
          then 
             update operw a set a.value='8428001' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428001') 
               and a.ref=k.ref;
          end if;

          -- видано готiвку за переказом Швидка копiйка+Контакт
          if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and ob22_ in ('60','64') 
          then 
             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;

          -- видано готiвку за переказом UNISTREAM+Золота корона
          if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and ob22_ in ('69','79') 
          then 
             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;

          -- видано готiвку за переказом (24 - Швидка копійка, 27 - Контакт)
          if nlsd1_ LIKE '2809%' and nlsk1_ LIKE '100%' and 
             ob22_ in ('24','27') and (k.tt=k.tt1 or tt_ is not null) then 

             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;

          -- видано готiвку за переказом UNISTREAM, Золота корона (36)
          if nlsd1_ LIKE '2809%' and nlsk1_ LIKE '100%' and 
             ob22_ in ('29','36') and (k.tt=k.tt1 or tt_ is not null) then 

             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;     

          -- прийнято готiвку за переказом Money Gram
          if k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and ob22_ in ('70') then 
             update operw a set a.value='8428001' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428001') 
               and a.ref=k.ref;
          end if;

          -- видано готiвку за переказом Money Gram
          if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and 
             ob22_ in ('70') and k.tt=k.tt1 then 

             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;     

          -- прийнято готiвку за переказом Лидер+Хазри+ИНТЕЛЄКСПРЕСС+RIA+VIGO OB22='75'
          -- 12.02.2014 прийнято готiвку за переказом Анелик OB22='76'
          if k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and ob22_ in ('72','73','74','75','65','31','76') then 
             update operw a set a.value='8428001' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428001') 
               and a.ref=k.ref;
          end if;

          -- видано готiвку за переказом Лидер+Хазри+ИНТЕЛЄКСПРЕСС+RIA+VIGO
          -- 03.12.2012 по счету 2909 и OB22='19' будем формировать код 8428001
          -- 02.01.2013 по счету 2909 и OB22='75' будем формировать код 8428001
          -- 12.02.2014 по счету 2909 и OB22='76' (Анелик) будем формировать код 8428001
          if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and 
             ob22_ in ('19','72','73','74','65','31','76') and k.tt=k.tt1 then 

             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
               and a.ref=k.ref;
          end if;     

          -- 02.01.2013 по счету 2909 и OB22='75' будем формировать код 8428001 
          -- кошти для виплати за системними переказами фiзичних осiб в iноземнiй валютi
          if pr_ob75=0 and k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and ob22_ in ('75') then 
             update operw a set a.value='8428002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8428002') 
              and a.ref=k.ref;
          end if;     

          -- продаж валюти
          if k.nlsd LIKE '3800%' and k.nlsk LIKE '100%' and 
             ob22_ in ('07','10') then 

             update operw a set a.value='2344001' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'2344001') 
               and a.ref=k.ref;
          end if;

          if k.tt='МГР' and 
             (LOWER(k.nazn) like 'видан%' or LOWER(k.nazn) like 'передан%') and 
             k.nlsd LIKE '3800%' and k.nlsk LIKE '100%' and 
             ob22_ in ('07','10') then 

             update operw a set a.value='8446012' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446012') 
               and a.ref=k.ref;
          end if;

          if k.tt not in ('МГР') and 
             (LOWER(k.nazn) like 'видан%' OR 
              LOWER(k.nazn) like 'передан%' OR  
              LOWER(k.nazn) like 'п_дкр_плення%' OR 
              LOWER(k.nazn) like 'видан_%' OR 
              LOWER(k.nazn) like 'в_везення%' OR
              LOWER(k.nazn) like 'вид. _нв%'  OR
              LOWER(k.nazn) like 'п_дкр_пл.%') and 
             k.nlsd LIKE '3800%' and k.nlsk LIKE '100%' and 
             ob22_ in ('03','07','10') then 

             update operw a set a.value='8446012' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446012') 
               and a.ref=k.ref;
          end if;                 

          -- куплено IВ у iншого банку-резидента 
          if k.nlsd LIKE '100%' and k.nlsk LIKE '1811%' then

             update operw a set a.value='8445002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8445002') 
               and a.ref=k.ref;
          end if;

          -- куплено IВ у iншого банку-резидента 
          if k.nlsd LIKE '100%' and k.nlsk LIKE '2809%' and 
             ob22_ in ('13') then

             update operw a set a.value='8445002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8445002') 
               and a.ref=k.ref;
          end if;
                     
          -- продано IВ iншому банку-резиденту 
          if k.nlsd LIKE '1811%' and k.nlsk LIKE '100%' then

             update operw a set a.value='8445001' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8445001') 
               and a.ref=k.ref;
          end if;

          if k.nlsd LIKE '1911%' and k.nlsk LIKE '100%' and ob22_ in ('00','01') then

             update operw a set a.value='8445001' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8445001') 
               and a.ref=k.ref;
          end if;
                     
          if k.nlsd LIKE '100%' and k.nlsk LIKE '1911%' and ob22_ in ('00','01') then
    
             update operw a set a.value='8445002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8445002') 
               and a.ref=k.ref;

             update operw a set a.value='804' 
             where a.tag='KOD_G' 
               and (trim(a.value) is null OR trim(a.value)<>'804') 
               and a.ref=k.ref;
          end if;

          -- зарахування на вклад 
          if  k.nlsd LIKE '100%' and substr(k.nlsk,1,4) IN ('2620', '2625', 
                                                            '2630', '2635') then

             if rezid_o = 1 then
                update operw a set a.value='8446001' 
                where a.tag='KOD_N' 
                 and (trim(a.value) is null OR trim(a.value)<>'8446001') 
                 and a.ref=k.ref;
             else
                update operw a set a.value='8427001' 
                where a.tag='KOD_N' 
                 and (trim(a.value) is null OR trim(a.value)<>'8427001') 
                 and a.ref=k.ref;
             end if;
             
          end if;
                 
          if k.nlsd LIKE '100%' and k.nlsk LIKE '2809%' and 
             ob22_ in ('09') and LOWER(k.nazn) like '%вкладные операции%' 
          then
             update operw a set a.value='8446001' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446001') 
              and a.ref=k.ref;

              if rezid_o ='2' then
                update operw a set a.value='8427001' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8427001') 
                  and a.ref=k.ref;
             end if;

          end if;

          if k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and 
             ob22_ in ('18') and LOWER(k.nazn) like '%поповнення депоз%' 
          then
             update operw a set a.value='8446001' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446001') 
              and a.ref=k.ref;

              if rezid_o ='2' then
                update operw a set a.value='8427001' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8427001') 
                  and a.ref=k.ref;
             end if;

          end if;

          -- видача зi вкладу 
          if substr(k.nlsd,1,4) IN ('2620', '2625', '2630', '2635', '3500') and 
             k.nlsk LIKE '100%' then 
             if rezid_o = 1 then 
                update operw a set a.value='8446002' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8446002') 
                  and a.ref=k.ref;
             else 
                update operw a set a.value='8427002' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8427002') 
                  and a.ref=k.ref;
             end if;
          end if;

          if nlsd1_ LIKE '2809%' and nlsk1_ LIKE '100%' and 
             ob22_ in ('09') then 
             update operw a set a.value='8446002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446002') 
              and a.ref=k.ref;

             if rezid_o ='2' then
                update operw a set a.value='8427004' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8427004') 
                  and a.ref=k.ref;
             end if;

          end if;

          if nlsd1_ LIKE '2909%' and nlsk1_ LIKE '100%' and 
             ob22_ in ('12') then 
             update operw a set a.value='8446002' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446002') 
              and a.ref=k.ref;

             if rezid_o ='2' then
                update operw a set a.value='8427004' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8427004') 
                  and a.ref=k.ref;
             end if;

          end if;

          -- прийнято готiвку за звичайним переказом 
          if k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and ob22_='35' then 
             update operw a set a.value='8446003' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446003') 
               and a.ref=k.ref;

             if rezid_o ='2' then
                update operw a set a.value='8427003' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8427003') 
                  and a.ref=k.ref;
             end if;
          end if;
                       
          -- видано готiвку за звичайним переказом 
          if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and 
             ob22_ in ('11','24','35','55','56') then 

             update operw a set a.value='8446004' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446004') 
               and a.ref=k.ref;

             if rezid_o ='2' then
                update operw a set a.value='8427004' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8427004') 
                  and a.ref=k.ref;
             end if;

          end if;

          -- прийнято готiвку за звичайним переказом 
          if k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and 
             ob22_ in ('11','24','35','55','56') then 

             update operw a set a.value='8446003' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446003') 
               and a.ref=k.ref;

             if rezid_o ='2' then
                update operw a set a.value='8427003' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8427003') 
                  and a.ref=k.ref;
             end if;
          end if;
                 
          -- прийнято на карт.рах-2924 
          if k.nlsd LIKE '100%' and substr(k.nlsk,1,4) in ('2924','2625') then 

             update operw a set a.value='8446005' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446005') 
               and a.ref=k.ref;

             if rezid_o ='2' then
                update operw a set a.value='8427005' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8427005') 
                  and a.ref=k.ref;
             end if;
          end if;
                     
          -- видано з карт.рах-2924 
          if substr(k.nlsd,1,4) in ('2924','2625') and k.nlsk LIKE '100%' then 

             update operw a set a.value='8446006' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446006') 
               and a.ref=k.ref;

             if rezid_o ='2' then
                update operw a set a.value='8427006' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8427006') 
                  and a.ref=k.ref;
             end if;
          end if;
                     
          -- внутрiшньосистемнi операцii
          if k.nlsd LIKE '100%' and substr(k.nlsk,1,4) IN ('1001','1002','1003',
                                                           '1007','3906','3907') 
          then  

             update operw a set a.value='8446012' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null or trim(a.value)<>'8446012') 
               and a.ref=k.ref;
          end if;

          if substr(k.nlsd,1,4) IN ('1001','1002','1003','1007','3906','3907') and 
             k.nlsk LIKE '100%' then 

             update operw a set a.value='8446012' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null or trim(a.value)<>'8446012') 
               and a.ref=k.ref;
          end if;
                     
          -- прийнято за чеки 
          if k.nlsd LIKE '100%' and k.nlsk LIKE '1919%' and ob22_='01' then 
     
             update operw a set a.value='8446007' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446007') 
               and a.ref=k.ref;

             if rezid_o ='2' then
                update operw a set a.value='8427007' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8427007') 
                  and a.ref=k.ref;
             end if;

          end if;

          if k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and ob22_='36' then 
     
             update operw a set a.value='8446007' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446007') 
               and a.ref=k.ref;

             if rezid_o ='2' then
                update operw a set a.value='8427007' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8427007') 
                  and a.ref=k.ref;
             end if;

          end if;
                      
          -- оплачено дорожнi чеки 
          if k.nlsd LIKE '1819%' and k.nlsk LIKE '100%' and ob22_='01' then 

             update operw a set a.value='8446008' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446008') 
               and a.ref=k.ref;

             if rezid_o ='2' then
                update operw a set a.value='8427008' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8427008') 
                  and a.ref=k.ref;
             end if;

          end if;

          if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and ob22_='36' then 

             update operw a set a.value='8446008' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446008') 
               and a.ref=k.ref;

             if rezid_o ='2' then
                update operw a set a.value='8427008' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8427008') 
                  and a.ref=k.ref;
             end if;

          end if;

          if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and ob22_='19' and 
             LOWER(k.nazn) like '%чек%' then 

             update operw a set a.value='8446008' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446008') 
               and a.ref=k.ref;

             if rezid_o ='2' then
                update operw a set a.value='8427008' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8427008') 
                  and a.ref=k.ref;
             end if;

          end if;

          -- конверсiя валюти
          if k.nlsd LIKE '100%' and k.nlsk LIKE '3800%' and ob22_='07' then 

             update operw a set a.value='8446016' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446016') 
               and a.ref=k.ref;
          end if;
                     
          if k.nlsd LIKE '3800%' and k.nlsk LIKE '100%' and ob22_='07' then 
     
             update operw a set a.value='8446016' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446016') 
               and a.ref=k.ref;
          end if;
                     
          -- комiсiя ОБУ
          if k.nlsd LIKE '100%' and k.nlsk LIKE '3800%' and ob22_='03' and 
                  (LOWER(k.nazn) like '%ком_с_я%' OR
                   LOWER(k.nazn) like '%коммисия' OR
                   LOWER(k.nazn) like '%комисия' )
          then  

             update operw a set a.value='8446009' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446009') 
               and a.ref=k.ref;
          end if;

          -- заставнi + iнкасо (iншi надходження)
          if k.tt=k.tt1 and k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and 
             ob22_ in ('19','34') then 

             update operw a set a.value='8446017' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446017') 
               and a.ref=k.ref;
          end if;

          if k.nlsd LIKE '100%' and k.nlsk LIKE '3552%' then 

             update operw a set a.value='8446017' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446017') 
               and a.ref=k.ref;
          end if;
                      
          -- заставнi+iнкасо+%% по вкладам (iншi видатки)
          -- 03.12.2012 по счету 2909 и OB22='19' будем формировать код 8428001
          if k.tt=k.tt1 and k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and 
             ob22_ in ('34') then 

             update operw a set a.value='8446018' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446018') 
               and a.ref=k.ref;
          end if;

          if k.tt=k.tt1 and substr(k.nlsd,1,4) IN ('2628','2638','3500','3552') and 
             k.nlsk LIKE '100%' then 

             update operw a set a.value='8446018' 
             where a.tag='KOD_N' 
               and (trim(a.value) is null OR trim(a.value)<>'8446018') 
               and a.ref=k.ref;
          end if;
                     
          -- прийнято IВ вiд ФО для погашення кредитiв та %% 
          if k.nlsd LIKE '100%' and 
             (substr(k.nlsk,1,3) IN ('206','207','220','221','223') OR 
              substr(k.nlsk,1,4) IN ('2290','2480','3578', 
                                     '3579','3600','3739')) then
    	 
             if UPPER(k.nazn) like '%'||UPPER('Розгорнен')||'%' OR 
                UPPER(k.nazn) like '%'||UPPER('Розгортан')||'%' then
                update operw a set a.value='8446010' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8446010') 
                  and a.ref=k.ref;
             else
                update operw a set a.value='8446021' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8446021') 
                  and a.ref=k.ref;
             end if;
             if k.tt in ('024') and k.nlsk LIKE '3739%' then 
                update operw a set a.value='8446010' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8446010') 
                  and a.ref=k.ref;
             end if;
          end if;
                     
          -- видано IВ ФО з каси уповноваженого банку як кредит 
          if (substr(k.nlsd,1,3) IN ('206','207','220','221','223') OR 
              substr(k.nlsd,1,4) IN ('2290','2480','3578',
                                     '3579','3600','3739')) and 
             k.nlsk LIKE '100%' then 

             if UPPER(k.nazn) like '%'||UPPER('Згорнен')||'%' OR 
                UPPER(k.nazn) like '%'||UPPER('Згортан')||'%' then
                update operw a set a.value='8446010' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8446010') 
                  and a.ref=k.ref;
             else
                update operw a set a.value='8446021' 
                where a.tag='KOD_N' 
                  and (trim(a.value) is null OR trim(a.value)<>'8446021') 
                  and a.ref=k.ref;
             end if;
          end if;
                     
          -- анулювання відкликааня переказів в IВ
          if (k.nlsd LIKE '2809%' OR k.nlsd LIKE '2909%') and k.nlsk LIKE '100%' 
             and k.tt in ('M37','MMV','CN3','CN4')
          then 

             update operw a set a.value='8446018'
             where a.tag='KOD_N'   
               and (a.value is null or a.value NOT LIKE '8446018%') 
               and a.ref=k.ref;

             begin
                select trim(w.value), 
                   to_date(substr(replace(replace(trim(w1.value), ',','/'),'.','/'),1,10), 'dd/mm/yyyy')
                   into ref_m37, dat_m37
                from operw w, operw w1
                where w.ref = k.ref
                  and (w.tag like 'D_REF%' or w.tag like 'REFT%')
                  and w1.ref = k.ref
                  and (w1.tag like 'D_1PB%' or w1.tag like 'DATT%');
               
                begin
                   select ref, fdat 
                      into ref_mmv, dat_mmv
                   from provodki 
                   where ref = ref_m37
                     and kv = k.kv 
                     and nlsd = k.nlsk 
                     and rownum = 1;

                   if to_char(k.fdat,'MM') = to_char(dat_mmv,'MM') then
                      update operw set value = '0000000' 
                      where ref = ref_m37 
                        and tag like 'KOD_N%';

                      update operw set value = '0000000' 
                      where ref = k.ref 
                        and tag like 'KOD_N%';
                   end if;
                exception when no_data_found then
                   null;
                end;
             EXCEPTION 
                WHEN NO_DATA_FOUND THEN
                    null;
                when others then 
                    raise_application_error(-20000, 'Помилка для РЕФ = '||to_char(k.ref)||
                                            ': перевірте доп.реквізити D_1PB(DATT) та D_REF(REFT)! '||sqlerrm);
             end;
     
          end if;  
       end loop;
   END IF;
   
   gl.param;
   delete from pb_1;

   bank_pb1 := F_Get_Params ('1_PB', -1);

   SELECT min(fdat),max(fdat)  INTO dat1_, dat2_ FROM fdat
   WHERE  to_char(fdat,'YYYYMM')= GGGGMM;
   sm_ := '|';

   -- deb.trace( 11, '1', DAT1_ || ' '||DAT2_);

   if gl.AMFO = '300001' then KL_:='35'; else KL_:='26'; end if;

   -- deb.trace( 11, '2', gl.AMFO);

   FOR g in (select decode(a.kv,810,decode(a.pos,2,' N  ',' K  '),'    ') KOR,
                t.KV                                                  KV,
                a.ACC                                                 ACC,
                decode(a.pap,1,'N','L')                               LN,
                b.ISO_COUNTR                                          ISO_COUNTR,
                substr(c.nmk,1,47)                                    NMK,
                t.LCV                                                 LCV,
	            a.NLS                                                 NLS,
                NVL(abs(fost(a.acc,dat1_) +
	            fdos(a.acc,dat1_,dat1_) -
                    fkos(a.acc,dat1_,dat1_) ) /100000,0)              S1,
                NVL(abs(fost(a.acc,dat2_))/100000,0)                  S2
             from accounts a,  customer c,  tabval   t,  bopcount b
             where (a.nbs in ('1500','1505','1600','1605')
                       and gl.AMFO<>300001
                       or a.nbs in ('1201','1202','1221','3201')
                   and gl.AMFO= 300001  )
                   and a.rnk = c.rnk
                   and a.kv   = t.kv
                   and c.country=b.kodc+0
                   and (c.codcagent=2 or c.rnk=4001 and gl.AMFO= 300001 )
                   and  c.codcagent=2
                   and (a.dazs is null or a.dazs>dat1_)
                UNION ALL
             select 'к  ',  --'Є   ','k   ',
                    t.kv,
                    a.acc,
                        'N',
                    decode(b.ISO_COUNTR,'DEU','EUZ',b.ISO_COUNTR),
                            'ГОТІВКА',    ---    'Гот_вка',--substr(a.nms,1,47),
                        t.lcv,
                    a.nls,
                            NVL(abs(fost(a.acc,dat1_)+
                        fdos(a.acc,dat1_,dat1_)-
                                fkos(a.acc,dat1_,dat1_))/100000,0),
                            NVL(abs(fost(a.acc,dat2_))/100000,0)
             from accounts a, tabval t,  bopcount b
             where (a.nbs in ('1001','1002','1003','1007')
		           and gl.AMFO<>300001
		           or a.nbs in ('1011')
			   and gl.AMFO= 300001 )
		 	   and  a.kv      = t.kv
			   and  t.country = b.kodc+0
			   and  t.kv      <>980
			   and (a.dazs is null or a.dazs>dat1_) )
   LOOP

-- deb.trace( 11, 'ACC', g.KV || g.NLS);

      nn_:=0;
      kor_ := g.KOR;

      if mfo_g = 333368 then
         kor_ := 'к917';
      end if;

      if mfo_g = 331467 then
         kor_ := 'к916';
      end if;

      if mfo_g = 313957 then
         kor_ := 'к908';
      end if;

      FOR k in ( select o.REF, o.TT TT, o.FDAT, o.DK, o.S, 
                        p.TT TT1, p.NLSA, p.NLSB,
                        p.nazn, P.MFOA, P.MFOB,
                        decode( P.MFOA,gl.amfo, P.ID_B , p.ID_A ) ASP_K,
                        decode( P.MFOA,gl.amfo, P.nam_b, p.nam_a) ASP_N,
                        p.kv, p.vdat 
                 from opldok o, oper p
                 where o.tt not in ('BAK') AND
                       o.acc  =g.ACC AND o.ref=p.ref AND p.sos=5 AND
                       o.fdat between dat1_ AND dat2_ AND o.S <>0
                 ORDER BY 3,1
               )
      LOOP

-- deb.trace( 11, 'REF', k.REF);

         --курсор по документам
         kod7_:=SUBSTR(F_dop(k.REF,'KOD_N'),1,7);
         BANK_:=SUBSTR(F_dop(k.REF,'KOD_B'),1,4);
         coun_:=SUBSTR(F_dop(k.REF,'KOD_G'),1,3);

         if k.tt in ('VPF','MVQ','MUQ') then --k.tt <> k.tt1 then
            BEGIN
               select trim(value) 
                  INTO kod1_ 
               from operw 
               where ref=k.ref 
                 and tag='73'||k.tt;
               if kod1_ = '261' then
                  kod7_ := '2343001';
                  bank_ := '    ';
                  coun_ := '804';
                end if;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               null;
            END;                          
         end if;

         if k.tt in ('151') and kod7_<>'8446018' then 
            kod7_ := '8446018';
            bank_ := '4';
            coun_ := '804';
         end if;

         if kod7_ LIKE '8446%' then 
            bank_ := '4';
            coun_ := '804';
         end if;

         --- OAB 03.02.2005
         IF substr(kod7_,1,4) in ('2314','2343','2344') THEN
            bank_:='    ';
         END IF;
         -- для Днепропетровск Укоопспилка формируем код банка 
         IF gl.amfo = 306566 and substr(kod7_,1,4) in ('2314','2343','2344') THEN
            BANK_:=SUBSTR(F_dop(k.REF,'KOD_B'),1,4);
         END IF;

         --- OAB 09.02.2005
         IF substr(kod7_,1,4) in ('2343','2344') THEN
            coun_:=g.ISO_COUNTR;
         END IF;

         If ascii(substr(coun_,1,1))>=48 and ascii(substr(coun_,1,1))<=57 THEn
            begin
               SELECT nvl(ISO_COUNTR,'EUZ') into coun_
               from bopcount
               where trim(kodc)=trim(coun_); --to_number(kodc)=to_number(coun_);
            EXCEPTION WHEN NO_DATA_FOUND THEN coun_:='EUZ';
            end;
         end if;

         if gl.amfo=300001 then
            OPER_:=substr(k.nazn,1,60);
         else
            begin
              select transdesc  into OPER_ from bopcode
              where transcode=kod7_ and rownum=1;
            EXCEPTION WHEN NO_DATA_FOUND THEN OPER_:='???';
            end;
         end if;

         KOD_ :=SUBSTR(KOD7_,1,4);
         BANK_:=SUBSTR('    ' || ltrim(rtrim(BANK_)),-4,4);
         S3_:= k.S/100000 ;
         if k.DK=0 then  
            s4_:=0;
         else            
            s4_:=s3_;   
            s3_:=0;
         end if;

--- OAB 03.02.2005
         IF kod7_ in ('2314002','8446025','8446027') AND S3_<>0 THEN
            s4_:=-s3_;
            s3_:=0;
         END IF;

--- OAB 06.05.2009 для Ровно Сбербанк 
         IF kod7_ in ('2312003') AND mfo_g=333368 AND S3_<>0 THEN
            s4_:=-s3_;
            s3_:=0;
         END IF;

-- значна сума  (виключаемо нейтральнi операцii код 8444 )
         if ( gl.p_icurval(g.KV, k.S, k.fdat) >=
              gl.p_icurval(840, 5000000, k.fdat) AND
              substr(g.NLS,1,2) <> '10' AND KOD_ not in 
                ('2041','2042','2133','2134','2135','2136','2137','2138','2153','2154',
                 '2155','2156','2157','2158','2173','2174','2175','2176','2177','2178',
                 '2193','2194','2195','2196','2197','2198','2223','2224','2225','2226', 
                 '2227','2228','2247','2248','2249','2250','2251','2252','2253','2254', 
                 '2303','2304','2305','2306','2307','2308','2311','2312','2315','2316',
                 '2343','2344','2373','2374','2375','2376','2421','2422','2423','2424',
                 '2429','2430','2431','2432','2433','2434','2443','2444','2445','2446',
                 '2475','2476','2351','2352','2353','2354','2355','2356','2481','2482',
                 '2489','2490','2485','2486','2487','2488','2493','2494','2501','2502',
                 '2483','2484','2503','2504','2497','2498','2505','2506','2507','2508',
                 '2471','2472','2473','2474','2591','2592',
                 '8444'
                )
            ) OR
            ( gl.p_icurval(g.KV, k.S, k.fdat) >=
              gl.p_icurval(840, 2000000, k.fdat) AND KOD_ in
                ('2041','2042','2133','2134','2135','2136','2137','2138','2153','2154',
                 '2155','2156','2157','2158','2173','2174','2175','2176','2177','2178',
                 '2193','2194','2195','2196','2197','2198','2223','2224','2225','2226', 
                 '2227','2228','2247','2248','2249','2250','2251','2252','2253','2254', 
                 '2303','2304','2305','2306','2307','2308','2311','2312','2315','2316',
                 '2343','2344','2373','2374','2375','2376','2421','2422','2423','2424',
                 '2429','2430','2431','2432','2433','2434','2443','2444','2445','2446',
                 '2475','2476','2351','2352','2353','2354','2355','2356','2481','2482',
                 '2489','2490','2485','2486','2487','2488','2493','2494','2501','2502',
                 '2483','2484','2503','2504','2497','2498','2505','2506','2507','2508',
                 '2471','2472','2473','2474','2591','2592'
                )
            )
         then 

            oper_99 := OPER_;

-- deb.trace( 12, 'S', k.S );
            begin

             SELECT c.NBS, c.ACC  --SUBSTR(a.NBS,1,2),a.acc
                INTO sNBSk_,ACC_
             FROM 
             (SELECT SUBSTR(a.NBS,1,2) NBS, a.acc ACC
              FROM accounts a, opldok o
              WHERE o.ref=k.ref and k.dk=1-o.dk and
                    o.acc=a.acc and rownum=1 and 
                    o.ref not in (select ref
                                  from operw
                                  where ref>=o.ref and tag='NOS_R') 
              UNION ALL
              SELECT SUBSTR(a.NBS,1,2) NBS, a.acc ACC
              FROM accounts a, opldok o
              WHERE k.dk=1-o.dk and
                    o.acc=a.acc and rownum=1 and 
                    o.ref in (select to_number(trim(value))
                              from operw
                               where ref=k.ref and tag='NOS_R')) c ;

               -- кто корреспондент по корсчету
-- deb.trace( 13, 'NBS', sNBSk_ );
-- deb.trace( 14, 'KL', KL_);

               if sNBSk_=KL_ then
                  -- клиент нашего банка
                  select decode(c.custtype,2,'U',
                         decode(c.sed,91,'S','F')) || sm_ ||
                         c.okpo || sm_ ||
                         decode(c.custtype,2,c.nmk,' ')
                  into DECL_
                  from  customer c, cust_acc u
                  where c.codcagent in (3,5)  and u.acc=ACC_ and
                        u.rnk=c.rnk and rownum=1;
-- deb.trace( 15, 'DECL_', DECL_ );

                  OPER_:= substr(sm_ || OPER_ || sm_ || BAKOD1_ || sm_ || DECL_,1,110) ;

               elsif gl.amfo<>300001 and sNBSk_ in ('16','39','19','37' ) then

                  --клиент лоро-банка
                  asp_S_:=SUBSTR(F_dop(k.REF,'ASP_S'),1,1) ;
                  asp_K_:=SUBSTR(F_dop(k.REF,'ASP_K'),1,14);
                  asp_N_:=SUBSTR(F_dop(k.REF,'ASP_N'),1,38);

                  -- МУЛЬТИВАЛ.ВПС
                  IF K.mfoa<>K.mfob THEN

                     if asp_K_ is null or substr(asp_K_,1,1)=' ' then
                        asp_K_:=k.ASP_K;
                     end if ;

                     if asp_S_ is null or substr(asp_S_,1,1)=' ' then
                        asp_S_:=IIF_S(to_char(length(asp_K_)),'8','F','U','F');
                     end if;
                     if asp_N_ is null or substr(asp_N_,1,1)=' ' then
                        asp_N_:=k.ASP_N;
                     end if;
                  END IF;

                  If asp_S_='U' then
                     OPER_:= substr(sm_    || OPER_ || sm_    || BAKOD1_ || sm_   ||
                             asp_S_ || sm_   || asp_K_ || sm_     || asp_N_ ,1,110) ;
                  else
                     OPER_:= substr(sm_    || OPER_ || sm_    || BAKOD1_ || sm_ ||
                             asp_S_ || sm_   || asp_K_ || sm_ ,1,110) ;
                  end if;
               end if;

               -- для проводок Дт 1500  Кт 3739 
               IF K.nlsa like '1500%' and K.nlsb like '3739%' and K.mfoa = K.mfob 
               THEN
                  BEGIN
                     select P.ID_B, c.nmkk 
                        into ASP_K_, ASP_N_
                     from oper p, customer c 
                     where p.tt not in ('BAK') 
                       and p.sos = 5 
                       and p.kv = k.kv 
                       and p.nlsa = k.nlsb 
                       and p.vdat = k.vdat  -- between k.vdat and k.vdat + 3 
                       and p.s = k.s 
                       --and p.nazn like k.nazn || '%'
                       and p.nlsb like '260%' 
                       and rownum = 1
                       and trim (p.id_b) = trim (c.okpo);

                     asp_S_ := IIF_S(to_char(length(asp_K_)),'8','F','U','F');

                     If asp_S_ = 'U' then
                        OPER_ := substr(sm_    || OPER_99 || sm_    || bank_pb1 || sm_   ||
                                 asp_S_ || sm_   || asp_K_ || sm_     || asp_N_ ,1,110) ;
                     else
                        OPER_:= substr(sm_    || OPER_99 || sm_    || bank_pb1 || sm_ ||
                                asp_S_ || sm_   || asp_K_ || sm_ ,1,110) ;
                     end if;

                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     null;
                  END;
               END IF;
            EXCEPTION WHEN NO_DATA_FOUND THEN DECL_:=null;
            end;

            if g.NLS not like '10%'
            then
               -- выборка всех реквизитов для декларирования из V_CIM_1PB_DOC
               -- с 03.11.2015 выборка всех реквизитов для декларирования 
               -- будет из CIM_1PB_RU_DOC
               BEGIN
                  select p.cl_type, p.cl_ipn, p.cl_name 
                     into ASP_S_, ASP_K_, ASP_N_
                  from cim_1pb_ru_doc p 
                  where p.ref_ca = k.ref 
                    and p.kv = k.kv 
                    and p.vdat = k.vdat;   

                  DECL_ := ASP_S_ || sm_ || ASP_K_ || sm_ || ASP_N_; 
                  OPER_:= substr(sm_ || OPER_99 || sm_ || BAKOD1_ || sm_ || DECL_,1,110) ;
               EXCEPTION WHEN NO_DATA_FOUND THEN 
                  null;
               END;
            end if;

-- deb.trace( 17, 'OPER_', OPER_);
         end if;

         den_:=to_char(k.FDAT,'DD')+0;
         mec_:=to_char(k.FDAT,'MM')+0;
         god_:=to_char(k.FDAT,'RR')+0;

         IF s3_+s4_<>0 THEN
            INSERT INTO pb_1 (refc,tt  ,LN ,DEN ,MEC  ,GOD ,BAKOD  ,COUNKOD ,
                PARTN, VALKOD,NLS  , KOR , KRE, DEB, coun , kod       , oper ,bank      )
            VALUES          (k.REF,k.TT,g.LN,DEN_,MEC_ ,GOD_,lpad(BAKOD1_,4,' '),g.ISO_COUNTR,
                g.NMK, g.LCV ,g.NLS, kor_, s3_, s4_, COUN_, trim(kod_), oper_,trim(bank_)   );
            nn_:=nn_+1 ;
         END IF;

      -- анулювання відкликааня переказів в IВ
      if k.tt in ('M37','MMV','CN3','CN4')
      then 

         begin
            select trim(w.value), 
               to_date(substr(replace(replace(trim(w1.value), ',','/'),'.','/'),1,10), 'dd/mm/yyyy')
               into ref_m37, dat_m37
            from operw w, operw w1
            where w.ref = k.ref
              and (w.tag like 'D_REF%' or w.tag like 'REFT%')
              and w1.ref = k.ref
              and (w1.tag like 'D_1PB%' or w1.tag like 'DATT%');
           
            begin
               select ref, fdat 
                  into ref_mmv, dat_mmv
               from provodki_otc 
               where ref = ref_m37
                 and kv = g.kv 
                 and nlsd = g.nls 
                 and rownum = 1;

               if to_char(k.fdat,'MM') = to_char(dat_mmv,'MM') then
                  
                  delete from pb_1  
                  where refc = k.ref; 
 
                  delete from pb_1  
                  where refc = ref_m37; 
                  
               end if;
            EXCEPTION 
               WHEN NO_DATA_FOUND THEN
                   null;
               when others then
                   if sqlcode in (-1830, -1858) then
                      raise_application_error(-20001, 'Перевірте доп.реквізит D_1PB для РЕФ = '||to_char(k.ref)||
                       ' ! Дата повинна бути в форматі dd/mm/yyyy');
                   else
                      raise;
                   end if;
            end;
         exception when no_data_found then
            null;
         end;
 
      end if;  

      END LOOP;

      den_:=to_char(dat1_,'DD')+0;
      mec_:=to_char(dat1_,'MM')+0;
      god_:=to_char(dat1_,'RR')+0;
      if g.LN='N' then
         s4_:=0   ;s3_:=0   ;kod_:='9111';kod2_:='9112';S1_:=g.S1;s2_:=g.S2;
      else
         s4_:=g.S1;s3_:=g.S2;kod_:='9221';kod2_:='9222';S1_:=0   ;S2_:=0   ;
      end if;
      INSERT INTO pb_1       (refc,tt, LN ,DEN, MEC, GOD, BAKOD,  COUNKOD,
          PARTN, VALKOD, NLS, KRE, DEB, coun,kod,kor)
      VALUES                 (0,'   ', g.LN,DEN_,MEC_,GOD_,lpad(BAKOD1_,4,' '),g.ISO_COUNTR,
          g.NMK,g.LCV,g.NLS,s1_, s4_,g.ISO_COUNTR,trim(kod_), kor_ );

      den_:=to_char(dat2_,'DD')+0;
      mec_:=to_char(dat2_,'MM')+0;
      god_:=to_char(dat2_,'RR')+0;
      INSERT INTO pb_1 (refc,tt, LN ,DEN, MEC, GOD, BAKOD, COUNKOD,
          PARTN, VALKOD, NLS, KRE, DEB, coun,kod, kor)
      VALUES           (0,'   ', g.LN,DEN_,MEC_,GOD_,lpad(BAKOD1_,4,' '),g.ISO_COUNTR,
          g.NMK,g.LCV,g.NLS,s3_, s2_,g.ISO_COUNTR,trim(kod2_),kor_ );
   END LOOP;
   
   logger.info ('FPB1: End for '||BAKOD1_ || ' ' || GGGGMM);
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FPB1_OLD.sql =========*** End *** 
PROMPT ===================================================================================== 
