

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PAWN_TIP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PAWN_TIP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PAWN_TIP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PAWN_TIP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PAWN_TIP ***
begin 
  execute immediate '
  CREATE TABLE BARS.PAWN_TIP 
   (	PAWN NUMBER(*,0), 
	TIP NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PAWN_TIP ***
 exec bpa.alter_policies('PAWN_TIP');


COMMENT ON TABLE BARS.PAWN_TIP IS 'Групы залгов';
COMMENT ON COLUMN BARS.PAWN_TIP.PAWN IS 'Вид залога';
COMMENT ON COLUMN BARS.PAWN_TIP.TIP IS 'Тип(группа) залога';



PROMPT *** Create  grants  PAWN_TIP ***
grant SELECT                                                                 on PAWN_TIP        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PAWN_TIP        to RCC_DEAL;
grant SELECT                                                                 on PAWN_TIP        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PAWN_TIP.sql =========*** End *** ====
PROMPT ===================================================================================== 
