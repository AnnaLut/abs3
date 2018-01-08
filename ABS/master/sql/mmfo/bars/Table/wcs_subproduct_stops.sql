

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_STOPS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SUBPRODUCT_STOPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SUBPRODUCT_STOPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_STOPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_STOPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SUBPRODUCT_STOPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SUBPRODUCT_STOPS 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	STOP_ID VARCHAR2(100), 
	ACT_LEVEL NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SUBPRODUCT_STOPS ***
 exec bpa.alter_policies('WCS_SUBPRODUCT_STOPS');


COMMENT ON TABLE BARS.WCS_SUBPRODUCT_STOPS IS 'Стопы субпродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_STOPS.ACT_LEVEL IS 'Уровень активации';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_STOPS.SUBPRODUCT_ID IS 'Идентификатор субпродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_STOPS.STOP_ID IS 'Идентификатор стопа';




PROMPT *** Create  constraint PK_SBPSTOPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_STOPS ADD CONSTRAINT PK_SBPSTOPS PRIMARY KEY (SUBPRODUCT_ID, STOP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPSTOPS_SBPID_SBPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_STOPS ADD CONSTRAINT FK_SBPSTOPS_SBPID_SBPS FOREIGN KEY (SUBPRODUCT_ID)
	  REFERENCES BARS.WCS_SUBPRODUCTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPSTOPS_STPID_STOPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_STOPS ADD CONSTRAINT FK_SBPSTOPS_STPID_STOPS FOREIGN KEY (STOP_ID)
	  REFERENCES BARS.WCS_STOPS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SBPSTOPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SBPSTOPS ON BARS.WCS_SUBPRODUCT_STOPS (SUBPRODUCT_ID, STOP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SUBPRODUCT_STOPS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SUBPRODUCT_STOPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SUBPRODUCT_STOPS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SUBPRODUCT_STOPS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_STOPS.sql =========*** 
PROMPT ===================================================================================== 
