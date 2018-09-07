CREATE OR REPLACE PACKAGE rko IS
/*
--***************************************************************--
              Плата за расчетно-кассовое обслуживание


-- 14/11/2017 COBUMMFO-5332:  3570/03 -> 3570/37 - переносится только ВХОДЯЩИЙ на 01 число остаток 3570


 Накопление идет по Opldok.FDAT !!!
 ------------------------------------

--***************************************************************--
*/


  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 8  29/05/2017';

  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

PROCEDURE START_FINISH (p_mode int, p_dat DATE DEFAULT NULL);

PROCEDURE acr(mode_ VARCHAR2, dat_ DATE,filt_ VARCHAR2 DEFAULT NULL);
PROCEDURE acr2(mode_ VARCHAR2, dat_ DATE,filt_ VARCHAR2 DEFAULT NULL, p_acc number default null);
PROCEDURE pay(mode_ VARCHAR2, dat_ DATE,filt_ VARCHAR2 DEFAULT NULL);
PROCEDURE pay2(mode_ VARCHAR2, dat_ DATE,filt_ VARCHAR2 DEFAULT NULL, p_acc number default null);
PROCEDURE er(acc_ NUMBER);
END;
/


-----------------------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY BARS.rko IS

/*
  

  COBUMMFO-5332:  3570/03 -> 3570/37 - переносится только ВХОДЯЩИЙ на 01 число остаток 3570/03


*/

  G_BODY_VERSION constant varchar2(64)  := 'version 01.06.2017';

  function header_version return varchar2 is -- возвращает версию заголовка пакета
  begin    return 'Package header RKO '||G_HEADER_VERSION;  end header_version;

  function body_version return varchar2 is ---возвращает версию тела пакета
  begin    return 'Package body RKO '||G_BODY_VERSION;  end body_version;
  ------------
  function Get_NLS_random  (p_R4 accounts.NBS%type ) return accounts.NLS%type   is   --получение № лиц.сч по случ.числам
                            nTmp_ number ;            l_nls accounts.NLS%type ;
  begin
    While 1<2        loop nTmp_ := trunc ( dbms_random.value (1, 999999999 ) ) ;
       begin select 1 into nTmp_ from accounts where nls like p_R4||'_'||nTmp_  ;
       EXCEPTION WHEN NO_DATA_FOUND THEN EXIT ;
       end;
    end loop;         l_nls := vkrzn ( substr(gl.aMfo,1,5) , p_R4||'0'||nTmp_ );
    RETURN l_Nls ;
  end    Get_NLS_random ;
-----------------------------------------------------------------------

PROCEDURE START_FINISH (p_mode int, ---- 1 = фініш,  2 = старт,  .....НЕважл.
                        p_dat DATE DEFAULT NULL  -- Банк.дата
                       ) is    
   l_dat date ;
begin If p_mode not in (1,2) then RETURN; end if;

   l_dat := NVL (p_dat, gl.BDATE) ;

   If p_Mode = 1 then  --- = фініш

      If trunc( l_dat, 'MM' ) < trunc ( DAT_NEXT_U (l_dat,1), 'MM' ) then
         -- Нарахування комісії за РКО 3570-6510,
         --регламентні роботи по закриттю місяця
         RKO.ACR( 1, l_dat, NULL ); -- розрахунок
         RKO.PAY( 1, l_dat, NULL ); -- проводки
      end if;

   ElsIf p_Mode = 2 then  --- = Старт

      -- Перенесення заборгованості на прострочку 3570/03->3570/37
      -- 6 числа кожного місяця

      if To_Number( to_char (l_DAT,'DD') ) >= 6               and    --- тек  дд = 6 или  7, 8 если 6 -выходной
         To_Number( to_char (DAT_NEXT_U(l_DAT,-1),'DD') ) < 6 then   -- -пред дд < 6 

         RKO.PAY( 3, l_DAT, NULL );
      end if;

   end if;

   --Погашення комісії за РКО  2600 -> 3570/37,3570/03
   --Виконується КОЖНОГО робочого дня на Старті

   RKO.PAY( 2, l_dat, ' and a.ACC not in (select ACC from RKO_3570) ' ) ;

end  START_FINISH ;

----------------------------------------------------------------------------------------------------------------


PROCEDURE acr(mode_ VARCHAR2, dat_ DATE, filt_ VARCHAR2 DEFAULT NULL) IS
BEGIN
  acr2(mode_, dat_, filt_, null);
end acr;


PROCEDURE acr2(mode_ VARCHAR2, dat_ DATE, filt_ VARCHAR2 DEFAULT NULL, p_acc number DEFAULT NULL) IS

---- ( 1 )   Накопление платы за РКО              --
/*

Если mode_ <0, то это  расчет по одному РКК = -mode_,
он предназначен для печати по одному клиенту

*/
-----------------------------------------------------
  acc_   NUMBER;
  accd_  NUMBER;

  s_     NUMBER(24);
  kol_   INT;           --  количество документов
  sdok_  NUMBER(24);    --  cумма документов
  s0_    NUMBER(24);
  tdat_  DATE;
  fdat_  DATE;
  daos_  DATE;
  nls_   VARCHAR2(15);
  c0     SYS_REFCURSOR;
  --- fdat_2560   date;   --  Дата "ПО"+1 для 2560. Дата fdat_ нач.периода рассчета
  DKON_KV1    date;   --  ДАТА посл.раб.дня КВАРТАЛА рассчитанная для fdat_
  DKON_KV     date;   --  ДАТА посл.раб.дня КВАРТАЛА рассчитанная для dat_
  kol_2560    INT ;   --  количество счетов 2560

  n_tarpak    NUMBER ; -- № тарифного пакета
  L_DOC_NOPAY INTEGER; --количество бесплатних документов
  l_shtar     accountsw.value%type;
