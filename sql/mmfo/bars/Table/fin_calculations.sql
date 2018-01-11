

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_CALCULATIONS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_CALCULATIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_CALCULATIONS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FIN_CALCULATIONS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''FIN_CALCULATIONS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_CALCULATIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_CALCULATIONS 
   (	RNK NUMBER, 
	ND NUMBER, 
	DAT DATE, 
	FDAT DATE, 
	DATD DATE, 
	FIN23 NUMBER, 
	OBS23 NUMBER, 
	KAT23 NUMBER, 
	K23 NUMBER, 
	VED CHAR(5), 
	VNKR VARCHAR2(3), 
	TIP_V NUMBER, 
	DAT_NEXT DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_CALCULATIONS ***
 exec bpa.alter_policies('FIN_CALCULATIONS');


COMMENT ON TABLE BARS.FIN_CALCULATIONS IS 'Розрахунки  фінстану';
COMMENT ON COLUMN BARS.FIN_CALCULATIONS.RNK IS 'РНК клієнта';
COMMENT ON COLUMN BARS.FIN_CALCULATIONS.ND IS 'Референс угоди';
COMMENT ON COLUMN BARS.FIN_CALCULATIONS.DAT IS 'Звітна дата';
COMMENT ON COLUMN BARS.FIN_CALCULATIONS.FDAT IS 'Дата формування';
COMMENT ON COLUMN BARS.FIN_CALCULATIONS.DATD IS 'Дата та час розрахунку';
COMMENT ON COLUMN BARS.FIN_CALCULATIONS.FIN23 IS 'Клас Постанова НБУ23';
COMMENT ON COLUMN BARS.FIN_CALCULATIONS.OBS23 IS 'Стан обслуговування боргу Постанова НБУ 23';
COMMENT ON COLUMN BARS.FIN_CALCULATIONS.KAT23 IS 'Категорія Постанова НБУ23';
COMMENT ON COLUMN BARS.FIN_CALCULATIONS.K23 IS 'Коофіциент покриття боргу Постанова НБУ 23';
COMMENT ON COLUMN BARS.FIN_CALCULATIONS.VED IS 'КВЕД';
COMMENT ON COLUMN BARS.FIN_CALCULATIONS.VNKR IS '';
COMMENT ON COLUMN BARS.FIN_CALCULATIONS.TIP_V IS 'Тип висновку 1 -поточний, 2-попередній';
COMMENT ON COLUMN BARS.FIN_CALCULATIONS.DAT_NEXT IS 'Дата наступного розрахунку';
COMMENT ON COLUMN BARS.FIN_CALCULATIONS.KF IS '';




PROMPT *** Create  constraint SYS_C004901 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_CALCULATIONS MODIFY (DATD NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FIN_CALCULATIONS ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_CALCULATIONS ADD CONSTRAINT PK_FIN_CALCULATIONS PRIMARY KEY (RNK, ND, DAT, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINCALCULATIONS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_CALCULATIONS MODIFY (KF CONSTRAINT CC_FINCALCULATIONS_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FIN_CALCULATIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FIN_CALCULATIONS ON BARS.FIN_CALCULATIONS (RNK, ND, DAT, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_CALCULATIONS ***
grant SELECT                                                                 on FIN_CALCULATIONS to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_CALCULATIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_CALCULATIONS to BARS_DM;
grant SELECT                                                                 on FIN_CALCULATIONS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_CALCULATIONS.sql =========*** End 
PROMPT ===================================================================================== 
