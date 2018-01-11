

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_PROFTAG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_PROFTAG ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_PROFTAG ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_PROFTAG 
   (	ID NUMBER, 
	TAG VARCHAR2(30), 
	NAME VARCHAR2(70), 
	NSINAME VARCHAR2(60)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBS_PROFTAG ***
 exec bpa.alter_policies('NBS_PROFTAG');


COMMENT ON TABLE BARS.NBS_PROFTAG IS 'Поля профилей счетов';
COMMENT ON COLUMN BARS.NBS_PROFTAG.ID IS 'Код поля';
COMMENT ON COLUMN BARS.NBS_PROFTAG.TAG IS 'Поле';
COMMENT ON COLUMN BARS.NBS_PROFTAG.NAME IS 'Наименование поля';
COMMENT ON COLUMN BARS.NBS_PROFTAG.NSINAME IS 'Имя справочника';




PROMPT *** Create  constraint XPK_NBS_PROFTAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_PROFTAG ADD CONSTRAINT XPK_NBS_PROFTAG PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_NBS_PROFTAG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_NBS_PROFTAG ON BARS.NBS_PROFTAG (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBS_PROFTAG ***
grant SELECT                                                                 on NBS_PROFTAG     to BARSREADER_ROLE;
grant SELECT                                                                 on NBS_PROFTAG     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBS_PROFTAG     to BARS_DM;
grant SELECT                                                                 on NBS_PROFTAG     to CUST001;
grant SELECT                                                                 on NBS_PROFTAG     to NBS_PROF;
grant SELECT                                                                 on NBS_PROFTAG     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_PROFTAG     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_PROFTAG.sql =========*** End *** =
PROMPT ===================================================================================== 
