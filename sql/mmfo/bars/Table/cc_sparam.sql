

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_SPARAM.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_SPARAM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_SPARAM'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_SPARAM'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_SPARAM'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_SPARAM ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_SPARAM 
   (	ACC NUMBER(38,0), 
	VIDD_9129 NUMBER(1,0), 
	DATG DATE, 
	SUMG NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_SPARAM ***
 exec bpa.alter_policies('CC_SPARAM');


COMMENT ON TABLE BARS.CC_SPARAM IS 'Спец.Парам по сч КД';
COMMENT ON COLUMN BARS.CC_SPARAM.ACC IS 'Внутренний номер сч';
COMMENT ON COLUMN BARS.CC_SPARAM.VIDD_9129 IS 'Вiдновл./невiдн.кред.лiнiя';
COMMENT ON COLUMN BARS.CC_SPARAM.DATG IS 'Найбл.дата платежу по ГПК';
COMMENT ON COLUMN BARS.CC_SPARAM.SUMG IS 'та сума(коп) по тiлу КД по ГПК';
COMMENT ON COLUMN BARS.CC_SPARAM.KF IS '';




PROMPT *** Create  constraint FK_CCSPARAM_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SPARAM ADD CONSTRAINT FK_CCSPARAM_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_V_9129 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SPARAM ADD CONSTRAINT FK_V_9129 FOREIGN KEY (VIDD_9129)
	  REFERENCES BARS.VID_9129 (VIDD_9129) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCSPARAM_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SPARAM ADD CONSTRAINT FK_CCSPARAM_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005108 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SPARAM MODIFY (ACC NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCSPARAM_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SPARAM MODIFY (KF CONSTRAINT CC_CCSPARAM_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_SPARAM ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SPARAM ADD CONSTRAINT XPK_SPARAM PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SPARAM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SPARAM ON BARS.CC_SPARAM (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_SPARAM ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CC_SPARAM       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_SPARAM       to BARS_DM;
grant SELECT                                                                 on CC_SPARAM       to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_SPARAM       to RCC_DEAL;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CC_SPARAM       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_SPARAM       to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to CC_SPARAM ***

  CREATE OR REPLACE PUBLIC SYNONYM CC_SPARAM FOR BARS.CC_SPARAM;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_SPARAM.sql =========*** End *** ===
PROMPT ===================================================================================== 
