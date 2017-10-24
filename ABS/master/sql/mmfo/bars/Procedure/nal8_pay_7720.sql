

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NAL8_PAY_7720.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NAL8_PAY_7720 ***

  CREATE OR REPLACE PROCEDURE BARS.NAL8_PAY_7720 (p_dat date)
/*
  qwa версия 29-03-2013
  процедура корретировки показателей по расчету резерва по счетам
    8000/0014/7720/45
    8010/0057/7720/44
  (запускать  предполагается в апреле,
  проводки пойдут последней банковской датой марта 2013 года)

*/
is
  Dat_tek DATE;            dat_sv  DATE;
  nlsks_6   varchar2(15);  nlsks_7   varchar2(15);
  ref_ int;                dk_ int;               dat_ date;    dat1_ date;
  S_ number;               nazn_ varchar2(160);
  nls8_   varchar2(15);    nls8a_  varchar2(15);  nls8p_  varchar2(15);
  nms8_   varchar2(38);    nms8a_  varchar2(38);  nms8p_  varchar2(38);
  acc8_   int         ;    acc8a_  int         ;  acc8p_  int         ;
  mfo_   varchar2(12);     user_   int;  pap_ int;  stat_ number;
  NLS_8020_01 varchar2(15);
  NLS_8020_02 varchar2(15);
  l_ref integer;
  l_pap number:=3;
  l_rnk number;
  l_tmp    integer:=null;
  l_acc    accounts.acc%type:=null;
  l_branch accounts.branch%type:=substr(SYS_CONTEXT('bars_context','user_branch_mask'),1,8);
  l_nls varchar2(15);
  l_nms varchar2(38);


MODCODE   constant varchar2(3) := 'NAL';

Begin
-- делаем день доступным для работы
    dat_sv:=to_date('29-03-2013','dd-mm-yyyy');
    --dat_sv:=gl.bd;
    update fdat set stat=null where fdat=dat_sv;
    Dat_tek:=GL.bdate; -- СОХРАНЕНИЕ ТЕК ДАТЫ
-- счет валовых для активных и пасс. остатков
 select val into nls_8020_01 from params where par='NU_KS7'; -- для пассивов(активный)
 select val into nls_8020_02 from params where par='NU_KS6'; -- для активов (пассивный)

bars_audit.info('nal1 '||nls_8020_01||' '||nls_8020_02);

  begin
      select f_ourmfo into mfo_ from dual;
      EXCEPTION WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(MODCODE, 'NAL_OURMFO');
  end;

  user_:= USER_ID;
  dat_ := dat_sv ;
  GL.bdate:=dat_;

-- сначала все 8000 (активы)
   nls8a_  := nls_8020_02;  -- контрсчет пассивный
bars_audit.info('nls_8020_02 '||nls_8020_02);
   begin
     select acc, substr(nms,1,38) into acc8a_, nms8a_
     from accounts where kv=980 and nls=nls8a_ and (dazs is null or dazs>gl.bd);
     EXCEPTION WHEN NO_DATA_FOUND THEN
     bars_error.raise_nerror(MODCODE, 'NAL_NU_KS6');
   end ;

-- 8000 ост в норме активный (<0)

  select k.acc,k.nls,sum(s)
  into l_acc,l_nls, s_
  from
  (select   acc,nls, dk, sum(decode(dk,0,-s,1,s)) s
     from opl l
    where   ref in
     (select ref
        from opldok p
       where   exists
          (select 1  from sal s,
          (select * from accounts where nbs='7720' and ob22 ='45') a
     where p.acc=s.acc and p.fdat=s.fdat
       and  s.fdat>=to_date('01-01-2013','dd-mm-yyyy')
       and  s.acc=a.acc
       and  s.nbs = '7720'
       and (s.dos<>0 or s.kos<>0)))
       and exists (select 1 from opldok where ref=l.ref and tt='PO3')
       and tt='PO3'
       and substr(nls,1,4)='8000'
       --and dk=0   -- взяли дебетовые обороты по 8000
   group by acc,nls,dk) k
   group by acc,nls;

   l_ref:=0;

   begin
   select nvl(max(l.ref),0)
    into l_ref
    from opldok l
   where l.fdat=dat_
     and  l.tt='PO1'
     and  l.s=abs(s_)
     and  l.acc=l_acc
     and  l.sos=5
     and  exists
         (select 1
           from  oper
           where ref=l.ref
            and  nazn='Списання сум зб_льшення-зменшення резерву 1кв 2013р.:8000-p080=0014, r020_fa=7720, ob22=45'
            and sos=5);
   exception when no_data_found then l_ref:=0;
   end;

  bars_audit.info('p_7720_0'||l_ref );

   if l_ref=0 then
   begin
       savepoint do_nal8_pay_1;
       gl.ref (ref_);

       nazn_:= 'Списання сум зб_льшення-зменшення резерву 1кв 2013р.:8000-p080=0014, r020_fa=7720, ob22=45';
       nms8_:=nms8a_; nls8_:=nls8a_; acc8_:=acc8a_;

       select  substr(nms,1,38)
         into  l_nms
         from  accounts
        where  acc=l_acc;

       if s_<0 then dk_:=0; else dk_:=1; end if;

