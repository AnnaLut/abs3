

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PHONE_MOB_CODE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PHONE_MOB_CODE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PHONE_MOB_CODE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PHONE_MOB_CODE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PHONE_MOB_CODE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PHONE_MOB_CODE ***
begin 
  execute immediate '
  CREATE TABLE BARS.PHONE_MOB_CODE 
   (	CODE VARCHAR2(2), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PHONE_MOB_CODE ***
 exec bpa.alter_policies('PHONE_MOB_CODE');


COMMENT ON TABLE BARS.PHONE_MOB_CODE IS 'Коди моб. операторів';
COMMENT ON COLUMN BARS.PHONE_MOB_CODE.CODE IS '';
COMMENT ON COLUMN BARS.PHONE_MOB_CODE.NAME IS '';




PROMPT *** Create  constraint PK_PHONEMOBCODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PHONE_MOB_CODE ADD CONSTRAINT PK_PHONEMOBCODE PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PHONEMOBCODE_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PHONE_MOB_CODE MODIFY (CODE CONSTRAINT CC_PHONEMOBCODE_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PHONEMOBCODE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PHONE_MOB_CODE MODIFY (NAME CONSTRAINT CC_PHONEMOBCODE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PHONEMOBCODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PHONEMOBCODE ON BARS.PHONE_MOB_CODE (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PHONE_MOB_CODE ***
grant SELECT                                                                 on PHONE_MOB_CODE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PHONE_MOB_CODE  to BARS_DM;
grant SELECT                                                                 on PHONE_MOB_CODE  to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PHONE_MOB_CODE.sql =========*** End **
PROMPT ===================================================================================== 
