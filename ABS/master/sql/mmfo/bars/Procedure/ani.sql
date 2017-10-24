

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ANI.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ANI ***

  CREATE OR REPLACE PROCEDURE BARS.ANI (MODE_ int, DAT_ date, DAT2_ DATE DEFAULT SYSDATE )
IS
--***************************************************************--
--             ��������� ��� ������� �������������� ������
--    1 - � �.�. ������� "ANI-1.������ ��� � ���"
--    3 - � �.�. ������� "ANI-3.����������� ����"

/*
      ����� AWK
      ������ ���������� ��� AWK.exe ���  AW.bat
      �����:   AWK ANI.sql ANI.<xxx> <���������>
               AWK ANI.sql ANI.123 1+2+3
               AWK ANI.sql ANI.12  1+2                                 *
               AWK ANI.sql ANI.13  1+3                                 *
               AWK ANI.sql ANI.1   1                                   *

               AWK ANI.sql ANI.ani 1+2+3+7

   1 - � �.�. ������� "ANI-1.������ ��� � ���"
   2 - � �.�. ������� "ANI-2.��������� ��������� �� ��"
   3 - � �.�. ������� "ANI-3.����������� ����"
   7 - � �.�. ������� "ANI-7.������������ ���-��� �� ���.��"

   28.08.2008 Sta ����� ������� ANI-7
   15.08.2008 Sta ��� ������� � RNBU_TRACE1 ��� ����� ���� �� �������
   05.06.2008 Sta ANI-3. ������.���� (������ ��� �����)
   07.05.2008 sTA ���� ���-���
   05.05.2008 Sta ��� �� ������� ����
--   28.03.2008 Sta � ���'�������� ���:
--                  I�������i� � ����i�����i �� ���i��i ������i�
--                  4102, 4103, 4105, 4202, 4203, 4205  H="�i���� 10 ���i�"
   26.11.2007 Sta �����  MODE_ in (1,-1)  GAP
     - 1 ��� ������� � ������� ��� (�� JOB)
     + 1 ��� ������� � ���.���
     ����� � �������

   23.11.2007 Sta �������� � ����������� ����
   14.11.2007 Sta ����������� � ������������
   02.11.2007 Sta + Virko
   ��� ���������� ���������������� ����� ������ ANI - ������.����
*/
    KS_    accounts.NLS%TYPE ;
    nls12_ accounts.NLS%TYPE ;
    NLSA_  accounts.NLS%TYPE ;
    NLSB_  accounts.NLS%TYPE ;
    n980_ int    ;
    JDAT_ date   ;
    IR_   NUMBER ;
    IT_   number ;
    OST_  number ;
    F_a7_ char(1);
    YN_   int    ;
    ZNAP_ number ;
    PAP_  char(1);
    XAR_  int    ;
    DAPP_ date   ;
    PAPS_ char(1);
    ACC_   int   ;
    BR_ID_ int   ;
    SR_   number ;
    ST_   number ;
    PRT_   int   ;
    SIR_  number ;
    SIT_  number ;
    SI_   number ;
    SROK_ int    ;

    cc_id_ CCK_AN_TMP.CC_ID%TYPE;
    KV_   accounts.KV%TYPE;
    TOBO_ accounts.TOBO%TYPE;

    errk SMALLINT;
    ern  CONSTANT POSITIVE := 333;
    err  EXCEPTION;
    erm  VARCHAR2(80);


begin
  n980_:= gl.baseval;
logger.info('ANI-1. ������, MODE_='|| MODE_);
  iF MODE_=333 THEN
     NULL;
