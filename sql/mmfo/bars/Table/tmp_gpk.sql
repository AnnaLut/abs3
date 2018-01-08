

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_GPK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_GPK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_GPK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_GPK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_GPK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_GPK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_GPK 
   (	FDAT DATE, 
	LIM2 NUMBER(38,0), 
	SUMG NUMBER(38,0), 
	SUMO NUMBER(38,0), 
	SUMK NUMBER, 
	SV0K1 NUMBER, 
	SV1RK NUMBER, 
	SV1MM NUMBER, 
	SV2PW NUMBER, 
	SV3CV NUMBER, 
	SV4TI NUMBER, 
	SV5GO NUMBER, 
	SV6NO NUMBER, 
	SV7RE NUMBER, 
	SV8MI NUMBER, 
	SV9PF NUMBER, 
	SVBT NUMBER, 
	IRR_KL NUMBER, 
	IRR_BANK NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_GPK ***
 exec bpa.alter_policies('TMP_GPK');


COMMENT ON TABLE BARS.TMP_GPK IS '';
COMMENT ON COLUMN BARS.TMP_GPK.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_GPK.LIM2 IS '';
COMMENT ON COLUMN BARS.TMP_GPK.SUMG IS '';
COMMENT ON COLUMN BARS.TMP_GPK.SUMO IS '';
COMMENT ON COLUMN BARS.TMP_GPK.SUMK IS '';
COMMENT ON COLUMN BARS.TMP_GPK.SV0K1 IS 'Разова комiсiя, %   ';
COMMENT ON COLUMN BARS.TMP_GPK.SV1RK IS 'Розр-Кас.Обсл., %';
COMMENT ON COLUMN BARS.TMP_GPK.SV1MM IS 'щомісячна комісія%';
COMMENT ON COLUMN BARS.TMP_GPK.SV2PW IS 'трах.застави, щорiчно, %';
COMMENT ON COLUMN BARS.TMP_GPK.SV3CV IS 'Страх.життя, щорiчно, %';
COMMENT ON COLUMN BARS.TMP_GPK.SV4TI IS 'Страх.титулу, щорiчно(3 р), %';
COMMENT ON COLUMN BARS.TMP_GPK.SV5GO IS 'Страх.цив.вiдпов, грн';
COMMENT ON COLUMN BARS.TMP_GPK.SV6NO IS 'Послуги нотарiуса, грн';
COMMENT ON COLUMN BARS.TMP_GPK.SV7RE IS 'Послуги реєстрат., грн';
COMMENT ON COLUMN BARS.TMP_GPK.SV8MI IS 'Державне мито, % вiд застави';
COMMENT ON COLUMN BARS.TMP_GPK.SV9PF IS 'Пенсiйн.фонд, % вiд застави';
COMMENT ON COLUMN BARS.TMP_GPK.SVBT IS 'Послуги БТI(МРЕО), грн';
COMMENT ON COLUMN BARS.TMP_GPK.IRR_KL IS 'Эф ставка клиента';
COMMENT ON COLUMN BARS.TMP_GPK.IRR_BANK IS 'Эф ставка банка';



PROMPT *** Create  grants  TMP_GPK ***
grant SELECT                                                                 on TMP_GPK         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_GPK         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_GPK         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_GPK         to RCC_DEAL;
grant SELECT                                                                 on TMP_GPK         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_GPK         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_GPK ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_GPK FOR BARS.TMP_GPK;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_GPK.sql =========*** End *** =====
PROMPT ===================================================================================== 
