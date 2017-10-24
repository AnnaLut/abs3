

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NAL8_0_OB22.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NAL8_0_OB22 ***

  CREATE OR REPLACE PROCEDURE BARS.NAL8_0_OB22 (dd_ date)
/*
 28-01-2015 nvv 2015 год

 
 23-01-2013 qwa Приведение в соотв. для 2013 года сворачивание
            за 2012 год 
            Учла особенности Тернополя и возможно других (с 2012 года), 
            когда счета уже открыты с аналитикой  8099%01( есть что угодно 
            после контрольного разряда, а Об22 в конце)
            При этом для  Тернополя переключевала счета !!

 19-01-2012 qwa В Ужгороде некорректно обрабатывались контрсчета, 
            (были закрытые и открытые), части не было открыто
            изменила размерность  SB_ZGOD_2009.ob22_a,  SB_ZGOD_2009.ob22_b 
            на 2 знака 
 28-12-2011 qwa
       корректировка под 2011 год в соотв. с листом №13/3-57/359 от 27.12.2011
       сделаны настройки-условности, которые нужно настраивать из года в год
       1) таблица  SB_ZGOD_2009 - задает кантровку счетов для перекрытия, должна
           соотв. листу, который департамент рассылает в конце года
       2) день для сворачивания, раньше брали 01-01, теперь похоже нужно брать 03-01
       3) нужно пересмотреть код для каждого раздела письма, учесть разные варианты
       - весь бал счет
       - отдельные Р080
       - отдельные OB22
       - отдельные Р080 и ОВ22
       - явно указаны в селектах для исключения
                       а)  8030 - Р080=0179,0180
                        
 27.12.2010 qwa
       введен препроцессор для ГОУ ОБ
 21.01.2010 qwa
       процедура для сворачивания 8-го класса в начале года
       версия  0.0   от 21-01-2010  для областных ОБ
       сворачиваем датой 01 января текущего года
       в соотв. с постановлением
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
  NLS_8099_01 varchar2(15);
  NLS_8099_02 varchar2(15);
  NLS_8099_03 varchar2(15);
  --NLS_8099_04 varchar2(15);
  NLS_8099_05 varchar2(15);
  NLS_8099_08 varchar2(15);
  NLS_8099_09 varchar2(15);
  NLS_8099_10 varchar2(15);
  NLS_8099_11 varchar2(15);
  NLS_8099_15 varchar2(15);
  NLS_8020_01 varchar2(15);
  NLS_8020_02 varchar2(15);
  l_pap number:=3;
  l_rnk number;
  l_tmp    integer:=null;
  l_acc    accounts.acc%type:=null;

  l_branch accounts.branch%type:=substr(SYS_CONTEXT('bars_context','user_branch_mask'),1,8);
  MODCODE   constant varchar2(3) := 'NAL';

Begin
    stat_:=null;
    /*
    select to_date('06-01-'||(to_char(fdat,'YYYY')),'dd-mm-yyyy') 
      into dat1_  -- для 2013 года 1-й рабочий день
      from fdat where fdat=dd_;
    */ 
    /*
    select min (fdat) 
      into dat1_  -- для 2013 года 1-й рабочий день
      from fdat where fdat between trunc(dd_,'yyyy') and dd_;  
     */
     
     dat1_ := trunc(dd_,'yyyy');
     
    begin
--   открываем дату  3-е января текущего года
     select fdat,stat
       into dat_sv,stat_
       from fdat
      where fdat=dat1_ ;
     EXCEPTION WHEN NO_DATA_FOUND THEN
         begin
          insert into fdat (FDAT,stat) values (dat1_,null);
         end;
    end;
-- делаем день доступным для работы
    if stat_ is not null then
       update fdat
          set stat=null
        where fdat=dat1_;

    end if;
    Dat_tek:=GL.bdate; -- СОХРАНЕНИЕ ТЕК ДАТЫ
-- вариант - дата сворачивания - первая рабочая дата этого года
--    select min(fdat) into dat_sv  from fdat
--           where to_number(to_char(fdat,'YYYY'))=
--                 to_number(to_char(dat_tek,'YYYY'));
--дата сворачивания - 1-01-20...

    user_   := USER_ID;
    dat_    := dat1_ ;
    GL.bdate:= dat1_;


-- rnk для возможного открытия счета
   begin
     select rnk  into l_rnk   from accounts
          where nls=(select val from params where par='NU_KS7');
          exception when no_data_found then
                    bars_error.raise_nerror(MODCODE, 'NAL_NU_KS7');
   end;