BEGIN

   n_tarpak:= 0;

   If mode_<0 then

      --  Определяем дату последнего раб.дня КВАРТАЛА, в который
      --  входит НАЧАЛЬНАЯ дата расчетного периода :

      EXECUTE IMMEDIATE ' TRUNCATE TABLE CCK_AN_TMP ' ;

      -- Начальная дата периода:
      fdat_    := to_date(filt_,'dd.mm.yyyy');

      If    to_char (fdat_,'MM') in ('03','06','09','12') then
            DKON_KV := Dat_last( fdat_);
      elsIf to_char (fdat_,'MM') in ('02','05','08','11') then
            DKON_KV := Dat_last( add_months( fdat_,1) ) ;
      else
            DKON_KV := Dat_last( add_months( fdat_,2) ) ;
      end if;

   else

      --  Определяем дату последнего раб.дня текущего КВАРТАЛА,  
      --  по КОНЕЧНОЙ дате dat_ :
             --------

      If    to_char (dat_,'MM') in ('03','06','09','12') then
            DKON_KV := Dat_last( dat_);
      elsIf to_char (dat_,'MM') in ('02','05','08','11') then
            DKON_KV := Dat_last( add_months(dat_,1) ) ;
      else
            DKON_KV := Dat_last( add_months(dat_,2) ) ;
      end if;

   end if;


   IF deb.debug THEN deb.trace(1,filt_,0); END IF;


   If mode_<0 then

      EXECUTE IMMEDIATE ' TRUNCATE TABLE CCK_AN_TMP ' ;

      OPEN c0 FOR
      'select acc,daos from accounts a
       where  rnk in
       (select n.rnk from RNKP_KOD n, KOD_CLI k
        where n.kodk=k.KOD_CLI and k.KOD_CLI=' || to_char(- mode_ ) ||  ') ';

   else

      if p_acc is null then

         OPEN c0 FOR
         'select r.acc,a.daos from rko_lst r,accounts a
          where r.acc=a.acc and ( dat0b<:dat_ or dat0b is null ) '|| filt_ USING dat_;

      else

         OPEN c0 FOR
         'select r.acc,a.daos from rko_lst r,accounts a
          where r.acc=a.acc and ( dat0b<:dat_ or dat0b is null ) and r.acc= '|| p_acc ||' '|| filt_ USING dat_;

      end if;

   end if;


   LOOP

   FETCH c0 INTO acc_,daos_; EXIT WHEN c0%NOTFOUND;

      SAVEPOINT beforko0;

      IF deb.debug THEN deb.trace(1,filt_,acc_); END IF;

   If mode_<0 then
      null;
   else
      BEGIN
         SELECT NVL(accd,acc),NVL(dat0b+1,daos_),s0
           INTO accd_,fdat_,s0_ FROM rko_lst
          WHERE acc=acc_ FOR UPDATE NOWAIT;
      EXCEPTION
         WHEN OTHERS THEN ROLLBACK TO beforko0; er(acc_); GOTO nextrec0;
      END;
   end if;


   BEGIN --  Накопление за период [fdat_,dat_] вкл-но ПО 1-му СЧЕТУ acc_
         --                                           ===================
         --  fdat_ = "По"+1
         --  dat_  = дата, по которую задано накопление


   --  Определяем  № ТАРИФНОГО ПАКЕТА счета  и  Количество бесплатныx
   --  документов для этого пакета

       BEGIN
          SELECT t.ID,      nvl(t.DOC_NOPAY,0)
          INTO   n_tarpak,  L_DOC_NOPAY
          FROM   AccountsW w, Tarif_Scheme t
          WHERE  w.ACC = acc_
             AND w.TAG = 'SHTAR'
             AND to_number(w.VALUE) = t.ID;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          L_DOC_NOPAY := 0;
          n_tarpak    := 0;
       END;

----------------------   Р А С Ч Е Т   --------------------------


IF  n_tarpak >= 38 THEN        ----     П А К Е Т Ы  >=  38    ----


      IF MODE_<0 THEN           ---<--  Для 412 отчета

         INSERT INTO CCK_AN_TMP ( reg, NLS, acc, N1, PR, N2 )
          ----------------------------------------------------------
          -- 1 --   По ДЕБЕТУ / только IB1,IB2,CL1,CL2     -- 412 --
          ----------------------------------------------------------
          SELECT rnk, nls , acc,  s,  pr,  COUNT(*)
          FROM (Select rnk, nls, acc, ref,s, pr , rownum R
                From (SELECT a.rnk, a.NLS, a.acc, o.ref,
                             F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                          DKON_KV,
                                          o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                          o.D_REC, o.REF
                                         ) S,
                             T.DK+D.DK PR
                      FROM   Oper o, Opldok d, Accounts a, RKO_TTS t
                      WHERE  a.acc=acc_
                         and a.acc=d.acc
                         and d.ref=o.ref
                         and (t.TT like 'IB%' or  t.TT like 'CL%')  ---<-   Только IB*,CL*
                         and d.sos=5
                         and d.fdat >= to_date(filt_,'dd.mm.yyyy')
                         and d.fdat <  dat_+1
                         and d.tt = t.tt
                         and (t.dk = 0 and d.dk = 0)          ---  за ДЕБЕТ (412)
                         and D.S > 0
                         and F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                          DKON_KV,
                                          o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                          o.D_REC, o.REF
                                         ) > 0
                      ORDER by o.ref
                     )
               )
          WHERE R > L_DOC_NOPAY
          Group by rnk,nls,acc,s,pr
                              UNION ALL
          ----------------------------------------------------------
          -- 2 --   По ДЕБЕТУ / кроме IB1,IB2,CL1,CL2      -- 412 --          n_tarpak >= 38
          ----------------------------------------------------------
          SELECT rnk, nls , acc,  s,  pr,  COUNT(*)
          FROM (Select rnk, nls, acc, ref,s, pr , rownum R
                From (SELECT a.rnk, a.NLS, a.acc, o.ref,
                             F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                          DKON_KV,
                                          o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                          o.D_REC, o.REF
                                         ) S,
                             T.DK+D.DK PR
                      FROM   Oper o, Opldok d, Accounts a, RKO_TTS t
                      WHERE  a.acc=acc_
                         and a.acc=d.acc
                         and d.ref=o.ref
                         and t.TT not like 'IB%' and t.TT not like 'CL%'   ---<-  Kроме IB*,CL*
                         and d.sos=5
                         and d.fdat >= to_date(filt_,'dd.mm.yyyy')
                         and d.fdat <  dat_+1
                         and d.tt = t.tt
                         and (t.dk = 0 and d.dk = 0)          ---  за ДЕБЕТ (412)
                         and D.S > 0
                         and F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                          DKON_KV,
                                          o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                          o.D_REC, o.REF
                                         ) > 0
                      ORDER by o.ref
                     )
               )
          ----  WHERE R > L_DOC_NOPAY
          Group by rnk,nls,acc,s,pr
                              UNION ALL
          ----------------------------------------------------------
          -- 3 --   По КРЕДИТУ                           -- 412 --         n_tarpak >= 38
          ----------------------------------------------------------
          SELECT rnk, nls , acc,  s,  pr,  COUNT(*)
          FROM (Select rnk, nls, acc, ref,s, pr , rownum R
                From (SELECT a.rnk, a.NLS, a.acc, o.ref,
                             F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                          DKON_KV,
                                          o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                          o.D_REC, o.REF
                                         ) S,
                             T.DK+D.DK PR
                      FROM   Oper o, Opldok d, Accounts a, RKO_TTS t
                      WHERE  a.acc=acc_
                         and a.acc=d.acc
                         and d.ref=o.ref
                         and d.sos=5
                         and d.fdat >= to_date(filt_,'dd.mm.yyyy')
                         and d.fdat <  dat_+1
                         and d.tt = t.tt
                         and (t.dk = 1 and d.dk = 1)         --- за КРЕДИТ (412)
                         and D.S > 0
                         and F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                          DKON_KV,
                                          o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                          o.D_REC, o.REF
                                         ) > 0
                      ORDER by o.REF
                     )
               )
      --- WHERE R > L_DOC_NOPAY    -- за КРЕДИТ колич.бесплатных НЕ учитываем !
          Group by RNK,NLS,ACC,S,PR ;


      ELSE       ------------  Р е а л ь н ы й   р а с ч е т :         n_tarpak >= 38


        Select NLS , sum(SUMS), sum(CNT), sum(SUMDOK)
        into   nls_, s_       , kol_    , sdok_
        From
        (
          -----------------------------------------------------------------
          -- 1 --     По ДЕБЕТУ / только IB1,IB2,CL1,CL2   -- Реал.расч. --       n_tarpak >= 38
          -----------------------------------------------------------------
          SELECT NLS , sum(S) SUMS, COUNT(*) CNT, sum(sdok) SUMDOK
          FROM
             (Select NLS, S, SDOK, REF, rownum R  FROM
               (SELECT nls, S, SDOK, ref  FROM
                    (SELECT a.NLS nls,
                          F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                       DKON_KV,
                                       o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                       o.D_REC, o.REF
                                     ) S,
                          d.S SDOK, o.ref
                     FROM  Oper o, Opldok d, Accounts a, RKO_TTS t
                     WHERE a.acc=acc_
                       and a.acc=d.acc
                       and d.ref=o.ref
                       and (t.TT like 'IB%' or t.TT like 'CL%')   ---<  только IB*,CL*  !
                       and d.sos=5
                       and d.fdat >=fdat_
                       and d.fdat < dat_+1
                       and d.tt = t.tt
                       and (t.dk = 0 and d.dk = 0)  --- за ДЕБЕТ (реальный расчет)
                       and D.S > 0
                    )
                WHERE S>0  order by REF
               )
             )
          WHERE R > L_DOC_NOPAY  --- Бесплатные по Дт только IB* !
          Group by NLS
                                 UNION ALL
          --------------------------------------------------------------
          -- 2 --     По ДЕБЕТУ / кроме IB1,IB2,CL1,CL2  -- Реал.расч.--      n_tarpak >= 38
          --------------------------------------------------------------
          SELECT NLS , sum(S) SUMS, COUNT(*) CNT, sum(sdok) SUMDOK
          FROM
             (Select NLS, S, SDOK, REF, rownum R  FROM
               (SELECT nls, S, SDOK, ref  FROM
                    (SELECT a.NLS nls,
                          F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                       DKON_KV,
                                       o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                       o.D_REC, o.REF
                                     ) S,
                          d.S SDOK, o.ref
                     FROM  Oper o, Opldok d, Accounts a, RKO_TTS t
                     WHERE a.acc=acc_
                       and a.acc=d.acc
                       and d.ref=o.ref
                       and t.TT not like 'IB%'  and  t.TT not like 'CL%' ---<  кроме IB*,CL*  !
                       and d.sos=5
                       and d.fdat >=fdat_
                       and d.fdat < dat_+1
                       and d.tt = t.tt
                       and (t.dk = 0 and d.dk = 0)   --- за ДЕБЕТ (реальный расчет)
                       and D.S > 0
                    )
                WHERE S>0  order by REF
               )
             )
          --- WHERE R > L_DOC_NOPAY   --- Бесплатные только IB*
          Group by NLS
                                 UNION ALL
          -------------------------------------------------------
          -- 3 --     По КРЕДИТУ:                 -- Реал.расч.--      n_tarpak >= 38
          -------------------------------------------------------
          SELECT NLS , SUM(s) sums, COUNT(*) cnt, SUM(sdok) sumsdok
          FROM
             (Select NLS, S, SDOK, REF, rownum R  FROM
               (SELECT nls, S, SDOK, ref  FROM
                    (SELECT a.NLS nls,
                          F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                       DKON_KV,
                                       o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                       o.D_REC, o.REF
                                     ) S,
                          d.S SDOK, o.ref
                     FROM  Oper o, Opldok d, Accounts a, RKO_TTS t
                     WHERE a.acc=acc_
                       and a.acc=d.acc
                       and d.ref=o.ref
                       and d.sos=5
                       and d.fdat >=fdat_
                       and d.fdat < dat_+1
                       and d.tt = t.tt
                       and (t.dk = 1 and d.dk = 1)  --- за КРЕДИТ (реальный расчет)
                       and D.S > 0
                    )
                WHERE S>0  order by REF
               )
             )
     ---  WHERE R > L_DOC_NOPAY  -- за КРЕДИТ колич.бесплатных НЕ учитываем !
          Group by NLS
        )
        Group by NLS;

      END IF ;



