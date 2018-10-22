var DataChanged = false;


var obj_Parameters = new Array();

obj_Parameters['EditType'] = ''; 	// Reg, ReReg, View - для чего открыто приложение
obj_Parameters['ReadOnly'] = '';        // Правка разрешена\запрещена
obj_Parameters['ReadOnlyMode'] = '';        // Правка разрешена\запрещена
obj_Parameters['BANKDATE'] = '';        // Банковская дата
obj_Parameters['Par_EN'] = '';          // Обязательное заполнение эк. нормативов
obj_Parameters['CUSTTYPE'] = '';        // Тип клиента (person,corp,bank)

// Осн. рквизиты
obj_Parameters['DATE_ON'] = ''; 		// Дата регистрации
obj_Parameters['DATE_OFF'] = ''; 	// Дата закрытия
obj_Parameters['ID'] = ''; 			// Идентификатор
obj_Parameters['ND'] = ''; 			// Номер договора
obj_Parameters['NMK'] = ''; 			// Наименование или ФИО
obj_Parameters['NMKV'] = ''; 		// Наименование (межд.)
obj_Parameters['NMKK'] = ''; 		// Наименование (краткое)
obj_Parameters['ADR'] = ''; 			// Адрес клиента
obj_Parameters['fullADR'] = ''; 		// Полный адрес клиента
obj_Parameters['fullADRMORE'] = ''; 	// Дополнительные адреса (для юр лиц)
obj_Parameters['CODCAGENT'] = ''; 	// Характеристика клиента (К010)
obj_Parameters['COUNTRY'] = ''; 		// Цифровой код страны
obj_Parameters['PRINSIDER'] = ''; 	// Признак инсайдера (К060)
obj_Parameters['TGR'] = ''; 			// Тип гос. реестра
obj_Parameters['STMT'] = ''; 		// Вид выписки
obj_Parameters['OKPO'] = ''; 		// Идентификационный код
obj_Parameters['SAB'] = ''; 			// Эликтронный код клиента
obj_Parameters['BC'] = ''; 			// Признак не является клиентом банка (1)
obj_Parameters['TOBO'] = ''; 		// ТОБО отделения
obj_Parameters['PINCODE'] = ''; 		// Неизвесное поле(неисп.)


// Рекв. налогопл.
obj_Parameters['RNlPres'] = ''; 	// Рекв. налогопл. заполнены\не заполнены
obj_Parameters['C_REG'] = ''; 		// Областная НИ
obj_Parameters['C_DST'] = ''; 		// Районная НИ
obj_Parameters['ADM'] = ''; 		// Адм. орган регистрации
obj_Parameters['TAXF'] = ''; 		// Налоговый код (К050)
obj_Parameters['RGADM'] = ''; 		// Рег. номер в Адм.
obj_Parameters['RGTAX'] = ''; 		// Рег. номер в НИ
obj_Parameters['DATET'] = ''; 		// Дата рег. в НИ
obj_Parameters['DATEA'] = ''; 		// Дата рег. в Адм.

// Экономические нормативы
obj_Parameters['NEkPres'] = ''; 	// Экономические нормативы заполнены\не заполнены
obj_Parameters['ISE'] = ''; 		// Инст. сек. экономики (К070)
obj_Parameters['FS'] = ''; 			// Форма собственности (К080)
obj_Parameters['VED'] = ''; 		// Вид эк. деятельности (К110)
obj_Parameters['OE'] = ''; 			// Отрасль экономики (К090)
obj_Parameters['K050'] = ''; 		// Форма хозяйствования (К050)
obj_Parameters['SED'] = ''; 		// Форма хозяйствования (К051)

