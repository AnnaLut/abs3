

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_OVER_NBS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_OVER_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_OVER_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_OVER_NBS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACC_OVER_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_OVER_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_OVER_NBS 
   (	NBS2600 VARCHAR2(4), 
	NBS2000 VARCHAR2(4), 
	NBS2607 VARCHAR2(4), 
	NBS2067 VARCHAR2(4), 
	NBS2069 VARCHAR2(4), 
	NBS2096 VARCHAR2(4), 
	NBS2480 VARCHAR2(4), 
	NBS9129 VARCHAR2(4), 
	NBS3579 VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_OVER_NBS ***
 exec bpa.alter_policies('ACC_OVER_NBS');


COMMENT ON TABLE BARS.ACC_OVER_NBS IS 'справочник НБС модуля овердрафты';
COMMENT ON COLUMN BARS.ACC_OVER_NBS.NBS2600 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_NBS.NBS2000 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_NBS.NBS2607 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_NBS.NBS2067 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_NBS.NBS2069 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_NBS.NBS2096 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_NBS.NBS2480 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_NBS.NBS9129 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_NBS.NBS3579 IS '';




PROMPT *** Create  constraint NK_ACC_OVER_NBS_NBS2600 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_NBS MODIFY (NBS2600 CONSTRAINT NK_ACC_OVER_NBS_NBS2600 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACC_OVER_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_NBS ADD CONSTRAINT PK_ACC_OVER_NBS PRIMARY KEY (NBS2600)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACC_OVER_NBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACC_OVER_NBS ON BARS.ACC_OVER_NBS (NBS2600) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_OVER_NBS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_NBS    to ABS_ADMIN;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on ACC_OVER_NBS    to BARS009;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_OVER_NBS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_OVER_NBS    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_NBS    to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_NBS    to TECH005;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_NBS    to TECH006;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_OVER_NBS    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on ACC_OVER_NBS    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_OVER_NBS.sql =========*** End *** 
PROMPT ===================================================================================== 