--------------------------------------------------
--------------------------------------------------
  ELSIf MODE_  = 3 then
     cc_id_ := to_char(DAT_,'dd/MM/yyyy');
     Srok_  := DAt2_ - DAT_;

     -- �������� � ����������� ����
     delete from CCK_AN_TMP;
     -----------------------
     For k in (select i.ID, i.acc, a.nbs, a.daos, i.acra, i.acrb,
                      substr(fs180(a.ACC),1,1) S180
               FROM int_accN i, accounts a
               where i.id in (0,1) and a.acc=i.acc
                 and a.nbs in (select nbs from ani3)
               )
     LOOP
        -- ������ ����
        ST_:= null;
        begin
          -- � ���� �� ��� ������ �������� ?
          select 0 into ST_ from int_accn where id=k.ID+10 and acc=k.ACC;

          -- ������ �������� ������ ������� ������.���� (����� ��� �����) ?
          -- � ���������, ������������ ��� ����� ���������� � �������� �������,
          -- �� ����� �������� �� �� �������� �� ����� ���.�������
          begin
             select Nvl(a.prt,1) into PRT_
             from ani3 a, int_ratn r
             where r.id=k.ID+10 and r.acc=k.ACC and r.br=a.id
               and r.bdat = (select max(bdat) from int_ratn
                             where id=r.id and acc=r.acc and bdat<=DAT2_);
          EXCEPTION WHEN NO_DATA_FOUND THEN  PRT_:=1;
          end;

        EXCEPTION WHEN NO_DATA_FOUND THEN
          begin
            -- ���, � ���� �� ���� ��� ������ ����� * ?
            select b.BR_ID, Nvl(a.prt,1)
            into    BR_ID_,  PRT_
            from ani3 a, brates b
            where a.pap = k.ID+1 and a.nbs=k.NBS
              and a.s180= '*'
              and a.id  = b.br_id;
          EXCEPTION WHEN NO_DATA_FOUND THEN
            begin
              -- ���, � ���� �� ���� ��� ������� ����� ?
              select b.BR_ID,Nvl(a.prt,1)
              into    BR_ID_,  PRT_
              from ani3 a, brates b
              where a.pap = k.ID+1 and a.nbs=k.NBS
                and a.s180= k.S180
                and a.id  = b.br_id;
            EXCEPTION WHEN NO_DATA_FOUND THEN BR_ID_:= null;
            end;
          end;

          If BR_ID_ is not null then
             --��������� ������.��������
             insert into int_accn (acc,id,METR, BASEM,BASEY,FREQ,STP_DAT,IO )
                     select k.acc,k.id+10,METR, BASEM,BASEY,FREQ,STP_DAT,IO
                     from int_accn where acc=k.ACC and id=k.ID;

             insert into int_ratn (acc,id,       BDAT, BR    )
                         values (k.ACC,k.ID+10,k.daos, BR_ID_);
             ST_:=0;
          end if;
        end;

        If ST_ = 0 then

           -- ������ ���� � �����.������
           SR_ :=0;
           acrn.p_int(k.acc,k.id,   DAT_,DAT2_,SR_, NULL,0);
           SR_ := round(SR_,0);
           IR_ := acrn.fprocN(k.acc,k.id,   DAT2_);
--SumOP NUMBER :=0;  -- ����� �������� �� �������
--SumO  NUMBER :=0;  -- ����� ��������
           SIR_:= acrn.SumOP;
           SI_ := acrn.SumO;

           -- ������ ���� (��� �����) � �����.������
           acrn.p_int(k.acc,k.ID+10,DAT_,DAT2_,ST_, NULL,0);
           ST_:=round(ST_,0);
           IT_:=acrn.fprocN(k.acc,k.id+10,DAT2_);
           SIT_:= acrn.SumOP;

           If PRT_ = 2 then
              ST_:= ST_ + SR_;
              IT_:= IT_ + IR_;
           end if;

           nlsa_:= null; nlsb_:= null;

           if k.acra is not null then
              select nls into NLSA_ from accounts where acc=k.ACRA;
           end if;

           if k.acrb is not null then
              select nls into NLSB_ from accounts where acc=k.ACRB;
           end if;

           If SR_<>0 OR ST_<>0 then
              insert into CCK_AN_TMP
                    (acc,BRANCH, nls , kv  , reg , name , acra, accl,
                     pr ,  prs , n1  , n2  , n3  , n4   , n5  ,
                     nbs,   dl , tip , rezQ, zalQ, UV   ,cc_id, Srok )
              select k.acc,nvl(a.tobo,'0'),
                     a.nls, a.kv, a.rnk,substr(c.nmk,1,30),NLSA_,NLSB_,
                     IR_  , IT_ , fost(k.acc,DAT2_),
                     SR_  , gl.p_icurval(a.kv,SR_,DAT2_),
                     ST_  , gl.p_icurval(a.kv,ST_,DAT2_),
                     k.NBS, k.S180, k.id,
                     gl.p_icurval(a.kv,SIR_,DAT2_),
                     gl.p_icurval(a.kv,SIT_,DAT2_),
                     gl.p_icurval(a.kv,SI_ ,DAT2_),
                     cc_id_, Srok_
              from accounts a, customer c
              where a.acc=k.ACC and c.rnk=a.rnk ;
           end if;
