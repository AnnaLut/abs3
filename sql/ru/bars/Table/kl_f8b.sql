

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_F8B.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_F8B ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_F8B'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F8B'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_F8B ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_F8B 
   (	DATF DATE, 
	RNK NUMBER, 
	OKPO VARCHAR2(14), 
	NMK VARCHAR2(70), 
	NNNN VARCHAR2(4), 
	LINK_GROUP NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_F8B ***
 exec bpa.alter_policies('KL_F8B');


COMMENT ON TABLE BARS.KL_F8B IS 'Коди ЄДРПОУ контрагентыв для файлу звiтностi #8B (ОБ) ';
COMMENT ON COLUMN BARS.KL_F8B.DATF IS 'Дата включення в файл';
COMMENT ON COLUMN BARS.KL_F8B.RNK IS 'РНК контрагента';
COMMENT ON COLUMN BARS.KL_F8B.OKPO IS 'ОКПО контрагента';
COMMENT ON COLUMN BARS.KL_F8B.NMK IS 'Назва контрагента';
COMMENT ON COLUMN BARS.KL_F8B.NNNN IS 'Умовний номер в файлі (NNNN)';
COMMENT ON COLUMN BARS.KL_F8B.LINK_GROUP IS 'Код групи контрагентів';




PROMPT *** Create  constraint SYS_C00119250 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F8B MODIFY (DATF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_F8B ***
grant SELECT                                                                 on KL_F8B          to RPBN002;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on KL_F8B          to START1;
grant FLASHBACK,SELECT                                                       on KL_F8B          to WR_REFREAD;



PROMPT *** Create SYNONYM  to KL_F8B ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_F8B FOR BARS.KL_F8B;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_F8B.sql =========*** End *** ======
PROMPT ===================================================================================== 
