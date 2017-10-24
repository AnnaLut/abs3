

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REP_PROC.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REP_PROC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REP_PROC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REP_PROC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REP_PROC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REP_PROC ***
begin 
  execute immediate '
  CREATE TABLE BARS.REP_PROC 
   (	PROCC VARCHAR2(5), 
	NAME VARCHAR2(35), 
	SEMANTIC VARCHAR2(210)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REP_PROC ***
 exec bpa.alter_policies('REP_PROC');


COMMENT ON TABLE BARS.REP_PROC IS 'Перечень процедур для формирования файлов отчетности';
COMMENT ON COLUMN BARS.REP_PROC.PROCC IS '';
COMMENT ON COLUMN BARS.REP_PROC.NAME IS '';
COMMENT ON COLUMN BARS.REP_PROC.SEMANTIC IS '';




PROMPT *** Create  constraint SYS_C007110 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REP_PROC MODIFY (PROCC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REP_PROC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REP_PROC        to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REP_PROC        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REP_PROC        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REP_PROC        to REP_PROC;
grant SELECT                                                                 on REP_PROC        to RPBN002;
grant SELECT                                                                 on REP_PROC        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REP_PROC        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on REP_PROC        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REP_PROC.sql =========*** End *** ====
PROMPT ===================================================================================== 
