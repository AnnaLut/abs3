

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_OVR8Z.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_OVR8Z ***

  CREATE OR REPLACE PROCEDURE BARS.P_OVR8Z ( NMODE_ INT, ACC_2000 INT )
 is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура выдачи-погашения овердрафта
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1998.  All Rights Reserved.
% VERSION     : 25.11.2003 17:14
% COMMENT     : доработана вставка документов для РЦК
%               добавлена обработка валютных овердрафтов
%               при погашениях за счет лимита отражаем это на 8000
%               добавлена генерация событий
% PARAMETERS  :
% 1. аргументы NMODE_ - параметр вызова, ACC_2000 - счет
%    если ACC_2000 = 0 в процедуре используются все счета
%    по портфелю овердрафта (acc_over)
% 2.|пар.вызова| выполняемые действия                        |
% 11.OVR-F1: Стягнення % по просрочцi   (D-2600,K-2069)
%  4.OVR-F2: Стягнення суми просрочки   (D-2600,K-2067)
%  1.OVR-F3: Стягнення % в останнiй день (D-2600,K-2607)
% 61.OVR-F4: Комiсiя за одноденний оверд.(D-2607 - K-6*)
% 91.OVR-F5: Невикористаний овердрафт (DK-9129)
% --.OVR-FS: Протокол автопроводок
%  2.OVR-S1: Перенос на просрочку (D-2067,K-2600,D-2069,K2607)
% -- OVR-S2: Нар.% за використаний та не використ. ОВР
% --.OVR-FS: Протокол автопроводок
% -----------   3  Авто-гашение нач. % по овердрафту
% 31. Погашение комиссии одного дня
% 8. закрытие догогвора
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

  id_       int;
  S_        number;
  REF_      int;
  NAZ_      varchar2(160);
  acc_      int;
  ret1_     int;
  nls_      varchar2(15);
  nms_      varchar2(38);
  acc67_    int;
  NBS_      char(4);
  MFO5_     VARCHAR2(12);
  nbs9_     char(4);
  acc9_     int;
  nls9_     varchar2(15);
  nms9_     varchar2(38);
  ir_       number;
  br_       number;
  op_       varchar2(15);
  s8000_    number;
  dk_       int;
  nazn1_    varchar2(70);
  ACC8_     int;
  acc_2008_ int;
  nls_2008_ varchar2(15);
  nms_2008_ varchar2(38);
  ost_2008_ number;
  acc_2067_ int;
  nls_2067_ varchar2(15);
  nms_2067_ varchar2(38);
  ost_2067_ number;
  acc_2069_ int;
  nls_2069_ varchar2(15);
  nms_2069_ varchar2(38);
  ost_2069_ number;
  tt9_      CONSTANT CHAR(3) := 'OV-';
  B9129_    char(4);
  dtxt_     varchar2(50);
  txt_      varchar2(35);
  ntemp_    number;
  flags_    varchar2(50);   -- флаг из params
  flagrlim_ number;         -- фл.восстановления лим.овердр.после пог.проср.
  tlim_     number;
  ts_       number;
  ts2_      number;
  DAT2_     date;
  OKPO_     varchar2(14);
  tt_       char(3);
  pr_2600_  number;
  pr_komis_ number;
  pr_9129_  number;
  pr_2069_  number;
  acc_8000_ number;
  nls_8000_ varchar2(15);
  acc_9129_ number;
  acc_2000_ number;
  openday_  char(1);
  ndoc_     varchar2(30);
  datd_     date;
---------------------------------------------------------------------------
  ern  CONSTANT POSITIVE := 208;
  err  EXCEPTION;
  erm  VARCHAR2(80);

BEGIN

 select id  into id_   from  staff  where LTRIM(RTRIM(UPPER(logname)))=USER;
 select VAL into MFO5_ from  PARAMS where PAR='MFO' ;
 select VAL into OKPO_ from  PARAMS where PAR='OKPO';

 --delete from tmp_ovr where dat <= gl.bdate - 3 ;
 commit;

 gl.bdate:=bankdate;

 --  опр. флаги из params
 begin
  select UPPER(val) into flags_ from params
    where UPPER(par) = 'OVRFLAGS';
  if INSTR(flags_,'RESTLIM') > 0 then flagrlim_:=1;
  else flagrlim_:=0;
  end if;
 exception when others then
  flagrlim_:=0;
 end;

 begin
  select val into openday_ from params
    where UPPER(par) = 'RRPDAY';
 exception when others then
  openday_:='0';
 end;

