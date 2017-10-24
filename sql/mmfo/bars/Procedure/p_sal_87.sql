

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SAL_87.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SAL_87 ***

  CREATE OR REPLACE PROCEDURE BARS.P_SAL_87 (dd_ date,datf_ date)
/*
 процедура для раскрытия 8-го класса счетов ОБ
 для перехода на общесистемный налучет
 разворачиваем заданной датой dd_, по состоянию 87 файла на дату datf_
*/
is
  Dat_tek DATE;          dat_sv  DATE;          nlsks6_   varchar2(15); nlsks7_   varchar2(15);
  ref_ int;              dk_ int;               dat_ date;    dat1_ date;
  S_ number;             nazn_ varchar2(160);
  nls8_   varchar2(15);  nls8a_  varchar2(15);  nls8p_  varchar2(15);
  nms8_   varchar2(38);  nms8a_  varchar2(38);  nms8p_  varchar2(38);
  acc8_   int         ;  acc8a_  int         ;  acc8p_  int         ;
  mfo_   varchar2(12);   user_   int;  pap_ int;  stat_ number;

Begin
    Dat_tek:=GL.bdate; -- СОХРАНЕНИЕ ТЕК ДАТЫ
    select val into nlsks6_ from params where par='NU_KS6';
    select val into nlsks7_ from params where par='NU_KS7';
nazn_:= 'Розкриття залишків на рахунках Подат.облiку згідно даних 87 файла за '||to_char(datf_,'dd-mm-yyyy')||
        ' в звя`зку з впровадженням нового АРМа';
    begin
      select f_ourmfo into mfo_ from dual;
      EXCEPTION WHEN NO_DATA_FOUND THEN  goto kin;
    end;
    user_:= USER_ID;
-- счет для разворачивания акт.(NU_KS6)
   nls8a_  := nlsks6_;
   begin
     select acc, substr(nms,1,38) into acc8a_, nms8a_
     from accounts where kv=980 and nls=nls8a_;
     EXCEPTION WHEN NO_DATA_FOUND THEN    goto kin;
   end ;

-- счет для разворачивания  пас.(NU_KS7)
    nls8p_  := nlsks7_;
    begin
     select acc, substr(nms,1,38) into acc8p_, nms8p_
     from accounts where kv=980 and nls=nls8p_;
     EXCEPTION WHEN NO_DATA_FOUND THEN    goto kin;
   end ;
-------------------------

dat_    := dd_;
GL.bdate:=dat_;
FOR k in (
     select substr(t.kodp,1,1) DK,
     t.znap ost,
     a.nls ,substr(a.nms,1,38) nms,a.acc
 from tmp_irep t,accounts a,specparam_int s
where  t.kodf='87'
   and t.datf= datf_
   and substr(t.kodp,1,1) in ('1','2')
   and a.acc=s.acc(+)
   and s.p080=substr(t.kodp,2,4)
   and s.ob22=substr(t.kodp,10,2)
   and s.r020_fa=substr(t.kodp,6,4)
   and a.dazs is null
   and (a.ostc is null or a.ostc=0) --and.acc not in (220081)
   order by dk, p080
 )
LOOP
       if   k.DK ='2' then   -- витрати (пасив 8 клас)
            dk_:= 0;   S_ := k.OST;  nms8_:=nms8p_;  nls8_:=nls8p_;  acc8_:=acc8p_;
      elsif k.DK ='1' then      -- доходи   (актив 8 клас)
            dk_:= 1;   S_ := k.OST;  nms8_:=nms8a_;  nls8_:=nls8a_;  acc8_:=acc8a_;
      end if;
      gl.ref (ref_);
      INSERT INTO oper
             (ref, tt, vob, nd, dk, pdat, vdat, datd, userid,
              nam_a,nlsa, mfoa, nam_b, nlsb, mfob, kv, s, nazn )
      VALUES
             (ref_ , 'PO1', 6, ref_, dk_, dat_, dat_, dat_, user_,
             k.NMS, k.NLS, mfo_, nms8_, nls8_, mfo_, 980, S_, nazn_ );
      gl.pay2( NULL,ref_,dat_,'PO1',980,1-dk_,k.ACC,  S_, S_, 1,nazn_);
      gl.pay2( NULL,ref_,dat_,'PO1',980,dk_  ,ACC8_,  S_, S_, 0,nazn_);
      gl.pay2( 2,   ref_,dat_);
END LOOP;
<<kin>> NULL;
gl.bDATE:= dat_tek;
commit;
END p_sal_87;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SAL_87.sql =========*** End *** 
PROMPT ===================================================================================== 
