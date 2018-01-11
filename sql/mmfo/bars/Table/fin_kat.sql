

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_KAT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_KAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_KAT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_KAT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_KAT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_KAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_KAT 
   (	KAT23 NUMBER(1,0), 
	K NUMBER(8,2), 
	FIN23 NUMBER(1,0), 
	OBS23 NUMBER(1,0), 
	VNCRR VARCHAR2(3), 
	IP1 NUMBER(1,0), 
	IP2 NUMBER(1,0), 
	IP3 NUMBER(1,0), 
	IP4 NUMBER(1,0), 
	IP5 NUMBER(1,0), 
	K2 NUMBER(8,2), 
	IDF NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_KAT ***
 exec bpa.alter_policies('FIN_KAT');


COMMENT ON TABLE BARS.FIN_KAT IS 'Значення показників ризику фінстану НБУ№23 для Ощадбанк';
COMMENT ON COLUMN BARS.FIN_KAT.KAT23 IS 'Категорія якості';
COMMENT ON COLUMN BARS.FIN_KAT.K IS 'Значення показнику ризику';
COMMENT ON COLUMN BARS.FIN_KAT.FIN23 IS 'Клас боржника';
COMMENT ON COLUMN BARS.FIN_KAT.OBS23 IS 'Стан обслуговування боргу';
COMMENT ON COLUMN BARS.FIN_KAT.VNCRR IS 'Мінімальне значення ВКР';
COMMENT ON COLUMN BARS.FIN_KAT.IP1 IS 'Мін. зн. Кредитна історія';
COMMENT ON COLUMN BARS.FIN_KAT.IP2 IS 'Мін. зн. Кофіциент покриття боргу';
COMMENT ON COLUMN BARS.FIN_KAT.IP3 IS 'Мін. зн. Менеджмент та ринки';
COMMENT ON COLUMN BARS.FIN_KAT.IP4 IS 'Мін. зн. Виконання БП та ТЕО';
COMMENT ON COLUMN BARS.FIN_KAT.IP5 IS 'Мін. зн. Інша негативна інформація';
COMMENT ON COLUMN BARS.FIN_KAT.K2 IS 'Значення показнику ризику при не виконанні субєктивних показників ';
COMMENT ON COLUMN BARS.FIN_KAT.IDF IS '';




PROMPT *** Create  constraint CC_FIN_KAT_KAT23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_KAT MODIFY (KAT23 CONSTRAINT CC_FIN_KAT_KAT23 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FIN_KAT_FIN23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_KAT MODIFY (FIN23 CONSTRAINT CC_FIN_KAT_FIN23 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FIN_KAT_OBS23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_KAT MODIFY (OBS23 CONSTRAINT CC_FIN_KAT_OBS23 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FIN_KAT_IDF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_KAT MODIFY (IDF CONSTRAINT CC_FIN_KAT_IDF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FINKAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_KAT ADD CONSTRAINT PK_FINKAT PRIMARY KEY (FIN23, OBS23, KAT23, IDF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FINKAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FINKAT ON BARS.FIN_KAT (FIN23, OBS23, KAT23, IDF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_KAT ***
grant SELECT                                                                 on FIN_KAT         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_KAT         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_KAT         to BARS_DM;
grant SELECT                                                                 on FIN_KAT         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_KAT.sql =========*** End *** =====
PROMPT ===================================================================================== 
