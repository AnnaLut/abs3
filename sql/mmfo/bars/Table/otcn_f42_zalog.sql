

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F42_ZALOG.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F42_ZALOG ***
BEGIN 
    execute immediate  
      'begin  
           bpa.alter_policy_info(''OTCN_F42_ZALOG'', ''FILIAL'' , null, null, null, null);
       end; 
      '; 
END; 
/


BEGIN 
    execute immediate 'drop table BARS.OTCN_F42_ZALOG cascade constraint'; 
exception when others then       
  if sqlcode=-942 then null; else raise; end if; 
END; 
/

PROMPT *** Create  table OTCN_F42_ZALOG ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_F42_ZALOG 
   (ACC NUMBER, 
	ACCS NUMBER, 
	RNKS NUMBER, 	
    ND NUMBER, 
	NBS CHAR(4), 
	R013 VARCHAR2(1), 
	OST NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to OTCN_F42_ZALOG ***
 exec bpa.alter_policies('OTCN_F42_ZALOG');

COMMENT ON TABLE BARS.OTCN_F42_ZALOG IS '“имчасова таблиц€ дл€ п≥дготовки даних по 42 файлу';
COMMENT ON COLUMN BARS.OTCN_F42_ZALOG.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_F42_ZALOG.ACCS IS '';
COMMENT ON COLUMN BARS.OTCN_F42_ZALOG.ND IS '';
COMMENT ON COLUMN BARS.OTCN_F42_ZALOG.NBS IS '';
COMMENT ON COLUMN BARS.OTCN_F42_ZALOG.R013 IS '';
COMMENT ON COLUMN BARS.OTCN_F42_ZALOG.OST IS '';




PROMPT *** Create  constraint SYS_C0010165 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F42_ZALOG MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint SYS_C0010166 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F42_ZALOG MODIFY (ACCS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  OTCN_F42_ZALOG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F42_ZALOG  to ABS_ADMIN;
grant SELECT                                                                 on OTCN_F42_ZALOG  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F42_ZALOG  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F42_ZALOG  to RPBN002;
grant SELECT                                                                 on OTCN_F42_ZALOG  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_F42_ZALOG  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F42_ZALOG.sql =========*** End **
PROMPT ===================================================================================== 
