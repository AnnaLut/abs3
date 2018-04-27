begin

     execute immediate 'begin bpa.alter_policy_info(''REZ_PAR_9200'', ''WHOLE'' , null , null, null, null ); end;'; 
     execute immediate 'begin bpa.alter_policy_info(''REZ_PAR_9200'', ''FILIAL'', null , null, null, null ); end;';

     EXECUTE IMMEDIATE 'create table BARS.REZ_PAR_9200'||
      '(rnk     integer,
        nd      integer,
        fin     number,
        VKR     VARCHAR2(3),
        PD      number)
        tablespace BRSMDLD';

exception when others then
  -- ORA-00955: name is already used by an existing object
  if SQLCODE = -00955 then null;   else raise; end if; 
end;
/

begin
  if getglobaloption('HAVETOBO') = 2 then    
     execute immediate 'begin   bpa.alter_policies(''REZ_PAR_9200''); end;'; 
   end if;
end;
/
commit;
-------------------------------------------------------------
COMMENT ON TABLE  BARS.REZ_PAR_9200         IS 'Параметри рахунків';
COMMENT ON COLUMN BARS.REZ_PAR_9200.rnk     IS 'РНК';
COMMENT ON COLUMN BARS.REZ_PAR_9200.nd      IS 'Реф договора';
COMMENT ON COLUMN BARS.REZ_PAR_9200.fin     IS 'Клас контрагента';
COMMENT ON COLUMN BARS.REZ_PAR_9200.pd      IS 'Значення коефіцієнту імовірності дефолту ';
COMMENT ON COLUMN BARS.REZ_PAR_9200.vkr     IS 'ВКР';

begin
 execute immediate   'alter table REZ_PAR_9200 add (COMM  varchar2(254)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_PAR_9200.COMM  IS 'Підстава';

begin
 execute immediate   'alter table REZ_PAR_9200 add (KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_PAR_9200.FDAT  IS 'Звітна дата';

begin
 execute immediate   'alter table REZ_PAR_9200 add (fDAT  DATE) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_PAR_9200.FDAT  IS 'Звітна дата';

begin
 execute immediate   'alter table REZ_PAR_9200 add (NOT_LIM  number(1)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_PAR_9200.NOT_LIM  IS 'Банк має право відмовитися від виконання зобов’язання';

PROMPT *** Create  index PK_REZ_PAR_9200 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZ_PAR_9200 ON BARS.REZ_PAR_9200 (FDAT, RNK, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  -- ORA-02260: table can have only one primary key
  if sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 or sqlcode=-955 or sqlcode=-6512 then null;   else raise; end if; 
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

GRANT SELECT ON BARS.REZ_PAR_9200 TO RCC_DEAL;
GRANT SELECT ON BARS.REZ_PAR_9200 TO START1;
GRANT SELECT ON BARS.REZ_PAR_9200 TO BARS_ACCESS_DEFROLE;

COMMIT;

