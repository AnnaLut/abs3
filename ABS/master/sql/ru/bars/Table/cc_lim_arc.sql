

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_LIM_ARC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_LIM_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_LIM_ARC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_LIM_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_LIM_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_LIM_ARC 
   (	ND NUMBER, 
	MDAT DATE, 
	FDAT DATE, 
	LIM2 NUMBER, 
	ACC NUMBER, 
	NOT_9129 NUMBER(*,0), 
	SUMG NUMBER, 
	SUMO NUMBER, 
	OTM NUMBER(*,0), 
	SUMK NUMBER, 
	NOT_SN NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	TYPM VARCHAR2(5)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_LIM_ARC ***
 exec bpa.alter_policies('CC_LIM_ARC');


COMMENT ON TABLE BARS.CC_LIM_ARC IS 'Архив ГПК';
COMMENT ON COLUMN BARS.CC_LIM_ARC.TYPM IS 'код модуля, который создал запись.';
COMMENT ON COLUMN BARS.CC_LIM_ARC.ND IS 'Реф КД';
COMMENT ON COLUMN BARS.CC_LIM_ARC.MDAT IS 'дата модиф.';
COMMENT ON COLUMN BARS.CC_LIM_ARC.FDAT IS 'Плат.дата';
COMMENT ON COLUMN BARS.CC_LIM_ARC.LIM2 IS '';
COMMENT ON COLUMN BARS.CC_LIM_ARC.ACC IS '';
COMMENT ON COLUMN BARS.CC_LIM_ARC.NOT_9129 IS '';
COMMENT ON COLUMN BARS.CC_LIM_ARC.SUMG IS '';
COMMENT ON COLUMN BARS.CC_LIM_ARC.SUMO IS '';
COMMENT ON COLUMN BARS.CC_LIM_ARC.OTM IS '';
COMMENT ON COLUMN BARS.CC_LIM_ARC.SUMK IS '';
COMMENT ON COLUMN BARS.CC_LIM_ARC.NOT_SN IS '';
COMMENT ON COLUMN BARS.CC_LIM_ARC.KF IS '';




PROMPT *** Create  constraint PK_CCLIMARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_ARC ADD CONSTRAINT PK_CCLIMARC PRIMARY KEY (ND, MDAT, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCLIMARC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_ARC MODIFY (KF CONSTRAINT CC_CCLIMARC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCLIMARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCLIMARC ON BARS.CC_LIM_ARC (ND, MDAT, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_LIM_ARC ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_LIM_ARC      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_LIM_ARC      to RCC_DEAL;
grant FLASHBACK,SELECT                                                       on CC_LIM_ARC      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_LIM_ARC.sql =========*** End *** ==
PROMPT ===================================================================================== 
