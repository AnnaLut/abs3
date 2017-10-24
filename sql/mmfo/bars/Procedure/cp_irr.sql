

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_IRR.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_IRR ***

  CREATE OR REPLACE PROCEDURE BARS.CP_IRR (IDN_ int,TT_ char, MOD_ int,DAT_ date ) is
-- (IDN_ int, TT_ char, MOD_ int, DAT_ date, RET_ OUT int ) is
/* 22.04.2008 Sta
   Процедура урегулирования начисленных % по методу эф.% ставки
   TT_  = 'IRR' код операции
   MOD_ = 0  По всем КД
   MOD_ > 0  По одному КД с nd=MOD_
   Вместе Bin\Bars008c.apd + патч PATCHo99.CP  + PROCEDURE CP_IRR
*/
 RET_  int ;
 IDE_  int := -(IDN_+2) ;
 FL_   int ;  NMS_  varchar2(38)  ;  R1_  int;
 VOB_  int ;  NMS6_ varchar2(38)  ;  VDAT_ date  := GL.BDATE  ;
 ACC8_ int ;  nls6_ varchar2(15)  ;  IRR_  number;  ACR_DAT_ date;
 SN_ number;  Int_  number        ;  SE_   number;  FDAT1_   date;
 S_  number;  TIP_  char(3):='SDI';  DK_   int   ;  ACCC_    int ;
 R_  number;  NLSR_ varchar2(15)  ;  NLS_ varchar2(15);
 ISP_  int ;  NMSR_ varchar2(38)  ;  Grp_   int  ;  MDATE_   date;
 ACC_  int ;  nazn_ varchar2(160) ;  REF_   int  ;  Q_     number;
 ZOIRR_ number;     DAT_DOS_ date ;  OST3_ number; IO_ int;

begin
 begin
   select to_number(substr(flags,38,1)) into FL_ from tts where tt=TT_;
 exception when no_data_found then
   RAISE_APPLICATION_ERROR (-20001, 'CP_IRR: Не описана операция '|| TT_ );
 end;

 begin
  select to_number(val) into zoirr_ from params where par='ZO_IRR';
 exception when no_data_found then zoirr_:=0;
 end;
--------------
RET_:=0;
FOR k in (select i.acc, i.acrb, i.acr_dat, i.basey, d.REF,
                 nvl(d.accD ,-100) ACCD  , nvl(d.accP ,-100) ACCP  ,
                 nvl(d.accR ,-100) ACCR  , nvl(d.accR2,-100) ACCR2 ,
                 nvl(d.accS ,-100) ACCS  ,
                 c.okpo, a.nls, substr(a.nms,1,38) NMS, a.KV, c.RNK
          from int_accn i, cp_deal d, accounts a, customer c
          where i.id =IDE_
            and d.acc=i.acc
            and a.acc=i.acc
            and a.rnk=c.rnk
            and i.acrb>0
            and NVL(i.acr_dat,a.daos-1)< DAT_
            and MOD_ in (0,d.ref) and d.ref>0 )
LOOP

   select min(fdat) into dat_dos_ from saldoa
   where dos+kos>0 and acc=k.ACC and fdat <= DAT_;

   If dat_dos_ is null then
      GOTO KIN_;
   end if ;

   IO_:=0;
   If k.ACR_DAT is null then ACR_DAT_ :=dat_dos_-1;
      begin
         select nvl(io,0) into IO_ from proc_dr
         where nbs=substr(k.nls,1,4) and rownum=1;
      exception when NO_DATA_FOUND THEN null;
      end;
   else                      ACR_DAT_ :=k.ACR_DAT ;
   end if ;

--logger.info('CP_IRR ACR_DAT_='||ACR_DAT_);

   NMS_:=k.NMS;
   RET_:=0;
   begin

     --Найти все, что будет нужно
     select a6.nls,round(r.IR,4), substr(a6.nms,1,38)
     into  nls6_,  IRR_, NMS6_
     from accounts a6, int_ratn r
     where r.acc=k.ACC and r.id=IDE_ and a6.acc=k.ACRB
       and a6.dazs is null;

   exception when NO_DATA_FOUND THEN
     RET_:=0;
     GOTO KIN_;
   end;

   SN_:=0; /* пересчитать нормальные проценты по осн долгу в игровом режиме */
   acrn.p_int(k.acc,IDN_,ACR_DAT_+1,DAT_,SN_, NULL,0);
