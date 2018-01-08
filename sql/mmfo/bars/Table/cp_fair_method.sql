

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_FAIR_METHOD.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_FAIR_METHOD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_FAIR_METHOD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_FAIR_METHOD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_FAIR_METHOD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_FAIR_METHOD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_FAIR_METHOD 
   (	ID NUMBER(2,0), 
	TITLE VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_FAIR_METHOD ***
 exec bpa.alter_policies('CP_FAIR_METHOD');


COMMENT ON TABLE BARS.CP_FAIR_METHOD IS 'Метод розрахунку справедливої вартості';
COMMENT ON COLUMN BARS.CP_FAIR_METHOD.ID IS '';
COMMENT ON COLUMN BARS.CP_FAIR_METHOD.TITLE IS '';




PROMPT *** Create  constraint PK_CP_FAIR_METHOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_FAIR_METHOD ADD CONSTRAINT PK_CP_FAIR_METHOD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index U_CP_FAIR_METHOD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.U_CP_FAIR_METHOD ON BARS.CP_FAIR_METHOD (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_FAIR_METHOD ***
grant SELECT                                                                 on CP_FAIR_METHOD  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_FAIR_METHOD.sql =========*** End **
PROMPT ===================================================================================== 
