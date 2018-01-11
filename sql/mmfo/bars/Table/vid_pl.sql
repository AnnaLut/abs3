

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VID_PL.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VID_PL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VID_PL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VID_PL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VID_PL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VID_PL ***
begin 
  execute immediate '
  CREATE TABLE BARS.VID_PL 
   (	N_VP NUMBER(*,0), 
	VID_PL VARCHAR2(30), 
	N_GR NUMBER(*,0), 
	KOD NUMBER(*,0), 
	KOD_1 NUMBER(*,0), 
	KOD_B NUMBER(*,0), 
	PROC_KP NUMBER(6,2), 
	R013 CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VID_PL ***
 exec bpa.alter_policies('VID_PL');


COMMENT ON TABLE BARS.VID_PL IS '';
COMMENT ON COLUMN BARS.VID_PL.N_VP IS '';
COMMENT ON COLUMN BARS.VID_PL.VID_PL IS '';
COMMENT ON COLUMN BARS.VID_PL.N_GR IS '';
COMMENT ON COLUMN BARS.VID_PL.KOD IS '';
COMMENT ON COLUMN BARS.VID_PL.KOD_1 IS '';
COMMENT ON COLUMN BARS.VID_PL.KOD_B IS '';
COMMENT ON COLUMN BARS.VID_PL.PROC_KP IS '';
COMMENT ON COLUMN BARS.VID_PL.R013 IS '';



PROMPT *** Create  grants  VID_PL ***
grant SELECT                                                                 on VID_PL          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VID_PL          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VID_PL          to BARS_DM;
grant SELECT                                                                 on VID_PL          to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on VID_PL          to VID_PL;
grant FLASHBACK,SELECT                                                       on VID_PL          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VID_PL.sql =========*** End *** ======
PROMPT ===================================================================================== 
