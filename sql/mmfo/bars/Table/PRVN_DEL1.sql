PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_DEL1.sql =========*** Run *** ======
PROMPT ===================================================================================== 

exec bars.bpa.alter_policy_info( 'PRVN_DEL1', 'WHOLE' , null, null, null, null ); 
exec bars.bpa.alter_policy_info( 'PRVN_DEL1', 'FILIAL', null, null, null, null );

PROMPT *** Create  table PRVN_DEL1 ***

begin  EXECUTE IMMEDIATE 'CREATE TABLE bars.PRVN_DEL1 
( Dat01 date, 	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''),  
  tip  int   ,  nd  int   ,   vidd    int   ,  kv   int, 
  b1   number,  SDF number,   DEL_SDF number,
  B3   number,  SDM number,   DEL_SDM number,
  B5   number,  SDI number,   DEL_SDI number,
  B7   number,  SDA number,   DEL_SDA number,
  A9   number,  SNA number,   DEL_SNA number,
  I9   number,  SRR number,   DEL_SRR number)
  TABLESPACE BRSMDLD ' ;           
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/

exec  bars.bpa.alter_policies('PRVN_DEL1'); 

begin EXECUTE IMMEDIATE 'alter table PRVN_DEL1 add (q_SDF number,q_SDM number,q_SDI number,q_SDA number,q_SNA number,q_SRR number) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

begin EXECUTE IMMEDIATE 'alter table PRVN_DEL1 add (nmk varchar2(70)) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

begin EXECUTE IMMEDIATE 'alter table PRVN_DEL1 add (ndg number) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

PROMPT *** Create  constraint PRVN_DEL1 ***

begin    execute immediate ' ALTER TABLE bars.PRVN_DEL1 drop CONSTRAINT XPK_PRVNDEL1 '; 
exception when others then  if  sqlcode = -02443  then null;   else raise; end if;   --    ORA-02443: Cannot drop constraint  - nonexistent constraint
end;
/

PROMPT *** Create  grants  PRVN_DEL1 ***
grant SELECT,UPDATE                                                          on PRVN_DEL1       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_DEL1       to BARS_DM;
grant SELECT,UPDATE                                                          on PRVN_DEL1       to START1;
grant SELECT                                                                 on PRVN_DEL1       to UPLD;

