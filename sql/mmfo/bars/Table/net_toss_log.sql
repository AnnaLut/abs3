

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/net_toss_log.sql =========*** Run *** 
PROMPT ===================================================================================== 





BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''net_toss_log'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''net_toss_log'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''net_toss_log'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/


begin 
  execute immediate '
  CREATE TABLE BARS.net_toss_log
   (	rec_id       number        ,
	rec_date     date          , 
	rec_bdate    date          , 
	rec_type     varchar2(50)  , 
	rec_message  varchar2(2000),
    rec_uname    varchar2(100) ,    
    phase        varchar2(10)  
   )  tablespace brsdynd
 PARTITION BY LIST (phase) 
     (
     PARTITION phase_sbon    VALUES (''SBON'')  TABLESPACE brsdynd,
     PARTITION phase_cl      VALUES (''CL'')    TABLESPACE brsdynd,
     PARTITION phase_corp2   VALUES (''CORP2'') TABLESPACE brsdynd,
     PARTITION phase_bpk     VALUES (''DOGBPK'')   TABLESPACE brsdynd,
     PARTITION phase_all     VALUES (DEFAULT)
     )'; 
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/



begin 
  execute immediate '
CREATE INDEX xie_nettosslog_phasedat  ON net_toss_log (phase, rec_date) LOCAL
 (PARTITION phase_sbon    TABLESPACE brsdyni,
  PARTITION phase_cl      TABLESPACE brsdyni,
  PARTITION phase_corp2   TABLESPACE brsdyni,
  PARTITION phase_dogbpk  TABLESPACE brsdyni,
  PARTITION phase_all     TABLESPACE brsdyni)';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/



exec bpa.alter_policies('net_toss_log');


COMMENT ON TABLE BARS.net_toss_log IS 'Протокол работы вертушек net.toss';


PROMPT *** Create  constraint xpk_nettosslog ***
begin   
 execute immediate 'ALTER TABLE BARS.net_toss_log ADD CONSTRAINT xpk_nettosslog  primary key  (rec_id)  USING INDEX  TABLESPACE BRSDYNI';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/









grant SELECT                                                                 on net_toss_log    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on net_toss_log    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/xpk_nettosslog.sql =========*** End *** 
PROMPT ===================================================================================== 
