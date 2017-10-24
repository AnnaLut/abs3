CREATE OR REPLACE PACKAGE BARS.rko IS
/*
--***************************************************************--
                ����� �� ��������-�������� ������������
                           (C) Unity-BARS


  ���������� ���� �� Opldok.FDAT !!!
  ------------------------------------

  14.06.2007 SERG ��������� � ������-��� �����.
  ��� �������:
        - �������� ���� ���������� *tobo* � varschar2(12) �� tobo.tobo%type
        - ��� ��������� ���� ��������� � �����(0), ��� ���� ����� ��� ������ '0'
          ���������:
        patchm73.rko (��� ����)
        patchm74.rko (������ ��� ������-���)


  ���� � ����.   �������� ����� ������������ �� ���� ������ � �������� �����,
  -----------    ��, ��� ����, ���� 6110 � �� � � ������� ���� - ����.

  6110 ������� �� TOBO_PARAMS �� ���� ���� ����� 2600 �  TAG='RKO6110'.
  ��� ������ 2600, �� ������� 6110 �� �������� � TOBO_PARAMS, �� �����
  ���� �� �������� "RKO" (  ����������  ���  �� INI-�����, ���� � ��������
  ����-� ����� �������� ����  #(tobopack.GetToboParam('RKO6110'))   ).

--***************************************************************--
*/


  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 7.01  28/04/2009';

  ----
  -- header_version - ���������� ������ ��������� ������
  --
  function header_version return varchar2;

  ----
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2;

PROCEDURE acr(mode_ VARCHAR2, dat_ DATE,filt_ VARCHAR2 DEFAULT NULL);
PROCEDURE acr2(mode_ VARCHAR2, dat_ DATE,filt_ VARCHAR2 DEFAULT NULL, p_acc number default null);
PROCEDURE pay(mode_ VARCHAR2, dat_ DATE,filt_ VARCHAR2 DEFAULT NULL);
PROCEDURE pay2(mode_ VARCHAR2, dat_ DATE,filt_ VARCHAR2 DEFAULT NULL, p_acc number default null);
PROCEDURE er(acc_ NUMBER);
END;
/
SHOW ERRORS;

CREATE OR REPLACE PACKAGE BODY BARS.rko IS


  -- global consts
  G_BODY_VERSION constant varchar2(64)  := 'version 27.04.2010';
-- ��������� � ��������� � �� ��

  ----
  -- header_version - ���������� ������ ��������� ������
  --
  function header_version return varchar2 is
  begin
    return 'Package header RKO '||G_HEADER_VERSION;
  end header_version;

  ----
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2 is
  begin
    return 'Package body RKO '||G_BODY_VERSION;
  end body_version;


PROCEDURE acr(mode_ VARCHAR2, dat_ DATE, filt_ VARCHAR2 DEFAULT NULL) IS
BEGIN
  acr2(mode_, dat_, filt_, null);
end acr;


PROCEDURE acr2(mode_ VARCHAR2, dat_ DATE, filt_ VARCHAR2 DEFAULT NULL, p_acc number DEFAULT NULL) IS
-- ---------------------------------------------------
--     ( 1 )   ���������� ����� �� ���              --
/*

���� mode_ <0, �� ���  ������ �� ������ ��� = -mode_,
�� ������������ ��� ������ �� ������ �������

*/
-- ---------------------------------------------------
  acc_   NUMBER;
  accd_  NUMBER;

  s_     NUMBER(24);
  kol_   INT;           --  ���������� ����������
  sdok_  NUMBER(24);    --  c���� ����������
  s0_    NUMBER(24);
  tdat_  DATE;
  fdat_  DATE;
  daos_  DATE;
  nls_   VARCHAR2(15);
  c0     SYS_REFCURSOR;
  fdat_2560   date;   --  ���� "��"+1 ��� 2560. ���� fdat_ ���.������� ��������
  DKON_KV1    date;   --  ���� ����.���.��� �������� ������������ ��� fdat_
  DKON_KV     date;   --  ���� ����.���.��� �������� ������������ ��� dat_
  kol_2560    INT ;   --  ���������� ������ 2560

  n_tarpak    INTEGER; -- � ��������� ������
  L_DOC_NOPAY INTEGER; --���������� ���������� ����������

BEGIN

   n_tarpak:= 0;

   If mode_<0 then

      --  ���������� ���� ���������� ���.��� ��������, � �������  
      --  ������ ��������� ���� ���������� ������� :

      EXECUTE IMMEDIATE ' TRUNCATE TABLE CCK_AN_TMP ' ;

      -- ��������� ���� �������:
      fdat_    := to_date(filt_,'dd.mm.yyyy');

      If    to_char (fdat_,'MM') in ('03','06','09','12') then
            DKON_KV := Dat_last( fdat_);
      elsIf to_char (fdat_,'MM') in ('02','05','08','11') then
            DKON_KV := Dat_last( add_months( fdat_,1) ) ;
      else
            DKON_KV := Dat_last( add_months( fdat_,2) ) ;
      end if;

   else
      --  ���������� ���� ���������� ���.��� ��������, � �������  
      --  ������ ��������� ���� ���������� ������� 

      --  �� ���������� ���� ���������� ������� ��������� ����
      --  "��"+1 (DAT0B+1) ��� ������� �������������� 2560/03 
      --  � �������� DAT0B :

      Select DAT0B+1 into fdat_2560
      From   RKO_LST
      Where  ACC in (Select ACC from Accounts
                     where NBS='2560' and OB22='03' and DAZS is NULL and
                        RNK in (Select nvl(RNK,-1) from RNKP_KOD where KODK=1)
                    )
         and DAT0A is not NULL
         and DAT0B is not NULL
         and rownum=1;

      If    to_char (fdat_2560,'MM') in ('03','06','09','12') then
            DKON_KV := Dat_last( fdat_2560);
      elsIf to_char (fdat_2560,'MM') in ('02','05','08','11') then
            DKON_KV := Dat_last( add_months(fdat_2560,1) ) ;
      else
            DKON_KV := Dat_last( add_months(fdat_2560,2) ) ;
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


   BEGIN --  ���������� �� ������ [fdat_,dat_] ���-�� �� 1-�� ����� acc_
         --                                           ===================
         --  fdat_ = "��"+1
         --  dat_  = ����, �� ������� ������ ����������


   --  ����������  � ��������� ������ �����  �  ���������� ���������x
   --  ���������� ��� ����� ������

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