-- если банковский день открыт
if openday_ = '1' then
 if NMODE_ =11 then
 -- 11.OVR-F1: Стягнення % по просрочцi    (D-2600,K-2069)

  naz_:='Авто-пог. нар.% на суму просроч. овердрафта' ;
  for k in (select A.NLS,
                   A.KV,
                   a.acc,
                   substr(A.NMS,1,38)        NMS,
                   least(A.OST,-p.ost)       S,
                   least(A.ost+A.lim,-p.ost) S2,
                   a.ost                     S3,
                   p.nls                     NLSP,
                   substr(p.nms,1,38)        NMSP,
                   c.okpo                    OKPO,
                   o.ndoc                    NDOC,
                   o.datd                    DATD,
                   nvl(uselim,0)             USELIM
            from (select a.ACC,a.NLS,a.KV,a.NMS,a.LIM, s.ostf-s.dos+s.kos OST
                  from accounts a, saldoa s
                  where a.nbs='2600' and a.acc=s.acc and
                        s.ostf-s.dos+s.kos > 0    and (a.acc,s.fdat)=
                       (select c.acc,max(c.fdat)
                        from saldoa c
                        where a.acc=c.acc and c.fdat<=gl.BDATE
                        group by c.acc)
                 )        A ,  sal      P ,  int_accn I ,
                 acc_over o ,  cust_acc CA,  customer C
            where P.nbs  = '2069'
              and A.acc  = o.acc
              and o.acco = i.acc
              and i.acra = P.acc
              and ca.acc = a.acc
              and ca.rnk = c.rnk
              and P.ost  < 0
              and P.fdat = gl.bdate
              and mod(nvl(o.flag,0),2)=0
              and (acc_2000 =0 or acc_2000=i.acc)
           )
  loop
    savepoint DO_PROVODKI_11;
    begin

      begin

        select a.nls
        into nls_8000_
        from accounts a
        where a.acc = ( select ao.acc_8000
                         from acc_over ao
                         where ao.acc = k.acc
                           and nvl(ao.sos,0) <> 1 );

      exception when no_data_found then

       nls_8000_ := null;

      end;

      select datd,ndoc
      into datd_,ndoc_
      from acc_over
      where acc = k.acc
        and nvl(sos,0) <> 1 ;

      GL.REF (REF_);

	    dtxt_:='(угода № '||rtrim(ndoc_)||' від '||to_char(datd_,'dd.mm.yyyy')||')';

       if k.uselim = 1 then
         ts_:=k.s2;
         -- опр необх оборот по 8000 на сумму исп лимита
         if k.s3 < ts_ then
           ts2_ := ts_;
           if k.s3 > 0 then ts2_ := ts2_ - k.s3; end if;
         end if;
       else
         ts_:=k.s;
       end if;

      gl.in_doc3
      ( ref_ ,  'OVR',  6,      ref_,   SYSDATE, GL.BDATE,  1,
      k.kv ,  ts_,    k.kv,   ts_,    null,    GL.BDATE,  GL.BDATE,
      k.NMS,  k.NLS,  MFO5_,  k.NMSP, k.NLSP,  MFO5_,     naz_||dtxt_ ,
      null,   k.okpo, k.okpo, null,   null,    null  ,    null,  id_   );

      GL.PAYV(1,REF_,GL.BDATE, 'OVR',1,K.KV,K.NLS,ts_,K.KV,K.NLSP,ts_);

      if nvl(ts2_,0) <> 0 and nls_8000_ is not null then
       GL.PAYV(1, REF_, GL.BDATE, 'OVR', 1, K.KV, nls_8000_, ts2_, K.KV, nls_8000_, ts2_ );
      end if;

  exception when others then rollback to DO_PROVODKI_11;
      begin
        insert into TMP_OVR (DAT, ID, DK, NLSA, NLSB, S, txt ) values
                            (GL.BDATE, 11, 1, K.NLS, K.NLSP, K.S,'Стягнення % по просрочцi');
        goto KIN_11;
      end;
    end;
    <<kin_11>> NULL;
   end loop;
   return ;

 elsif NMODE_ =4 then
 -- 4.OVR-F2: Погашення просрочки         (D-2600,K-2067)

  naz_:='Авто-пог. суми боргу просроч. овердрафта ' ;
  for k in
   (select a.acc ACC2600,a.NLS, substr(a.nms,1,38) NMS, least(a.ost,-p.ost) S,
           p.nls NLSP, substr(p.nms,1,38) NMSP,
           a.KV, c.OKPO, o.NDOC, o.DATD
    from sal A, sal P, acc_over o, cust_acc ca, customer c
     where p.nbs = '2067'
       and a.ost > 0
       and a.fdat = gl.bdate
       and p.ost < 0
       and p.fdat = gl.bdate
	     and a.acc=o.acc
       and o.acco=p.acc
	     and mod(nvl(o.flag,0),2)=0
       and (acc_2000 =0 or acc_2000=p.acc)
	     and ca.acc=a.acc
       and ca.rnk=c.rnk
       and a.nbs='2600'   )
  loop
    savepoint DO_PROVODKI_4;
    begin

      GL.REF (REF_);

      select datd,ndoc
      into datd_,ndoc_
      from acc_over
      where acc = k.ACC2600
        and nvl(sos,0) <> 1 ;

      dtxt_:='(угода № '||rtrim(ndoc_)||' від '||to_char(datd_,'dd.mm.yyyy')||')';

      gl.in_doc3
     ( ref_ ,  'OVR',  6,      ref_,   SYSDATE, GL.BDATE,  1,
       k.kv ,  K.S,    k.kv,   K.S,    null,    GL.BDATE,  GL.BDATE,
       k.NMS,  k.NLS,  MFO5_,  k.NMSP, k.NLSP,  MFO5_,     naz_||dtxt_ ,
       null,   k.okpo, k.okpo, null,   null,    null  ,    null,  id_   );

      GL.PAYV(1,REF_,GL.BDATE, 'OVR',1,K.KV,K.NLS,K.S,K.KV,K.NLSP,K.S);

      --- Восстановление лимита для Петрокоммерца
      if flagrlim_=1 then
	    select nvl(lim,0) into tlim_ from accounts where acc =  k.acc2600  ;
        update accounts set lim =tlim_+ABS(k.s) where acc=  k.acc2600  ;
      end if;

    exception when others then rollback to DO_PROVODKI_4;
      begin
        insert into TMP_OVR (DAT, ID, DK, NLSA, NLSB, S, txt) values
                            (GL.BDATE, 4, 1, K.NLS, K.NLSP, K.S,'Погашення просрочки');
        goto KIN_4;
      end;
    end;
    <<kin_4>> null;
   end loop;
   return;

 elsif NMODE_ =61 then
 --OVR-F6: Комiсiя за овердрафт ОДНОГО дня

 for k in ( select S8.acc ACC8,
                  S6.acc ACC6,
                  least(S8.dos, S6.kos) S,
                  c.okpo,
				          o.ndoc,
				          o.datd,
				          c.nmk,
                  a.kv
             from saldoa  s8, saldoa  s6,
                cust_acc u, customer c,
                acc_over o, accounts A
             where O.ACC   = O.ACCO
               and (acc_2000 =0 or acc_2000=o.acc)
               and S8.ACC  = O.ACC_8000
               and S8.fdat = gl.bdate
               and S8.dos  > 0
               and S8.TRCN > 0
               and S6.ACC  = O.ACC
               and S6.fdat = gl.bdate
               and S6.KOS  > 0
               and A.ACC   = O.ACC
               and A.nbs   = '2600'
               and u.acc   = A.acc
               and u.rnk   = c.rnk     )
 loop
    savepoint DO_PROVODKI_61;
    begin
      -- счета
      begin

        select a.nls, substr(a.nms,1,38), b.nls, substr(b.nms,1,38)
        into nls_2067_ , nms_2067_ ,  nls_,  nms_
        from int_accn i, accounts a, accounts b
        where i.acc  = k.acc8
          and i.id   = 0
          and i.acra = a.acc
          and i.acrb = b.acc;

      exception when NO_DATA_FOUND then
        begin

          select a.nls, substr(a.nms,1,38), b.nls, substr(b.nms,1,38)
          into nls_2067_ , nms_2067_ ,  nls_,  nms_
          from int_accn i, accounts a, accounts b
          where i.acc  = k.acc6
            and i.id   = 0
            and i.acra = a.acc
            and i.acrb = b.acc;

        exception when NO_DATA_FOUND then nls_2067_ :=null;
        end;
      end;

      -- % ставка
      begin

        select i.ir,n.tt into ir_,tt_
        from int_ratn i, int_accn n
        where i.acc = k.acc8
          and i.id  = 0
          and i.acc = n.acc
          and i.id  = n.id
          and bdat=( select max(bdat)
                     from int_ratn i
                     where acc  = k.acc8
                       and id   = 0
                       and bdat <= gl.bdate );

      exception when NO_DATA_FOUND then
        begin

          select ir,n.tt into ir_,tt_
          from int_ratn i, int_accn n
          where i.acc = k.acc6
            and i.id  = 0
            and i.acc = n.acc
            and i.id  = n.id
            and bdat=( select max(bdat)
                       from int_ratn
                       where acc=k.ACC6
                         and id=0
                         and bdat<=gl.bdate );

        exception when NO_DATA_FOUND then Ir_:=0;
        end;
      end ;

      -- начислить проценты
      S_:= round( k.S * IR_/36500,0);
      if S_>0 and Ir_>0 and NLS_2067_ is not null then
         GL.REF (REF_);
         dtxt_:=' за '||to_char(GL.BDATE,'dd.mm.yyyy')||' пр.ст. '||to_char(IR_)||' угода № '||rtrim(k.ndoc);
         NAZ_:=substr('Комic. за одноден. овер. '||dtxt_||' '||k.nmk,1,160);

         gl.in_doc3
        ( ref_ ,  'OVR',  6,      ref_,   SYSDATE, GL.BDATE,  1,
          k.kv ,   s_,     k.kv,    s_,     null,    GL.BDATE,  GL.BDATE,
          nms_2067_,  nls_2067_,  MFO5_,  nms_,    nls_,  MFO5_,     naz_ ,
          null,   k.OKPO, okpo_, null,   null,    null  ,    null,   id_   );

         gl.payv(1,REF_,gl.BDATE, tt_,1,k.kv,nls_2067_,S_,k.kv,NLS_,S_);

         update opldok set txt=substr(naz_,1,70) where ref=REF_ and stmt=gl.ASTMT;
         update SALDOA set TRCN=0 where FDAT=GL.BDATE and ACC=K.ACC8;

      end if;

    exception when others then rollback to DO_PROVODKI_61;
      begin
        insert into TMP_OVR (DAT, ID, DK, NLSA, NLSB, S, txt ) values
                            (GL.BDATE, 61, 1,  nls_2067_, NLS_, S_,'Комiсiя за овр.ОДНОГО дня');
        goto KIN_61;
      end ;
    end;
    <<kin_61>> NULL;
 end loop;
 return ;
 ----------------------------
 elsif NMODE_ =1 then
 -- 1.OVR-F4: Стягнення % в останнiй день (D-2600,K-2607) с реального остатка, без учета лимита

 for k in (select a.NLS,
                  a.KV,
                  least(a.ostc,-p.ostc) S,
                  least(a.ostc+a.lim,-p.ostc) S2,
                  a.ostc S3,
                  substr(a.nms,1,38) NMS,
                  a.ACC,
                  p.nls NLSP,
                  substr(p.nms,1,38) NMSP,
                  c.OKPO,
                  o.NDOC,
                  o.DATD,
                  nvl(o.sos,0) SOS,
                  nvl(o.uselim,0) USELIM,
                  a8.nls NLS8000
	           from  acc_over o, accounts A, accounts P,
                   int_accn i, customer c, cust_acc ca, accounts a8
	           where (acc_2000 =0 or acc_2000=i.acc)
	             and o.acc=i.acc
               and i.acra=p.acc
               and o.acc=a.acc
               and o.acc_8000=a8.acc
	             and mod(i.id,2)=0
               and mod(nvl(o.flag,0),2)=0
	             and ca.rnk=c.rnk
               and ca.acc = p.acc
               and a.nbs = '2600'
               and p.ostc<0
               and a.mdate<=gl.bdate  )
 loop
    savepoint  DO_PROVODKI_1;
    begin
       GL.REF (REF_);
       if k.sos = 1 then
          naz_:='Погашення нарах. % на суму просроченого овердрафта ';
       else
          naz_:='Погашення нарах. % на суму овердрафта по датi закiнчення ';
       end if;
       dtxt_:='угода '||rtrim(k.ndoc)||' від '||to_char(k.datd,'dd.mm.yyyy');

       if k.uselim = 1 then
         ts_:=k.s2;
         -- опр необх оборот по 8000 на сумму исп лимита
         if k.s3 < ts_ then
           ts2_ := ts_;
           if k.s3 > 0 then ts2_ := ts2_ - k.s3; end if;
         end if;
       else
         ts_:=k.s;
       end if;

	   if ts_ > 0 then

         gl.in_doc3
        ( ref_ ,  'OVR',  6,      ref_,   SYSDATE, GL.BDATE,  1,
          k.kv ,  ts_,    k.kv,   ts_,    null,    GL.BDATE,  GL.BDATE,
          k.NMS,  k.NLS,  MFO5_,  k.NMSP, k.NLSP,  MFO5_,     naz_||dtxt_ ,
          null,   k.okpo, k.okpo, null,   null,    null  ,    null,
          id_   );

         GL.PAYV(1,REF_,GL.BDATE, 'OVR',1,K.KV,K.NLS,ts_,K.KV,K.NLSP,ts_);

         if nvl(ts2_,0) <> 0 then
           GL.PAYV(1, REF_, GL.BDATE, 'OVR', 1, K.KV, K.NLS8000, ts2_, K.KV, K.NLS8000, ts2_ );
         end if;

	     --- обнулить лимит овердрафта
         if flagrlim_ = 0 then
            update accounts set lim=0 where acc = k.acc;
         end if;
		end if;

    exception when others then rollback to DO_PROVODKI_1;
       begin
          insert into TMP_OVR (DAT, ID, DK, NLSA, NLSB, S, txt ) values
		                      (GL.BDATE, 1, 1, k.NLS, k.NLSP, k.S,'Стягнення % в останнiй день' );
          goto kin_1;
       end;
    end;
 <<kin_1>> NULL;
 end loop;
 return;

 elsif NMODE_ =91 then
 -- 91.OVR-F5: Невикористаний овердрафт    (DK-9129)

   for K in (select cu.RNK, a.ISP,a.GRP, SUBSTR(a.nms,1,38) NMS, a.NLS,
                    -(least(a.ostc,0)+a.lim) S, a.KV, a.ACC, o.ACC_9129
             from  accounts a, cust_acc cu, acc_over o
             where a.acc = cu.acc
               and nvl(o.flag,0)< 2
               and a.acc        = o.acc
               and nvl(o.sos,0) <> 1
               and o.acc = o.acco
               and a.nbs = '2600'    )
   loop
      savepoint DO_PROVODKI_91;

   begin
     --контрсчет для проводки берем из карточки операции
     select t.name,SUBSTR(T.NLSM,1,4), t.nlsk, b.acc, substr(b.nms,1,38)
     into     naz_ ,B9129_, nls9_,  acc9_,  nms9_
     from tts t , accounts b
     where t.tt=tt9_ and b.kv = k.kv  and  b.nls=t.nlsk;
   exception
     when NO_DATA_FOUND then erm := '8012 - No defined # '||tt9_;  raise err;
   end;

      begin
         -- k.S = должно быть
         -- S_  = есть по факту
         begin

           select ACC,NLS,SUBSTR(NMS,1,38),OSTC  into  ACC_,nls_,nms_, S_
           from  accounts
           where NBS=B9129_
             and kv=k.kv
             and acc=k.ACC_9129;

         exception when NO_DATA_FOUND then
           begin
             Nls_:=VKRZN(SUBSTR(GL.AMFO,1,5),B9129_||'0'||SUBSTR(K.NLS,6,9));
             txt_:='Открытие '|| Nls_;
             OP_REG(99,0,0,0,RET1_,K.RNK,Nls_,k.kv,K.NMS,'ODB',K.ISP,ACC_);
             update ACCOUNTS set GRP=K.GRP,SECI=7, SECO=0 where ACC=ACC_;
             S_:=0;
            end;
         end;
         txt_:='9129-Наследование обеспечения';

		 insert into cc_accp (ACCS, ACC,ND )
                       select acc_, c.acc, c.nd
                       from cc_accp c, pawn_acc p
					   where accs=k.acc
					     and c.ACC = p.acc
					     and (acc_,c.acc) not in (select accs,acc from cc_accp);


         S_ := K.S - S_ ;
         if S_<>0 then
            txt_:='Урегулирование 9129';
            if S_<0 then dk_:=0; S_:=0-S_ ; else  dk_:=1; end if;

            GL.REF (REF_);

            gl.in_doc3
           ( ref_ ,  tt9_,  6,      ref_,   SYSDATE, GL.BDATE,  1-dk_,
             k.kv ,  s_,    k.kv,   s_,    null,    GL.BDATE,  GL.BDATE,
             nms_,   nls_,  gl.amfo,  nms9_, nls9_,  gl.amfo,     naz_ ,
             null,   okpo_, okpo_, null,   null,    null  ,    null,
             id_   );

            GL.PAYV(1,REF_,GL.BDATE,tt9_,1-dk_,K.KV,NLS_,S_,K.KV,NLS9_,S_);

         end if;
      exception when others then rollback to DO_PROVODKI_91;
         begin
            insert into TMP_OVR (DAT, ID, DK, NLSA, NLSB, S, txt ) values
                                (GL.BDATE, 91 ,dk_, nls_, nls9_, S_ ,txt_ );
            goto KIN_91;
         end;
      end;