---------------------------------------------------------------------
ELSE       ---   По-старому:   ПАКЕТЫ  0 - 37                             n_tarpak < 38
---------------------------------------------------------------------



      IF MODE_<0 THEN             ---<--  Для 412 отчета

         INSERT INTO CCK_AN_TMP ( reg, NLS, acc, N1, PR, N2 )
          SELECT rnk, nls , acc,  s,  pr,  COUNT(*)
          FROM (Select rnk, nls, acc, ref,s, pr , rownum R
                From (SELECT a.rnk, a.NLS, a.acc, o.ref,
                             F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                          DKON_KV,
                                          o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                          o.D_REC, o.REF
                                         ) S,
                             T.DK+D.DK PR
                      FROM   Oper o, Opldok d, Accounts a, RKO_TTS t
                      WHERE  a.acc=acc_
                         and a.acc=d.acc
                         and d.ref=o.ref
                         and d.sos=5
                         and d.fdat >= to_date(filt_,'dd.mm.yyyy')
                         and d.fdat <  dat_+1
                         and d.tt = t.tt
                         and (t.dk = 0 and d.dk = 0)          ---  за ДЕБЕТ (412)
                         and D.S > 0
                         and F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                          DKON_KV,
                                          o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                          o.D_REC, o.REF
                                         ) > 0
                      ORDER by o.ref
                     )
               )
          WHERE R > L_DOC_NOPAY
          Group by rnk,nls,acc,s,pr
                              UNION ALL
          SELECT rnk, nls , acc,  s,  pr,  COUNT(*)
          FROM (Select rnk, nls, acc, ref,s, pr , rownum R
                From (SELECT a.rnk, a.NLS, a.acc, o.ref,
                             F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                          DKON_KV,
                                          o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                          o.D_REC, o.REF
                                         ) S,
                             T.DK+D.DK PR
                      FROM   Oper o, Opldok d, Accounts a, RKO_TTS t
                      WHERE  a.acc=acc_
                         and a.acc=d.acc
                         and d.ref=o.ref
                         and d.sos=5
                         and d.fdat >= to_date(filt_,'dd.mm.yyyy')
                         and d.fdat <  dat_+1
                         and d.tt = t.tt
                         and (t.dk = 1 and d.dk = 1)         --- за КРЕДИТ (412)
                         and D.S > 0
                         and F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                          DKON_KV,
                                          o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                          o.D_REC, o.REF
                                         ) > 0
                      ORDER by o.REF
                     )
               )
      --- WHERE R > L_DOC_NOPAY    -- за КРЕДИТ колич.бесплатных НЕ учитываем !
          Group by RNK,NLS,ACC,S,PR ;


      ELSE       ------------------     Реальный рассчет :              n_tarpak < 38
                                                                        --------------

        Select NLS , sum(SUMS), sum(CNT), sum(SUMDOK)
        into   nls_, s_       , kol_    , sdok_
        From
        (
          SELECT NLS , sum(S) SUMS, COUNT(*) CNT, sum(sdok) SUMDOK
          FROM
             (Select NLS, S, SDOK, REF, rownum R  FROM
               (SELECT nls, S, SDOK, ref  FROM
                    (SELECT a.NLS nls,
                          F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                       DKON_KV,
                                       o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                       o.D_REC, o.REF
                                     ) S,
                          d.S SDOK, o.ref
                     FROM  Oper o, Opldok d, Accounts a, RKO_TTS t
                     WHERE a.acc=acc_
                       and a.acc=d.acc
                       and d.ref=o.ref
                       and d.sos=5
                       and d.fdat >=fdat_
                       and d.fdat < dat_+1
                       and d.tt = t.tt
                       and (t.dk = 0 and d.dk = 0)   --- за ДЕБЕТ (реальный расчет)
                       and D.S > 0
                    )
                WHERE S>0  order by REF
               )
             )
          WHERE R > L_DOC_NOPAY      --- Бесплатные документы по Дт !
          Group by NLS
                                 UNION ALL
          SELECT NLS , SUM(s) sums, COUNT(*) cnt, SUM(sdok) sumsdok
          FROM
             (Select NLS, S, SDOK, REF, rownum R  FROM
               (SELECT nls, S, SDOK, ref  FROM
                    (SELECT a.NLS nls,
                          F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                       DKON_KV,
                                       o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                       o.D_REC, o.REF
                                     ) S,
                          d.S SDOK, o.ref
                     FROM  Oper o, Opldok d, Accounts a, RKO_TTS t
                     WHERE a.acc=acc_
                       and a.acc=d.acc
                       and d.ref=o.ref
                       and d.sos=5
                       and d.fdat >=fdat_
                       and d.fdat < dat_+1
                       and d.tt = t.tt
                       and (t.dk = 1 and d.dk = 1)  --- за КРЕДИТ (реальный расчет)
                       and D.S > 0
                    )
                WHERE S>0  order by REF
               )
             )
     ---  WHERE R > L_DOC_NOPAY  -- за КРЕДИТ колич.бесплатных НЕ учитываем !
          Group by NLS
        )
        Group by NLS;

      END IF ;