-- определим контрсчета, если нет нужных - откроем
    for k in (select distinct nbs_a,ob22_a from SB_ZGOD_2009 where nbs_a='8099')
    loop
     if   k.ob22_a='01' then
          begin
            select nls into nls_8099_01 from accounts where nls like '8099%01' and dazs is null and rownum=1;
            exception when no_data_found then
             op_reg_lock (99, 0, 0, 28,  l_tmp,  l_rnk,
                vkrzn(substr(f_ourmfo,1,5),k.nbs_a||'0'||trim(k.ob22_a)),   980, 'Техн_чний рахунок для ', 'ODB',
                USER_ID, l_acc, '1', l_pap,  0, null, null, null, null, null,
                null, null, null, null,l_branch);

            bars_audit.info('nal0= в?дкриття рахунка'||l_acc);
            if l_acc is null
             then bars_error.raise_nerror(MODCODE, 'NAL_ACC_ERR');
            else
             begin
             insert   into specparam_int (acc,ob22,kf)
                   values (l_acc,k.ob22_a,sys_context('bars_context','user_mfo'));   

               exception when dup_val_on_index then
               update  specparam_int
                  set ob22=k.ob22_a
                where acc=l_acc;
             end;
             select nls into nls_8099_01 from accounts where acc=l_acc;
            end if;
            commit;
          end;
     elsif k.ob22_a='02' then
           begin
            select nls into nls_8099_02 from accounts where nls like '8099%02' and dazs is null and rownum=1;
            exception when no_data_found then
             op_reg_lock (99, 0, 0, 28,  l_tmp,  l_rnk,
                vkrzn(substr(f_ourmfo,1,5),k.nbs_a||'0'||trim(k.ob22_a)),   980, 'Техн_чний рахунок для ', 'ODB',
                USER_ID, l_acc, '1', l_pap,  0, null, null, null, null, null,
                null, null, null, null,l_branch);

            bars_audit.info('nal0= в?дкриття рахунка'||l_acc);
            if l_acc is null
             then bars_error.raise_nerror(MODCODE, 'NAL_ACC_ERR');
            else
             begin
             insert   into specparam_int (acc,ob22,kf)
                   values (l_acc,k.ob22_a,sys_context('bars_context','user_mfo'));   


               exception when dup_val_on_index then
               update  specparam_int
                  set ob22=k.ob22_a
                where acc=l_acc;
             end;
             select nls into nls_8099_02 from accounts where acc=l_acc;
            end if;
            commit;
           end;
     elsif k.ob22_a='03' then
           begin
            select nls into nls_8099_03 from accounts where nls like '8099%03' and dazs is null and rownum=1;
           exception when no_data_found then
             op_reg_lock (99, 0, 0, 28,  l_tmp,  l_rnk,
                vkrzn(substr(f_ourmfo,1,5),k.nbs_a||'0'||trim(k.ob22_a)),   980, 'Техн_чний рахунок для ', 'ODB',
                USER_ID, l_acc, '1', l_pap,  0, null, null, null, null, null,
                null, null, null, null,l_branch);

            bars_audit.info('nal0= в?дкриття рахунка'||l_acc);
            if l_acc is null
             then bars_error.raise_nerror(MODCODE, 'NAL_ACC_ERR');
            else
             begin
             insert   into specparam_int (acc,ob22,kf)
                   values (l_acc,k.ob22_a,sys_context('bars_context','user_mfo'));   


               exception when dup_val_on_index then
               update  specparam_int
                  set ob22=k.ob22_a
                where acc=l_acc;
             end;
             select nls into nls_8099_03 from accounts where acc=l_acc;
            end if;
            commit;
           end;
     elsif k.ob22_a='05' then
           begin
            select nls into nls_8099_05 from accounts where nls like '8099%05' and dazs is null and rownum=1;
           exception when no_data_found then
             op_reg_lock (99, 0, 0, 28,  l_tmp,  l_rnk,
                vkrzn(substr(f_ourmfo,1,5),k.nbs_a||'0'||trim(k.ob22_a)),   980, 'Техн_чний рахунок для ', 'ODB',
                USER_ID, l_acc, '1', l_pap,  0, null, null, null, null, null,
                null, null, null, null,l_branch);

            bars_audit.info('nal0= в?дкриття рахунка'||l_acc);
            if l_acc is null
             then bars_error.raise_nerror(MODCODE, 'NAL_ACC_ERR');
            else
             begin
             insert   into specparam_int (acc,ob22,kf)
                   values (l_acc,k.ob22_a,sys_context('bars_context','user_mfo'));   

               exception when dup_val_on_index then
               update  specparam_int
                  set ob22=k.ob22_a
                where acc=l_acc;
             end;
             select nls into nls_8099_05 from accounts where acc=l_acc;
            end if;
            commit;
           end;
     elsif k.ob22_a='08' then
           begin
            select nls into nls_8099_08 from accounts where nls like '8099%08' and dazs is null and rownum=1;
            exception when no_data_found then
             op_reg_lock (99, 0, 0, 28,  l_tmp,  l_rnk,
                vkrzn(substr(f_ourmfo,1,5),k.nbs_a||'0'||trim(k.ob22_a)),   980, 'Техн_чний рахунок для ', 'ODB',
                USER_ID, l_acc, '1', l_pap,  0, null, null, null, null, null,
                null, null, null, null,l_branch);

            bars_audit.info('nal0= в?дкриття рахунка'||l_acc);
            if l_acc is null
             then bars_error.raise_nerror(MODCODE, 'NAL_ACC_ERR');
            else
             begin
             insert   into specparam_int (acc,ob22,kf)
                   values (l_acc,k.ob22_a,sys_context('bars_context','user_mfo'));   

               exception when dup_val_on_index then
               update  specparam_int
                  set ob22=k.ob22_a
                where acc=l_acc;
             end;
            select nls into nls_8099_08 from accounts where acc=l_acc;
            end if;
            commit;
           end;
     elsif k.ob22_a='09' then
           begin
            select nls into nls_8099_09 from accounts where nls like '8099%09' and dazs is null and rownum=1;
           exception when no_data_found then
             op_reg_lock (99, 0, 0, 28,  l_tmp,  l_rnk,
                vkrzn(substr(f_ourmfo,1,5),k.nbs_a||'0'||trim(k.ob22_a)),   980, 'Техн_чний рахунок для ', 'ODB',
                USER_ID, l_acc, '1', l_pap,  0, null, null, null, null, null,
                null, null, null, null,l_branch);

            bars_audit.info('nal0= в?дкриття рахунка'||l_acc);
            if l_acc is null
             then bars_error.raise_nerror(MODCODE, 'NAL_ACC_ERR');
            else
             begin
             insert   into specparam_int (acc,ob22,kf)
                   values (l_acc,k.ob22_a,sys_context('bars_context','user_mfo'));   

               exception when dup_val_on_index then
               update  specparam_int
                  set ob22=k.ob22_a
                where acc=l_acc;
             end;
             select nls into nls_8099_09 from accounts where acc=l_acc;
            end if;
            commit;
           end;
     elsif k.ob22_a='10' then
           begin
            select nls into nls_8099_10 from accounts where nls like '8099%10' and dazs is null and rownum=1;
           exception when no_data_found then
             op_reg_lock (99, 0, 0, 28,  l_tmp,  l_rnk,
                vkrzn(substr(f_ourmfo,1,5),k.nbs_a||'0'||trim(k.ob22_a)),   980, 'Техн_чний рахунок для ', 'ODB',
                USER_ID, l_acc, '1', l_pap,  0, null, null, null, null, null,
                null, null, null, null,l_branch);

            bars_audit.info('nal0= в?дкриття рахунка'||l_acc);
            if l_acc is null
             then bars_error.raise_nerror(MODCODE, 'NAL_ACC_ERR');
            else
             begin
             insert   into specparam_int (acc,ob22,kf)
                   values (l_acc,k.ob22_a,sys_context('bars_context','user_mfo'));   

               exception when dup_val_on_index then
               update  specparam_int
                  set ob22=k.ob22_a
                where acc=l_acc;
             end;
             select nls into nls_8099_10 from accounts where acc=l_acc;
            end if;
            commit;
           end;
     elsif k.ob22_a='11' then
           begin
            select nls into nls_8099_11 from accounts where nls like '8099%11' and dazs is null and rownum=1;
           exception when no_data_found then
             op_reg_lock (99, 0, 0, 28,  l_tmp,  l_rnk,
                vkrzn(substr(f_ourmfo,1,5),k.nbs_a||'0'||trim(k.ob22_a)),   980, 'Техн_чний рахунок для ', 'ODB',
                USER_ID, l_acc, '1', l_pap,  0, null, null, null, null, null,
                null, null, null, null,l_branch);

            bars_audit.info('nal0= в?дкриття рахунка'||l_acc);
            if l_acc is null
             then bars_error.raise_nerror(MODCODE, 'NAL_ACC_ERR');
            else
             begin
             insert   into specparam_int (acc,ob22,kf)
                   values (l_acc,k.ob22_a,sys_context('bars_context','user_mfo'));   

               exception when dup_val_on_index then
               update  specparam_int
                  set ob22=k.ob22_a
                where acc=l_acc;
             end;
             select nls into nls_8099_11 from accounts where acc=l_acc;
            end if;
            commit;
           end;
 /*    elsif k.ob22_a='15' then
           begin
            select nls into nls_8099_15 from accounts where nls like '8099%15' and dazs is null and rownum=1;
           exception when no_data_found then
             op_reg_lock (99, 0, 0, 28,  l_tmp,  l_rnk,
                vkrzn(substr(f_ourmfo,1,5),k.nbs_a||'0'||trim(k.ob22_a)),   980, 'Техн_чний рахунок для ', 'ODB',
                USER_ID, l_acc, '1', l_pap,  0, null, null, null, null, null,
                null, null, null, null,l_branch);

            bars_audit.info('nal0= в?дкриття рахунка'||l_acc);
            if l_acc is null
             then bars_error.raise_nerror(MODCODE, 'NAL_ACC_ERR');
            else
             begin
             insert   into specparam_int (acc,ob22,kf)
                   values (l_acc,k.ob22_a,sys_context('bars_context','user_mfo'));   

               exception when dup_val_on_index then
               update  specparam_int
                  set ob22=k.ob22_a
                where acc=l_acc;
             end;
             select nls into nls_8099_15 from accounts where acc=l_acc;
            end if;
            commit;
           end;*/
     end if;
    end loop;