----------------------   � � � � � �   --------------------------
                       

IF  n_tarpak >= 38 THEN        ----     � � � � � �  >=  38    ----
 

      IF MODE_<0 THEN           ---<--  ��� 412 ������ 

         INSERT INTO CCK_AN_TMP ( reg, NLS, acc, N1, PR, N2 )
          ----------------------------------------------------------
          -- 1 --   �� ������ / ������ IB1,IB2,CL1,CL2     -- 412 --
          ----------------------------------------------------------
          SELECT rnk, nls , acc,  s,  pr,  COUNT(*)
          FROM (Select rnk, nls, acc, ref,s, pr , rownum R
                From (SELECT a.rnk, a.NLS, a.acc, o.ref,
                             F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl((Select max(DAT)  
                                               from   OPER_VISA 
                                               where  REF=o.REF and GROUPID not in (30,80)), 
                                               o.PDAT
                                              ),
                                          DKON_KV,
                                          o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                          o.D_REC, o.REF
                                         ) S,
                             T.DK+D.DK PR
                      FROM   Oper o, Opldok d, Accounts a, RKO_TTS t
                      WHERE  a.acc=acc_
                         and a.acc=d.acc
                         and d.ref=o.ref
                         and (t.TT like 'IB%' or  t.TT like 'CL%')  ---<-   ������ IB*,CL*  
                         and d.sos=5
                         and d.fdat >= to_date(filt_,'dd.mm.yyyy')
                         and d.fdat <  dat_+1
                         and d.tt = t.tt
                         and (t.dk = 0 and d.dk = 0)          ---  �� ����� (412)
                         and D.S > 0
                         and F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl((Select max(DAT)  
                                               from   OPER_VISA 
                                               where  REF=o.REF and GROUPID not in (30,80)), 
                                               o.PDAT
                                              ),
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
          -- 2 --   �� ������ / ����� IB1,IB2,CL1,CL2      -- 412 --          n_tarpak >= 38
          ----------------------------------------------------------
          SELECT rnk, nls , acc,  s,  pr,  COUNT(*)
          FROM (Select rnk, nls, acc, ref,s, pr , rownum R
                From (SELECT a.rnk, a.NLS, a.acc, o.ref,
                             F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl((Select max(DAT)  
                                               from   OPER_VISA 
                                               where  REF=o.REF and GROUPID not in (30,80)), 
                                               o.PDAT
                                              ),
                                          DKON_KV,
                                          o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                          o.D_REC, o.REF
                                         ) S,
                             T.DK+D.DK PR
                      FROM   Oper o, Opldok d, Accounts a, RKO_TTS t
                      WHERE  a.acc=acc_
                         and a.acc=d.acc
                         and d.ref=o.ref
                         and t.TT not like 'IB%' and t.TT not like 'CL%'   ---<-  K���� IB*,CL* 
                         and d.sos=5
                         and d.fdat >= to_date(filt_,'dd.mm.yyyy')
                         and d.fdat <  dat_+1
                         and d.tt = t.tt
                         and (t.dk = 0 and d.dk = 0)          ---  �� ����� (412)
                         and D.S > 0
                         and F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl((Select max(DAT)  
                                               from   OPER_VISA 
                                               where  REF=o.REF and GROUPID not in (30,80)), 
                                               o.PDAT
                                              ),
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
          -- 3 --   �� �������                           -- 412 --         n_tarpak >= 38
          ----------------------------------------------------------
          SELECT rnk, nls , acc,  s,  pr,  COUNT(*)
          FROM (Select rnk, nls, acc, ref,s, pr , rownum R
                From (SELECT a.rnk, a.NLS, a.acc, o.ref,
                             F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl((Select max(DAT)  
                                               from   OPER_VISA 
                                               where  REF=o.REF and GROUPID not in (30,80)), 
                                               o.PDAT
                                              ),
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
                         and (t.dk = 1 and d.dk = 1)         --- �� ������ (412)
                         and D.S > 0
                         and F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl((Select max(DAT)  
                                               from   OPER_VISA 
                                               where  REF=o.REF and GROUPID not in (30,80)), 
                                               o.PDAT
                                              ),
                                          DKON_KV,
                                          o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                          o.D_REC, o.REF
                                         ) > 0
                      ORDER by o.REF
                     )
               )
      --- WHERE R > L_DOC_NOPAY    -- �� ������ �����.���������� �� ��������� !
          Group by RNK,NLS,ACC,S,PR ;


      ELSE       ------------  � � � � � � � �   � � � � � � :         n_tarpak >= 38


        Select NLS , sum(SUMS), sum(CNT), sum(SUMDOK)
        into   nls_, s_       , kol_    , sdok_
        From
        (
          -----------------------------------------------------------------
          -- 1 --     �� ������ / ������ IB1,IB2,CL1,CL2   -- ����.����. --       n_tarpak >= 38
          -----------------------------------------------------------------
          SELECT NLS , sum(S) SUMS, COUNT(*) CNT, sum(sdok) SUMDOK
          FROM
             (Select NLS, S, SDOK, REF, rownum R  FROM
               (SELECT nls, S, SDOK, ref  FROM
                    (SELECT a.NLS nls,
                          F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                       nvl((Select max(DAT)  
                                            from   OPER_VISA 
                                            where  REF=o.REF and GROUPID not in (30,80)), 
                                            o.PDAT
                                           ),
                                       DKON_KV,
                                       o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                       o.D_REC, o.REF
                                     ) S,
                          d.S SDOK, o.ref
                     FROM  Oper o, Opldok d, Accounts a, RKO_TTS t
                     WHERE a.acc=acc_
                       and a.acc=d.acc
                       and d.ref=o.ref
                       and (t.TT like 'IB%' or t.TT like 'CL%')   ---<  ������ IB*,CL*  !
                       and d.sos=5
                       and d.fdat >=fdat_
                       and d.fdat < dat_+1
                       and d.tt = t.tt
                       and (t.dk = 0 and d.dk = 0)  --- �� ����� (�������� ������)
                       and D.S > 0
                    )
                WHERE S>0  order by REF
               )
             )
          WHERE R > L_DOC_NOPAY  --- ���������� �� �� ������ IB* !
          Group by NLS
                                 UNION ALL
          --------------------------------------------------------------
          -- 2 --     �� ������ / ����� IB1,IB2,CL1,CL2  -- ����.����.--      n_tarpak >= 38
          --------------------------------------------------------------
          SELECT NLS , sum(S) SUMS, COUNT(*) CNT, sum(sdok) SUMDOK
          FROM
             (Select NLS, S, SDOK, REF, rownum R  FROM
               (SELECT nls, S, SDOK, ref  FROM
                    (SELECT a.NLS nls,
                          F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                       nvl((Select max(DAT)  
                                            from   OPER_VISA 
                                            where  REF=o.REF and GROUPID not in (30,80)), 
                                            o.PDAT
                                           ),
                                       DKON_KV,
                                       o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                       o.D_REC, o.REF
                                     ) S,
                          d.S SDOK, o.ref
                     FROM  Oper o, Opldok d, Accounts a, RKO_TTS t
                     WHERE a.acc=acc_
                       and a.acc=d.acc
                       and d.ref=o.ref
                       and t.TT not like 'IB%'  and  t.TT not like 'CL%' ---<  ����� IB*,CL*  !
                       and d.sos=5
                       and d.fdat >=fdat_
                       and d.fdat < dat_+1
                       and d.tt = t.tt
                       and (t.dk = 0 and d.dk = 0)   --- �� ����� (�������� ������)
                       and D.S > 0
                    )
                WHERE S>0  order by REF
               )
             )
          --- WHERE R > L_DOC_NOPAY   --- ���������� ������ IB*
          Group by NLS
                                 UNION ALL
          -------------------------------------------------------
          -- 3 --     �� �������:                 -- ����.����.--      n_tarpak >= 38
          -------------------------------------------------------
          SELECT NLS , SUM(s) sums, COUNT(*) cnt, SUM(sdok) sumsdok
          FROM
             (Select NLS, S, SDOK, REF, rownum R  FROM
               (SELECT nls, S, SDOK, ref  FROM
                    (SELECT a.NLS nls,
                          F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                       nvl((Select max(DAT)  
                                            from   OPER_VISA 
                                            where  REF=o.REF and GROUPID not in (30,80)), 
                                            o.PDAT
                                           ),
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
                       and (t.dk = 1 and d.dk = 1)  --- �� ������ (�������� ������)
                       and D.S > 0
                    )
                WHERE S>0  order by REF
               )
             )
     ---  WHERE R > L_DOC_NOPAY  -- �� ������ �����.���������� �� ��������� ! 
          Group by NLS
        )
        Group by NLS;

      END IF ;



