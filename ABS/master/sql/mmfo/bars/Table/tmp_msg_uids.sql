

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_MSG_UIDS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_MSG_UIDS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_MSG_UIDS ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_MSG_UIDS 
   (	USER_ID NUMBER(38,0)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_MSG_UIDS ***
 exec bpa.alter_policies('TMP_MSG_UIDS');


COMMENT ON TABLE BARS.TMP_MSG_UIDS IS 'Временная таблица с идентификаторами пользователей, кому необх. отослать сообщение';
COMMENT ON COLUMN BARS.TMP_MSG_UIDS.USER_ID IS 'ID користувача';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_MSG_UIDS.sql =========*** End *** 
PROMPT ===================================================================================== 
