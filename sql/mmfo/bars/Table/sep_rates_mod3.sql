

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEP_RATES_MOD3.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEP_RATES_MOD3 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEP_RATES_MOD3'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEP_RATES_MOD3'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SEP_RATES_MOD3'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEP_RATES_MOD3 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEP_RATES_MOD3 
   (	ID NUMBER(*,0), 
	RATE NUMBER, 
	DESCRIPTION VARCHAR2(256)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEP_RATES_MOD3 ***
 exec bpa.alter_policies('SEP_RATES_MOD3');


COMMENT ON TABLE BARS.SEP_RATES_MOD3 IS '';
COMMENT ON COLUMN BARS.SEP_RATES_MOD3.ID IS '';
COMMENT ON COLUMN BARS.SEP_RATES_MOD3.RATE IS '';
COMMENT ON COLUMN BARS.SEP_RATES_MOD3.DESCRIPTION IS '';




PROMPT *** Create  constraint PK_SEPRATESMOD3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_MOD3 ADD CONSTRAINT PK_SEPRATESMOD3 PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESMOD3_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_MOD3 MODIFY (ID CONSTRAINT CC_SEPRATESMOD3_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESMOD3_RATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_MOD3 MODIFY (RATE CONSTRAINT CC_SEPRATESMOD3_RATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESMOD3_DESC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_MOD3 MODIFY (DESCRIPTION CONSTRAINT CC_SEPRATESMOD3_DESC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SEPRATESMOD3 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SEPRATESMOD3 ON BARS.SEP_RATES_MOD3 (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEP_RATES_MOD3 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SEP_RATES_MOD3  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SEP_RATES_MOD3  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SEP_RATES_MOD3  to SEP_RATES_ROLE;
grant FLASHBACK,SELECT                                                       on SEP_RATES_MOD3  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEP_RATES_MOD3.sql =========*** End **
PROMPT ===================================================================================== 
