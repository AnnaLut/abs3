

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IBX_LEGAL_PERS_PAYM.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IBX_LEGAL_PERS_PAYM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IBX_LEGAL_PERS_PAYM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''IBX_LEGAL_PERS_PAYM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IBX_LEGAL_PERS_PAYM ***
begin 
  execute immediate '
  CREATE TABLE BARS.IBX_LEGAL_PERS_PAYM 
   (	PAY_ID VARCHAR2(300), 
	REF NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IBX_LEGAL_PERS_PAYM ***
 exec bpa.alter_policies('IBX_LEGAL_PERS_PAYM');


COMMENT ON TABLE BARS.IBX_LEGAL_PERS_PAYM IS 'Связка ИД платежей Томаса с нашим РЕФ';
COMMENT ON COLUMN BARS.IBX_LEGAL_PERS_PAYM.PAY_ID IS '';
COMMENT ON COLUMN BARS.IBX_LEGAL_PERS_PAYM.REF IS '';




PROMPT *** Create  constraint PK_IBX_LEGAL_PERS_PAYM ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_LEGAL_PERS_PAYM ADD CONSTRAINT PK_IBX_LEGAL_PERS_PAYM PRIMARY KEY (PAY_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_IBX_LEGAL_PERS_PAYM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_IBX_LEGAL_PERS_PAYM ON BARS.IBX_LEGAL_PERS_PAYM (PAY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  IBX_LEGAL_PERS_PAYM ***
grant SELECT                                                                 on IBX_LEGAL_PERS_PAYM to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IBX_LEGAL_PERS_PAYM.sql =========*** E
PROMPT ===================================================================================== 
