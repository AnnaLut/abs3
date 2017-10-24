

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OB_KORR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OB_KORR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OB_KORR ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OB_KORR 
   (	FIN NUMBER(38,0), 
	OBS NUMBER(38,0), 
	VNCRR VARCHAR2(4), 
	KHIST NUMBER(38,0), 
	NEINF NUMBER(38,0), 
	KAT23 NUMBER(38,0), 
	K23 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OB_KORR ***
 exec bpa.alter_policies('TMP_OB_KORR');


COMMENT ON TABLE BARS.TMP_OB_KORR IS 'ОБ:Знач пок ризику для Банкiв-боржникiв';
COMMENT ON COLUMN BARS.TMP_OB_KORR.FIN IS 'Клас';
COMMENT ON COLUMN BARS.TMP_OB_KORR.OBS IS 'Обслуговування';
COMMENT ON COLUMN BARS.TMP_OB_KORR.VNCRR IS 'Min(ВН.кр.рейт)';
COMMENT ON COLUMN BARS.TMP_OB_KORR.KHIST IS 'Кр.iсторiя';
COMMENT ON COLUMN BARS.TMP_OB_KORR.NEINF IS 'Iнша негат.iнф.';
COMMENT ON COLUMN BARS.TMP_OB_KORR.KAT23 IS 'Кат.якостi';
COMMENT ON COLUMN BARS.TMP_OB_KORR.K23 IS 'Показник ризику';




PROMPT *** Create  constraint PK_TMPOBKORR ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OB_KORR ADD CONSTRAINT PK_TMPOBKORR PRIMARY KEY (FIN, OBS, VNCRR, KHIST, NEINF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPOBKORR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPOBKORR ON BARS.TMP_OB_KORR (FIN, OBS, VNCRR, KHIST, NEINF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_OB_KORR ***
grant SELECT                                                                 on TMP_OB_KORR     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_OB_KORR     to BARS_DM;
grant SELECT                                                                 on TMP_OB_KORR     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OB_KORR.sql =========*** End *** =
PROMPT ===================================================================================== 
