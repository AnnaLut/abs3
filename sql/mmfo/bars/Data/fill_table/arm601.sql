begin
Insert into BARS.operapp
   (CODEAPP, CODEOPER, APPROVE, REVOKED, GRANTOR)
 Values
   ('$RM_F601', 3381, 1, 0, 1);
COMMIT;
exception when others then null;
end;
/