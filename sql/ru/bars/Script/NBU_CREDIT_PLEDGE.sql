begin 
update BARSTRANS.TRANSP_SEND_TYPE  set type_name='NBU_CREDIT_PLEDGE' where id=17;
commit;
end;
/
begin 
update BARSTRANS.TRANSP_RECEIVE_TYPE  set type_name='NBU_CREDIT_PLEDGE' where id=17;
commit;
end;
/