-- acc,BRANCH,nls,kv - ���.����
-- reg,name - ������
-- acra, accl - ��.(NLS � �� ��� )���%, ��.���-����
-- pr - ��� % ������
-- prs - ������. % ������
-- n1 - ��� �� �����
-- n2 - ����� % �� ���.% ��
-- n3 - ����� % �� ���.% �� - ���,
-- n4 - ����� % �� �����.% ��
-- n5 - ����� % �� �����.% �� -���

        end if;
     END LOOP;

     Delete from int_ratn where id in (10,11);
     Delete from int_accn where id in (10,11);
     Commit;

     RETURN;

--------------------------------------------------
--------------------------------------------------

  ElsIf MODE_ in (1,-1) then /* GAP */

--     If MODE_ = 1 then  JDAT_ := gl.BD    ;
--     else               JDAT_ := gl.BD -1 ;
--     end if;
     If Dat_= Dat2_ or Dat2_ is null then
        select max(fdat) into JDAT_ from saldoa;
     else                     JDAT_:=dat2_;
     end if;


logger.info('ANI-1. ������ ���. p_fa7_nn �� '||JDAT_);
     Bars.p_fa7_nn( JDAT_,1);
     commit;
logger.info('ANI-2. ��������� ���. p_fa7_nn ');
-----------------------------------------------------------------------------

     delete from RNBU_TRACE1 where fdat is null or fdat=JDAT_ ;
     commit;
logger.info('ANI-3. ��������� ���. delete from RNBU_TRACE1 ');
-----------------------------------------------------------------------------

 INSERT INTO RNBU_TRACE1
  (RECID,USERID,NLS,KV,ODATE,KODP,ZNAP,NBUC,ISP,RNK,ACC,REF,COMM,ND,MDATE,FDAT)
 SELECT
   RECID,USERID,NLS,KV,ODATE,KODP,ZNAP,NBUC,ISP,RNK,ACC,REF,COMM,ND,MDATE,JDAT_
 FROM RNBU_TRACE WHERE SUBSTR(kodp,2,1)<'5' or SUBSTR(kodp,2,1)='9' ;
 commit;

