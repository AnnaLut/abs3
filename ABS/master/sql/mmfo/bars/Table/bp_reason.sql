

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BP_REASON.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BP_REASON ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BP_REASON'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BP_REASON'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BP_REASON'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BP_REASON ***
begin 
  execute immediate '
  CREATE TABLE BARS.BP_REASON 
   (	ID NUMBER(38,0), 
	REASON VARCHAR2(160)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BP_REASON ***
 exec bpa.alter_policies('BP_REASON');


COMMENT ON TABLE BARS.BP_REASON IS 'Справочник возможных причин возврата документов';
COMMENT ON COLUMN BARS.BP_REASON.ID IS 'Код';
COMMENT ON COLUMN BARS.BP_REASON.REASON IS 'Наименование';




PROMPT *** Create  constraint PK_BPREASON ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_REASON ADD CONSTRAINT PK_BPREASON PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPREASON_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_REASON MODIFY (ID CONSTRAINT CC_BPREASON_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPREASON_REASON_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_REASON MODIFY (REASON CONSTRAINT CC_BPREASON_REASON_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPREASON ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPREASON ON BARS.BP_REASON (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BP_REASON ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BP_REASON       to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BP_REASON       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BP_REASON       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BP_REASON       to BPREASON;
grant DELETE,INSERT,SELECT,UPDATE                                            on BP_REASON       to SEP_ROLE;
grant SELECT                                                                 on BP_REASON       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BP_REASON       to WR_ALL_RIGHTS;
grant SELECT                                                                 on BP_REASON       to WR_CHCKINNR_ALL;
grant SELECT                                                                 on BP_REASON       to WR_CHCKINNR_CASH;
grant SELECT                                                                 on BP_REASON       to WR_CHCKINNR_SELF;
grant SELECT                                                                 on BP_REASON       to WR_CHCKINNR_SUBTOBO;
grant SELECT                                                                 on BP_REASON       to WR_CHCKINNR_TOBO;
grant FLASHBACK,SELECT                                                       on BP_REASON       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BP_REASON.sql =========*** End *** ===
PROMPT ===================================================================================== 
