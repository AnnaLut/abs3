

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MONEXR.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MONEXR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MONEXR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MONEXR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MONEXR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MONEXR ***
begin 
  execute immediate '
  CREATE TABLE BARS.MONEXR 
   (	FDAT DATE, 
	OB22 CHAR(2), 
	BRANCH CHAR(22), 
	KV NUMBER(*,0), 
	S_2909 NUMBER(38,0), 
	K_2909 NUMBER(38,0), 
	S_2809 NUMBER(38,0), 
	K_2809 NUMBER(38,0), 
	S_0000 NUMBER(38,0), 
	K_0000 NUMBER(38,0), 
	FL NUMBER(*,0), 
	RS_2909 NUMBER(38,0), 
	RK_2909 NUMBER(38,0), 
	RS_2809 NUMBER(38,0), 
	RK_2809 NUMBER(38,0), 
	RS_0000 NUMBER(38,0), 
	RK_0000 NUMBER(38,0), 
	KOD_NBU VARCHAR2(5), 
	FM NUMBER(*,0), 
	KOMB1 NUMBER, 
	KOMB2 NUMBER, 
	KOMB3 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MONEXR ***
 exec bpa.alter_policies('MONEXR');


COMMENT ON TABLE BARS.MONEXR IS '';
COMMENT ON COLUMN BARS.MONEXR.KOMB1 IS 'комиссия оператора';
COMMENT ON COLUMN BARS.MONEXR.KOMB2 IS 'комиссия субагента';
COMMENT ON COLUMN BARS.MONEXR.KOMB3 IS 'комиссия субагента за анулирование';
COMMENT ON COLUMN BARS.MONEXR.FDAT IS '';
COMMENT ON COLUMN BARS.MONEXR.OB22 IS '';
COMMENT ON COLUMN BARS.MONEXR.BRANCH IS '';
COMMENT ON COLUMN BARS.MONEXR.KV IS '';
COMMENT ON COLUMN BARS.MONEXR.S_2909 IS '';
COMMENT ON COLUMN BARS.MONEXR.K_2909 IS '';
COMMENT ON COLUMN BARS.MONEXR.S_2809 IS '';
COMMENT ON COLUMN BARS.MONEXR.K_2809 IS '';
COMMENT ON COLUMN BARS.MONEXR.S_0000 IS '';
COMMENT ON COLUMN BARS.MONEXR.K_0000 IS '';
COMMENT ON COLUMN BARS.MONEXR.FL IS 'Флаг обработки внутри ОБ по ВПС';
COMMENT ON COLUMN BARS.MONEXR.RS_2909 IS '';
COMMENT ON COLUMN BARS.MONEXR.RK_2909 IS '';
COMMENT ON COLUMN BARS.MONEXR.RS_2809 IS '';
COMMENT ON COLUMN BARS.MONEXR.RK_2809 IS '';
COMMENT ON COLUMN BARS.MONEXR.RS_0000 IS '';
COMMENT ON COLUMN BARS.MONEXR.RK_0000 IS '';
COMMENT ON COLUMN BARS.MONEXR.KOD_NBU IS '';
COMMENT ON COLUMN BARS.MONEXR.FM IS 'Флаг обработки на М/Б по СВИФТУ';




PROMPT *** Create  constraint XPK_MONEXR ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEXR ADD CONSTRAINT XPK_MONEXR PRIMARY KEY (FDAT, KOD_NBU, BRANCH, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_MONEXR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_MONEXR ON BARS.MONEXR (FDAT, KOD_NBU, BRANCH, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create COLUMN RET_SEND ***
begin 
   EXECUTE IMMEDIATE 'alter TABLE BARS.MONEXR add ( RET_SEND  NUMBER )';
EXCEPTION
   WHEN OTHERS
   THEN
      IF SQLCODE = -01430
      THEN
         NULL;
      ELSE
         RAISE;
      END IF;         -- ORA-01430: column being added already exists in table
END;
/

COMMENT ON COLUMN BARS.MONEXR.RET_SEND IS 'Сума комісії, яку утримує оператор для повернення клієнту';

PROMPT *** Create  grants  MONEXR ***
grant SELECT                                                                 on MONEXR          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on MONEXR          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MONEXR          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on MONEXR          to START1;
grant SELECT                                                                 on MONEXR          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MONEXR.sql =========*** End *** ======
PROMPT ===================================================================================== 
