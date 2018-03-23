begin
  EXECUTE IMMEDIATE 
   'ALTER TABLE BARS.REZ_PAR_9200 DROP PRIMARY KEY CASCADE';
 exception when others then
  -- ORA-02260:  Cannot drop nonexistent primary key
  if SQLCODE = -02441 then null;   else raise; end if; 
end;
/

begin
  EXECUTE IMMEDIATE 
 'ALTER TABLE REZ_PAR_9200 ADD (CONSTRAINT PK_REZ_PAR_9200 PRIMARY KEY (fdat,RNK,ND))';
exception when others then
  -- ORA-02260: table can have only one primary key
  if SQLCODE = -02260 then null;   else raise; end if; 
end;
/
