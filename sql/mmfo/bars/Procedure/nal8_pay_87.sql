

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NAL8_PAY_87.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NAL8_PAY_87 ***

  CREATE OR REPLACE PROCEDURE BARS.NAL8_PAY_87 (par_dat_ date)
/*
 процедура отражения состояния 87 файла от филиалов  после миграции
 (запускать  предполагается локальной банковской датой соотв. дате миграции
 предварительно файл нужно заимпортировать через ф-ю "Отчетность НБУ (польз 20094)"

 версия 08-06-2011 - после отладки в Черкассах
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
  l_pap number:=3;
  l_rnk number;
  l_tmp    integer:=null;
  l_acc    accounts.acc%type:=null;
  l_branch accounts.branch%type:=substr(SYS_CONTEXT('bars_context','user_branch_mask'),1,8);
  l_nls varchar2(15);
  l_nms varchar2(38);

MODCODE   constant varchar2(3) := 'NAL';

Begin
    stat_:=null;
    dat1_:=par_dat_ ;
    begin
--   проверим дату
     select fdat,stat
      into dat_sv,stat_
      from fdat
      where fdat=dat1_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN     --- здесь сообщение, что дата закрыта
        insert into fdat (FDAT,stat) values (dat1_,null);
    end;
-- делаем день доступным для работы
    if stat_ is not null then
       update fdat set stat=null where fdat=dat1_;
    end if;
    Dat_tek:=GL.bdate; -- СОХРАНЕНИЕ ТЕК ДАТЫ
    dat_sv:=dat1_;
-- счет валовых для активных и пасс. остатков
 select val into nls_8020_01 from params where par='NU_KS7'; -- для пассивов(активный)
 select val into nls_8020_02 from params where par='NU_KS6'; -- для активов (пассивный)

bars_audit.info('nal1 '||nls_8020_01||' '||nls_8020_02);

  begin
      select f_ourmfo into mfo_ from dual;
      EXCEPTION WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(MODCODE, 'NAL_OURMFO');
  end;

  for n in (
    select count(*) kk,mfo
     from  RNBU_IN_FILES f
     where file_name like ('@87%')
     and   exists (select 1
                     from rnbu_in_inf_records
                    where file_id=f.file_id
                      and substr(parameter,1,1)in ('1','2'))
     group by mfo)
  loop
     if n.kk>1 then    null;
       ---- !!!
        --  сообщ о том что обнаружено более 1 необработанного файла для мфо
        -- выход на ошибку
        -- заполнить справочник данными по "двойным файлам"
        -- переход на конец - дальше не обрабатываем
      end if;
  end loop;
  user_:= USER_ID;
  dat_    := dat_sv ;
  GL.bdate:=dat_;

-- сначала все активы
   nls8a_  := nls_8020_02;  -- контрсчет пассивный
bars_audit.info('nls_8020_02 '||nls_8020_02);
   begin
     select acc, substr(nms,1,38) into acc8a_, nms8a_
     from accounts where kv=980 and nls=nls8a_ and (dazs is null or dazs>gl.bd);
     EXCEPTION WHEN NO_DATA_FOUND THEN
     bars_error.raise_nerror(MODCODE, 'NAL_NU_KS6');
   end ;
   FOR k in (
     select init_date,last_date,file_id, mfo,  record_id, p080, r020_fa, ob22,s OST,kod
      from   v_fil_87
      where  pap=1
          )
   LOOP
      begin
         savepoint do_nal8_pay_871;
         gl.ref (ref_);

         nazn_:= 'Коригування показника згiдно файлу 87 фiлiї '||k.mfo||' - пiсля мiграцiї';
         dk_:= 0; S_ :=k.OST; nms8_:=nms8a_; nls8_:=nls8a_; acc8_:=acc8a_;

         -- подберем счет куда проводить
         -- если счет не нашли - показатель пропускаем
         l_acc:=0;
         l_nls:=null;
         l_nms:=null;
         begin
         select  a.acc,a.nls, substr(a.nms,1,38)
           into  l_acc, l_nls, l_nms
           from  accounts a, specparam_int i, sb_p0853 p
          where a.acc=i.acc
            and a.nls like '8____11%'
            and a.kv=980
            and a.dazs is null
            and (p.d_close is null or p.d_close>gl.bd)
            and  a.nbs=p.r020
            and  i.p080=p.p080
            and  i.r020_fa=p.r020_fa
            and  i.ob22=p.ob22
            and  i.p080=k.p080
            and  i.r020_fa=k.r020_fa
            and  i.ob22=k.ob22;
         exception when no_data_found then null;
         end;
         if   nvl(l_acc,0)>0  then
               INSERT INTO oper
                  (ref, tt, vob, nd, dk, pdat, vdat, datd, userid,
                   nam_a,nlsa, mfoa, nam_b, nlsb, mfob, kv, s, nazn )
               VALUES
                 (ref_ , 'PO1', 6, ref_, 1-dk_, dat_, dat_, dat_, user_,
                  l_NMS, l_NLS,  mfo_, nms8_, nls8_, mfo_, 980, S_, nazn_ );
               gl.pay2( NULL,ref_,dat_,'PO1',980, dk_,   l_ACC,  S_, S_,1, nazn_);
               gl.pay2( NULL,ref_,dat_,'PO1',980, 1-dk_  ,ACC8_,  S_, S_,0, nazn_);
               gl.pay2( 2,   ref_,dat_);

               update rnbu_in_inf_records
                  set  parameter='9'||substr(parameter,2,length(parameter)-1)
                where file_id=k.file_id
                  and  record_id=k.record_id;
         end if;
         exception
               when others then rollback to do_nal8_pay_871;

      end;
   END LOOP;
   commit;
-- потом все пассивы
   nls8p_  := nls_8020_01;  -- контрсчет
bars_audit.info('nls_8020_01 '||nls_8020_01);
   begin
     select acc, substr(nms,1,38) into acc8p_, nms8p_
     from accounts where kv=980 and nls=nls8p_ and dazs is null;
     EXCEPTION WHEN NO_DATA_FOUND THEN
     bars_error.raise_nerror(MODCODE, 'NAL_NU_KS7');
   end ;
   FOR k in (
       -- выборка суммы из файла - пассивы
     select init_date,last_date,file_id, mfo,  record_id, p080, r020_fa, ob22,s OST, kod
      from   v_fil_87
      where  pap=2
          )
   LOOP
     begin
         savepoint do_nal8_pay_872;
         gl.ref (ref_);

         nazn_:= 'Коригування показника згiдно файлу 87 фiлiї '||k.mfo||' - пiсля мiграцiї';
         dk_:= 1; S_ :=k.OST; nms8_:=nms8p_; nls8_:=nls8p_; acc8_:=acc8p_;

         l_acc:=0;
         l_nls:=null;
         l_nms:=null;

         begin
         select  a.acc,a.nls, substr(a.nms,1,38)
           into  l_acc, l_nls, l_nms
           from  accounts a, specparam_int i, sb_p0853 p
          where a.acc=i.acc
            and a.nls like '8____11%'
            and a.kv=980
            and a.dazs is null
            and (p.d_close is null or p.d_close>gl.bd)
            and  a.nbs=p.r020
            and  i.p080=p.p080
            and  i.r020_fa=p.r020_fa
            and  i.ob22=p.ob22
            and  i.p080=k.p080
            and  i.r020_fa=k.r020_fa
            and  i.ob22=k.ob22;
         exception when no_data_found then null;
         end;
         if   nvl(l_acc,0)>0  then
               INSERT INTO oper
                  (ref, tt, vob, nd, dk, pdat, vdat, datd, userid,
                   nam_a,nlsa, mfoa, nam_b, nlsb, mfob, kv, s, nazn )
               VALUES
                 (ref_ , 'PO1', 6, ref_, dk_, dat_, dat_, dat_, user_,
               nms8_, nls8_, mfo_, l_NMS , l_nls, mfo_, 980, S_, nazn_ );
               gl.pay2( NULL,ref_,dat_,'PO1',980, 1-dk_,ACC8_,  S_, S_,1, nazn_);
               gl.pay2( NULL,ref_,dat_,'PO1',980, dk_  ,l_ACC,  S_, S_,0, nazn_);
               gl.pay2( 2,   ref_,dat_);

               update rnbu_in_inf_records
                  set  parameter='8'||substr(parameter,2,length(parameter)-1)
                where file_id=k.file_id
                  and  record_id=k.record_id;
        end if;
        exception
             when others then rollback to do_nal8_pay_872;
       end;
   END LOOP;
   commit;
gl.bDATE:= dat_tek;
commit;
END nal8_pay_87;
/
show err;

PROMPT *** Create  grants  NAL8_PAY_87 ***
grant EXECUTE                                                                on NAL8_PAY_87     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NAL8_PAY_87     to NALOG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NAL8_PAY_87.sql =========*** End *
PROMPT ===================================================================================== 
