
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SAL_SNP_KOR.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SAL_SNP_KOR ***

  CREATE OR REPLACE PROCEDURE BARS.P_SAL_SNP_KOR 
  ( mode_   int ,
    p_dat1  date,
    p_dat2  date,
    p_sql  varchar2
  ) IS

   p_mode1    int;
   p_mode2    int;

   l_dat1  date;
   l_dat2  date;
--   L_dat1S  NUMBER;
--   L_dat2S  NUMBER;

   l_dat1K  date;
   l_dat2K  date;
   l_dat1KS  NUMBER;
   l_dat2KS  NUMBER;
   l_dat1KSm  NUMBER;
   l_dat2KSm  NUMBER;

   p_trace varchar2(15) := 'P_SAL_SNP_KOR';

begin

-- ƒата банк≥вська початку зв≥та
SELECT MIN(FDAT) INTO l_dat1 FROM FDAT WHERE FDAT >= P_DAT1;
-- ƒата банк≥вська к≥нц€ зв≥та
SELECT MAX(FDAT) INTO l_dat2 FROM FDAT WHERE FDAT <= P_DAT2;


IF l_dat1 IS NULL THEN l_dat1:= l_dat2; END IF;


--L_dat1S := F_SNAP_DATI(l_dat1, 1);
--L_dat2S := F_SNAP_DATI(l_dat2, 1);

Logger.info(p_trace ||' l_dat1=' ||l_dat1);
Logger.info(p_trace ||' l_dat2=' ||l_dat2);

/*
IF mode_ in (1,0) THEN

 Bars_accm_sync.sync_snap_period(
                  p_objname    => 'BALANCE',
                  p_startdate  => l_dat1,
                  p_finishdate => l_dat2,
                  p_snapmode   => 1);
Logger.info(p_trace ||' SNAP ' ||l_dat1||' END '|| l_dat2);

END IF;
*/

-- ¬х≥дна дата    перев≥р чи не останн≥й банк≥вський день?
--                  чи не попадаЇе в пер≥од корегуючих

         if DAT_LAST(p_dat1) = p_dat1  --останн≥й банк≥вський день м≥с€ц€
                   then  p_mode1 := 1;
                         if to_char(p_dat1,'MM') = '01' then  l_dat1K := trunc(p_dat1+10,'MM')+20; l_dat1KS := F_SNAP_DATI(l_dat1K, 1); l_dat1KSm := F_SNAP_DATI(l_dat1K, 2);
                         else                                 l_dat1K := trunc(p_dat1+10,'MM')+10; l_dat1KS := F_SNAP_DATI(l_dat1K, 1); l_dat1KSm := F_SNAP_DATI(l_dat1K, 2);
                         end if;

         elsif  p_dat1 between trunc(p_dat1,'MM') and trunc(p_dat1,'MM')+20 and to_char(p_dat1,'MM') = '01'
                   then  p_mode1 := 2; --пер≥од корегуючих в м≥с€ц≥на початок року
                         l_dat1K := trunc(p_dat1,'MM')+20;  l_dat1KS := F_SNAP_DATI(l_dat1K, 1); l_dat1KSm := F_SNAP_DATI(l_dat1K, 2);

         elsif  p_dat1 between trunc(p_dat1,'MM') and trunc(p_dat1,'MM')+10  --пер≥од корегуючих в м≥с€ц≥
                   then  p_mode1 := 3;
                         l_dat1K := trunc(p_dat1,'MM')+10; l_dat1KS := F_SNAP_DATI(l_dat1K, 1); l_dat1KSm := F_SNAP_DATI(l_dat1K, 2);

      else   p_mode1 := 0; -- звичайний банк≥вський день
      end if;

Logger.info(p_trace ||' p_mode1=' ||p_mode1||' l_dat1K='||l_dat1K);

-- ¬их≥дна дата    перев≥р чи не останн≥й банк≥вський день?
--                  чи не попадаЇе в пер≥од корегуючих

         if DAT_LAST(p_dat2) = p_dat2
                   then  p_mode2 := 1; --останн≥й банк≥вський день м≥с€ц€
                         if (to_char(p_dat2,'MM') = '01') then    l_dat2K := trunc(p_dat2+10,'MM')+20; l_dat2KS := F_SNAP_DATI(l_dat2K, 1); l_dat2KSm := F_SNAP_DATI(l_dat2K, 2);
                         else                                   l_dat2K := trunc(p_dat2+10,'MM')+10; l_dat2KS := F_SNAP_DATI(l_dat2K, 1); l_dat2KSm := F_SNAP_DATI(l_dat2K, 2);
                         end if;

      elsif  p_dat2 between trunc(p_dat2,'MM') and trunc(p_dat2,'MM')+20 and to_char(p_dat2,'MM') = '01'
                   then  p_mode2 := 2; --пер≥од корегуючих в м≥с€ц≥на початок року
                         l_dat2K := trunc(p_dat2,'MM')+20; l_dat2KS := F_SNAP_DATI(l_dat2K, 1);  l_dat2KSm := F_SNAP_DATI(l_dat2K, 2);

      elsif  p_dat2 between trunc(p_dat2,'MM') and trunc(p_dat2,'MM')+10
                   then  p_mode2 := 3; --пер≥од корегуючих в м≥с€ц≥
                         l_dat2K := trunc(p_dat2,'MM')+10; l_dat2KS := F_SNAP_DATI(l_dat2K, 1);  l_dat2KSm := F_SNAP_DATI(l_dat2K, 2);

      else               p_mode2 := 0; -- звичайний банк≥вський день
      end if;

