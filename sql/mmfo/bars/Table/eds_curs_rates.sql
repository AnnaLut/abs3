PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EDS_CURS_RATES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EDS_CURS_RATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EDS_CURS_RATES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_CURS_RATES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_CURS_RATES'', ''WHOLE'' ,  null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EDS_CURS_RATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.EDS_CURS_RATES 
   (    REQ_ID VARCHAR2(36), 
    KV NUMBER(3,0), 
    NAME VARCHAR2(20), 
    VDATE DATE, 
    RATE_O NUMBER(9,4), 
    RATE_B NUMBER(9,4), 
    RATE_S NUMBER(9,4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EDS_CURS_RATES ***
 exec bpa.alter_policies('EDS_CURS_RATES');


COMMENT ON TABLE BARS.EDS_CURS_RATES IS 'Курси валют для відображення в Є-декларації';
COMMENT ON COLUMN BARS.EDS_CURS_RATES.REQ_ID IS 'Ід декларації';
COMMENT ON COLUMN BARS.EDS_CURS_RATES.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.EDS_CURS_RATES.NAME IS 'Назва валюти';
COMMENT ON COLUMN BARS.EDS_CURS_RATES.VDATE IS 'Дата на яку взято курси';
COMMENT ON COLUMN BARS.EDS_CURS_RATES.RATE_O IS 'Курс НБУ';
COMMENT ON COLUMN BARS.EDS_CURS_RATES.RATE_B IS 'Курс купівлі';
COMMENT ON COLUMN BARS.EDS_CURS_RATES.RATE_S IS 'Курс продажу';


PROMPT *** Create  index PK_EDS_CURS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EDS_CURS ON BARS.EDS_CURS_RATES (REQ_ID, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  constraint PK_EDS_CURS_RATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.EDS_CURS_RATES ADD CONSTRAINT PK_EDS_CURS_RATES PRIMARY KEY (REQ_ID, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/
GRANT SELECT ON EDS_CURS_RATES TO BARS_ACCESS_DEFROLE;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EDS_CURS_RATES.sql =========*** End **
PROMPT ===================================================================================== 

