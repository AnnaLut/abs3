

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_SOS_SSR.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_OPER_SOS_SSR ***

  CREATE OR REPLACE TRIGGER BARS.TU_OPER_SOS_SSR 
   bEFORE UPDATE OF sos ON BARS.OPER
FOR EACH ROW
    WHEN (
OLD.sos>0 AND
      NEW.sos<0 AND
      OLD.TT ='SSR'
      -- ������� �� ����� �������
      --and OLD.nlsb like '2906%' and OLD.nlsa like '2906%'
      ) DECLARE
-- �������������� ������� ����������� (�����) �� ������ � ���� (��� ���) � ���
   p_DBCODE varchar2(160); -- ��� �������          � �� �� DB_LINK
   L_DBCODE int;           -- �������� ����� ���a �������
   p_NSC    varchar(160) ; -- � ����� (����������) � �� �� DB_LINK
   L_NSC    int;           -- �������� ����� � ����� (����������)

   p_REF int; --��� ���������� ���������

BEGIN
   --��� ���������� ���������
   p_REF := :OLD.REF;

   -- � ����� (����������)
   p_NSC  := fun_GetNSC    (:OLD.nazn);   L_NSC   := Nvl(length(p_NSC   ),0);
   If L_NSC <1 OR L_NSC >19 then
      RAISE_APPLICATION_ERROR (-20001, '��.� �����');
   end if;

   p_DBCODE:= fun_GetDBCODE(:OLD.nazn);   L_DBCODE:= Nvl(length(p_DBCODE),0);
   If L_DBCODE <1 OR L_DBCODE >11 then
      RAISE_APPLICATION_ERROR (-20001, '��.DBCODE');
   end if;

   -- ������� ����� � �����������
   execute immediate
        'begin USSR_PAYOFF.payoff_back@DEPDB(:p_REF, :p_DBCODE, :p_NSC); end;'
             using p_ref, p_dbcode, p_nsc;

   -- ������������� ������ ����������
   execute immediate
        'update accounts@DEPDB a
         set a.blkd=0, a.blkk=0
         where a.acc=(select d.acc
                      from dpt_deposit@DEPDB d,
                           DPT_PAYMENTS_EXT@DEPDB e
                      where e.EXT_REF=' || p_ref || '
                        and e.TRANSH_ID=-1
                        and e.FL_ADDNUM<0
                        and e.dpt_id=d.deposit_id)';

END tu_OPER_SOS_SSR;


/
ALTER TRIGGER BARS.TU_OPER_SOS_SSR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_SOS_SSR.sql =========*** End
PROMPT ===================================================================================== 
