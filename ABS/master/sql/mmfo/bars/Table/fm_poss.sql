

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_POSS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_POSS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_POSS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FM_POSS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_POSS ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_POSS 
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




PROMPT *** ALTER_POLICIES to FM_POSS ***
 exec bpa.alter_policies('FM_POSS');


COMMENT ON TABLE BARS.FM_PEP IS 'ФМ. Висновок щодо наявн.у кл-та потенц. та реал. фін.можл.для провед. опер.';
COMMENT ON COLUMN BARS.FM_PEP.ID IS 'Код';
COMMENT ON COLUMN BARS.FM_PEP.NAME IS 'Назва';




PROMPT *** Create  constraint PK_FMPEP ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_POSS ADD CONSTRAINT PK_FM_POSS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FM_POSS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FM_POSS ON BARS.FM_POSS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_POSS ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on FM_POSS          to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_POSS.sql =========*** End *** ======
PROMPT ===================================================================================== 