// Реквизиты клиента
// -----(банк)-----
obj_Parameters['MFO'] = ''; 		// Код банка - МФО
obj_Parameters['ALT_BIC'] = ''; 		// Альтернативный 
obj_Parameters['BIC'] = ''; 		// ВІС
obj_Parameters['RATING'] = ''; 		// Рейтинг банка
obj_Parameters['KOD_B'] = ''; 		// Для 1ПБ
obj_Parameters['DAT_ND'] = ''; 		// Неизвесная дата
obj_Parameters['NUM_ND'] = ''; 		// Номер ген. соглашения (неисп.)  
obj_Parameters['K190'] = '';        // Рейтинг надійності K190 (для 26Х)
// --(банк/юр.лицо)--
obj_Parameters['RUK'] = ''; 		// Руководитель
obj_Parameters['BUH'] = ''; 		// Гл. бухгалтер банка
obj_Parameters['TELR'] = ''; 		// Телефон руководителя
obj_Parameters['TELB'] = ''; 		// Телефон гл. бухгалтера
// -----(юр.лицо)-----
obj_Parameters['NMKU'] = ''; 		// Наименование по уставу
obj_Parameters['fullACCS'] = ''; 	// Счета контрагента Юр.Лица
obj_Parameters['E_MAIL'] = ''; 		// E_MAIL
obj_Parameters['TEL_FAX'] = ''; 		// Факс
obj_Parameters['SEAL_ID'] = ''; 		// Ид. графического образа печати
obj_Parameters['DOV'] = ''; 			// |
obj_Parameters['BDOV'] = ''; 		// |Неизвесные поля(неисп.)
obj_Parameters['EDOV'] = ''; 		// |
// -----(физ.лицо)-----
obj_Parameters['RCFlPres'] = ''; 	// Реквизиты клиента физ.лицо заполнены\не заполнены
obj_Parameters['PASSP'] = ''; 		// Вид документа
obj_Parameters['SER'] = ''; 		// Серия
obj_Parameters['NUMDOC'] = ''; 		// Номер док.
obj_Parameters['ORGAN'] = ''; 		// Кем выдан
obj_Parameters['PDATE'] = ''; 		// Когда выдан
obj_Parameters['BDAY'] = ''; 		// Дата рождения
obj_Parameters['BPLACE'] = ''; 		// Место рождения
obj_Parameters['SEX'] = ''; 		// Пол
obj_Parameters['TELD'] = ''; 		// Телефон 1
obj_Parameters['TELW'] = ''; 		// Телефон 2
//obj_Parameters['DOV'] = ''; 		// |
//obj_Parameters['BDOV'] = ''; 		// |Неизвесные поля(неисп.)
//obj_Parameters['EDOV'] = ''; 		// |

// Доп информация
obj_Parameters['ISP'] = ''; 		// Менеджер клиента (ответ. исполнитель)
obj_Parameters['NOTES'] = ''; 	// Примечание
obj_Parameters['CRISK'] = ''; 	// Класс заемщика
obj_Parameters['MB'] = ''; 		// Принадлежность малому бизнесу
obj_Parameters['ADR_ALT'] = ''; 	// Альтнрнативный адрес
obj_Parameters['NOM_DOG'] = ''; 	// № дог. за сопровождение
obj_Parameters['LIM_KASS'] = ''; // Лимит кассы
obj_Parameters['LIM'] = ''; 		// Лимит на активніе операции
obj_Parameters['NOMPDV'] = ''; 	// № в реестре плательщиков ПДВ
obj_Parameters['RNKP'] = ''; 	// регистрационный № холдинга
obj_Parameters['NOTESEC'] = ''; 	// Примечание для службы безопасности
obj_Parameters['TrustEE'] = ''; 	// таблица довереных лиц
obj_Parameters['NRezidCode'] = ''; 	// Код в країні реєстрації для нерезидентів

// Доп реквизиты
obj_Parameters['DopRekv'] = ''; 		// таблица доп реквизитов
obj_Parameters['DopRekv_SN_LN'] = ''; 	//таблиця CUSTOMERW параметр SN_LN
obj_Parameters['DopRekv_SN_FN'] = ''; 	//таблиця CUSTOMERW параметр SN_FN
obj_Parameters['DopRekv_SN_MN'] = ''; 	//таблиця CUSTOMERW параметр SN_MN
obj_Parameters['DopRekv_SN_4N'] = '';   //таблиця CUSTOMERW параметр SN_4N 
obj_Parameters['DopRekv_NDBO'] = '';   //таблиця CUSTOMERW параметр номер ДБО
obj_Parameters['DopRekv_SDBO'] = '';   //таблиця CUSTOMERW параметр ознака підпису ДБО

obj_Parameters['DopRekv_MPNO'] = '';   //таблиця CUSTOMERW параметр MPNO 
//доп реквизиты необходимые для заполнения
obj_Parameters['reqFields'] = new Array();