-- счет валовых для активных и пасс. остатков
 select val into nls_8020_01 from params where par='NU_KS7';
 select val into nls_8020_02 from params where par='NU_KS6';

bars_audit.info('nal1 '||nls_8020_01||' '||nls_8020_02);

nazn_:= 'Згортання рахункiв Податкового облiку на початок '||to_char(gl.bd,'YYYY')||' року';
    begin
      select f_ourmfo into mfo_ from dual;
      EXCEPTION WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(MODCODE, 'NAL_OURMFO');
    end;

-- пункт 3-А =========================================================================
-- 8099 01 акт.
   nls8a_  := nls_8099_01;  -- контрсчет
bars_audit.info('nal_01 '||nls_8099_01);
   begin
     select acc, substr(nms,1,38) into acc8a_, nms8a_
     from accounts where kv=980 and nls=nls8a_ and (dazs is null or dazs<gl.bd);
     EXCEPTION WHEN NO_DATA_FOUND THEN
     bars_error.raise_nerror(MODCODE, 'NAL_NU_KS6');
   end ;
   FOR k in (
         SELECT s.NLS nls, s.OST ostf,i.ob22,i.p080 ,substr(s.nms,1,38) NMS,  s.ACC  -- все ob22,p080
          FROM  sal s,specparam_int i,
                (select nbs_b,ob22_b,p080_b
                   from SB_ZGOD_2009
                  where dk=1 and nbs_a='8099' and ob22_a='01'
                ) t
          WHERE  s.kv=980                  and   s.fdat=dat_  and s.ost<0
                 and  s.nbs =t.nbs_b       and   s.acc=i.acc
                 and i.ob22=nvl(t.ob22_b,i.ob22)
                 and t.p080_b is null
                 and t.ob22_b is null  and s.nls like '8%'
                 and ((s.nbs<>'8030') or
                      (s.nbs='8030' and i.p080 not in ('0179','0349')))   ----- для 2011,2012,2013
                                                                           --   года по 8030 исключаем Р080=0179
         union all
         SELECT s.NLS, s.OST,i.ob22,i.p080 ,substr(s.nms,1,38) NMS,  s.ACC   -- только отдельные P080
          FROM  sal s,specparam_int i,
                (select nbs_b,ob22_b,p080_b from SB_ZGOD_2009  where dk=1 and nbs_a='8099' and ob22_a='01'      ) t
         WHERE     s.kv=980                  and   s.fdat=dat_                  and s.ost<0
                  and  s.nbs =t.nbs_b            and   s.acc=i.acc
                  and i.ob22=nvl(t.ob22_b,i.ob22)
                  and t.p080_b is not null  and s.nls like '8%'
                  and i.p080=t.p080_b
                  and t.ob22_b is null
         union all
         SELECT s.NLS, s.OST,i.ob22,i.p080 ,substr(s.nms,1,38) NMS,  s.ACC   -- только отдельные OB22
          FROM  sal s,specparam_int i,
                (select nbs_b,ob22_b,p080_b from SB_ZGOD_2009  where dk=1 and nbs_a='8099' and ob22_a='01') t
          WHERE     s.kv=980                  and   s.fdat=dat_                 and s.ost<0
              and  s.nbs =t.nbs_b            and   s.acc=i.acc
              and i.ob22=nvl(t.ob22_b,i.ob22)
              and t.ob22_b is not null
              and i.ob22=t.ob22_b  and s.nls like '8%'
              and t.p080_b is null
        --  union all
        --   SELECT s.NLS, s.OSTF,'15',null,substr(s.nms,1,38) NMS,  s.ACC
        --    FROM  sal s
        --    WHERE s.nls=nls_8099_15  and   s.fdat=dat_   and s.ostf>0
        --   union all
        --   SELECT s.NLS, s.OSTF,'01',null,substr(s.nms,1,38) NMS,  s.ACC
        --    FROM  sal s
        --   WHERE s.nls=nls_8020_01  and   s.fdat=dat_   and s.ostf<0
          )
   LOOP
      begin
         dk_:= 0; S_ :=-k.OSTF; nms8_:=nms8a_; nls8_:=nls8a_; acc8_:=acc8a_;
         savepoint do_nal8_0_3a;
         gl.ref (ref_);
         INSERT INTO oper
             (ref, tt, vob, nd, dk, pdat, vdat, datd, userid,
              nam_a,nlsa, mfoa, nam_b, nlsb, mfob, kv, s, nazn )
         VALUES
             (ref_ , 'PO1', 6, substr(ref_,1,10), dk_, dat_, dat_, dat_, user_,
              k.NMS, k.NLS, mfo_, nms8_, nls8_, mfo_, 980, S_, nazn_ );
             gl.pay2( NULL,ref_,dat_,'PO1',980,1-dk_,k.ACC,  S_, S_,1, nazn_);
             gl.pay2( NULL,ref_,dat_,'PO1',980,dk_  ,ACC8_,  S_, S_,0, nazn_);
             gl.pay2( 2,   ref_,dat_);
         exception when others then rollback to do_nal8_0_3a;
         logger.info('NAL8_ '||k.NLS||' >' ||sqlerrm); 
      end;
   END LOOP;
