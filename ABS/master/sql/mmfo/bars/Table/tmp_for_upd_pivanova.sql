

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FOR_UPD_PIVANOVA.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FOR_UPD_PIVANOVA ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FOR_UPD_PIVANOVA ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_FOR_UPD_PIVANOVA 
   (	DATE_FROM DATE, 
	ACCOUNT_ID NUMBER(38,0), 
	INTEREST_KIND NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FOR_UPD_PIVANOVA ***
 exec bpa.alter_policies('TMP_FOR_UPD_PIVANOVA');


COMMENT ON TABLE BARS.TMP_FOR_UPD_PIVANOVA IS '';
COMMENT ON COLUMN BARS.TMP_FOR_UPD_PIVANOVA.DATE_FROM IS '';
COMMENT ON COLUMN BARS.TMP_FOR_UPD_PIVANOVA.ACCOUNT_ID IS '';
COMMENT ON COLUMN BARS.TMP_FOR_UPD_PIVANOVA.INTEREST_KIND IS '';




PROMPT *** Create  constraint SYS_C00132694 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_FOR_UPD_PIVANOVA MODIFY (ACCOUNT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_FOR_UPD_PIVANOVA ***
grant SELECT                                                                 on TMP_FOR_UPD_PIVANOVA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FOR_UPD_PIVANOVA.sql =========*** 
PROMPT ===================================================================================== 
