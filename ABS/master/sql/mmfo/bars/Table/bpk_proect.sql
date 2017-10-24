

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_PROECT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_PROECT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_PROECT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BPK_PROECT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BPK_PROECT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_PROECT ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_PROECT 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(100), 
	OKPO VARCHAR2(10), 
	PRODUCT_CODE VARCHAR2(30), 
	OKPO_N NUMBER(22,0), 
	USED_W4 NUMBER(22,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_PROECT ***
 exec bpa.alter_policies('BPK_PROECT');


COMMENT ON TABLE BARS.BPK_PROECT IS '';
COMMENT ON COLUMN BARS.BPK_PROECT.ID IS '';
COMMENT ON COLUMN BARS.BPK_PROECT.NAME IS '';
COMMENT ON COLUMN BARS.BPK_PROECT.OKPO IS '';
COMMENT ON COLUMN BARS.BPK_PROECT.PRODUCT_CODE IS '';
COMMENT ON COLUMN BARS.BPK_PROECT.OKPO_N IS 'Код системной организациим';
COMMENT ON COLUMN BARS.BPK_PROECT.USED_W4 IS 'Используется для Way4';
COMMENT ON COLUMN BARS.BPK_PROECT.KF IS '';




PROMPT *** Create  constraint PK_BPKPROECT ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PROECT ADD CONSTRAINT PK_BPKPROECT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPROECT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PROECT MODIFY (KF CONSTRAINT CC_BPKPROECT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPKPROECT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PROECT ADD CONSTRAINT FK_BPKPROECT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPROECT_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PROECT MODIFY (ID CONSTRAINT CC_BPKPROECT_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKPROECT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKPROECT ON BARS.BPK_PROECT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_PROECT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BPK_PROECT      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_PROECT      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_PROECT      to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_PROECT      to OBPC;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_PROECT      to OW;
grant FLASHBACK,SELECT                                                       on BPK_PROECT      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_PROECT.sql =========*** End *** ==
PROMPT ===================================================================================== 
