

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCOUNTSW.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCOUNTSW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCOUNTSW'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACCOUNTSW'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCOUNTSW ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCOUNTSW 
   (	ACC NUMBER(38,0), 
	TAG VARCHAR2(8), 
	VALUE VARCHAR2(254), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCOUNTSW ***
 exec bpa.alter_policies('ACCOUNTSW');


COMMENT ON TABLE BARS.ACCOUNTSW IS 'Хранилище значений доп.параметров счета';
COMMENT ON COLUMN BARS.ACCOUNTSW.ACC IS 'ACC счета';
COMMENT ON COLUMN BARS.ACCOUNTSW.TAG IS 'Код доп.параметра';
COMMENT ON COLUMN BARS.ACCOUNTSW.VALUE IS 'Значение доп.параметра';
COMMENT ON COLUMN BARS.ACCOUNTSW.KF IS '';




PROMPT *** Create  constraint FK_ACCOUNTSW_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSW ADD CONSTRAINT FK_ACCOUNTSW_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSW_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSW ADD CONSTRAINT FK_ACCOUNTSW_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSW_ACCOUNTSFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSW ADD CONSTRAINT FK_ACCOUNTSW_ACCOUNTSFIELD FOREIGN KEY (TAG)
	  REFERENCES BARS.ACCOUNTS_FIELD (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCOUNTSW ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSW ADD CONSTRAINT PK_ACCOUNTSW PRIMARY KEY (ACC, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSW_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSW MODIFY (KF CONSTRAINT CC_ACCOUNTSW_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint CC_ACCOUNTSW_TAG ***
begin
  execute immediate 'alter table accountsw
  add constraint accountsw_tag
  check ((tag IN (''INTRT'',''ND_REST'') and (txt between 0 and 100 or tag is null)) or value not IN (''INTRT'',''ND_REST''))';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/

PROMPT *** Create  index PK_ACCOUNTSW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCOUNTSW ON BARS.ACCOUNTSW (ACC, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCOUNTSW ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTSW       to ACCOUNTSW;
grant SELECT                                                                 on ACCOUNTSW       to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTSW       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCOUNTSW       to BARS_DM;
grant SELECT                                                                 on ACCOUNTSW       to BARS_SUP;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTSW       to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTSW       to OBPC;
grant SELECT                                                                 on ACCOUNTSW       to RPBN001;
grant SELECT                                                                 on ACCOUNTSW       to START1;
grant SELECT                                                                 on ACCOUNTSW       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACCOUNTSW       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCOUNTSW.sql =========*** End *** ===
PROMPT ===================================================================================== 