-- пункт 3- Б  =========================================================================
-- 8099 02 пас.
   nls8p_  := nls_8099_02;  -- контрсчет
bars_audit.info('nal_02 '||nls_8099_02);
   begin
     select acc, substr(nms,1,38) into acc8p_, nms8p_
     from accounts where kv=980 and nls=nls8p_ and (dazs is null or dazs<gl.bd);
     EXCEPTION WHEN NO_DATA_FOUND THEN
     bars_error.raise_nerror(MODCODE, 'NAL_NU_KS7');
   end ;
   FOR k in (
         SELECT s.NLS nls, s.OST ostf,i.ob22,i.p080 ,substr(s.nms,1,38) NMS,  s.ACC
          FROM  sal s,specparam_int i,
                (select nbs_b,ob22_b,p080_b from SB_ZGOD_2009  where dk=0 and nbs_a='8099' and ob22_a='02' ) t
          WHERE     s.kv=980                  and   s.fdat=dat_  and s.ost>0
                 and  s.nbs =t.nbs_b            and   s.acc=i.acc   and s.nls like '8%'
                 and i.ob22=nvl(t.ob22_b,i.ob22)
                 and t.p080_b is null
                 and t.ob22_b is null  
         union all
         SELECT s.NLS, s.OST,i.ob22,i.p080 ,substr(s.nms,1,38) NMS,  s.ACC
          FROM  sal s,specparam_int i,
                (select nbs_b,ob22_b,p080_b from SB_ZGOD_2009  where dk=0 and nbs_a='8099' and ob22_a='02'      ) t
         WHERE     s.kv=980                  and   s.fdat=dat_                  and s.ost>0
                  and  s.nbs =t.nbs_b            and   s.acc=i.acc  and s.nls like '8%'
                  and i.ob22=nvl(t.ob22_b,i.ob22)
                  and t.p080_b is not null
                  and i.p080=t.p080_b
                  and t.ob22_b is null 
         union all
         SELECT s.NLS, s.OST,i.ob22,i.p080 ,substr(s.nms,1,38) NMS,  s.ACC
          FROM  sal s,specparam_int i,
                (select nbs_b,ob22_b,p080_b from SB_ZGOD_2009  where dk=0 and nbs_a='8099' and ob22_a='02') t
          WHERE     s.kv=980                  and   s.fdat=dat_                 and s.ost>0
              and  s.nbs =t.nbs_b            and   s.acc=i.acc
              and i.ob22=nvl(t.ob22_b,i.ob22)
              and t.ob22_b is not null
              and i.ob22=t.ob22_b  and s.nls like '8%'
              and t.p080_b is null
            )
   LOOP
      begin
         dk_:= 1; S_ :=k.OSTF; nms8_:=nms8p_; nls8_:=nls8p_; acc8_:=acc8p_;
         savepoint do_nal8_0_3b;
         gl.ref (ref_);
         INSERT INTO oper
             (ref, tt, vob, nd, dk, pdat, vdat, datd, userid,
              nam_a,nlsa, mfoa, nam_b, nlsb, mfob, kv, s, nazn )
         VALUES
             (ref_ , 'PO1', 6, substr(ref_,1,10), dk_, dat_, dat_, dat_, user_,
              k.NMS, k.NLS, mfo_, nms8_, nls8_, mfo_, 980, S_, nazn_ );
             gl.pay2( NULL,ref_,dat_,'PO1',980,1-dk_,k.ACC,  S_, S_,1, nazn_);
             gl.pay2( NULL,ref_,dat_,'PO1',980,dk_  ,ACC8_,  S_, S_,0, nazn_);
             gl.pay2( 2,   ref_,dat_);
         exception when others then rollback to do_nal8_0_3b;
      end;
   END LOOP;

