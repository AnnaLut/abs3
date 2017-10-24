

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P12_2C.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P12_2C ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''P12_2C'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''P12_2C'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table P12_2C ***
begin 
  execute immediate '
  CREATE TABLE BARS.P12_2C 
   (	CODE VARCHAR2(10), 
	TXT VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to P12_2C ***
 exec bpa.alter_policies('P12_2C');


COMMENT ON TABLE BARS.P12_2C IS 'Справочник признаков операции';
COMMENT ON COLUMN BARS.P12_2C.CODE IS 'Код записи';
COMMENT ON COLUMN BARS.P12_2C.TXT IS 'Признака операции';




PROMPT *** Create  constraint NK_P12_2C_CODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.P12_2C ADD CONSTRAINT NK_P12_2C_CODE CHECK (CODE IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_P12_2C ***
begin   
 execute immediate '
  ALTER TABLE BARS.P12_2C ADD CONSTRAINT PK_P12_2C PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_P12_2C ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_P12_2C ON BARS.P12_2C (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  P12_2C ***
grant DELETE,INSERT,SELECT,UPDATE                                            on P12_2C          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on P12_2C          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P12_2C.sql =========*** End *** ======
PROMPT ===================================================================================== 
