

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_RECIPIENTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_RECIPIENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_RECIPIENTS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAY_RECIPIENTS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ZAY_RECIPIENTS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_RECIPIENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_RECIPIENTS 
   (	URL VARCHAR2(256), 
	MFO VARCHAR2(10), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_RECIPIENTS ***
 exec bpa.alter_policies('ZAY_RECIPIENTS');


COMMENT ON TABLE BARS.ZAY_RECIPIENTS IS 'Довідник шляхів до вебсервісів РУ';
COMMENT ON COLUMN BARS.ZAY_RECIPIENTS.URL IS 'url сервісу на стороні РУ';
COMMENT ON COLUMN BARS.ZAY_RECIPIENTS.MFO IS 'МФО РУ';
COMMENT ON COLUMN BARS.ZAY_RECIPIENTS.KF IS '';




PROMPT *** Create  constraint CC_ZAYRECIPIENTS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_RECIPIENTS MODIFY (KF CONSTRAINT CC_ZAYRECIPIENTS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_RECIPIENTS ***
grant SELECT                                                                 on ZAY_RECIPIENTS  to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on ZAY_RECIPIENTS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_RECIPIENTS  to BARS_DM;
grant SELECT                                                                 on ZAY_RECIPIENTS  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_RECIPIENTS.sql =========*** End **
PROMPT ===================================================================================== 
