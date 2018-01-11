

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANB0.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANB0 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANB0'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANB0'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANB0'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANB0 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANB0 
   (	NREP NUMBER(*,0), 
	NAME VARCHAR2(35), 
	TIP CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANB0 ***
 exec bpa.alter_policies('ANB0');


COMMENT ON TABLE BARS.ANB0 IS 'Зв_ти управл_нського обл_ку';
COMMENT ON COLUMN BARS.ANB0.NREP IS 'Код';
COMMENT ON COLUMN BARS.ANB0.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.ANB0.TIP IS '';




PROMPT *** Create  constraint SYS_C009641 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANB0 MODIFY (NREP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_ANB0 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANB0 ADD CONSTRAINT XPK_ANB0 PRIMARY KEY (NREP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ANB0 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ANB0 ON BARS.ANB0 (NREP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ANB0 ***
grant SELECT                                                                 on ANB0            to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ANB0            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ANB0            to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ANB0            to RPBN001;
grant SELECT                                                                 on ANB0            to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ANB0            to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANB0.sql =========*** End *** ========
PROMPT ===================================================================================== 
