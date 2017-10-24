

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/S5_CCK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure S5_CCK ***

  CREATE OR REPLACE PROCEDURE BARS.S5_CCK 
 (BRANCH_ varchar2,  --   '/333368/000151/'
  NBS_    char    ,  -- маска Бал счета,  '2%'
  NLS_    varchar2,  -- NLS   = 1 лицевой счет, или '*' - по маске БС
  ACR_DAT_   date ,  -- Дата, по которую начислены %  ( включительно ).
  dd_         int )  --Пл. День: Null - от даты КД,  Число - дата-конст

  IS
-----------------------
 OB22_ char(2);
 NBS6  char(4);
 Dat1_    date;
 DAT4_    date;
 Dat1g_   date;
 DAT4g_   date;
 GPK_     int ;
 DAT2g_   date;
 ND_       int;
 aim_      int;
 KOM_ number :=  0; -- % комиссии
 METR_90 int :=  null ; -- методика комиссии
 DEN_    int := 25; -- день погашения
 ACC8_   int ;
 DEL2_ number;
 G67_   varchar2(15);
 CC_ID_ varchar2(40);
 ACC_SS int;
 sOS_ int;
 PAWN_ int;
 KF_ varchar2(6) := substr(BRANCH_,2,6);
 ACRB_ int; ACRA_ int; IR_SS number; IR_SP number;
 --DATE_ST_ date;
 LiMIT_ number;  ALL_ZADOL_ number;
 DS_ varchar2(8);

begin
  bc.subst_mfo( KF_ );
  for k in (select a.NBS, a.DAOS, a.acc, a.rnk,  a.isp, a.grp,
                   a.KV , a.nls , decode(substr(a.nbs,1,2),'22',11,1) VIDD,
                   -A.ostc LIMIT,
                   s.CLI_KOD,s.GROUP_C,s.DOG,
                   s.SUMMA,   s.NLS_SP,  s.NLS_SN,  s.NLS_SPN,   s.NLS_SLN,
                   s.NLS_VNEB,s.NLS_RS,  s.NLS_2400,s.NLS_2490,  s.NLS_3600,
                   s.NLS_PPRR,s.NLS_9031,s.NLS_OPRL,s.NLS_OSOM
            from (select distinct
                         s.CLI_KOD,s.GROUP_C,s.DOG,  s.i_va,
                         s.SUMMA, nvl(s.LS_ALT,'0') LS,
                         to_char(s.SC_OOSN) NLS,
                         nvl(to_char(s.SC_OPRS),'*') NLS_SP,
                         nvl(to_char(s.SC_POSN),'*') NLS_SN,
                         nvl(to_char(s.SC_PPRS),'*') NLS_SPN,
                         nvl(to_char(s.SC_2480),'*') NLS_SLN,
                         nvl(to_char(s.SC_VNEB),'*') NLS_VNEB,
                         nvl(to_char(s.RSCHET ),'*') NLS_RS  ,
                         nvl(to_char(s.SC_2400),'*') NLS_2400,
                         nvl(to_char(s.SC_2490),'*') NLS_2490,
                         nvl(to_char(s.SC_3600),'*') NLS_3600,
                         nvl(to_char(s.SC_PPRR),'*') NLS_PPRR,
                         nvl(to_char(s.SC_240P),'*') NLS_9031,
                         nvl(to_char(s.SC_OPRL),'*') NLS_OPRL,
                         nvl(to_char(s.SC_OSOM),'*') NLS_OSOM
                   from TEST_D5 s
                ) s,
                accounts a
            where a.branch=BRANCH_ and s.I_VA=a.kv
              and s.NLS = a.nls  and s.LS not like '*%'
              and a.nbs in ('2082', '2083', '2232', '2233',
                            '2062', '2063', '2202', '2203',
                            '2072', '2073', '2212', '2213')
              and a.nbs like NBS_
              and NLS_ in (a.nls,'*')
             )
  loop
    ACC_SS := k.acc; LiMIT_ :=k.LIMIT;

    begin
       --найти внеш. № КД
       select s."IdContract"  into CC_ID_
       from S6_SALDO s , "S6_Contract" co
       where co."IdContract"= s."IdContract"
         and s.i_va=k.KV and s.NLS = substr(k.NLS,1,4)||substr(k.nls,6,9) ;
       --найти вид обеспечения
       begin
          select c.PAWN into PAWN_ from "S6_Contract" S6,cc_pawn c
          where s6.v_main=c.s031 and "IdContract" = CC_ID_ and c.pawn<>34;
       exception when no_data_found then PAWN_:=33;
       end;
    exception when no_data_found then
       CC_ID_:= k.GROUP_C||'/'||k.CLI_KOD||'/'||k.DOG;
       insert into  TEST_PROT_CCK  (branch,kv,nls,rnk,cc_id,txt)
          values (BRANCH_, k.kv, k.nls, k.rnk, CC_ID_, 'S5:Не найдено № КД');
       GOTO nextRec;
    end;

    --найти цель
    begin
       select nvl(min(AIM),62)  into aim_    from cc_aim    where k.nbs in
       ( nvl(NBS,'2062'), nvl(NBS2 ,'2063'),nvl(NBSF,'2202'), nvl(NBSF2,'2203'));
    exception when no_data_found then aim_:=62;
    end;

    -- найти % ставку
    IR_SS := null;
    select min(DATE_ST), max(DATE_en) into DAT1_, DAT4_    from TEST_P5
    where GROUP_C=k.GROUP_C and CLI_KOD=k.cli_kod and DOG=k.dog;

    If DAT1_ is not null then
       If DAT1_ >= DAT4_ then
          insert into  TEST_PROT_CCK  (branch,kv,nls,rnk,cc_id,txt)
             values (BRANCH_,k.kv,k.nls,k.rnk, CC_ID_,
              'S5:Дата Нач='|| DAT1_|| ' >= Дата кон='||DAT4_);
          GOTO nextRec;
       end if;

       DEL2_:= round( months_between(DAT4_,DAT1_),0) ;