Logger.info(p_trace ||' p_mode2=' ||p_mode2||' l_dat2K='||l_dat2K);




EXECUTE IMMEDIATE 'TRUNCATE TABLE CCK_AN_TMP';

Logger.info(p_trace ||'sql = ' ||p_sql);

   EXECUTE IMMEDIATE  p_sql;



-- «вичайна оборотно сальдова в≥дом≥сть.

insert   into CCK_AN_TMP (branch,nbs,kv,nls,name,name1, acc,accl, n1,n2,n3,n4,n5,zalq,zal,rezq, AIM)
SELECT
       a.branch,
       to_number(a.nbs) NBS,
       a.kv,
       a.nls,
       substr(a.nms,1,70),
       a.ob22,
       a.acc,
       a.accc,
               --sum(decode(b1.CALDT_ID, L_dat1S, b1.ost+b1.dos-b1.kos,0)) OSTD,
               --sum(decode(b1.CALDT_ID, L_dat1S, b1.ostq+b1.dosq-b1.kosq,0)) OSTVD,
               sum(decode(b1.fdat, l_dat1, b1.ost+b1.dos-b1.kos,0)) OSTD,
               sum(decode(b1.fdat, l_dat1, b1.ostq+b1.dosq-b1.kosq,0)) OSTVD,
               sum(b1.dos) DOS,
               sum(b1.dosq) DOSq,
               sum(b1.kos) KOS,
               sum(b1.kosq) KOSq,
               --sum(decode(b1.CALDT_ID, L_dat2S, b1.ost,  0)) OSTID,
               --sum(decode(b1.CALDT_ID, L_dat2S, b1.ostq, 0)) OSTIVD,
               sum(decode(b1.fdat, l_dat2, b1.ost,  0)) OSTID,
               sum(decode(b1.fdat, l_dat2, b1.ostq, 0)) OSTIVD,
               0
          FROM snap_balances b1,  accounts a, tmp_sal_acc ca
         WHERE  --b1.CALDT_ID between L_dat1S and L_dat2S
                 b1.fdat between l_dat1 and l_dat2
           and b1.acc = a.acc
           and b1.acc = ca.acc
           AND A.ACC = CA.ACC
         group by a.acc, a.branch,
                  to_number(a.nbs) ,
                  a.kv,
                  a.nls,
                  substr(a.nms,1,70),
                  a.ob22,
                  a.accc;





IF  p_mode1 IN (1, 2, 3) and mode_ = 1   THEN

--  ќ–»√”ё„≤  початок  ѕ≈–≤ќƒ”
insert into CCK_AN_TMP (branch,nbs,kv,nls,name,name1, acc,accl, n1,n2,n3,n4,n5,zalq,zal,rezq, AIM)
SELECT A.BRANCH,
       A.NBS,
       A.KV,
       A.NLS,
       substr(a.nms,1,70),
       A.OB22,
       A.ACC,
       A.ACCC,
       SUM(-AC.DOS+AC.KOS)   AS OSTD,
       SUM(-AC.DOSq+AC.KOSq) AS OSTvD,
       -SUM(AC.DOS) AS DOS,
       -SUM(AC.DOSQ) AS DOSQ,
       -SUM(AC.KOS) AS KOS,
       -SUM(AC.KOSQ) AS KOSQ,
       0   AS OSTID,
       0   AS OSTIVD,
       1
FROM ACCM_LIST_CORRDOCS AC, ACCOUNTS A
 where  caldt_id between l_dat1KSm and l_dat1KS
   AND AC.ACC = A.ACC --AND A.ACCC IS NOT NULL
   and (a.dazs IS NULL or a.dazs>= L_dat1)
   --and trim(a.nls) LIKE p_mask
   and a.acc in (select acc from  tmp_sal_acc)
group by A.ACC,
         A.BRANCH,
         A.NBS,
         A.KV,
         A.NLS,
         substr(a.nms,70),
         A.OB22,
         A.ACCC;


