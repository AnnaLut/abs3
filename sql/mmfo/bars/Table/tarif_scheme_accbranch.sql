

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TARIF_SCHEME_ACCBRANCH.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TARIF_SCHEME_ACCBRANCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TARIF_SCHEME_ACCBRANCH'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TARIF_SCHEME_ACCBRANCH'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TARIF_SCHEME_ACCBRANCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TARIF_SCHEME_ACCBRANCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.TARIF_SCHEME_ACCBRANCH 
   (	ID NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	DAT_BEGIN DATE, 
	DAT_END DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TARIF_SCHEME_ACCBRANCH ***
 exec bpa.alter_policies('TARIF_SCHEME_ACCBRANCH');


COMMENT ON TABLE BARS.TARIF_SCHEME_ACCBRANCH IS 'Схемы тарифов в разрезе отделений';
COMMENT ON COLUMN BARS.TARIF_SCHEME_ACCBRANCH.ID IS 'Ид.';
COMMENT ON COLUMN BARS.TARIF_SCHEME_ACCBRANCH.BRANCH IS 'Отделение';
COMMENT ON COLUMN BARS.TARIF_SCHEME_ACCBRANCH.DAT_BEGIN IS 'Дата начала';
COMMENT ON COLUMN BARS.TARIF_SCHEME_ACCBRANCH.DAT_END IS 'Дата окончания';




PROMPT *** Create  constraint PK_TARIFSCHEMEACCBRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCHEME_ACCBRANCH ADD CONSTRAINT PK_TARIFSCHEMEACCBRANCH PRIMARY KEY (ID, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIFSCHEMEACCBR_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCHEME_ACCBRANCH MODIFY (ID CONSTRAINT CC_TARIFSCHEMEACCBR_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIFSCHEMEACCBR_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCHEME_ACCBRANCH MODIFY (BRANCH CONSTRAINT CC_TARIFSCHEMEACCBR_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TARIFSCHEMEACCBRANCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TARIFSCHEMEACCBRANCH ON BARS.TARIF_SCHEME_ACCBRANCH (ID, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TARIF_SCHEME_ACCBRANCH ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TARIF_SCHEME_ACCBRANCH to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TARIF_SCHEME_ACCBRANCH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TARIF_SCHEME_ACCBRANCH to BARS_DM;
grant SELECT                                                                 on TARIF_SCHEME_ACCBRANCH to START1;
grant FLASHBACK,SELECT                                                       on TARIF_SCHEME_ACCBRANCH to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TARIF_SCHEME_ACCBRANCH.sql =========**
PROMPT ===================================================================================== 
