

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ANI34.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ANI34 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ANI34 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ANI34 
   (  B DATE, 
  E DATE, 
  G01 VARCHAR2(9), 
  G02 NUMBER, 
  G03 VARCHAR2(15), 
  G04 NUMBER, 
  G05 VARCHAR2(70), 
  G06 DATE, 
  G07 DATE, 
  G08 DATE, 
  G08A NUMBER, 
  G08B NUMBER, 
  G09 NUMBER, 
  G10 NUMBER, 
  G11 NUMBER, 
  G12 NUMBER, 
  G13 NUMBER, 
  G14 NUMBER, 
  G15 NUMBER, 
  G16 NUMBER, 
  G17 NUMBER, 
  G18 NUMBER, 
  G19 NUMBER, 
  G20 NUMBER, 
  G21 NUMBER, 
  G22 VARCHAR2(9), 
  G23 VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** add column G23 ***
begin 
  execute immediate '
  alter table tmp_ani34 add G23 VARCHAR2(2)';
exception when others then       
  if sqlcode=-01430 then null; else raise; end if; 
end; 
/


PROMPT *** ALTER_POLICIES to TMP_ANI34 ***
 exec bpa.alter_policies('TMP_ANI34');


COMMENT ON TABLE BARS.TMP_ANI34 IS '№3. Фін.результат за період по похідним фін.інструментам';
COMMENT ON COLUMN BARS.TMP_ANI34.B IS 'Дата початку~перiоду анаiзу~Beg';
COMMENT ON COLUMN BARS.TMP_ANI34.E IS 'Дата кiнця~перiоду анаiзу~End';
COMMENT ON COLUMN BARS.TMP_ANI34.G01 IS 'Тип~угоди~01';
COMMENT ON COLUMN BARS.TMP_ANI34.G02 IS 'Вн. ~№ угоди~02';
COMMENT ON COLUMN BARS.TMP_ANI34.G03 IS '№~тикету~03';
COMMENT ON COLUMN BARS.TMP_ANI34.G04 IS 'РНК~~04';
COMMENT ON COLUMN BARS.TMP_ANI34.G05 IS 'Найменування~контрагента~05    ';
COMMENT ON COLUMN BARS.TMP_ANI34.G06 IS 'Дата~угоди~06';
COMMENT ON COLUMN BARS.TMP_ANI34.G07 IS 'Дата~валютування ~07';
COMMENT ON COLUMN BARS.TMP_ANI34.G08 IS 'Дата~повернення~08';
COMMENT ON COLUMN BARS.TMP_ANI34.G08A IS 'Вал~А~0A';
COMMENT ON COLUMN BARS.TMP_ANI34.G08B IS 'Вал~Б~0Б';
COMMENT ON COLUMN BARS.TMP_ANI34.G09 IS 'Сума Вал А~на дату валют~09';
COMMENT ON COLUMN BARS.TMP_ANI34.G10 IS 'Сума Вал Б~на дату валют~10';
COMMENT ON COLUMN BARS.TMP_ANI34.G11 IS 'Сума Вал А~на дату повер~11';
COMMENT ON COLUMN BARS.TMP_ANI34.G12 IS 'Cума Вал Б~на дату повер~12';
COMMENT ON COLUMN BARS.TMP_ANI34.G13 IS '6204~переоцінка~13';
COMMENT ON COLUMN BARS.TMP_ANI34.G14 IS '6204~нереаліз. р-т~14';
COMMENT ON COLUMN BARS.TMP_ANI34.G15 IS '6204~реаліз. р-т~15';
COMMENT ON COLUMN BARS.TMP_ANI34.G16 IS '6209~переоцінка~16';
COMMENT ON COLUMN BARS.TMP_ANI34.G17 IS '6209~нереаліз. р-т~17';
COMMENT ON COLUMN BARS.TMP_ANI34.G18 IS '6209~реаліз. р-т~18';
COMMENT ON COLUMN BARS.TMP_ANI34.G19 IS 'Усього ~нереаліз. р-т~19';
COMMENT ON COLUMN BARS.TMP_ANI34.G20 IS 'Усього ~реаліз. р-т~20';
COMMENT ON COLUMN BARS.TMP_ANI34.G21 IS 'Усього~фін. р-т ~21';
COMMENT ON COLUMN BARS.TMP_ANI34.G22 IS 'Статус~угоди~22';
COMMENT ON COLUMN BARS.TMP_ANI34.G23 IS 'Ініціатор~23';



PROMPT *** Create  grants  TMP_ANI34 ***
grant SELECT                                                                 on TMP_ANI34       to START1;
grant SELECT                                                                 on TMP_ANI34       to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_ANI34       to BARS_DM;
grant SELECT                                                                 on TMP_ANI34       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_ANI34       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ANI34.sql =========*** End *** ===
PROMPT ===================================================================================== 
