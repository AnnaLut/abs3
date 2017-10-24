

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ANI_GAPS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ANI_GAPS ***

  CREATE OR REPLACE PROCEDURE BARS.ANI_GAPS (MODE_ int, JDAT1_ DATE, JDAT2_ DATE ) IS

/*

  Процедура для функций аналитического модуля
  дополнение для Функции ANI-1.Анализ АКТ и ПАС
  ANI-1s.ANI-1s. Пiдсумки та усереднення вiдповiдностi АКТ-ПАС
  Итоговые и усредненные данные
*/

begin

  If MODE_ in (1,-1) then /* GAP */

     delete from ani_gap where fdat >= JDAT1_ and fdat <= JDAT2_;
     commit;

     -- 1) KV + BRANCH детально
     insert into ANI_GAP (Fdat, pap, kv, branch ,
       G00,R00, G01,R01, G02,R02, G03,R03, G04,R04, G05,R05, G06,R06, G07,R07,
       G0A,R0A, G0B,R0B, G0C,R0C, G0D,R0D, G0E,R0E, G0F,R0F, G0G,R0G, G0H,R0H,
       G0X,R0X )
     select fdat, pap, KV, branch,
       Sum(G00)/100 G00, Sum(R00)/100 R00,
       Sum(G01)/100 G01, Sum(R01)/100 R01,
       Sum(G02)/100 G02, Sum(R02)/100 R02,
       Sum(G03)/100 G03, Sum(R03)/100 R03,
       Sum(G04)/100 G04, Sum(R04)/100 R04,
       Sum(G05)/100 G05, Sum(R05)/100 R05,
       Sum(G06)/100 G06, Sum(R06)/100 R06,
       Sum(G07)/100 G07, Sum(R07)/100 R07,
       Sum(G0A)/100 G0A, Sum(R0A)/100 R0A,
       Sum(G0B)/100 G0B, Sum(R0B)/100 R0B,
       Sum(G0C)/100 G0C, Sum(R0C)/100 R0C,
       Sum(G0D)/100 G0D, Sum(R0D)/100 R0D,
       Sum(G0E)/100 G0E, Sum(R0E)/100 R0E,
       Sum(G0F)/100 G0F, Sum(R0F)/100 R0F,
       Sum(G0G)/100 G0G, Sum(R0G)/100 R0G,
       Sum(G0H)/100 G0H, Sum(R0H)/100 R0H,
       Sum(G0X)/100 G0X, Sum(R0X)/100 R0X
     from (SELECT fdat, PAP, KV, branch,
            G00,G00*IR R00, G0X,G0X*IR R0X,
            G01,G01*IR R01, G02,G02*IR R02, G03,G03*IR R03, G04,G04*IR R04,
            G05,G05*IR R05, G06,G06*IR R06, G07,G07*IR R07, G0A,G0A*IR R0A,
            G0B,G0B*IR R0B, G0C,G0C*IR R0C, G0D,G0D*IR R0D, G0E,G0E*IR R0E,
            G0F,G0F*IR R0F, G0G,G0G*IR R0G, G0H,G0H*IR R0H
          FROM
            (select fdat,Substr(kodp,1,1) PAP, nvl(IR,0) IR, KV, Nvl(nbuc,'0') branch,
                      decode(Substr(kodp,8,1),'1',znap,0) G01,
                      decode(Substr(kodp,8,1),'2',znap,0) G02,
                      decode(Substr(kodp,8,1),'3',znap,0) G03,
                      decode(Substr(kodp,8,1),'4',znap,0) G04,
                      decode(Substr(kodp,8,1),'5',znap,0) G05,
                      decode(Substr(kodp,8,1),'6',znap,0) G06,
                      decode(Substr(kodp,8,1),'7',znap,0) G07,
                      decode(Substr(kodp,8,1),'A',znap,0) G0A,
                      decode(Substr(kodp,8,1),'B',znap,0) G0B,
                      decode(Substr(kodp,8,1),'C',znap,0) G0C,
                      decode(Substr(kodp,8,1),'D',znap,0) G0D,
                      decode(Substr(kodp,8,1),'E',znap,0) G0E,
                      decode(Substr(kodp,8,1),'F',znap,0) G0F,
                      decode(Substr(kodp,8,1),'G',znap,0) G0G,
                      decode(Substr(kodp,8,1),'H',znap,0) G0H,
                      decode(Substr(kodp,8,1),'0',znap,' ',znap,0) G0X, znap G00
             from RNBU_TRACE1 r1
             where fdat >= JDAT1_ and fdat<=JDAT2_ AND Substr(kodp,2,1)<'6' )
          WHERE G00<>0 )
     Group by fdat, pap,kv,branch ;

     commit;

     --  BRANCH Консолидировано по бранчам
     insert into ANI_GAP (Fdat, pap, kv, branch ,
       G00,R00, G01,R01, G02,R02, G03,R03, G04,R04, G05,R05, G06,R06, G07,R07,
       G0A,R0A, G0B,R0B, G0C,R0C, G0D,R0D, G0E,R0E, G0F,R0F, G0G,R0G, G0H,R0H,
       G0X,R0X )
     select fdat, pap, 0, branch,
       Sum(G00)/100 G00, Sum(R00)/100 R00,
       Sum(G01)/100 G01, Sum(R01)/100 R01,
       Sum(G02)/100 G02, Sum(R02)/100 R02,
       Sum(G03)/100 G03, Sum(R03)/100 R03,
       Sum(G04)/100 G04, Sum(R04)/100 R04,
       Sum(G05)/100 G05, Sum(R05)/100 R05,
       Sum(G06)/100 G06, Sum(R06)/100 R06,
       Sum(G07)/100 G07, Sum(R07)/100 R07,
       Sum(G0A)/100 G0A, Sum(R0A)/100 R0A,
       Sum(G0B)/100 G0B, Sum(R0B)/100 R0B,
       Sum(G0C)/100 G0C, Sum(R0C)/100 R0C,
       Sum(G0D)/100 G0D, Sum(R0D)/100 R0D,
       Sum(G0E)/100 G0E, Sum(R0E)/100 R0E,
       Sum(G0F)/100 G0F, Sum(R0F)/100 R0F,
       Sum(G0G)/100 G0G, Sum(R0G)/100 R0G,
       Sum(G0H)/100 G0H, Sum(R0H)/100 R0H,
       Sum(G0X)/100 G0X, Sum(R0X)/100 R0X
     from (SELECT fdat, PAP, KV, branch,
            G00,G00*IR R00, G0X,G0X*IR R0X,
            G01,G01*IR R01, G02,G02*IR R02, G03,G03*IR R03, G04,G04*IR R04,
            G05,G05*IR R05, G06,G06*IR R06, G07,G07*IR R07, G0A,G0A*IR R0A,
            G0B,G0B*IR R0B, G0C,G0C*IR R0C, G0D,G0D*IR R0D, G0E,G0E*IR R0E,
            G0F,G0F*IR R0F, G0G,G0G*IR R0G, G0H,G0H*IR R0H
          FROM
            (select fdat,Substr(kodp,1,1) PAP, nvl(IR,0) IR, KV, Nvl(nbuc,'0') branch,
                      decode(Substr(kodp,8,1),'1',znap,0) G01,
                      decode(Substr(kodp,8,1),'2',znap,0) G02,
                      decode(Substr(kodp,8,1),'3',znap,0) G03,
                      decode(Substr(kodp,8,1),'4',znap,0) G04,
                      decode(Substr(kodp,8,1),'5',znap,0) G05,
                      decode(Substr(kodp,8,1),'6',znap,0) G06,
                      decode(Substr(kodp,8,1),'7',znap,0) G07,
                      decode(Substr(kodp,8,1),'A',znap,0) G0A,
                      decode(Substr(kodp,8,1),'B',znap,0) G0B,
                      decode(Substr(kodp,8,1),'C',znap,0) G0C,
                      decode(Substr(kodp,8,1),'D',znap,0) G0D,
                      decode(Substr(kodp,8,1),'E',znap,0) G0E,
                      decode(Substr(kodp,8,1),'F',znap,0) G0F,
                      decode(Substr(kodp,8,1),'G',znap,0) G0G,
                      decode(Substr(kodp,8,1),'H',znap,0) G0H,
                      decode(Substr(kodp,8,1),'0',znap,' ',znap,0) G0X, znap G00
             from RNBU_TRACE1 r1
             where fdat >= JDAT1_ and fdat<=JDAT2_ AND Substr(kodp,2,1)<'6' )
          WHERE G00<>0 )
     Group by fdat, pap,branch ;

     commit;

     --  KV Консолидировано по валютам
     insert into ANI_GAP (Fdat, pap, kv, branch ,
       G00,R00, G01,R01, G02,R02, G03,R03, G04,R04, G05,R05, G06,R06, G07,R07,
       G0A,R0A, G0B,R0B, G0C,R0C, G0D,R0D, G0E,R0E, G0F,R0F, G0G,R0G, G0H,R0H,
       G0X,R0X )
     select fdat, pap, KV, '*',
       Sum(G00)/100 G00, Sum(R00)/100 R00,
       Sum(G01)/100 G01, Sum(R01)/100 R01,
       Sum(G02)/100 G02, Sum(R02)/100 R02,
       Sum(G03)/100 G03, Sum(R03)/100 R03,
       Sum(G04)/100 G04, Sum(R04)/100 R04,
       Sum(G05)/100 G05, Sum(R05)/100 R05,
       Sum(G06)/100 G06, Sum(R06)/100 R06,
       Sum(G07)/100 G07, Sum(R07)/100 R07,
       Sum(G0A)/100 G0A, Sum(R0A)/100 R0A,
       Sum(G0B)/100 G0B, Sum(R0B)/100 R0B,
       Sum(G0C)/100 G0C, Sum(R0C)/100 R0C,
       Sum(G0D)/100 G0D, Sum(R0D)/100 R0D,
       Sum(G0E)/100 G0E, Sum(R0E)/100 R0E,
       Sum(G0F)/100 G0F, Sum(R0F)/100 R0F,
       Sum(G0G)/100 G0G, Sum(R0G)/100 R0G,
       Sum(G0H)/100 G0H, Sum(R0H)/100 R0H,
       Sum(G0X)/100 G0X, Sum(R0X)/100 R0X
     from (SELECT fdat, PAP, KV, branch,
            G00,G00*IR R00, G0X,G0X*IR R0X,
            G01,G01*IR R01, G02,G02*IR R02, G03,G03*IR R03, G04,G04*IR R04,
            G05,G05*IR R05, G06,G06*IR R06, G07,G07*IR R07, G0A,G0A*IR R0A,
            G0B,G0B*IR R0B, G0C,G0C*IR R0C, G0D,G0D*IR R0D, G0E,G0E*IR R0E,
            G0F,G0F*IR R0F, G0G,G0G*IR R0G, G0H,G0H*IR R0H
          FROM
            (select fdat,Substr(kodp,1,1) PAP, nvl(IR,0) IR, KV, Nvl(nbuc,'0') branch,
                      decode(Substr(kodp,8,1),'1',znap,0) G01,
                      decode(Substr(kodp,8,1),'2',znap,0) G02,
                      decode(Substr(kodp,8,1),'3',znap,0) G03,
                      decode(Substr(kodp,8,1),'4',znap,0) G04,
                      decode(Substr(kodp,8,1),'5',znap,0) G05,
                      decode(Substr(kodp,8,1),'6',znap,0) G06,
                      decode(Substr(kodp,8,1),'7',znap,0) G07,
                      decode(Substr(kodp,8,1),'A',znap,0) G0A,
                      decode(Substr(kodp,8,1),'B',znap,0) G0B,
                      decode(Substr(kodp,8,1),'C',znap,0) G0C,
                      decode(Substr(kodp,8,1),'D',znap,0) G0D,
                      decode(Substr(kodp,8,1),'E',znap,0) G0E,
                      decode(Substr(kodp,8,1),'F',znap,0) G0F,
                      decode(Substr(kodp,8,1),'G',znap,0) G0G,
                      decode(Substr(kodp,8,1),'H',znap,0) G0H,
                      decode(Substr(kodp,8,1),'0',znap,' ',znap,0) G0X, znap G00
             from RNBU_TRACE1 r1
             where fdat >= JDAT1_ and fdat<=JDAT2_ AND Substr(kodp,2,1)<'6' )
          WHERE G00<>0 )
     Group by fdat, pap,kv ;

     commit;

     --  Консолидировано по банку
     insert into ANI_GAP (Fdat, pap, kv, branch ,
       G00,R00, G01,R01, G02,R02, G03,R03, G04,R04, G05,R05, G06,R06, G07,R07,
       G0A,R0A, G0B,R0B, G0C,R0C, G0D,R0D, G0E,R0E, G0F,R0F, G0G,R0G, G0H,R0H,
       G0X,R0X )
     select fdat, pap, 0, '*',
       Sum(G00)/100 G00, Sum(R00)/100 R00,
       Sum(G01)/100 G01, Sum(R01)/100 R01,
       Sum(G02)/100 G02, Sum(R02)/100 R02,
       Sum(G03)/100 G03, Sum(R03)/100 R03,
       Sum(G04)/100 G04, Sum(R04)/100 R04,
       Sum(G05)/100 G05, Sum(R05)/100 R05,
       Sum(G06)/100 G06, Sum(R06)/100 R06,
       Sum(G07)/100 G07, Sum(R07)/100 R07,
       Sum(G0A)/100 G0A, Sum(R0A)/100 R0A,
       Sum(G0B)/100 G0B, Sum(R0B)/100 R0B,
       Sum(G0C)/100 G0C, Sum(R0C)/100 R0C,
       Sum(G0D)/100 G0D, Sum(R0D)/100 R0D,
       Sum(G0E)/100 G0E, Sum(R0E)/100 R0E,
       Sum(G0F)/100 G0F, Sum(R0F)/100 R0F,
       Sum(G0G)/100 G0G, Sum(R0G)/100 R0G,
       Sum(G0H)/100 G0H, Sum(R0H)/100 R0H,
       Sum(G0X)/100 G0X, Sum(R0X)/100 R0X
     from (SELECT fdat, PAP, KV, branch,
            G00,G00*IR R00, G0X,G0X*IR R0X,
            G01,G01*IR R01, G02,G02*IR R02, G03,G03*IR R03, G04,G04*IR R04,
            G05,G05*IR R05, G06,G06*IR R06, G07,G07*IR R07, G0A,G0A*IR R0A,
            G0B,G0B*IR R0B, G0C,G0C*IR R0C, G0D,G0D*IR R0D, G0E,G0E*IR R0E,
            G0F,G0F*IR R0F, G0G,G0G*IR R0G, G0H,G0H*IR R0H
          FROM
            (select fdat,Substr(kodp,1,1) PAP, nvl(IR,0) IR, KV, Nvl(nbuc,'0') branch,
                      decode(Substr(kodp,8,1),'1',znap,0) G01,
                      decode(Substr(kodp,8,1),'2',znap,0) G02,
                      decode(Substr(kodp,8,1),'3',znap,0) G03,
                      decode(Substr(kodp,8,1),'4',znap,0) G04,
                      decode(Substr(kodp,8,1),'5',znap,0) G05,
                      decode(Substr(kodp,8,1),'6',znap,0) G06,
                      decode(Substr(kodp,8,1),'7',znap,0) G07,
                      decode(Substr(kodp,8,1),'A',znap,0) G0A,
                      decode(Substr(kodp,8,1),'B',znap,0) G0B,
                      decode(Substr(kodp,8,1),'C',znap,0) G0C,
                      decode(Substr(kodp,8,1),'D',znap,0) G0D,
                      decode(Substr(kodp,8,1),'E',znap,0) G0E,
                      decode(Substr(kodp,8,1),'F',znap,0) G0F,
                      decode(Substr(kodp,8,1),'G',znap,0) G0G,
                      decode(Substr(kodp,8,1),'H',znap,0) G0H,
                      decode(Substr(kodp,8,1),'0',znap,' ',znap,0) G0X, znap G00
             from RNBU_TRACE1 r1
             where fdat >= JDAT1_ and fdat<=JDAT2_ AND Substr(kodp,2,1)<'6' )
          WHERE G00<>0 )
     Group by fdat, pap;

     commit;

     -- розриви
     insert into ANI_GAP (Fdat, pap, kv, branch ,
       G00,R00, G01,R01, G02,R02, G03,R03, G04,R04, G05,R05, G06,R06, G07,R07,
       G0A,R0A, G0B,R0B, G0C,R0C, G0D,R0D, G0E,R0E, G0F,R0F, G0G,R0G, G0H,R0H,
       G0X,R0X )
     SELECT Fdat, 3, kv, branch,
       SUM( ( 3 - 2*PAP) * G00 ),  SUM( ( 3 - 2*PAP) * R00 ),
       SUM( ( 3 - 2*PAP) * G01 ),  SUM( ( 3 - 2*PAP) * R01 ),
       SUM( ( 3 - 2*PAP) * G02 ),  SUM( ( 3 - 2*PAP) * R02 ),
       SUM( ( 3 - 2*PAP) * G03 ),  SUM( ( 3 - 2*PAP) * R03 ),
       SUM( ( 3 - 2*PAP) * G04 ),  SUM( ( 3 - 2*PAP) * R04 ),
       SUM( ( 3 - 2*PAP) * G05 ),  SUM( ( 3 - 2*PAP) * R05 ),
       SUM( ( 3 - 2*PAP) * G06 ),  SUM( ( 3 - 2*PAP) * R06 ),
       SUM( ( 3 - 2*PAP) * G07 ),  SUM( ( 3 - 2*PAP) * R07 ),
       SUM( ( 3 - 2*PAP) * G0A ),  SUM( ( 3 - 2*PAP) * R0A ),
       SUM( ( 3 - 2*PAP) * G0B ),  SUM( ( 3 - 2*PAP) * R0B ),
       SUM( ( 3 - 2*PAP) * G0C ),  SUM( ( 3 - 2*PAP) * R0C ),
       SUM( ( 3 - 2*PAP) * G0D ),  SUM( ( 3 - 2*PAP) * R0D ),
       SUM( ( 3 - 2*PAP) * G0E ),  SUM( ( 3 - 2*PAP) * R0E ),
       SUM( ( 3 - 2*PAP) * G0F ),  SUM( ( 3 - 2*PAP) * R0F ),
       SUM( ( 3 - 2*PAP) * G0G ),  SUM( ( 3 - 2*PAP) * R0G ),
       SUM( ( 3 - 2*PAP) * G0H ),  SUM( ( 3 - 2*PAP) * R0H ),
       SUM( ( 3 - 2*PAP) * G0X ),  SUM( ( 3 - 2*PAP) * R0X )
     FROM ANI_GAP
     where fdat >= JDAT1_ and fdat<=JDAT2_
     GROUP BY Fdat,  kv, branch;

     COMMIT;

  end if;

end ANI_GAPs;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ANI_GAPS.sql =========*** End *** 
PROMPT ===================================================================================== 
