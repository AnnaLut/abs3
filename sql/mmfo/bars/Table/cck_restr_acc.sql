

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_RESTR_ACC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_RESTR_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_RESTR_ACC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CCK_RESTR_ACC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CCK_RESTR_ACC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_RESTR_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_RESTR_ACC 
   (	ACC NUMBER, 
	FDAT DATE, 
	VID_RESTR NUMBER, 
	TXT VARCHAR2(250), 
	SUMR NUMBER DEFAULT 0, 
	FDAT_END DATE, 
	PR_NO NUMBER DEFAULT 1, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_RESTR_ACC ***
 exec bpa.alter_policies('CCK_RESTR_ACC');


COMMENT ON TABLE BARS.CCK_RESTR_ACC IS 'Дати та види реструктуризації рахунків, що не в КП';
COMMENT ON COLUMN BARS.CCK_RESTR_ACC.ACC IS '';
COMMENT ON COLUMN BARS.CCK_RESTR_ACC.FDAT IS '';
COMMENT ON COLUMN BARS.CCK_RESTR_ACC.VID_RESTR IS '';
COMMENT ON COLUMN BARS.CCK_RESTR_ACC.TXT IS '';
COMMENT ON COLUMN BARS.CCK_RESTR_ACC.SUMR IS '';
COMMENT ON COLUMN BARS.CCK_RESTR_ACC.FDAT_END IS '';
COMMENT ON COLUMN BARS.CCK_RESTR_ACC.PR_NO IS '';
COMMENT ON COLUMN BARS.CCK_RESTR_ACC.KF IS '';




PROMPT *** Create  constraint CC_CCKRESTRACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR_ACC MODIFY (KF CONSTRAINT CC_CCKRESTRACC_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCKRESTRACC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR_ACC ADD CONSTRAINT FK_CCKRESTRACC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCKRESTR_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCKRESTR_ACC ON BARS.CCK_RESTR_ACC (ACC, VID_RESTR, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_RESTR_ACC ***
grant SELECT                                                                 on CCK_RESTR_ACC   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_RESTR_ACC   to BARS_DM;
grant SELECT                                                                 on CCK_RESTR_ACC   to RCC_DEAL;



PROMPT *** Create SYNONYM  to CCK_RESTR_ACC ***

  CREATE OR REPLACE PUBLIC SYNONYM CCK_RESTR_ACC FOR BARS.CCK_RESTR_ACC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_RESTR_ACC.sql =========*** End ***
PROMPT ===================================================================================== 
