

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZID.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZID ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZID'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REZID'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REZID'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZID ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZID 
   (	REZID NUMBER(1,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZID ***
 exec bpa.alter_policies('REZID');


COMMENT ON TABLE BARS.REZID IS 'Резидентность';
COMMENT ON COLUMN BARS.REZID.REZID IS 'Код';
COMMENT ON COLUMN BARS.REZID.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_REZID ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZID ADD CONSTRAINT PK_REZID PRIMARY KEY (REZID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZID_REZID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZID MODIFY (REZID CONSTRAINT CC_REZID_REZID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZID_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZID MODIFY (NAME CONSTRAINT CC_REZID_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REZID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZID ON BARS.REZID (REZID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZID ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REZID           to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REZID           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZID           to BARS_DM;
grant SELECT                                                                 on REZID           to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on REZID           to REZID;
grant SELECT                                                                 on REZID           to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REZID           to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on REZID           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZID.sql =========*** End *** =======
PROMPT ===================================================================================== 
