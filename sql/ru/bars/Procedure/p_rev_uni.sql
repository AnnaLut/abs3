

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REV_UNI.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REV_UNI ***

  CREATE OR REPLACE PROCEDURE BARS.P_REV_UNI ( p_kv NUMBER, dat_ DATE,NBS_REV char ) IS

 dat1_  DATE  ;
 ost1_  NUMBER; dosq_  NUMBER; dosd_ NUMBER ; dos_ NUMBER;
 ost2_  NUMBER; kosq_  NUMBER; kosd_ NUMBER ; kos_ NUMBER;
 dlta_  NUMBER; ostf_  NUMBER; nbs1_ CHAR(4);
 sdls_  NUMBER; sumos_ NUMBER; nbs2_ CHAR(4);
 pdat_    DATE;
 K980  int := gl.baseval; DATV_ date := gl.BDATE;

  S0000_ varchar2(15); --\
  s0009_ VARCHAR2(15); -- ������� �������������

BEGIN
  If P_kv<> 840 then return; end if;
  ----------------------------------
  begin
    select nls into s0000_ from accounts  a
    where dazs is null and  nls=GetGlobalOption('S0000') and kv=k980
      and exists (select 1 from saldoa where acc=a.acc);
  EXCEPTION WHEN NO_DATA_FOUND THEN
    raise_application_error(-(20000+333), '\NOT s0000', TRUE);
  END;

  begin
    select nls into s0009_ from accounts  a
    where dazs is null and  nls=GetGlobalOption('S0009') and kv=k980
      and exists (select 1 from saldoa where acc=a.acc);
  EXCEPTION WHEN NO_DATA_FOUND THEN
    raise_application_error(-(20000+333), '\NOT s0009', TRUE);
  END;

  --����-1 d �� �����
  FOR d IN (SELECT UNIQUE fdat FROM saldoa
            WHERE fdat>=DAT_ AND fdat<=gl.bDATE
            ORDER BY fdat )
  LOOP
     -- ����-2 k �� ��� - ������
     FOR k IN (SELECT acc,nls,NBS FROM accounts
               WHERE kv=k980 AND nls in (s0000_,s0009_) order by nls)
     LOOP

        sdls_:=0;  dosd_:=0;  kosd_:=0;
        SELECT MAX(fdat) INTO dat1_ FROM saldoa WHERE fdat<d.fdat;
        dat1_ := NVL(dat1_,d.fdat);
        sumos_ := 0; -- Nominal ammount total

        IF k.nls=s0000_ THEN nbs1_:='1000'; nbs2_:='7999';
        ELSE                 nbs1_:='9000'; nbs2_:='9999';
        END IF;

        --���� 3 c �� ������
        FOR c IN (SELECT a.kv, s.acc, s.fdat, s.ostf, s.dos, s.kos
                  FROM accounts a, saldoa s
                  WHERE a.acc<>k.acc AND a.acc=s.acc
                    AND (a.acc,s.fdat) =
                     (SELECT c.acc,MAX(c.fdat) FROM saldoa c
                      WHERE c.acc=a.acc AND c.fdat<=d.fdat GROUP BY c.acc)
                    AND a.kv<>k980 AND a.nbs>=nbs1_
                    AND a.nbs<=nbs2_ AND a.pos=1
                  )
        LOOP
           --���� ��� � ��������
           IF c.fdat=d.fdat
              THEN ostf_:=c.ostf;             dos_:=c.dos; kos_:=c.kos;
              ELSE ostf_:=c.ostf-c.dos+c.kos; dos_:=0;     kos_:=0;
           END IF;
           sumos_ := sumos_ + ostf_;                       /* ����� �� ��� � ���*/
           ost1_:=gl.p_icurval(c.kv, ostf_, dat1_ );        /* ���� ��� � ���*/
           ost2_:=gl.p_icurval(c.kv,ostf_-dos_+kos_,d.fdat);/* ��� ��� � ���*/
           dosq_:=gl.p_icurval(c.kv, dos_, d.fdat );        /* �������� �� � ���*/
           kosq_:=gl.p_icurval(c.kv, kos_, d.fdat );
           dlta_:=ost2_-(ost1_-dosq_+kosq_);      /*������ ��� ������ �����*/
           IF dlta_<0 THEN dosq_:=dosq_-dlta_;    /*������� ������ � ������*/
           ELSE            kosq_:=kosq_+dlta_;
           END IF;

           BEGIN
              SELECT MAX(fdat) INTO pdat_ FROM saldob WHERE acc=c.acc AND fdat<=d.fdat;
           EXCEPTION WHEN NO_DATA_FOUND THEN pdat_ := NULL;
           END;
           IF pdat_<>d.fdat AND dosq_=0 AND kosq_=0 THEN /* �� ������ �� ���� */
              GOTO MET_EOL;
           END IF;
           --���������� �����
           IF pdat_ = d.fdat THEN
              UPDATE saldob SET ostf=ost2_-kosq_+dosq_,dos=dosq_,kos=kosq_
              WHERE acc=c.acc AND fdat=d.fdat;
           ELSE
              INSERT INTO saldob (acc,fdat,pdat,ostf,dos,kos)
               VALUES (c.acc,d.fdat,pdat_,ost2_-kosq_+dosq_,dosq_,kosq_);
           END IF;
           --������� ���� ��������
           kosd_:= kosd_ + dosq_;
           dosd_:= dosd_ + kosq_;
         <<MET_EOL>>
           --����� ���� ��������
           sdls_:= sdls_ - ost2_ + kosq_ - dosq_;
        END LOOP; -- ����� ���� 3c �� ������

        --������ �������� �� �������
        IF dosd_>kosd_ THEN dosd_:=dosd_-kosd_; kosd_:=0;
        ELSE                kosd_:=kosd_-dosd_; dosd_:=0;
        END IF;

        BEGIN
           SELECT MAX(fdat) INTO pdat_
           FROM saldob WHERE acc=k.acc AND fdat <=d.fdat;
        EXCEPTION  WHEN NO_DATA_FOUND THEN pdat_ := NULL;
        END;

        --��� �������� ��� �������
        IF Nvl(pdat_,d.fdat-1)<>d.fdat AND dosd_=0 AND kosd_=0 THEN
           GOTO MET_EO2;
        END IF;

        IF pdat_ = d.fdat THEN
           UPDATE saldob SET ostf=sdls_,dos=dosd_,kos=kosd_
           WHERE acc=k.acc AND fdat=d.fdat;
        ELSE
           INSERT INTO saldob (acc,fdat,pdat,ostf,dos,kos)
           VALUES (k.acc,d.fdat,pdat_,sdls_,dosd_,kosd_);
        END IF;

      <<MET_EO2>>
        NULL;

     END LOOP; -- ����� ����-2 k �� ��� - ������
     -- COMMIT;
  END LOOP; --����� �����-1 d �� �����

  gl.bdate:=DATV_;

END p_rev_UNI;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REV_UNI.sql =========*** End ***
PROMPT ===================================================================================== 
