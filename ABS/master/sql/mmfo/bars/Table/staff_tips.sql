

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_TIPS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_TIPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_TIPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_TIPS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STAFF_TIPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_TIPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_TIPS 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_TIPS ***
 exec bpa.alter_policies('STAFF_TIPS');


COMMENT ON TABLE BARS.STAFF_TIPS IS 'Довідник типових користувачів';
COMMENT ON COLUMN BARS.STAFF_TIPS.ID IS 'Код';
COMMENT ON COLUMN BARS.STAFF_TIPS.NAME IS 'Назва';




PROMPT *** Create  constraint PK_STAFFTIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TIPS ADD CONSTRAINT PK_STAFFTIPS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTIPS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TIPS MODIFY (ID CONSTRAINT CC_STAFFTIPS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFTIPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFTIPS ON BARS.STAFF_TIPS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_TIPS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_TIPS      to ABS_ADMIN;
grant SELECT                                                                 on STAFF_TIPS      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_TIPS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_TIPS      to BARS_DM;
grant SELECT                                                                 on STAFF_TIPS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_TIPS.sql =========*** End *** ==
PROMPT ===================================================================================== 