---------------------------------------------------------------------
ELSE       ---   ��-�������:   ������  0 - 37                             n_tarpak < 38
---------------------------------------------------------------------



      IF MODE_<0 THEN             ---<--  ��� 412 ������ 

         INSERT INTO CCK_AN_TMP ( reg, NLS, acc, N1, PR, N2 )
          SELECT rnk, nls , acc,  s,  pr,  COUNT(*)
          FROM (Select rnk, nls, acc, ref,s, pr , rownum R
                From (SELECT a.rnk, a.NLS, a.acc, o.ref,
                             F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl((Select max(DAT)  
                                               from   OPER_VISA 
                                               where  REF=o.REF and GROUPID not in (30,80)), 
                                               o.PDAT
                                              ),
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
                         and (t.dk = 0 and d.dk = 0)          ---  �� ����� (412)
                         and D.S > 0
                         and F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl((Select max(DAT)  
                                               from   OPER_VISA 
                                               where  REF=o.REF and GROUPID not in (30,80)), 
                                               o.PDAT
                                              ),
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
                                          nvl((Select max(DAT)  
                                               from   OPER_VISA 
                                               where  REF=o.REF and GROUPID not in (30,80)), 
                                               o.PDAT
                                              ),
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
                         and (t.dk = 1 and d.dk = 1)         --- �� ������ (412)
                         and D.S > 0
                         and F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                          nvl((Select max(DAT)  
                                               from   OPER_VISA 
                                               where  REF=o.REF and GROUPID not in (30,80)), 
                                               o.PDAT
                                              ),
                                          DKON_KV,
                                          o.NLSA,o.NLSB,o.MFOA,o.MFOB,t.TT,a.ACC,
                                          o.D_REC, o.REF
                                         ) > 0
                      ORDER by o.REF
                     )
               )
      --- WHERE R > L_DOC_NOPAY    -- �� ������ �����.���������� �� ��������� !
          Group by RNK,NLS,ACC,S,PR ;


      ELSE       ------------------     �������� ������� :              n_tarpak < 38
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
                                       nvl((Select max(DAT)  
                                            from   OPER_VISA 
                                            where  REF=o.REF and GROUPID not in (30,80)), 
                                            o.PDAT
                                           ),
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
                       and (t.dk = 0 and d.dk = 0)   --- �� ����� (�������� ������)
                       and D.S > 0
                    )
                WHERE S>0  order by REF
               )
             )
          WHERE R > L_DOC_NOPAY      --- ���������� ��������� �� �� !
          Group by NLS
                                 UNION ALL
          SELECT NLS , SUM(s) sums, COUNT(*) cnt, SUM(sdok) sumsdok
          FROM
             (Select NLS, S, SDOK, REF, rownum R  FROM
               (SELECT nls, S, SDOK, ref  FROM
                    (SELECT a.NLS nls,
                          F_TARIF_RKO( t.NTAR,a.KV,a.NLS,d.S,
                                       nvl((Select max(DAT)  
                                            from   OPER_VISA 
                                            where  REF=o.REF and GROUPID not in (30,80)), 
                                            o.PDAT
                                           ),
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
                       and (t.dk = 1 and d.dk = 1)  --- �� ������ (�������� ������)
                       and D.S > 0
                    )
                WHERE S>0  order by REF
               )
             )
     ---  WHERE R > L_DOC_NOPAY  -- �� ������ �����.���������� �� ��������� ! 
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

--                          �������� !
--    ���� "�" ����� ���������� ������ ������ � ����� ������ - ����� ��
--    ���������� ��� ���� = NULL.  ������ ������ ee �� DAOS:


    If mode_<0 then
       null;                    ----  ������ 27-04-2010. ��������
    ELSE
       UPDATE rko_lst SET dat0a=NVL(dat0a,daos_), dat0b=dat_, s0=s0+s_,
              KOLDOK=KOLDOK+kol_,
              SUMDOK=SUMDOK+sdok_,
              comm=NULL    WHERE acc=acc_;

--     E��� ����� ���������� "���������" = 0, �� ������ "�" �� "��"+1,
--     ( �� ������ � "���������" > 0, ���� "�" ���������� �� "��"+1 �����
--       ���������� ������������ ):

       UPDATE rko_lst SET dat0a=dat_+1 WHERE  acc=acc_  and  s0=0;

    End If;

-------------------------------------------------------------------------
--  ��� "�������":
--    E��� ����� ���������� "���������"=0, �� ������ "�" �� "��"+1,
--    �.�. ����������� ���� "�" �� ��� ���, ���� �� ����� �� ��������
--    ���������� �����  ( s0>0 ).
--
----  UPDATE rko_lst SET dat0a=dat_+1 WHERE  acc=acc_  and  s0=0;
-------------------------------------------------------------------------


      COMMIT;
<<nextrec0>>
      NULL;

   END LOOP;
   CLOSE c0;
END acr2;




---===========================================================================

PROCEDURE pay2(mode_ VARCHAR2, dat_ DATE,filt_ VARCHAR2 DEFAULT NULL, p_acc number default null) IS
-- ---------------------------------------------------
--          ( 2 )   ��������� ����� �� ���          --
-- ---------------------------------------------------
acc1_zakr  INT;
acc2_zakr  INT;

acc_     NUMBER;        --  ACC ��������� �����
nlsosn_  VARCHAR2(15);  --  NLS   --//--
rnk_osn  NUMBER;        --  RNK   --//--
nam_osn  VARCHAR2(38);  --  NMS   --//--


accd_    NUMBER;        --  ACC �����-�������� (�����-�����������)
nlsa_    VARCHAR2(15);  --  NLS   --//--
rnk_     NUMBER;        --  RNK   --//--
nam_a_   VARCHAR2(38);  --  NMS   --//--
isp_     NUMBER;        --  ISP   --//--


i        INT;
s_     NUMBER(24);
s0_    NUMBER(24);
kol_   INT;           --  ���������� ����������
sdok_  NUMBER(24);    --  c���� ����������
s0a_   NUMBER(24);
s1_    NUMBER(24);
s1a_   NUMBER(24);
s2_    NUMBER(24);
s2a_   NUMBER(24);
ostc_  NUMBER(24);
nls_   VARCHAR2(15);
nlsb_  VARCHAR2(65);

nlsc_  VARCHAR2(15);  --  NLS 3570
acc1_  NUMBER;        --  ACC 3570

nlsd_  VARCHAR2(15);  --  NLS 3579
acc2_  NUMBER;        --  ACC 3579

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
tobo_a     tobo.tobo%type;-- ��� ���� ����� 2600
mfo_a      VARCHAR2(12);-- "MFO �������.�������" ����� 2600, ���� �� � BANK_ACC
nlsb_tobo  VARCHAR2(15);-- ���� 6110 �� TOBO_PARAMS: TOBO=tobo_a,TAG='RKO6110'
nam_b_tobo VARCHAR2(38);-- Accounts.NMS ����� nlsb_tobo


nd_rko_    VARCHAR2(50);
z_po       VARCHAR2(40);

nn2560     INT;            --  �����. ������, � ������� �������� ���� �����.
                           --  3570,  ������� �������
scheta     VARCHAR2(100);  --  �������� ���� ������
nazn_gah   VARCHAR2(200);


dat0a_  DATE;
dat1a_  DATE;
dat2a_  DATE;

dat0b_  DATE;
dat1b_  DATE;
dat2b_  DATE;

dat0a_t  DATE;
dat0b_t  DATE;

blkd_    NUMBER;     --  ��������������� �� �� �����-�����������

NO_MONEY EXCEPTION;
PRAGMA EXCEPTION_INIT(NO_MONEY, -20203);

c0     SYS_REFCURSOR;

erm  VARCHAR2 (80)           ;
ern  CONSTANT POSITIVE       := 200         ;
err  EXCEPTION               ;


BEGIN

----------  ���������:  ��������� �� �������� "RKO" ?  ------------
   BEGIN
      SELECT substr(flags,38,1) INTO flg_
        FROM tts
       WHERE tt='RKO';
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         erm:='9701 - �� ��������� �������� RKO !';
         RAISE err;
   END;
--------------------------------------------------------------------


   deb.trace(3,'DATE',dat_);


----=============    ������ ����� �� ������ RKO_LST:   ================

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

      SAVEPOINT beforko1;

      -- ������ ������ � RKO_LST.   acc_ - ACC ��������� �����.
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


      -- ���������� NLS,RNK,NMS ��������� �����  acc_ (��� ������ � oper.NAZN):
      BEGIN                    ----------------------
         SELECT NLS, RNK, substr(NMS,1,38)
           INTO nlsosn_, rnk_osn, nam_osn
           FROM accounts
          WHERE acc=acc_;
      END;


      --  ���������� ��� �� �����-�����������  accd_ :
                           -------------------------
      SELECT a.nls,a.kv, a.ostc+nvl(a.lim,0), a.isp, a.grp, c.rnk,
             NVL(TRIM(c.nmkk),TRIM(SUBSTR(c.nmk,1,38))), c.okpo,
             a.TOBO, a.BLKD
      INTO nlsa_,kva_,ostc_,isp_,grp_,rnk_,nam_a_,okpo_,tobo_a,
           blkd_
      FROM accounts a,customer c
      WHERE a.acc=accd_ AND a.rnk=c.rnk;


      kkk_:=0;              ----  ���������� kkk_ - K�� ����.�������  
      BEGIN  
        Select KODK  Into  kkk_         
        From   RNKP_KOD 
        Where  RNK = rnk_  and  KODK is not NULL and rownum=1;
      EXCEPTION  WHEN NO_DATA_FOUND THEN
        kkk_:=0;
      END;  



------   ���������� 6110 (nlsb_tobo) ��� �����.2600 ������ ��� --------------
------   ������� "0" � "1"  �  ���� ������.����� s0_>0 :       --------------


   IF ( INSTR(mode_,'0')>0  OR  INSTR(mode_,'1')>0 ) and s0_>0   then

      BEGIN                            -- 1. ������� ���� "��������������"
         SELECT  trim(VALUE)           --    6110 � AccountsW / TAG='S6110'
         into    nlsb_tobo
         FROM    AccountsW
         WHERE   ACC=acc_ and TAG='S6110';
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


                                       -- 2). ���� 6110 �� ��22 � ���� ���
      IF nlsb_tobo is NULL THEN        --     ����������� BRANCH-e:

         nlsb_tobo:=NBS_OB22_NULL('6110','06',tobo_a);

         IF nlsb_tobo is NULL  then
            raise_application_error(-20000,'�� ������ ���� 6110/06 �� '||substr(tobo_a,1,15)||' !', true);
         END IF;
      END IF;

      BEGIN             ---  ���������� NMS �����  nlsb_tobo (6110)
        SELECT SUBSTR(NMS,1,38)
        INTO nam_b_tobo
        FROM accounts
        WHERE NLS=nlsb_tobo AND KV=980;
      EXCEPTION  WHEN NO_DATA_FOUND THEN
        raise_application_error(-20000, '���� '||nlsb_tobo||' ��� '||nlsosn_||'  �� ������ !', true);
      END;

   END IF;

