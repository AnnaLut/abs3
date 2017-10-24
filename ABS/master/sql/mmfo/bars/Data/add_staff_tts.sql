begin
   insert into staff_tts (TT, ID, APPROVE, ADATE1, ADATE2, RDATE1, RDATE2, REVOKED, GRANTOR)
   values ('TOH', 2009401, 1, null, null, null, null, 0, 2009401);
   insert into staff_tts (TT, ID, APPROVE, ADATE1, ADATE2, RDATE1, RDATE2, REVOKED, GRANTOR)
   values ('TOH', 79001, 1, null, null, null, null, 0, 2009401);
   insert into staff_tts (TT, ID, APPROVE, ADATE1, ADATE2, RDATE1, RDATE2, REVOKED, GRANTOR)
   values ('TOH', 3633011, 1, null, null, null, null, 0, 2009401);
   insert into staff_tts (TT, ID, APPROVE, ADATE1, ADATE2, RDATE1, RDATE2, REVOKED, GRANTOR)
   values ('TOH', 3659100, 1, null, null, null, null, 0, 2009401);
exception when others then   if SQLCODE = -00001 then null;   else raise; end if;   --ORA-00001: unique constraint
end;
/
commit;