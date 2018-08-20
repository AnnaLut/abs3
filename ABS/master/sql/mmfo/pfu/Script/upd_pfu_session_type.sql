begin
Insert into PFU.PFU_SESSION_TYPE
   (ID, SESSION_TYPE_CODE, SESSION_TYPE_NAME, PFU_METHOD_CODE)
 Values
   (28, 'REQ_EPP_MATCHING2', 'Відправка квитанції про розбір реєстру ЕПП 2', 'put_epp_packet_bnk_state2');
 exception when dup_val_on_index then null;
COMMIT;
end;
/
