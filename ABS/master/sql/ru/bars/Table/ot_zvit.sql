

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OT_ZVIT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OT_ZVIT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OT_ZVIT ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OT_ZVIT 
   (	ID_REC NUMBER(38,0), 
	ID_REP NUMBER(38,0), 
	ID_SORT NUMBER(38,0), 
	TP NUMBER(1,0) DEFAULT 0, 
	NAME1 VARCHAR2(250), 
	NAME2 VARCHAR2(250), 
	NAME3 VARCHAR2(250), 
	COL1 NUMBER(38,3), 
	COL2 NUMBER(38,3), 
	COL3 NUMBER(38,3), 
	COL4 NUMBER(38,3), 
	COL5 NUMBER(38,3), 
	COL6 NUMBER(38,3), 
	COL7 NUMBER(38,3), 
	COL8 NUMBER(38,3), 
	COL9 NUMBER(38,3), 
	COL10 NUMBER(38,3), 
	COL11 NUMBER(38,3), 
	COL12 NUMBER(38,3)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OT_ZVIT ***
 exec bpa.alter_policies('OT_ZVIT');


COMMENT ON TABLE BARS.OT_ZVIT IS 'Временная таблица для формирования централиз.отчетности';
COMMENT ON COLUMN BARS.OT_ZVIT.ID_REC IS '';
COMMENT ON COLUMN BARS.OT_ZVIT.ID_REP IS '';
COMMENT ON COLUMN BARS.OT_ZVIT.ID_SORT IS '';
COMMENT ON COLUMN BARS.OT_ZVIT.TP IS '';
COMMENT ON COLUMN BARS.OT_ZVIT.NAME1 IS '';
COMMENT ON COLUMN BARS.OT_ZVIT.NAME2 IS '';
COMMENT ON COLUMN BARS.OT_ZVIT.NAME3 IS '';
COMMENT ON COLUMN BARS.OT_ZVIT.COL1 IS '';
COMMENT ON COLUMN BARS.OT_ZVIT.COL2 IS '';
COMMENT ON COLUMN BARS.OT_ZVIT.COL3 IS '';
COMMENT ON COLUMN BARS.OT_ZVIT.COL4 IS '';
COMMENT ON COLUMN BARS.OT_ZVIT.COL5 IS '';
COMMENT ON COLUMN BARS.OT_ZVIT.COL6 IS '';
COMMENT ON COLUMN BARS.OT_ZVIT.COL7 IS '';
COMMENT ON COLUMN BARS.OT_ZVIT.COL8 IS '';
COMMENT ON COLUMN BARS.OT_ZVIT.COL9 IS '';
COMMENT ON COLUMN BARS.OT_ZVIT.COL10 IS '';
COMMENT ON COLUMN BARS.OT_ZVIT.COL11 IS '';
COMMENT ON COLUMN BARS.OT_ZVIT.COL12 IS '';




PROMPT *** Create  constraint PK_OTZVIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.OT_ZVIT ADD CONSTRAINT PK_OTZVIT PRIMARY KEY (ID_REC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTZVIT_IDSORT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OT_ZVIT MODIFY (ID_SORT CONSTRAINT CC_OTZVIT_IDSORT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTZVIT_IDREP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OT_ZVIT MODIFY (ID_REP CONSTRAINT CC_OTZVIT_IDREP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTZVIT_IDREC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OT_ZVIT MODIFY (ID_REC CONSTRAINT CC_OTZVIT_IDREC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OTZVIT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OTZVIT ON BARS.OT_ZVIT (ID_REC) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OT_ZVIT ***
grant SELECT                                                                 on OT_ZVIT         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OT_ZVIT         to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OT_ZVIT         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OT_ZVIT.sql =========*** End *** =====
PROMPT ===================================================================================== 
