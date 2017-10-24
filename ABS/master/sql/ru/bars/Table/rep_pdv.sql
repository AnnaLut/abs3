

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REP_PDV.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REP_PDV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REP_PDV'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REP_PDV'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REP_PDV ***
begin 
  execute immediate '
  CREATE TABLE BARS.REP_PDV 
   (	ID NUMBER(*,0) DEFAULT 0, 
	NN NUMBER(*,0), 
	NBS_DT CHAR(4), 
	OB22_DT CHAR(2), 
	NBS_KT CHAR(4), 
	OB22_KT CHAR(2), 
	NLS_DT VARCHAR2(14), 
	NLS_KT VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REP_PDV ***
 exec bpa.alter_policies('REP_PDV');


COMMENT ON TABLE BARS.REP_PDV IS '';
COMMENT ON COLUMN BARS.REP_PDV.ID IS '';
COMMENT ON COLUMN BARS.REP_PDV.NN IS '';
COMMENT ON COLUMN BARS.REP_PDV.NBS_DT IS '';
COMMENT ON COLUMN BARS.REP_PDV.OB22_DT IS '';
COMMENT ON COLUMN BARS.REP_PDV.NBS_KT IS '';
COMMENT ON COLUMN BARS.REP_PDV.OB22_KT IS '';
COMMENT ON COLUMN BARS.REP_PDV.NLS_DT IS '';
COMMENT ON COLUMN BARS.REP_PDV.NLS_KT IS '';




PROMPT *** Create  constraint SYS_C001461507 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REP_PDV MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REP_PDV ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REP_PDV         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REP_PDV         to NALOG;
grant FLASHBACK,SELECT                                                       on REP_PDV         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REP_PDV.sql =========*** End *** =====
PROMPT ===================================================================================== 
