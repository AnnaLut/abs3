

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FS.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FS ***
begin 
  execute immediate '
  CREATE TABLE BARS.FS 
   (	FS CHAR(2), 
	NAME VARCHAR2(105), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FS ***
 exec bpa.alter_policies('FS');


COMMENT ON TABLE BARS.FS IS 'Справочник форм собственности';
COMMENT ON COLUMN BARS.FS.FS IS 'Код формы';
COMMENT ON COLUMN BARS.FS.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.FS.D_CLOSE IS 'Дата отмены норматива';




PROMPT *** Create  constraint CC_FS_DCLOSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.FS ADD CONSTRAINT CC_FS_DCLOSE CHECK (d_close = trunc(d_close)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FS ***
begin   
 execute immediate '
  ALTER TABLE BARS.FS ADD CONSTRAINT PK_FS PRIMARY KEY (FS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007103 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FS MODIFY (FS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FS MODIFY (NAME CONSTRAINT CC_FS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FS ON BARS.FS (FS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FS              to ABS_ADMIN;
grant SELECT                                                                 on FS              to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FS              to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FS              to BARS_DM;
grant SELECT                                                                 on FS              to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on FS              to FS;
grant SELECT                                                                 on FS              to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FS              to WR_ALL_RIGHTS;
grant SELECT                                                                 on FS              to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on FS              to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FS.sql =========*** End *** ==========
PROMPT ===================================================================================== 
