

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBK_CLIENT_ANALYSIS_ERRORS.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBK_CLIENT_ANALYSIS_ERRORS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBK_CLIENT_ANALYSIS_ERRORS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_CLIENT_ANALYSIS_ERRORS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_CLIENT_ANALYSIS_ERRORS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBK_CLIENT_ANALYSIS_ERRORS ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBK_CLIENT_ANALYSIS_ERRORS 
   (	BATCHID VARCHAR2(50), 
	KF VARCHAR2(6), 
	RNK NUMBER(38,0), 
	CODE VARCHAR2(50), 
	MSG VARCHAR2(500), 
	INSERT_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBK_CLIENT_ANALYSIS_ERRORS ***
 exec bpa.alter_policies('EBK_CLIENT_ANALYSIS_ERRORS');


COMMENT ON TABLE BARS.EBK_CLIENT_ANALYSIS_ERRORS IS 'Таблица ошибок возникших на стороне ЕБК при попытке формировать рекомендации';
COMMENT ON COLUMN BARS.EBK_CLIENT_ANALYSIS_ERRORS.BATCHID IS '';
COMMENT ON COLUMN BARS.EBK_CLIENT_ANALYSIS_ERRORS.KF IS '';
COMMENT ON COLUMN BARS.EBK_CLIENT_ANALYSIS_ERRORS.RNK IS '';
COMMENT ON COLUMN BARS.EBK_CLIENT_ANALYSIS_ERRORS.CODE IS '';
COMMENT ON COLUMN BARS.EBK_CLIENT_ANALYSIS_ERRORS.MSG IS '';
COMMENT ON COLUMN BARS.EBK_CLIENT_ANALYSIS_ERRORS.INSERT_DATE IS '';




PROMPT *** Create  index INDX_ECAERR_U2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.INDX_ECAERR_U2 ON BARS.EBK_CLIENT_ANALYSIS_ERRORS (KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBK_CLIENT_ANALYSIS_ERRORS ***
grant SELECT                                                                 on EBK_CLIENT_ANALYSIS_ERRORS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on EBK_CLIENT_ANALYSIS_ERRORS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBK_CLIENT_ANALYSIS_ERRORS to BARS_DM;
grant SELECT                                                                 on EBK_CLIENT_ANALYSIS_ERRORS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBK_CLIENT_ANALYSIS_ERRORS.sql =======
PROMPT ===================================================================================== 
