

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PODOTC.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PODOTC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PODOTC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PODOTC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PODOTC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PODOTC ***
begin 
  execute immediate '
  CREATE TABLE BARS.PODOTC 
   (	ID NUMBER(38,0), 
	TAG VARCHAR2(10), 
	VAL VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PODOTC ***
 exec bpa.alter_policies('PODOTC');


COMMENT ON TABLE BARS.PODOTC IS 'Реестр подотчетных лиц';
COMMENT ON COLUMN BARS.PODOTC.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.PODOTC.TAG IS 'Параметр';
COMMENT ON COLUMN BARS.PODOTC.VAL IS 'Значение параметра';




PROMPT *** Create  constraint SYS_C008688 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PODOTC MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008689 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PODOTC MODIFY (TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008690 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PODOTC MODIFY (VAL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PODOTC ***
begin   
 execute immediate '
  ALTER TABLE BARS.PODOTC ADD CONSTRAINT PK_PODOTC PRIMARY KEY (ID, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PODOTC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PODOTC ON BARS.PODOTC (ID, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PODOTC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PODOTC          to ABS_ADMIN;
grant SELECT                                                                 on PODOTC          to BARSREADER_ROLE;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on PODOTC          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PODOTC          to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on PODOTC          to REF0000;
grant SELECT                                                                 on PODOTC          to START1;
grant SELECT                                                                 on PODOTC          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PODOTC          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on PODOTC          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PODOTC.sql =========*** End *** ======
PROMPT ===================================================================================== 
