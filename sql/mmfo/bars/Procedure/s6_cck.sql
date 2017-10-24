

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/S6_CCK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure S6_CCK ***

  CREATE OR REPLACE PROCEDURE BARS.S6_CCK 
 (BRANCH_ varchar2,  --   '/333368/'
  NBS_    char    ,  -- маска Бал счета,  '2%'
  NLS_    varchar2,  -- NLS   = 1 лицевой счет, или '*' - по маске БС
  ACR_DAT_   date ,  -- Дата, по которую начислены %  ( включительно ).
  dd_         int )  --Пл. День: Null - от даты КД,  Число - дата-конст
IS

 OB22_ char(2); NBS6  char(4);
------------
 Dat1_  date;
 DAT4_  date;
 Dat1g_ date;
 DAT4g_ date;
 GPK_    int;
 DAT2g_ date;
 ND_     int;
 aim_    int;
 KOM_ number :=  0; -- % комиссии
 METR_90 int :=  null ; -- методика комиссии
 DEN_    int := 25; -- день погашения
 ACC8_   int ; DATP_ date;
 DEL2_ number;
 G67_  varchar2(15);
 sOS_     int;
 PAWN_    int;
 KF_ varchar2(6) := substr(BRANCH_,2,6);
 ACRB_    int;
 ACRA_    int;
 IR_SS number;
 IR_SP number;
 --DATE_ST_ date;
 ALL_ZADOL_ number;
 DS_ varchar2(8);

begin
  bc.subst_mfo(KF_);
  --удаляем повторяющиеся счета
  for k in (select a.NBS, a.DAOS, a.nls, a.acc, a.rnk,  a.isp, a.grp, a.KV,
                   decode(substr(a.nbs,1,2),'22',11,1) VIDD,
                   -A.ostc LIMIT, co.SUMMA*100 SUMMA,
                   co."IdContract" CC_ID ,
                   co.v_main, co.D_BEGIN, co.D_RETURN
            from "S6_Credit_NLS" s6,
                 "S6_Contract"   co,
                 Accounts a
            where s6."Type"=1 and a.kf=s6.bic and s6.bic=KF_
              and s6."IdContract" = co."IdContract"
              and a.branch=BRANCH_
              and substr(a.nls,1,4)||substr(a.nls,6,9)=s6.nls
 and a.nbs in ('2232', '2233','2202', '2203','2212', '2213')
--   and a.nbs in ('2082', '2083','2062', '2063','2072', '2073')
             and a.NBS like NBS_
--and NOT exists (select 1 from nd_acc where acc=A.ACC)
             and NLS_ in (a.nls,'*')
            )
  loop

logger.info('CCK- 1 '|| k.nls);

    --найти вид обеспечения
    begin
      select PAWN into PAWN_ from cc_pawn where k.v_main=s031 and pawn<>34;
    exception when no_data_found then PAWN_:=33;
    end;

    --найти цель
    begin
      select nvl(min(AIM),62)  into aim_    from cc_aim    where k.nbs in
       ( nvl(NBS,'2062'), nvl(NBS2 ,'2063'),nvl(NBSF,'2202'), nvl(NBSF2,'2203'));
    exception when no_data_found then aim_:=62;
    end;

    -- найти % ставку
    IR_SS := null;    DAT1_:= least(k.D_BEGIN,k.daos) ;    DAT4_:= k.D_RETURN;

    If DAT1_ is not null then
       If DAT1_ >= DAT4_ then
          insert into  TEST_PROT_CCK  (branch,kv,nls,rnk,cc_id,txt)
             values (BRANCH_,k.kv,k.nls,k.rnk, k.CC_ID,
              'S6:Дата Нач='|| DAT1_|| ' >= Дата кон='||DAT4_);
          GOTO nextRec;
       end if;

       DEL2_:= round( months_between(DAT4_,DAT1_)+0.2,0) ;
       logger.info('CCK-'||k.CC_ID||' - '||DEL2_||to_char(dat4_,'ddmmyyyy')||'-'||to_char(dat1_,'ddmmyyyy')||'SUM='||to_char(k.SUMMA) );

       If DEL2_ < 1 then
          insert into  TEST_PROT_CCK  (branch,kv,nls,rnk,cc_id,txt)
             values (BRANCH_,k.kv,k.nls,k.rnk, k.CC_ID,'S6: Период < 15 дней');
          GOTO nextRec;
       end if;
       DEL2_:= Round(k.SUMMA / DEL2_,-2);


       select max("Prc_Osn")/100, max("Prc_Prs")/100  into IR_SS, IR_SP
       from "S6_Credit_Percent"  where "IdContract" = K.CC_ID ;
    Else
       insert into  TEST_PROT_CCK  (branch,kv,nls,rnk,cc_id,txt)
          values (BRANCH_, k.kv, k.nls, k.rnk, k.CC_ID, 'S6:Нет даты нач');
       GOTO nextRec;
    end if;
    DAT4_:= cck.CorrectDate(gl.baseval, DAT4_, DAT4_-1);
