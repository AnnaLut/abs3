

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DOC_DIALOGREQ.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DOC_DIALOGREQ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DOC_DIALOGREQ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DOC_DIALOGREQ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DOC_DIALOGREQ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DOC_DIALOGREQ ***
begin 
  execute immediate '
  CREATE TABLE BARS.DOC_DIALOGREQ 
   (	DOC_ID VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DOC_DIALOGREQ ***
 exec bpa.alter_policies('DOC_DIALOGREQ');


COMMENT ON TABLE BARS.DOC_DIALOGREQ IS 'Список отчетов требующих заполнения диалога дополнительных атрибутов
(Максимальний (бажаний) розмір Кредиту)';
COMMENT ON COLUMN BARS.DOC_DIALOGREQ.DOC_ID IS '';




PROMPT *** Create  constraint DOC_DIALOGREQ_U01 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_DIALOGREQ ADD CONSTRAINT DOC_DIALOGREQ_U01 UNIQUE (DOC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009445 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_DIALOGREQ MODIFY (DOC_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index DOC_DIALOGREQ_U01 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.DOC_DIALOGREQ_U01 ON BARS.DOC_DIALOGREQ (DOC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DOC_DIALOGREQ ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DOC_DIALOGREQ   to ABS_ADMIN;
grant SELECT                                                                 on DOC_DIALOGREQ   to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DOC_DIALOGREQ   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DOC_DIALOGREQ   to BARS_DM;
grant SELECT                                                                 on DOC_DIALOGREQ   to UPLD;
grant FLASHBACK,SELECT                                                       on DOC_DIALOGREQ   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DOC_DIALOGREQ.sql =========*** End ***
PROMPT ===================================================================================== 
