

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RKO_METHOD_TARIF.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RKO_METHOD_TARIF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RKO_METHOD_TARIF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RKO_METHOD_TARIF'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RKO_METHOD_TARIF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RKO_METHOD_TARIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.RKO_METHOD_TARIF 
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




PROMPT *** ALTER_POLICIES to RKO_METHOD_TARIF ***
 exec bpa.alter_policies('RKO_METHOD_TARIF');


COMMENT ON TABLE BARS.RKO_METHOD_TARIF IS 'Спосіб зміни тарифів за договором банківського рахунку';
COMMENT ON COLUMN BARS.RKO_METHOD_TARIF.ID IS '';
COMMENT ON COLUMN BARS.RKO_METHOD_TARIF.NAME IS '';




PROMPT *** Create  constraint PK_RKOMETHODTARIF ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_METHOD_TARIF ADD CONSTRAINT PK_RKOMETHODTARIF PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOMETHODTARIF_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_METHOD_TARIF MODIFY (ID CONSTRAINT CC_RKOMETHODTARIF_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOMETHODTARIF_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_METHOD_TARIF MODIFY (NAME CONSTRAINT CC_RKOMETHODTARIF_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RKOMETHODTARIF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RKOMETHODTARIF ON BARS.RKO_METHOD_TARIF (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RKO_METHOD_TARIF ***
grant SELECT                                                                 on RKO_METHOD_TARIF to BARSREADER_ROLE;
grant SELECT                                                                 on RKO_METHOD_TARIF to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RKO_METHOD_TARIF to BARS_DM;
grant SELECT                                                                 on RKO_METHOD_TARIF to CUST001;
grant SELECT                                                                 on RKO_METHOD_TARIF to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RKO_METHOD_TARIF.sql =========*** End 
PROMPT ===================================================================================== 