logger.info('CCK- 2 '|| DAT4_);
------
    If K.LIMIT=0 then  DEL2_:= 0;                       sos_:=13; GPK_ := 2;
    Else
       Den_:= NVL(DD_, to_number(to_char(DAT1_,'dd'))); SOs_:=10; GPK_ := 1;
    end if;
    PUL.Set_Mas_Ini( 'DEL2_', to_char(DEL2_), 'Дельта для ГПК' );

iF DD_ IS NULL THEN
   DS_   := to_char(gl.BDATE,'MM')||to_char(DAT1_,'DD');
   If    DS_ in ('0229','0230','0231'       ) then DS_:='0228';
   elsIf DS_ in ('0431','0631','0931','1131') then DS_:=substr(DS_,1,3)||'0';
   end if;
   DAT1g_:=TO_DATE( to_char(gl.BDATE,'YYYY')||DS_,'YYYYMMDD');
   If DAT1g_ > gl.BDATE then DAT1g_:= add_months(DAT1g_,-1); end if;
ELSE
   DAT1g_ := to_date( '25-02-2009','dd-mm-yyyy');
END IF;

  P_GPK( GPK_,0,K.LIMIT, DAT1g_, DAT4_, IR_SS, 5, 0, METR_90,0,2);

  ND_  := null; --открытие КД
  ALL_ZADOL_:= Abs(K.LIMIT);
  bars_context.subst_branch(branch_);
  CCK.CC_OPEN (ND_,k.RNK, substr(K.CC_ID,1,20), k.DAOS, DAT4_, k.DAOS, k.DAOS,
                   k.KV,  K.LIMIT/100, k.vidd, 4,  aim_,'', 1, 1, '',
                   k.ISP, '','', 5,IR_SS, 0, Den_, DAT1_, 5,  KOM_ );

  INSERT INTO nd_txt(ND,TAG,TXT) values(ND_, 'FLAGS','10');
  update cc_deal set sdog=k.SUMMA/100 where nd=ND_;
  update cc_add  set accs=k.ACC       where nd=ND_;
  if sos_=13 then
     update cc_deal set sos=13 where nd=ND_;
  end if;
  select acc into Acc8_ from accounts where kf=KF_ and nls like '8999_'||ND_;
  update accounts set tip='SS ',mdate=DAT4_, accc=acc8_ where acc=k.ACC;
  UPDATE accounts set vid=2, grp=k.GRP, branch=BRANCH_  where acc= ACC8_;
  insert into nd_acc (nd,acc) values (ND_,k.ACC);

  delete from cc_lim where nd=ND_;
  If DAT4_ - DAT1g_<15 then
     insert into cc_lim (ND,FDAT,LIM2,ACC,SUMG,SUMO,SUMK)
     select ND_,max(FDAT),k.LIMIT,ACC8_,sum(SUMG),sum(SUMO),sum(SUMK)
     from tmp_gpk ;
  else
     insert into cc_lim (ND,FDAT,LIM2,ACC,SUMG,SUMO,SUMK)
     select ND_,FDAT,LIM2,ACC8_,SUMG,SUMO,SUMK from tmp_gpk ;
  end if;

  INSERT INTO nd_txt (ND,TAG,TXT) values(ND_, 'INIC', branch_);
  If KOM_ > 0  then
     UPDATE int_accn set metr=METR_90 where acc=Acc8_ and id=2;
  end if;
  -----------------------

  ACRB_ := null;
  begin
     NBS6  := null;
     If    k.nbs in ('2202', '2203') then NBS6:='6042';
     elsIf k.nbs in ('2212', '2213') then NBS6:='6043';
     elsIf k.nbs in ('2232', '2233') then NBS6:='6046';
     elsIf k.nbs in ('2062', '2063') then NBS6:='6026';
     elsIf k.nbs in ('2072', '2073') then NBS6:='6027';
     elsIf k.nbs in ('2082', '2083') then NBS6:='6029';
     end if;

     select decode(k.KV,980, c.sd_n, c.sd_i) into OB22_
     from CCK_OB22 c, SPECPARAM_INT s
     where s.acc=k.ACC and c.nbs=k.NBS and s.OB22=c.ob22;

     begin
        select a.acc, a.nls into ACRB_,g67_ from accounts a, SPECPARAM_INT s
        where a.branch =BRANCH_
          and a.KV=980
          and a.nbs=NBS6 and a.acc=s.ACC and s.ob22=OB22_
          and a.dazs is null and rownum=1;
     exception when no_data_found then
        begin
          select a.acc, a.nls into ACRB_,g67_ from accounts a, SPECPARAM_INT s
          where a.branch = substr(BRANCH_,1,length(BRANCH_)-7)
            and a.KV=980
            and a.nbs=NBS6 and a.acc=s.ACC and s.ob22=OB22_
            and a.dazs is null
            and rownum=1;
        exception when no_data_found then  NULL;
        end;
     end;

  exception when no_data_found then  null;
  end;
  -------------------
