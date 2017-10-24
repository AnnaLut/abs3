

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SPOT_P1.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SPOT_P1 ***

  CREATE OR REPLACE PROCEDURE BARS.SPOT_P1 ( Mode_ int, dat_ date DEFAULT gl.bdate, p_acc number ) IS

  --31-07-2009 Специально для ОБ
  -- Без учета операций БМ*
  -- Без проводки при изменении знака (или обнуления) ВАЛ.Поз.

  --05.11.2007 По методике НБУ, которая начинает действовать с 01.01.2006
  VX_   NUMBER; ISX_ nUMBER;
  DOS_  number; KOS_ number;
  SN_   number; SN1_ number; SI_  number; KV1_ int; KV2_ int;
  S1_   number; S2_  number;
  SPOT_K_ NUMBER(24,9);  SPOT_P_ NUMBER(24,9);
  K980 int :=gl.baseval;  NLS_3800 varchar2(15);
  DK_ int; REF_ int; MM_ number;
  nlsn_ varchar2(15); nlsr_ varchar2(15);
  namn_ varchar2(38); namr_ varchar2(38);
  V_R_   NUMBER(30,10);  V_RT_  char(5);
  I_R_   NUMBER(30,10);  I_RT_  char(5);

ern CONSTANT POSITIVE := 208;  err EXCEPTION; erm VARCHAR2(80);

BEGIN

  If Mode_ = 0 then
     DELETE from SPOT where vdate=DAT_ and acc = p_acc;
  end if;

  FOR sp IN (select t.kv, c.RATE_k, c.RATE_p, c.acc,
                    o.bsum, o.rate_o, t.lcv, t.name, t.DIG
             FROM tabval t, SPOT c, cur_rates o
             where c.acc = p_acc and t.kv=c.kv and t.kv not in (980,960) and t.kv=o.kv
               and (c.kv,c.acc,c.vdate)=
                   (select kv,acc, max(vdate) from SPOT
                    where kv=c.kv and acc=c.acc AND vdate<DAT_ group by kv,acc)
               and (o.kv,o.vdate)=
                   (select kv,max(vdate) from cur_rates
                    where kv=o.kv and vdate<=DAT_ group by kv)
            )
  LOOP

    SPOT_K_:= Nvl(sp.RATE_k,0); SPOT_P_:= Nvl(sp.RATE_p,0);
    V_R_:=null;  V_RT_:=null  ;  I_R_:=null;  I_RT_:=null;

  begin
    SELECT ost+dos-kos, ost, DOS, KOS, nls
    INTO VX_,ISX_, DOS_, KOS_, NLS_3800
    FROM sal WHERE fdat=DAT_ and acc=SP.ACC;

--logger.info('SPM-1 sp.kv='||sp.kv|| ' VX_='|| VX_||' ISX_='||ISX_);

    -- Если изменился знак ВП или если были операции, которые увеличили ВП
    if sign(VX_)<>sign(ISX_) OR VX_>0 and ISX_>0 and KOS_>0  OR
                                VX_<0 and ISX_<0 and DOS_>0    then
       If    VX_>0 then V_R_:=SPOT_K_;V_RT_:='СЗККВ';
       elsIf VX_<0 then V_R_:=SPOT_P_;V_RT_:='СЗКПВ';
       end if;
       SN_ :=0; SI_ :=0; SN1_:=0;

       If ISX_>0 then  DK_:=1;   else     DK_:=0;    end if;

--logger.info('SPM-1a DK_='||DK_);

       FOR k in (select o.tt,o.dk,o.nlsa,o.nlsb,
                        p.S,o.kv KV1,o.kv2,o.s S1,o.S2,o.REF
                 from opldok p, oper o
                 where p.acc=sp.ACC and p.ref=o.ref and p.sos=5 and p.fdat=DAT_
                   and p.dk= DK_ and p.S>0 )
       LooP
