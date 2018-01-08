

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TNAZNF.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TNAZNF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TNAZNF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TNAZNF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TNAZNF ***
begin 
  execute immediate '
  CREATE TABLE BARS.TNAZNF 
   (	N NUMBER(2,0), 
	TXT VARCHAR2(200), 
	COMM VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TNAZNF ***
 exec bpa.alter_policies('TNAZNF');


COMMENT ON TABLE BARS.TNAZNF IS '';
COMMENT ON COLUMN BARS.TNAZNF.N IS '';
COMMENT ON COLUMN BARS.TNAZNF.TXT IS '';
COMMENT ON COLUMN BARS.TNAZNF.COMM IS '';




PROMPT *** Create  constraint XPK_TNAZNF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TNAZNF ADD CONSTRAINT XPK_TNAZNF PRIMARY KEY (N)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_TNAZNF_N ***
begin   
 execute immediate '
  ALTER TABLE BARS.TNAZNF MODIFY (N CONSTRAINT NK_TNAZNF_N NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TNAZNF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TNAZNF ON BARS.TNAZNF (N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TNAZNF ***
grant SELECT                                                                 on TNAZNF          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TNAZNF          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TNAZNF          to BARS_DM;
grant SELECT                                                                 on TNAZNF          to OPER000;
grant DELETE,INSERT,SELECT,UPDATE                                            on TNAZNF          to START1;
grant SELECT                                                                 on TNAZNF          to TECH_MOM1;
grant SELECT                                                                 on TNAZNF          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TNAZNF          to WR_ALL_RIGHTS;
grant SELECT                                                                 on TNAZNF          to WR_DOC_INPUT;
grant FLASHBACK,SELECT                                                       on TNAZNF          to WR_REFREAD;



PROMPT *** Create SYNONYM  to TNAZNF ***

  CREATE OR REPLACE PUBLIC SYNONYM TNAZNF FOR BARS.TNAZNF;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TNAZNF.sql =========*** End *** ======
PROMPT ===================================================================================== 
