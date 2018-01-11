

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GERC_AUDIT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GERC_AUDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GERC_AUDIT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GERC_AUDIT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GERC_AUDIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.GERC_AUDIT 
   (	DATE_RUN DATE DEFAULT sysdate, 
	EXTERNALDOCUMENT_ID VARCHAR2(30), 
	REC_MESSAGE VARCHAR2(2000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GERC_AUDIT ***
 exec bpa.alter_policies('GERC_AUDIT');


COMMENT ON TABLE BARS.GERC_AUDIT IS 'Журнал обработки операций ГЕРЦ';
COMMENT ON COLUMN BARS.GERC_AUDIT.DATE_RUN IS '';
COMMENT ON COLUMN BARS.GERC_AUDIT.EXTERNALDOCUMENT_ID IS 'Номер документа в системе ГЕРЦ';
COMMENT ON COLUMN BARS.GERC_AUDIT.REC_MESSAGE IS 'Сообщение';



PROMPT *** Create  grants  GERC_AUDIT ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on GERC_AUDIT      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GERC_AUDIT      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GERC_AUDIT.sql =========*** End *** ==
PROMPT ===================================================================================== 