--logger.info('SPM-1b DK_='||DK_);

          If substr(k.TT,1,2)='BM' and
             k.nlsa like '11%'     and
             k.nlsb like '38%'     and
             k.kv1=k.kv2          then
             begin
               select o.s into SN1_
               from opldok o, accounts a
               where o.ref=k.REF and substr(o.tt,1,2)='BM'
                 and o.dk=DK_ and o.acc=a.acc
                 and a.nls like '100%';
             EXCEPTION  WHEN NO_DATA_FOUND THEN
                SN1_:=gl.p_Icurval(sp.KV,k.S,DAT_);
             end;

          ElsIf  k.S  not in (k.S1 ,k.S2 ) or
             sp.KV not in (k.KV1,k.KV2) or
                   960 in (k.KV1,k.KV2)     then

             SN1_:=gl.p_icurval(sp.kv,k.S,DAT_); /*дочерняя валютооб операция*/

          ElsIf sp.KV=k.KV1 and k.kv2= K980 then
             SN1_:=k.S2;   /* родительская покупка-продажа за грн*/

          ElsIf sp.KV=k.KV2 and k.kv1= K980 then
             SN1_:=k.S1;   /* родительская покупка-продажа за грн*/

          Else             /* конверсия*/
             If sp.KV=k.KV1 then  KV2_:=k.KV2; S2_:=k.S2;
             else                 KV2_:=k.KV1; S2_:=k.S1;
             end if;

             begin
                If VX_ =0 and ISX_>0  /* з закритої перейшла в довгу */
                OR VX_ <0 and ISX_<0  /* залишилась короткою */         then
                   SN1_:=gl.p_Icurval(sp.KV,k.S,DAT_);
                else
                  select Round(S2_*c.rate_k,0) into SN1_
                  from spot c, accounts a
                  where a.nls=NLS_3800 and a.kv=c.kv and c.acc=a.acc
                    and c.rate_k > 0
                    and c.kv=KV2_  and (c.kv,c.acc,c.vdate)=
                     (select kv,acc,max(vdate) from SPOT
                      where kv=c.kv and acc=c.acc AND vdate<DAT_ group by kv,acc);
                end if;
             EXCEPTION  WHEN NO_DATA_FOUND THEN
                SN1_:=gl.p_Icurval(sp.KV,k.S,DAT_);
             end;
          end if;

          SI_:= SI_ + k.S;  SN_:= SN_ +SN1_;

       end loop;

--logger.info('SPM-2 SI=_'||SI_|| ' SN_='||SN_);
       ---------------------------
       If    VX_> 0 and ISX_>0 then  /* сохран длинная   ++  */
          SPOT_K_ := (SPOT_K_*VX_ + SN_)/ (VX_+SI_);
          SPOT_P_ := 0;
       elsIf VX_ =0 and ISX_>0  then  /* от 0 к длинной  0+  */
          SPOT_K_ := SN_/ SI_;
          SPOT_P_ := 0;
       elsIf VX_ <0 and ISX_>=0  then /* изменилась из короткой на длин -+ */
          select n.nls, r.nls, s.ost ,substr(n.nms,1,38), substr(r.nms,1,38)
          into   nlsn_, nlsr_, MM_, namn_,namr_
          from accounts n, accounts r, sal s, vp_list v
          where v.acc3800=sp.ACC and v.ACC_RRD =n.acc and v.ACC_RRS=r.acc
            and s.acc=n.acc and s.fdat=DAT_;
          If ISX_>0  then    SPOT_K_ := SN_/ SI_;
          else               SPOT_K_ := 0;
          end if;
          SPOT_P_ := 0;

 /* Это выброшено. т.к.счета 6204 не однозначно привязаны к 3800 !!
          If MM_ <> 0 then
             if MM_>0 THEN DK_:=1;   ELSE  DK_:=0; MM_:=ABS(MM_); END IF;
             GL.ref(ref_);
             INSERT INTO oper (ref,tt,vob,nd,dk,pdat,vdat,KV,KV2,S,SQ,S2,
               datd,DATP,NAM_A,NLSA,MFOA,NAM_B,NLSB,MFOB,USERID,nazn,sign)
             VALUES (ref_,'SPM',6,ref_,DK_,sysdate,GL.BDATE,980,980,MM_,MM_,MM_,
               gl.bDATE,GL.BDATE,namn_,nlsn_,gl.aMFO,namr_,nlsr_,gl.aMFO,gl.aUID,
               'Змiна ВП '|| NLS_3800 ||'/'||sp.KV||' з короткої на довгу ',GetAutoSign);
             GL.payv(1,ref_,dat_,'SPM',DK_,K980,nlsN_,MM_,K980,nlsR_,MM_);
          end if;
*/

       ElsIf VX_< 0 and ISX_<0  then  /* сохран короткая   --   */

