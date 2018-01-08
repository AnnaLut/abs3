

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_FE9.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_FE9 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_FE9'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_FE9'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KL_FE9'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_FE9 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_FE9 
   (	NLSD VARCHAR2(15), 
	KV NUMBER, 
	NLSK VARCHAR2(15), 
	D060 VARCHAR2(2), 
	TT VARCHAR2(3), 
	COMM VARCHAR2(60), 
	PR_DEL NUMBER, 
	OB22 VARCHAR2(2), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_FE9 ***
 exec bpa.alter_policies('KL_FE9');


COMMENT ON TABLE BARS.KL_FE9 IS 'Довiдник особових рах. для вiдбору док-тiв в файл #E9';
COMMENT ON COLUMN BARS.KL_FE9.NLSD IS 'Особовий рах. Дт';
COMMENT ON COLUMN BARS.KL_FE9.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.KL_FE9.NLSK IS 'Особовий рах. Кт';
COMMENT ON COLUMN BARS.KL_FE9.D060 IS 'Мiжн. код системи переказiв';
COMMENT ON COLUMN BARS.KL_FE9.TT IS 'Код операцii';
COMMENT ON COLUMN BARS.KL_FE9.COMM IS 'Коментар';
COMMENT ON COLUMN BARS.KL_FE9.PR_DEL IS 'Признак знищення (0-знищувати,1-включати в обробку)';
COMMENT ON COLUMN BARS.KL_FE9.OB22 IS 'Параметр OB22';
COMMENT ON COLUMN BARS.KL_FE9.KF IS '';




PROMPT *** Create  constraint CC_KLFE9_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_FE9 MODIFY (KF CONSTRAINT CC_KLFE9_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_KL_FE9 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_KL_FE9 ON BARS.KL_FE9 (KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_FE9 ***
grant SELECT                                                                 on KL_FE9          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_FE9          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_FE9          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_FE9          to RPBN002;
grant SELECT                                                                 on KL_FE9          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_FE9          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KL_FE9          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_FE9.sql =========*** End *** ======
PROMPT ===================================================================================== 
