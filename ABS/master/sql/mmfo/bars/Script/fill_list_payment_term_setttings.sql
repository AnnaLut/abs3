begin
    list_utl.cor_list(smb_deposit_utl.DEPOSIT_PAYMENT_TERM_CODE, '����������� ������� �������');
    list_utl.cor_list_item(smb_deposit_utl.DEPOSIT_PAYMENT_TERM_CODE, smb_deposit_utl.PAYMENT_TERM_MONTHLY_ID, 'PAYMENT_TERM_MONTHLY', '��������');
    list_utl.cor_list_item(smb_deposit_utl.DEPOSIT_PAYMENT_TERM_CODE, smb_deposit_utl.PAYMENT_TERM_QUARTERLY_ID, 'PAYMENT_TERM_QUARTERLY', '������������');
    list_utl.cor_list_item(smb_deposit_utl.DEPOSIT_PAYMENT_TERM_CODE, smb_deposit_utl.PAYMENT_TERM_EOT_ID, 'PAYMENT_TERM_EOT', '� ���� ������');
    commit;
end;
/