-------------------- END ������ 6110 ----------------------------------


      nlsc_:= VKRZN(SUBSTR(gl.aMFO,1,5),'3570'||SUBSTR(nlsa_,5));
      nlsd_:= VKRZN(SUBSTR(gl.aMFO,1,5),'3579'||SUBSTR(nlsa_,5));

      IF acc1_ IS NULL THEN
         s1_:=0;
      ELSE                     --     s1_  - ������� �� 3570
         BEGIN
            SELECT nls,-ostc INTO nlsc_,s1_ FROM accounts
                   WHERE acc=acc1_ ;   ------ AND  ostb=ostc;    ---  !!!
         EXCEPTION WHEN NO_DATA_FOUND THEN
            s1_:=0;
         END;
      END IF;

      IF acc2_ IS NULL THEN
         s2_:=0;
      ELSE                     --     s2_  - ������� �� 3579
         BEGIN
            SELECT nls,-ostc INTO nlsd_,s2_ FROM accounts
                   WHERE acc=acc2_ ;   ------ AND  ostb=ostc;    ---  !!!
         EXCEPTION WHEN NO_DATA_FOUND THEN
            s2_:=0;
         END;
      END IF;

----================================================================
---                  �������� �� ������� 0,1,2,3:
----================================================================

-- 0.  ��������� ����� �� ���  (������ "0"):     2600 ---> 6110
---------------------------------------------------------------------
      IF INSTR(mode_,'0') > 0 AND s0_>0 AND ostc_>0 AND ostc_>=s0_ THEN  -- ��������� ����������� ����� ��������

         s0a_:= s0_;      --  c���� �������� 2600-6110

         BEGIN
            SAVEPOINT beforko2;

            gl.ref (ref_);
            INSERT INTO oper (ref,tt,vob,nd,dk,Pdat, Vdat, Datd, datP,
                             nlsa,nam_a,mfoa,nlsb,nam_b,mfob,
                             kv,s,kv2,s2,id_a,id_b,userid,nazn)
            VALUES ( ref_,tt_,6,case when length(ref_)>10 then substr(ref_, -10) else to_char(ref_) end,1,SYSDATE,  gl.bDATE,gl.bDATE, gl.bDATE,
                nlsa_,nam_a_,gl.aMFO,  nlsb_tobo,  nam_b_tobo,gl.aMFO,kva_,s0a_,kvb_,s0a_,
                       okpo_,gl.aOKPO,gl.aUID,
            '�� ������������ �������������� ���. '||nlsosn_
              ||' � '
              ||TO_CHAR(dat0a_,'DD.MM.YYYY')||' �� '
              ||TO_CHAR(dat0b_,'DD.MM.YYYY')||'. ��������i� '
              ||trim(to_char(kol_))||', �� ���� '
              ||trim(to_char(sdok_/100,'9999999990D00'))||' ���.'
                   );

            gl.payv(flg_,ref_,gl.bDATE,tt_,1,980,nlsa_,s0a_,980, nlsb_tobo, s0a_);

            insert into oper_visa (ref, dat, userid, status)
            values (ref_, sysdate, user_id, 0);

