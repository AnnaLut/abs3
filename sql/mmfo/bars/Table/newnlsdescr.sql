

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NEWNLSDESCR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NEWNLSDESCR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NEWNLSDESCR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NEWNLSDESCR'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NEWNLSDESCR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NEWNLSDESCR ***
begin 
  execute immediate '
  CREATE TABLE BARS.NEWNLSDESCR 
   (	TYPEID CHAR(1), 
	DESCR VARCHAR2(40), 
	SQLVAL VARCHAR2(2000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NEWNLSDESCR ***
 exec bpa.alter_policies('NEWNLSDESCR');


COMMENT ON TABLE BARS.NEWNLSDESCR IS 'Словарь символов для построения счета';
COMMENT ON COLUMN BARS.NEWNLSDESCR.TYPEID IS 'Символ';
COMMENT ON COLUMN BARS.NEWNLSDESCR.DESCR IS 'Наименование';
COMMENT ON COLUMN BARS.NEWNLSDESCR.SQLVAL IS 'SQL-выражение';




PROMPT *** Create  constraint PK_NEWNLSDESCR ***
begin   
 execute immediate '
  ALTER TABLE BARS.NEWNLSDESCR ADD CONSTRAINT PK_NEWNLSDESCR PRIMARY KEY (TYPEID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008400 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NEWNLSDESCR MODIFY (TYPEID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NEWNLSDESCR_DESCR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NEWNLSDESCR MODIFY (DESCR CONSTRAINT CC_NEWNLSDESCR_DESCR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NEWNLSDESCR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NEWNLSDESCR ON BARS.NEWNLSDESCR (TYPEID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NEWNLSDESCR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NEWNLSDESCR     to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NEWNLSDESCR     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NEWNLSDESCR     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on NEWNLSDESCR     to NEWNLSDESCR;
grant SELECT                                                                 on NEWNLSDESCR     to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NEWNLSDESCR     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on NEWNLSDESCR     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NEWNLSDESCR.sql =========*** End *** =
PROMPT ===================================================================================== 