bars_audit.info('p_7720_1'||s_||dk_||l_acc||l_nls );

       INSERT INTO oper
             (ref, tt, vob, nd, dk, pdat, vdat, datd, userid,
              nam_b, nlsb, mfob,nam_a,nlsa, mfoa, kv, s, kv2, s2, nazn )
       VALUES
             (ref_ , 'PO1', 6, ref_, 1-dk_, dat_, dat_, dat_, user_,
             l_NMS, l_NLS,  mfo_, nms8_, nls8_, mfo_, 980, abs(S_),980,abs(S_), nazn_ );

--select s2 into l_s2 from oper where ref=ref_;
--bars_audit.info( 'nal8_pay='||l_s2 );

       gl.pay2( NULL,ref_,dat_,'PO1',980, 1-dk_,   l_ACC,  abs(S_), abs(S_),1, nazn_); -- счет 8000   по КТ
       gl.pay2( NULL,ref_,dat_,'PO1',980, dk_  ,   ACC8_,  abs(S_), abs(S_),0, nazn_); -- контрсчет по ДТ
       gl.pay2( 2,   ref_,dat_);
bars_audit.info('p_7720_2'||ref_ );
   exception
       when others then rollback to do_nal8_pay_1;
   end;
   end if;
   commit;
-- потом все пассивы 8010
   nls8p_  := nls_8020_01;  -- контрсчет
bars_audit.info('nls_8020_01 '||nls_8020_01);
   begin
     select acc, substr(nms,1,38) into acc8p_, nms8p_
     from accounts where kv=980 and nls=nls8p_ and dazs is null;
     EXCEPTION WHEN NO_DATA_FOUND THEN
     bars_error.raise_nerror(MODCODE, 'NAL_NU_KS7');
   end ;

-- 8010 ост в норме пассивный (>0)

  select k.acc,k.nls,sum(s)
  into l_acc,l_nls, s_
  from
  (select   acc,nls, dk, sum(decode(dk,0,-s,1,s)) s
     from opl l
    where   ref in
     (select ref
        from opldok p
       where   exists
          (select 1  from sal s,
          (select * from accounts where nbs='7720' and ob22 ='44') a
     where p.acc=s.acc and p.fdat=s.fdat
       and  s.fdat>=to_date('01-01-2013','dd-mm-yyyy')
       and  s.acc=a.acc
       and  s.nbs = '7720'
       and (s.dos<>0 or s.kos<>0)))
       and exists (select 1 from opldok where ref=l.ref and tt='PO3')
       and tt='PO3'
       and substr(nls,1,4)='8010'
       --and dk=1  -- обороты по 8010
   group by acc,nls,dk) k
   group by acc,nls;

   begin
   l_ref:=0;
   select nvl(max(l.ref),0)
    into l_ref
    from opldok l
   where l.fdat=dat_
     and  l.tt='PO1'
     and  l.s=abs(s_)
     and  l.acc=l_acc
     and  l.sos=5
     and  exists
         (select 1
           from  oper
           where ref=l.ref
            and  nazn='Списання сум зб_льшення-зменшення резерву 1кв 2013р.:8010-p080=0057,r020_fa=7720,ob22=44'
            and sos=5);
   exception when no_data_found then l_ref:=0;
   end;
   if l_ref=0 then
   begin
       savepoint do_nal8_pay_2;
       gl.ref (ref_);
         nazn_:= 'Списання сум зб_льшення-зменшення резерву 1кв 2013р.:8010-p080=0057,r020_fa=7720,ob22=44';
       nms8_:=nms8p_; nls8_:=nls8p_; acc8_:=acc8p_;

       select  substr(nms,1,38)
         into  l_nms
         from  accounts
        where  acc=l_acc;

       if s_>0 then dk_:=1; else dk_:=0; end if;

       INSERT INTO oper
             (ref, tt, vob, nd, dk, pdat, vdat, datd, userid,
              nam_a, nlsa, mfoa,  nam_b, nlsb, mfob,  kv, s,  kv2, s2, nazn )
       VALUES
             (ref_ , 'PO1', 6, ref_, dk_, dat_, dat_, dat_, user_,
             l_NMS, l_NLS,  mfo_, nms8_, nls8_, mfo_, 980, abs(S_),  980, abs(S_),nazn_ );

--select s2 into l_s2 from oper where ref=ref_;
--bars_audit.info( 'nal8_pay='||l_s2 );

       gl.pay2( NULL,ref_,dat_,'PO1',980, 1-dk_,   l_ACC,  abs(S_), abs(S_),1, nazn_); -- счет 8010   по ДТ
       gl.pay2( NULL,ref_,dat_,'PO1',980, dk_  ,   ACC8_,  abs(S_), abs(S_),0, nazn_); -- контрсчет по КТ
       gl.pay2( 2,   ref_,dat_);

   exception
        when others then rollback to do_nal8_pay_2;
   end;
   end if;

commit;
gl.bDATE:= dat_tek;

END nal8_pay_7720;
/
show err;

PROMPT *** Create  grants  NAL8_PAY_7720 ***
grant EXECUTE                                                                on NAL8_PAY_7720   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NAL8_PAY_7720   to NALOG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NAL8_PAY_7720.sql =========*** End
PROMPT ===================================================================================== 
