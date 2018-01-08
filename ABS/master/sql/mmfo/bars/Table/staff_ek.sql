

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_EK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_EK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_EK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_EK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_EK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_EK ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_EK 
   (	ID NUMBER(38,0), 
	POK NUMBER(38,0), 
	SORT_ORDER NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_EK ***
 exec bpa.alter_policies('STAFF_EK');


COMMENT ON TABLE BARS.STAFF_EK IS 'Пользователи <-> эконом.показатели';
COMMENT ON COLUMN BARS.STAFF_EK.ID IS 'Код пользователя';
COMMENT ON COLUMN BARS.STAFF_EK.POK IS 'Код показателя';
COMMENT ON COLUMN BARS.STAFF_EK.SORT_ORDER IS 'Порядок сортировки';




PROMPT *** Create  constraint PK_STAFFEK ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_EK ADD CONSTRAINT PK_STAFFEK PRIMARY KEY (ID, POK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFEK_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_EK MODIFY (ID CONSTRAINT CC_STAFFEK_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFEK_POK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_EK MODIFY (POK CONSTRAINT CC_STAFFEK_POK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFEK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFEK ON BARS.STAFF_EK (ID, POK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_EK ***
grant SELECT                                                                 on STAFF_EK        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_EK        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_EK        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_EK        to DPT_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_EK        to STAFF_EK;
grant SELECT                                                                 on STAFF_EK        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_EK        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on STAFF_EK        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_EK.sql =========*** End *** ====
PROMPT ===================================================================================== 
