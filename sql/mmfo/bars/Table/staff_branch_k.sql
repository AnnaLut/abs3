

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_BRANCH_K.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_BRANCH_K ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_BRANCH_K'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_BRANCH_K'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_BRANCH_K'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_BRANCH_K ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_BRANCH_K 
   (	ID NUMBER, 
	BRANCH_K VARCHAR2(30), 
	ADDP NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_BRANCH_K ***
 exec bpa.alter_policies('STAFF_BRANCH_K');


COMMENT ON TABLE BARS.STAFF_BRANCH_K IS 'Користувачi-Куратори BRANCH';
COMMENT ON COLUMN BARS.STAFF_BRANCH_K.ID IS 'Iд.користувача';
COMMENT ON COLUMN BARS.STAFF_BRANCH_K.BRANCH_K IS 'Iд.BRANCH';
COMMENT ON COLUMN BARS.STAFF_BRANCH_K.ADDP IS 'Код доп.прив.пользователя';




PROMPT *** Create  constraint PK_STAFFBRANCHK ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_BRANCH_K ADD CONSTRAINT PK_STAFFBRANCHK PRIMARY KEY (ID, BRANCH_K)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFBRANCHK_BRANCH_K ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_BRANCH_K ADD CONSTRAINT CC_STAFFBRANCHK_BRANCH_K CHECK (BRANCH_K <> SYS_CONTEXT(''bars_context'',''user_branch'')
          AND
          BRANCH_K LIKE SYS_CONTEXT(''bars_context'',''user_branch_mask'')
          ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFBRANCHK_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_BRANCH_K MODIFY (ID CONSTRAINT CC_STAFFBRANCHK_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFBRANCHK_BR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_BRANCH_K MODIFY (BRANCH_K CONSTRAINT CC_STAFFBRANCHK_BR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFBRANCHK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFBRANCHK ON BARS.STAFF_BRANCH_K (ID, BRANCH_K) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_BRANCH_K ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_BRANCH_K  to ABS_ADMIN;
grant SELECT                                                                 on STAFF_BRANCH_K  to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_BRANCH_K  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_BRANCH_K  to RPBN001;
grant SELECT                                                                 on STAFF_BRANCH_K  to SALGL;
grant SELECT                                                                 on STAFF_BRANCH_K  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_BRANCH_K  to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on STAFF_BRANCH_K  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_BRANCH_K.sql =========*** End **
PROMPT ===================================================================================== 
