

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_VCC989917_PAY.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_VCC989917_PAY ***

  CREATE OR REPLACE TRIGGER BARS.TU_VCC989917_PAY 
instead of update ON BARS.V_CC_989917 for each row
declare
  opr oper%rowtype;
  ref_sos_ number;

begin

if :old.opl = 0 and :new.opl = 1
--:old.otm = bitand (nvl (:old.otm, 0), 253) + 2 and :new.otm = 0
  then
          begin
          select 1
           into ref_sos_
            from oper
              where ref = :old.ref2
              and sos >= 0;
          exception when NO_DATA_FOUND then ref_sos_ := 2;
          end;

          if ref_sos_ = 2 then


								if mod(:new.s,1) > 0
								then  raise_application_error(-20003,'\9999     Сума повинна становити ціле число -'||:new.s);
								else  opr.s := :new.s*100;
								end if;


                                begin
                                        select substr(nms,1,38)  into opr.nam_a  from accounts
                                        where nls = :old.nlsa and kv = gl.baseval and dazs is null;
                                      exception when no_data_found then
                                        raise_application_error(-20004,'Не знайдено рах.'||:old.nlsa||'  :'||:new.VA_KC );
                                      end;

                                  gl.ref (opr.REF);

                                  gl.in_doc3(ref_  => opr.REF,
                                            tt_    => 'VS3' ,
                                            vob_   => 180,
                                            nd_    => substr(to_char(opr.REF),1,10),
                                            pdat_  => SYSDATE ,
                                            vdat_  => gl.BDATE,
                                            dk_    => 0,
                                            kv_    => gl.baseval,
                                            s_     => opr.s,
                                            kv2_   => gl.baseval,
                                            s2_    => opr.s,
                                            sk_    =>  null ,
                                            data_  => gl.bdate ,
                                            datp_  => gl.bdate ,
                                            nam_a_ => :old.nam_b,
                                            nlsa_  => :old.nlsb ,
                                            mfoa_  => gl.aMfo  ,
                                            nam_b_ => opr.nam_a,
                                            nlsb_  => :old.nlsa ,
                                            mfob_  => gl.aMfo  ,
                                            nazn_  => substr('Внесено в сховище '||:old.va_kc||' КД Реф:'||:old.nd||' '||:old.fio||' бранч '||:old.branch , 1,159),
                                            d_rec_ => null,
                                            id_a_  => gl.aOkpo ,
                                            id_b_  => gl.aOkpo ,
                                            id_o_  => null,
                                            sign_  => null,
                                            sos_   => 1,
                                            prty_  => null,
                                            uid_   => null);

                                   paytt (  flg_  => 0,          -- флаг оплаты
                                            ref_  => opr.REF,    -- референция
                                            datv_ => gl.bdate,   -- дата валютировния
                                            tt_   =>'VS3',     -- тип транзакции
                                            dk0_  => 0,          -- признак дебет-кредит
                                            kva_  => gl.baseval, -- код валюты А
                                            nls1_ =>:old.nlsb,   -- номер счета А
                                            sa_   => opr.s,      -- сумма в валюте А
                                            kvb_  => gl.baseval, -- код валюты Б
                                            nls2_ => :old.nlsa  ,  -- номер счета Б
                                            sb_   => opr.s    -- сумма в валюте Б
                                           );

                                update CC_989917_REF
                                  set ref2 = opr.REF
                                    where ref1 = :old.ref1;

          else

            raise_application_error(-(20001),'\9999      REF: '||:old.ref1||'  документ був оприбуткований РЕФ: '||:old.ref2,TRUE);

          end if;


  else

  raise_application_error(-(20002),'\9999    REF: '||:old.ref1||' повторна оплата документа',TRUE);
  end if;




end;
/
ALTER TRIGGER BARS.TU_VCC989917_PAY ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_VCC989917_PAY.sql =========*** En
PROMPT ===================================================================================== 
