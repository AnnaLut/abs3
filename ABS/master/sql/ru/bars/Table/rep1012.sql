

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REP1012.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REP1012 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REP1012'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REP1012'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REP1012 ***
begin 
  execute immediate '
  CREATE TABLE BARS.REP1012 
   (	ID NUMBER, 
	NAME VARCHAR2(50), 
	LISTRNK VARCHAR2(2000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REP1012 ***
 exec bpa.alter_policies('REP1012');


COMMENT ON TABLE BARS.REP1012 IS 'Довідник для звіта 1011';
COMMENT ON COLUMN BARS.REP1012.ID IS 'ІД ключ';
COMMENT ON COLUMN BARS.REP1012.NAME IS 'Назва списку клієнтів';
COMMENT ON COLUMN BARS.REP1012.LISTRNK IS 'Список РНК';




PROMPT *** Create  constraint XPK_REP1012 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REP1012 ADD CONSTRAINT XPK_REP1012 PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REP1012 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_REP1012 ON BARS.REP1012 (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REP1012 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REP1012         to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REP1012.sql =========*** End *** =====
PROMPT ===================================================================================== 
