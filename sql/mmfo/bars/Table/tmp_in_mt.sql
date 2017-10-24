

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_IN_MT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_IN_MT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_IN_MT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_IN_MT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_IN_MT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_IN_MT ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_IN_MT 
   (	ID_U NUMBER(*,0), 
	NBS NUMBER(*,0), 
	ACC NUMBER(*,0), 
	NLS VARCHAR2(15), 
	KV NUMBER(*,0), 
	FDAT DATE, 
	DAT_B DATE, 
	DAT_E DATE, 
	CP_IN VARCHAR2(2), 
	CP_MT VARCHAR2(2), 
	DOS NUMBER, 
	KOS NUMBER, 
	DEL NUMBER, 
	DOSN NUMBER, 
	KOSN NUMBER, 
	DELN NUMBER, 
	KV_C VARCHAR2(5), 
	N_OST NUMBER, 
	E_OST NUMBER, 
	DAY_K NUMBER(*,0), 
	DAY_F NUMBER(*,0), 
	DAY_O NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_IN_MT ***
 exec bpa.alter_policies('TMP_IN_MT');


COMMENT ON TABLE BARS.TMP_IN_MT IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.ID_U IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.NBS IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.ACC IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.NLS IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.KV IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.DAT_B IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.DAT_E IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.CP_IN IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.CP_MT IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.DOS IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.KOS IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.DEL IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.DOSN IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.KOSN IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.DELN IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.KV_C IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.N_OST IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.E_OST IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.DAY_K IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.DAY_F IS '';
COMMENT ON COLUMN BARS.TMP_IN_MT.DAY_O IS '';




PROMPT *** Create  constraint SYS_C008963 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_IN_MT MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_IN_MT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_IN_MT       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_IN_MT       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_IN_MT       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_IN_MT.sql =========*** End *** ===
PROMPT ===================================================================================== 
