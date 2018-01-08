

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPR_SB.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPR_SB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPR_SB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SPR_SB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SPR_SB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPR_SB ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPR_SB 
   (	NAME CHAR(8), 
	TXT VARCHAR2(48), 
	MODE_DEL CHAR(1), 
	PR_SAVE CHAR(1), 
	POLE_IND VARCHAR2(30), 
	NAME_IND VARCHAR2(12), 
	DLSTRN NUMBER(*,0), 
	FORMFEED CHAR(1), 
	POLE_IND2 VARCHAR2(25), 
	FILTR_2 VARCHAR2(25), 
	PR_VIBOR CHAR(1)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPR_SB ***
 exec bpa.alter_policies('SPR_SB');


COMMENT ON TABLE BARS.SPR_SB IS '';
COMMENT ON COLUMN BARS.SPR_SB.NAME IS '';
COMMENT ON COLUMN BARS.SPR_SB.TXT IS '';
COMMENT ON COLUMN BARS.SPR_SB.MODE_DEL IS '';
COMMENT ON COLUMN BARS.SPR_SB.PR_SAVE IS '';
COMMENT ON COLUMN BARS.SPR_SB.POLE_IND IS '';
COMMENT ON COLUMN BARS.SPR_SB.NAME_IND IS '';
COMMENT ON COLUMN BARS.SPR_SB.DLSTRN IS '';
COMMENT ON COLUMN BARS.SPR_SB.FORMFEED IS '';
COMMENT ON COLUMN BARS.SPR_SB.POLE_IND2 IS '';
COMMENT ON COLUMN BARS.SPR_SB.FILTR_2 IS '';
COMMENT ON COLUMN BARS.SPR_SB.PR_VIBOR IS '';



PROMPT *** Create  grants  SPR_SB ***
grant SELECT                                                                 on SPR_SB          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPR_SB          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPR_SB          to START1;
grant SELECT                                                                 on SPR_SB          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPR_SB.sql =========*** End *** ======
PROMPT ===================================================================================== 
