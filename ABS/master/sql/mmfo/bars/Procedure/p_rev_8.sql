

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REV_8.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REV_8 ***

  CREATE OR REPLACE PROCEDURE BARS.P_REV_8 ( kv_ NUMBER, dat_ DATE,NBS_REV char ) IS

-- 11-11-2009 Sta RNK_ в accounts
-- 15.04.2009 Mik+Sta
-- Попередній БЕК операції REV (яка була раніше PVP для балансування вішалки)

 tt_      oper.tt%type := 'REV';

 dat2_    date := NVL(dat_,gl.bDATE);

 dat1_  DATE  ;
 ost1_  NUMBER; dosq_  NUMBER; dosd_ NUMBER ; dos_ NUMBER;
 ost2_  NUMBER; kosq_  NUMBER; kosd_ NUMBER ; kos_ NUMBER;
 dlta_  NUMBER; ostf_  NUMBER; nbs1_ CHAR(4);
 sdls_  NUMBER; sumos_ NUMBER; nbs2_ CHAR(4);
 pdat_    DATE;
 K980  int := gl.baseval; DATV_ date := gl.BDATE;
 ern  CONSTANT POSITIVE := 212;  err EXCEPTION; erm  VARCHAR2(80);

  ACC_6204 int; ACC_3800 int;
  OST_6204 number;
  ACC_     int;
  DAT_6204 date;
  NLS_3800  varchar2(15) :=vkrzn(substr(gl.AMFO,1,5),'38000000000000');
  NLS_38010 varchar2(15) :=vkrzn(substr(gl.AMFO,1,5),'38010000000000');
  NLS_38011 varchar2(15) :=vkrzn(substr(gl.AMFO,1,5),'38010000000001');

  S0000_ varchar2(15); --\
  S3800_ varchar2(15); --|  TABVAL
  S3801_ varchar2(15); --/
  s0009_ VARCHAR2(15); -- ВЕШАЛКА внеБАЛАНСОВАЯ
  rnk_   Number;

BEGIN
  NLS_3800  :=vkrzn(substr(gl.AMFO,1,5),'38000000000000');