END IF;

--------------------------------------------------------------------

    EXCEPTION
       WHEN NO_DATA_FOUND THEN s_:= 0; kol_:= 0; sdok_:= 0;
       WHEN OTHERS        THEN ROLLBACK TO beforko0; er(acc_); GOTO nextrec0;
    END;


    IF deb.debug THEN deb.trace(1,'Acrued for '||nls_,s_); END IF;

--                          ВНИМАНИЕ !
--    Дату "С" после начисления меняем только в одном случае - когда до
--    начисления она была = NULL.  Причем меняем ee на DAOS:


    If mode_<0 then
       null;                    ----  Сухова 27-04-2010. Черкассы
    ELSE
       UPDATE rko_lst SET dat0a=NVL(dat0a,daos_), dat0b=dat_, s0=s0+s_,
              KOLDOK=KOLDOK+kol_,
              SUMDOK=SUMDOK+sdok_,
              comm=NULL    WHERE acc=acc_;

--     Eсли после начисления "Начислено" = 0, то меняем "С" на "По"+1,
--     ( по счетам с "Начислено" > 0, дата "С" поменяется на "По"+1 после
--       порождения автопроводок ):

       UPDATE rko_lst SET dat0a=dat_+1 WHERE  acc=acc_  and  s0=0;

    End If;

    COMMIT;
<<nextrec0>>
    NULL;

   END LOOP;
   CLOSE c0;
END acr2;
--------------------------------------------------------------------------------------------------------
-- COBUMMFO-8905 Перенесли логику OP_BS_OB в пакет. Нужно, чтобы немного по другому работала
--------------------------------------------------------------------------------------------------------
procedure OP_BS_OB_LOCAL( P_BBBOO varchar2 )
is
   aa accounts%rowtype;
------------------------------------------------------------------------
begin
  bars_audit.trace( 'RKO.OP_BS_OB_LOCAL : Entry with P_BBBOO='||P_BBBOO );

  aa.NBS  := substr(P_BBBOO,1,4);
  aa.OB22 := substr(P_BBBOO,5,2);
  aa.kv   := nvl ( to_number( pul.get_mas_ini_val ('OP_BSOB_KV') ), gl.baseval );
  aa.kv   := nvl ( aa.kv, 980 );

  bars_audit.trace( 'RKO.OP_BS_OB_LOCAL : nbs='||aa.NBS||', OB22='||aa.OB22||', KV='||to_char(aa.kv) );

  for p in ( select BRANCH
               from BARS.BRANCH
              where BRANCH like '/'||gl.aMfo||'/______/'
                and DATE_CLOSED is null )
  loop
    begin
      -- м.б. уже есть
      select *
        into aa
        from accounts
       where branch = p.BRANCH
         and nbs  = aa.nbs
         and ob22 = aa.ob22
         and kv   = aa.kv
         and dazs is null
         and rownum = 1;
    EXCEPTION
       WHEN NO_DATA_FOUND THEN
		  -- Если ничего не нашли - ничего не восстанавливаем
          -- Просто пишем в лог
          bars_audit.error('RKO.OP_BS_OB_LOCAL Помилка: Рахунок '||aa.nbs||'/'||aa.ob22||' по відділенню '||p.BRANCH||'не знайдено');         
    end;
  end loop;

  bars_audit.trace( 'RKO.OP_BS_OB_LOCAL : Exit.' );

end;

---======================================================================================================

PROCEDURE pay2(mode_ VARCHAR2, dat_ DATE,filt_ VARCHAR2 DEFAULT NULL, p_acc number default null) IS
-- ---------------------------------------------------
--          ( 2 )   Взыскание платы за РКО          --
-- ---------------------------------------------------
acc1_zakr  INT;
acc2_zakr  INT;

acc_     NUMBER;        --  ACC   основного счета
nlsosn_  VARCHAR2(15);  --  NLS    --//--
rnk_osn  NUMBER;        --  RNK    --//--
nam_osn  VARCHAR2(38);  --  NMS    --//--
br_osn   VARCHAR2(30);  --  BRANCH --//--


accd_    NUMBER;        --  ACC   счета-списания (счета-плательщика)
nlsa_    VARCHAR2(15);  --  NLS    --//--
rnk_     NUMBER;        --  RNK    --//--
nam_a_   VARCHAR2(38);  --  NMS    --//--
isp_     NUMBER;        --  ISP    --//--
br_      VARCHAR2(30);  --  BRANCH --//--


i        INT;
s_     NUMBER(24);
s0_    NUMBER(24);
kol_   INT;           --  количество документов
sdok_  NUMBER(24);    --  cумма документов
s0a_   NUMBER(24);
s1_    NUMBER(24);    --  текущий остаток 3570
s1_01  NUMBER(24);    --  входящий на нач.месяца остаток 3570
kos_3570  NUMBER(24); --  сумма KOS по 3570 с 01 по тек.день
s1a_   NUMBER(24);
s2_    NUMBER(24);
s2a_   NUMBER(24);
ostc_  NUMBER(24);
nls_   VARCHAR2(15);
nlsb_  VARCHAR2(65);

nlsc_  VARCHAR2(15);   --  NLS 3570
acc1_  NUMBER;         --  ACC 3570

nlsd_  VARCHAR2(15);   --  NLS 3579
acc2_  NUMBER;         --  ACC 3579

kkk_   number;

tmp_3570  VARCHAR2(15);
tmp_   NUMBER;
flg_   NUMBER;
grp_   NUMBER;
kva_   NUMBER;
kvb_   NUMBER := 980;
tt_    CHAR(3):='RKO';
ref_   NUMBER;
nam_b_ VARCHAR2(38);
nam_c_ VARCHAR2(38);
nam_d_ VARCHAR2(38);
okpo_  VARCHAR2(14);
tobo_a     tobo.tobo%type;-- код ТОБО счета 2600
mfo_a      VARCHAR2(12);-- "MFO процесс.рахунку" счета 2600, если он в BANK_ACC
nlsb_tobo  VARCHAR2(15);-- счет 6510 из TOBO_PARAMS: TOBO=tobo_a, TAG='RKO6110'
nam_b_tobo VARCHAR2(38);-- Accounts.NMS счета nlsb_tobo