--  ������ ���� "�" �� "��"+1 (dat0a=dat0b+1) - ��������� ������ ����������
--                                              �������.
--  ���� "��" (dat0b) �� ������:

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
-- 1.  ����������� ����� ����� � 3570  (������ "1"):  3570 --> 6110
----------------------------------------------------------------------------
      IF INSTR(mode_,'1') > 0 AND s0_>0 THEN  -- �� ����������

         BEGIN
            SAVEPOINT beforko3;

            acc1_zakr:=1;
            if acc1_ is not NULL then
               Begin 
                 Select 1 into acc1_zakr 
                 from   Accounts 
                 where  ACC=acc1_ and DAZS is NULL;
               EXCEPTION when no_data_found then
                 acc1_zakr:=0;   --- acc1_ ��� ������ ��� ������ acc1_ 
               END;              --- ������ ��� � ACCOUNTS
            end if;


            -----------------   �������� 3570*  ---------------------
            ---  �������� !  �������� ���� �� ����� ����� ��������,
            ---              � �� �� ����� ��������� �����.
            ---------------------------------------------------------

            IF acc1_ is NULL  or  acc1_zakr=0  THEN

               BEGIN  ------  ������ ������ 3570*

                nlsc_:= VKRZN(SUBSTR(gl.aMFO,1,5),'3570'||SUBSTR(nlsa_,5));

                select xxx into tmp_3570 from
                (
                  Select a.NLS          xxx
                  from   accounts a, Specparam_Int s
                  where  a.NLS = nlsc_ and a.KV=980 and a.ACC=s.ACC and
                         (a.RNK<>rnk_  OR  s.OB22<>'03'  OR  a.DAZS is not NULL)
                   union all
                  Select to_char(r.ACC) xxx
                  from   Accounts a, RKO_LST r
                  where  a.NLS=nlsc_ and a.KV=980 and a.ACC=r.ACC1 and
                         r.ACC in (Select ACC from RKO_3570)
                )
                where  rownum<2;

                   --   C��� 3570<����� 2600> ��� ����, �� ��:
                   --    -  �� ������ RNK   � � �   � OB22<>'03'    � � �   �� ������ !
                   --    -  ���� 3570 �������� � ����� �� ������ "������ ���. �� 3570"
                   --   ��������� ������ ���� �� �����:  3570 k S NN RRRRRR
                   --   ���:  S  - 6-�� ����� �� 2600*

                i:= 1;

                loop

                   nlsc_:= vkrzn(substr(gl.aMFO,1,5),
                           '3570'||'0'|| substr(nlsa_,6,1) ||
                           lpad(to_char(i),2,'0') || lpad(to_char(rnk_),6,'0'));

                   Begin    -- ���� �� ����� ���� ?

                       select xxx into tmp_3570 from
                       (
                         Select a.NLS          xxx
                         from   accounts a, Specparam_Int s
                         where  a.NLS = nlsc_ and a.KV=980 and a.ACC=s.ACC and
                                (a.RNK<>rnk_  OR  s.OB22<>'03'  OR  a.DAZS is not NULL)
                         union all
                         Select to_char(r.ACC) xxx
                         from   Accounts a, RKO_LST r
                         where  a.NLS=nlsc_ and a.KV=980 and a.ACC=r.ACC1 and
                                r.ACC in (Select ACC from RKO_3570)
                       )
                       where  rownum<2;

                   Exception when no_data_found then
                      EXIT;     -- ������ ����� ��� ���, - ���������
                   End;

                   i := i + 1;
                   if i = 100 then
                      exit;
                   end if;

                end loop;

               EXCEPTION when no_data_found then
                null;
               END;  ---------- END ������� ������ 3570*  -----


               OP_REG(99,0,0, grp_,tmp_, rnk_, nlsc_,kva_,
                       substr('�����.��� '||nam_a_,1,70),'ODB',isp_,acc1_);

               p_setAccessByAccmask(acc1_,accd_);

               UPDATE rko_lst SET acc1=acc1_ WHERE acc=acc_;

               UPDATE accounts SET (TOBO)=
                               (select TOBO from Accounts WHERE acc=acc_)
                               WHERE acc=acc1_;

               ---INSERT into BANK_ACC (ACC,MFO)
               ---       select acc1_, MFO from BANK_ACC where ACC=acc_;

               BEGIN
                 INSERT INTO Specparam (ACC,R013,S240)  VALUES (acc1_,'3','1');
               EXCEPTION WHEN OTHERS THEN
                 UPDATE Specparam SET R013='3', S240='1'  WHERE  ACC=acc1_;
               END;

               BEGIN
                 INSERT INTO Specparam_INT (ACC,OB22)  VALUES (acc1_,'03');
               EXCEPTION WHEN OTHERS THEN
                 UPDATE Specparam_INT SET OB22='03'  WHERE  ACC=acc1_;
               END;

            END IF;
            ----------  �nd �������� 3570* ---------------

            gl.ref (ref_);

            Insert into OPER (ref,tt,vob,nd,dk,pdat,vdat,datd, datP,
                              nlsa,nam_a,mfoa,nlsb,nam_b,mfob,
                             kv,s,kv2,s2,id_a,id_b,userid,nazn)
            VALUES (ref_,tt_,6,case when length(ref_)>10 then substr(ref_, -10) else to_char(ref_) end,1,SYSDATE,gl.bDATE,gl.bDATE, gl.bDATE,
                nlsc_,nam_a_,gl.aMFO, nlsb_tobo, nam_b_tobo,gl.aMFO,kva_,s0_,kvb_,s0_,
                       okpo_,gl.aOKPO,gl.aUID,
       substr( '����������� ���i�i� �� ������������ �������������� �������'||nlsosn_
               ||' � '
               ||TO_CHAR(dat0a_,'DD.MM.YYYY')||' �� '
               ||TO_CHAR(dat0b_,'DD.MM.YYYY')||'. ��������i� '
               ||trim(to_char(kol_))||', �� ���� '
               ||trim(to_char(sdok_/100,'9999999990D00'))||' ���.' ,
              1,160 
             )
                   );


            GL.PAYV(flg_,ref_,gl.bDATE,tt_,1,980,nlsc_,s0_,980,nlsb_tobo,s0_);

            insert into oper_visa (ref, dat, userid, status)
            values (ref_, sysdate, user_id, 0);

