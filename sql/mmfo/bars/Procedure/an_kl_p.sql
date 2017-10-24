

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/AN_KL_P.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure AN_KL_P ***

  CREATE OR REPLACE PROCEDURE BARS.AN_KL_P 
(id_ int, DAT1_ date, DAT2_ date, RNK1_ int, RNK2_ int, MNLS_ varchar2) IS
  dny_ int     ;  dny1_ int     ; kols_ int;
  i_   int     ;
  dat_ date    ;
  n1_  number  ;  NN1_ NUMBER ;q1_ number    ; KV_ int;
  n2_  number  ;  NN2_ NUMBER ;
  S_980_ number; S_840_ number; S_978_ number; S_810_ number; S_EQV_ number;
                 Q_840_ number; Q_978_ number; Q_810_ number;
  K_980_ number; K_840_ number; K_978_ number; K_810_ number;
  NNK_   int   ; NYK_   int   ; NMB_   int   ; OMB_   int   ;
  D1_    number; D2_    number; D3_    number; D4_    number;
  D5_    number; D6_    number; D7_    number; D8_    number;
  D9_    number; D10_   number; D11_   number; D12_   number;
  R1_    number;
  NMK_   varchar2(35);
ern CONSTANT POSITIVE := 203; erm VARCHAR2(80); err EXCEPTION;
BEGIN
--IF deb.debug THEN
--   deb.trace( ern, '1.id_', id_);
--END IF;
 delete from tmp_an_kl where id=id_;
-------- цикл -1: клиен е его мультивалютный счет
 for c0 in ( select cu.RNK, a.NLS, count(*) KOL, min(a.isp) ISP
             from cust_acc cu, accounts a
             where a.dazs is null and
                   cu.acc=a.acc and a.nls like mNLS_ and
                   cu.rnk>=RNK1_ and cu.rnk<=RNK2_
             group by cu.rnk, a.NLS)
 LOOP
IF deb.debug THEN
   deb.trace( ern, '2.rnk+nls', c0.rnk||' '||c0.nls);
END IF;
-- sred ost + obopot
    S_980_:=0; S_840_:=0; S_978_:=0; S_810_:=0; kols_:=0;
               Q_840_:=0; Q_978_:=0; Q_810_:=0;
    K_980_:=0; K_840_:=0; K_978_:=0; K_810_:=0;
    dny_ :=DAT2_ - DAT1_ ;
    dny1_:=dny_ + 1;
-------- цикл -2 : средние остатки: цикл по датам
    FOR i_ in 0..dny_
    LOOP
       select max(fdat) into dat_ from fdat where fdat<=DAT1_ + i_;
IF deb.debug THEN
   deb.trace( ern, '3.i+dat', i_||' '||to_char(dat_,'dd-mm-yyyy') );
END IF;
-------- цикл -3 цикл по остаткам счета
       for c1 in (select kv,acc from accounts where nls=c0.NLS)
       LOOP
IF deb.debug THEN
   deb.trace( ern, '4.acc, kv', c1.acc||' '||c1.kv );
END IF;
          begin
             SELECT ostf-dos+kos INTO n1_ FROM saldoa
             WHERE acc = c1.ACC and
                   (acc,fdat) = (SELECT acc,max(fdat)  FROM saldoa
                                 WHERE acc=c1.ACC AND fdat <=dat_
                                 GROUP BY acc );
             exception when NO_DATA_FOUND THEN n1_:=0;
          end ;

--IF deb.debug THEN
--   deb.trace( ern, '5.ost', n1_ );
--END IF;
          begin
             SELECT kos INTO n2_ FROM saldoa
             WHERE acc=c1.ACC AND fdat= DAT1_ + i_ ;
             exception when NO_DATA_FOUND THEN n2_:=0;
          end ;

IF deb.debug THEN
   deb.trace( ern, '6.kos', n2_ );
