

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_CUST.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_CUST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_CUST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_CUST'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''FIN_CUST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_CUST ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_CUST 
   (	NMK VARCHAR2(38), 
	OKPO VARCHAR2(14), 
	CUSTTYPE NUMBER(*,0), 
	FZ CHAR(1), 
	ISP NUMBER(*,0), 
	VED CHAR(5), 
	DATEA DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_CUST ***
 exec bpa.alter_policies('FIN_CUST');


COMMENT ON TABLE BARS.FIN_CUST IS 'Незарег.Клиенты в анализе Фин.стану';
COMMENT ON COLUMN BARS.FIN_CUST.NMK IS 'Наименование клиента';
COMMENT ON COLUMN BARS.FIN_CUST.OKPO IS 'ОКПО(числовое) или РНК';
COMMENT ON COLUMN BARS.FIN_CUST.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.FIN_CUST.FZ IS 'Форма звiту=" " или M(лат)';
COMMENT ON COLUMN BARS.FIN_CUST.ISP IS 'Ответ.Исполнитель в банке';
COMMENT ON COLUMN BARS.FIN_CUST.VED IS 'Дата реєстрації підприемства';
COMMENT ON COLUMN BARS.FIN_CUST.DATEA IS '';
COMMENT ON COLUMN BARS.FIN_CUST.KF IS '';




PROMPT *** Create  constraint XPK_FIN_CUST ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_CUST ADD CONSTRAINT XPK_FIN_CUST PRIMARY KEY (OKPO, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_CUST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_CUST ON BARS.FIN_CUST (OKPO, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_CUST ***
grant SELECT                                                                 on FIN_CUST        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_CUST        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_CUST        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_CUST        to R_FIN2;
grant SELECT                                                                 on FIN_CUST        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_CUST        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_CUST.sql =========*** End *** ====
PROMPT ===================================================================================== 
