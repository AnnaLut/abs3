

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GERC_SIGNS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GERC_SIGNS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GERC_SIGNS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GERC_SIGNS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GERC_SIGNS ***
begin 
  execute immediate '
  CREATE TABLE BARS.GERC_SIGNS 
   (	REC_DATE DATE DEFAULT SYSDATE, 
	EXTERNALDOCUMENTID VARCHAR2(32), 
	BUFFER VARCHAR2(4000), 
	DIGITALSIGNATURE CLOB, 
	VALIDATIONSTATUS VARCHAR2(10)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (DIGITALSIGNATURE) STORE AS BASICFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GERC_SIGNS ***
 exec bpa.alter_policies('GERC_SIGNS');


COMMENT ON TABLE BARS.GERC_SIGNS IS 'Операция, буфер, подпись от ГЕРЦ при валидации';
COMMENT ON COLUMN BARS.GERC_SIGNS.REC_DATE IS 'Дата валидации';
COMMENT ON COLUMN BARS.GERC_SIGNS.EXTERNALDOCUMENTID IS 'Ідентифікатор документа в системі Герц';
COMMENT ON COLUMN BARS.GERC_SIGNS.BUFFER IS 'Буфер (розрахований в АБС)';
COMMENT ON COLUMN BARS.GERC_SIGNS.DIGITALSIGNATURE IS 'Цифровий підпис vega2';
COMMENT ON COLUMN BARS.GERC_SIGNS.VALIDATIONSTATUS IS 'Статус валидации в сервисе';




PROMPT *** Create  constraint SYS_C00132296 ***
begin   
 execute immediate '
  ALTER TABLE BARS.GERC_SIGNS MODIFY (EXTERNALDOCUMENTID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GERC_SIGNS ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on GERC_SIGNS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GERC_SIGNS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GERC_SIGNS.sql =========*** End *** ==
PROMPT ===================================================================================== 