END IF;

          if i_=0 and c1.kv in (980, 840, 978, 810 ) then
             kols_:=kols_+1;
          end if;

          KV_:=c1.kv;
          begin
             SELECT ROUND( N1_/e1,0), ROUND( N2_/e1,0)
             into NN1_, NN2_  FROM euro WHERE kv=kv_ ;
             KV_:=978 ;
             N1_:=NN1_;
             N2_:=NN2_;
             exception when NO_DATA_FOUND THEN NN1_:=0;
          end ;

          q1_:= gl.p_icurval(KV_, n1_, DAT2_) ;

             if KV_=980 then S_980_:=S_980_+n1_; K_980_:=K_980_+n2_;
          elsif KV_=840 then S_840_:=S_840_+n1_; K_840_:=K_840_+n2_;
                               Q_840_:=Q_840_+q1_;
          elsif KV_=978 then S_978_:=S_978_+n1_; K_978_:=K_978_+n2_;
                               Q_978_:=Q_978_+q1_;
          elsif KV_=810 then S_810_:=S_810_+n1_; K_810_:=K_810_+n2_;
                               Q_810_:=Q_810_+q1_;          end if;
       END LOOP;
-------- цикл -3
    END LOOP;
-------- цикл -2

IF deb.debug THEN
   deb.trace( ern, '16.s_980,dny1', s_980_||' '||dny1_ );
END IF;

       S_980_:= round(S_980_/ dny1_,0);
       S_840_:= round(S_840_/ dny1_,0);
       S_978_:= round(S_978_/ dny1_,0);
       S_810_:= round(S_810_/ dny1_,0);

       Q_840_:= round(Q_840_/ dny1_,0);
       Q_978_:= round(Q_978_/ dny1_,0);
       Q_810_:= round(Q_810_/ dny1_,0);

--       s_eqv_:= S_980_  +
--                gl.p_icurval(840, S_840_, DAT2_) +
--                gl.p_icurval(978, S_978_, DAT2_) +
--                gl.p_icurval(810, S_810_, DAT2_) ;
--       if kols_ >0 then
--          s_eqv_:= round(s_eqv_/ kols_ ,0);
--       end if;

IF deb.debug THEN
   deb.trace( ern, '17.s_980', s_980_ );
END IF;
----кол-во док
    NNK_:=0;  NYK_:=0;  NMB_:=0;  OMB_:=0;
    FOR k in (select o.ref, o.dk, o.tt from opldok o, accounts a
              where a.acc=o.acc and o.fdat>=DAT1_ and o.fdat<=DAT2_ and
                    o.sos=5 and a.nls=c0.NLS)
    LOOP
          if k.dk=0 then
             if k.tt in
               ('KL1','KL2','KL3','KL4') then NYK_ :=NYK_+1;
             else                             NNK_ :=NNK_+1; end if;
                SELECT t.fli INTO N1_ FROM tts t, oper o
                WHERE t.tt=o.tt and o.ref=k.ref;
                if n1_ = 1               then NMB_ :=NMB_+1; end if;
          else
             if k.tt='R01'               then OMB_ :=OMB_+1; end if;
          end if;
    END LOOP;
----- доходность
    D1_:=0;  D2_:=0;  D3_:=0;  D4_:=0;
    D5_:=0;  D6_:=0;  D7_:=0;  D8_:=0;
    D9_:=0;  D10_:=0; D11_:=0; D12_:=0;
    R1_:=0;
    FOR k in ( select id, dk, NLS,  NLSM
               from an_kl
               where dk in (0,1) and (nls is not null OR NLSM IS NOT NULL)
              )
    LOOP
--- маска на включение и исключение
       IF K.NLS IS NOT NULL AND K.NLSM IS NOT NULL THEN
          begin
             SELECT SUM (S) INTO N1_
             FROM
             ( SELECT nvl(SUM(S),0) S
               FROM OPL
               WHERE DK=k.DK AND SOS=5 AND NLS like k.NLS AND KV=980 AND
                     FDAT >=DAT1_ AND FDAT<=DAT2_ AND
                     REF IN  (SELECT REF   FROM OPL
                              WHERE SOS=5 AND DK=1-k.DK AND
                                    nls=c0.NLS AND FDAT >=DAT1_ AND
                                    FDAT<=DAT2_ )
               UNION ALL
               SELECT -nvl(SUM(S),0)  FROM OPL
               WHERE DK=k.DK AND SOS=5 AND NLS like k.NLSM AND KV=980 AND
                     FDAT >=DAT1_ AND FDAT<=DAT2_ AND
                     REF IN  (SELECT REF   FROM OPL
                              WHERE SOS=5 AND DK=1-k.DK AND
                                    nls=c0.NLS AND FDAT >=DAT1_ AND
                                    FDAT<=DAT2_ )
             ) ;
          exception when NO_DATA_FOUND THEN n1_:=0;
          end ;
