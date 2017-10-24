

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KD_TIP.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KD_TIP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KD_TIP ***
begin 
  execute immediate '
  CREATE TABLE BARS.KD_TIP 
   (	TIP NUMBER(*,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KD_TIP ***
 exec bpa.alter_policies('KD_TIP');


COMMENT ON TABLE BARS.KD_TIP IS '';
COMMENT ON COLUMN BARS.KD_TIP.TIP IS '';
COMMENT ON COLUMN BARS.KD_TIP.NAME IS '';




PROMPT *** Create  constraint PK_KD_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.KD_TIP ADD CONSTRAINT PK_KD_TIP PRIMARY KEY (TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004969 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KD_TIP MODIFY (TIP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KD_TIP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KD_TIP ON BARS.KD_TIP (TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KD_TIP ***
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on KD_TIP          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KD_TIP          to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on KD_TIP          to KD_888;
grant SELECT                                                                 on KD_TIP          to RCC_DEAL;
grant FLASHBACK,SELECT                                                       on KD_TIP          to WR_REFREAD;



PROMPT *** Create SYNONYM  to KD_TIP ***

  CREATE OR REPLACE PUBLIC SYNONYM KD_TIP FOR BARS.KD_TIP;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KD_TIP.sql =========*** End *** ======
PROMPT ===================================================================================== 