--
-- пункт 3-B =========================================================================
-- 8099 08 пас.  только пас. остаток
   nls8a_  := nls_8099_08;  -- контрсчет
  bars_audit.info('nal_08 '||nls_8099_08);
   begin
     select acc, substr(nms,1,38) into acc8a_, nms8a_
     from accounts where kv=980 and nls=nls8a_ and (dazs is null or dazs<gl.bd);
     EXCEPTION WHEN NO_DATA_FOUND THEN
     bars_error.raise_nerror(MODCODE, 'NAL_NU_KS6');
   end ;
   FOR k in (
         SELECT s.NLS nls, s.OST ostf,i.ob22,i.p080 ,substr(s.nms,1,38) NMS,  s.ACC
          FROM  sal s,specparam_int i,
                (select nbs_b,ob22_b,p080_b from SB_ZGOD_2009  where dk=0 and nbs_a='8099' and ob22_a ='08' ) t
          WHERE     s.kv=980                  and   s.fdat=dat_  and s.ost>0
                 and  s.nbs =t.nbs_b            and   s.acc=i.acc
                 and i.ob22=nvl(t.ob22_b,i.ob22)
                 and t.p080_b is null
                 and t.ob22_b is null  and s.nls like '8%'
               )
   LOOP
     begin
         dk_:= 1; S_ :=k.OSTF; nms8_:=nms8a_; nls8_:=nls8a_; acc8_:=acc8a_;
         savepoint do_nal8_0_3v1;
         gl.ref (ref_);
         INSERT INTO oper
             (ref, tt, vob, nd, dk, pdat, vdat, datd, userid,
              nam_a,nlsa, mfoa, nam_b, nlsb, mfob, kv, s, nazn )
         VALUES
             (ref_ , 'PO1', 6, substr(ref_,1,10), dk_, dat_, dat_, dat_, user_,
              k.NMS, k.NLS, mfo_, nms8_, nls8_, mfo_, 980, S_, nazn_ );
             gl.pay2( NULL,ref_,dat_,'PO1',980,1-dk_,k.ACC,  S_, S_,1, nazn_);
             gl.pay2( NULL,ref_,dat_,'PO1',980,dk_  ,ACC8_,  S_, S_,0, nazn_);
             gl.pay2( 2,   ref_,dat_);
         exception when others then rollback to do_nal8_0_3v1;
      end;
   END LOOP;