nd_rko_    VARCHAR2(50);
z_po       VARCHAR2(40);

nn2560     INT;            --  Колич. счетов, к которым привязан один конкр.
                           --  3570,  который гасится
scheta     VARCHAR2(100);  --  Перечень этих счетов
nazn_gah   VARCHAR2(200);


dat0a_  DATE;
dat1a_  DATE;
dat2a_  DATE;

dat0b_  DATE;
dat1b_  DATE;
dat2b_  DATE;

dat0a_t  DATE;
dat0b_t  DATE;

blkd_    NUMBER;     --  блокированность на Дт счета-плательщика

NO_MONEY EXCEPTION;
PRAGMA EXCEPTION_INIT(NO_MONEY, -20203);

c0     SYS_REFCURSOR;

erm  VARCHAR2 (80)           ;
ern  CONSTANT POSITIVE       := 200         ;
err  EXCEPTION               ;


BEGIN


  If INSTR(mode_,'1') > 0  THEN
     OP_BS_OB_LOCAL(P_BBBOO => '651006');  ---   открытие 6510/06
  End If;


----------  Проверяем:  насторена ли операция "RKO" ?  ------------
   BEGIN
      SELECT substr(flags,38,1) INTO flg_
        FROM tts
       WHERE tt='RKO';
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         erm:='9701 - Не настроена операция RKO !';
         RAISE err;
   END;
--------------------------------------------------------------------

--  Удаляем 3570 ( RKO_LST.ACC1 = null ) у счетов 2600, которые сидят в "Плате за РО", если 
--  этот же 3570 встречается в счетах 2600, сидящих в "Плате за РО - только на 3570".
--  То же самое делаем с 3579 (3570/37 - в новом ПС)


   UPDATE RKO_LST set ACC1=null where
      ACC not in (Select ACC from RKO_3570)   and
      ACC1 in (Select ACC1 from RKO_LST where ACC in (Select ACC from RKO_3570));
            
   UPDATE RKO_LST set ACC2=null where
      ACC not in (Select ACC from RKO_3570)   and
      ACC2 in (Select ACC2 from RKO_LST where ACC in (Select ACC from RKO_3570));

--------------------------------------------------------------------

   deb.trace(3,'DATE',dat_);


----=============    Начало цикла по счетам RKO_LST:   ================

   if p_acc is null then

      OPEN c0 FOR
     'SELECT r.acc FROM rko_lst r,accounts a
      WHERE r.acc=a.acc AND ( dat0b<:1 OR dat0b IS NULL OR 1=1 ) '||filt_
       ||' order by DAT1B desc'  USING dat_;

   else

      OPEN c0 FOR
     'SELECT r.acc FROM rko_lst r,accounts a
      WHERE r.acc=a.acc AND ( dat0b<:1 OR dat0b IS NULL OR 1=1 ) and r.acc= '||p_acc||' '||filt_
       ||' order by DAT1B desc'  USING dat_;

   end if;

   LOOP

   FETCH c0 INTO acc_; EXIT WHEN c0%NOTFOUND;

      begin -- COBUMMFO-8905 Делаем обертку, чтобы не выпускать исключения во вне
      SAVEPOINT beforko1;

      -- Читаем запись в RKO_LST.   acc_ - ACC основного счета.
                                    ---------------------------
      BEGIN
         SELECT NVL(accd,acc),dat0a,dat0b,s0,
                dat1a,dat1b,acc1,dat2a,dat2b,acc2,
                KOLDOK,SUMDOK
           INTO accd_,dat0a_,dat0b_,s0_,dat1a_,dat1b_,acc1_,dat2a_,dat2b_,acc2_,
                kol_, sdok_
           FROM rko_lst
          WHERE acc=acc_ FOR UPDATE NOWAIT;
      EXCEPTION
         WHEN OTHERS THEN ROLLBACK; er(acc_); GOTO nextrec3;
      END;

      -- Определяем все по основному счету  acc_ :
      BEGIN                ----------------------
         SELECT NLS, RNK, substr(NMS,1,38), BRANCH
           INTO nlsosn_, rnk_osn, nam_osn , br_osn
           FROM accounts
          WHERE acc=acc_;
      END;

      --  Определяем все по счету-списания accd_ :
                            ----------------------
      SELECT a.nls,a.kv, a.ostc+nvl(a.lim,0), a.isp, a.grp, c.rnk,
             NVL(TRIM(c.nmkk),TRIM(SUBSTR(c.nmk,1,38))), c.okpo,
             a.TOBO, a.BLKD, a.BRANCH
      INTO nlsa_,kva_,ostc_,isp_,grp_,rnk_,nam_a_,okpo_,tobo_a,
           blkd_, br_
      FROM accounts a,customer c
      WHERE a.acc=accd_ AND a.rnk=c.rnk;

      kkk_:=0;              ----  Определяем kkk_ - Kод Корп.Клиента
      BEGIN
        Select KODK  Into  kkk_
        From   RNKP_KOD
        Where  RNK = rnk_  and  KODK is not NULL and rownum=1;
      EXCEPTION  WHEN NO_DATA_FOUND THEN
        kkk_:=0;
      END;

------   Определяем 6510 (nlsb_tobo) для текущ. 2600 только при --------------
------   КНОПКАХ "0" и "1"  и  если начисл.сумма s0_>0 :        --------------

   IF ( INSTR(mode_,'0')>0  OR  INSTR(mode_,'1')>0 ) and s0_>0   then
      BEGIN                            -- 1. Вначале ищем "индивидуальный"
         SELECT  trim(VALUE)           --    6510 в AccountsW/TAG='S6110'
         into    nlsb_tobo
         FROM    AccountsW
         WHERE   ACC=acc_ and TAG='S6110' and VALUE is not NULL and trim(VALUE) like '6510%' ;
      EXCEPTION  WHEN NO_DATA_FOUND THEN
         nlsb_tobo := NULL;
      END;

      If nlsb_tobo is not NULL then
         BEGIN
           Select NLS into  nlsb_tobo
           From   Accounts
           Where  NLS=nlsb_tobo and DAZS is NULL;
         EXCEPTION  WHEN NO_DATA_FOUND THEN
           nlsb_tobo := NULL;
         END;
      End If;

                                       -- 2). Ищем 6510 по ОВ22 в этом или
                                       --     вышестоящем BRANCH-e:       
      IF nlsb_tobo is NULL THEN        

         nlsb_tobo := NBS_OB22_NULL( '6510','06',tobo_a );

         If nlsb_tobo is NULL  then    --    Не найден счет 6510/06.  Открываем !
----------- raise_application_error(-20000,'Не найден счет 6510/06 на '||substr(tobo_a,1,15), true);   
            nlsb_tobo := RKO.Get_NLS_random ('6510') ;  -- получение № лиц.сч 6510 по случ.числам
            Select ISP, RNK, ACC into isp_6510, rnk_6510, acc_6510_1  --- для нахождения ISP,RNK и доступа берем любой счет 6% этого бранча
            from   Accounts 
            where  NBS like '6%' and DAZS is NULL and BRANCH = substr(tobo_a,1,15) and rownum = 1 ;

            OP_REG(99, 0, 0, grp_, tmp_, rnk_6510, nlsb_tobo, 980, 'За обробку документів субєктів господарювання','ODB', isp_6510, acc_6510);
            p_setAccessByAccmask(acc_6510, acc_6510_1);      ---  копируем доступ из acc_6510_1
            Accreg.setAccountSParam( acc_6510, 'OB22', '06' ) ;
            UPDATE accounts set  TOBO = substr(tobo_a,1,15)  WHERE acc = acc_6510;

         End If;

         END IF;
      END IF;

      BEGIN             ---  Определяем NMS счета  nlsb_tobo (6510)
        SELECT SUBSTR(NMS,1,38)
        INTO   nam_b_tobo
        FROM   accounts
        WHERE  NLS = nlsb_tobo  and  KV = 980  and  DAZS is NULL;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        raise_application_error(-20000, 'Счет '||nlsb_tobo||' для '||nlsosn_||'  НЕ НАЙДЕН !', true);
      END;

   END IF;
