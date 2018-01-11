

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KODOBL_REG.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KODOBL_REG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KODOBL_REG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KODOBL_REG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KODOBL_REG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KODOBL_REG ***
begin 
  execute immediate '
  CREATE TABLE BARS.KODOBL_REG 
   (	KO NUMBER(*,0), 
	C_REG NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KODOBL_REG ***
 exec bpa.alter_policies('KODOBL_REG');


COMMENT ON TABLE BARS.KODOBL_REG IS 'Таблица-связка между кодами областей справочников SPR_REG и KODOBL';
COMMENT ON COLUMN BARS.KODOBL_REG.KO IS 'Поле KO в таблице KODOBL';
COMMENT ON COLUMN BARS.KODOBL_REG.C_REG IS 'Поле C_REG в таблице SPR_REG';



PROMPT *** Create  grants  KODOBL_REG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KODOBL_REG      to ABS_ADMIN;
grant SELECT                                                                 on KODOBL_REG      to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on KODOBL_REG      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KODOBL_REG      to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on KODOBL_REG      to FINMON01;
grant SELECT                                                                 on KODOBL_REG      to RPBN002;
grant SELECT                                                                 on KODOBL_REG      to START1;
grant SELECT                                                                 on KODOBL_REG      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KODOBL_REG      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KODOBL_REG.sql =========*** End *** ==
PROMPT ===================================================================================== 
