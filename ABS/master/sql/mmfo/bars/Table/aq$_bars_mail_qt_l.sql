

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AQ$_BARS_MAIL_QT_L.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AQ$_BARS_MAIL_QT_L ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AQ$_BARS_MAIL_QT_L ***
begin 
  execute immediate '
  CREATE TABLE BARS.AQ$_BARS_MAIL_QT_L 
   (	MSGID RAW(16), 
	SUBSCRIBER# NUMBER, 
	NAME VARCHAR2(30), 
	ADDRESS# NUMBER, 
	DEQUEUE_TIME TIMESTAMP (6) WITH TIME ZONE, 
	TRANSACTION_ID VARCHAR2(30), 
	DEQUEUE_USER VARCHAR2(30), 
	FLAGS RAW(1)
   ) USAGE QUEUE PCTFREE 0 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to AQ$_BARS_MAIL_QT_L ***
 exec bpa.alter_policies('AQ$_BARS_MAIL_QT_L');


COMMENT ON TABLE BARS.AQ$_BARS_MAIL_QT_L IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_L.MSGID IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_L.SUBSCRIBER# IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_L.NAME IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_L.ADDRESS# IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_L.DEQUEUE_TIME IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_L.TRANSACTION_ID IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_L.DEQUEUE_USER IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_L.FLAGS IS '';



PROMPT *** Create  grants  AQ$_BARS_MAIL_QT_L ***
grant SELECT                                                                 on AQ$_BARS_MAIL_QT_L to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on AQ$_BARS_MAIL_QT_L to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AQ$_BARS_MAIL_QT_L to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on AQ$_BARS_MAIL_QT_L to START1;
grant SELECT                                                                 on AQ$_BARS_MAIL_QT_L to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AQ$_BARS_MAIL_QT_L.sql =========*** En
PROMPT ===================================================================================== 
