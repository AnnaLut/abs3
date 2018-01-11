

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CODCAGENT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CODCAGENT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CODCAGENT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CODCAGENT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CODCAGENT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CODCAGENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CODCAGENT 
   (	CODCAGENT NUMBER(1,0), 
	NAME VARCHAR2(35), 
	REZID NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CODCAGENT ***
 exec bpa.alter_policies('CODCAGENT');


COMMENT ON TABLE BARS.CODCAGENT IS 'Характеристика контрагента';
COMMENT ON COLUMN BARS.CODCAGENT.CODCAGENT IS 'Код';
COMMENT ON COLUMN BARS.CODCAGENT.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.CODCAGENT.REZID IS 'Резидентность';




PROMPT *** Create  constraint PK_CODCAGENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CODCAGENT ADD CONSTRAINT PK_CODCAGENT PRIMARY KEY (CODCAGENT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CODCAGENT_CODCAGENT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CODCAGENT MODIFY (CODCAGENT CONSTRAINT CC_CODCAGENT_CODCAGENT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CODCAGENT_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CODCAGENT MODIFY (NAME CONSTRAINT CC_CODCAGENT_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CODCAGENT_REZID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CODCAGENT MODIFY (REZID CONSTRAINT CC_CODCAGENT_REZID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CODCAGENT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CODCAGENT ON BARS.CODCAGENT (CODCAGENT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CODCAGENT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CODCAGENT       to ABS_ADMIN;
grant SELECT                                                                 on CODCAGENT       to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CODCAGENT       to BARSREADER_ROLE;
grant SELECT                                                                 on CODCAGENT       to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CODCAGENT       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CODCAGENT       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CODCAGENT       to CODCAGENT;
grant SELECT                                                                 on CODCAGENT       to CUST001;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on CODCAGENT       to FINMON;
grant SELECT                                                                 on CODCAGENT       to START1;
grant SELECT                                                                 on CODCAGENT       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CODCAGENT       to WR_ALL_RIGHTS;
grant SELECT                                                                 on CODCAGENT       to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on CODCAGENT       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CODCAGENT.sql =========*** End *** ===
PROMPT ===================================================================================== 
