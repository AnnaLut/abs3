

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MBK_CP.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MBK_CP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MBK_CP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MBK_CP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MBK_CP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MBK_CP ***
begin 
  execute immediate '
  CREATE TABLE BARS.MBK_CP 
   (	ND NUMBER, 
	ID NUMBER, 
	KOL NUMBER(*,0), 
	SASIN NUMBER(*,0), 
	ACC NUMBER, 
	REF NUMBER, 
	TIPD NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MBK_CP ***
 exec bpa.alter_policies('MBK_CP');


COMMENT ON TABLE BARS.MBK_CP IS 'Таблиця связи сделки репо-МБК и ЦБ в залоге';
COMMENT ON COLUMN BARS.MBK_CP.ND IS 'реф сделки МБК';
COMMENT ON COLUMN BARS.MBK_CP.ID IS 'Ид ЦБ в Абс';
COMMENT ON COLUMN BARS.MBK_CP.KOL IS 'Количество ЦБ переданных/принятых в залог';
COMMENT ON COLUMN BARS.MBK_CP.SASIN IS 'с правом собственности = 1. Иначе без права собственнорсти Реф КД АБС';
COMMENT ON COLUMN BARS.MBK_CP.ACC IS 'acc сч 9500/9510';
COMMENT ON COLUMN BARS.MBK_CP.REF IS 'реф блока проводок по привязке ЦБ';
COMMENT ON COLUMN BARS.MBK_CP.TIPD IS '';




PROMPT *** Create  constraint FK_MBKCP_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBK_CP ADD CONSTRAINT FK_MBKCP_ND FOREIGN KEY (ND)
	  REFERENCES BARS.CC_DEAL (ND) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_MBKCP_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBK_CP ADD CONSTRAINT FK_MBKCP_ID FOREIGN KEY (ID)
	  REFERENCES BARS.CP_KOD (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_MBKCP ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBK_CP ADD CONSTRAINT PK_MBKCP PRIMARY KEY (ND, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MBKCP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MBKCP ON BARS.MBK_CP (ND, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MBK_CP ***
grant SELECT                                                                 on MBK_CP          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MBK_CP          to BARS_DM;
grant SELECT                                                                 on MBK_CP          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MBK_CP.sql =========*** End *** ======
PROMPT ===================================================================================== 