---------------------------------------
  begin
    select s0000,s3800,s3801,s0009 into s0000_,s3800_,s3801_,s0009_
    from tabval where kv=KV_ and d_close is null;
  EXCEPTION WHEN OTHERS THEN RETURN;
  end;

  select to_number(trim(val)) into rnk_ from params where par='OUR_RNK';

  If NBS_REV <> '8' then
     -- еще работаем на старой вешалке 6404 или 35*-36*
     begin
        iF NBS_REV ='6' then
           select a.acc,s.ostf-s.dos+s.kos,s.fdat
           into ACC_6204,OST_6204,DAT_6204
           from accounts a, saldoB s
           where a.kv = KV_ and a.nls= S0000_ and a.acc= s.acc and
            (s.acc,s.fdat) = (select acc, max(fdat) from saldoB
                              where acc=s.acc and fdat<=DAT_ group by acc) ;

        elsiF NBS_REV ='3' then

           select a.acc, s.ostf-s.dos+s.kos, s.fdat
           into ACC_6204 , OST_6204, DAT_6204
           from accounts a, saldoB s
           where a.kv = KV_ and a.nls= S3801_ and a.acc= s.acc and
            (s.acc,s.fdat) = (select acc, max(fdat) from saldoB
                              where acc=s.acc and fdat<=DAT_ group by acc) ;

           If OST_6204 =0 then
              select a.acc, s.ostf-s.dos+s.kos, s.fdat
              into ACC_6204 , OST_6204, DAT_6204
              from accounts a, saldoB s
              where a.kv = KV_ and a.nls= S3800_ and a.acc= s.acc and
               (s.acc,s.fdat) = (select acc, max(fdat) from saldoB
                                 where acc=s.acc and fdat<=DAT_ group by acc) ;
           end if;
        end if;

        -- Сегодня же и перейдем
        update params set val=to_char(DAT_,'dd-mm-yyyy') where par='DAT_REV';
        if SQL%rowcount = 0 then
           insert into params (par, val, comm) values
            ('DAT_REV', to_char(DAT_,'dd-mm-yyyy'),'Дата перехода на вешалку 3800');
        end if;

     EXCEPTION WHEN NO_DATA_FOUND THEN  OST_6204:=0; ACC_6204:= null;
     END;
  end if;

  begin
     -- Открыта ли новая вешалка 3800 ?
     select acc into ACC_3800 from accounts where nls=NLS_3800 and kv=KV_ ;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     -- Нет, открываем новую вешалку 3800
     execute immediate 'SELECT bars_sqnc.get_nextval(''s_accounts'') FROM dual' INTO acc_3800;
     INSERT INTO ACCOUNTS (ACC,KV,NLS,NBS,VID,POS,PAP,nms, daos,rnk)
       VALUES(ACC_3800,kv_,NLS_3800,'3800', 0,1,3,
       'Балансування екв по валютi', gl.BDATE, RNK_);
  end;

  begin
     --есть ли хоть одна запись в SALDOa ?
     select acc into acc_ from saldoa where acc=acc_3800 and rownum=1;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     INSERT INTO SALDOA (ACC,FDAT,OSTF,DOS,KOS) VALUES( ACC_3800,DAT_,0,0,0);
  END;

  S0000_ :=NLS_3800;

  --цикл-1 d по датам
  FOR d IN (SELECT UNIQUE fdat FROM saldoa WHERE fdat>=DAT_ AND fdat<=gl.bDATE
  ORDER BY fdat )
  LOOP
     -- цикл-2 k по бал - внебал
     FOR k IN (SELECT acc,nls,NBS FROM accounts WHERE kv=kv_ AND nls in (s0000_,s0009_) order by nls)
     LOOP

        sdls_:=0;  dosd_:=0;  kosd_:=0;
        SELECT MAX(fdat) INTO dat1_ FROM saldoa WHERE fdat<d.fdat;
        dat1_ := NVL(dat1_,d.fdat);
        sumos_ := 0; -- Nominal ammount total

        IF k.nls=s0000_ THEN nbs1_:='1000'; nbs2_:='7999';
        ELSE                 nbs1_:='9000'; nbs2_:='9999';
        END IF;

        --цикл 3 c по счетам
        FOR c IN (SELECT s.acc, s.fdat, s.ostf, s.dos, s.kos
                  FROM accounts a, saldoa s
                  WHERE a.acc<>k.acc AND a.acc=s.acc AND (a.acc,s.fdat) =
                     (SELECT c.acc,MAX(c.fdat) FROM saldoa c
                      WHERE c.acc=a.acc AND c.fdat<=d.fdat GROUP BY c.acc)
                    AND a.kv=kv_ AND a.nbs>=nbs1_ AND a.nbs<=nbs2_ AND a.pos=1
                  )
        LOOP
           --Вход ост в номинале
           IF c.fdat=d.fdat
              THEN ostf_:=c.ostf;             dos_:=c.dos; kos_:=c.kos;
              ELSE ostf_:=c.ostf-c.dos+c.kos; dos_:=0;     kos_:=0;
           END IF;
           sumos_ := sumos_ + ostf_;                       /* Сумма вх ост в ном*/
           ost1_:=gl.p_icurval(kv_, ostf_, dat1_ );        /* Вход ост в экв*/
           ost2_:=gl.p_icurval(kv_,ostf_-dos_+kos_,d.fdat);/* Исх ост в экв*/
           dosq_:=gl.p_icurval(kv_, dos_, d.fdat );        /* реальные Об в экв*/
           kosq_:=gl.p_icurval(kv_, kos_, d.fdat );
           dlta_:=ost2_-(ost1_-dosq_+kosq_);      /*дельта для переоц счета*/
           IF dlta_<0 THEN dosq_:=dosq_-dlta_;    /*обороты вместе с переоц*/
           ELSE            kosq_:=kosq_+dlta_;
           END IF;

           BEGIN
              SELECT MAX(fdat) INTO pdat_ FROM saldob WHERE acc=c.acc AND fdat<=d.fdat;
           EXCEPTION WHEN NO_DATA_FOUND THEN pdat_ := NULL;
           END;
           IF pdat_<>d.fdat AND dosq_=0 AND kosq_=0 THEN /* сч переоц не надо */
              GOTO MET_EOL;
           END IF;
           --переоценка счета
           IF pdat_ = d.fdat THEN
              UPDATE saldob SET ostf=ost2_-kosq_+dosq_,dos=dosq_,kos=kosq_
              WHERE acc=c.acc AND fdat=d.fdat;
           ELSE
              INSERT INTO saldob (acc,fdat,pdat,ostf,dos,kos)
               VALUES (c.acc,d.fdat,pdat_,ost2_-kosq_+dosq_,dosq_,kosq_);
           END IF;
           --текущий итог оборотов
           kosd_:= kosd_ + dosq_;
           dosd_:= dosd_ + kosq_;
         <<MET_EOL>>
           --Сумма вход остатков
           sdls_:= sdls_ - ost2_ + kosq_ - dosq_;
        END LOOP; -- конец цикл 3c по счетам

        --дельта оборотов по вешалке
        IF dosd_>kosd_ THEN dosd_:=dosd_-kosd_; kosd_:=0;
        ELSE                kosd_:=kosd_-dosd_; dosd_:=0;
        END IF;

        BEGIN
           SELECT MAX(fdat) INTO pdat_
           FROM saldob WHERE acc=k.acc AND fdat <=d.fdat;
        EXCEPTION  WHEN NO_DATA_FOUND THEN pdat_ := NULL;
        END;

        --нет оборотов для вешалки
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


        -- ЭТО момент перехода со старой методики на 3800 !!
        If k.nls=NLS_3800 and OST_6204<>0 and ACC_6204 is not null and k.acc=ACC_3800
           THEN
           delete from saldoB where acc=ACC_6204 and fdat>=DAT_;

           If OST_6204 >0 then /* на старой вешалке был кредит вх остаток*/
              INSERT INTO saldob (acc, fdat, pdat,    ostf,     dos     , kos)
                     VALUES (ACC_6204, DAT_, DAT_6204,OST_6204, OST_6204, 0 );
              UPDATE saldob set ostf=0,kos=kos+OST_6204 where acc=k.acc and fdat=DAT_;
              if SQL%rowcount = 0 then
                 INSERT INTO saldob (acc, fdat, pdat, ostf,dos, kos )
                             VALUES (k.acc,DAT_,null, 0   ,  0, OST_6204);
              end if;

           elsIf OST_6204 <0 then /* на старой вешалке был дебет вх остаток*/
              INSERT INTO saldob (acc, fdat, pdat,    ostf,     dos, kos )
                     VALUES (ACC_6204, DAT_, DAT_6204,OST_6204, 0  ,-OST_6204);
              UPDATE saldob set ostf=0,dos=dos-OST_6204 where acc=k.acc and fdat=DAT_;
              if SQL%rowcount = 0 then
                 INSERT INTO saldob (acc, fdat, pdat, ostf,dos     , kos )
                             VALUES (k.acc,DAT_,null, 0,  -OST_6204, 0  );
              end if;
           end if;
           OST_6204:=0;
        end if;


        If k.nls=NLS_3800 then /*синхронизация 3800 и 3801 */
           Declare
              OstA_3800 number; OstA_3801 number;
              OstP_3800 number; OstP_3801 number;
              nmsA_3801 varchar2(38):='Баланc A-екв по вал';
              nmsP_3801 varchar2(38):='Баланc П-екв по вал';
              NLS_6204  varchar2(15); nms_6204  varchar2(38);
              REF_ int; S_ number; DK_ int;
           Begin

              FOR x IN (SELECT ref FROM oper
                        WHERE tt=tt_ AND nd=tt_||kv_ AND vdat=d.fdat AND sos>0)
              LOOP
                 gl.bck( x.ref, 9);
              END LOOP;

              --найти суммы А и П по 3800
              begin
                 select Nvl(sum(decode(Sign(B.ostf-B.dos+B.kos),1,
                             0,B.ostf-B.dos+B.kos)),0),
                        Nvl(sum(decode(Sign(B.ostf-B.dos+B.kos),1,
                             B.ostf-B.dos+B.kos,0)),0)
                 into OstA_3800, OstP_3800
                 from saldob b , accounts a
                 where b.acc=a.acc and a.nls=NLS_3800 and kv<>gl.baseval
                   and (b.acc,b.fdat) =(select acc, max(fdat) from saldob
                            where acc=b.acc and fdat<=d.FDAT group by acc);
              EXCEPTION  WHEN NO_DATA_FOUND THEN OstA_3800:=0; OstP_3800:=0;
              END;
              --найти суммы А по 3801
              begin
                 select acc into Acc_ from accounts where kv=k980 and nls=NLS_38010;
                 begin
                    select s.ostf-s.dos+s.kos into OstA_3801 from saldoa s
                    where s.acc=Acc_ and (s.acc,s.fdat)=(select acc, max(fdat)
                       from saldoa where acc=s.acc and fdat<=d.FDAT group by acc);
                 EXCEPTION  WHEN NO_DATA_FOUND THEN OstA_3801:=0;
                 end;
              EXCEPTION     WHEN NO_DATA_FOUND THEN OstA_3801:=0;
                 execute immediate 'SELECT bars_sqnc.get_nextval(''s_accounts'') FROM dual' INTO acc_;
                 INSERT INTO ACCOUNTS (ACC,KV,NLS,NBS,VID,POS,pap,nms, daos, rnk)
                   VALUES(ACC_,K980,NLS_38010,'3801', 0,  1,  3, nmsA_3801,
                   gl.BDATE, RNK_);
              END;

              --найти суммы П по 3801
              begin
                 select acc into Acc_ from accounts where kv=k980 and nls=NLS_38011;
                 begin
                    select s.ostf-s.dos+s.kos into OstP_3801 from saldoa s
                    where s.acc=Acc_ and (s.acc,s.fdat)=(select acc, max(fdat)
                       from saldoa where acc=s.acc and fdat<=d.FDAT group by acc);
                 EXCEPTION  WHEN NO_DATA_FOUND THEN OstP_3801:=0;
                 end;
              EXCEPTION     WHEN NO_DATA_FOUND THEN OstP_3801:=0;
                 execute immediate 'SELECT bars_sqnc.get_nextval(''s_accounts'') FROM dual' INTO acc_;
                 INSERT INTO ACCOUNTS (ACC,KV,NLS,NBS,VID,POS,pap, nms , daos, rnk)
                   VALUES(ACC_,K980,NLS_38011,'3801', 0,  1,  3, nmsP_3801,
                   gl.BDATE, RNK_);
              END;

              If OstA_3800 <>-OstA_3801 OR OstP_3800 <>-OstP_3801 then
                 begin
                    SELECT a.nls,substr(a.nms,1,38) INTO NLS_6204, nms_6204
                    FROM accounts a, vp_list v
                    WHERE a.nbs<'8000'
                      and v.acc6204=a.acc and a.dazs is null and rownum=1;
                 EXCEPTION   WHEN NO_DATA_FOUND THEN
                    SELECT nls,substr(nms,1,38) INTO NLS_6204, nms_6204
                    FROM accounts
                    WHERE nbs='6204' and kv=gl.baseval and dazs is null and rownum=1;
                 end;

                 gl.BDATE:=d.FDAT;
                 S_:= OstA_3800 +OstA_3801;
                 If S_ <>  0 then
                    If S_< 0 then DK_:=0; S_:=-S_; else DK_:=1; end if;
                    GL.ref (ref_);
                    INSERT INTO oper (ref,tt,vob,nd,dk,pdat,vdat,datd,
                         userid,nam_a,nlsa,mfoa,nam_b,nlsb,mfob,kv,s,nazn)
                    VALUES (ref_,tt_,6,tt_||kv_,DK_,SYSDATE,gl.bDATE,gl.bDATE,
                         gl.aUID, nmsA_3801 ,NLS_38010,gl.aMFO, NMS_6204, nls_6204,
                         gl.aMFO, K980,S_, nmsA_3801 ||' '||KV_);
                    GL.payv(1,ref_,gl.BDATE,tt_,DK_,K980,NLS_38010,S_,K980,nls_6204,S_);
                 end if;

                 S_:= OstP_3800 + OstP_3801;
                 If S_ <>0 then
                    If S_<0 then DK_:=0; S_:=-S_; else DK_:=1; end if;
                    GL.ref (ref_);
                    INSERT INTO oper (ref,tt,vob,nd,dk,pdat,vdat,datd,
                         userid,nam_a,nlsa,mfoa,nam_b,nlsb,mfob,kv,s,nazn)
                    VALUES (ref_,tt_,6,tt_||kv_,DK_,SYSDATE,gl.bDATE,gl.bDATE,
                         gl.aUID, nmsP_3801 ,NLS_38011,gl.aMFO, NMS_6204, nls_6204,
                         gl.aMFO, K980, S_, nmsA_3801 ||' '||KV_);
                    GL.payv(1,ref_,gl.BDATE,tt_,DK_,K980,NLS_38011,S_,K980,nls_6204,S_);
                 end if;
              end if;
           End;

        end if;
     END LOOP; -- конец цикл-2 k по бал - внебал
     -- COMMIT;
  END LOOP; --конец цикла-1 d по датам

  gl.bdate:=DATV_;

-----------------
EXCEPTION
   WHEN err    THEN gl.bdate:=DATV_;
                    raise_application_error(-(20000+ern), '\'||erm, TRUE);
   WHEN OTHERS THEN gl.bdate:=DATV_;
                    raise_application_error(-(20000+ern), SQLERRM , TRUE);
END p_rev_8;
/
show err;

PROMPT *** Create  grants  P_REV_8 ***
grant EXECUTE                                                                on P_REV_8         to ABS_ADMIN;
grant EXECUTE                                                                on P_REV_8         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_REV_8         to TECH005;
grant EXECUTE                                                                on P_REV_8         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REV_8.sql =========*** End *** =
PROMPT ===================================================================================== 
