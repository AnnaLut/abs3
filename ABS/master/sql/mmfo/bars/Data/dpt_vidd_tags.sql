PROMPT ============================================================
PROMPT *** Run *** ========== new dpt_vidd_tag =========*** Run ***
PROMPT ============================================================

begin
    begin
      insert into dpt_vidd_tags values ('MIN_DEPBALANCE', '̳�. ����������� ������� �� ���.�������� �볺��� (� ���.)', 'Y', 'Y', null);
    exception when dup_val_on_index then
      null;
    end;
commit;      
end;
/  
 
PROMPT ============================================================
PROMPT *** End *** ========== new dpt_vidd_tag =========*** End ***
PROMPT ============================================================