-- пункт 3- В  =========================================================================
-- 8099 10 пас.
   nls8p_  := nls_8099_10;  -- контрсчет
bars_audit.info('nal_10 '||nls_8099_10);
   begin
     select acc, substr(nms,1,38) into acc8p_, nms8p_
     from accounts where kv=980 and nls=nls8p_ and (dazs is null or dazs<gl.bd);
     EXCEPTION WHEN NO_DATA_FOUND THEN
     bars_error.raise_nerror(MODCODE, 'NAL_NU_KS7');
   end ;
   FOR k in (
         SELECT s.NLS nls, s.OST ostf,i.ob22,i.p080 ,substr(s.nms,1,38) NMS,  s.ACC
          FROM  sal s,specparam_int i,
                (select nbs_b,ob22_b,p080_b from SB_ZGOD_2009  where dk=0 and nbs_a='8099' and ob22_a='10' ) t
          WHERE     s.kv=980                  and   s.fdat=dat_  and s.ost>0
                 and  s.nbs =t.nbs_b            and   s.acc=i.acc
                 and i.ob22=nvl(t.ob22_b,i.ob22)
                 and t.p080_b is null
                 and t.ob22_b is null  and s.nls like '8%'
           )
   LOOP
     begin
         dk_:= 1; S_ :=k.OSTF; nms8_:=nms8p_; nls8_:=nls8p_; acc8_:=acc8p_;
         savepoint do_nal8_0_3v2;
         gl.ref (ref_);
         INSERT INTO oper
             (ref, tt, vob, nd, dk, pdat, vdat, datd, userid,
              nam_a,nlsa, mfoa, nam_b, nlsb, mfob, kv, s, nazn )
         VALUES
             (ref_ , 'PO1', 6, substr(ref_,1,10), dk_, dat_, dat_, dat_, user_,
              k.NMS, k.NLS, mfo_, nms8_, nls8_, mfo_, 980, S_, nazn_ );
             gl.pay2( NULL,ref_,dat_,'PO1',980,1-dk_,k.ACC,  S_, S_,1, nazn_);
             gl.pay2( NULL,ref_,dat_,'PO1',980,dk_  ,ACC8_,  S_, S_,0, nazn_);
             gl.pay2( 2,   ref_,dat_);
         exception when others then rollback to do_nal8_0_3v2;
     end;
   END LOOP;
 -- пункт 3-Г1 =========================================================================
