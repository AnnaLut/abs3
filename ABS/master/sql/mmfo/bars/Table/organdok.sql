

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ORGANDOK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ORGANDOK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ORGANDOK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ORGANDOK'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ORGANDOK'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ORGANDOK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ORGANDOK 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(70), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ORGANDOK ***
 exec bpa.alter_policies('ORGANDOK');


COMMENT ON TABLE BARS.ORGANDOK IS 'Органы выдачи документов';
COMMENT ON COLUMN BARS.ORGANDOK.KF IS '';
COMMENT ON COLUMN BARS.ORGANDOK.ID IS 'Код';
COMMENT ON COLUMN BARS.ORGANDOK.NAME IS 'Наименование органа';




PROMPT *** Create  constraint CC_ORGANDOK_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ORGANDOK MODIFY (ID CONSTRAINT CC_ORGANDOK_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ORGANDOK_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ORGANDOK MODIFY (NAME CONSTRAINT CC_ORGANDOK_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ORGANDOK ***
begin   
 execute immediate '
  ALTER TABLE BARS.ORGANDOK ADD CONSTRAINT PK_ORGANDOK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ORGANDOK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ORGANDOK ON BARS.ORGANDOK (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ORGANDOK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ORGANDOK        to ABS_ADMIN;
grant SELECT                                                                 on ORGANDOK        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ORGANDOK        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ORGANDOK        to BARS_DM;
grant SELECT                                                                 on ORGANDOK        to CUST001;
grant SELECT                                                                 on ORGANDOK        to START1;
grant SELECT                                                                 on ORGANDOK        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ORGANDOK        to WR_ALL_RIGHTS;
grant SELECT                                                                 on ORGANDOK        to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on ORGANDOK        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ORGANDOK.sql =========*** End *** ====
PROMPT ===================================================================================== 
