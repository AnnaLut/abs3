

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_950A.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_950A ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_950A'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_950A'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SW_950A'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_950A ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_950A 
   (	SWREF NUMBER(38,0), 
	FDAT DATE DEFAULT sysdate, 
	KV NUMBER(3,0), 
	S NUMBER(24,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_950A ***
 exec bpa.alter_policies('SW_950A');


COMMENT ON TABLE BARS.SW_950A IS 'SWT. Остатки на ностро-счетах';
COMMENT ON COLUMN BARS.SW_950A.SWREF IS 'Референс сообщения (выписки)';
COMMENT ON COLUMN BARS.SW_950A.FDAT IS 'Дата остатка';
COMMENT ON COLUMN BARS.SW_950A.KV IS 'Код валюты счета';
COMMENT ON COLUMN BARS.SW_950A.S IS 'Остаток на счете';
COMMENT ON COLUMN BARS.SW_950A.KF IS '';




PROMPT *** Create  constraint PK_SW950A ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950A ADD CONSTRAINT PK_SW950A PRIMARY KEY (SWREF, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950A_SWREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950A MODIFY (SWREF CONSTRAINT CC_SW950A_SWREF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950A_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950A MODIFY (FDAT CONSTRAINT CC_SW950A_FDAT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950A_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950A MODIFY (KV CONSTRAINT CC_SW950A_KV_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950A_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950A MODIFY (S CONSTRAINT CC_SW950A_S_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SW950A_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950A MODIFY (KF CONSTRAINT CC_SW950A_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SW950A ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SW950A ON BARS.SW_950A (SWREF, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_950A ***
grant SELECT                                                                 on SW_950A         to BARSREADER_ROLE;
grant SELECT                                                                 on SW_950A         to BARS_DM;
grant SELECT                                                                 on SW_950A         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_950A         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_950A ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_950A FOR BARS.SW_950A;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_950A.sql =========*** End *** =====
PROMPT ===================================================================================== 
