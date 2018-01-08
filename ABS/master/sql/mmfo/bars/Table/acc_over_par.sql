

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_OVER_PAR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_OVER_PAR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_OVER_PAR'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACC_OVER_PAR'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACC_OVER_PAR'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_OVER_PAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_OVER_PAR 
   (	PAR VARCHAR2(8), 
	VAL VARCHAR2(50), 
	COMM VARCHAR2(70), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_OVER_PAR ***
 exec bpa.alter_policies('ACC_OVER_PAR');


COMMENT ON TABLE BARS.ACC_OVER_PAR IS 'Параметры модуля овердрафты';
COMMENT ON COLUMN BARS.ACC_OVER_PAR.PAR IS 'Параметр';
COMMENT ON COLUMN BARS.ACC_OVER_PAR.VAL IS 'Значение';
COMMENT ON COLUMN BARS.ACC_OVER_PAR.COMM IS 'Комментарий';
COMMENT ON COLUMN BARS.ACC_OVER_PAR.KF IS '';




PROMPT *** Create  constraint FK_ACCOVERPAR_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_PAR ADD CONSTRAINT FK_ACCOVERPAR_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ACC_OVER_PAR_PAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_PAR MODIFY (PAR CONSTRAINT NK_ACC_OVER_PAR_PAR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCOVERPAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_PAR ADD CONSTRAINT PK_ACCOVERPAR PRIMARY KEY (KF, PAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCOVERPAR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCOVERPAR ON BARS.ACC_OVER_PAR (KF, PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_OVER_PAR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_PAR    to ABS_ADMIN;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on ACC_OVER_PAR    to BARS009;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_OVER_PAR    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_OVER_PAR    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_PAR    to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_PAR    to TECH005;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_PAR    to TECH006;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_OVER_PAR    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on ACC_OVER_PAR    to WR_REFREAD;



PROMPT *** Create SYNONYM  to ACC_OVER_PAR ***

  CREATE OR REPLACE PUBLIC SYNONYM ACC_OVER_PAR FOR BARS.ACC_OVER_PAR;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_OVER_PAR.sql =========*** End *** 
PROMPT ===================================================================================== 