--logger.info('CP_IRR sn_='||sn_);

   if k.KV=gl.baseval then  VOB_:= 6;  /* определить VOB */
   else                     VOB_:=16;
   end if;

   SN_:= round(Abs(SN_),0);

   -- в период ЗО на Украине
   If zoirr_=1 then
      begin
         If gl.baseval=980 and to_char(gl.bdate,'yyyyMM')>to_char(DAT_,'yyyyMM') then
            begin
               SELECT max(FDAT) into VDAT_ from fdat
               where to_char(fdat,'yyyyMM')<to_char(gl.bdate,'yyyyMM');
               VOB_:= 96;
            exception when NO_DATA_FOUND THEN null;
            end;
         end if;
      end;
   end if;

   NAZN_:=substr(
     'Регулювання нарахованих % по методу эф.% ставки='||IRR_||
     ' за перiод з '|| to_char(ACR_DAT_+1,'dd/mm/yyyy')||
     ' по '||to_char( DAT_,'dd/mm/yyyy'), 1,160);


   If SN_ = 0 and NOT (k.basey=2 and DAT_-ACR_DAT_=1 and TO_CHAR(dat_,'DD')='31')
      then /*окончательное обнуление дисконта (или премии) */
      NAZN_:= substr('Остаточне '||NAZN_,1,160);

      FOR k2 in (select OSTB,NLS,substr(nms,1,38) NMS
                 from accounts
                 WHERE acc in (k.ACCD,k.ACCP) and ostb<>0
                 )
      LOOP
         If k2.OSTB>0 then DK_:=1; S_:= k2.OSTB;
         else              DK_:=0; S_:=-k2.OSTB;
         end if;
         Q_:=gl.p_icurval(k.KV, S_, VDAT_ );
         GL.REF (REF_);
         INSERT INTO oper (s,s2,dk,ref,tt,vob,nd,PDAT, VDAT, DATD, DATP,
            nam_a,nlsa,mfoa,kv, nam_b,nlsb,mfob,kv2, nazn, userid,sign,id_a,id_b)
         VALUES(S_,Q_, DK_, ref_,TT_, VOB_,REF_,sysdate,VDAT_,VDAT_,gl.bDATE,
            k2.NMS,k2.NLS,gl.AMFO, k.KV, NMS6_,NLS6_,gl.AMFO, gl.baseval,
            NAZN_,USER_ID , GetAutoSign,k.OKPO, gl.aOKPO );
         GL.payV(FL_,REF_,VDAT_,TT_,DK_,k.KV,k2.NLS,S_,gl.baseval,NLS6_, Q_ );
      end LOOP; /* FOR k2 */

      update int_accn SET ACR_DAT = DAT_ where acc = k.ACC and id=IDE_;
      RET_:=1;
      GOTO KIN_;
   end if;

   -- эф.проценты по бал стоимости в игровом режиме
   SE_:=0;

   FDAT1_:= ACR_DAT_ + IO_;

   FOR K3 in (select FDAT1_+c.num  FDAT from conductor c
              WHERE  FDAT1_+c.num<= DAT_ and c.num>0 )
   LOOP
      OST3_:=0;
      If IDN_ = 0 then
         select sum (s.ostf + s.kos-decode(s.acc,
                                         k.ACCR,decode(s.fdat,gl.BD,0,s.dos),
                                         s.dos)
                                         )
         into OST3_
         FROM saldoa s
         where s.acc in (k.ACC, k.ACCD,k.ACCP,k.ACCR, k.ACCR2,k.ACCS)
           and (s.acc,s.fdat)=
               (select acc,max(fdat) from saldoa
                where acc=s.acc and fdat<=k3.FDAT group by acc);
      else
         select sum (s.ostf-s.dos+decode(s.acc,
                                         k.ACCR,decode(s.fdat,gl.BD,0,s.kos),
                                         s.kos) )
         into OST3_
         FROM saldoa s
         where s.acc in (k.ACC, k.ACCD,k.ACCP,k.ACCR, k.ACCR2,k.ACCS)
           and (s.acc,s.fdat)=
               (select acc,max(fdat) from saldoa
                where acc=s.acc and fdat<=k3.FDAT group by acc);
      end if;


      If OST3_<>0 then
         INT_:=0;
         int_:= OST3_*IRR_/36500;
--         acrn.p_int(k.ACC,IDN_+2,FDAT1_+1,K3.FDAT,int_,OST3_,0);
         SE_:=SE_+ INT_;
      end if;

--logger.info('CP_IRR = k3.fdat=' ||k3.fdat||
--                    ' , OST3_='||OST3_ ||
--                    ' FDAT1_=' || FDAT1_ );

      FDAT1_:=K3.FDAT;

   End LOOP; /* FOR K3 */
   SE_:= round(Abs(SE_),0);

--   delete from int_ratn where acc=k.ACC and id=3;
--   delete from int_accn where acc=k.ACC and id=3;

--logger.info('CP_IRR SE_='||SE_);

   update int_accn SET ACR_DAT = DAT_ where acc = k.ACC and id=IDE_;

   If SN_=SE_ then
      RET_:=1;
      GOTO KIN_;
   end if;
   ----------------
   -- Проводки
/*   If IDN_ =0 then    S_:=SN_-SE_;
     else                S_:=SE_-SN_;
     end if ;
*/
   S_:=SN_-SE_;
   If IDN_ =  0 then
      If   S_>0 then DK_:=0; TIP_:='SDI';  /* Умен Премию,  Увел дисконт */
      else S_:=-S_;  DK_:=1; TIP_:='SPI';  /* Умен дисконт, Увел премию */
      end if;
   else
      If   S_>0 then DK_:=1; TIP_:='SDI';  /* Умен дисконт, Увел премию */
      else S_:=-S_;  DK_:=0; TIP_:='SPI';  /* Умен Премию,  Увел дисконт */
      end if;
   end if;

   Q_:=gl.p_icurval(k.KV, S_, VDAT_ );