--Logger.info('SPM-4 '|| SPOT_P_||'*'||(-VX_)||' +'|| SN_||')/ '||(-VX_)||'+'||SI_);

          SPOT_P_ := (SPOT_P_*(-VX_) + SN_)/ (-VX_+SI_);
          SPOT_K_ := 0;
       elsIf VX_=0  and ISX_<0  then  /* от 0 к короткой   0- */
          SPOT_P_ := SN_/ SI_;
          SPOT_K_ := 0;

       elsIf VX_>0 and  ISX_<= 0  then /* изменилась из длин на короткую +-  */
          If ISX_<0  then   SPOT_P_ := SN_/ SI_;
          else              SPOT_P_ := 0;
          end if;
          SPOT_K_ := 0;
          select n.nls, r.nls, s.ost ,substr(n.nms,1,38), substr(r.nms,1,38)
          into   nlsn_, nlsr_, MM_, namn_,namr_
          from accounts n, accounts r, sal s, vp_list v
          where v.acc3800=sp.ACC and v.ACC_RRD =n.acc and v.ACC_RRS=r.acc
            and s.acc=n.acc and s.fdat=DAT_;
/*  Это выброшено. т.к.счета 6204 не однозначно привязаны к 3800 !!
          If MM_ <> 0 then
             if MM_>0 THEN DK_:=1;  ELSE  DK_:=0; MM_:=ABS(MM_);  END IF;
             GL.ref(ref_);
             INSERT INTO oper (ref,tt,vob,nd,dk,pdat,vdat,KV,KV2,S,SQ,S2,
               datd,DATP,NAM_A,NLSA,MFOA,NAM_B,NLSB,MFOB,USERID,nazn,sign)
             VALUES (ref_,'SPM',6,ref_,DK_,sysdate,GL.BDATE,980,980,MM_,MM_,MM_,
               gl.bDATE,GL.BDATE,namn_,nlsn_,gl.aMFO,namr_,nlsr_,gl.aMFO,gl.aUID,
               'Змiна ВП '|| NLS_3800 ||'/'||sp.KV||' з довгої на коротку ',GetAutoSign);
             GL.payv(1,ref_,dat_,'SPM',DK_,K980,nlsN_,MM_,K980,nlsR_,MM_);
          end if;
*/
       end if;

       If ISX_ = 0 then
          SPOT_k_ := 0; SPOT_p_ := 0;
       end if;

       if mode_=0 then
          INSERT into SPOT (kv,acc,vdate,RATE_k,rate_p)
          values (sp.KV,sp.acc,DAT_,SPOT_k_,SPOT_p_);
       end if;

    end if;
  EXCEPTION  WHEN NO_DATA_FOUND THEN null;
  end;

  END LOOp;
------------
END SPOT_p1;
/
show err;

PROMPT *** Create  grants  SPOT_P1 ***
grant EXECUTE                                                                on SPOT_P1         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SPOT_P1         to RCC_DEAL;
grant EXECUTE                                                                on SPOT_P1         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SPOT_P1.sql =========*** End *** =
PROMPT ===================================================================================== 
