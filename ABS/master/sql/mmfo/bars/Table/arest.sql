

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AREST.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AREST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''AREST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''AREST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''AREST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AREST ***
begin 
  execute immediate '
  CREATE TABLE BARS.AREST 
   (	NLS NUMBER(14,0), 
	BLS NUMBER(*,0), 
	CLI_KOD NUMBER(*,0), 
	I_VA NUMBER(*,0), 
	TYPE NUMBER(*,0), 
	CHAR_KA NUMBER(*,0), 
	VID NUMBER(*,0), 
	PS NUMBER(*,0), 
	SIO NUMBER(*,0), 
	KFIL NUMBER(*,0), 
	NK VARCHAR2(38), 
	DOP DATE, 
	DCL DATE, 
	VSH NUMBER(16,0), 
	DOS NUMBER(16,0), 
	KOS NUMBER(16,0), 
	ISH NUMBER(16,0), 
	VSH_V NUMBER(16,0), 
	DOS_V NUMBER(16,0), 
	KOS_V NUMBER(16,0), 
	ISH_V NUMBER(16,0), 
	DAPP DATE, 
	LIMIT NUMBER(16,0), 
	ISP NUMBER(*,0), 
	ABON CHAR(4), 
	CLI_ID VARCHAR2(14), 
	NLS_ALT NUMBER(*,0), 
	GROUP_C NUMBER(*,0), 
	REE_FLAG CHAR(2), 
	REE_DATE DATE, 
	OSN NUMBER(*,0), 
	GROUP_U NUMBER(*,0), 
	ANALIT CHAR(2), 
	KORG NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to AREST ***
 exec bpa.alter_policies('AREST');


COMMENT ON TABLE BARS.AREST IS '';
COMMENT ON COLUMN BARS.AREST.NLS IS '';
COMMENT ON COLUMN BARS.AREST.BLS IS '';
COMMENT ON COLUMN BARS.AREST.CLI_KOD IS '';
COMMENT ON COLUMN BARS.AREST.I_VA IS '';
COMMENT ON COLUMN BARS.AREST.TYPE IS '';
COMMENT ON COLUMN BARS.AREST.CHAR_KA IS '';
COMMENT ON COLUMN BARS.AREST.VID IS '';
COMMENT ON COLUMN BARS.AREST.PS IS '';
COMMENT ON COLUMN BARS.AREST.SIO IS '';
COMMENT ON COLUMN BARS.AREST.KFIL IS '';
COMMENT ON COLUMN BARS.AREST.NK IS '';
COMMENT ON COLUMN BARS.AREST.DOP IS '';
COMMENT ON COLUMN BARS.AREST.DCL IS '';
COMMENT ON COLUMN BARS.AREST.VSH IS '';
COMMENT ON COLUMN BARS.AREST.DOS IS '';
COMMENT ON COLUMN BARS.AREST.KOS IS '';
COMMENT ON COLUMN BARS.AREST.ISH IS '';
COMMENT ON COLUMN BARS.AREST.VSH_V IS '';
COMMENT ON COLUMN BARS.AREST.DOS_V IS '';
COMMENT ON COLUMN BARS.AREST.KOS_V IS '';
COMMENT ON COLUMN BARS.AREST.ISH_V IS '';
COMMENT ON COLUMN BARS.AREST.DAPP IS '';
COMMENT ON COLUMN BARS.AREST.LIMIT IS '';
COMMENT ON COLUMN BARS.AREST.ISP IS '';
COMMENT ON COLUMN BARS.AREST.ABON IS '';
COMMENT ON COLUMN BARS.AREST.CLI_ID IS '';
COMMENT ON COLUMN BARS.AREST.NLS_ALT IS '';
COMMENT ON COLUMN BARS.AREST.GROUP_C IS '';
COMMENT ON COLUMN BARS.AREST.REE_FLAG IS '';
COMMENT ON COLUMN BARS.AREST.REE_DATE IS '';
COMMENT ON COLUMN BARS.AREST.OSN IS '';
COMMENT ON COLUMN BARS.AREST.GROUP_U IS '';
COMMENT ON COLUMN BARS.AREST.ANALIT IS '';
COMMENT ON COLUMN BARS.AREST.KORG IS '';



PROMPT *** Create  grants  AREST ***
grant SELECT                                                                 on AREST           to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on AREST           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AREST           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on AREST           to START1;
grant SELECT                                                                 on AREST           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AREST.sql =========*** End *** =======
PROMPT ===================================================================================== 
