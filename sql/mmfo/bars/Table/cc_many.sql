

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_MANY.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_MANY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_MANY'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_MANY'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_MANY'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_MANY ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_MANY 
   (	ND NUMBER(*,0), 
	FDAT DATE, 
	SS1 NUMBER, 
	SDP NUMBER, 
	SS2 NUMBER, 
	SN2 NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	P_SS NUMBER, 
	P_SN NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_MANY ***
 exec bpa.alter_policies('CC_MANY');


COMMENT ON TABLE BARS.CC_MANY IS 'План.Денежные потоки';
COMMENT ON COLUMN BARS.CC_MANY.ND IS 'Реф КД';
COMMENT ON COLUMN BARS.CC_MANY.FDAT IS 'Дата в потоке';
COMMENT ON COLUMN BARS.CC_MANY.SS1 IS 'Выдача';
COMMENT ON COLUMN BARS.CC_MANY.SDP IS 'Дополнительно(Дисконт-Премия)';
COMMENT ON COLUMN BARS.CC_MANY.SS2 IS 'Погашение кредита';
COMMENT ON COLUMN BARS.CC_MANY.SN2 IS 'Погашение %';
COMMENT ON COLUMN BARS.CC_MANY.KF IS '';
COMMENT ON COLUMN BARS.CC_MANY.P_SS IS 'План-Сумма Погашения кредита';
COMMENT ON COLUMN BARS.CC_MANY.P_SN IS 'План-Сумма Погашения процентов';




PROMPT *** Create  constraint FK_CCMANY_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_MANY ADD CONSTRAINT FK_CCMANY_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCMANY_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_MANY MODIFY (KF CONSTRAINT CC_CCMANY_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CC_MANY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_MANY ADD CONSTRAINT PK_CC_MANY PRIMARY KEY (ND, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CC_MANY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CC_MANY ON BARS.CC_MANY (ND, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_MANY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_MANY         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_MANY         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_MANY         to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_MANY         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to CC_MANY ***

  CREATE OR REPLACE PUBLIC SYNONYM CC_MANY FOR BARS.CC_MANY;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_MANY.sql =========*** End *** =====
PROMPT ===================================================================================== 
