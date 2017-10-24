

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_PL_INS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_PL_INS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_PL_INS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CCK_PL_INS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CCK_PL_INS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_PL_INS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_PL_INS 
   (	ND NUMBER, 
	MFOB VARCHAR2(6), 
	NLSB VARCHAR2(15), 
	NAM_B VARCHAR2(38), 
	ID_B VARCHAR2(14), 
	NAZN VARCHAR2(160), 
	S NUMBER, 
	REF NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_PL_INS ***
 exec bpa.alter_policies('CCK_PL_INS');


COMMENT ON TABLE BARS.CCK_PL_INS IS 'Перелік пл.інструкцій по видачі кредиту';
COMMENT ON COLUMN BARS.CCK_PL_INS.ND IS 'Реф. КД';
COMMENT ON COLUMN BARS.CCK_PL_INS.MFOB IS 'МФО банку отримувача';
COMMENT ON COLUMN BARS.CCK_PL_INS.NLSB IS 'Рах.отримувача';
COMMENT ON COLUMN BARS.CCK_PL_INS.NAM_B IS 'Назва отримувача';
COMMENT ON COLUMN BARS.CCK_PL_INS.ID_B IS 'Ід.код отримувача';
COMMENT ON COLUMN BARS.CCK_PL_INS.NAZN IS '';
COMMENT ON COLUMN BARS.CCK_PL_INS.S IS '';
COMMENT ON COLUMN BARS.CCK_PL_INS.REF IS 'Реф.проводки на отримувача';



PROMPT *** Create  grants  CCK_PL_INS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_PL_INS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_PL_INS      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_PL_INS      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_PL_INS.sql =========*** End *** ==
PROMPT ===================================================================================== 
