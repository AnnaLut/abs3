BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_ON_DATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ON_DATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ON_DATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_ON_DATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_ON_DATE 
   (	USER_ID  NUMBER DEFAULT sys_context(''bars_global'', ''user_id''),
        ID 	 NUMBER,        --5 № ЦП в системi
        CP_ID    VARCHAR2(20),  --6 Код ЦП
	RYN      NUMBER, 
        RYN_NAME VARCHAR2(35),  --10 Суб.портфель
	REF      NUMBER,        --4 Реф угоди купiвлi 
	ERAT     NUMBER,        --22 Ефект. ставка %
        DOX      NUMBER,
        EMI      NUMBER,
        KV       NUMBER,         --7 Вал 
        MDATE    DATE,           --11 Дата погашення 
        OSTA     NUMBER,         --14 Сума Номiналу
        PF       NUMBER,
        PF_NAME  VARCHAR2(70),   --9 Портфель
        DATD     DATE,           --1 Дата угоди купiвлі
        ND       VARCHAR2(32),   --2 № угоди купiвлi
        RNK      NUMBER,
        SUMB     NUMBER,         --3 Сума угоди купiвлi 
        VIDD     NUMBER,         --8 Вид угод (Бал.Рах.)
        IR       NUMBER,         --12 Номінальна %ст. річна 
        MO_PR    NUMBER,         --13 Ном.% ст.місячна
        OSTD     NUMBER,         --15 Сума дисконту
        OSTP     NUMBER,         --16 Сума премії
        OSTR     NUMBER,         --17 Сума нарах %
        OSTR2    NUMBER,         --18 Сума куплених %
        OSTS     NUMBER,         --19 Сума переоц.
        OSTAB    NUMBER,         --20 Сума ном N-план
        OSTAF    NUMBER,         --21 Сума ном N-буд
        P_DATE   DATE            --23 На дату
   ) TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** ALTER_POLICIES to CP_ON_DATE ***
 exec bpa.alter_policies('CP_ON_DATE');


COMMENT ON TABLE BARS.CP_ON_DATE IS 'Таблиця для звіту ЦП Портфель на дату';


PROMPT *** Create  index IDX1_CPONDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX1_CPONDATE ON BARS.CP_ON_DATE (USER_ID, ID) 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  CP_ON_DATE ***
grant SELECT                                            on CP_ON_DATE         to BARS_ACCESS_DEFROLE;