--logger.info('CP_IRR S_='||S_||' , Q_='||Q_);

   GL.REF (REF_);
   INSERT INTO oper (s,s2,dk,ref,tt,vob,nd, PDAT, VDAT, DATD, DATP,
        mfoa, kv, nam_b, nlsb, mfob, kv2, nazn, userid,sign, id_a, id_b )
   VALUES(S_, Q_, DK_, ref_,TT_, VOB_,REF_, sysdate, VDAT_, VDAT_, gl.bDATE,
        gl.AMFO, k.KV, NMS6_,NLS6_,gl.AMFO, gl.baseval,
        NAZN_, USER_ID , GetAutoSign, k.OKPO, gl.aOKPO );
   begin
     -- а есть ли обратный счет  ?
     select accc,acc,ABS(a.ostb), a.nls, substr(a.nms,1,38)
     into  ACCC_, acc_, R_, NLS_, NMS_
     from accounts a
     where a.kv=k.KV
       and a.acc=decode(TIP_,'SDI',k.ACCP,k.ACCD ) and a.ostb<>0;

   exception when NO_DATA_FOUND THEN R_:=0;
   end;

   If R_>=S_  then /* забрать с реверса S_ */
      gl.payV(FL_,REF_,VDAT_,TT_,DK_,k.KV,NLS_,S_,gl.baseval,NLS6_, Q_ );
   else
      begin         /* а есть ли прямой счет  ? */
         select ACCC,acc, nls,substr(nms,1,38)
         into ACCC_, acc_, NLS_,NMS_
         from accounts
         where  acc=decode(TIP_,'SDI',k.ACCD,k.ACCP )
           AND  kv=k.KV and dazs is null and rownum=1 ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         begin /* а есть ли номинальный счет в какой-нибудь валюте ? */
            select a.accc,a.isp ,a.grp ,a.mdate
            into    accC_,  isp_,  grp_,  MDATE_
            from accounts a
            WHERE a.acc=k.ACC
              and a.dazs is null and rownum=1;
         exception when NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR (-20001, 'CP_IRR: Нет сч-номинала' );
         end;

         begin
--logger.info('CP_IRR TIP='||TIP_);
            -- родительский счет номинала
            select nls into NLS_ from accounts where acc=ACCC_;
--logger.info('CP_IRR родительский счет номинала='||NLS_);

            -- родительский счет диск или премии
            select decode(TIP_,'SDI', nlsD, nlsP) into NLSR_
            from cp_accc where nlsa = NLS_ and rownum=1;
--logger.info('CP_IRR родительский счет диск или премии='||NLSR_);

            select acc, substr(nms,1,38)
            into ACCC_ , NMSR_
            from  accounts
            where nls=NLSR_ and kv=k.KV;
--logger.info('CP_IRR ACC родительский счет диск или премии='||NLSR_);

         exception when NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR (-20001, 'CP_IRR: Нет сч-род (D/P)' );
         end;

         -- открыть прямой счет
         NLS_:= Vkrzn(substr(gl.aMFO,1,5),
                      substr(NLSR_  ,1,4) || substr(k.NLS,5,10)
                     );
         cp.CP_REG_EX(99,0,0,GRP_,R1_,k.RNK,nls_,k.kv,NMS_,'ODB',ISP_,acc_);
         -- подвязать под родителя
         UPDATE accounts SET mdate=MDATE_,accc=ACCC_,seci=4, pos=0
                WHERE acc=acc_;
         -- запись в CP_Deal
         If TIP_ = 'SDI' then
            update cp_deal set accD=acc_ where ref=k.REF;
         else
            update cp_deal set accP=acc_ where ref=k.REF;
         end if;

      end;

      If R_>0    then /* забрать с реверса R_ */
         Q_:=gl.p_icurval(k.KV, R_, VDAT_ );
         gl.payV(FL_,REF_,VDAT_,TT_,DK_,k.KV,NLSR_,R_,gl.baseval,NLS6_, Q_ );
         -- и провести по прямому (S_-R_)
         S_:= S_ - R_;  Q_:=gl.p_icurval(k.KV, S_, VDAT_ );
         gl.payV(FL_,REF_,VDAT_,TT_,DK_,k.KV,NLS_,S_,gl.baseval,NLS6_, Q_ );
      else   /* провести только по прямому S_ */
         gl.payV(FL_,REF_,VDAT_,TT_,DK_,k.KV,NLS_,S_,gl.baseval,NLS6_, Q_ );
      end if;

      select NLS,substr(nms,1,38)
      into NLSR_, NMSR_
      from  accounts
      where acc=ACCC_;
      update oper set nam_a=NMSR_,nlsa=NLSR_ where ref=REF_;
   end if;

   RET_:=1;
 <<KIN_>> NULL;
END LOOP;  /*  FOR k */

end CP_IRR;
/
show err;

PROMPT *** Create  grants  CP_IRR ***
grant EXECUTE                                                                on CP_IRR          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CP_IRR          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_IRR.sql =========*** End *** ==
PROMPT ===================================================================================== 
