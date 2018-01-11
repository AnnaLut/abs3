

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CC_KOMISSIA.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CC_KOMISSIA ***

  CREATE OR REPLACE PROCEDURE BARS.CC_KOMISSIA 
(METR_  int   , --��� ��������
 nAcc_  int   , -- ��� �������� �
 nId_   int   , -- acrn.p_int(nAcc,nId,dDat1,dDat2,nInt,nOst,nMode)
 dDat1_ date  , --
 dDat2_ date  , --
 nInt_   OUT NUMBER, -- Interest accrued
 nOst_   number,
 nMode_  int)
IS

/*
   25.08.2015 Sta �������� 99. ������ COBUSUPABS-3721

   20.12.2011 Nov  ������� �������� 0. ��� ����� ������� ���������� ��������� (�������)
                   ���� ����� ���������� ����� �������� . ��� �����������. ���������� ��������
                   ����� ��� �����������  ����������  ���-��� �� ���������. (0 ����, 95 ����)
   14.03.2011 ���  ������� �������� 98 �� ������� ����� ������
   02.03.2010 Nov  ������� �������� 97 �� ���������� ����
   25.09.2009 Nov  ������� ������ �������� 95 �� �������� �� % ��� ����� �� ���                   � �������� 30/360
   13.05.2009 OLGA �������� �����������
   02.06.2008 Nov ��� ����� ������ ��������� ����� ����� ������� �������� 91
                  ������� ���������� ����� ������ � ������ ����������� � �� ����� ������� �������
                  ������� BARS010.apd ������ 134 �� 02.06.2008
   01.11.2007 Nov � �������� 94 ��������� ������������ ���� ������/����� ������.
                  ��������� ������� ��� ������� ����/����.����� ������� ���� ����� �� ������� �������
   28.09.2007 Sta Mert=92 = % � ������� ���������� �������         (������ ��� ��������,  �.�. ������ (����,���) �� ��� �� �����������)
   03.08.2007 Sta �������� �������� �� ���������� ����� ����
   22.05.2007 Nov �������� ��� ������� ��� ������� ����� ����� 333432
              91 - ��� ���=333432 ������������ �� ������������ 94 ��������, ������� �� 94:                   ������-�� � ��� ������ � % �������� ����-�� � ����
              92 - ��� ������-�� ��� ���� ��������� ������� � ���������-�� � ����  ��� ���=333432
   01.03.2007 Sta 94 - �������� ����� ����                  ( % �� ���������������� ����� ������� ��            �� ����������� ��� � ����������� ������� )
   17.01.2007 ���� ���� �������� ��� ����=92
   28.10.2006 Sta ���������� ����� �������� � ���������� �� � nInt_ (OUT)
   03.10.2006 Sta ��� ��� ��� ��� ������ ����
                  - ����� �� ��, � ��� acr_dat <DAT_31 ��� acr_dat is NULL     � ���� ��������� ��� ��
                  - � ����.��. ������ � ������� �� (���_01,���_����) �� ���_31
                  - � acr_dat ������ DAT_31
   18.05.2006 ������. �������� ����� ��� �������� = 93            % �� �������������� ����� ��
   03.05.2006 ������� �� ������� ����������:
           - ������ ��� ��������
           - ��������� ������� �������� �� �������� ������ and (a.dazs is null or a.dazs>DAT2_);

   31.01.2006 ������ ��� "�������������" �������� ���� �������
   01.12.2005 ������ ��� ��� �� ���� ������� ��, ��� ������� ����� ���� ����
   28.10.2005 ������  �������� �� ��������
*/

 KV_  int;  NLS_ varchar2(15); ND_  cc_deal.nd%type; ACR_DAT_ date ;
 IR_ number    ; -- ������ ��������
 S_  number :=0; --����� � ��������
 l_ostx   number; -- ������� �����
 DAT_31   date ;
 DAT_01   date ;
 dTmp_    date ; nTmp_ number;
 dTmp_31_ date ;
 DAOS_    date ;
 Kol_ int;
 modcode CONSTANT varchar2(3) := 'CCK';
 l_title varchar2(20) := 'CCK CC_KOMISSIA: ';
 BASEY_ int_accn.basey%type;
 l_nazn acr_intN.nazn%type;
 l_cc_id cc_deal.cc_id%type;