--er.info(' CCk * dat1='|| dat1_||' dat4='||dat4_ || ' '|| k.SUMMA ||' ' ||del2_);

       If DEL2_ < 1 then
          insert into  TEST_PROT_CCK  (branch,kv,nls,rnk,cc_id,txt)
             values (BRANCH_,k.kv,k.nls,k.rnk, CC_ID_,'S5: Период < 15 дней');
          GOTO nextRec;
       end if;
       DEL2_:= Round(k.SUMMA / DEL2_,0);
--logger.info(' CCk * '||del2_);
       select max(PR_OSN)/100, max(PR_PRS)/100  into IR_SS, IR_SP    from TEST_P5
       where GROUP_C=k.GROUP_C and CLI_KOD=k.cli_kod and DOG=k.dog   and DATE_en = DAT4_;
    Else
       insert into  TEST_PROT_CCK  (branch,kv,nls,rnk,cc_id,txt)
          values (BRANCH_, k.kv, k.nls, k.rnk, CC_ID_, 'S5:Не найдено % ставку');
       GOTO nextRec;
    end if;

    DAT4_:= cck.CorrectDate(gl.baseval, DAT4_, DAT4_-1);

    If LIMIT_=0 then  DEL2_:= 0;                   sos_ := 13 ;  GPK_ := 2;
    Else
       Den_:= NVL(DD_, to_number(to_char(DAT1_,'dd')));
       SOs_ := 10 ;  GPK_ := 1;
    end if;


   PUL.Set_Mas_Ini( 'DEL2_', to_char(DEL2_), 'Дельта для ГПК' );

iF DD_ IS NULL THEN
   DS_   := to_char(gl.BDATE,'MM')||to_char(DAT1_,'DD');
else
   DS_   := substr('0'||DD_,-2);
end if;