--  logger.info('CCK -3 '||ACRB_);

  ACRA_ := null;
  for p in (select a.acc, a.nbs, a.nls , a.ostc
            from "S6_Credit_NLS" s6, accounts a
            where  a.dazs is null  and a.acc <> k.ACC
             and substr(a.nls,1,4)||substr(a.nls,6,9)=s6.nls
             and a.kf=KF_ and s6."IdContract"=k.CC_ID
             order by a.nbs
            )
  loop
    If p.nbs like '2__8' then
       ACRA_:= p.acc;
       update accounts set tip='SN ' where acc=p.ACC;
       insert into nd_acc (nd,acc) values (ND_,p.ACC);
       delete from int_ratn where acc=k.ACC and id=0;
       delete from int_accn where acc=k.ACC and id=0;
       insert into int_accn(metr,basey,freq,acc,id,acra,acrb,tt, acr_dat )
             values (0,0,1,k.ACC,0,ACRA_,ACRB_, '%%1', ACR_DAT_ );
       insert into int_ratn(acc,id,bdat,ir) values (k.ACC,0,DAT1_,IR_SS);
    ElsIf p.nbs like '2__7' then
       update accounts set tip='SP ', accc=ACC8_ where acc=p.ACC;
       insert into nd_acc (nd,acc) values (ND_,p.ACC);
       delete from int_ratn where acc=p.ACC and id=0;
       delete from int_accn where acc=p.ACC and id=0;
       insert into int_accn(metr,basey,freq,acc,id,acra,acrb,tt, ACR_DAT)
          values (0, 0, 1, p.acc,0,ACRA_, ACRB_,'%%1', ACR_DAT_);
       insert into int_ratn(acc,id,bdat,ir) values
                                   (p.acc,0,DAT1_,nvl(IR_SP,IR_SS));
    ElsIf p.nbs like '2290' then
       update accounts set tip='SL ', accc=ACC8_ where acc=p.ACC;
       insert into nd_acc (nd,acc) values (ND_,p.ACC);
    ElsIf p.nbs like '2__9' then
       update accounts set tip='SPN' where acc=p.ACC;
       begin
       insert into nd_acc (nd,acc) values (ND_,p.ACC);
       exception when dup_val_on_index then null; end;
    ElsIf p.nbs like '2480' then
       update accounts set tip='SLN' where acc=p.ACC;
       insert into nd_acc (nd,acc) values (ND_,p.ACC);
    ElsIf p.nbs like '9603' then
       update accounts set tip='S9N' where acc=p.ACC;
       insert into nd_acc (nd,acc) values (ND_,p.ACC);
    ElsIf p.nbs in('3600','9601') then
       insert into nd_acc (nd,acc) values (ND_,p.ACC);
    ElsIf p.nbs like '9129' then
       update accounts set tip='CR9' where acc=p.ACC;
       insert into nd_acc (nd,acc) values (ND_,p.ACC);
    ElsIf p.nbs like '2__5' then
       update accounts set tip='SPI' where acc=p.ACC;
       insert into nd_acc (nd,acc) values (ND_,p.ACC);
    ElsIf p.nbs like '2__6' then
       update accounts set tip='SDI' where acc=p.ACC;
       insert into nd_acc (nd,acc) values (ND_,p.ACC);
    ElsIf p.nbs in ('9031','9500','9501','9502','9520','9521', '9523') then
       update accounts set tip='ZAL' where acc=p.ACC;
       begin
         insert into PAWN_ACC (ACC,PAWN,MPAWN) values (p.acc,PAWN_,1);
       exception when DUP_VAL_ON_INDEX then null;
       end;

       insert into cc_accp  (ACC,ACCS)
       select p.acc, a.acc from accounts a, nd_acc n
       where n.nd=ND_ and n.acc=a.acc and a.tip in ('SS ','SP ','SL ')
             and not exists (select 1 from cc_accp where acc=p.acc and accs=a.acc);
    end if;