-------------------- END поиска 6510 ----------------------------------
      ----nlsc_:= VKRZN(SUBSTR(gl.aMFO,1,5),'3570'||SUBSTR(nlsa_,5));
      ----nlsd_:= RKO.Get_NLS_random  ('3570') ;  --получение № лиц.сч по случ.числам

      IF acc1_ IS NULL THEN
         s1_ := 0 ;
      ELSE                     --     s1_  - остаток на ACC1 (3570/03)
         BEGIN
            SELECT nls,-ostc INTO nlsc_, s1_ 
            FROM   accounts
            WHERE  acc=acc1_ ;   
         EXCEPTION WHEN NO_DATA_FOUND THEN
            s1_:=0;
         END;
      END IF;

      IF acc2_ IS NULL THEN
         s2_:=0;
      ELSE                     --     s2_  - остаток на ACC2 (3570/37)
         BEGIN
            SELECT nls,-ostc INTO nlsd_, s2_ 
            FROM   accounts
            WHERE  acc=acc2_ ;   
         EXCEPTION WHEN NO_DATA_FOUND THEN
            s2_:=0;
         END;
      END IF;

----================================================================
---                  ПРОВОДКИ по кнопкам 0,1,2,3:
----================================================================
-- 0.  Взыскание платы за РКО  (кнопка "0"):     2600 ---> 6510
---------------------------------------------------------------------
      IF INSTR(mode_,'0') > 0 AND s0_>0 AND ostc_>0 AND ostc_>=s0_ THEN  -- Попробуем начисленную плату взыскать
         s0a_:= s0_;      --  cумма проводки 2600-6510
         BEGIN
            SAVEPOINT beforko2;
            gl.ref (ref_);
            INSERT INTO oper (ref,tt,vob,nd,dk,Pdat, Vdat, Datd, datP,
                             nlsa,nam_a,mfoa,nlsb,nam_b,mfob,
                             kv,s,kv2,s2,id_a,id_b,userid,nazn)
            VALUES ( ref_,tt_,6,case when length(ref_)>10 then substr(ref_, -10) else to_char(ref_) end,1,SYSDATE,  gl.bDATE,gl.bDATE, gl.bDATE,
                nlsa_,nam_a_,gl.aMFO,  nlsb_tobo,  nam_b_tobo,gl.aMFO,kva_,s0a_,kvb_,s0a_,
                       okpo_,gl.aOKPO,gl.aUID,
            'За розрахункове обслуговування рах. '||nlsosn_
              ||' з '
              ||TO_CHAR(dat0a_,'DD.MM.YYYY')||' по '
              ||TO_CHAR(dat0b_,'DD.MM.YYYY')||'. Документiв '
              ||trim(to_char(kol_))||', на суму '
              ||trim(to_char(sdok_/100,'9999999990D00'))||' грн.'
                   );

            gl.payv(flg_,ref_,gl.bDATE,tt_,1,980,nlsa_,s0a_,980, nlsb_tobo, s0a_);

            insert into oper_visa (ref, dat, userid, status)
            values (ref_, sysdate, user_id, 0);

--  Меняем дату "С" на "По"+1 (dat0a=dat0b+1) - фиксируем начало следующего
--                                              периода.
--  Дату "По" (dat0b) не меняем:

            UPDATE rko_lst SET s0=s0-s0a_, comm=NULL,
                               KOLDOK=0,
                               SUMDOK=0,
                               dat0a=dat0b+1  WHERE acc=acc_;

            s0_:= s0_ - s0a_; ostc_:= ostc_ -s0a_;

         EXCEPTION
            WHEN NO_MONEY THEN ROLLBACK TO beforko2; er(acc_);
            WHEN OTHERS   THEN ROLLBACK TO beforko1; er(acc_); GOTO  nextrec1;
         END;
      END IF;

----------------------------------------------------------------------------
-- 1.  Начисление на 3570  (кнопка "1"):      3570/03 --> 6510
----------------------------------------------------------------------------
      IF INSTR(mode_,'1') > 0 AND s0_>0 THEN  -- На прострочку
         BEGIN
            SAVEPOINT beforko3;

            acc1_zakr:=1;
            if acc1_ is not NULL then
               Begin
                 Select 1 into acc1_zakr
                 from   Accounts
                 where  ACC=acc1_ and DAZS is NULL;
               EXCEPTION when no_data_found then
                 acc1_zakr:=0;   --- acc1_ или ЗАКРЫТ или такого acc1_
               END;              --- вообще нет в ACCOUNTS
            end if;

            IF acc1_ is NULL  or  acc1_zakr=0  THEN
               nlsc_ := RKO.Get_NLS_random ('3570') ;  -- получение № лиц.сч 3570/03 по случ.числам

               OP_REG(99,0,0, grp_,tmp_, rnk_, nlsc_,kva_, substr('Нарах.РКО '||nam_a_,1,70),'ODB',isp_,acc1_);
               p_setAccessByAccmask(acc1_,accd_);
               Accreg.setAccountSParam( acc1_, 'OB22', '03' ) ;
               Accreg.setAccountSParam( acc1_, 'R013', '3'  ) ;
               Accreg.setAccountSParam( acc1_, 'S240', '1'  ) ;
               UPDATE rko_lst SET acc1=acc1_ WHERE acc=acc_;
               UPDATE accounts set  TOBO =  br_  WHERE acc=acc1_;
            END IF;
            ----------  Еnd открытия АСС1 - 3570/03 ---------------

            gl.ref (ref_);

            Insert into OPER (ref,tt,vob,nd,dk,pdat,vdat,datd, datP,
                              nlsa,nam_a,mfoa,nlsb,nam_b,mfob,
                             kv,s,kv2,s2,id_a,id_b,userid,nazn)
            VALUES (ref_,tt_,6,case when length(ref_)>10 then substr(ref_, -10) else to_char(ref_) end,1,SYSDATE,gl.bDATE,gl.bDATE, gl.bDATE,
                nlsc_,nam_a_,gl.aMFO, nlsb_tobo, nam_b_tobo,gl.aMFO,kva_,s0_,kvb_,s0_,
                       okpo_,gl.aOKPO,gl.aUID,
       substr( 'Нарахування комiсiї за розрахункове обслуговування рахунку '||nlsosn_
               ||' з '
               ||TO_CHAR(dat0a_,'DD.MM.YYYY')||' по '
               ||TO_CHAR(dat0b_,'DD.MM.YYYY')||'. Документiв '
               ||trim(to_char(kol_))||', на суму '
               ||trim(to_char(sdok_/100,'9999999990D00'))||' грн.' ,
              1,160
             )
                   );

            GL.PAYV(flg_,ref_,gl.bDATE,tt_,1,980,nlsc_,s0_,980,nlsb_tobo,s0_);

            insert into oper_visa (ref, dat, userid, status)
            values (ref_, sysdate, user_id, 0);

