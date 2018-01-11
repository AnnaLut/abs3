

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FINMON_REFT_INPERR.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FINMON_REFT_INPERR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FINMON_REFT_INPERR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_REFT_INPERR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_REFT_INPERR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FINMON_REFT_INPERR ***
begin 
  execute immediate '
  CREATE TABLE BARS.FINMON_REFT_INPERR 
   (	ID NUMBER, 
	C1 NUMBER, 
	ERROR_DETAIL VARCHAR2(2000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FINMON_REFT_INPERR ***
 exec bpa.alter_policies('FINMON_REFT_INPERR');


COMMENT ON TABLE BARS.FINMON_REFT_INPERR IS '';
COMMENT ON COLUMN BARS.FINMON_REFT_INPERR.ID IS '';
COMMENT ON COLUMN BARS.FINMON_REFT_INPERR.C1 IS '';
COMMENT ON COLUMN BARS.FINMON_REFT_INPERR.ERROR_DETAIL IS '';




PROMPT *** Create  constraint SYS_C005661 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_REFT_INPERR MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005662 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_REFT_INPERR MODIFY (C1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FINMON_REFT_INPERR ***
grant SELECT                                                                 on FINMON_REFT_INPERR to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on FINMON_REFT_INPERR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FINMON_REFT_INPERR to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on FINMON_REFT_INPERR to FINMON01;
grant SELECT                                                                 on FINMON_REFT_INPERR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FINMON_REFT_INPERR.sql =========*** En
PROMPT ===================================================================================== 