<<kin_91>>   NULL;
   end loop;
   return ;

 elsif NMODE_ =2 then
 --2.OVR-S3: Перенос на просрочку        (D-2067,K-2600,D-2069,K2607)

  -- перенос на просрочку задолженности по овердрафту
  NBS_ :='2067';  -- пока неясен другой способ
  nbs9_:='2069';  -- для нач процентов
  naz_:='Перенесення заборгованностi овердрафта на просрочену ' ;

  for k in (select a.NLS,a.KV,substr(a.NMS,1,38) NMS,a.ACC, -a.ostc OST,
                    a.GRP,a.SECO,a.SECI,a.ISP,a.MDATE,nvl(a.lim,0) LIM,
                    c.OKPO,c.RNK, o.NDOC, o.DATD
              from accounts a, acc_over o, cust_acc u, customer c
              where o.acc = a.acc  and u.acc = a.acc  and c.rnk = u.rnk
                and a.ostc<0 and a.mdate<GL.BDATE  and nvl(o.sos,0)<> 1 and a.nbs='2600'
                and (acc_2000 =0 or acc_2000=o.acc)  )
  loop
   savepoint DO_PROVODKI_2;
   begin
      dtxt_:='угода № '||rtrim(k.ndoc)||' від '||to_char(k.datd,'dd.mm.yyyy');
      NLS_2067_:=NBS_||'0'||substr(k.NLS,6,9);
      NLS_2067_:=VKRZN(substr(MFO5_,1,5),NLS_2067_);
      NMS_2067_:=substr('Просроч.заборг.'||k.NDOC||' за оверд',1,38) ;
      ret1_:=0;
      txt_:='1.Открытие '|| NLS_2067_ ;
      op_reg(99,0,0,0,ret1_,k.RNK,NLS_2067_,k.KV,NMS_2067_,'ODB',k.ISP,acc_2067_);
      txt_:='2.Обновление '|| NLS_2067_ ;
      update accounts  set grp=k.GRP, seco=k.SECO, seci=k.SECI, blkd  = 0,
                           mdate=k.MDATE, nms=NMS_2067_,dazs = null
                       where acc=acc_2067_;
      NLS_2069_:=NBS9_||'0'||substr(k.NLS,6,9);
      NLS_2069_:=VKRZN(substr(MFO5_,1,5),NLS_2069_);
      NMS_2069_:=substr('Нар % на просроч.заборг.'||k.NDOC||' за оверд',1,38) ;
      ret1_:=0;
      txt_:='3.Открытие '|| NLS_2069_;
      op_reg(99,0,0,0,ret1_,k.RNK,NLS_2069_,k.KV,NMS_2069_,'ODB',k.ISP,acc_2069_);
      txt_:='4.Обновление '|| NLS_2069_ ;
      update accounts set grp=k.GRP, seco=k.SECO, seci =k.SECI,blkd  = 0,
                          mdate=k.MDATE, nms=NMS_2069_, dazs=null
                      where acc=acc_2069_;
      begin
        select acc into ret1_ from int_accn where acc=acc_2067_ and id=0;
        txt_:='5.Обнов.%карты '|| NLS_2067_ ;
        update int_accn set acra=acc_2069_  where acc=acc_2067_ and id=0;
      exception when NO_DATA_FOUND then
        begin
          ---- счет доходов для нового БС NBS_
          select a.acc into acc67_  from accounts a, proc_dr p
           where a.kv=k.kv  and p.nbs=NBS_ and p.g67 = a.nls ;
        exception when NO_DATA_FOUND then acc67_:=null;
        end;
        txt_:='6.Создание % карты '|| NLS_2067_ ;
        ---- создать проц.карточку
        insert into int_accN (ACC,ID,METR,BASEM,BASEY,FREQ,TT,ACRA,ACRB)
        select acc_2067_,0,METR,BASEM,BASEY,FREQ,TT,acc_2069_,nvl(acc67_,ACRB)
        from int_accn where acc = k.acc and id  = 0;
      end;

      begin
        select acc into ret1_
        from int_ratn where acc=acc_2069_ and bdat=gl.bdate;
      exception when NO_DATA_FOUND then
        ------проставить/добавить историю % ставки
        txt_:='7.Внесение % став '|| NLS_2067_ ;
        begin
           select acc into acc_2067_ from int_RATN
           where acc=acc_2067_ and id=0 and BDAT= gl.bDATE;
        exception when NO_DATA_FOUND then
           insert into int_ratn (ACC,ID,BDAT,IR,BR,OP)
           select acc_2067_,0, gl.bdate,IR,BR,OP  from int_ratn n
           where n.acc=k.acc and n.id=0
             and n.bdat=( select max(bdat)
                          from int_ratn
                          where bdat < gl.bdate
                            and acc  = k.acc
                            and id   = 0  );
        end;
      end;

      begin
        select acc into s_ from acc_over where acc=k.acc and acco=acc_2067_;
      exception when NO_DATA_FOUND then
        ---поместить в портфель овердрафта
        txt_:='8.Помещение в овр'|| NLS_2067_ ;
        insert into acc_over (ACC,ACCO,TIPO,FLAG,ND,DAY,sos,sd,NDOC)
        select ao.acc,acc_2067_,ao.tipo,ao.flag,ao.nd,ao.day,1,ao.sd,ao.ndoc
        from acc_over ao
        where acco = k.acc
          and nvl(ao.sos,0)=0
          and ao.acc not in ( select ao2.acc
                               from acc_over ao2
                               where ao2.acc = k.acc
                                 and nvl(ao2.sos,0) =1 );
      end;

      --- 2607 -> 2069
      begin
        select a.acc, a.nls, substr(a.nms,1,38), -a.ostc
        into acc_2008_, nls_2008_, nms_2008_, ost_2008_
        from accounts a, int_accn i
        where i.acra=a.acc and i.acc=k.acc and a.ostc<0 and mod(i.id,2)=0 ;
        txt_:='9.Перенесення на проср суми %';

        GL.REF (REF_);

       -- p_oversob( k.acc,null,ref_,8,ost_2008_,null);

        gl.in_doc3
        ( ref_ ,  'OVR',  6,      ref_,   SYSDATE, GL.BDATE,  1,
        k.kv ,  ost_2008_,    k.kv,   ost_2008_,    null,    GL.BDATE,  GL.BDATE,
        NMS_2069_,  NLS_2069_,  MFO5_,  NMS_2008_, NLS_2008_,  MFO5_, 'Перенесення нар % на просроченi' ,
        null,   k.okpo, k.okpo, null,   null,    null  ,    null,
        id_   );

        GL.PAYV(1,REF_,GL.BDATE, 'OVR',1,K.KV,NLS_2069_,ost_2008_,K.KV,NLS_2008_,ost_2008_);

      exception when NO_DATA_FOUND then ost_2008_:=0;
      end;

      --- 2600 -> 2067
      txt_:='10.Перенесення на проср.осн.суми';

      GL.REF (REF_);

      --p_oversob( k.acc,null,ref_,6,k.ost,null);

        gl.in_doc3
        ( ref_ ,  'OVR',  6,      ref_,   SYSDATE, GL.BDATE,  1,
        k.kv ,  k.ost,    k.kv,   k.ost,    null,    GL.BDATE,  GL.BDATE,
        NMS_2067_,  NLS_2067_,  MFO5_,  k.NMS, k.NLS,  MFO5_, naz_||dtxt_ ,
        null,   k.okpo, k.okpo, null,   null,    null  ,    null,
        id_   );

       GL.PAYV(1,REF_,GL.BDATE, 'OVR',1,K.KV,NLS_2067_,k.ost,K.KV,k.NLS,k.ost);

      --- убрать под 0 неиспользованый лимит овердрафта
      if flagrlim_=0 then
        update accounts set lim =0 where acc=  k.acc  ;
      else

        --- уменьшаем лимит на просроченую сумму (Петрокоммерц)
        if k.lim > k.ost then
          update accounts set lim =k.lim-ABS(k.ost) where acc=  k.acc  ;
        else
          update accounts set lim =0 where acc=  k.acc  ;
        end if;
      end if;

      update accounts set blkd=1 where acc=  acc_2067_ ;

   exception when others then rollback to DO_PROVODKI_2;
      begin
        insert into TMP_OVR (DAT, ID, DK, NLSA, NLSB, S, txt) values
                            (GL.BDATE, 2, 1, NLS_2067_, K.NLS, K.ost, txt_ );
        goto kin_2;
      end;
   end;
   <<kin_2>> NULL;
  end loop;
  return;

 --- Погашение процентов по овердрафту
 elsif NMODE_ = 3 then
 for k in
