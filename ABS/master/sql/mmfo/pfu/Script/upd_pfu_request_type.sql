begin
Insert into PFU.PFU_REQUEST_TYPE
   (ID, REQUEST_TYPE_CODE, REQUEST_TYPE_NAME)
 Values
   (12, 'PUT_EPP_PACKET_BNK_STATE_2', '��������� 2 (��� ���� ������ �� ��������� ������ ��� (��� ��, CardMake))');
exception when dup_val_on_index then null;
end;
/
COMMIT;

