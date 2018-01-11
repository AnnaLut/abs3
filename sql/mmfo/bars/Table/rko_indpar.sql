

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RKO_INDPAR.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RKO_INDPAR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RKO_INDPAR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RKO_INDPAR'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RKO_INDPAR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RKO_INDPAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.RKO_INDPAR 
   (	ID NUMBER(10,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RKO_INDPAR ***
 exec bpa.alter_policies('RKO_INDPAR');


COMMENT ON TABLE BARS.RKO_INDPAR IS 'Тип індивідуального параметру';
COMMENT ON COLUMN BARS.RKO_INDPAR.ID IS '';
COMMENT ON COLUMN BARS.RKO_INDPAR.NAME IS '';




PROMPT *** Create  constraint PK_RKOINDPAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_INDPAR ADD CONSTRAINT PK_RKOINDPAR PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOINDPAR_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_INDPAR MODIFY (ID CONSTRAINT CC_RKOINDPAR_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOINDPAR_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_INDPAR MODIFY (NAME CONSTRAINT CC_RKOINDPAR_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RKOINDPAR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RKOINDPAR ON BARS.RKO_INDPAR (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RKO_INDPAR ***
grant SELECT                                                                 on RKO_INDPAR      to BARSREADER_ROLE;
grant SELECT                                                                 on RKO_INDPAR      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RKO_INDPAR      to BARS_DM;
grant SELECT                                                                 on RKO_INDPAR      to CUST001;
grant SELECT                                                                 on RKO_INDPAR      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RKO_INDPAR.sql =========*** End *** ==
PROMPT ===================================================================================== 