--  ќ–»√”ё„≤ ƒЋя ќ—Ќќ¬Ќќ√ќ –ј’”Ќ ” ѕќ ѕќ¬я«јЌ»ћ
insert into CCK_AN_TMP (branch,nbs,kv,nls,name,name1, acc,accl, n1,n2,n3,n4,n5,zalq,zal,rezq, AIM)
SELECT CA.BRANCH,
       CA.NBS,
       CA.KV,
       CA.NLS,
       substr(ca.nms,1,70),
       CA.OB22,
       A.ACCC,
       NULL,
       SUM(-AC.DOS+AC.KOS) AS OSTD,
       SUM(-AC.DOSq+AC.KOSq) AS OSTvD,
       -SUM(AC.DOS) AS DOS,
       -SUM(AC.DOSQ) AS DOSQ,
       -SUM(AC.KOS) AS KOS,
       -SUM(AC.KOSQ) AS KOSQ,
       0 AS OSTiD,
       0 AS OSTviD,
       11
FROM ACCM_LIST_CORRDOCS AC, ACCOUNTS A, ACCOUNTS CA
 where  caldt_id between  l_dat1KSm and l_dat1KS
   AND AC.ACC = A.ACC AND A.ACCC IS NOT NULL
   and (Ca.dazs IS NULL or Ca.dazs>= L_dat1)
   --and Ca.nls LIKE p_mask AND CA.KV = A.KV
   AND A.ACCC IS NOT NULL
   AND A.ACCC = CA.ACC and ca.acc in (select acc from  tmp_sal_acc)
group by CA.BRANCH,
         CA.NBS,
         CA.KV,
         CA.NLS,
         substr(ca.nms,1,70),
         CA.OB22,
         A.ACCC;

END IF;


IF  p_mode2 IN (1, 2, 3) and mode_ = 1  THEN

--  ќ–»√”ё„≤  к≥нець  ѕ≈–≤ќƒ”
insert into CCK_AN_TMP (branch,nbs,kv,nls,name,name1, acc,accl, n1,n2,n3,n4,n5,zalq,zal,rezq, AIM)
SELECT A.BRANCH,
       A.NBS,
       A.KV,
       A.NLS,
       substr(a.nms,1,70),
       A.OB22,
       A.ACC,
       A.ACCC,
       0 AS OSTD,
       0 AS OSTvD,
       SUM(AC.DOS) AS DOS,
       SUM(AC.DOSQ) AS DOSQ,
       SUM(AC.KOS) AS KOS,
       SUM(AC.KOSQ) AS KOSQ,
       SUM(-AC.DOS+AC.KOS) AS OSTID,
       SUM(-AC.DOSq+AC.KOSq) AS OSTvID,
       2
FROM ACCM_LIST_CORRDOCS AC, ACCOUNTS A
 where  caldt_id between l_dat2KSm and l_dat2KS
   AND AC.ACC = A.ACC --AND A.ACCC IS NOT NULL
   and (a.dazs IS NULL or a.dazs>= L_dat1)
   --and trim(a.nls) LIKE p_mask
   and a.acc in (select acc from  tmp_sal_acc)
group by A.BRANCH,
         A.NBS,
         A.KV,
         A.NLS,
         substr(a.nms,1,70),
         A.OB22,
         A.ACC,
         A.ACCC;


--  ќ–»√”ё„≤ ƒЋя ќ—Ќќ¬Ќќ√ќ –ј’”Ќ ” ѕќ ѕќ¬я«јЌ»ћ
insert into CCK_AN_TMP (branch,nbs,kv,nls,name,name1, acc,accl, n1,n2,n3,n4,n5,zalq,zal,rezq, AIM)
SELECT CA.BRANCH,
       CA.NBS,
       CA.KV,
       CA.NLS,
       substr(ca.nms,1,70),
       CA.OB22,
       A.ACCC,
       NULL,
       0 AS OSTD,
       0 AS OSTvD,
       SUM(AC.DOS) AS DOS,
       SUM(AC.DOSQ) AS DOSQ,
       SUM(AC.KOS) AS KOS,
       SUM(AC.KOSQ) AS KOSQ,
       SUM(-AC.DOS+AC.KOS) AS OSTID,
       SUM(-AC.DOSq+AC.KOSq) AS OSTvID,
       22
FROM ACCM_LIST_CORRDOCS AC, ACCOUNTS A, ACCOUNTS CA
 where  caldt_id between l_dat2KSm and l_dat2KS
   AND AC.ACC = A.ACC AND A.ACCC IS NOT NULL
   and (Ca.dazs IS NULL or Ca.dazs>= L_dat1)
   --and Ca.nls LIKE p_mask AND CA.KV = A.KV
   AND A.ACCC IS NOT NULL
   AND A.ACCC = CA.ACC and ca.acc in (select acc from  tmp_sal_acc)
group by CA.BRANCH,
         CA.NBS,
         CA.KV,
         CA.NLS,
         substr(ca.nms,1,70),
         CA.OB22,
         A.ACCC;

END IF;

--  ≤Ќ≈÷№ ѕ≈–≤ќƒ”.................!!!!!!!!!!


commit;
--Return;
end P_SAL_SNP_KOR;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SAL_SNP_KOR.sql =========*** End
PROMPT ===================================================================================== 