(select A6.NLS                       NLS6 ,
        substr(A6.NMS,1,38)          NMS6 ,
        A6.ACC                       ACC6 ,
        a6.kv                        KV,
        a8.nls                       NLS8 ,
        substr(a8.nms,1,38)          NMS8 ,
        a8.acc                       ACC8 ,
        least(A6.OST,-a8.ost)        S ,
        least(A6.OST+A6.LIM,-a8.ost) S2,
        a6.ost                       S3,
        c.okpo                       OKPO ,
        o.ndoc                       NDOC,
        o.datd                       DATD,
        o.nd                         ND,
        nvl(o.uselim,0)              USELIM,
        a8000.nls                    NLS8000
  from (select a.NLS, a.kv, a.NMS, a.ACC, a.LIM, s.ostf-s.dos+s.kos OST
        from accounts a, saldoa s
        where a.nbs='2600'
          and a.acc=s.acc
          and (a.acc,s.fdat) =
             (select c.acc,max(c.fdat)
              from saldoa c
              where a.acc=c.acc and c.fdat <= gl.BDATE
              group by c.acc)
       )        a6,  sal      a8,  int_accn i,
       acc_over  o,  cust_acc ca,  customer c, accounts a8000
   where a8.fdat  =  gl.bdate
     and a6.acc   =  o.acc
	 and a8000.acc = o.acc_8000
     and o.acco   =  i.acc
     and i.acra   =  a8.acc
     and a8.ost   <  0
     and (acc_2000 =0 or acc_2000=i.acc) and mod(i.id,2) = 0
     and ca.acc   = a6.acc
     and ca.rnk   = c.rnk
 )
  loop
    savepoint DO_PROVODKI_3;
    begin

      gl.ref (ref_);

      naz_:='Погашення відсотків за користування овердрафтом  угода № '||
             rtrim(k.ndoc)||' від '||to_char(k.datd,'dd.mm.yyyy');
      --- использовать лимит
       if k.uselim = 1 then
         ts_:=k.s2;
         -- опр необх оборот по 8000 на сумму исп лимита
         if k.s3 < ts_ then
           ts2_ := ts_;
           if k.s3 > 0 then ts2_ := ts2_ - k.s3; end if;
         end if;
       else
         ts_:=k.s;
       end if;

	  if ts_ > 0 then

       gl.in_doc3
        ( ref_ ,  'OVR',  6,      ref_,   SYSDATE, GL.BDATE,  1,
        k.kv ,  ts_,    k.kv,   ts_,    null,    GL.BDATE,  GL.BDATE,
        k.NMS6,  k.NLS6,  MFO5_,  k.NMS8, k.NLS8,  MFO5_, naz_ ,
        null,   k.okpo, k.okpo, null,   null,    null  ,    null,
        id_   );


        gl.pay(null,ref_,gl.bDATE,'OVR',k.kv,0,k.ACC6,ts_,0,'Погашення % овердрафту');
        gl.pay(null,ref_,gl.bDATE,'OVR',k.kv,1,k.ACC8,ts_,0,'Погашення % овердрафту');
        gl.pay(2,ref_,gl.bDATE);

        if nvl(ts2_,0) <> 0 then
          GL.PAYV(1, REF_, GL.BDATE, 'OVR', 1, K.KV, K.NLS8000, ts2_, K.KV, K.NLS8000, ts2_ );
        end if;

	   end if;

    exception when others then rollback to DO_PROVODKI_3;
      begin
         insert into TMP_OVR (DAT, ID, DK, NLSA, NLSB, S,txt) values
                             (GL.BDATE, 3, 1, K.NLS6, K.NLS8, K.S, 'Погашення %');
         goto kin_3;
      end;
    end;
    <<kin_3>> NULL;
  end loop;
  return;

