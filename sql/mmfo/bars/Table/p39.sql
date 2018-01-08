

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P39.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P39 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table P39 ***
begin 
  execute immediate '
  CREATE TABLE BARS.P39 
   (	NLS VARCHAR2(14), 
	KV NUMBER(*,0), 
	DATE_ST DATE, 
	PR NUMBER(10,4), 
	NLSN VARCHAR2(14), 
	NLSDR VARCHAR2(14), 
	ID NUMBER(*,0), 
	ACC NUMBER(*,0), 
	ACRA NUMBER(*,0), 
	ACRB NUMBER(*,0), 
	TT CHAR(3), 
	METR NUMBER(*,0), 
	BASEY NUMBER(*,0), 
	BASEM NUMBER(*,0), 
	FREQ NUMBER(*,0), 
	BR NUMBER(*,0), 
	DAPP DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to P39 ***
 exec bpa.alter_policies('P39');


COMMENT ON TABLE BARS.P39 IS '';
COMMENT ON COLUMN BARS.P39.NLS IS '';
COMMENT ON COLUMN BARS.P39.KV IS '';
COMMENT ON COLUMN BARS.P39.DATE_ST IS '';
COMMENT ON COLUMN BARS.P39.PR IS '';
COMMENT ON COLUMN BARS.P39.NLSN IS '';
COMMENT ON COLUMN BARS.P39.NLSDR IS '';
COMMENT ON COLUMN BARS.P39.ID IS '';
COMMENT ON COLUMN BARS.P39.ACC IS '';
COMMENT ON COLUMN BARS.P39.ACRA IS '';
COMMENT ON COLUMN BARS.P39.ACRB IS '';
COMMENT ON COLUMN BARS.P39.TT IS '';
COMMENT ON COLUMN BARS.P39.METR IS '';
COMMENT ON COLUMN BARS.P39.BASEY IS '';
COMMENT ON COLUMN BARS.P39.BASEM IS '';
COMMENT ON COLUMN BARS.P39.FREQ IS '';
COMMENT ON COLUMN BARS.P39.BR IS '';
COMMENT ON COLUMN BARS.P39.DAPP IS '';



PROMPT *** Create  grants  P39 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on P39             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on P39             to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on P39             to PROC_DR;
grant FLASHBACK,SELECT                                                       on P39             to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P39.sql =========*** End *** =========
PROMPT ===================================================================================== 
