

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
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CLIM_MFO ***
 exec bpa.alter_policies('CLIM_MFO');


COMMENT ON TABLE BARS.CLIM_MFO IS '';
COMMENT ON COLUMN BARS.CLIM_MFO.MFO IS '';
COMMENT ON COLUMN BARS.CLIM_MFO.NAME IS '';
COMMENT ON COLUMN BARS.CLIM_MFO.ORD IS '';
COMMENT ON COLUMN BARS.CLIM_MFO.COD_OU IS '';
COMMENT ON COLUMN BARS.CLIM_MFO.KF IS '';




PROMPT *** Create  constraint SYS_C00109870 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLIM_MFO MODIFY (MFO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLIM_MFO ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CLIM_MFO        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CLIM_MFO.sql =========*** End *** ====
PROMPT ===================================================================================== 
