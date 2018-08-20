

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/pfu_epp_line_bnk_state2.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table pfu_epp_line_bnk_state2 ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_EPP_LINE_BNK_STATE2 
   (EPP_LINE_ID      NUMBER(10,0),
    BATCH_REQUEST_ID NUMBER(10,0),
    STATE_ID         NUMBER(5,0), 
    TYPE_CARD        VARCHAR2(4000),
    EPP_EXPIRY_DATE  DATE,
    PFU_RESULT       NUMBER(1,0),
    RES_TAG          VARCHAR2(4000),
    CREATE_DATE      DATE default trunc(sysdate),
    COMM             VARCHAR2(4000),
    STAGE_TICKET     NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** Add comments to the table PFU.pfu_epp_line_bnk_state2 ***
COMMENT ON TABLE PFU.pfu_epp_line_bnk_state2 IS 'Рядки файлу ПЕНСІОНЕРІВ для квитанції 2 (PUT_EPP_PACKET_BNK_STATE_2)';

PROMPT *** Add comments to the columns of table PFU.pfu_epp_line_bnk_state2 *** 
COMMENT ON COLUMN PFU.pfu_epp_line_bnk_state2.EPP_LINE_ID IS '';
COMMENT ON COLUMN PFU.pfu_epp_line_bnk_state2.BATCH_REQUEST_ID IS '';
COMMENT ON COLUMN PFU.pfu_epp_line_bnk_state2.STATE_ID IS 'Стан';
COMMENT ON COLUMN PFU.pfu_epp_line_bnk_state2.TYPE_CARD IS 'Тип карти';
COMMENT ON COLUMN PFU.pfu_epp_line_bnk_state2.EPP_EXPIRY_DATE IS 'Термін дії картки';
COMMENT ON COLUMN PFU.pfu_epp_line_bnk_state2.PFU_RESULT IS 'Результат опрацювання кожного запису файлу';
COMMENT ON COLUMN PFU.pfu_epp_line_bnk_state2.RES_TAG IS 'Назва тегів в файлі для відкриття рахунків';
COMMENT ON COLUMN PFU.pfu_epp_line_bnk_state2.CREATE_DATE IS 'Дата створення рядка (дата початку опрацювання)';
COMMENT ON COLUMN PFU.pfu_epp_line_bnk_state2.COMM IS 'Коментар';
COMMENT ON COLUMN PFU.pfu_epp_line_bnk_state2.STAGE_TICKET IS '1 - очікує формування pfu_result для квитанції 2, 2 - очікує формування файлу квитанції 2, null - обробки не потребує';



begin
    execute immediate 'create index I_EPP_LN_BNK_ST2_STAGE_TICKET on PFU.PFU_EPP_LINE_BNK_STATE2 (STAGE_TICKET)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/


PROMPT *** Create column PFU.PFU_EPP_LINE_BNK_STATE2.ERROR_STACK ***
begin 
  execute immediate 'ALTER TABLE PFU.PFU_EPP_LINE_BNK_STATE2 ADD ERROR_STACK VARCHAR2(4000)';
exception when others then 
  if sqlcode in (-904, -6512, -1430) then 
    null; 
  else 
    raise; 
  end if;
end;
/
PROMPT *** Add comments to the column PFU.PFU_EPP_LINE_BNK_STATE2.ERROR_STACK *** 
COMMENT ON COLUMN PFU.PFU_EPP_LINE_BNK_STATE2.ERROR_STACK IS 'Траса помилки, або назва тега який буде передаватись в пфу';


PROMPT *** Create column PFU.PFU_EPP_LINE_BNK_STATE2.EPP_NUMBER ***
begin 
  execute immediate 'ALTER TABLE PFU.PFU_EPP_LINE_BNK_STATE2 ADD EPP_NUMBER VARCHAR2(4000)';
exception when others then 
  if sqlcode in (-904, -6512, -1430) then 
    null; 
  else 
    raise; 
  end if;
end;
/
PROMPT *** Add comments to the column PFU.PFU_EPP_LINE_BNK_STATE2.EPP_NUMBER *** 
COMMENT ON COLUMN PFU.PFU_EPP_LINE_BNK_STATE2.EPP_NUMBER IS 'Номер пенсійного посвідчення';

PROMPT *** Create column PFU.PFU_EPP_LINE_BNK_STATE2.RN ***
begin 
  execute immediate 'ALTER TABLE PFU.PFU_EPP_LINE_BNK_STATE2 ADD RN NUMBER(10,0)';
exception when others then 
  if sqlcode in (-904, -6512, -1430) then 
    null; 
  else 
    raise; 
  end if;
end;
/
PROMPT *** Add comments to the column PFU.PFU_EPP_LINE_BNK_STATE2.RN *** 
COMMENT ON COLUMN PFU.PFU_EPP_LINE_BNK_STATE2.RN IS 'PFU_EPP_LINE.LINE_ID';


PROMPT *** Create column PFU.PFU_EPP_LINE_BNK_STATE2.PS_TYPE ***
begin 
  execute immediate 'ALTER TABLE PFU.PFU_EPP_LINE_BNK_STATE2 ADD PS_TYPE VARCHAR2(1 CHAR)';
exception when others then 
  if sqlcode in (-904, -6512, -1430) then 
    null; 
  else 
    raise; 
  end if;
end;
/
PROMPT *** Add comments to the column PFU.PFU_EPP_LINE_BNK_STATE2.PS_TYPE *** 
COMMENT ON COLUMN PFU.PFU_EPP_LINE_BNK_STATE2.PS_TYPE IS 'Назва платіжної системи. Поле обов. При result = 0 ("0" простір, "1" MasterCard)';


PROMPT *** Create  grants  pfu_epp_line_bnk_state2 ***
grant SELECT                                                                 on pfu_epp_line_bnk_state2    to BARSREADER_ROLE;
grant SELECT                                                                 on pfu_epp_line_bnk_state2    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/pfu_epp_line_bnk_state2.sql =========*** End *** =
PROMPT ===================================================================================== 
