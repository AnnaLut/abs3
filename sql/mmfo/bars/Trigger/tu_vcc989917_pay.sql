

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
								then  raise_application_error(-20003,'\9999     ���� ������� ��������� ���� ����� -'||:new.s);
								else  opr.s := :new.s*100;
								end if;


                                begin
                                        select substr(nms,1,38)  into opr.nam_a  from accounts
                                        where nls = :old.nlsa and kv = gl.baseval and dazs is null;
                                      exception when no_data_found then
                                        raise_application_error(-20004,'�� �������� ���.'||:old.nlsa||'  :'||:new.VA_KC );
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
                                            nazn_  => substr('������� � ������� '||:old.va_kc||' �� ���:'||:old.nd||' '||:old.fio||' ����� '||:old.branch , 1,159),
                                            d_rec_ => null,
                                            id_a_  => gl.aOkpo ,
                                            id_b_  => gl.aOkpo ,
                                            id_o_  => null,
                                            sign_  => null,
                                            sos_   => 1,
                                            prty_  => null,
                                            uid_   => null);

                                   paytt (  flg_  => 0,          -- ���� ������
                                            ref_  => opr.REF,    -- ����������
                                            datv_ => gl.bdate,   -- ���� ������������
                                            tt_   =>'VS3',     -- ��� ����������
                                            dk0_  => 0,          -- ������� �����-������
                                            kva_  => gl.baseval, -- ��� ������ �
                                            nls1_ =>:old.nlsb,   -- ����� ����� �
                                            sa_   => opr.s,      -- ����� � ������ �
                                            kvb_  => gl.baseval, -- ��� ������ �
                                            nls2_ => :old.nlsa  ,  -- ����� ����� �
                                            sb_   => opr.s    -- ����� � ������ �
                                           );

                                update CC_989917_REF
                                  set ref2 = opr.REF
                                    where ref1 = :old.ref1;

          else

            raise_application_error(-(20001),'\9999      REF: '||:old.ref1||'  �������� ��� �������������� ���: '||:old.ref2,TRUE);

          end if;


  else

  raise_application_error(-(20002),'\9999    REF: '||:old.ref1||' �������� ������ ���������',TRUE);
  end if;




end;
/
ALTER TRIGGER BARS.TU_VCC989917_PAY ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_VCC989917_PAY.sql =========*** En
PROMPT ===================================================================================== 
