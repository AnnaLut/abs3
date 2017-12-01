

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_FM.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_FM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_FM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_FM ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_FM 
   (	OKPO NUMBER, 
		FDAT DATE, 
		FM CHAR(1) DEFAULT '' '', 
		DATE_F1  DATE DEFAULT sysdate, 
		DATE_F2  DATE DEFAULT sysdate, 
		DATE_F3  DATE DEFAULT sysdate, 
		DATE_F3N DATE DEFAULT sysdate, 
		VED VARCHAR2(5)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/



begin 
  execute immediate 
    ' ALTER TABLE BARS.FIN_FM ADD (DATE_F3 DATE)';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/


begin 
  execute immediate 
    ' ALTER TABLE BARS.FIN_FM ADD (DATE_F3N DATE)';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

PROMPT *** ALTER_POLICIES to FIN_FM ***
 exec bpa.alter_policies('FIN_FM');


COMMENT ON TABLE BARS.FIN_FM IS 'История изменения формы отчета клиента';
COMMENT ON COLUMN BARS.FIN_FM.OKPO IS 'Код ОКПО клиента';
COMMENT ON COLUMN BARS.FIN_FM.FDAT IS 'Дата изменения';
COMMENT ON COLUMN BARS.FIN_FM.FM IS 'Форма "М" или " "';
COMMENT ON COLUMN BARS.FIN_FM.DATE_F1 IS 'Дата збереження Форми 1';
COMMENT ON COLUMN BARS.FIN_FM.DATE_F2 IS 'Дата збереження Форми 2';
COMMENT ON COLUMN BARS.FIN_FM.VED IS 'КВЕД';
COMMENT ON COLUMN BARS.FIN_FM.DATE_F3  IS 'Дата збереження Форми 3';
COMMENT ON COLUMN BARS.FIN_FM.DATE_F3N IS 'Дата збереження Форми 3 непрямий метод';




PROMPT *** Create  constraint CC_FIN_FM_FM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_FM MODIFY (FM CONSTRAINT CC_FIN_FM_FM_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_FIN_FM ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_FM ADD CONSTRAINT XPK_FIN_FM PRIMARY KEY (OKPO, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_FM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_FM ON BARS.FIN_FM (OKPO, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_FM ***
grant SELECT                                                                 on FIN_FM          to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_FM          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_FM          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_FM          to RCC_DEAL;
grant SELECT                                                                 on FIN_FM          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_FM          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_FM.sql =========*** End *** ======
PROMPT ===================================================================================== 
