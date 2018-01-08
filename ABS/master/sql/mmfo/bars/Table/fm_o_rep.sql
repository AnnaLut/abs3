

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_O_REP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_O_REP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_O_REP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FM_O_REP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FM_O_REP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_O_REP ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_O_REP 
   (	ID NUMBER, 
	NAME VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_O_REP ***
 exec bpa.alter_policies('FM_O_REP');


COMMENT ON TABLE BARS.FM_O_REP IS 'Оцінка репутації клієнта ФМ';
COMMENT ON COLUMN BARS.FM_O_REP.ID IS '';
COMMENT ON COLUMN BARS.FM_O_REP.NAME IS '';




PROMPT *** Create  constraint PK_O_REP_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_O_REP ADD CONSTRAINT PK_O_REP_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_O_REP_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_O_REP_ID ON BARS.FM_O_REP (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_O_REP ***
grant SELECT                                                                 on FM_O_REP        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_O_REP        to BARS_DM;
grant SELECT                                                                 on FM_O_REP        to CUST001;
grant SELECT                                                                 on FM_O_REP        to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_O_REP.sql =========*** End *** ====
PROMPT ===================================================================================== 
