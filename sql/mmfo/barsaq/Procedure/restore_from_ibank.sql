

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Procedure/RESTORE_FROM_IBANK.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RESTORE_FROM_IBANK ***

  CREATE OR REPLACE PROCEDURE BARSAQ.RESTORE_FROM_IBANK 
is
    /*
        ��������� ��� �������������� ������ � ����� BARSAQ ��� ����
        �� ������ � ����� BANK ��������-��������

        �����! ������ � ����� BARSAQ ����� ������� ������������!

    */
begin
    -- ������ ��������� �������
    delete
      from ibank_rnk;
    delete
      from ibank_acc;
    -- ��������� �������
    execute immediate
    'insert
      into ibank_rnk(kf, rnk)
    select bank_id, rnk
      from ibank.v_customers2';
    --
    execute immediate
    'insert
      into ibank_acc(kf, acc)
    select a.kf, a.acc
      from ibank.v_accounts2 c, barsaq.v_kf_accounts a
     where a.kf = c.bank_id
       and a.nls = c.acc_num
       and a.kv = c.cur_id';
   --
end restore_from_ibank;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Procedure/RESTORE_FROM_IBANK.sql =========
PROMPT ===================================================================================== 
