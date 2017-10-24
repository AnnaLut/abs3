

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPERW_TMP_PRL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPERW_TMP_PRL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OPERW_TMP_PRL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OPERW_TMP_PRL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPERW_TMP_PRL ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPERW_TMP_PRL 
   (	REF NUMBER, 
	TAG CHAR(5), 
	VALUE VARCHAR2(200), 
	KF CHAR(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 COMPRESS FOR OLTP LOGGING
  TABLESPACE BRSBIGD 
  PARALLEL 12 ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OPERW_TMP_PRL ***
 exec bpa.alter_policies('OPERW_TMP_PRL');


COMMENT ON TABLE BARS.OPERW_TMP_PRL IS '';
COMMENT ON COLUMN BARS.OPERW_TMP_PRL.REF IS '';
COMMENT ON COLUMN BARS.OPERW_TMP_PRL.TAG IS '';
COMMENT ON COLUMN BARS.OPERW_TMP_PRL.VALUE IS '';
COMMENT ON COLUMN BARS.OPERW_TMP_PRL.KF IS '';




PROMPT *** Create  constraint SYS_C00123617 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERW_TMP_PRL MODIFY (TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPERW_TMP_PRL.sql =========*** End ***
PROMPT ===================================================================================== 