--  ������ ���� "�" �� "��"+1 (dat0a=dat0b+1) - ��������� ������ ����������
--                                              �������.
--  ���� "��" (dat0b) �� ������:



            Select dat0a, dat0b  into  dat0a_t, dat0b_t 
            From   RKO_LST
            WHERE  acc=acc_;

            UPDATE rko_lst SET  dat1a=dat0a_t, 
                                dat1b=dat0b_t,
                                s0=0, comm=NULL,
                                KOLDOK=0,
                                SUMDOK=0
                                                WHERE acc=acc_;

            UPDATE rko_lst SET  dat1a=dat0a_t, 
                                dat1b=dat0b_t   WHERE ACC1=acc1_;

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
-- 2.  ��������� ����� �� ���  (������ "2"):     2600 -->  3579,3570
----------------------------------------------------------------------------

      IF INSTR(mode_,'2') > 0 THEN       -- ������� �������� ���� �� ���

         deb.trace(2,to_char(ostc_),s2_);


     -- 1). ����� ������� ������������ ���� 3579:
     ---------------------------------------------
         IF s2_ > 0 AND ostc_ > 0  AND  blkd_ = 0 THEN

            IF   ostc_ < s2_ THEN
                 s2a_:= ostc_;
            ELSE s2a_:=s2_;
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
                   '��������� ���i�i� �� ������������ �������������� ������� '
                    ||nlsosn_||' ��i��� ������� �����.  ��� ���.'
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


       --   2). ����� ����� ������� ���� 3570:
       ----------------------------------------

         IF s1_ > 0 AND ostc_ > 0  AND  blkd_ = 0  THEN

            IF ostc_ < s1_ THEN s1a_:= ostc_; ELSE s1a_:= s1_; END IF;

            BEGIN
               SAVEPOINT beforko5;

               BEGIN    ------  ���� ������ � NAZN ������ ������, � �������
                        ------  �������� ���� 3570 :

                 Select count(*) into nn2560 from RKO_LST where ACC1=acc1_;


            ---  ��� "��������"  �  ���� ���� "�" � "��" ������ (������ 2-� ���.�����),
            ---  �� �� �� ��������.

                 if (dat1a_ < gl.bDATE - 62 or dat1a_ is null) and
                    (dat1b_ < gl.bDATE - 62 or dat1b_ is null) 
                      or
                    kkk_ = 2                                   then

                    z_po := '. ��� ���';

                 else
                    z_po :=     ' � '
                              ||TO_CHAR(dat1a_,'DD-MM-YYYY')
                              ||' �� '
                              ||TO_CHAR(dat1b_,'DD-MM-YYYY')
                              ||'. ��� ���';
                 end if;
          

                 If    nn2560=1  then

                    nazn_gah:='���i�.�� ������.����.������� '
                              ||nlsosn_
                              ||z_po      ;
                         --     ||' � '
                         --     ||TO_CHAR(dat1a_,'DD-MM-YYYY')
                         --     ||' �� '
                         --     ||TO_CHAR(dat1b_,'DD-MM-YYYY')
                         --     ||'. ��� ���';

                 Elsif nn2560<=6 then

                    Select ConcatStr(NLS) into scheta from Accounts where
                            ACC in (select ACC from RKO_LST where ACC1=acc1_);

                    nazn_gah:=substr(
                              '���i�.�� ������.����.������i� '
                              ||trim(scheta)
                              ||z_po, 1, 160
                                     );

                          --    ||' � '
                          --    ||TO_CHAR(dat1a_,'DD-MM-YYYY')
                          --    ||' �� '
                          --    ||TO_CHAR(dat1b_,'DD-MM-YYYY')
                          --    ||'. ��� ���',
                          --            1, 160 );

                 Else

                    Select trim(NMK) into   scheta 
                    from   Customer 
                    where  RNK=(Select RNK from Accounts where NLS=nlsosn_
                           and KV=980);

                    nazn_gah:=substr(
                              '���i�.�� ������.����.������i� ��i���� '
                              ||scheta||' ��i��� �����i� �����. ��� ���.',
                                      1, 160 );

                 End If;

               EXCEPTION WHEN OTHERS then
                                         -- ���� �����-�� ������ - ��-�������:
                    nazn_gah:='���i�.�� ������.����.������� '
                              ||nlsosn_
                              ||z_po      ;

                             -- ||' � '
                             -- ||TO_CHAR(dat1a_,'DD-MM-YYYY')
                             -- ||' �� '
                             -- ||TO_CHAR(dat1b_,'DD-MM-YYYY')
                             -- ||'. ��� ���';
               END;


            ---------------   �������  ND_RKO   -------------------
               Begin 

                  Select trim(VALUE) into nd_rko_ 
                  From   AccountsW 
                  Where  ACC=acc_ and TAG='ND_RKO' and VALUE is not NULL;

                  nd_rko_:=' ���.� '||nd_rko_||'.';

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
            --------  '��������� ���i�i� �� ������.�������������� �� ������� '
            --------  ||nlsosn_||' ��i��� ������� �����.  ��� ���.'
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
-- 3. ������� ����� �� ���������  (������ "3"):    3570 -> 3579
----------------------------------------------------------------------------

      IF INSTR(mode_,'3') > 0 AND s1_ > 0 THEN -- ��������� �� ���������

         BEGIN
            SAVEPOINT beforko6;

            acc2_zakr:=1;
            if acc2_ is not NULL then
               Begin 
                 Select 1 into acc2_zakr 
                 from   Accounts 
                 where  ACC=acc2_ and DAZS is NULL;
               EXCEPTION when no_data_found then
                 acc2_zakr:=0;   --- acc2_ ��� ������ ��� ������ acc2_ 
               END;              --- ������ ��� � ACCOUNTS
            end if;

            -------------------   �������� 3579*  ---------------------
            ---  �������� !  �������� ���� �� ����� ����� ��������,
            ---              � �� �� ����� ��������� �����.
            -----------------------------------------------------------
            IF acc2_ IS NULL  or  acc2_zakr=0  THEN

               BEGIN  ------  ������ ������ 3579*

                nlsd_:= VKRZN(SUBSTR(gl.aMFO,1,5),'3579'||SUBSTR(nlsa_,5));

                select a.NLS into tmp_3570
                from   accounts a, Specparam_Int s
                where  a.NLS = nlsd_ and a.KV=980 and a.ACC=s.ACC  and
                       (a.RNK<>rnk_  OR  s.OB22<>'07'  OR  a.DAZS is not NULL);

                   --   C��� 3579<����� 2600> ��� ����:
                   --        --  �� ������ RNK   ���
                   --        --  � OB22<>'07'    ���
                   --        --  �� ������ !
                   --   ��������� ������ ���� �� �����:  3579 k S NN RRRRRR
                   --   ���:  S  - 6-�� ����� �� 2600*

                i:= 1;
                loop
                   nlsd_:= vkrzn(substr(gl.aMFO,1,5),
                           '3579'||'0'|| substr(nlsa_,6,1) ||
                           lpad(to_char(i),2,'0') || lpad(to_char(rnk_),6,'0'));

                   Begin    -- ���� �� ����� ���� ?

                     Select a.NLS into tmp_3570
                     from Accounts a, Specparam_Int s
                     where a.NLS = nlsd_ and a.KV=980 and a.ACC=s.ACC and
                           (a.RNK<>rnk_ OR s.OB22<>'07' OR a.DAZS is not NULL);

                   Exception when no_data_found then
                     EXIT;     -- ������ ����� ��� ���, - ���������
                   End;

                   i := i + 1;
                   if i = 100 then
                      exit;
                   end if;

                end loop;

               EXCEPTION when no_data_found then
                null;
               END;  ---------- END ������� ������ 3579*  -----


               OP_REG(99,0,0,grp_,tmp_,rnk_,nlsd_,kva_,
               substr('������.��� �� 31�. '||nam_a_,1,70),'ODB',isp_,acc2_);

               p_setAccessByAccmask(acc2_,accd_);

               UPDATE rko_lst SET acc2=acc2_ WHERE acc=acc_;

               UPDATE accounts SET (TOBO)=
                               (select TOBO from Accounts WHERE acc=acc_)
                               WHERE acc=acc2_;
               ---INSERT into BANK_ACC (ACC,MFO)
               ---           select acc2_, MFO from BANK_ACC where ACC=acc_;

               BEGIN
                 INSERT INTO Specparam (ACC,S240,S270)  VALUES (acc2_,'C','01');
               EXCEPTION WHEN OTHERS THEN
                 UPDATE Specparam SET S240='C', S270='01' WHERE  ACC=acc2_;
               END;

               BEGIN
                 INSERT INTO Specparam_INT (ACC,OB22)  VALUES (acc2_,'07');
               EXCEPTION WHEN OTHERS THEN
                 UPDATE Specparam_INT SET OB22='07'  WHERE  ACC=acc2_;
               END;

            END IF; ---------------- END  �������� 3579*   -----------


            gl.ref (ref_);

            Insert into OPER (ref,tt,vob,nd,dk,pdat,vdat,datd, datP,
                           nlsa,nam_a,mfoa,nlsb,nam_b,mfob,
                           kv,s,kv2,s2,id_a,id_b,userid,nazn)
            VALUES (ref_,tt_,6,case when length(ref_)>10 then substr(ref_, -10) else to_char(ref_) end,1,SYSDATE,gl.bDATE,gl.bDATE, gl.bDATE,
                nlsd_,nam_a_,gl.aMFO,nlsc_,nam_a_,gl.aMFO,kva_,s1_,kvb_,s1_,
                 okpo_,okpo_,gl.aUID,
            '����������� ���� ���i�i� �� ������������ �������������� ���. '||nlsosn_
                   );


            GL.PAYV(flg_,ref_,gl.bDATE,tt_,1,980,nlsd_,s1_,980,nlsc_,s1_);

            insert into oper_visa (ref, dat, userid, status)
            values (ref_, sysdate, user_id, 0);

            IF s2_ > 0 THEN   -- ������ ��� ����
               UPDATE rko_lst SET dat2b=dat1b,comm=NULL WHERE acc=acc_;
            ELSE
               UPDATE rko_lst SET dat2a=dat1a,dat2b=dat1b,comm=NULL WHERE acc=acc_;
            END IF;

         EXCEPTION
            WHEN NO_MONEY THEN ROLLBACK TO beforko6; er(acc_); GOTO  nextrec3;
            WHEN OTHERS   THEN ROLLBACK TO beforko6; er(acc_); GOTO  nextrec3;
         END;
      END IF;

<<nextrec3>>
      COMMIT;

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
GRANT EXECUTE ON BARS.RKO TO BARS_ACCESS_DEFROLE;

SHOW ERRORS;
