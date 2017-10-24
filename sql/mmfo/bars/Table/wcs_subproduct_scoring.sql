

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_SCORING.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SUBPRODUCT_SCORING ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SUBPRODUCT_SCORING'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_SCORING'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_SCORING'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SUBPRODUCT_SCORING ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SUBPRODUCT_SCORING 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	SCORING_ID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SUBPRODUCT_SCORING ***
 exec bpa.alter_policies('WCS_SUBPRODUCT_SCORING');


COMMENT ON TABLE BARS.WCS_SUBPRODUCT_SCORING IS 'Карта скоринга субпродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_SCORING.SUBPRODUCT_ID IS 'Идентификатор субродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_SCORING.SCORING_ID IS 'Идентификатор карты скоринга';




PROMPT *** Create  constraint PK_SUBPRODUCTSCOR ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_SCORING ADD CONSTRAINT PK_SUBPRODUCTSCOR PRIMARY KEY (SUBPRODUCT_ID, SCORING_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPSCORS_SBPID_SBPS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_SCORING ADD CONSTRAINT FK_SBPSCORS_SBPID_SBPS_ID FOREIGN KEY (SUBPRODUCT_ID)
	  REFERENCES BARS.WCS_SUBPRODUCTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPSCORS_SID_SCORING_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_SCORING ADD CONSTRAINT FK_SBPSCORS_SID_SCORING_ID FOREIGN KEY (SCORING_ID)
	  REFERENCES BARS.WCS_SCORINGS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SUBPRODUCTSCOR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SUBPRODUCTSCOR ON BARS.WCS_SUBPRODUCT_SCORING (SUBPRODUCT_ID, SCORING_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SUBPRODUCT_SCORING ***
grant SELECT                                                                 on WCS_SUBPRODUCT_SCORING to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SUBPRODUCT_SCORING to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_SCORING.sql =========**
PROMPT ===================================================================================== 
