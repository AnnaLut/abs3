

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_ACCOUNTS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_ACCOUNTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_ACCOUNTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ACCOUNTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_ACCOUNTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_ACCOUNTS 
   (	CP_REF NUMBER, 
	CP_ACCTYPE VARCHAR2(5), 
	CP_ACC NUMBER, 
	OSTC NUMBER, 
	OSTCR NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_ACCOUNTS ***
 exec bpa.alter_policies('CP_ACCOUNTS');


COMMENT ON TABLE BARS.CP_ACCOUNTS IS '������� �����';
COMMENT ON COLUMN BARS.CP_ACCOUNTS.CP_REF IS '������������� �����';
COMMENT ON COLUMN BARS.CP_ACCOUNTS.CP_ACCTYPE IS '��� �������';
COMMENT ON COLUMN BARS.CP_ACCOUNTS.CP_ACC IS '������������� �������';
COMMENT ON COLUMN BARS.CP_ACCOUNTS.OSTC IS '';
COMMENT ON COLUMN BARS.CP_ACCOUNTS.OSTCR IS '';




PROMPT *** Create  constraint FK_CP_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCOUNTS ADD CONSTRAINT FK_CP_REF FOREIGN KEY (CP_REF)
	  REFERENCES BARS.CP_DEAL (REF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCOUNTS ADD CONSTRAINT FK_CP_ACC FOREIGN KEY (CP_ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_ACCOUNTSTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCOUNTS ADD CONSTRAINT FK_CP_ACCOUNTSTYPES FOREIGN KEY (CP_ACCTYPE)
	  REFERENCES BARS.CP_ACCTYPES (TYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_CP_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCOUNTS ADD CONSTRAINT XPK_CP_ACCOUNTS PRIMARY KEY (CP_REF, CP_ACCTYPE, CP_ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002856192 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCOUNTS MODIFY (CP_ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002856191 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCOUNTS MODIFY (CP_ACCTYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002856190 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCOUNTS MODIFY (CP_REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_ACCOUNTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_ACCOUNTS ON BARS.CP_ACCOUNTS (CP_REF, CP_ACCTYPE, CP_ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_ACCOUNTS ***
grant SELECT                                                                 on CP_ACCOUNTS     to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ACCOUNTS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_ACCOUNTS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_ACCOUNTS.sql =========*** End *** =
PROMPT ===================================================================================== 
