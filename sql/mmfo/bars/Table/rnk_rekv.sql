

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNK_REKV.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNK_REKV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNK_REKV'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RNK_REKV'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''RNK_REKV'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNK_REKV ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNK_REKV 
   (	RNK NUMBER(38,0), 
	LIM_KASS NUMBER(24,0), 
	ADR_ALT VARCHAR2(70), 
	NOM_DOG VARCHAR2(10), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNK_REKV ***
 exec bpa.alter_policies('RNK_REKV');


COMMENT ON TABLE BARS.RNK_REKV IS 'Расширенные реквизиты клиента';
COMMENT ON COLUMN BARS.RNK_REKV.RNK IS 'Идентификатор клиента';
COMMENT ON COLUMN BARS.RNK_REKV.LIM_KASS IS '';
COMMENT ON COLUMN BARS.RNK_REKV.ADR_ALT IS '';
COMMENT ON COLUMN BARS.RNK_REKV.NOM_DOG IS 'Номер договора';
COMMENT ON COLUMN BARS.RNK_REKV.KF IS '';




PROMPT *** Create  constraint PK_RNKREKV ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNK_REKV ADD CONSTRAINT PK_RNKREKV PRIMARY KEY (KF, RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_RNKREKV_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNK_REKV ADD CONSTRAINT FK_RNKREKV_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_RNKREKV_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNK_REKV ADD CONSTRAINT FK_RNKREKV_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RNKREKV_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNK_REKV MODIFY (RNK CONSTRAINT CC_RNKREKV_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RNKREKV_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNK_REKV MODIFY (KF CONSTRAINT CC_RNKREKV_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RNKREKV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RNKREKV ON BARS.RNK_REKV (KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RNK_REKV ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RNK_REKV        to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNK_REKV        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNK_REKV        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNK_REKV        to CUST001;
grant SELECT                                                                 on RNK_REKV        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RNK_REKV        to WR_ALL_RIGHTS;
grant SELECT                                                                 on RNK_REKV        to WR_CUSTREG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNK_REKV.sql =========*** End *** ====
PROMPT ===================================================================================== 