--  logger.info('CCK -4 '||p.nls);

    ALL_ZADOL_:=   ALL_ZADOL_ + Abs(p.ostc);
  end loop;
------------------
  CCK.cc_START(ND_);         -- остатки на сч 8999
  CCK.CC_AUTOR (ND_,'','' ); -- авторизация

  update "S6_Credit_NLS" set BIC = -ND_ where "IdContract" = k.CC_ID;
------------------
  If ACRB_ is NOT null then
     update  accounts set tip='SD ' where acc=ACRB_;
     insert into nd_acc (nd,acc) values (ND_,ACRB_);

/*
     if k.kv=980 then update proc_dr set g67= g67_, g67n=g67_ where nbs=k.NBS and sour=4;
        if SQL%rowcount = 0 then
           insert into proc_dr (NBS, G67, SOUR, NBSN, G67N,rezid,io,branch)
           values (k.NBS, g67_, 4, substr(k.NBS,1,3)||'8', g67_,1,0,branch_);
        end if;
     else
        update proc_dr set v67= g67_, v67n=g67_ where nbs=k.NBS and sour=4;
        if SQL%rowcount = 0 then
           insert into proc_dr (NBS, v67, SOUR, NBSN, v67N,rezid,io,branch)
           values (k.NBS, g67_, 4, substr(k.NBS,1,3)||'8', g67_,1,0,branch_);
        end if;
     end if;
*/
  end if;
-------------------
--  logger.info('CCK -5 ok');

  <<nextRec>> null;
   commit;
END LOOP;

end S6_CCK;
 
/
show err;

PROMPT *** Create  grants  S6_CCK ***
grant EXECUTE                                                                on S6_CCK          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/S6_CCK.sql =========*** End *** ==
PROMPT ===================================================================================== 