--- Погашение комиссии одного дня
elsif NMODE_ = 31 then
for k in
(select a6.NLS                       NLS6,
        substr(a6.NMS,1,38)          NMS6,
        a6.ACC                       ACC6,
        a6.KV                        KV,
        a3.nls                       NLS8,
        substr(a3.nms,1,38)          NMS8,
        a3.acc                       ACC8,
        least(A6.OST,-a3.ost)        S,
        least(A6.OST+A6.LIM,-a3.ost) S2,
        a6.ost                       S3,
        c.okpo                       OKPO,
        o.ndoc                       NDOC,
        o.datd                       DATD,
        o.nd                         ND,
        nvl(o.uselim,0)              USELIM,
    		a8.nls                  NLS8000
  from (select a.NLS, a.KV, a.NMS, a.ACC, a.LIM, s.ostf-s.dos+s.kos OST
        from accounts a, saldoa s
        where  a.nbs=2600 and a.acc=s.acc and
        (a.acc,s.fdat) = (select c.acc,max(c.fdat)
                          from saldoa c
                          where a.acc=c.acc and c.fdat <= gl.BDATE
                          group by c.acc)
        )       A6, sal a3, int_accn i, acc_over o,
       cust_acc ca, customer c, accounts a8
   where a3.fdat    =  gl.bdate
     and a6.acc     =  o.acc
     and o.acc_8000 =  i.acc
     and o.acc_8000 =  a8.acc
     and i.acra     =  a3.acc
     and (acc_2000  =0 or o.acc_8000=acc_2000)  and mod(i.id,2) = 0
     and ca.acc     = a6.acc
     and ca.rnk     = c.rnk
  )
  loop
    savepoint DO_PROVODKI_3;
    begin
      gl.ref (ref_);
      naz_:='Погашення комiсiї за овр.угода № '||
             rtrim(k.ndoc)||' від '||to_char(k.datd,'dd.mm.yyyy');

       if k.uselim = 1 then
         ts_:=k.s2;
         -- опр необх оборот по 8000 на сумму исп лимита
         if k.s3 < ts_ then
           ts2_ := ts_;
           if k.s3 > 0 then ts2_ := ts2_ - k.s3; end if;
         end if;
       else
         ts_:=k.s;
       end if;

	  if ts_ > 0 then

        gl.in_doc3
        ( ref_ ,  'OVR',  6,      ref_,   SYSDATE, GL.BDATE,  1,
        k.kv ,  ts_,   k.kv,   ts_,    null,    GL.BDATE,  GL.BDATE,
        k.NMS6,  k.NLS6,  MFO5_,  k.NMS8, k.NLS8,  MFO5_, naz_ ,
        null,   k.okpo, k.okpo, null,   null,    null  ,    null,
        id_   );

        gl.pay(null,ref_,gl.bDATE,'OVR',k.kv,0,k.ACC6,ts_,0,'Погашення комісії овердрафту');
        gl.pay(null,ref_,gl.bDATE,'OVR',k.kv,1,k.ACC8,ts_,0,'Погашення комісії овердрафту');
        gl.pay(2,ref_,gl.bDATE);

        if nvl(ts2_,0) <> 0 then
          GL.PAYV(1, REF_, GL.BDATE, 'OVR', 1, K.KV, K.NLS8000, ts2_, K.KV, K.NLS8000, ts2_ );
        end if;

	   end if;

    exception when others then rollback to DO_PROVODKI_3;
    begin
       insert into TMP_OVR (DAT, ID, DK, NLSA, NLSB, S,txt) values
                           (GL.BDATE, 3, 1, K.NLS6, K.NLS8, K.S, 'Погашення комісії');
       goto kin_31;
     end;
    end;
    <<kin_31>> NULL;
  end loop;

 --- закрытие договора
 elsif NMODE_ = 8 then

 -- p_oversob (acc_2000,null,null,2,0,null);


   --- 9129,8000
   begin
    select o.acc_9129,o.acc_8000
    into acc_9129_,acc_8000_
    from acc_over o
	where o.acc   = acc_2000 and nvl(o.sos,0) <> 1;
   exception when no_data_found then
    acc_9129_:=0;
    acc_8000_:=0;
   end;

   --- 2067,2069
   begin
    select o.acco,i.acra,o.acc_9129,o.acc_8000
    into acc_2067_,acc_2069_,acc_9129_,acc_8000_
    from acc_over o, int_accn i
    where i.acc = o.acco
      and i.id  = 0
      and o.acc = acc_2000
      and o.sos = 1 ;
   exception when no_data_found then
    acc_2067_ := null;
    acc_2069_ := null;
   end;

   begin
     select i.ir into pr_2600_
     from int_ratn i, int_accn n
     where i.acc=acc_2000
	     and i.id=0
       and i.acc=n.acc
       and n.id=i.id
       and bdat=( select max(bdat)
                  from int_ratn i
                  where acc  = acc_2000
                    and id   = 0
                    and bdat<= gl.bdate );
   exception when NO_DATA_FOUND then pr_2600_:=0 ;
   end;

   begin
     select ir into pr_komis_
     from int_ratn i, int_accn n
     where i.acc = acc_8000_
       and i.id  = 0
       and i.id  = n.id
       and i.acc = n.acc
       and bdat=( select max(bdat)
                  from int_ratn
                  where acc  = acc_8000_
                    and id   = 0
                    and bdat <=gl.bdate );

   exception when NO_DATA_FOUND then pr_komis_:=0;
   end;

   if pr_komis_ = 0 then pr_komis_ :=pr_2600_; end if;

   pr_9129_:=acrn.FPROC(acc_9129_,gl.bdate) ;
   pr_2069_:=acrn.FPROC(acc_2069_,gl.bdate) ;

   delete from acc_over where acc=acc_2000 and sos=1;

   update acc_over o
   set acc_2067  = acc_2067_,
       acc_2069  = acc_2069,
       pr_2600a  = pr_2600_,
       pr_komis  = pr_komis_,
       pr_2069   = pr_2069_,
       pr_9129   = pr_9129_
   where acc=acc_2000 ;

   insert into acc_over_archive (ACC,ACCO,TIPO,ND,DAY,FLAG,SOS,
            DATD,SD,NDOC,VIDD,DATD2,KRL,USEOSTF,
            USELIM,ACC_9129,ACC_8000,OBS,TXT,
            USERID,DELETED,PR_2600A,PR_KOMIS,
            PR_9129,PR_2069,ACC_2067,ACC_2069,DELDATE)
    select  ACC,ACCO,TIPO,ND,DAY,FLAG,SOS,
            DATD,SD,NDOC,VIDD,DATD2,KRL,USEOSTF,
            USELIM,ACC_9129,ACC_8000,OBS,TXT,
            USERID,DELETED,PR_2600A,PR_KOMIS,
            PR_9129,PR_2069,ACC_2067,ACC_2069,SYSDATE
	 from acc_over where   acc=acc_2000 ;

   delete from acc_over where acc=acc_2000 ;

 end if;
end if;


EXCEPTION
    WHEN err    THEN raise_application_error(-(20000+ern),'\'||erm,TRUE);
    WHEN OTHERS THEN raise_application_error(-(20000+ern),SQLERRM,TRUE);
END p_ovr8z;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_OVR8Z.sql =========*** End *** =
PROMPT ===================================================================================== 