If    DS_ in ('0229','0230','0231'       ) then DS_:='0228';
elsIf DS_ in ('0431','0631','0931','1131') then DS_:=substr(DS_,1,3)||'0';
end if;
DAT1g_:=TO_DATE( to_char(gl.BDATE,'YYYY')||DS_,'YYYYMMDD');

  P_GPK( GPK_,0,LIMIT_, DAT1g_, DAT4_, IR_SS, 5, 0, METR_90,0,2);

  ND_  := null; --открытие КД
  ALL_ZADOL_:= Abs(LIMIT_);
  bars_context.subst_branch(branch_);
  CCK.CC_OPEN (ND_,k.RNK, substr(CC_ID_,1,20), k.DAOS, DAT4_, k.DAOS, k.DAOS,
                   k.KV,  LIMIT_/100, k.vidd, 4,  aim_,'', 1, 1, '',
                   k.ISP, '','', 5,IR_SS, 0, Den_, DAT1_, 5,  KOM_ );
  bc.subst_mfo( KF_ );
  INSERT INTO nd_txt(ND,TAG,TXT) values(ND_, 'FLAGS','10');
  update cc_deal set sdog=k.SUMMA/100 where nd=ND_;
  update cc_add  set accs=ACC_SS      where nd=ND_;
  if sos_=13 then
     update cc_deal set sos=13 where nd=ND_;
  end if;
  select acc into Acc8_ from accounts where kf=KF_ and nls like '8999_'||ND_;
  update accounts set tip='SS ', accc=acc8_, mdate=DAT4_ where acc=ACC_SS;
  UPDATE accounts set vid=2, grp=k.GRP, branch=BRANCH_ where acc= ACC8_;
  insert into nd_acc (nd,acc) values (ND_,ACC_SS);

  delete from cc_lim where nd=ND_;
  If DAT4_ - DAT1g_<15 then
     insert into cc_lim (ND,FDAT,LIM2,ACC,SUMG,SUMO,SUMK)
     select ND_,max(FDAT),LIMIT_,ACC8_,sum(SUMG),sum(SUMO),sum(SUMK)
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

  ACRA_ := null;
  for p in (select acc, nbs, nls, ostc  from accounts
            where dazs is null
              and kv=k.KV and rnk=k.RNK
              and acc<> ACC_SS
              and nls in (k.nls,k.NLS_SP  , k.NLS_SN  , k.NLS_SPN,
                          k.NLS_SPN , k.NLS_SLN , k.NLS_VNEB,
                          k.NLS_RS  , k.NLS_2400, k.NLS_2490,
                          k.NLS_3600, k.NLS_PPRR, k.NLS_9031,
                          k.NLS_OPRL, k.NLS_OSOM  )
             order by nbs
            )
  LOOP
    If p.nbs like '2__8' then
       ACRA_:= p.acc;
       update accounts set tip='SN ' where acc=p.ACC;
       insert into nd_acc (nd,acc) values (ND_,p.ACC);
       delete from int_ratn where acc=ACC_SS and id=0;
       delete from int_accn where acc=ACC_SS and id=0;
       insert into int_accn(metr,basey,freq,acc,id,acra,acrb,tt, ACR_DAT )
                       values (0,0,1,acc_SS,0,ACRA_,ACRB_, '%%1',ACR_DAT_);
       insert into int_ratn(acc,id,bdat,ir) values (acc_SS,0,DAT1_,IR_SS);
    ElsIf p.nbs like '2__7' then
       update accounts set tip='SP ', accc=ACC8_ where acc=p.ACC;
       insert into nd_acc (nd,acc) values (ND_,p.ACC);
       delete from int_ratn where acc=p.ACC and id=0;
       delete from int_accn where acc=p.ACC and id=0;
       insert into int_accn(metr,basey,freq,acc,id,acra,ACRB,tt, ACR_DAT)
                      values (0,0, 1, p.acc,0,ACRA_, ACRB_,'%%1',ACR_DAT_);
       insert into int_ratn(acc,id,bdat,ir) values
                                   (p.acc,0,DAT1_,nvl(IR_SP,IR_SS));
    ElsIf p.nbs like '2290' then
       update accounts set tip='SL ', accc=ACC8_ where acc=p.ACC;
       insert into nd_acc (nd,acc) values (ND_,p.ACC);

    ElsIf p.nbs like '2__9' then
       update accounts set tip='SPN' where acc=p.ACC;
       insert into nd_acc (nd,acc) values (ND_,p.ACC);

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

   ALL_ZADOL_:=   ALL_ZADOL_ + Abs(p.ostc);
  end loop;

  CCK.cc_START(ND_);         -- остатки на сч 8999
  CCK.CC_AUTOR (ND_,'','' ); -- авторизация

  update TEST_D5 set LS_ALT = '*'||to_char(ND_)
     where CLI_KOD=k.CLI_KOD and GROUP_C=k.GROUP_C and DOG=k.DOG ;
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

  <<nextRec>> null;

 commit;
END LOOP;

end S5_CCK;
/
show err;

PROMPT *** Create  grants  S5_CCK ***
grant EXECUTE                                                                on S5_CCK          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/S5_CCK.sql =========*** End *** ==
PROMPT ===================================================================================== 
