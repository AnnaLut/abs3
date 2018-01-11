

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_VIDD.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_VIDD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_VIDD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_VIDD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CP_VIDD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_VIDD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_VIDD 
   (	VIDD NUMBER(38,0), 
	TIPD NUMBER(38,0), 
	NAME VARCHAR2(70), 
	PF NUMBER(38,0), 
	DOX NUMBER(38,0), 
	EMI NUMBER(38,0), 
	S605 VARCHAR2(15), 
	S605P VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_VIDD ***
 exec bpa.alter_policies('CP_VIDD');


COMMENT ON TABLE BARS.CP_VIDD IS 'Види угод по ЦП';
COMMENT ON COLUMN BARS.CP_VIDD.VIDD IS 'Б/Р виду угоди';
COMMENT ON COLUMN BARS.CP_VIDD.TIPD IS 'Тип угоди (розмiщення/залучення)';
COMMENT ON COLUMN BARS.CP_VIDD.NAME IS 'Назва виду угоди';
COMMENT ON COLUMN BARS.CP_VIDD.PF IS 'Код портфеля';
COMMENT ON COLUMN BARS.CP_VIDD.DOX IS 'Код доходностi';
COMMENT ON COLUMN BARS.CP_VIDD.EMI IS 'Код типу емiтента';
COMMENT ON COLUMN BARS.CP_VIDD.S605 IS '';
COMMENT ON COLUMN BARS.CP_VIDD.S605P IS '';




PROMPT *** Create  constraint XPK_CP_VIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_VIDD ADD CONSTRAINT XPK_CP_VIDD PRIMARY KEY (VIDD, EMI, PF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008366 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_VIDD MODIFY (VIDD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_VIDD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_VIDD ON BARS.CP_VIDD (VIDD, EMI, PF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_VIDD ***
grant SELECT                                                                 on CP_VIDD         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_VIDD         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_VIDD         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_VIDD         to CP_ROLE;
grant SELECT                                                                 on CP_VIDD         to UPLD;
grant FLASHBACK,SELECT                                                       on CP_VIDD         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_VIDD.sql =========*** End *** =====
PROMPT ===================================================================================== 
