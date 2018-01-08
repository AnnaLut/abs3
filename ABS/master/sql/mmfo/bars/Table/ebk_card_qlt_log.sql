

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBK_CARD_QLT_LOG.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBK_CARD_QLT_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBK_CARD_QLT_LOG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_CARD_QLT_LOG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_CARD_QLT_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBK_CARD_QLT_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBK_CARD_QLT_LOG 
   (	RNK NUMBER(38,0), 
	DATE_UPDATED DATE, 
	USER_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBK_CARD_QLT_LOG ***
 exec bpa.alter_policies('EBK_CARD_QLT_LOG');


COMMENT ON TABLE BARS.EBK_CARD_QLT_LOG IS 'Таблица логирования изменений над карточкой в АРМ Качестве';
COMMENT ON COLUMN BARS.EBK_CARD_QLT_LOG.RNK IS '';
COMMENT ON COLUMN BARS.EBK_CARD_QLT_LOG.DATE_UPDATED IS '';
COMMENT ON COLUMN BARS.EBK_CARD_QLT_LOG.USER_ID IS '';




PROMPT *** Create  index INDX_EBK_CARD_QLT_LOG ***
begin   
 execute immediate '
  CREATE INDEX BARS.INDX_EBK_CARD_QLT_LOG ON BARS.EBK_CARD_QLT_LOG (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBK_CARD_QLT_LOG ***
grant SELECT                                                                 on EBK_CARD_QLT_LOG to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on EBK_CARD_QLT_LOG to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBK_CARD_QLT_LOG to BARS_DM;
grant SELECT                                                                 on EBK_CARD_QLT_LOG to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBK_CARD_QLT_LOG.sql =========*** End 
PROMPT ===================================================================================== 