logger.info('ANI-4. ��������� ���. insert 1 ');
-----------------------------------------------------------------------------
     for k in (SELECT nls,kv,nbs, acc, rnk, isp, mdate, tobo
               FROM accounts WHERE substr(nbs,1,1)<'5' and DAZS IS NULL)
     LOOP

        BEGIN
           SELECT s.Fdat, s.ostf-s.dos+s.kos,
                  decode( SIGN(s.ostf-s.dos+s.kos),1, '2','1')
           into DAPP_, OST_, PAPS_
           from saldoa s
           where acc=k.ACC and (s.acc,s.fdat)=
                (select acc, max(fdat) from saldoa
                 where acc=k.ACC and fdat<=JDAT_ group by acc);
           If OST_ <> 0 then
              select t020, r050, '0' /*f_A7*/ into PAP_, XAR_, f_A7_  from kl_r020
              where prem='�� ' and r020=k.NBS;
              YN_:=0; /* ��� �.�. HE �������� */
              If F_A7_ ='1' then YN_:=1; /* ��� �.�.�������� */
                 If PAP_ =3 then         /* �������� �� ������������ �_� �� */
                    begin
                      select acc into ACC_ from rnbu_trace1
                      where acc=k.ACC and fdat=JDAT_;
                    EXCEPTION WHEN NO_DATA_FOUND THEN YN_:=0; /* ��� HE �������� */
                    end;
                 end if;

                 If YN_=1 and XAR_ in (12,21) then  /* ������, ������ - �������� */
                    UPDATE rnbu_trace1
                      set kodp = (3-substr(kodp,1,1))||substr(kodp,2,10),
                          znap = '-'||ZNAP
                    where acc=k.ACC and fdat=JDAT_;
                 end if;
              end if;

              If YN_=0 then /* ��� ����� HE �������� */
                 If k.KV=n980_ then ZNAP_:= OST_ ;
                 else               ZNAP_:= gl.p_icurval(k.kv,OST_,JDAT_);
                 end if;
                 PAP_:= PAPS_; ZNAP_:= Abs(ZNAP_);

                 If XAR_ in (12,21) then  PAP_:= 3-PAP_; ZNAP_:= -ZNAP_;
                 end if;
                 INSERT INTO rnbu_trace1
                    (fdat,userid,nls,kv,odate,kodp,znap,acc,rnk,isp,mdate,comm,nbuc)
                  values
                    (JDAT_,gl.aUID,k.nls,k.kv,DAPP_, PAP_||k.NBS||
                    ' 1' || fs240_def(k.NBS,2,PAP_) || '  ',
                    to_char(ZNAP_),
                     k.ACC,k.RNK,k.ISP,k.MDATE, '��������� �� A7',k.tobo);
              END if;
           end if;
        EXCEPTION WHEN NO_DATA_FOUND THEN null;
        END;

/*
        -- 28.03.2008 Sta  4102,4103,4105,4202,4203,4205  H="�i���� 10 ���i�"
        If k.nbs in ('4102','4103','4105','4202','4203','4205') then
           UPDATE rnbu_trace1
                set kodp = substr(kodp,1,7)||'H'||substr(kodp,9,35)
                where acc=k.ACC and fdat=JDAT_;
        end if;
*/

        --07.05.2008
        BEGIN
           SELECT NVL(acrn.fproc(K.acc,JDAT_),0) INTO ir_ FROM anb1_ps
           where NBS=K.NBS AND (id like '1%' or id like '2%') and rownum=1;
           UPDATE rnbu_trace1 set IR=IR_ where acc=k.ACC and fdat=JDAT_;
        EXCEPTION WHEN NO_DATA_FOUND THEN IR_:= NULL; /*  HE ����. */
        END;

     END LOOP;

     commit;
logger.info('ANI-5. ��������� ���. insert 2 ');
--------------------------------------------------------------------

     Insert into RNBU_TRACE1 (fdat,kodp,KV, NBUC, znap)
     select JDAT_,'25     H', n980_, a.tobo, to_char(sum((s.ostf-s.dos+s.kos)))
     from accounts a, saldoa s
     where a.dazs is null and a.nbs >='5000' and a.nbs<'8000' and a.acc=s.acc
       and (s.acc,s.fdat)= (select acc,max(fdat) from saldoa
                            where  acc=a.ACC and fdat<=JDAT_ group by acc)
     group by a.tobo;
     commit;

logger.info('ANI-6. ��������� ���. insert 3 ');
--------------------------------------------------------------------
--------------------------------------------------

  end if;
logger.info('ANI-7. �����. ');

end ANI;
/
show err;

PROMPT *** Create  grants  ANI ***
grant EXECUTE                                                                on ANI             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ANI             to SALGL;
grant EXECUTE                                                                on ANI             to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ANI.sql =========*** End *** =====
PROMPT ===================================================================================== 
