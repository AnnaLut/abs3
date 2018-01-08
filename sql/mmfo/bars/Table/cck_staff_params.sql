

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_STAFF_PARAMS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_STAFF_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_STAFF_PARAMS'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''CCK_STAFF_PARAMS'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''CCK_STAFF_PARAMS'', ''WHOLE'' , null, ''null'', ''null'', ''null'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_STAFF_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_STAFF_PARAMS 
   (	USER_ID NUMBER, 
	KF VARCHAR2(30), 
	PAR VARCHAR2(10), 
	VAL VARCHAR2(254), 
	COMM VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_STAFF_PARAMS ***
 exec bpa.alter_policies('CCK_STAFF_PARAMS');


COMMENT ON TABLE BARS.CCK_STAFF_PARAMS IS 'Кредиты: параметры для пользователей';
COMMENT ON COLUMN BARS.CCK_STAFF_PARAMS.USER_ID IS 'ID пользователя';
COMMENT ON COLUMN BARS.CCK_STAFF_PARAMS.KF IS '';
COMMENT ON COLUMN BARS.CCK_STAFF_PARAMS.PAR IS 'Параметр';
COMMENT ON COLUMN BARS.CCK_STAFF_PARAMS.VAL IS 'Значение';
COMMENT ON COLUMN BARS.CCK_STAFF_PARAMS.COMM IS 'Комментарий';




PROMPT *** Create  constraint XPK_CCK_STAFF_PARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_STAFF_PARAMS ADD CONSTRAINT XPK_CCK_STAFF_PARAMS PRIMARY KEY (USER_ID, PAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009846 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_STAFF_PARAMS MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009847 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_STAFF_PARAMS MODIFY (PAR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CCK_STAFF_PARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CCK_STAFF_PARAMS ON BARS.CCK_STAFF_PARAMS (USER_ID, PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_STAFF_PARAMS ***
grant SELECT                                                                 on CCK_STAFF_PARAMS to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_STAFF_PARAMS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_STAFF_PARAMS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_STAFF_PARAMS to RCC_DEAL;
grant SELECT                                                                 on CCK_STAFF_PARAMS to UPLD;
grant FLASHBACK,SELECT                                                       on CCK_STAFF_PARAMS to WR_REFREAD;



PROMPT *** Create SYNONYM  to CCK_STAFF_PARAMS ***

  CREATE OR REPLACE PUBLIC SYNONYM CCK_STAFF_PARAMS FOR BARS.CCK_STAFF_PARAMS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_STAFF_PARAMS.sql =========*** End 
PROMPT ===================================================================================== 
