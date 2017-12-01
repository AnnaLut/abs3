

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_FORMA3_DM.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_FORMA3_DM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_FORMA3_DM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FORMA3_DM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FORMA3_DM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_FORMA3_DM ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_FORMA3_DM 
   (	FDAT DATE, 
		OKPO NUMBER, 
		ID NUMBER, 
		COLUM3 NUMBER, 
		COLUM4 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_FORMA3_DM ***
 exec bpa.alter_policies('FIN_FORMA3_DM');


COMMENT ON TABLE BARS.FIN_FORMA3_DM IS 'Дані по формі3';
COMMENT ON COLUMN BARS.FIN_FORMA3_DM.FDAT IS '';
COMMENT ON COLUMN BARS.FIN_FORMA3_DM.OKPO IS 'Код окпо';
COMMENT ON COLUMN BARS.FIN_FORMA3_DM.ID IS '';
COMMENT ON COLUMN BARS.FIN_FORMA3_DM.COLUM3 IS 'За звітний період(Форма3) надходження(форма3 з непрямий метод) ';
COMMENT ON COLUMN BARS.FIN_FORMA3_DM.COLUM4 IS '                          видаток(форма3 з непрямий метод)';




PROMPT *** Create  constraint FK_FINFORMA3DM_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_FORMA3_DM ADD CONSTRAINT FK_FINFORMA3DM_ID FOREIGN KEY (ID)
	  REFERENCES BARS.FIN_FORMA3_REF (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_FIN_FORMA3_DM ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_FORMA3_DM ADD CONSTRAINT XPK_FIN_FORMA3_DM PRIMARY KEY (FDAT, OKPO, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_FORMA3_DM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_FORMA3_DM ON BARS.FIN_FORMA3_DM (FDAT, OKPO, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_FORMA3_DM ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_FORMA3_DM   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_FORMA3_DM   to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_FORMA3_DM.sql =========*** End ***
PROMPT ===================================================================================== 
