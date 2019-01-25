PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_ATM_UNITS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_ATM_UNITS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_ATM_UNITS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_ATM_UNITS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_ATM_UNITS 
   (	EQUIP_ID NUMBER, 
	UNITNO VARCHAR2(10), 
	UNIT_TYPE VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_ATM_UNITS ***
 exec bpa.alter_policies('TELLER_ATM_UNITS');


COMMENT ON TABLE BARS.TELLER_ATM_UNITS IS '';
COMMENT ON COLUMN BARS.TELLER_ATM_UNITS.EQUIP_ID IS '';
COMMENT ON COLUMN BARS.TELLER_ATM_UNITS.UNITNO IS '';
COMMENT ON COLUMN BARS.TELLER_ATM_UNITS.UNIT_TYPE IS '';




PROMPT *** Create  constraint PK_TELLER_ATM_UNITS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_ATM_UNITS ADD CONSTRAINT PK_TELLER_ATM_UNITS PRIMARY KEY (EQUIP_ID, UNITNO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TELLER_ATM_UNITS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TELLER_ATM_UNITS ON BARS.TELLER_ATM_UNITS (EQUIP_ID, UNITNO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_ATM_UNITS.sql =========*** End 
PROMPT ===================================================================================== 
