

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CLIM_MFO.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CLIM_MFO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CLIM_MFO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CLIM_MFO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CLIM_MFO ***
begin 
  execute immediate '
  CREATE TABLE BARS.CLIM_MFO 
   (	MFO VARCHAR2(6), 
	NAME VARCHAR2(50), 
	ORD NUMBER(2,0), 
	COD_OU VARCHAR2(2), 
	KF VARCHAR2(6), 
	KOD_S VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
PROMPT *** Add  columns KOD_S ***
begin 
execute immediate'
alter table CLIM_MFO add (
  KOD_S VARCHAR2(4 BYTE))';
exception
 when others 
 then 
 if sqlcode = -1430 then null; 
 else raise;
 end if;
end;
/


PROMPT *** ALTER_POLICIES to CLIM_MFO ***
 exec bpa.alter_policies('CLIM_MFO');


COMMENT ON TABLE BARS.CLIM_MFO IS '';
COMMENT ON COLUMN BARS.CLIM_MFO.KOD_S IS '';
COMMENT ON COLUMN BARS.CLIM_MFO.MFO IS '';
COMMENT ON COLUMN BARS.CLIM_MFO.NAME IS '';
COMMENT ON COLUMN BARS.CLIM_MFO.ORD IS '';
COMMENT ON COLUMN BARS.CLIM_MFO.COD_OU IS '';
COMMENT ON COLUMN BARS.CLIM_MFO.KF IS '';




PROMPT *** Create  constraint PK_CLIM_MFO ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLIM_MFO ADD CONSTRAINT PK_CLIM_MFO PRIMARY KEY (KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0016149 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLIM_MFO MODIFY (MFO NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CLIM_MFO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CLIM_MFO ON BARS.CLIM_MFO (KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLIM_MFO ***
grant SELECT                                                                 on CLIM_MFO        to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CLIM_MFO        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CLIM_MFO        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CLIM_MFO.sql =========*** End *** ====
PROMPT ===================================================================================== 