-- 8099 03 акт.
/*
nls8a_  := nls_8099_03;  -- контрсчет
bars_audit.info('nal_03 '||nls_8099_03);
   begin
     select acc, substr(nms,1,38) into acc8a_, nms8a_
     from accounts where kv=980 and nls=nls8a_ and (dazs is null or dazs<gl.bd);
     EXCEPTION WHEN NO_DATA_FOUND THEN
     bars_error.raise_nerror(MODCODE, 'NAL_NU_KS6');
   end ;
   FOR k in (
         SELECT s.NLS nls, s.OST ostf,i.ob22,i.p080 ,substr(s.nms,1,38) NMS,  s.ACC
          FROM  sal s,specparam_int i,
                (select nbs_b,ob22_b,p080_b from SB_ZGOD_2009  where dk=1 and nbs_a='8099' and ob22_a='03' ) t
          WHERE     s.kv=980                  and   s.fdat=dat_  and s.ostf<0
                 and  s.nbs =t.nbs_b            and   s.acc=i.acc
                 and i.ob22=nvl(t.ob22_b,i.ob22)
                 and t.p080_b is null
                 and t.ob22_b is null  and s.nls like '8%'
              )
   LOOP
      begin
         dk_:= 0; S_ :=-k.OSTF; nms8_:=nms8a_; nls8_:=nls8a_; acc8_:=acc8a_;
         savepoint do_nal8_0_3g1;
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
         exception when others then rollback to do_nal8_0_3g1;
       end;
   END LOOP;*/
-- пункт 3-Г2 =========================================================================
-- 8099 08 акт. только акт. остаток
   nls8a_  := nls_8099_08;  -- контрсчет
   begin
     select acc, substr(nms,1,38) into acc8a_, nms8a_
     from accounts where kv=980 and nls=nls8a_ and (dazs is null or dazs<gl.bd);
     EXCEPTION WHEN NO_DATA_FOUND THEN
     bars_error.raise_nerror(MODCODE, 'NAL_NU_KS6');
   end ;
   FOR k in (
         SELECT s.NLS nls, s.OST ostf,i.ob22,i.p080 ,substr(s.nms,1,38) NMS,  s.ACC
          FROM  sal s,specparam_int i,
                (select nbs_b,ob22_b,p080_b from SB_ZGOD_2009  where dk=1 and nbs_a='8099' and ob22_a='08' ) t
          WHERE     s.kv=980                  and   s.fdat=dat_  and s.ost<0
                 and  s.nbs =t.nbs_b            and   s.acc=i.acc
                 and i.ob22=nvl(t.ob22_b,i.ob22)
                 and t.p080_b is null
                 and t.ob22_b is null  and s.nls like '8%'
             )
   LOOP
     begin
         dk_:= 0; S_ :=-k.OSTF; nms8_:=nms8a_; nls8_:=nls8a_; acc8_:=acc8a_;
         savepoint do_nal8_0_3g2;
         gl.ref (ref_);
         INSERT INTO oper
             (ref, tt, vob, nd, dk, pdat, vdat, datd, userid,
              nam_a,nlsa, mfoa, nam_b, nlsb, mfob, kv, s, nazn )
         VALUES
             (ref_ , 'PO1', 6, substr(ref_,1,10), dk_, dat_, dat_, dat_, user_,
              k.NMS, k.NLS, mfo_, nms8_, nls8_, mfo_, 980, S_, nazn_ );
             gl.pay2( NULL,ref_,dat_,'PO1',980,1-dk_,k.ACC,  S_, S_,1, nazn_);
             gl.pay2( NULL,ref_,dat_,'PO1',980,dk_  ,ACC8_,  S_, S_,0, nazn_);
             gl.pay2( 2,   ref_,dat_);
         exception when others then rollback to do_nal8_0_3g2;
      end;
   END LOOP;