function SetParameters(p_EditType,
						p_ReadOnly,
                        p_ReadOnlyMode,
						p_BANKDATE,
						p_Par_EN,
						p_CUSTTYPE,
						p_DATE_ON,
						p_DATE_OFF,
						p_ID,
						p_ND,
						p_NMK,
						p_NMKV,
						p_NMKK,
						p_ADR,
						p_fullADR,
						p_fullADRMORE,
						p_CODCAGENT,
						p_COUNTRY,
						p_PRINSIDER,
						p_TGR,
						p_STMT,
						p_OKPO,
						p_SAB,
						p_BC,
						p_TOBO,
						p_PINCODE,
						p_RNlPres,
						p_C_REG,
						p_C_DST,
						p_ADM,
						p_TAXF,
						p_RGADM,
						p_RGTAX,
						p_DATET,
						p_DATEA,
						p_NEkPres,
						p_PINCODE,
						p_RNlPres,
						p_ISE,
						p_FS,
						p_VED,
						p_OE,
						p_K050,
						p_SED,
						p_MFO,
						p_ALT_BIC,
						p_BIC,
						p_RATING,
						p_KOD_B,
						p_DAT_ND,
                        p_NUM_ND,
                        p_K190,
						p_RUK,
						p_BUH,
						p_TELR,
						p_TELB,
						p_NMKU,
						p_fullACCS,
						p_TEL_FAX,
						p_E_MAIL,
						p_SEAL_ID,
						p_RCFlPres,
						p_PASSP,
						p_SER,
						p_NUMDOC,
						p_ORGAN,
						p_PDATE,
						p_BDAY,
						p_BPLACE,
						p_SEX,
						p_TELD,
						p_TELW,
						//p_DOV,
						//p_BDOV,
						//p_EDOV,
						p_ISP,
						p_NOTES,
						p_CRISK,
						p_MB,
						p_ADR_ALT,
						p_NOM_DOG,
						p_LIM_KASS,
						p_LIM,
						p_NOMPDV,
						p_RNKP,
						p_NOTESEC,
						p_TrustEE,
                        nRezidCode,
						p_DopRekv,
                        p_DopRekv_SN_LN,
                        p_DopRekv_SN_FN,
                        p_DopRekv_SN_MN,
                        p_DopRekv_SN_4N,
                        p_DopRekv_NDBO,
                        p_DopRekv_SDBO,
                        p_DopRekv_MPNO) {
    obj_Parameters['EditType'] = p_EditType;
    obj_Parameters['ReadOnly'] = p_ReadOnly;
    obj_Parameters['ReadOnlyMode'] = p_ReadOnlyMode;
    obj_Parameters['BANKDATE'] = p_BANKDATE;
    obj_Parameters['Par_EN'] = p_Par_EN;
    obj_Parameters['CUSTTYPE'] = p_CUSTTYPE;
    obj_Parameters['DATE_ON'] = p_DATE_ON;
    obj_Parameters['DATE_OFF'] = p_DATE_OFF;
    obj_Parameters['ID'] = p_ID;
    obj_Parameters['ND'] = p_ND;
    obj_Parameters['NMK'] = p_NMK;
    obj_Parameters['NMKV'] = p_NMKV;
    obj_Parameters['NMKK'] = p_NMKK;
    obj_Parameters['ADR'] = p_ADR;
    obj_Parameters['fullADR'] = eval('(' + decodeURIComponent(p_fullADR) + ');');
    obj_Parameters['fullADRMORE'] = p_fullADRMORE;
    obj_Parameters['CODCAGENT'] = p_CODCAGENT;
    obj_Parameters['COUNTRY'] = p_COUNTRY;
    obj_Parameters['PRINSIDER'] = p_PRINSIDER;
    obj_Parameters['TGR'] = p_TGR;
    obj_Parameters['STMT'] = p_STMT;
    obj_Parameters['OKPO'] = p_OKPO;
    obj_Parameters['SAB'] = p_SAB;
    obj_Parameters['BC'] = p_BC;
    obj_Parameters['TOBO'] = p_TOBO;
    obj_Parameters['PINCODE'] = p_PINCODE;
    obj_Parameters['RNlPres'] = p_RNlPres;
    obj_Parameters['C_REG'] = p_C_REG;
    obj_Parameters['C_DST'] = p_C_DST;
    obj_Parameters['ADM'] = p_ADM;
    obj_Parameters['TAXF'] = p_TAXF;
    obj_Parameters['RGADM'] = p_RGADM;
    obj_Parameters['RGTAX'] = p_RGTAX;
    obj_Parameters['DATET'] = p_DATET;
    obj_Parameters['DATEA'] = p_DATEA;
    obj_Parameters['NEkPres'] = p_NEkPres;
    obj_Parameters['ISE'] = p_ISE;
    obj_Parameters['FS'] = p_FS;
    obj_Parameters['VED'] = p_VED;
    obj_Parameters['OE'] = p_OE;
    obj_Parameters['K050'] = p_K050;
    obj_Parameters['SED'] = p_SED;
    obj_Parameters['MFO'] = p_MFO;
    obj_Parameters['ALT_BIC'] = p_ALT_BIC;
    obj_Parameters['BIC'] = p_BIC;
    obj_Parameters['RATING'] = p_RATING;
    obj_Parameters['KOD_B'] = p_KOD_B;
    obj_Parameters['DAT_ND'] = p_DAT_ND;
    obj_Parameters['NUM_ND'] = p_NUM_ND;
    obj_Parameters['RUK'] = p_RUK;
    obj_Parameters['BUH'] = p_BUH;
    obj_Parameters['TELR'] = p_TELR;
    obj_Parameters['TELB'] = p_TELB;
    obj_Parameters['NMKU'] = p_NMKU;
    obj_Parameters['fullACCS'] = p_fullACCS;
    obj_Parameters['TEL_FAX'] = p_TEL_FAX,
	obj_Parameters['E_MAIL'] = p_E_MAIL,
	obj_Parameters['SEAL_ID'] = p_SEAL_ID,
	obj_Parameters['RCFlPres'] = p_RCFlPres;
    obj_Parameters['PASSP'] = p_PASSP;
    obj_Parameters['SER'] = p_SER;
    obj_Parameters['NUMDOC'] = p_NUMDOC;
    obj_Parameters['ORGAN'] = p_ORGAN;
    obj_Parameters['PDATE'] = p_PDATE;
    obj_Parameters['BDAY'] = p_BDAY;
    obj_Parameters['BPLACE'] = p_BPLACE;
    obj_Parameters['SEX'] = p_SEX;
    obj_Parameters['TELD'] = p_TELD;
    obj_Parameters['TELW'] = p_TELW;
    //obj_Parameters['DOV'] = p_DOV;
    //obj_Parameters['BDOV'] = p_BDOV;
    //obj_Parameters['EDOV'] = p_EDOV;
    obj_Parameters['ISP'] = p_ISP;
    obj_Parameters['NOTES'] = p_NOTES;
    obj_Parameters['CRISK'] = p_CRISK;
    obj_Parameters['MB'] = p_MB;
    obj_Parameters['ADR_ALT'] = p_ADR_ALT;
    obj_Parameters['NOM_DOG'] = p_NOM_DOG;
    obj_Parameters['LIM_KASS'] = p_LIM_KASS;
    obj_Parameters['LIM'] = p_LIM;
    obj_Parameters['NOMPDV'] = p_NOMPDV;
    obj_Parameters['RNKP'] = p_RNKP;
    obj_Parameters['NOTESEC'] = p_NOTESEC;
    obj_Parameters['TrustEE'] = p_TrustEE;
    obj_Parameters['NRezidCode'] = nRezidCode;
    obj_Parameters['DopRekv'] = p_DopRekv;
    obj_Parameters['DopRekv_SN_LN'] = p_DopRekv_SN_LN;
    obj_Parameters['DopRekv_SN_FN'] = p_DopRekv_SN_FN;
    obj_Parameters['DopRekv_SN_MN'] = p_DopRekv_SN_MN;
    obj_Parameters['DopRekv_SN_4N'] = p_DopRekv_SN_4N;
    obj_Parameters['DopRekv_NDBO'] = p_DopRekv_NDBO;
    obj_Parameters['DopRekv_SDBO'] = p_DopRekv_SDBO;
    obj_Parameters['DopRekv_MPNO'] = p_DopRekv_MPNO;  
    obj_Parameters['K190'] = p_K190;  
}