begin 
   insert into params$global ( PAR, VAL, COMM, SRV_FLAG) values ('XOZ_NEW', 1, '����� ������ ������������ ��������',0 );
   commit;
exception when others then
   if SQLCODE = -00001 then NULL;   else raise; end if;
end;
/