-- пункт 3-Г3 =========================================================================
-- 8099 09 акт.
   nls8a_  := nls_8099_09;  -- контрсчет
bars_audit.info('nal_09 '||nls_8099_09);
   begin
     select acc, substr(nms,1,38) into acc8a_, nms8a_
     from accounts where kv=980 and nls=nls8a_ and (dazs is null or dazs<gl.bd);
     EXCEPTION WHEN NO_DATA_FOUND THEN
     bars_error.raise_nerror(MODCODE, 'NAL_NU_KS6');
   end ;
   FOR k in (
         SELECT s.NLS nls, s.OST ostf,i.ob22,i.p080 ,substr(s.nms,1,38) NMS,  s.ACC
          FROM  sal s,specparam_int i,
                (select nbs_b,ob22_b,p080_b from sb_ZGOD_2009  where dk=1 and nbs_a='8099' and ob22_a='09' ) t
          WHERE     s.kv=980                  and   s.fdat=dat_  and s.ost<0
                 and  s.nbs =t.nbs_b          and   s.acc=i.acc
                 and i.ob22=nvl(t.ob22_b,i.ob22)
                 and t.p080_b is null
                 and t.ob22_b is null  and s.nls like '8%'
          )
   LOOP
      begin
         dk_:= 0; S_ :=-k.OSTF; nms8_:=nms8a_; nls8_:=nls8a_; acc8_:=acc8a_;
         savepoint do_nal8_0_3g3;
         gl.ref (ref_);
         INSERT INTO oper
             (ref, tt, vob, nd, dk, pdat, vdat, datd, userid,
              nam_a,nlsa, mfoa, nam_b, nlsb, mfob, kv, s, nazn )
         VALUES
             (ref_ , 'PO1', 6, substr(ref_,1,10), dk_, dat_, dat_, dat_, user_,
              k.NMS, k.NLS, mfo_, nms8_, nls8_, mfo_, 980, S_, nazn_ );
             gl.pay2( NULL,ref_,dat_,'PO1',980,1-dk_,k.ACC,  S_, S_,1, nazn_);
             gl.pay2( NULL,ref_,dat_,'PO1',980,dk_  ,ACC8_,  S_, S_,0, nazn_);
             gl.pay2( 2,   ref_,dat_);
         exception when others then rollback to do_nal8_0_3g3;
       end;
   END LOOP;
-- пункт 3-Г4 =========================================================================
-- 8099 15 акт.
/*
   nls8a_  := nls_8099_15;  -- контрсчет
bars_audit.info('nal_15 '||nls_8099_15);
   begin
     select acc, substr(nms,1,38) into acc8a_, nms8a_
     from accounts where kv=980 and nls=nls8a_ and (dazs is null or dazs<gl.bd);
     EXCEPTION WHEN NO_DATA_FOUND THEN
     bars_error.raise_nerror(MODCODE, 'NAL_NU_KS6');
   end ;
   FOR k in (
          SELECT s.NLS, s.OSTF,i.ob22,i.p080 ,substr(s.nms,1,38) NMS,  s.ACC
          FROM  sal s,specparam_int i,
                (select nbs_b,ob22_b,p080_b from sb_ZGOD_2009  where dk=1 and nbs_a='8099' and ob22_a='15'      ) t
          WHERE     s.kv=980                  and   s.fdat=dat_                  and s.ostf<0
                  and  s.nbs =t.nbs_b            and   s.acc=i.acc
                  and i.ob22=nvl(t.ob22_b,i.ob22)
                  and t.p080_b is not null
                  and i.p080=t.p080_b
                  and t.ob22_b is null  and s.nls like '8%'
             )
   LOOP
     begin
         dk_:= 0; S_ :=-k.OSTF; nms8_:=nms8a_; nls8_:=nls8a_; acc8_:=acc8a_;
         savepoint  do_nal8_0_3g4;
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
         exception when others then rollback to do_nal8_0_3g4;
      end;
   END LOOP;*/
update fdat set stat=stat_ where fdat=dat1_;
gl.bDATE:= dat_tek;
commit;
END nal8_0_ob22;
/
show err;

PROMPT *** Create  grants  NAL8_0_OB22 ***
grant EXECUTE                                                                on NAL8_0_OB22     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NAL8_0_OB22     to NALOG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NAL8_0_OB22.sql =========*** End *
PROMPT ===================================================================================== 
