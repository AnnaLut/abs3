

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XOZ7_CA.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XOZ7_CA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XOZ7_CA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XOZ7_CA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XOZ7_CA ***
begin 
  execute immediate '
  CREATE TABLE BARS.XOZ7_CA 
   (	REC NUMBER, 
	ACC7 NUMBER, 
	S7 NUMBER, 
	KODZ VARCHAR2(10), 
	OB40 VARCHAR2(3), 
	NAZN VARCHAR2(160)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XOZ7_CA ***
 exec bpa.alter_policies('XOZ7_CA');


COMMENT ON TABLE BARS.XOZ7_CA IS 'Розшщифровка платежу з ЦА на РУ рол деб запиту';
COMMENT ON COLUMN BARS.XOZ7_CA.REC IS 'REC деб.запиту. що надійшов з РУ';
COMMENT ON COLUMN BARS.XOZ7_CA.ACC7 IS 'Рах типу 7 кл в ЦА';
COMMENT ON COLUMN BARS.XOZ7_CA.S7 IS 'Сума. що відшкодовується з цього рах';
COMMENT ON COLUMN BARS.XOZ7_CA.KODZ IS '';
COMMENT ON COLUMN BARS.XOZ7_CA.OB40 IS '';
COMMENT ON COLUMN BARS.XOZ7_CA.NAZN IS '';



PROMPT *** Create  grants  XOZ7_CA ***
grant SELECT                                                                 on XOZ7_CA         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XOZ7_CA.sql =========*** End *** =====
PROMPT ===================================================================================== 
