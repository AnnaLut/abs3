

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_FOND.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_FOND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_FOND'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_FOND'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KL_FOND'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_FOND ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_FOND 
   (	KOD VARCHAR2(1), 
	MIN_S NUMBER, 
	MAX_S NUMBER, 
	COMM VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_FOND ***
 exec bpa.alter_policies('KL_FOND');


COMMENT ON TABLE BARS.KL_FOND IS 'Коди границь вкладiв для Фонду гарантування';
COMMENT ON COLUMN BARS.KL_FOND.KOD IS 'Код границi';
COMMENT ON COLUMN BARS.KL_FOND.MIN_S IS 'MIN сума вкладу';
COMMENT ON COLUMN BARS.KL_FOND.MAX_S IS 'MAX сума вкладу';
COMMENT ON COLUMN BARS.KL_FOND.COMM IS 'Примiтка';



PROMPT *** Create  grants  KL_FOND ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_FOND         to ABS_ADMIN;
grant SELECT                                                                 on KL_FOND         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_FOND         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_FOND         to BARS_DM;
grant SELECT                                                                 on KL_FOND         to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_FOND         to SALGL;
grant SELECT                                                                 on KL_FOND         to START1;
grant SELECT                                                                 on KL_FOND         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_FOND         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_FOND.sql =========*** End *** =====
PROMPT ===================================================================================== 
