

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MB_PLAN.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MB_PLAN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MB_PLAN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MB_PLAN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MB_PLAN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MB_PLAN ***
begin 
  execute immediate '
  CREATE TABLE BARS.MB_PLAN 
   (	ID NUMBER(*,0), 
	TIPD NUMBER(*,0), 
	KV NUMBER(*,0), 
	DAT DATE, 
	S NUMBER(28,0), 
	ND_ID VARCHAR2(20), 
	COMM VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MB_PLAN ***
 exec bpa.alter_policies('MB_PLAN');


COMMENT ON TABLE BARS.MB_PLAN IS 'План.платежи банка (вне модулей)';
COMMENT ON COLUMN BARS.MB_PLAN.ID IS '№ пп';
COMMENT ON COLUMN BARS.MB_PLAN.TIPD IS 'Разм(1), Привл=2';
COMMENT ON COLUMN BARS.MB_PLAN.KV IS 'Вал';
COMMENT ON COLUMN BARS.MB_PLAN.DAT IS 'План-дата';
COMMENT ON COLUMN BARS.MB_PLAN.S IS 'План-сумма (коп.)';
COMMENT ON COLUMN BARS.MB_PLAN.ND_ID IS 'Ид.дог';
COMMENT ON COLUMN BARS.MB_PLAN.COMM IS 'Комментарий';



PROMPT *** Create  grants  MB_PLAN ***
grant FLASHBACK,SELECT                                                       on MB_PLAN         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MB_PLAN         to BARS_DM;
grant SELECT                                                                 on MB_PLAN         to SALGL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MB_PLAN         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on MB_PLAN         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MB_PLAN.sql =========*** End *** =====
PROMPT ===================================================================================== 