BEGIN
  nInt_ :=0;
  --��������� ���� ������,�� ��� �� ��������� (31 ����� )
  DAT_31 := add_months( dDat2_-to_number(to_char(dDat2_,'dd')),1);
  --������ ���� ������,�� ��� �� ��������� (01 ����� )
  DAT_01 :=add_months(DAT_31,-1)+1;

   bars_audit.trace('%s 1.������: DAT_31=>%s, DAT_01=>%s',     l_title, to_char(DAT_31), to_char(DAT_01));

  BEGIN
    SELECT a.kv, a.nls, GREATEST(a.DAOS, DAT_01),a.daos , n.nd,d.cc_id, abs(a.ostx), i.basey
    INTO     KV_, NLS_,        ACR_DAT_,           DAOS_,  ND_,l_cc_id, l_ostx, BASEY_
      FROM accounts a, int_accn i, nd_acc n,cc_deal d
     WHERE a.acc=nAcc_ AND a.acc=i.acc AND i.id=2 AND i.metr>90
       AND a.nls like '8999%' and a.acc=n.acc and d.nd=n.nd
       AND i.acra is not null AND i.acrb is not null
       AND a.daos<=DAT_31 AND i.tt is not null
       AND (a.dazs is null   OR a.dazs>DAT_31)
       AND (to_char(i.ACR_DAT,'YYYYMM') < to_char(DAT_31,'YYYYMM')           OR           i.acr_dat is null) ;

    bars_audit.trace('%s 2.NLS_=>%s, KV_=>%s, METR_=>%s, gl.amfo=>%s, ACR_DAT_=>%s,DAOS_=>%s',    l_title, NLS_, to_char(KV_), to_char(METR_), gl.amfo, to_char(ACR_DAT_), to_char(DAOS_));

  EXCEPTION WHEN NO_DATA_FOUND THEN         RETURN ;
  END;
