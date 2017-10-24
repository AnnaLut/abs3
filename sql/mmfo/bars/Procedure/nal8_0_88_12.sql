

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NAL8_0_88_12.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NAL8_0_88_12 ***

  CREATE OR REPLACE PROCEDURE BARS.NAL8_0_88_12 (dd_ date)
/*

 qwa  версия  0.1   от 14-06-2011
                    с 01-06-2011  88 файл отменяется и надеюсь в дальнейшем не понадобится

 qwa  версия  0.0   от 29-11-2010
 сворачиваем датой 30 ноября или ближайшей к ней <= 30-11 текущего года
 добавляем в АРМ "Податковий облык ОБ (закриття-в?дкриття року)"
*******************************************************************
 Описание
 процедура для "списання сум тимчасових р_зниць" (88 файл)
 для областных ОБ
 2010 - отработала в Ровно
 если текущий банк месяц = 12 - то сворачиваем датой 30-11-тек года
 если текущий банк месяц = 01 - то сворачиваем датой 01-01-тек года

 Должен быть открыт счет  8099 с   OB22=12.
 Свернет строго по состоянию остатка
 Активные (дебетовые) 8061,8063,8065,8067,8068.
 Пассивные (кредитовые)    8060,8062,8064,8066,8069.
 Если по указанным бал.счетам остаток "не в той  стороне" -
 прийдется свернуть вручную.






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
  NLS_8099_ varchar2(15);  -- контрсчет ( 12, 13, 14)
  l_pap number:=3;
  l_rnk number;
  l_tmp    integer:=null;
  l_acc    accounts.acc%type:=null;
  l_branch accounts.branch%type:=substr(SYS_CONTEXT('bars_context','user_branch_mask'),1,8);

MODCODE   constant varchar2(3) := 'NAL';

Begin
  stat_:=null;
  if  to_char(bankdate_g,'mm')='12' then
   -- сворачиваем ближайшей датой к 30-11- текущего года
  select max(fdat)
   into dat1_
   from fdat
  where fdat<= to_date('30-11-'||(to_char(dd_,'YYYY')),'dd-mm-yyyy');
  elsif  to_char(bankdate_g,'mm')='01' then            -- сворачиваем датой 01-01-текущего года
   select to_date('01-01-'||(to_char(fdat,'YYYY')),'dd-mm-yyyy')
            into dat1_
            from fdat
           where fdat=dd_;
    begin                                              -- открываем дату  1-е января текущего года
     select fdat,stat
       into dat_sv,stat_
       from fdat
      where fdat=dat1_ ;
     EXCEPTION WHEN NO_DATA_FOUND THEN
         insert into fdat (FDAT,stat) values (dat1_,null);

    end;
    if stat_ is not null then                          -- делаем день доступным для работы
       update fdat set stat=null where fdat=dat1_;
    end if;
  elsif  to_char(bankdate_g,'dd-mm-yyyy')>='01-04-2011' then            -- сворачиваем датой 01-06-2011
   select to_date('01-06-2011','dd-mm-yyyy')                     -- частный случай...
            into dat1_
            from fdat
           where fdat=dd_;
    begin                                              -- открываем день 01-06-2011
     select fdat,stat
       into dat_sv,stat_
       from fdat
      where fdat=dat1_ ;
     EXCEPTION WHEN NO_DATA_FOUND THEN
         insert into fdat (FDAT,stat) values (dat1_,null);
    end;
    if stat_ is not null then                          -- делаем день доступным для работы
       update fdat set stat=null where fdat=dat1_;
    end if;
  else
    bars_audit.info('nal8_0_88_12= без проводок');
     return ;                                  --    !!!!!!!!!!!!!!добавить сообщение о том что не 12 и не 01 месяц
  end if;


 Dat_tek:=GL.bdate; -- СОХРАНЕНИЕ ТЕК ДАТЫ
 dat_sv:=dat1_;
 begin
      select f_ourmfo into mfo_ from dual;
      EXCEPTION WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(MODCODE, 'NAL_OURMFO');
 end;
 user_:= USER_ID;
 dat_    := dat_sv ;
 GL.bdate:=dat_;

-- определим контрсчет для тимчасовых , должен быть открыт
  begin
   select a.nls into nls_8099_
     from accounts a
    where  a.nbs='8099' and a.ob22='12';
    exception when no_data_found then
      bars_error.raise_nerror(MODCODE, 'NAL_ACC_ERR');
  end;
bars_audit.info('1_nal_12 = nls_8099_12 '||nls_8099_||'  dat_sv = '||dat_sv);

-- 8099 12 акт.
   nls8a_  := nls_8099_;  -- контрсчет
   begin
     select acc, substr(nms,1,38) into acc8a_, nms8a_
     from accounts where kv=980 and nls=nls8a_ and (dazs is null or dazs>gl.bd);
     EXCEPTION WHEN NO_DATA_FOUND THEN
        bars_error.raise_nerror(MODCODE, 'NAL_NU_KS6');
   end ;
   FOR k in (
         SELECT s.NLS nls, s.OSTF ost, substr(s.nms,1,38) NMS,  s.ACC
          FROM  sal s
          WHERE   s.kv=980     and   s.fdat=dat_  and s.ostf<0
                 and  s.nbs in ('8061','8063')
          )
   LOOP
     begin
       savepoint do_nal8_0_88_1;
         dk_:= 0; S_ :=-k.OST; nms8_:=nms8a_; nls8_:=nls8a_; acc8_:=acc8a_;
         nazn_:= 'Списання сум тимчасових рiзниць зг.листа в_д 30.05.2011 №13/3-61/112' ;
         gl.ref (ref_);
         INSERT INTO oper
             (ref, tt, vob, nd, dk, pdat, vdat, datd, userid,
              nam_a,nlsa, mfoa, nam_b, nlsb, mfob, kv, s, nazn )
         VALUES
             (ref_ , 'PO1', 6, ref_, dk_, dat_, dat_, dat_, user_,
              k.NMS, k.NLS, mfo_, nms8_, nls8_, mfo_, 980, S_, nazn_ );
             gl.pay2( NULL,ref_,dat_,'PO1',980,1-dk_,k.ACC,  S_, S_,1, nazn_);
             gl.pay2( NULL,ref_,dat_,'PO1',980,dk_  ,ACC8_,  S_, S_,0, nazn_);
             gl.pay2( 2,   ref_,dat_);
     bars_audit.info('2_nal_12 = ref_'||ref_);
         exception
               when others then rollback to do_nal8_0_88_1;
     end;
   END LOOP;

-- 8099 12 пас.
   nls8p_  := nls_8099_;  -- контрсчет
bars_audit.info('3_nal_12 = nls8p_ '||nls_8099_||'  dat_sv = '||dat_sv);

   begin
     select acc, substr(nms,1,38) into acc8p_, nms8p_
     from accounts where kv=980 and nls=nls8p_ and (dazs is null or dazs>gl.bd);
     EXCEPTION WHEN NO_DATA_FOUND THEN
     bars_error.raise_nerror(MODCODE, 'NAL_NU_KS7');
   end ;
   FOR k in (
         SELECT s.NLS nls, s.OSTF ost, substr(s.nms,1,38) NMS,  s.ACC
          FROM  sal s
          WHERE   s.kv=980     and   s.fdat=dat_  and s.ostf>0
                 and  s.nbs in ('8060','8062'))
   LOOP
     begin
        savepoint do_nal8_0_88_1;
        dk_:= 1; S_ :=k.OST; nms8_:=nms8p_; nls8_:=nls8p_; acc8_:=acc8p_;
        nazn_:= 'Списання сум тимчасових рiзниць зг.листа в_д 30.05.2011 №13/3-61/112' ;
        gl.ref (ref_);
        INSERT INTO oper
             (ref, tt, vob, nd, dk, pdat, vdat, datd, userid,
              nam_a,nlsa, mfoa, nam_b, nlsb, mfob, kv, s, nazn )
        VALUES
             (ref_ , 'PO1', 6, ref_, dk_, dat_, dat_, dat_, user_,
              k.NMS, k.NLS, mfo_, nms8_, nls8_, mfo_, 980, S_, nazn_ );
         gl.pay2( NULL,ref_,dat_,'PO1',980,1-dk_,k.ACC,  S_, S_,1, nazn_);
         gl.pay2( NULL,ref_,dat_,'PO1',980,dk_  ,ACC8_,  S_, S_,0, nazn_);
         gl.pay2( 2,   ref_,dat_);
      bars_audit.info('4_nal_12 = ref_'||ref_);
        exception
               when others then rollback to do_nal8_0_88_1;
     end;
   END LOOP;

-- пост_йн_ р_зниц_
  begin
   select a.nls into nls_8099_
     from accounts a
    where  a.nbs='8099' and a.ob22='13';
    exception when no_data_found then
      bars_error.raise_nerror(MODCODE, 'NAL_ACC_ERR');
  end;
bars_audit.info('1_nal_12 = nls_8099_13 '||nls_8099_||'  dat_sv = '||dat_sv);


-- 8099 13 акт.
   nls8a_  := nls_8099_;  -- контрсчет
   begin
     select acc, substr(nms,1,38) into acc8a_, nms8a_
     from accounts where kv=980 and nls=nls8a_ and (dazs is null or dazs>gl.bd);
     EXCEPTION WHEN NO_DATA_FOUND THEN
        bars_error.raise_nerror(MODCODE, 'NAL_NU_KS6');
   end ;
   FOR k in (
         SELECT s.NLS nls, s.OSTF ost, substr(s.nms,1,38) NMS,  s.ACC
          FROM  sal s
          WHERE   s.kv=980     and   s.fdat=dat_  and s.ostf<0
                 and  s.nbs in ('8065','8067')
          )
   LOOP
     begin
       savepoint do_nal8_0_88_3;  -- 8099-13 акт
         dk_:= 0; S_ :=-k.OST; nms8_:=nms8a_; nls8_:=nls8a_; acc8_:=acc8a_;
         nazn_:= 'Списання сум пост_йних рiзниць зг.листа в_д 30.05.2011 №13/3-61/112' ;
         gl.ref (ref_);
         INSERT INTO oper
             (ref, tt, vob, nd, dk, pdat, vdat, datd, userid,
              nam_a,nlsa, mfoa, nam_b, nlsb, mfob, kv, s, nazn )
         VALUES
             (ref_ , 'PO1', 6, ref_, dk_, dat_, dat_, dat_, user_,
              k.NMS, k.NLS, mfo_, nms8_, nls8_, mfo_, 980, S_, nazn_ );
             gl.pay2( NULL,ref_,dat_,'PO1',980,1-dk_,k.ACC,  S_, S_,1, nazn_);
             gl.pay2( NULL,ref_,dat_,'PO1',980,dk_  ,ACC8_,  S_, S_,0, nazn_);
             gl.pay2( 2,   ref_,dat_);
     bars_audit.info('2_nal_12 = ref_'||ref_);
         exception
               when others then rollback to do_nal8_0_88_3;
     end;
   END LOOP;

-- 8099 13 пас.
   nls8p_  := nls_8099_;  -- контрсчет
bars_audit.info('3_nal_12 = nls8p_ '||nls_8099_||'  dat_sv = '||dat_sv);

   begin
     select acc, substr(nms,1,38) into acc8p_, nms8p_
     from accounts where kv=980 and nls=nls8p_ and (dazs is null or dazs>gl.bd);
     EXCEPTION WHEN NO_DATA_FOUND THEN
     bars_error.raise_nerror(MODCODE, 'NAL_NU_KS7');
   end ;
   FOR k in (
         SELECT s.NLS nls, s.OSTF ost, substr(s.nms,1,38) NMS,  s.ACC
          FROM  sal s
          WHERE   s.kv=980     and   s.fdat=dat_  and s.ostf>0
                 and  s.nbs in ('8064','8066'))
   LOOP
     begin
        savepoint do_nal8_0_88_4;     -- 8099-13 пас
        dk_:= 1; S_ :=k.OST; nms8_:=nms8p_; nls8_:=nls8p_; acc8_:=acc8p_;
        nazn_:= 'Списання сум пост_йних рiзниць  зг.листа в_д 30.05.2011 №13/3-61/112' ;
        gl.ref (ref_);
        INSERT INTO oper
             (ref, tt, vob, nd, dk, pdat, vdat, datd, userid,
              nam_a,nlsa, mfoa, nam_b, nlsb, mfob, kv, s, nazn )
        VALUES
             (ref_ , 'PO1', 6, ref_, dk_, dat_, dat_, dat_, user_,
              k.NMS, k.NLS, mfo_, nms8_, nls8_, mfo_, 980, S_, nazn_ );
         gl.pay2( NULL,ref_,dat_,'PO1',980,1-dk_,k.ACC,  S_, S_,1, nazn_);
         gl.pay2( NULL,ref_,dat_,'PO1',980,dk_  ,ACC8_,  S_, S_,0, nazn_);
         gl.pay2( 2,   ref_,dat_);
      bars_audit.info('4_nal_12 = ref_'||ref_);
        exception
               when others then rollback to do_nal8_0_88_4;
     end;
   END LOOP;

   --
   ----  р_зниц_ помилкового в_дображення 5,6
   --

  begin
   select a.nls into nls_8099_
     from accounts a
    where  a.nbs='8099' and a.ob22='14';
    exception when no_data_found then
      bars_error.raise_nerror(MODCODE, 'NAL_ACC_ERR');
  end;
bars_audit.info('1_nal_12 = nls_8099_13 '||nls_8099_||'  dat_sv = '||dat_sv);
-- 8099 14 акт.
   nls8a_  := nls_8099_;  -- контрсчет
   begin
     select acc, substr(nms,1,38) into acc8a_, nms8a_
     from accounts where kv=980 and nls=nls8a_ and (dazs is null or dazs>gl.bd);
     EXCEPTION WHEN NO_DATA_FOUND THEN
        bars_error.raise_nerror(MODCODE, 'NAL_NU_KS6');
   end ;
   FOR k in (
         SELECT s.NLS nls, s.OSTF ost, substr(s.nms,1,38) NMS,  s.ACC
          FROM  sal s
          WHERE   s.kv=980     and   s.fdat=dat_  and s.ostf<0
                 and  s.nbs in ('8068')
          )
   LOOP
     begin
       savepoint do_nal8_0_88_5;  -- 8099-14 акт
         dk_:= 0; S_ :=-k.OST; nms8_:=nms8a_; nls8_:=nls8a_; acc8_:=acc8a_;
         nazn_:= 'Списання сум рiзниць помилкового в_дображення зг.листа в_д 30.05.2011 №13/3-61/112' ;
         gl.ref (ref_);
         INSERT INTO oper
             (ref, tt, vob, nd, dk, pdat, vdat, datd, userid,
              nam_a,nlsa, mfoa, nam_b, nlsb, mfob, kv, s, nazn )
         VALUES
             (ref_ , 'PO1', 6, ref_, dk_, dat_, dat_, dat_, user_,
              k.NMS, k.NLS, mfo_, nms8_, nls8_, mfo_, 980, S_, nazn_ );
             gl.pay2( NULL,ref_,dat_,'PO1',980,1-dk_,k.ACC,  S_, S_,1, nazn_);
             gl.pay2( NULL,ref_,dat_,'PO1',980,dk_  ,ACC8_,  S_, S_,0, nazn_);
             gl.pay2( 2,   ref_,dat_);
     bars_audit.info('2_nal_12 = ref_'||ref_);
         exception
               when others then rollback to do_nal8_0_88_5;
     end;
   END LOOP;

-- 8099 13 пас.
   nls8p_  := nls_8099_;  -- контрсчет
bars_audit.info('3_nal_12 = nls8p_ '||nls_8099_||'  dat_sv = '||dat_sv);

   begin
     select acc, substr(nms,1,38) into acc8p_, nms8p_
     from accounts where kv=980 and nls=nls8p_ and (dazs is null or dazs>gl.bd);
     EXCEPTION WHEN NO_DATA_FOUND THEN
     bars_error.raise_nerror(MODCODE, 'NAL_NU_KS7');
   end ;
   FOR k in (
         SELECT s.NLS nls, s.OSTF ost, substr(s.nms,1,38) NMS,  s.ACC
          FROM  sal s
          WHERE   s.kv=980     and   s.fdat=dat_  and s.ostf>0
                 and  s.nbs in ('8069'))
   LOOP
     begin
        savepoint do_nal8_0_88_6;     -- 8099-14 пас
        dk_:= 1; S_ :=k.OST; nms8_:=nms8p_; nls8_:=nls8p_; acc8_:=acc8p_;
        nazn_:=  'Списання сум рiзниць помилкового в_дображення зг.листа в_д 30.05.2011 №13/3-61/112' ;
        gl.ref (ref_);
        INSERT INTO oper
             (ref, tt, vob, nd, dk, pdat, vdat, datd, userid,
              nam_a,nlsa, mfoa, nam_b, nlsb, mfob, kv, s, nazn )
        VALUES
             (ref_ , 'PO1', 6, ref_, dk_, dat_, dat_, dat_, user_,
              k.NMS, k.NLS, mfo_, nms8_, nls8_, mfo_, 980, S_, nazn_ );
         gl.pay2( NULL,ref_,dat_,'PO1',980,1-dk_,k.ACC,  S_, S_,1, nazn_);
         gl.pay2( NULL,ref_,dat_,'PO1',980,dk_  ,ACC8_,  S_, S_,0, nazn_);
         gl.pay2( 2,   ref_,dat_);
      bars_audit.info('4_nal_12 = ref_'||ref_);
        exception
               when others then rollback to do_nal8_0_88_6;
     end;
   END LOOP;
gl.bDATE:= dat_tek;
commit;
END nal8_0_88_12;
/
show err;

PROMPT *** Create  grants  NAL8_0_88_12 ***
grant EXECUTE                                                                on NAL8_0_88_12    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NAL8_0_88_12    to NALOG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NAL8_0_88_12.sql =========*** End 
PROMPT ===================================================================================== 
