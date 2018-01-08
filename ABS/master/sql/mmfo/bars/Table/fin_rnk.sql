

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_RNK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_RNK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_RNK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_RNK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_RNK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_RNK ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_RNK 
   (	FDAT DATE, 
	IDF NUMBER(*,0), 
	KOD VARCHAR2(4), 
	S NUMBER(24,3), 
	OKPO NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	SS NUMBER(24,3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_RNK ***
 exec bpa.alter_policies('FIN_RNK');


COMMENT ON TABLE BARS.FIN_RNK IS 'Фiн.звiти клiєнтiв';
COMMENT ON COLUMN BARS.FIN_RNK.FDAT IS 'Дата звiту';
COMMENT ON COLUMN BARS.FIN_RNK.IDF IS 'Форма';
COMMENT ON COLUMN BARS.FIN_RNK.KOD IS 'Код рядка';
COMMENT ON COLUMN BARS.FIN_RNK.S IS 'Показник поточний';
COMMENT ON COLUMN BARS.FIN_RNK.OKPO IS 'ОКПО(числовое) или РНК';
COMMENT ON COLUMN BARS.FIN_RNK.BRANCH IS '';
COMMENT ON COLUMN BARS.FIN_RNK.SS IS 'Значення для звіту';


begin 
  execute immediate 
    ' ALTER TABLE BARS.FIN_RNK  DROP CONSTRAINT XPK_FIN_RNK';
exception when others then 
  if sqlcode=-2443 then null; else raise; end if;
end;
/


delete from fin_rnk
 where  rowid not in (select min(rowid)  from fin_rnk group by okpo,  idf, fdat, kod );
commit;

begin 
  execute immediate 
    ' DROP INDEX BARS.XPK_FIN_RNK';
exception when others then 
  if sqlcode=-1418 then null; else raise; end if;
end;
/

PROMPT *** Create  constraint XPK_FIN_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_RNK ADD CONSTRAINT XPK_FIN_RNK PRIMARY KEY (OKPO, FDAT, IDF, KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FIN_RNK_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_RNK ADD CONSTRAINT FK_FIN_RNK_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FIN_RNK_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_RNK MODIFY (BRANCH CONSTRAINT CC_FIN_RNK_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_RNK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_RNK ON BARS.FIN_RNK (OKPO, FDAT, IDF, KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_RNK ***
grant SELECT                                                                 on FIN_RNK         to BARS009;
grant SELECT                                                                 on FIN_RNK         to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_RNK         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_RNK         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_RNK         to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_RNK         to R_FIN2;
grant SELECT                                                                 on FIN_RNK         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_RNK         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_RNK.sql =========*** End *** =====
PROMPT ===================================================================================== 