--  Меняем дату "С" на "По"+1 (dat0a=dat0b+1) - фиксируем начало следующего
--                                              периода.
--  Дату "По" (dat0b) не меняем:

            Select dat0a, dat0b  into  dat0a_t, dat0b_t
            From   RKO_LST
            WHERE  acc=acc_;

               UPDATE rko_lst 
               SET  dat1a=dat0a_t,
                                dat1b=dat0b_t,
                    s0=0, 
                    comm=NULL,
                                KOLDOK=0,
                                SUMDOK=0
                                                WHERE acc=acc_;

               UPDATE rko_lst 
               SET  dat1a=dat0a_t,
                    dat1b=dat0b_t
               WHERE ACC1=acc1_;

            UPDATE rko_lst SET  dat0a=dat0b+1   WHERE acc=acc_;

            s1_:=s1_+s0_;

         EXCEPTION
            WHEN NO_MONEY THEN ROLLBACK TO beforko3; er(acc_);
            WHEN OTHERS   THEN ROLLBACK TO beforko1; er(acc_); GOTO  nextrec1;
         END;
      END IF;

<<nextrec1>>

      NULL;

----------------------------------------------------------------------------
-- 2.  Взыскание долга за РКО  (кнопка "2"):     2600 ->  3570/37, 3570/03
----------------------------------------------------------------------------

      IF INSTR(mode_,'2') > 0 THEN       -- Пробуем взыскать долг по РКО

         deb.trace(2,to_char(ostc_),s2_);

     -- 1). Гасим сначала просроченный долг 3570/37 (АСС2):
     -------------------------------------------------------

         IF s2_ > 0 AND ostc_ > 0  AND  blkd_ = 0 THEN
            IF   ostc_ < s2_ THEN
                 s2a_:= ostc_;
               ELSE 
			        s2a_:=s2_;
            END IF;

            BEGIN
               SAVEPOINT beforko4;

               gl.ref (ref_);
               INSERT INTO oper (ref,tt,vob,nd,dk,pdat,vdat,datd, datP,
                              nlsa,nam_a,mfoa,nlsb,nam_b,mfob,
                              kv,s,kv2,s2,id_a,id_b,userid,nazn)
               VALUES (ref_,tt_,6,case when length(ref_)>10 then substr(ref_, -10) else to_char(ref_) end,1,SYSDATE,gl.bDATE,gl.bDATE, gl.bDATE,
                   nlsa_,nam_a_,gl.aMFO,nlsd_,nam_a_,gl.aMFO,kva_,s2a_,kvb_,s2a_,
                    okpo_,okpo_,gl.aUID,
                   'Погашення комiсiї за розрахункове обслуговування рахунку '
                    ||nlsosn_||' згiдно тарифів банка.  Без НДС.'
                      );

               gl.payv(flg_,ref_,gl.bDATE,tt_,1,980,nlsa_,s2a_,980,nlsd_,s2a_);

               insert into oper_visa (ref, dat, userid, status)
               values (ref_, sysdate, user_id, 0);

               UPDATE rko_lst SET comm=NULL WHERE acc=acc_;

               s2_:= s2_ - s2a_; ostc_:= ostc_ - s2a_;

            EXCEPTION
               WHEN NO_MONEY THEN ROLLBACK TO beforko4; er(acc_);
               WHEN OTHERS   THEN ROLLBACK TO beforko1; er(acc_); GOTO  nextrec3;
            END;
         END IF;

         deb.trace(1,to_char(ostc_),s1_);


       --   2). Затем гасим простой долг 3570/03  (АСС1):
       ---------------------------------------------------

         IF s1_ > 0 AND ostc_ > 0  AND  blkd_ = 0  THEN

            IF ostc_ < s1_ THEN s1a_:= ostc_; ELSE s1a_:= s1_; END IF;

            BEGIN
               SAVEPOINT beforko5;

               BEGIN    ------  Блок вывода в NAZN списка счетов, к которым
                        ------  привязан этот 3570 :

                 Select count(*) into nn2560 from RKO_LST where ACC1=acc1_;

            ---  Для "УКРПОШТИ"  и  если Даты "з" и "по" старые (больше 2-х мес.назад),
            ---  то их НЕ печатаем.
                 if (dat1a_ < gl.bDATE - 62 or dat1a_ is null) and
                    (dat1b_ < gl.bDATE - 62 or dat1b_ is null)
                      or
                    kkk_ = 2                                   then

                    z_po := '. Без НДС';

                 else
                    z_po :=     ' з '
                              ||TO_CHAR(dat1a_,'DD-MM-YYYY')
                              ||' по '
                              ||TO_CHAR(dat1b_,'DD-MM-YYYY')
                              ||'. Без НДС';
                 end if;

                 If    nn2560=1  then

                    nazn_gah:='Комiс.за розрах.обсл.рахунку '
                              ||nlsosn_
                              ||z_po      ;
                         --     ||' з '
                         --     ||TO_CHAR(dat1a_,'DD-MM-YYYY')
                         --     ||' по '
                         --     ||TO_CHAR(dat1b_,'DD-MM-YYYY')
                         --     ||'. Без НДС';

                 Elsif nn2560<=6 then

                    Select ConcatStr(NLS) into scheta from Accounts where
                            ACC in (select ACC from RKO_LST where ACC1=acc1_);

                    nazn_gah:=substr(
                              'Комiс.за розрах.обсл.рахункiв '
                              ||trim(scheta)
                              ||z_po, 1, 160
                                     );

                          --    ||' з '
                          --    ||TO_CHAR(dat1a_,'DD-MM-YYYY')
                          --    ||' по '
                          --    ||TO_CHAR(dat1b_,'DD-MM-YYYY')
                          --    ||'. Без НДС',
                          --            1, 160 );

                 Else

                    Select trim(NMK) into   scheta
                    from   Customer
                    where  RNK=(Select RNK from Accounts where NLS=nlsosn_
                           and KV=980);

                    nazn_gah:=substr(
                              'Комiс.за розрах.обсл.рахункiв Клiєнта '
                              ||scheta||' згiдно тарифiв банка. Без НДС.',
                                      1, 160 );

                 End If;
               EXCEPTION WHEN OTHERS then
                                         -- Если какая-то ошибка - по-старому:
                    nazn_gah:='Комiс.за розрах.обсл.рахунку '
                              ||nlsosn_
                              ||z_po      ;

                             -- ||' з '
                             -- ||TO_CHAR(dat1a_,'DD-MM-YYYY')
                             -- ||' по '
                             -- ||TO_CHAR(dat1b_,'DD-MM-YYYY')
                             -- ||'. Без НДС';
               END;


            ---------------   Добавка  ND_RKO   -------------------
               Begin
                  Select trim(VALUE) into nd_rko_
                  From   AccountsW
                  Where  ACC=acc_ and TAG='ND_RKO' and VALUE is not NULL;

                  nd_rko_:=' Дог.№ '||nd_rko_||'.';

               EXCEPTION WHEN NO_DATA_FOUND THEN
                  nd_rko_:='';
               End;

               nazn_gah:=Substr( trim(nazn_gah||nd_rko_), 1, 160);
            --------------------------------------------------------

               gl.ref (ref_);

               INSERT INTO oper (ref,tt,vob,nd,dk,pdat,vdat,datd, datP,
                              nlsa,nam_a,mfoa,nlsb,nam_b,mfob,
                              kv,s,kv2,s2,id_a,id_b,userid,nazn)
               VALUES (ref_,tt_,6,case when length(ref_)>10 then substr(ref_, -10) else to_char(ref_) end,1,SYSDATE,gl.bDATE,gl.bDATE, gl.bDATE,
                   nlsa_,nam_a_,gl.aMFO,nlsc_,nam_a_,gl.aMFO,kva_,s1a_,kvb_,s1a_,
                    okpo_,okpo_,gl.aUID,
            --------  'Погашення комiсiї за розрах.обслуговування по рахунку '
            --------  ||nlsosn_||' згiдно тарифів банка.  Без НДС.'
                    nazn_gah
                       );

               gl.payv(flg_,ref_,gl.bDATE,tt_,1,980,nlsa_,s1a_,980,nlsc_,s1a_);

               insert into oper_visa (ref, dat, userid, status)
               values (ref_, sysdate, user_id, 0);

               UPDATE rko_lst SET comm=NULL WHERE acc=acc_;

               s1_:= s1_ - s1a_;

            EXCEPTION
               WHEN NO_MONEY THEN ROLLBACK TO beforko5; er(acc_);
               WHEN OTHERS   THEN ROLLBACK TO beforko1; er(acc_); GOTO  nextrec3;
            END;
         END IF;
      END IF;

