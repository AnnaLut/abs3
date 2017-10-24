

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_OPER_VISA.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_OPER_VISA ***

  CREATE OR REPLACE TRIGGER BARS.TAI_OPER_VISA 
/*
 * ������� ��� ���������� ���������� �� ��������� ����
 * ��� ��������� (������ ���) ��� �������� ����������
 * author anny
 * V.1.9 (08.12.2011)
 */
for insert ON BARS.OPER_VISA  COMPOUND TRIGGER
l_tt oper.tt%type;

    Before each Row
    is
     begin

          begin
           select tt into l_tt from oper where ref = :new.REF;
          exception
            when no_data_found then null;
          end;

          if
              :new.status  = 0 and l_tt = 'AA6'
               and CHK.GETNEXTVISAGROUP(:new.REF,  CHK.GETNEXTVISAGROUP(:new.REF,  lpad(lpad(chk.to_hex(:new.groupid),2,'0'),2,'0'))    )  = '!!'
               then
               :new.status := 2;

          end if;

         end
    Before each Row;

    After each Row
    is
        begin
          begin
           select tt into l_tt from oper where ref = :new.REF;
          exception
            when no_data_found then null;
          end;

          if
              :new.status  = 0 and l_tt = 'AA6'
               and CHK.GETNEXTVISAGROUP(:new.REF,  CHK.GETNEXTVISAGROUP(:new.REF,  lpad(lpad(chk.to_hex(:new.groupid),2,'0'),2,'0'))    )  = '!!'
               then

                bars_cash.enque_ref(:new.ref, :new.userid);
                if bars_cash.G_ISUSECASH = 1 and bars_cash.G_CURRSHIFT = 0 then
                 -- ��i�� �� �� ���� ��������
                 bars_cash.open_cash(p_shift => 1, p_force => 1);
              end if;

          end if;

           if :new.status  = 0  or          -- ������ (�����������)
              :new.groupid = 77 or          -- ��������� ������.
              :new.groupid = 80 or          -- from params where par = 'NU_CHCK'   (��������� ����)
              :new.groupid = 81 or          -- from params where par = 'NU_CHCKN'  (��������� ����)
              :new.groupid = 30 or          -- �������� ������ ����������� ��� �������� � �����������
              :new.groupid = 94 then null;  -- ��������� ��� �����

           else
           -- ��� ���������(����� ���� � �� ��������)
           -- ��� �������� (������� ��������� ��� ���)
           if :new.status = 2  or bars_cash.is_cashvisa(:new.groupid) = 1
               or (     lpad(lpad(chk.to_hex(:new.groupid),2,'0'),2,'0')= '05'
                    and CHK.GETNEXTVISAGROUP(:new.REF,  lpad(lpad(chk.to_hex(:new.groupid),2,'0'),2,'0')) = '07'
                    and CHK.GETNEXTVISAGROUP(:new.REF,  CHK.GETNEXTVISAGROUP(:new.REF,  lpad(lpad(chk.to_hex(:new.groupid),2,'0'),2,'0'))    )  = '!!'
                  )
               then

              bars_cash.enque_ref(:new.ref, :new.userid);
              -- ��� ������ � ������ � ������������ ��� - ����� ��������� ������� ��
              -- ����� � ������������ ���
              if bars_cash.G_ISUSECASH = 1 and bars_cash.G_CURRSHIFT = 0 then
                 -- ��i�� �� �� ���� ��������
                 bars_cash.open_cash(p_shift => 1, p_force => 1);
              end if;

           end if;

             end if;

        end
    After each Row;

end TAI_OPER_VISA;
/
ALTER TRIGGER BARS.TAI_OPER_VISA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_OPER_VISA.sql =========*** End *
PROMPT ===================================================================================== 