------ маска только на включение
       ELSIF K.NLSM IS NULL THEN
          begin
             SELECT nvl(SUM(S),0) INTO N1_
             FROM OPL
             WHERE DK=k.DK AND SOS=5 AND NLS like k.NLS AND KV=980 AND
                   FDAT >=DAT1_ AND FDAT<=DAT2_ AND
                   REF IN  (SELECT REF   FROM OPL
                            WHERE SOS=5 AND DK=1-k.DK AND
                                  nls=c0.NLS AND FDAT >=DAT1_ AND
                                  FDAT<=DAT2_ )   ;
          exception when NO_DATA_FOUND THEN n1_:=0;
          end ;
------маска только на исключение
       ELSIF K.NLS  IS NULL THEN
          begin
             SELECT -nvl(SUM(S),0) INTO N1_ FROM OPL
             WHERE DK=k.DK AND SOS=5 AND NLS like k.NLSM AND KV=980 AND
                   FDAT >=DAT1_ AND FDAT<=DAT2_ AND
                   REF IN  (SELECT REF   FROM OPL
                            WHERE SOS=5 AND DK=1-k.DK AND
                                  nls=c0.NLS AND FDAT >=DAT1_ AND
                                  FDAT<=DAT2_ )    ;
          exception when NO_DATA_FOUND THEN n1_:=0;
          end ;

       END IF;
          If k.id=1   then D1_ :=D1_ + n1_;
       elsIf k.id=2   then D2_ :=D2_ + n1_;
       elsIf k.id=3   then D3_ :=D3_ + n1_;
       elsIf k.id=4   then D4_ :=D4_ + n1_;
       elsIf k.id=5   then D5_ :=D5_ + n1_;
       elsIf k.id=6   then D6_ :=D6_ + n1_;
       elsIf k.id=7   then D7_ :=D7_ + n1_;
       elsIf k.id=8   then D8_ :=D8_ + n1_;
       elsIf k.id=9   then D9_ :=D9_ + n1_;
       elsIf k.id=10  then D10_:=D10_+ n1_;
       elsIf k.id=11  then D11_:=D11_+ n1_;
       elsIf k.id=12  then D12_:=D12_+ n1_;
       elsIf k.id=101 then R1_ :=R1_ + n1_;
       end if ;
    END LOOP;
-------------------
     select substr(nmk,1,35) into NMK_ from customer where rnk=c0.rnk;
--IF deb.debug THEN
--   deb.trace( ern, '6.nmk', nmk_ );
--END IF;
    insert into tmp_an_kl
      (id    , RNK   , NMK   , NLS   , KOL   , ISP,
       S_980 , S_840 , S_978 , S_810 , Q_840 , Q_978 , Q_810 ,
       K_980 , K_840 , K_978 , K_810 ,
       NNK   , NYK   , NMB   , OMB   ,
       D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11, D12,
       R1    )
    values
      (id_   , c0.RNK, NMK_  , c0.NLS, c0.KOL, c0.ISP,
       S_980_, S_840_, S_978_, S_810_, Q_840_, Q_978_, Q_810_,
       K_980_, K_840_, K_978_, K_810_,
       NNK_  , NYK_  , NMB_  , OMB_  ,
       D1_,D2_,D3_,D4_,D5_,D6_,D7_,D8_,D9_,D10_,D11_,D12_,
       R1_   );
 END LOOP;
-------- цикл -1
 commit;
EXCEPTION
  WHEN err    THEN raise_application_error(-(20000+ern),'\'||erm,TRUE);
  WHEN OTHERS THEN raise_application_error(-(20000+ern),SQLERRM,TRUE);
END an_kl_p ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/AN_KL_P.sql =========*** End *** =
PROMPT ===================================================================================== 
