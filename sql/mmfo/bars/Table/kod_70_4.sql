

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_70_4.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_70_4 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_70_4'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_70_4'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_70_4'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_70_4 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_70_4 
   (	P70 CHAR(2), 
	TXT VARCHAR2(102), 
	DATA_O DATE, 
	DATA_C DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_70_4 ***
 exec bpa.alter_policies('KOD_70_4');


COMMENT ON TABLE BARS.KOD_70_4 IS '';
COMMENT ON COLUMN BARS.KOD_70_4.P70 IS '';
COMMENT ON COLUMN BARS.KOD_70_4.TXT IS '';
COMMENT ON COLUMN BARS.KOD_70_4.DATA_O IS '';
COMMENT ON COLUMN BARS.KOD_70_4.DATA_C IS '';




PROMPT *** Create  constraint PK_KOD_70_4 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KOD_70_4 ADD CONSTRAINT PK_KOD_70_4 PRIMARY KEY (P70)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KOD_70_4 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KOD_70_4 ON BARS.KOD_70_4 (P70) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KOD_70_4 ***
grant FLASHBACK,SELECT                                                       on KOD_70_4        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOD_70_4        to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KOD_70_4        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KOD_70_4        to WR_REFREAD;
grant SELECT                                                                 on KOD_70_4        to ZAY;



PROMPT *** Create SYNONYM  to KOD_70_4 ***

  CREATE OR REPLACE PUBLIC SYNONYM KOD_70_4 FOR BARS.KOD_70_4;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_70_4.sql =========*** End *** ====
PROMPT ===================================================================================== 
