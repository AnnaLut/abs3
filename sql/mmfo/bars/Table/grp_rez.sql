

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRP_REZ.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRP_REZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRP_REZ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GRP_REZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GRP_REZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRP_REZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRP_REZ 
   (	GRP NUMBER(*,0), 
	NAME VARCHAR2(100), 
	NAME_SHORT VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRP_REZ ***
 exec bpa.alter_policies('GRP_REZ');


COMMENT ON TABLE BARS.GRP_REZ IS 'Довідник груп резерву';
COMMENT ON COLUMN BARS.GRP_REZ.GRP IS 'Группа';
COMMENT ON COLUMN BARS.GRP_REZ.NAME IS 'Назва';
COMMENT ON COLUMN BARS.GRP_REZ.NAME_SHORT IS 'Коротка назва';



PROMPT *** Create  grants  GRP_REZ ***
grant DELETE,INSERT,SELECT,UPDATE                                            on GRP_REZ         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GRP_REZ         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on GRP_REZ         to RCC_DEAL;
grant SELECT                                                                 on GRP_REZ         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRP_REZ.sql =========*** End *** =====
PROMPT ===================================================================================== 