---------------------------------------
  BEGIN
    SELECT i.ir/100      INTO IR_      FROM int_ratn i
    WHERE i.acc=nAcc_ AND i.id=nId_  AND i.ir>0   AND (i.acc,i.id,i.bdat) =  (SELECT acc,id,max(bdat)  FROM int_ratn  WHERE acc=i.acc AND id=i.id AND bdat<=DAT_31  GROUP BY acc,id );
    bars_audit.trace('%s 3.IR_=>%s',    l_title, to_char(IR_));
  EXCEPTION WHEN NO_DATA_FOUND THEN IR_:=0;
  END;

  IF METR_ =  0 THEN  acrn.p_int(nAcc_,nId_,DAT_01, DAT_31,S_,NULL,1);
    
     update acr_intN  set nazn='����������� �������� ���� �� ������� N '||l_cc_id||' �a '||to_char(DAT_01,'mm')||' �i���� '||to_char(DAT_01,'yyyy')||' ����. ������ '||to_char(IR_*100,'990D99MI')
     where acc=nAcc_ and  id=nId_;

  ElsIf METR_ = 99 THEN  ---   25.08.2015 Sta �������� 99. ������ COBUSUPABS-3721

     S_ := 0; dTmp_ := DAT_01;
     for k in (select fdat from cc_lim where  nd = ND_ and fdat >=  DAT_01 and fdat < DAT_31 and fdat > DAOS_ and sumg > 0
               union all select DAT_31  from dual
               order by 1
              )
     loop
       begin select lim2 into l_ostx from cc_lim where nd = ND_ and fdat = (select max(fdat) from cc_lim where nd = ND_ and fdat < k.fdat);
             dTmp_ := greatest (dTmp_,DAT_01);        s_ := s_ +  calp_NR ( l_ostx , IR_*100, dTmp_, k.fdat, basey_);
             dTmp_ := k.fdat +1 ;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
       end;
     end loop;

  ELSIF METR_ = 91 THEN   -- ������� 1 (��� ����� ����� ����� �����)
     IF gl.amfo='333432' THEN     -- ������ 94, ������� ����������� �� 1 ���� � ��� � ��� ������ (�����, �����)
        S_:=0; dTmp_ := DAT_01;
        WHILE  dTmp_ <= DAT_31
        LOOP
           BEGIN SELECT Nvl(s.ostf-s.dos+s.kos,0) INTO nTmp_  FROM saldoa s  WHERE s.acc=nAcc_  AND (s.acc,s.fdat) = (SELECT acc,max(fdat) FROM saldoa  WHERE acc=s.acc AND fdat<=dTmp_ GROUP BY acc);
                 S_ := S_ + nTmp_;
           EXCEPTION WHEN NO_DATA_FOUND THEN null;
           END;
           dTmp_:= dTmp_ + 1 ;
        END LOOP;
        S_ := Round( S_*IR_,0) ;

     ELSIF gl.amfo='353575' THEN        S_ := gl.p_icurval(KV_, IR_*10000*1000, DAOS_ )/1000;      -- ������� 2 (��� ����� ������)
     ELSE      -- �������� ����������� ( �� ���������� ������� � ����������� �������)
        BEGIN  SELECT Round((s.ostf-s.dos+s.kos) *IR_,0) INTO S_  FROM saldoa s  WHERE s.acc=nAcc_   AND (s.acc,s.fdat) =
                (SELECT acc,max(fdat)  FROM saldoa           WHERE acc=s.acc AND fdat<=DAT_31 GROUP BY acc);
        EXCEPTION WHEN NO_DATA_FOUND THEN S_:=0;
        END;
     END IF;

  ELSIF METR_ = 92 THEN
     begin
       IF gl.amfo='333432' THEN      -- ������ 92, ������� ����������� �� 1 ���� � ��� � ��� ������ (�����, �����)
          SELECT Round( SUM(LEAST(kos,dos) - DOS) * IR_ * to_number(to_char(DAT_31,'dd')),0)  INTO S_   FROM saldoa   WHERE acc=nAcc_ AND dos>0;
       ELSIF gl.aMFO = '300120' THEN    --   28.09.2007 Sta Mert=92 = % � ������� ���������� �������      --  (������ ��� ��������,  �.�. ������ (����,���) �� ��� �� �����������)
          SELECT Round(s.DOS*IR_,0)  INTO S_   FROM saldoa s
          WHERE s.acc=nAcc_  AND (s.acc,s.fdat)= (SELECT acc,min(fdat)  FROM saldoa            WHERE acc=s.acc AND dos>0 GROUP BY acc);
       ELSE     -- �������� ��� ( �� ����� ���� ����� � ������ ��)
          SELECT Round( SUM( LEAST(kos,dos) - DOS) * IR_,0)       INTO S_   FROM saldoa  WHERE acc=nAcc_ AND dos>0;
       END IF;
     EXCEPTION WHEN NO_DATA_FOUND THEN S_:=0;
     END;

  ELSIF METR_ = 93 THEN   -- % �� �������������� ����� ��
     BEGIN  SELECT Round(l.LIM2*IR_,0)     INTO S_     FROM nd_acc n, cc_lim l
            WHERE nAcc_=n.acc AND n.nd=l.ND  AND (l.ND,l.FDAT) =    (SELECT nd, min(fdat)  FROM  cc_lim  WHERE nd=l.ND GROUP BY nd);
     EXCEPTION WHEN NO_DATA_FOUND THEN S_:=0;
     END;

  ELSIF METR_ = 94 THEN  -- �������� ����� ���� ( % �� ���������������� ����� ������� ��     �� ����������� ��� � ����������� ������� )
     Kol_:=0; S_:=0; dTmp_ := ACR_DAT_; dTmp_31_ := ACR_DAT_;
     WHILE  dTmp_ <= DAT_31
     LOOP
       BEGIN SELECT Nvl(s.ostf-s.dos+s.kos,0) INTO nTmp_ FROM saldoa s
             WHERE s.acc=nAcc_   AND (s.acc,s.fdat) =  (SELECT acc,max(fdat) FROM saldoa  WHERE acc=s.acc AND fdat<=dTmp_ GROUP BY acc);
             S_ := S_ + nTmp_;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
       END;
        IF Kol_  =  0 THEN ACR_DAT_:=dTmp_; END IF; -- ������ ��������� ���� ��������
        IF nTmp_ <> 0 THEN Kol_:= Kol_ + 1; END IF;
        IF Kol_  <> 0 AND nTmp_<>0  THEN dTmp_31_:=dTmp_; END IF;-- ������ ���� ��������� ��������
       dTmp_:= dTmp_ + 1 ;
     END LOOP;
     IF Kol_<>0 THEN
        S_:= Round( S_*IR_/Kol_,0);
     END IF;
     IF dTmp_31_< ACR_DAT_ THEN DAT_31:=ACR_DAT_;
     ELSE DAT_31:=dTmp_31_;
     END IF;

  ELSIF METR_ = 95 THEN
    begin    select (sdog*IR_*100)  into S_ from cc_deal where nd=ND_;
    l_nazn:='����������� ���i�i� �� �������������� ������� N '||l_cc_id||' �a '||to_char(DAT_01,'mm')||' �i���� '||to_char(DAT_01,'yyyy')||' ����. ������ '||to_char(IR_*100,'990D99MI');
    exception when others then      logger.info('CCK komis: �� ������� ����������� ���. ��� �������� �'||ND_);
    end;

  ELSIF METR_ = 96 THEN
    begin    select (ostc*IR_)  into S_ from accounts where nls like '8999_'||to_char(ND_);
    l_nazn:='����������� ���i�i� �� �������������� ������� N '||l_cc_id||' �a '||to_char(DAT_01,'mm')||' �i���� '||to_char(DAT_01,'yyyy')||' ����. ������ '||to_char(IR_*100,'990D99MI');
    exception when others then     logger.info('CCK komis: �� ������� ����������� ���. ��� �������� �'||ND_);
    end;

  ELSIF METR_ = 97 THEN            -- �� ������������� �����
    begin     S_:=TRUNC(IR_*10000,2);
     l_nazn:='����������� ���i�i� �� �������������� ������� N '||l_cc_id||' �a '||to_char(DAT_01,'mm')||' �i���� '||to_char(DAT_01,'yyyy')||' ����. �� ���� '||to_char(IR_*100,'99999990D99MI');
    exception when others then     logger.info('CCK komis: �� ������� ����������� ���. ��� �������� �'||ND_);
    end;

  ELSIF METR_ = 98 THEN  --      -- �� ������� ����� �� ��������  (�� ����� 10 000 ��� ��� ������ 0.03 = 3 ���  )
    begin     S_:=TRUNC(l_ostx*IR_,2);
     l_nazn:='����������� ���i�i� �� �������������� ������� N '||l_cc_id||' �a '||to_char(DAT_01,'mm')||' �i���� '||to_char(DAT_01,'yyyy')||' ����. �� ���� '||to_char(IR_*100,'99999990D99MI');
    exception when others then     logger.info('CCK komis: �� ������� ����������� ���. ��� �������� �'||ND_);
    end;

  ELSE      RETURN;     --������ �������� ....
  END IF;

    bars_audit.trace('%s 4.�����:S_=>%s',             l_title, to_char(S_));

  IF nMode_ = 1 and METR_>=90  THEN
     DELETE FROM acr_intN WHERE  acc=nAcc_ AND id=nId_;
     INSERT INTO acr_intN (acc, id, fdat, tdat,ir,br,acrd,remi,nazn)    VALUES (nAcc_,nId_ ,ACR_DAT_,DAT_31,IR_*100,0, S_ ,0,l_nazn);
  END IF;

  nInt_:= S_;

end CC_KOMISSIA ;
/
show err;

PROMPT *** Create  grants  CC_KOMISSIA ***
grant EXECUTE                                                                on CC_KOMISSIA     to BARS010;
grant EXECUTE                                                                on CC_KOMISSIA     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_KOMISSIA     to RCC_DEAL;
grant EXECUTE                                                                on CC_KOMISSIA     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CC_KOMISSIA.sql =========*** End *
PROMPT ===================================================================================== 
