

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BMS_TMP_MSG_UIDS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BMS_TMP_MSG_UIDS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BMS_TMP_MSG_UIDS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BMS_TMP_MSG_UIDS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BMS_TMP_MSG_UIDS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BMS_TMP_MSG_UIDS ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.BMS_TMP_MSG_UIDS 
   (	USER_ID NUMBER(38,0)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BMS_TMP_MSG_UIDS ***
 exec bpa.alter_policies('BMS_TMP_MSG_UIDS');


COMMENT ON TABLE BARS.BMS_TMP_MSG_UIDS IS 'Временная таблица с идентификаторами пользователей, кому необх. отослать сообщение';
COMMENT ON COLUMN BARS.BMS_TMP_MSG_UIDS.USER_ID IS 'ID користувача';



PROMPT *** Create  grants  BMS_TMP_MSG_UIDS ***
grant SELECT                                                                 on BMS_TMP_MSG_UIDS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BMS_TMP_MSG_UIDS.sql =========*** End 
PROMPT ===================================================================================== 
