

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_PARAMS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_PARAMS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_PARAMS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_PARAMS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_PARAMS 
   (	PAR VARCHAR2(10), 
	VAL VARCHAR2(100), 
	COMM VARCHAR2(100), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_PARAMS ***
 exec bpa.alter_policies('OW_PARAMS');


COMMENT ON TABLE BARS.OW_PARAMS IS 'OpenWay. Параметри модуля';
COMMENT ON COLUMN BARS.OW_PARAMS.KF IS '';
COMMENT ON COLUMN BARS.OW_PARAMS.PAR IS 'Код параметру';
COMMENT ON COLUMN BARS.OW_PARAMS.VAL IS 'Значення';
COMMENT ON COLUMN BARS.OW_PARAMS.COMM IS 'Назва параметру';




PROMPT *** Create  constraint PK_OWPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PARAMS ADD CONSTRAINT PK_OWPARAMS PRIMARY KEY (PAR, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWPARAMS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PARAMS MODIFY (KF CONSTRAINT CC_OWPARAMS_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWPARAMS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PARAMS ADD CONSTRAINT FK_OWPARAMS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWPARAMS_PAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PARAMS MODIFY (PAR CONSTRAINT CC_OWPARAMS_PAR_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWPARAMS ON BARS.OW_PARAMS (PAR, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_PARAMS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OW_PARAMS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_PARAMS       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_PARAMS       to OW;
grant FLASHBACK,SELECT                                                       on OW_PARAMS       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_PARAMS.sql =========*** End *** ===
PROMPT ===================================================================================== 
