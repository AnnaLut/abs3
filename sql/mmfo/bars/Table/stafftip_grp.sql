

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFFTIP_GRP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFFTIP_GRP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFFTIP_GRP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFFTIP_GRP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STAFFTIP_GRP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFFTIP_GRP ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFFTIP_GRP 
   (	IDU NUMBER(22,0), 
	IDG NUMBER(22,0), 
	SEC_SEL NUMBER(1,0), 
	SEC_DEB NUMBER(1,0), 
	SEC_CRE NUMBER(1,0), 
	SECG NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFFTIP_GRP ***
 exec bpa.alter_policies('STAFFTIP_GRP');


COMMENT ON TABLE BARS.STAFFTIP_GRP IS 'Типов_ користувач_ <-> Групи користувач_в';
COMMENT ON COLUMN BARS.STAFFTIP_GRP.IDU IS 'Код типового користувача';
COMMENT ON COLUMN BARS.STAFFTIP_GRP.IDG IS 'Код групи користувача';
COMMENT ON COLUMN BARS.STAFFTIP_GRP.SEC_SEL IS '';
COMMENT ON COLUMN BARS.STAFFTIP_GRP.SEC_DEB IS '';
COMMENT ON COLUMN BARS.STAFFTIP_GRP.SEC_CRE IS '';
COMMENT ON COLUMN BARS.STAFFTIP_GRP.SECG IS '';




PROMPT *** Create  constraint PK_STAFFTIPGRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_GRP ADD CONSTRAINT PK_STAFFTIPGRP PRIMARY KEY (IDU, IDG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFTIPGRP_STAFFTIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_GRP ADD CONSTRAINT FK_STAFFTIPGRP_STAFFTIPS FOREIGN KEY (IDU)
	  REFERENCES BARS.STAFF_TIPS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFTIPGRP_GROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_GRP ADD CONSTRAINT FK_STAFFTIPGRP_GROUPS FOREIGN KEY (IDG)
	  REFERENCES BARS.GROUPS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTIPGRP_IDU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_GRP MODIFY (IDU CONSTRAINT CC_STAFFTIPGRP_IDU_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTIPGRP_IDG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_GRP MODIFY (IDG CONSTRAINT CC_STAFFTIPGRP_IDG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFTIPGRP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFTIPGRP ON BARS.STAFFTIP_GRP (IDU, IDG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFFTIP_GRP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFFTIP_GRP    to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFFTIP_GRP    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFFTIP_GRP    to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFFTIP_GRP.sql =========*** End *** 
PROMPT ===================================================================================== 
