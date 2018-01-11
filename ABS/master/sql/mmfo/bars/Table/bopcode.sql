

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BOPCODE.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BOPCODE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BOPCODE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BOPCODE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BOPCODE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BOPCODE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BOPCODE 
   (	TRANSCODE CHAR(7), 
	KOD_NNN NUMBER(*,0), 
	TRANSDESC VARCHAR2(110), 
	KIND CHAR(1), 
	TRANSCODE_N VARCHAR2(7)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BOPCODE ***
 exec bpa.alter_policies('BOPCODE');


COMMENT ON TABLE BARS.BOPCODE IS '';
COMMENT ON COLUMN BARS.BOPCODE.TRANSCODE IS '';
COMMENT ON COLUMN BARS.BOPCODE.KOD_NNN IS '';
COMMENT ON COLUMN BARS.BOPCODE.TRANSDESC IS '';
COMMENT ON COLUMN BARS.BOPCODE.KIND IS '';
COMMENT ON COLUMN BARS.BOPCODE.TRANSCODE_N IS '';




PROMPT *** Create  index XPK_BOPCODE ***
begin   
 execute immediate '
  CREATE INDEX BARS.XPK_BOPCODE ON BARS.BOPCODE (TRANSCODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BOPCODE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BOPCODE         to ABS_ADMIN;
grant SELECT                                                                 on BOPCODE         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BOPCODE         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BOPCODE         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BOPCODE         to BOPCODE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BOPCODE         to PB1;
grant SELECT                                                                 on BOPCODE         to START1;
grant SELECT                                                                 on BOPCODE         to UPLD;
grant FLASHBACK,SELECT                                                       on BOPCODE         to WR_REFREAD;



PROMPT *** Create SYNONYM  to BOPCODE ***

  CREATE OR REPLACE PUBLIC SYNONYM BOPCODE FOR BARS.BOPCODE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BOPCODE.sql =========*** End *** =====
PROMPT ===================================================================================== 