----------------------------------------------------------------------------
-- 3. Перенос долга на просрочку  (кнопка "3"):    3570/03 -> 3570/37
----------------------------------------------------------------------------

      IF INSTR(mode_,'3') > 0  THEN    -- переносим ВХОДЯЩИЙ остаток на 1 число  !!!

         ---  s1_            (-OSTC) - текущий ост.3570 c обратным знаком
         ---  Находим s1_01  ( OSTC) - входящий на нач.месяца ост.3570:
         BEGIN
           Select nvl(ostf-dos+kos,0)
           Into   s1_01 
           From   SaldoA 
           Where  ACC=acc1_ 
             and  (ACC,FDAT)=
                      (Select ACC, max(FDAT) from Saldoa 
                       where ACC=acc1_ and 
                         FDAT < ADD_MONTHS(TRUNC(gl.bdate,'MM'),0 )
                       group by ACC)
             and nvl(ostf-dos+kos,0)<0;
         EXCEPTION WHEN OTHERS THEN
           s1_01 := 0;
         END;

         ---  Находим сумму KOS по 3570 с начала месяца по тек.момент:
         Select nvl(sum(KOS),0)
         Into   kos_3570
         From   SaldoA 
         Where  ACC=acc1_ 
           and  FDAT>=ADD_MONTHS(TRUNC(gl.bdate,'MM'),0)  and
                FDAT<=gl.bdate ;
            

         -----   Переносимая ACC1->ACC2 (3570/03->3570/37) сумма:    

         s1_ := ABS( least( 0, s1_01 + kos_3570 ));

         IF  s1_ > 0 THEN

            BEGIN
               SAVEPOINT beforko6;
   
               acc2_zakr:=1;
               if acc2_ is not NULL then
                  Begin
                    Select 1 into acc2_zakr
                    from   Accounts
                    where  ACC=acc2_ and DAZS is NULL;
                  EXCEPTION when no_data_found then
                    acc2_zakr:=0;   --- acc2_ или ЗАКРЫТ или такого acc2_
                  END;              --- вообще нет в ACCOUNTS
               end if;
   
               IF acc2_ IS NULL  or  acc2_zakr=0  THEN
   
                  nlsd_:= RKO.Get_NLS_random ('3570') ;  -- Получение № лиц.сч 3570/37 по случ.числам
  
                  OP_REG(99,0,0,grp_,tmp_,rnk_,nlsd_,kva_,    substr('Простр.РКО до 31д. '||nam_a_,1,70),'ODB',isp_,acc2_);
                  p_setAccessByAccmask(acc2_,accd_);
                  Update RKO_LST  set ACC2 = acc2_  WHERE acc = acc_;
                  Update ACCOUNTS set TOBO = br_    WHERE acc = acc2_;
                  ----   3579.07  => 3570.37 прострочені нараховані доходи за обслуговування суб`єктів господарювання
                  Accreg.setAccountSParam( acc2_, 'OB22', '37' ) ; -- надо у
                  Accreg.setAccountSParam( acc2_, 'S270', '01' ) ;
                  Accreg.setAccountSParam( acc2_, 'S240', 'C'  ) ;

               END IF; ---------------- END  открытия 3579*   -----------
   
               gl.ref (ref_);
   
               Insert into OPER (ref,tt,vob,nd,dk,pdat,vdat,datd, datP,   nlsa,nam_a,mfoa,nlsb,nam_b,mfob,  kv,s,kv2,s2,id_a,id_b,userid,nazn)
               VALUES (ref_,tt_,6,case when length(ref_)>10 then substr(ref_, -10) else to_char(ref_) end,1,SYSDATE,gl.bDATE,gl.bDATE, gl.bDATE,
                   nlsd_,nam_a_,gl.aMFO,nlsc_,nam_a_,gl.aMFO,kva_,s1_,kvb_,s1_,
                    okpo_,okpo_,gl.aUID,
               'Прострочена сума комiсiї за розрахункове обслуговування рах. '||nlsosn_
                      );
   
               GL.PAYV(flg_,ref_,gl.bDATE,tt_,1,980,nlsd_,s1_,980,nlsc_,s1_);
   
               insert into oper_visa (ref, dat, userid, status)
               values (ref_, sysdate, user_id, 0);
   
               IF s2_ > 0 THEN   -- раньше был долг
                  UPDATE rko_lst SET dat2b=dat1b,comm=NULL WHERE acc=acc_;
               ELSE
                  UPDATE rko_lst SET dat2a=dat1a,dat2b=dat1b,comm=NULL WHERE acc=acc_;
               END IF;
            EXCEPTION
               WHEN NO_MONEY THEN ROLLBACK TO beforko6; er(acc_); GOTO  nextrec3;
               WHEN OTHERS   THEN ROLLBACK TO beforko6; er(acc_); GOTO  nextrec3;
            END;
         END IF;
      END IF;

<<nextrec3>>
      COMMIT;
      exception
		 when others then
			  -- COBUMMFO-8905 Ошибку логируем и идем дальше
	          bars_audit.error('RKO.PAY2 Помилка: '||sqlcode||' '||sqlerrm);
	  end;
   END LOOP;
   CLOSE c0;
EXCEPTION
   WHEN err THEN
      raise_application_error(-(20000+ern),'\'||erm,TRUE);
END pay2;

procedure pay(mode_ VARCHAR2, dat_ DATE, filt_ VARCHAR2 DEFAULT NULL)
is
begin
  pay2(mode_, dat_,filt_, null);
end;

PROCEDURE er(acc_ NUMBER) IS
status_ VARCHAR2(1);
code_   INTEGER;
erm_    VARCHAR2(255) := NULL;
BEGIN
   deb.trap(SQLERRM,code_,erm_,status_);
   UPDATE rko_lst SET comm=substr(status_||' '||-code_||' '||erm_,1,250) WHERE acc=acc_;
   IF deb.debug THEN deb.trace(6,erm_,code_); END IF;
END;
END;
/
