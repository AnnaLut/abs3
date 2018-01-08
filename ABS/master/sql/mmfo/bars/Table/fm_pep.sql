

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_PEP.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_PEP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_PEP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FM_PEP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_PEP ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_PEP 
   (	ID NUMBER, 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_PEP ***
 exec bpa.alter_policies('FM_PEP');


COMMENT ON TABLE BARS.FM_PEP IS 'ФМ. Дозвіл ПЕП';
COMMENT ON COLUMN BARS.FM_PEP.ID IS 'Код';
COMMENT ON COLUMN BARS.FM_PEP.NAME IS 'Назва';




PROMPT *** Create  constraint PK_FMPEP ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_PEP ADD CONSTRAINT PK_FMPEP PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FMPEP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FMPEP ON BARS.FM_PEP (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_PEP ***
grant SELECT                                                                 on FM_PEP          to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on FM_PEP          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_PEP          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_PEP.sql =========*** End *** ======
PROMPT ===================================================================================== 
