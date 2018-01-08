

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_ARSENAL_STR.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_ARSENAL_STR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_ARSENAL_STR'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BPK_ARSENAL_STR'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BPK_ARSENAL_STR'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_ARSENAL_STR ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_ARSENAL_STR 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(70), 
	OB22 VARCHAR2(2), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_ARSENAL_STR ***
 exec bpa.alter_policies('BPK_ARSENAL_STR');


COMMENT ON TABLE BARS.BPK_ARSENAL_STR IS 'БПК. Довідник страхових компаній';
COMMENT ON COLUMN BARS.BPK_ARSENAL_STR.KF IS '';
COMMENT ON COLUMN BARS.BPK_ARSENAL_STR.ID IS '№';
COMMENT ON COLUMN BARS.BPK_ARSENAL_STR.NAME IS 'Назва';
COMMENT ON COLUMN BARS.BPK_ARSENAL_STR.OB22 IS 'ОБ22';




PROMPT *** Create  constraint CC_BPKARSENALSTR_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ARSENAL_STR MODIFY (KF CONSTRAINT CC_BPKARSENALSTR_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BPKARSENALSTR ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ARSENAL_STR ADD CONSTRAINT PK_BPKARSENALSTR PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKARSENALSTR_OB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ARSENAL_STR ADD CONSTRAINT CC_BPKARSENALSTR_OB22 CHECK (ob22 in (''24'', ''29'', ''30'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPKARSENALSTR_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ARSENAL_STR ADD CONSTRAINT FK_BPKARSENALSTR_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKARSENALSTR_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ARSENAL_STR MODIFY (ID CONSTRAINT CC_BPKARSENALSTR_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_BPKARSENALSTR_OB22 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_BPKARSENALSTR_OB22 ON BARS.BPK_ARSENAL_STR (OB22, CASE  WHEN OB22 IS NULL THEN NULL ELSE KF END ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKARSENALSTR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKARSENALSTR ON BARS.BPK_ARSENAL_STR (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_ARSENAL_STR ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BPK_ARSENAL_STR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_ARSENAL_STR to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_ARSENAL_STR to OBPC;
grant FLASHBACK,SELECT                                                       on BPK_ARSENAL_STR to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_ARSENAL_STR.sql =========*** End *
PROMPT ===================================================================================== 
